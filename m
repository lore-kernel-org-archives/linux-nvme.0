From: minwoo.im@samsung.com (Minwoo Im)
Date: Thu, 11 Apr 2019 20:21:55 +0900
Subject: [PATCH v2] nvme-cli: fix typo, removing the duplicate 'are'
In-Reply-To: <20190411092316.5479-1-sschricker@suse.de>
References: <20190411092316.5479-1-sschricker@suse.de>
 <CGME20190411092619epcas5p1a46c545239ce6f387137cf97ae02600a@epcms2p4>
Message-ID: <20190411112155epcms2p4864c8230eac00d6047b424268d46bee9@epcms2p4>

> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf
> Of Simon Schricker
> Sent: Thursday, April 11, 2019 6:23 PM
> To: linux-nvme at lists.infradead.org
> Cc: keith.busch at intel.com; sschricker at suse.de; hch at lst.de;
> sagi at grimberg.me
> Subject: [PATCH v2] nvme-cli: fix typo, removing the duplicate 'are'
> 
> Signed-off-by: Simon Schricker <sschricker at suse.de>
> ---
>  Documentation/nvme-netapp-ontapdevices.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/nvme-netapp-ontapdevices.txt
> b/Documentation/nvme-netapp-ontapdevices.txt
> index 8eaa73f..c292758 100644
> --- a/Documentation/nvme-netapp-ontapdevices.txt
> +++ b/Documentation/nvme-netapp-ontapdevices.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  Display information about ONTAP devices on the host. The ONTAP devices
> are
> -are identified using the Identify Controller data.
> +identified using the Identify Controller data.

We can regenerate documents sooner or later for .html and .1.
For this patch, Looks good.

Reviewed-by: Minwoo Im <minwoo.im at samsung.com>

> 
>  OPTIONS
>  -------
> --
> 2.16.4
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
