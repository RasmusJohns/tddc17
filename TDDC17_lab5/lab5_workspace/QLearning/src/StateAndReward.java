public class StateAndReward {

	
	/* State discretization function for the angle controller */
	public static String getStateAngle(double angle, double vx, double vy) {

		/* TODO: IMPLEMENT THIS FUNCTION */
		
		String state = "stable";
		
		if (0 <= angle && angle < 0.39) {
			state = "1";
		} else if (0.39 <= angle && angle < 0.785) {
			state = "2";
		} else if (0.785 <= angle && angle < 1.57) {
			state = "3";
		} else if (1.57 <= angle && angle < Math.PI) {
			state = "4";
		} else if (-0.39 <= angle && angle < 0) {
			state = "-1";
		} else if (-0.785 <= angle && angle < -0.39) {
			state = "-2";
		} else if (-1.57 <= angle && angle < -0.785) {
			state = "-3";
		} else if (-Math.PI <= angle && angle < -1.57) {
			state = "-4";
		}
		return state;
	}

	/* Reward function for the angle controller */
	public static double getRewardAngle(double angle, double vx, double vy) {

		/* TODO: IMPLEMENT THIS FUNCTION */
		
		double reward = 0;

		// Use together with Gamma = 0.5
		reward = Math.pow(Math.PI, 2) - (Math.pow(angle, 2)); 
		
		return reward;
	}

	/* State discretization function for the full hover controller */
	public static String getStateHover(double angle, double vx, double vy) {

		/* TODO: IMPLEMENT THIS FUNCTION */

		String state = "OneStateToRuleThemAll2";
		String angle_state = "OneStateToRuleThemAll2";
		String vy_state = "OneStateToRuleThemAll2";
		String vx_state = "OneStateToRuleThemAll2";
		
		
		if (0 <= angle && angle < 0.39) {
			angle_state = "a1";
		} else if (0.39 <= angle && angle < 0.785) {
			angle_state = "a2";
		} else if (0.785 <= angle && angle < 1.57) {
			angle_state = "a3";
		} else if (1.57 <= angle && angle < Math.PI) {
			angle_state = "a4";
		} else if (-0.39 <= angle && angle < 0) {
			angle_state = "a-1";
		} else if (-0.785 <= angle && angle < -0.39) {
			angle_state = "a-2";
		} else if (-1.57 <= angle && angle < -0.785) {
			angle_state = "a-3";
		} else if (-Math.PI <= angle && angle < -1.57) {
			angle_state = "a-4";
		}
		
		/*if (-0.3 <= vy && vy < 0) {
			vy_state = "vy-1";
		} else if (-0.6 <= vy && vy < -0.3) {
			vy_state = "vy-2";
		} else if ( -2 <= vy && vy < -0.6) {
			vy_state = "vy-3";
		} else if ( -5 <= vy && vy < -2) {
			vy_state = "vy-4";
		} else if ( -25 <= vy && vy < -5) {
			vy_state = "vy-5";
		} else if ( 0 <= vy && vy < 0.3) {
			vy_state = "vy1";
		} else if ( 0.3 <= vy && vy < 0.6) {
			vy_state = "vy2";
		} else if ( 0.6 <= vy && vy < 2) {
			vy_state = "vy3";
		} else if ( 2 <= vy && vy < 5) {
			vy_state = "vy4";
		} else if ( 5 <= vy && vy < 25) {
			vy_state = "vy5";
		}
		
		if (-0.3 <= vx && vx < 0) {
			vx_state = "vx-1";
		} else if ( -0.6 <= vx && vx < -0.3) {
			vx_state = "vx-2";
		} else if ( -2 <= vx && vx < -0.6) {
			vx_state = "vx-3";
		} else if ( -5 <= vx && vx < -2) {
			vx_state = "vx-4";
		} else if ( -25 <= vx && vx < -5) {
			vx_state = "vx-5";
		} else if ( 0 <= vx && vx < 0.3) {
			vx_state = "vx1";
		} else if ( 0.3 <= vx && vx < 0.6) {
			vx_state = "vx2";
		} else if ( 0.6 <= vx && vx < 2) {
			vx_state = "vx3";
		} else if ( 2 <= vx && vx < 5) {
			vx_state = "vx4";
		} else if ( 5 <= vx && vx < 25) {
			vx_state = "vx5";
		}*/
		
		// kommentar för nästa gång: roboten är för svag i Y-led och faller. Annars ganska bra.
		state = angle_state + ":" + discretize(vx, 3, -3, 3) + ":" + discretize(vy, 10, -3, 3);
		
		return state;
	}

	/* Reward function for the full hover controller */
	public static double getRewardHover(double angle, double vx, double vy) {

		/* TODO: IMPLEMENT THIS FUNCTION */
		
		double reward = 0;
		
		double angle_reward = Math.pow(Math.PI, 2) - (Math.pow(angle, 2));
		
		double vy_reward = Math.pow(Math.PI, 2) / Math.pow(2, Math.abs(vy));
		
		double vx_reward = Math.pow(Math.PI, 2) / Math.pow(2, Math.abs(vx));
				
		reward = angle_reward + vy_reward + vx_reward;

		return reward;
	}

	// ///////////////////////////////////////////////////////////
	// discretize() performs a uniform discretization of the
	// value parameter.
	// It returns an integer between 0 and nrValues-1.
	// The min and max parameters are used to specify the interval
	// for the discretization.
	// If the value is lower than min, 0 is returned
	// If the value is higher than min, nrValues-1 is returned
	// otherwise a value between 1 and nrValues-2 is returned.
	//
	// Use discretize2() if you want a discretization method that does
	// not handle values lower than min and higher than max.
	// ///////////////////////////////////////////////////////////
	public static int discretize(double value, int nrValues, double min,
			double max) {
		if (nrValues < 2) {
			return 0;
		}

		double diff = max - min;

		if (value < min) {
			return 0;
		}
		if (value > max) {
			return nrValues - 1;
		}

		double tempValue = value - min;
		double ratio = tempValue / diff;

		return (int) (ratio * (nrValues - 2)) + 1;
	}

	// ///////////////////////////////////////////////////////////
	// discretize2() performs a uniform discretization of the
	// value parameter.
	// It returns an integer between 0 and nrValues-1.
	// The min and max parameters are used to specify the interval
	// for the discretization.
	// If the value is lower than min, 0 is returned
	// If the value is higher than min, nrValues-1 is returned
	// otherwise a value between 0 and nrValues-1 is returned.
	// ///////////////////////////////////////////////////////////
	public static int discretize2(double value, int nrValues, double min,
			double max) {
		double diff = max - min;

		if (value < min) {
			return 0;
		}
		if (value > max) {
			return nrValues - 1;
		}

		double tempValue = value - min;
		double ratio = tempValue / diff;

		return (int) (ratio * nrValues);
	}

}
