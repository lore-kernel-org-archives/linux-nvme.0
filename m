From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sun, 3 Dec 2017 14:56:24 +0900
Subject: [PATCH] nvme-pci: remove an unnecessary variable initialization
 in HMB code
In-Reply-To: <1512279430-2806-1-git-send-email-minwoo.im.dev@gmail.com>
References: <1512279430-2806-1-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <CAA7jztd=fbtacLjOn5B04Nf2x-gzYr1qGiiuDZh-vK_SfiTwvg@mail.gmail.com>

On Sun, Dec 3, 2017@2:37 PM, Minwoo Im <minwoo.im.dev@gmail.com> wrote:
> The local variable __size__ will be set a bit later in a for-loop.
> Remove the explicit initialization at the beginning of this function.
>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index f5800c3..9f7993b 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1770,7 +1770,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
>         dma_addr_t descs_dma;
>         int i = 0;
>         void **bufs;
> -       u64 size = 0, tmp;
> +       u64 size, tmp;
>
>         tmp = (preferred + chunk_size - 1);
>         do_div(tmp, chunk_size);
> --
> 2.7.4
>

Sorry for making confusions. The following patch is good to be reviewed.
+ Added one more removal for an unnecessary variable initialization in
nvme_setup_host_mem()


The local variable __size__ and __ret__ will be set a bit later.
Remove the explicit initialization at the beginning of those functions.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 drivers/nvme/host/pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f5800c3..35331fa 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1770,7 +1770,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev
*dev, u64 preferred,
        dma_addr_t descs_dma;
        int i = 0;
        void **bufs;
-       u64 size = 0, tmp;
+       u64 size, tmp;

        tmp = (preferred + chunk_size - 1);
        do_div(tmp, chunk_size);
@@ -1853,7 +1853,7 @@ static int nvme_setup_host_mem(struct nvme_dev *dev)
        u64 preferred = (u64)dev->ctrl.hmpre * 4096;
        u64 min = (u64)dev->ctrl.hmmin * 4096;
        u32 enable_bits = NVME_HOST_MEM_ENABLE;
-       int ret = 0;
+       int ret;

        preferred = min(preferred, max);
        if (min > max) {
