# Nix Cheatsheet

## Search for a package
nix search nixpkgs PACKAGE_NAME
nix search nixpkgs 'python.*'

## Use nix-shell to test packages before installing them. 
nix-shell -p PACKAGE_NAME

## Add new packages to the command-line-utilities package. 
First, edit and add the package name to the list following `paths = with pkgs; [` then:

git add flake.nix
git commit -m "COMMIT MESSAGE"
nix profile upgrade nix-config

## Update installed packages. 
nix flake update # Updates the flake.lock with more up-to-date software. 
git diff flake.lock # Examine to see what's updated. 
git add flake.lock
git commit -m "Updating nixpkgs"
nix profile upgrade nix-config # Actually upgrades the software. 

## See installed profile packages
nix profile list

## Maintenance: See generations and rollback
nix profile history # Lists generations
nix profile rollback # Rolls back to previous generation. 
nix profile rollback --to <generation> # To specific generation. 

## Maintenance: Purge unreferenced Nix packages
nix store du -sh /nix/store # See size of Nix store
nix-collect-garbage # -d option deletes old generations first, which is more aggressive but limits rollback possibility. 

## Other Nix commands
nix profile add nixpkgs#PACKAGE_NAME # Installs a package outside the declarative flake configuration. Use the flake instead.
nix config check 
nix store info 
nix flake --help

## NixOS Updates
NixOS stores configuration information at /etc/nixos/configuration.nix
After editing it, upgrade to include packages and switch to the updated version with: 
sudo nixos-rebuild switch
