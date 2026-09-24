{
  description = "Nix-managed command-line environment for macOS";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { nixpkgs, ... }:
    let
      systems = [
        "aarch64-darwin"
        # "aarch64-linux" # Not implemented yet.
        # "x86_64-linux" # Not implemented yet.
      ];

      forAllSystems = nixpkgs.lib.genAttrs systems;

      cliPackages = pkgs: with pkgs; [
        btop
        git
        htop
        python3
        go
        micro
        fastfetch
        qrencode
        gh
        tlrc
		emacs
		emacsPackages.olivetti
        #bat
        #fd
        #fzf
        #jq
        #ripgrep
        #tree
        #wget
      ];
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.buildEnv {
            name = "command-line-utilities";
            paths = cliPackages pkgs;
          };
        }
      );
    };
}
