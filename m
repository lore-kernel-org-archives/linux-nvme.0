From: yyt168@gmail.com (Tony Yang)
Date: Fri, 15 Sep 2017 22:08:13 +0800
Subject: Compile nvme 4.13 appear error
Message-ID: <CADL4p-qzviN+8EuHA=vXE+E=Ot_ur7dWuXW0zdmGPnx4-gsdpA@mail.gmail.com>

Dear All


     I use make to Compile nvme 4.13, Appear this error

  CC drivers/acpi/acpica/nsxfname.o
make[3]: *** No rule to make target `drivers/acpi/acpica/nsxfobj.o',
needed by `drivers/acpi/acpica/acpi.o'. Stop.
make[2]: *** [drivers/acpi/acpica] Error 2
make[1]: *** [drivers/acpi] Error 2
make: *** [drivers] Error 2
[root at cescel03 nvme-nvme-4.13]# uname -r
2.6.32-431.el6.x86_64
[root at cescel03 nvme-nvme-4.13]# pwd
/u01/soft/nvme-nvme-4.13

Could you tell me how to solve this problem? I checked, The nsxfobj.o
file does not exist nvme 4.13 package.

Thanks

---Tony
