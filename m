From: yyt168@gmail.com (Tony Yang)
Date: Mon, 25 Dec 2017 23:02:35 +0800
Subject: How to Persistent nvme Storage?
In-Reply-To: <25635e6f-ad24-06a2-ac06-db86c784fc05@grimberg.me>
References: <CADL4p-oX+AojAs-rSL5CY_p2hZYaK_cJ+Px+NkVeKhh428OUDw@mail.gmail.com>
 <8b1b3096-5c03-6f8d-b3f2-fe0cfa025a5b@grimberg.me>
 <CADL4p-r1bLz4jM_YoJbanBVE3kPDuoy35iJyRGPSt7KATYUeDQ@mail.gmail.com>
 <66c5e406-6f4f-497f-9633-f1d85de7e303@grimberg.me>
 <CADL4p-qifp4VXTJuh6GkHsuMdFSCeHOYvXM7-+QuMTOq3imMtA@mail.gmail.com>
 <5b609220-cb69-6995-6422-5f203bfb3cfb@grimberg.me>
 <CADL4p-pT6TpmYz5fCmJQQAFQzuttX=h20V-ROoHV67a9C-XMJg@mail.gmail.com>
 <CADL4p-oTfz2+0G-+mDsCDoom+4VJ_aZgbasYwQ35UsxrEaW7wA@mail.gmail.com>
 <25635e6f-ad24-06a2-ac06-db86c784fc05@grimberg.me>
Message-ID: <CADL4p-pY5PeS7RrpVsFWh5hX_bSL7r2pYpb2SBjS-eh5Zd0u+w@mail.gmail.com>

Thanks

   I check the .config ,not found CONFIG_NVME_MULTIPATH=y?I added this
line to .config file then recompile, but always do not have this
option, how to set up this option to open? I use the nvme-4.15
version.

[root at cesdb01 nvme-4.15]# uname -r
4.13.0-rc7+
[root at cesdb01 nvme-4.15]# cat .config|grep -i nvme
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_FABRICS=m
CONFIG_NVME_RDMA=m
CONFIG_NVME_FC=m
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_RDMA=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
CONFIG_RTC_NVMEM=y
CONFIG_NVMEM=y
[root at cesdb01 nvme-4.15]# nvme list
Node             SN                   Model
        Namespace Usage                      Format           FW Rev
---------------- --------------------
---------------------------------------- ---------
-------------------------- ---------------- --------
/dev/nvme3n1     52a5c7ef4e684a27     Linux
        10        600.13  GB / 600.13  GB    512   B +  0 B   4.13.0-r
/dev/nvme4n1     20a4165e18d8146f     Linux
        10          1.92  TB /   1.92  TB    512   B +  0 B   4.13.0-r
/dev/nvme5n1     ab72e70de250bce6     Linux
        10          3.20  TB /   3.20  TB    512   B +  0 B   4.13.0-r
/dev/nvme6n1     67834bc8f68e1be9     Linux
        10          2.00  TB /   2.00  TB    512   B +  0 B   4.13.0-r
/dev/nvme7n1     bc3922467a3524a5     Linux
        10          1.92  TB /   1.92  TB    512   B +  0 B   4.13.0-r
/dev/nvme8n1     1d346731b87eb3d3     Linux
        10          1.92  TB /   1.92  TB    512   B +  0 B   4.13.0-r
[root at cesdb01 nvme-4.15]# nvme list-subsys
no NVMe subsystem(s) detected.
[root at cesdb01 nvme-4.15]#

2017-12-25 18:10 GMT+08:00 Sagi Grimberg <sagi at grimberg.me>:
> Please check your kernel .config includes CONFIG_NVME_MULTIPATH=y
> and your kernel version.
