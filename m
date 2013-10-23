From: vishal.l.verma@linux.intel.com (Vishal Verma)
Date: Wed, 23 Oct 2013 15:01:58 -0600
Subject: [PATCHv2] NVMe: compat SG_IO ioctl
In-Reply-To: <1382555254-23087-1-git-send-email-keith.busch@intel.com>
References: <1382555254-23087-1-git-send-email-keith.busch@intel.com>
Message-ID: <1382562118.20774.11.camel@teamfortress>

On Wed, 2013-10-23@13:07 -0600, Keith Busch wrote:
> For 32-bit versions of sg3-utils running on a 64-bit system. This is
> mostly a copy from the relevent portions of fs/compat_ioctl.c, with
> slight modifications for going through block_device_operations.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> v1->v2:
> 
> Added the copying the status back into the 32-bit user structure at the
> end. I missed this when copying from the original implmenetation.
> 
>  drivers/block/nvme-core.c |   14 ++++-
>  drivers/block/nvme-scsi.c |  146 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/nvme.h      |    1 +
>  3 files changed, 160 insertions(+), 1 deletion(-)
> 

Reviewed-by: Vishal Verma <vishal.l.verma at linux.intel.com>
