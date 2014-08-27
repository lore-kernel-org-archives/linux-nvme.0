From: vishal.l.verma@intel.com (Verma, Vishal L)
Date: Wed, 27 Aug 2014 20:52:53 +0000
Subject: [PATCH 2/2] NVMe: Fix SG_IO status values
In-Reply-To: <1409169339-9821-2-git-send-email-keith.busch@intel.com>
References: <1409169339-9821-1-git-send-email-keith.busch@intel.com>
 <1409169339-9821-2-git-send-email-keith.busch@intel.com>
Message-ID: <1409172776.27227.1.camel@omniknight.lm.intel.com>

On Wed, 2014-08-27@13:55 -0600, Keith Busch wrote:
> We've only been setting the sg_io_hdr status values on SCSI commands
> that require an nvme command to complete the translation. The fields
> in the struct are output parameters, so we have to set them, otherwise
> user space will see whatever was in memory from before. In the case of
> compat SG_IO, this would reveal kernel memory. This fixes the issue by
> initializing the sg_io_hdr with successful status.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/block/nvme-scsi.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
Acked-by: Vishal Verma <vishal.l.verma at linux.intel.com>
