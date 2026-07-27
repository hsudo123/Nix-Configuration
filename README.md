# Nix configuration for both nix-darwin (macs), nixos, and home-manager

# nix-darwin
1. download [nix package manager](https://nixos.org/download/#nix-install-macos)
2. edit `nix.conf` 
    ```nix
    experimental-features = nix-command flakes
    ```
3. clone the repository to $HOME, rename the folder as `sysconfig`
4. install nix-darwin and build the config by 
   ```zsh
   sudo nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/sysconfig#HSUDO
   ```

# nixos
1. install [nixos](https://nixos.org/download/#nix-install-macos)
2. edit `nix.conf` 
    ```nix
    experimental-features = nix-command flakes
    ```
3. clone the repository to $HOME, rename the folder as `sysconfig`
4. copy content of `/etc/nixos/hardware-configuration.nix` to `sysconfig/HANIX.nix` (in the module named `flake.modules.nixos.hardware`)
5. build the config by 
    ```zsh
    sudo nixos-rebuild switch --flake ~/sysconfig#HANIX
    ```

# home-manager
1. after either of the above done, run the following command
    ```zsh
    nix run github:nix-community/home-manager -- switch --flake ~/sysconfig#<user_name>@<host_name>
    ```