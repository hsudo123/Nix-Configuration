# Nix configuration for both nix-darwin (macs), nixos, and home-manager

# 為甚麼要用Nix
[NixOS: Everything Everywhere All At Once](https://www.youtube.com/watch?v=CwfKlX3rA6E)

[Nix in 100 Seconds](https://www.youtube.com/watch?v=FJVFXsNzYZQ)

- Nix天生管理套件的方式不會有[dependency hell](https://zh.wikipedia.org/zh-tw/%E7%9B%B8%E4%BE%9D%E6%80%A7%E5%9C%B0%E7%8B%B1)的問題
- NixOS提供了一個集中化宣告式系統、套件安裝設定的介面，你對系統的變更幾乎都可以包含在/etc/nixos下，因此同樣的設定檔可以產出同樣的系統
- NixOS在每次rebuild都會產生新的generation，當系統出現錯誤時，你可以輕鬆回到還未出錯的狀態

以上，NixOS是穩定性、可重現性極強的linux發行版

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