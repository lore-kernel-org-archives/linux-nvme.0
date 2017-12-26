From: yyt168@gmail.com (Tony Yang)
Date: Tue, 26 Dec 2017 17:14:27 +0800
Subject: How to Persistent nvme Storage?
In-Reply-To: <372c46ad-bfbd-416f-945d-356bacc3dc7c@grimberg.me>
References: <CADL4p-oX+AojAs-rSL5CY_p2hZYaK_cJ+Px+NkVeKhh428OUDw@mail.gmail.com>
 <8b1b3096-5c03-6f8d-b3f2-fe0cfa025a5b@grimberg.me>
 <CADL4p-r1bLz4jM_YoJbanBVE3kPDuoy35iJyRGPSt7KATYUeDQ@mail.gmail.com>
 <66c5e406-6f4f-497f-9633-f1d85de7e303@grimberg.me>
 <CADL4p-qifp4VXTJuh6GkHsuMdFSCeHOYvXM7-+QuMTOq3imMtA@mail.gmail.com>
 <5b609220-cb69-6995-6422-5f203bfb3cfb@grimberg.me>
 <CADL4p-pT6TpmYz5fCmJQQAFQzuttX=h20V-ROoHV67a9C-XMJg@mail.gmail.com>
 <CADL4p-oTfz2+0G-+mDsCDoom+4VJ_aZgbasYwQ35UsxrEaW7wA@mail.gmail.com>
 <25635e6f-ad24-06a2-ac06-db86c784fc05@grimberg.me>
 <CADL4p-pY5PeS7RrpVsFWh5hX_bSL7r2pYpb2SBjS-eh5Zd0u+w@mail.gmail.com>
 <372c46ad-bfbd-416f-945d-356bacc3dc7c@grimberg.me>
Message-ID: <CADL4p-oV4+yjLjsBAXhZJp61hoRrrwrkLwOkvb=kBEYyBZjjtg@mail.gmail.com>

Hi,

    I follow your prompts to download the latest nvme 4.15, according
to the following steps to configure, but still can not find
CONFIG_NVME_MULTIPATH this option, how to solve?

Create the kernel .config file?
make menuconfig

Select the following modules by clicking on each line and typing the letter "M".

NVM Express block device
NVM Express over Fabrics RDMA host driver
NVMe Target support
NVMe loopback device support
NVMe over Fabrics RDMA target support

Go to:

Device Drivers   > Network device support > Ethernet driver support >
Mellanox devices >

And make sure that the following module is enabled.

Mellanox Technologies ConnectX-4 and Connect-IB core driver

and then save .config to check not found CONFIG_NVME_MULTIPATH   <<<----

[root at cesdb01 nvme-4.15]# cat .config |grep -i nvme
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
[root at cesdb01 nvme-4.15]#


2017-12-26 1:27 GMT+08:00 Sagi Grimberg <sagi at grimberg.me>:
>
>> Thanks
>>
>>     I check the .config ,not found CONFIG_NVME_MULTIPATH=y?I added this
>> line to .config file then recompile, but always do not have this
>> option, how to set up this option to open? I use the nvme-4.15
>> version.
>>
>> [root at cesdb01 nvme-4.15]# uname -r
>> 4.13.0-rc7+
>
>
> You need to upgrade the kernel, you can use the latest from the nvme
> tree http://git.infradead.org/nvme.git nvme-4.15
