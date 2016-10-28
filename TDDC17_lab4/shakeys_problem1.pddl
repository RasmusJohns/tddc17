
(define (problem shakyes_problem1)
	      (:domain shakeys_domain)
	(:objects
		room1 room2 room3 		- location
		left_arm right_arm 		- arm
		box ball toy_tractor 	- object
		door1 door2 door3 		- door
		)
	(:init
			(connected room1 room2 door1)
			(connected room2 room1 door1)
			(connected room2 room3 door2)
			(connected room3 room2 door2)
			(connected room2 room3 door3)
			(connected room3 room2 door3)
			(wide door3)
			(wide door1)
			(occupied room1)
			(in box room1)
			(in ball room2)
			(in toy_tractor room3)
			(pushable box)
			(climbable box)
			(holdable toy_tractor)
			(holdable ball)
			(empty left_arm)
			(empty right_arm)
	)
	(:goal (and (occupied room2)
							(in ball room3)
				 )
	)
)
