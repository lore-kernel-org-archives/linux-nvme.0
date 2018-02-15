From: wenxiong@linux.vnet.ibm.com (wenxiong)
Date: Thu, 15 Feb 2018 15:35:17 -0600
Subject: NVMe disks are not available with lsblk
In-Reply-To: <20180215074425.eiqgxjc5kci2u3zv@linux-x5ow.site>
References: <24c11b7c42c0958f813aa396c6cd85c3@linux.vnet.ibm.com>
 <20180215074425.eiqgxjc5kci2u3zv@linux-x5ow.site>
Message-ID: <42015a1d2e21bea1bd38227ba3d555af@linux.vnet.ibm.com>

On 2018-02-15 01:44, Johannes Thumshirn wrote:
> On Wed, Feb 14, 2018@10:40:01AM -0600, wenxiong wrote:
>> Hi All,
>> 
>> Somehow with CONFIG_NVME_MULTIPATH enable(4.16.0-rc1), one of my NVME 
>> device
>> is not showed up with lsblk command.
>> 
>> 
>> I am not familiar with CONFIG_NVME_MULTIPATH enable. I tried to enable
>> multipath in system but still not show up.
>> 
>> For example,/dev/nvme1 device is showed up in nvme list but not with 
>> lsblk.
>> 
>> Anyone saw the similar issue? Any suggestion for debugging this issue?
> 
> Can you chec if you have a this commit:
> https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=d51f05bfecb299a830897106460bf395be440c0a
> for util-linux?
> 
> Byte,
> 	Johannes

Hi John,

Thanks! I will try it.

I found an interesting thing today. I have two NVME devices(difference 
vendors) in my system.

With CONFIG_NVME_MULTIPATH enable(4.16-rc1),

linux-r4t8:/sys/block # ls -l
total 0
lrwxrwxrwx 1 root root 0 Feb 15 10:22 nvme0n1 -> 
../devices/pci001e:90/001e:90:00.0/nvme/nvme0/nvme0n1
lrwxrwxrwx 1 root root 0 Feb 15 10:22 nvme1c33n1 -> 
../devices/pci001c:70/001c:70:00.0/nvme/nvme1/nvme1c33n1
lrwxrwxrwx 1 root root 0 Feb 15 10:22 nvme1n1 -> 
../devices/virtual/nvme-subsystem/nvme-subsys1/nvme1n1
lrwxrwxrwx 1 root root 0 Feb 15 10:22 sda -> 
../devices/vio/30000003/host0/target0:0:1/0:0:1:0/block/sda

/dev/nvme1n1 is not showed up in lsblk. We really didn't see nvme1n1 in 
/sys/block but we saw nvme1c33n1. Probably I need to understand more 
about NVME_MULTIPATH. who may have documentation for NVME_MULTIPATH?


Without CONFIG_NVME_MULTIPATH disablb(4.16-rc1),

linux-r4t8:/sys/block # ls -ltr
total 0
lrwxrwxrwx 1 root root 0 Feb 15 15:14 nvme1n1 -> 
../devices/pci001c:70/001c:70:00.0/nvme/nvme1/nvme1n1
lrwxrwxrwx 1 root root 0 Feb 15 15:14 sda -> 
../devices/vio/30000003/host0/target0:0:1/0:0:1:0/block/sda
lrwxrwxrwx 1 root root 0 Feb 15 15:14 nvme0n1 -> 
../devices/pci001e:90/001e:90:00.0/nvme/nvme0/nvme0n1

Thanks,
Wendy
