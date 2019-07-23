From: mark.wunderlich@intel.com (Wunderlich, Mark)
Date: Tue, 23 Jul 2019 00:06:44 +0000
Subject: nvme-tcp: 'page must not be a Slab one'
In-Reply-To: <6a2eedf1-8629-c5b5-257b-94cf7b3c7ae6@grimberg.me>
References: <B33B37937B7F3D4CB878107E305D4916D14FD1@ORSMSX104.amr.corp.intel.com>
 <6a2eedf1-8629-c5b5-257b-94cf7b3c7ae6@grimberg.me>
Message-ID: <B33B37937B7F3D4CB878107E305D4916D15096@ORSMSX104.amr.corp.intel.com>

Thanks Sagi,

Indeed no, I did not have that patch yet.  I now see it tagged @ v5.3-rc1.
I'll move to that branch, or also try for now stable-v5.2.1 without CONFIG_DEBUG_VM.

Cheers

-----Original Message-----
From: Sagi Grimberg [mailto:sagi@grimberg.me] 
Sent: Monday, July 22, 2019 3:38 PM
To: Wunderlich, Mark <mark.wunderlich at intel.com>; linux-nvme at lists.infradead.org
Subject: Re: nvme-tcp: 'page must not be a Slab one'


> New to this list, not to NVMe_oF.? Apologize up front if this is not an appropriate use of this forum, please slap wrist appropriately if so.

This is exactly the correct forum.

> Am developing for NVMe_oF/TCP, and seeing the failure message in subject line during kernel_sendpage.
> This failure new to me starting with v5.1.? See it in v5.2 and stable 5.2.1
> 
> Wondering if this is related to 'nvme-tcp: replace sendpage calls with sendmsg calls for SLAB chunks'?.? If so, is there patch in the works to address it, or did I miss it.

Yes, this is specific to CONFIG_DEBUG_VM.

do you have this patch applied?
37c15219599f ("nvme-tcp: don't use sendpage for SLAB pages")
