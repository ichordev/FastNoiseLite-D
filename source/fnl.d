extern(C) nothrow @nogc{
	//alias Float = float;
	alias Float = double;

	enum NoiseType{
		openSimplex2,
		openSimplex2S,
		cellular,
		perlin,
		valueCubic,
		value,
	}

	enum RotationType3D{
		none,
		improveXYPlanes,
		improveXZPlanes,
	}

	enum FractalType{
		none,
		fbm,
		ridged,
		pingPong,
		domainWarpProgressive,
		domainWarpIndependent,
	}

	enum CellularDistFn{
		euclidean,
		distEuclideanSq,
		distManhattan,
		distHybrid,
	}

	enum CellularReturnType{
		cellValue,
		dist,
		dist2,
		dist2Add,
		dist2Sub,
		dist2Mul,
		dist2Div,
	}

	enum DomainWarpType{
		openSimplex2,
		openSimplex2Reduced,
		basicGrid,
	}

	/**
	* Structure containing entire noise system state.
	* @note Must only be created using fnlCreateState(optional: seed). To ensure defaults are set.
	*/
	struct NoiseState{
		/**
		* Seed used for all noise types.
		* @remark Default: 1337
		*/
		int seed;
		
		/**
		* The frequency for all noise types.
		* @remark Default: 0.01
		*/
		float frequency;
		
		/**
		* The noise algorithm to be used by GetNoise(...).
		* @remark Default: NoiseType.openSimplex2
		*/
		NoiseType noiseType;
		
		/**
		* Sets noise rotation type for 3D.
		* @remark Default: RotationType3D.none
		*/
		RotationType3D rotationType3D;
		
		/**
		* The method used for combining octaves for all fractal noise types.
		* @remark Default: None
		* @remark FractalType.domainWarp... only effects fnlDomainWarp...
		*/
		FractalType fractalType;
		
		/**
		* The octave count for all fractal noise types.
		* @remark Default: 3
		*/
		int octaves;
		
		/**
		* The octave lacunarity for all fractal noise types.
		* @remark Default: 2.0
		*/
		float lacunarity;
		
		/**
		* The octave gain for all fractal noise types.
		* @remark Default: 0.5
		*/
		float gain;
		
		/**
		* The octave weighting for all none Domaain Warp fractal types.
		* @remark Default: 0.0
		* @remark 
		*/
		float weightedStrength;
		
		/**
		* The strength of the fractal ping pong effect.
		* @remark Default: 2.0
		*/
		float pingPongStrength;
		
		/**
		* The distance function used in cellular noise calculations.
		* @remark Default: CellularDistFn.distEuclideanSQ
		*/
		CellularDistFn cellularDistFn;
		
		/**
		* The cellular return type from cellular noise calculations.
	// 	 * @remark Default: CellularReturnType.dist
		*/
		CellularReturnType cellularReturnType;
		
		/**
		* The maximum distance a cellular point can move from it's grid position.
		* @remark Default: 1.0
		* @note Setting this higher than 1 will cause artifacts.
		*/
		float cellularJitterMod;
		
		/**
		* The warp algorithm when using fnlDomainWarp...
		* @remark Default: OpenSimplex2
		*/
		DomainWarpType domainWarpType;
		
		/**
		* The maximum warp distance from original position when using fnlDomainWarp...
		* @remark Default: 1.0
		*/
		float domainWarpAmp;
	}
	
	private{
		/**
		* Creates a noise state with default values.
		* @param seed Optionally set the state seed.
		*/
		NoiseState fnlCreateState();
		
		/**
		* 2D noise at given position using the state settings
		* @returns Noise output bounded between -1 and 1.
		*/
		float fnlGetNoise2D(NoiseState* state, Float x, Float y);
		
		/**
		* 3D noise at given position using the state settings
		* @returns Noise output bounded between -1 and 1.
		*/
		float fnlGetNoise3D(NoiseState* state, Float x, Float y, Float z);
		
		/**
		* 2D warps the input position using current domain warp settings.
		* 
		* Example usage with fnlGetNoise2D:
		* ```
		* fnlDomainWarp2D(&state, &x, &y);
		* noise = fnlGetNoise2D(&state, x, y);
		* ```
		*/
		void fnlDomainWarp2D(NoiseState* state, Float* x, Float* y);
		
		/**
		* 3D warps the input position using current domain warp settings.
		* 
		* Example usage with fnlGetNoise3D:
		* ```
		* fnlDomainWarp3D(&state, &x, &y, &z);
		* noise = fnlGetNoise3D(&state, x, y, z);
		* ```
		*/
		void fnlDomainWarp3D(NoiseState* state, Float* x, Float* y, Float* z);
	}
		alias createState = fnlCreateState;
		alias getNoise2D = fnlGetNoise2D;
		alias getNoise3D = fnlGetNoise3D;
		alias domainWarp2D = fnlDomainWarp2D;
		alias domainWarp3D = fnlDomainWarp3D;
}
