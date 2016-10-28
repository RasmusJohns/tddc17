(define (domain shakeys_domain)
  (:requirements [:strips] [:equality] [:typing] [:adl])
  [(:types
          location	; there are several connected locations in the
		      object
          door
          arm)]
  (:predicates
        	(connected	?l1  ?l2 - location ?d - door)		; location ?l1 is connected to location ?l2 with door ?d
          (wide ?d - door)  ;is door ?d wide

        	(occupied	?l - location)			; there is a robot at location ?l
        	(holding		?a - arm ?o - object)	; arm ?a is holding ?s small_object
          (empty  ?a - arm) ;is arm ?a empty

        	(in		?o - object ?l - location)	; object ?o is somewhere in location ?l
          (lit  ?l - location)  ; is location ?l lit
          (holdable ?o - object)  ;is object ?o holdable
          (pushable ?o - object)  ;is object ?o pushable
          (climbable ?o - object)  ;is object ?o climbable

           )
  (:action move_between_rooms
         		:parameters (?from ?to - location  ?d - door)

         		:precondition (and (connected ?from ?to ?d)
         				               (occupied ?from)
         				               (not (occupied ?to))
                          )

         		:effect (and (occupied ?to)
                         (not (occupied ?from))
                    )
  )

  (:action light_room
         		:parameters (?l - location  ?o - object)

         		:precondition (and (in ?o ?l)
         				          (climbable ?o)
                          (not(lit ?l)))

         		:effect (lit ?l)
    )

    (:action de-light_room
           		:parameters (?l - location  ?o - object)

           		:precondition (and (in ?o ?l)
           				          (climbable ?o)
                            (lit ?l)
                            )

           		:effect (not (lit ?l))
      )

    (:action push_box_between_rooms
              :parameters (?from ?to - location ?d - door ?o - object)

              :precondition (and (occupied ?from)
                                 (in ?o ?from)
                                 (connected ?from ?to ?d)
                                 (wide ?d)
                                 (pushable ?o)
                            )

              :effect (and (in ?o ?to)
                           (not (in ?o ?from))
                           (occupied ?to)
                           (not (occupied ?from))
                      )
    )


    (:action pick_up_object
            :parameters (?o - object ?a - arm ?l - location)

            :precondition (and (holdable ?o)
                   				     (empty ?a)
                               (lit ?l)
                               (in ?o ?l)
                               (occupied ?l)
                          )

            :effect (and (not (empty ?a))
                         (holding ?a ?o)
                         (not (in ?o ?l))
                    )
    )

    (:action drop_object
            :parameters (?o - object ?a - arm ?l - location)

            :precondition (and (holding ?a ?o)
                   				     (not (empty ?a))
                               (occupied ?l)
                          )

            :effect (and (empty ?a)
                         (holding ?a ?o)
                         (in ?o ?l)
                    )
    )


  )
