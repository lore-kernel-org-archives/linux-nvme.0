From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 13 Feb 2019 11:27:14 +0100
Subject: KXG60ZNV256G not recognized
In-Reply-To: <19873dbf-4c19-5cab-d5fb-c63f6cb72101@uni-siegen.de>
References: <19873dbf-4c19-5cab-d5fb-c63f6cb72101@uni-siegen.de>
Message-ID: <facf2124-d29c-2151-2419-db9b0776f3cd@suse.de>

On 13/02/2019 11:07, Gerd Pokorra wrote:
> Dear Sir or Madam,
> 
> in a Laptop is a NVMe SSD from Toshiba with the type name KXG60ZNV256G
> that will not be recognized from Linux. I can load the module nvme but
> there is no /dev/nvme*. I tried it with the kernel version 4.18.16-300.
> The command 'nvme list' show no device.
> 
> Could you help or have an idea how to access the device?

Hi Gerd,

Can you please send the output of 'lspci -vvv' for the device in question?

Thanks a lot,
	Johannes

-- 
Johannes Thumshirn                            SUSE Labs Filesystems
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
