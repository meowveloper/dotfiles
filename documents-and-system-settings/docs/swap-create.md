# How to create swap space after installation without manual partitioning

1. create swap file
```bash
sudo touch /swapfile
```

2. Set the no-COW attribute on the swap file
```bash
sudo chattr +C /swapfile
```

3. Allocate the actual space (make space 1x or 2x of RAM)
```bash
sudo fallocate -l 24G /swapfile
```

4. Set permissions
```bash
sudo chmod 600 /swapfile
```

5. Designate the file as a swap area
```bash
sudo mkswap /swapfile
```

6. Activate the swap file immediately for the current session.
```bash
sudo swapon /swapfile
```

7. Make the Swap Permanent 
    - For the swap file to be active every time you boot add the following line to the end of `/etc/fstab` file (need sudo)
    - `/swapfile none swap defaults 0 0`

