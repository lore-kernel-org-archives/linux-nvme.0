From: kbusch@kernel.org (Keith Busch)
Date: Mon, 15 Apr 2019 09:13:14 -0600
Subject: [PATCH v2] nvme-cli: fix typo, removing the duplicate 'are'
In-Reply-To: <20190411092316.5479-1-sschricker@suse.de>
References: <20190411092316.5479-1-sschricker@suse.de>
Message-ID: <20190415151314.GC7312@localhost.localdomain>

On Thu, Apr 11, 2019@11:23:16AM +0200, Simon Schricker wrote:
> Signed-off-by: Simon Schricker <sschricker at suse.de>
> ---
>  Documentation/nvme-netapp-ontapdevices.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/nvme-netapp-ontapdevices.txt b/Documentation/nvme-netapp-ontapdevices.txt
> index 8eaa73f..c292758 100644
> --- a/Documentation/nvme-netapp-ontapdevices.txt
> +++ b/Documentation/nvme-netapp-ontapdevices.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  DESCRIPTION
>  -----------
>  Display information about ONTAP devices on the host. The ONTAP devices are
> -are identified using the Identify Controller data.
> +identified using the Identify Controller data.
>  
>  OPTIONS
>  -------

Applied, thank you.
