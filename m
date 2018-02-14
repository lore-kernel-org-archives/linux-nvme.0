From: wenxiong@linux.vnet.ibm.com (wenxiong)
Date: Wed, 14 Feb 2018 10:40:01 -0600
Subject: NVMe disks are not available with lsblk
Message-ID: <24c11b7c42c0958f813aa396c6cd85c3@linux.vnet.ibm.com>

Hi All,

Somehow with CONFIG_NVME_MULTIPATH enable(4.16.0-rc1), one of my NVME 
device is not showed up with lsblk command.


I am not familiar with CONFIG_NVME_MULTIPATH enable. I tried to enable 
multipath in system but still not show up.

For example,/dev/nvme1 device is showed up in nvme list but not with 
lsblk.

Anyone saw the similar issue? Any suggestion for debugging this issue?

Thanks,
Wendy
# nvme list
Node             SN                   Model                              
       Namespace Usage                      Format           FW Rev
---------------- -------------------- 
---------------------------------------- --------- 
-------------------------- ---------------- --------
/dev/nvme1n1     S3RVNA0J600164       PCIe3 1.6TB NVMe Flash Adapter II 
x8     1         245.76  GB / 245.76  GB      4 KiB +  0 B   MN12MN12

# lsblk
NAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
sda       8:0    0    40G  0 disk
??sda1    8:1    0     4M  0 part
??sda2    8:2    0   500M  0 part
??sda3    8:3    0    21G  0 part
??sda4    8:4    0     4K  0 part
??sda5    8:5    0     2G  0 part [SWAP]
??sda6    8:6    0  12.6G  0 part /
??sda7    8:7    0   3.9G  0 part /home
