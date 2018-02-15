From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 15 Feb 2018 08:44:25 +0100
Subject: NVMe disks are not available with lsblk
In-Reply-To: <24c11b7c42c0958f813aa396c6cd85c3@linux.vnet.ibm.com>
References: <24c11b7c42c0958f813aa396c6cd85c3@linux.vnet.ibm.com>
Message-ID: <20180215074425.eiqgxjc5kci2u3zv@linux-x5ow.site>

On Wed, Feb 14, 2018@10:40:01AM -0600, wenxiong wrote:
> Hi All,
> 
> Somehow with CONFIG_NVME_MULTIPATH enable(4.16.0-rc1), one of my NVME device
> is not showed up with lsblk command.
> 
> 
> I am not familiar with CONFIG_NVME_MULTIPATH enable. I tried to enable
> multipath in system but still not show up.
> 
> For example,/dev/nvme1 device is showed up in nvme list but not with lsblk.
> 
> Anyone saw the similar issue? Any suggestion for debugging this issue?

Can you chec if you have a this commit:
https://git.kernel.org/pub/scm/utils/util-linux/util-linux.git/commit/?id=d51f05bfecb299a830897106460bf395be440c0a
for util-linux?

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
