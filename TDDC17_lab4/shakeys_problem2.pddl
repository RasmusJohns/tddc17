
(define (problem shakyes_problem1)
	      (:domain shakeys_domain)
	(:objects
		room1 room2 room3 room4 room5		- location
		left_arm right_arm 		- arm
		box ball1  ball2 ball3 ball4	- object
		door12 door23 door34 door41 doorw1 doorw2 doorw3 doorw4 		- door
		)
	(:init
			(connected room1 room2 door12)
			(connected room2 room1 door12)
			(connected room2 room3 door23)
			(connected room3 room2 door23)
			(connected room2 room3 door34)
			(connected room3 room2 door34)
			(connected room4 room1 door41)
			(connected room1 room4 door41)

			(connected room5 room1 doorw1)
			(connected room1 room5 doorw1)
			(connected room5 room2 doorw2)
			(connected room2 room5 doorw2)
			(connected room5 room3 doorw3)
			(connected room3 room5 doorw3)
			(connected room5 room4 doorw4)
			(connected room4 room5 doorw4)

			(wide doorw1)
			(wide doorw2)
			(wide doorw3)
			(wide doorw4)

			(occupied room5)

			(in box room1)
			(in ball1 room1)
			(in ball2 room2)
			(in ball3 room3)
			(in ball4 room4)

			(pushable box)
			(climbable box)

			(holdable ball1)
			(holdable ball2)
			(holdable ball3)
			(holdable ball4)

			(empty left_arm)
			(empty right_arm)
	)
	(:goal (and (in ball1 room4)
							(in ball2 room3)
							(in ball3 room1)
							(in ball4 room2)
							(not (lit room1))
							(not (lit room2))
							(not (lit room3))
							(not (lit room4))
							(occupied room4)

				 )
	)
)
