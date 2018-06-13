From: keith.busch@intel.com (Keith Busch)
Date: Wed, 13 Jun 2018 09:11:29 -0600
Subject: NVMe drive kernel fail after hotplug kernel 4.16.12
In-Reply-To: <AM6PR03MB4038A5FDD819AE34DDDE54A4F87E0@AM6PR03MB4038.eurprd03.prod.outlook.com>
References: <AM6PR03MB4038E7290A514371F9D60E17F87F0@AM6PR03MB4038.eurprd03.prod.outlook.com>
 <AM6PR03MB4038A5FDD819AE34DDDE54A4F87E0@AM6PR03MB4038.eurprd03.prod.outlook.com>
Message-ID: <20180613151128.GB5574@localhost.localdomain>

On Wed, Jun 13, 2018@01:31:37AM -0700, Albert Schlegel wrote:
> Hi,
> 
> 
> I have a problem with NVMe drive and hotplug where the kernel (nvme driver) has some problems. I posted the detailed problem here:
> https://www.linuxquestions.org/questions/showthread.php?p=5866497#post5866497
> 
> 
> Is there a solution for this or it is possible to fix this?

Could you see if this commit fixes your issue?

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/nvme/host/pci.c?id=1d39e6928cbd0eb737c51545210b5186d5551ba1
