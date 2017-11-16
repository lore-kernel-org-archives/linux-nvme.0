From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri, 17 Nov 2017 01:37:29 +0900
Subject: [PATCH] nvme-pci: avoid hmb desc array idx out-of-bound when
 hmmaxd set.
In-Reply-To: <1510850064-10419-1-git-send-email-minwoo.im.dev@gmail.com>
References: <1510850064-10419-1-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <CAA7jztde+cNEXDsAJ+BuxBD07o1=1rOqb8PD4FjLJAopbx3_Rg@mail.gmail.com>

+ added linux-nvme at lists.infradead.org

On Fri, Nov 17, 2017@1:34 AM, Minwoo Im <minwoo.im.dev@gmail.com> wrote:
> hmb descriptor idx out-of-bound occurs in case of below conditions.
> preferred = 128MiB
> chunk_size = 4MiB
> hmmaxd = 1
>
> Current code will not allow rmmod which will free hmb descriptors
> to be done successfully in above case.
>
> "descs[i]" will be set in for-loop without seeing any conditions
> related to "max_entries" after a single "descs" was allocated by
> (max_entries = 1) in this case.
>
> Added a condition into for-loop to check index of descriptors.
>
> Fixes: 044a9df1("nvme-pci: implement the HMB entry number and size limitations")
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>  drivers/nvme/host/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 762b840..c66e57d 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1787,7 +1787,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
>         if (!bufs)
>                 goto out_free_descs;
>
> -       for (size = 0; size < preferred; size += len) {
> +       for (size = 0; size < preferred && i < max_entries; size += len) {
>                 dma_addr_t dma_addr;
>
>                 len = min_t(u64, chunk_size, preferred - size);
> --
> 2.7.4
>
