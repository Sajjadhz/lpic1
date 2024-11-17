### **What this script does?**
This script enables us to download debian packages with its dependencies which is useful when we want to install packages on air-gapped environments.

---

### **How to Use**
1. **Create a file with the package list**:  
   Example `package-list.txt`:
   ```
   ntp
   realmd
   libnss-sss
   libpam-sss
   sssd
   sssd-tools
   adcli
   samba-common-bin
   oddjob
   oddjob-mkhomedir
   packagekit
   ```

2. **Run the script**:  
   Provide the package list file as an argument:
   ```bash
   ./downloadPackages.sh package-list.txt
   ```

3. **Downloaded packages**:  
   All `.deb` files will be saved in a directory named with the current date (e.g., `17112024`).

---
