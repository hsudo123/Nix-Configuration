{
  description = "Hank's nix-darwin system flake";

    inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

		nix-darwin.url = "github:nix-darwin/nix-darwin/master";
		nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		flake-parts.url = "github:hercules-ci/flake-parts";
		import-tree.url = "github:vic/import-tree";

		mac-app-util.url = "github:hraban/mac-app-util";
    };

	outputs = inputs@{ 
		self, 
		nixpkgs, 
		nix-darwin, 
		home-manager, 
		mac-app-util, 
		... 
	}: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
		imports = [
			inputs.flake-parts.flakeModules.modules
			(inputs.import-tree ./modules)
		];
	};
}
