{
  description = "Hank's nix-darwin system flake";

	inputs = {
		nixpkgs.url = "https://flakehub.com/f/DeterminateSystems/nixpkgs-weekly/0.1";
		# nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

		nix-darwin.url = "github:nix-darwin/nix-darwin/master";
		nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

		mac-app-util.url = "github:hraban/mac-app-util";
		mac-app-util.inputs.nixpkgs.follows = "nixpkgs";

		home-manager.url = "github:nix-community/home-manager";
		home-manager.inputs.nixpkgs.follows = "nixpkgs";

		hermes-agent.url = "github:NousResearch/hermes-agent";
		hermes-agent.inputs.nixpkgs.follows = "nixpkgs";

		flake-parts.url = "github:hercules-ci/flake-parts";
		import-tree.url = "github:vic/import-tree";
		nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
	};

	outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
		imports = [
			inputs.flake-parts.flakeModules.modules
			(inputs.import-tree ./modules)
		];
	};
}
