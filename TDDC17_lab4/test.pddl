(define (domain SHAKEYS_WORLD)
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
  (:action move
         		:parameters (?from ?to - location  ?d - door)

         		:precondition (and (connected ?from ?to ?d)
         				         (occupied ?from)
         				         (not (occupied ?to)))

         		:effect (and (occupied ?to) (not (occupied ?from)))
            )

    (:action pick_up
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
  )
