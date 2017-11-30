From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Thu, 30 Nov 2017 23:37:52 +0900
Subject: [PATCH] nvme-pci: fix NULL pointer dereference in
 nvme_free_host_mem()
In-Reply-To: <1511546580-3165-1-git-send-email-minwoo.im.dev@gmail.com>
References: <1511546580-3165-1-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <CAA7jztcGumue11hx6zpoitGDuyRpm-ixp-j2GptNS=nqcO9ptg@mail.gmail.com>

On Sat, Nov 25, 2017@3:03 AM, Minwoo Im <minwoo.im.dev@gmail.com> wrote:
> Following condition which will cause NULL pointer dereference will
> occur in nvme_free_host_mem() when it tries to remove pci device via
> nvme_remove() especially after a failure of host memory allocation for HMB.
>
>     "(host_mem_descs == NULL) && (nr_host_mem_descs != 0)"
>
> It's because __nr_host_mem_descs__ is not cleared to 0 unlike
> __host_mem_descs__ is so.
>
> Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
> ---
>  drivers/nvme/host/pci.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 6173747..f5800c3 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1759,6 +1759,7 @@ static void nvme_free_host_mem(struct nvme_dev *dev)
>                         dev->nr_host_mem_descs * sizeof(*dev->host_mem_descs),
>                         dev->host_mem_descs, dev->host_mem_descs_dma);
>         dev->host_mem_descs = NULL;
> +       dev->nr_host_mem_descs = 0;
>  }
>
>  static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
> --
> 2.7.4
>

Hi Christoph,

I saw a commit (7e5dd57ef3081ff6c03908d786ed5087f6fbb7ae) for this
patch on nvme-4.15.
Thanks to you for picking it up.

Is there anything I missed or need to know about "freeing host memory"?

Thanks,
