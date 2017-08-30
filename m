From: changpeng.liu@intel.com (Liu, Changpeng)
Date: Wed, 30 Aug 2017 07:35:34 +0000
Subject: [PATCH] nvme: fix the definition of Amin doorbell buffer config
 support
In-Reply-To: <d02bb862-427a-81e9-8f44-7aa8d07331e0@mellanox.com>
References: <1504149769-15307-1-git-send-email-changpeng.liu@intel.com>
 <d02bb862-427a-81e9-8f44-7aa8d07331e0@mellanox.com>
Message-ID: <FF7FC980937D6342B9D289F5F3C7C2625B5BCB74@SHSMSX103.ccr.corp.intel.com>



> -----Original Message-----
> From: Max Gurtovoy [mailto:maxg at mellanox.com]
> Sent: Wednesday, August 30, 2017 3:18 PM
> To: Liu, Changpeng <changpeng.liu at intel.com>; linux-nvme at lists.infradead.org;
> Busch, Keith <keith.busch at intel.com>; axboe at fb.com; hch at lst.de;
> sagi at grimberg.me
> Subject: Re: [PATCH] nvme: fix the definition of Amin doorbell buffer config
> support
> 
> 
> 
> On 8/31/2017 6:22 AM, Changpeng Liu wrote:
> > NVMe 1.3 specification defines the Optioal Admin Command Support
> > feature flags, bit 8 set to '1' then the controller supports the
> > Doorbell Buffer Config command. Bit 7 is used for Virtualization
> > Mangement command.
> >
> > Signed-off-by: Changpeng Liu <changpeng.liu at intel.com>
> > ---
> >   include/linux/nvme.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> 
> Looks good (need to update the typo Optioal -> Optional during the merge),
Thanks, will send v2 to fix the typo.
> 
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
