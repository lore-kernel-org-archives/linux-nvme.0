From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 22 Jul 2019 15:38:02 -0700
Subject: nvme-tcp: 'page must not be a Slab one'
In-Reply-To: <B33B37937B7F3D4CB878107E305D4916D14FD1@ORSMSX104.amr.corp.intel.com>
References: <B33B37937B7F3D4CB878107E305D4916D14FD1@ORSMSX104.amr.corp.intel.com>
Message-ID: <6a2eedf1-8629-c5b5-257b-94cf7b3c7ae6@grimberg.me>


> New to this list, not to NVMe_oF.? Apologize up front if this is not an appropriate use of this forum, please slap wrist appropriately if so.

This is exactly the correct forum.

> Am developing for NVMe_oF/TCP, and seeing the failure message in subject line during kernel_sendpage.
> This failure new to me starting with v5.1.? See it in v5.2 and stable 5.2.1
> 
> Wondering if this is related to 'nvme-tcp: replace sendpage calls with sendmsg calls for SLAB chunks'?.? If so, is there patch in the works to address it, or did I miss it.

Yes, this is specific to CONFIG_DEBUG_VM.

do you have this patch applied?
37c15219599f ("nvme-tcp: don't use sendpage for SLAB pages")
