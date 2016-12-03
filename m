From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 3 Dec 2016 13:57:01 +0300
Subject: [PATCH 2/3] ahci-remap.h: add ahci remapping definitions
In-Reply-To: <1480703463-17489-3-git-send-email-hch@lst.de>
References: <1480703463-17489-1-git-send-email-hch@lst.de>
 <1480703463-17489-3-git-send-email-hch@lst.de>
Message-ID: <aa6cba2c-6cf7-0222-b871-d98d1c8e4fe8@cogentembedded.com>

Hello.

On 12/2/2016 9:31 PM, Christoph Hellwig wrote:

> From: Dan Williams <dan.j.williams at intel.com>
>
> Signed-off-by: Dan Williams <dan.j.williams at intel.com>
> [hch: split into a separate header and commit]
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  include/linux/ahci-remap.h | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>  create mode 100644 include/linux/ahci-remap.h
>
> diff --git a/include/linux/ahci-remap.h b/include/linux/ahci-remap.h
> new file mode 100644
> index 0000000..883d366
> --- /dev/null
> +++ b/include/linux/ahci-remap.h
> @@ -0,0 +1,29 @@
> +#ifndef _LINUX_AHCI_REMAP_H
> +#define _LINUX_AHCI_REMAP_H
> +
> +#include <linux/sizes.h>
> +
> +#define AHCI_VSCAP		0xa4
> +#define AHCI_REMAP_CAP		0x800
> +#define AHCI_VSCAP		0xa4

    Why do it twice?

MBR, Sergei
