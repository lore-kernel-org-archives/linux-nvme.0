Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AD3C54F54
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 05:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LnSKdBsI5P4yNxKlVDAgX6ZRyHfaTBwJq6vRswotV/I=; b=fFCTdm4ZP+GU5cV+s1RVI6cllD
	A+8hT/t1g0kiH4klHXud86awJjwHrLP1wvewktB87NyC0EDO2fmm4/64IPug5MdwYr46WGh3EGkbw
	AqQegEy80wsh88HDk+anm32YS4oOFIwP7NedF/AJstn9X2NoupvxCf3lwMuEqb0VSlwAEkQcRmNWs
	20dkmG/Cdo9DwaL9PnyJegyTU17NF7QVk7WzSj4cLMdmc9DJpmZDUwMXG/kN6WYiWaclJkGAwmRHk
	cnSQQXLSOvAf/DjEod4Xhga4J1hJecIbDVDSAIPWZp3eEEl2hjZlAYJzOXysan3RCxEf3UrdG2j6s
	0g3O3zww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpfSf-0000000Blos-0kEc;
	Fri, 31 Jul 2026 05:07:09 +0000
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpACB-00000008uRW-0iee
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 19:44:07 +0000
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-4ab3c6f7f44so67305b6e.3
        for <linux-nvme@lists.infradead.org>; Wed, 29 Jul 2026 12:44:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785354241; cv=none;
        d=google.com; s=arc-20260327;
        b=Z725I1Vlsx6sf/ksNUv2GJlU7+faieEWTOPrJy7OCICPLnYEW46vim8C3eVYEz95wS
         v5zRAJLdHa02LKmpPj6ecOf2zBzp9gcNG2feQXdKX2m89KnRFZG0+ywTYDcRpWRC7FD8
         3yBp3T1rSsdWYcPSG9qbYnIg4oj7k+82ZF1Y075XMRAKQbCQiJfEWW3FeILU2lOr7olP
         3lf6GdFsmyLP/g16/qiMB3Ov3+zqGgRd2XE+cHAXFlrvY+JiksvyidxNVN/DgvPouFg+
         bm8vAfymC0zDLR5yKle9lbpfNGaSORYCWLmhCHqQW3C6LJ/EFLGqEV+4ibxT1VFt3GZV
         YygA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LnSKdBsI5P4yNxKlVDAgX6ZRyHfaTBwJq6vRswotV/I=;
        fh=fvhlr5nSncUg5DclikiwKi0X2LiEKIBTGoT9JCTKoUs=;
        b=KnJxekhDtWxS6iPeaGH4J4L0IuwaW0yRlbOSKh9QDFX7AYhaGXIC4nlXrkxQ12qGcH
         W2Wx1Pi/0ZqD3OWaFO/xQs+S1ErXP1w+AdrApNPUuBBKfmzPW8Tiwcf4gAqFJrBDZ1ML
         6NmBbElC9N5EezSaqCvGZkkJ+Oq1v6YR+VwaKHM+0hGW22TxwocqtwjktslxF9MXxg3K
         U2V3denbwriXGNssL3sApO7EbQnpPrWUxKO8X3WfURF//8aTYzXjNe0jubPgI5rIlAzY
         +NvOODttEt/qNH8VxKqxXQpPi+5zVEoExrx+M0I3SWFCCE3nUZXA5CHI/FSNz6pKWEz0
         RQVQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1785354241; x=1785959041; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LnSKdBsI5P4yNxKlVDAgX6ZRyHfaTBwJq6vRswotV/I=;
        b=RuKxC2j5Vb1K5PtCtNx+KlVSpStVvHvB8VFWj6bZhsd5qF7SYGBRQKLSJT23GT3SyP
         PQRqbWqxEVbKvAEjie/3VXK+jL5Sn3/l7h1m8wUB19eCzTwIaU64q7jZSYDi2yBgYQmO
         9kFkZKNDZTmL3AQDPiNFMT6CDQYJZRHT5CwLXPVqfWMjxSgd623rButHs6e5JOe+bv2D
         a6xzlP4F2kUW8dydT6J78Q5RF43HvkVqAqGFhJm/1U6pOQJxLmISM6m9SglKKS9p4lPj
         y7Kp3Y/QWGhCZtviNKkMmOfK3Wrgq0tN/AxpS5LJ/N2TByFOe08C+hOHsEe/8uAJQPpY
         81SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785354241; x=1785959041;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LnSKdBsI5P4yNxKlVDAgX6ZRyHfaTBwJq6vRswotV/I=;
        b=QqjEv6qcl8OXW0/2fKX25dejsPjqll3vD7Z6v10286KoK6w/8A0KKyIYoyp0E+G0LR
         1EScAyvtwTEHzLnOaGw03mMbwP0/g6fivhGLJ4OcpFU3iCWdQLnvNWmy6zWE0/rGYfQz
         I4qw6QSNG7JxNcmu7q5nc/nekm57jx6RgX4O49fxT66aJbjJyOGUq5AsA5jv9GDJsChO
         1BiNCo8UdtlXVH3sgnbrcxTDzJzo45oOGhisymqMK5JeKoW9z0/aG0nMr8h5v71JHoWv
         iSFK0BOI/48jZRy1vDoIN04eh9pDTqQ87033IXy4AwLmtnohL0lYTzL16ON+8O9/rE6c
         Ygkw==
X-Forwarded-Encrypted: i=1; AHgh+RosMZlJTXpsPmKQSrjNEr0t0T4swC9F9tqQYl2R4dtNSN5HZiEkxuOI7si002E67Jw8z6LfcU4f8Y9g@lists.infradead.org
X-Gm-Message-State: AOJu0YwsnRPIGtBcP/7FIFOoXnOxDHpgIM4Khtdk28UtZxLPX5O9KfWc
	HRW5xeovWm/YlLKFgV28bEYMryVmNxMOsYXu0R3FfNLWbCE+1At99rlLAcmboGJIZG8h/38d6K9
	XKWIHTjgVPzTXbDAXE/sfYrHXdF0h+uNHEAciKhRYGw==
X-Gm-Gg: AR+sD131N3HKOspibnfGoh9Uzrcc7CPcAGwGQsYrLpjrWB2WRknT7a9piDkoAmTeTjm
	rxrnpP0HiDlXbdlRb2v+U2ORE/i97CgYkRZEbw1MW4Zd8Zs95fIpxnfvNuUzsB/OQ4HfwqPlOmZ
	hlRTmFjCmLvl23cK4J5j+xEgvl3Mz8CN4v9AVagUQtBw+qUD/4NXekZHq3xlfjRckUzb39E77EK
	ByOFUVwJ4TB/XJ5E+8bo4TZ0PA0FCb3qGBrSll4zuXMngD/W3rCcOQC1uno6njiFAohXR336lKC
	Pz7DJ3x2kMXB9CVAD+2U+Fp1kc4eilxk67kQmGjRb4tN
X-Received: by 2002:a05:6871:441:b0:457:9007:a35f with SMTP id
 586e51a60fabf-458bc1eaa28mr97408fac.1.1785354241430; Wed, 29 Jul 2026
 12:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1785274111.git.asml.silence@gmail.com> <19e5c945ea8114320c10f7951d19197d48b59249.1785274111.git.asml.silence@gmail.com>
In-Reply-To: <19e5c945ea8114320c10f7951d19197d48b59249.1785274111.git.asml.silence@gmail.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 29 Jul 2026 12:43:50 -0700
X-Gm-Features: AUfX_mzj7jaY2dlfE4GHJvNcQHfDZNxuFZTdOCDHOZZK5KuWQBBj743IB8eIF1Q
Message-ID: <CADUfDZpwF0jp2e=+c3w_NjWPbnQ858bkSD731M6+x27jzgcJiw@mail.gmail.com>
Subject: Re: [PATCH v4 08/14] nvme-pci: implement dma_token backed requests
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, 
	Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>, 
	William Power <william.power@intel.com>, Phil Cayton <phil.cayton@intel.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>, 
	Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, 
	Benjamin Marzinski <bmarzins@redhat.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev, 
	nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org, 
	ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_124403_444720_761B2667 
X-CRM114-Status: GOOD (  29.40  )
X-Mailman-Approved-At: Thu, 30 Jul 2026 22:07:00 -0700
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 28, 2026 at 2:35=E2=80=AFPM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> Enable BIO_DMABUF_MAP backed requests. It creates a prp list for the
> dmabuf when it's mapped, which is then used to initialise requests.
>
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  drivers/nvme/host/core.c |  12 ++
>  drivers/nvme/host/nvme.h |   2 +
>  drivers/nvme/host/pci.c  | 259 +++++++++++++++++++++++++++++++++++++++
>  3 files changed, 273 insertions(+)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 453c1f0b2dd0..ce66a1843bec 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2676,6 +2676,17 @@ static int nvme_report_zones(struct gendisk *disk,=
 sector_t sector,
>  #define nvme_report_zones      NULL
>  #endif /* CONFIG_BLK_DEV_ZONED */
>
> +static int nvme_init_dma_buf_io_ctx(struct block_device *bdev,
> +                                   struct dma_buf_io_ctx *ctx)
> +{
> +       struct nvme_ns *ns =3D bdev->bd_disk->private_data;
> +       struct nvme_ctrl *ctrl =3D ns->ctrl;
> +
> +       if (!ctrl->ops->init_dma_buf_io_ctx)
> +               return -EINVAL;
> +       return ctrl->ops->init_dma_buf_io_ctx(ctrl, ctx);
> +}
> +
>  const struct block_device_operations nvme_bdev_ops =3D {
>         .owner          =3D THIS_MODULE,
>         .ioctl          =3D nvme_ioctl,
> @@ -2686,6 +2697,7 @@ const struct block_device_operations nvme_bdev_ops =
=3D {
>         .get_unique_id  =3D nvme_get_unique_id,
>         .report_zones   =3D nvme_report_zones,
>         .pr_ops         =3D &nvme_pr_ops,
> +       .init_dma_buf_io_ctx =3D nvme_init_dma_buf_io_ctx,
>  };
>
>  static int nvme_wait_ready(struct nvme_ctrl *ctrl, u32 mask, u32 val,
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 824651cc898d..034c31af8fec 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -652,6 +652,8 @@ struct nvme_ctrl_ops {
>         int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
>         void (*print_device_info)(struct nvme_ctrl *ctrl);
>         bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
> +       int (*init_dma_buf_io_ctx)(struct nvme_ctrl *ctrl,
> +                                  struct dma_buf_io_ctx *ctx);
>         unsigned long (*get_virt_boundary)(struct nvme_ctrl *ctrl, bool i=
s_admin);
>  };
>
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 69932d640b53..f1b67c191892 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -27,6 +27,8 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/io-64-nonatomic-hi-lo.h>
>  #include <linux/sed-opal.h>
> +#include <linux/dma-buf-io.h>
> +#include <linux/dma-resv.h>
>
>  #include "trace.h"
>  #include "nvme.h"
> @@ -393,6 +395,13 @@ struct nvme_queue {
>         struct completion delete_done;
>  };
>
> +struct nvme_dmabuf_map {
> +       struct dma_buf_io_map base;
> +       struct sg_table *sgt;
> +       unsigned nr_entries;
> +       dma_addr_t dma_list[];
> +};
> +
>  /* bits for iod->flags */
>  enum nvme_iod_flags {
>         /* this command has been aborted by the timeout handler */
> @@ -859,6 +868,138 @@ static void nvme_free_descriptors(struct request *r=
eq)
>         }
>  }
>
> +static inline struct nvme_dmabuf_map *
> +to_nvme_dmabuf_map(struct dma_buf_io_map *map)
> +{
> +       return container_of(map, struct nvme_dmabuf_map, base);
> +}
> +
> +static void nvme_dmabuf_map_sync_for_cpu(struct nvme_dev *nvme_dev,
> +                                        struct request *req)
> +{
> +       struct device *dev =3D nvme_dev->dev;
> +       enum dma_data_direction dma_dir;
> +       struct bio *bio =3D req->bio;
> +       struct nvme_dmabuf_map *map =3D to_nvme_dmabuf_map(bio->bi_dmabuf=
_map);
> +       dma_addr_t *dma_list =3D map->dma_list;
> +       unsigned offset =3D bio->bi_iter.bi_offset;
> +       unsigned map_idx =3D offset / NVME_CTRL_PAGE_SIZE;
> +       int length =3D blk_rq_payload_bytes(req) +
> +                    (offset & (NVME_CTRL_PAGE_SIZE - 1));
> +
> +       dma_dir =3D rq_data_dir(req) =3D=3D READ ? DMA_FROM_DEVICE : DMA_=
TO_DEVICE;
> +
> +       while (length > 0) {
> +               dma_sync_single_for_cpu(dev, dma_list[map_idx++],
> +                                       NVME_CTRL_PAGE_SIZE, dma_dir);
> +               length -=3D NVME_CTRL_PAGE_SIZE;
> +       }
> +}
> +
> +static void nvme_dmabuf_map_sync_for_device(struct nvme_dev *nvme_dev,
> +                                           struct request *req)
> +{
> +       struct device *dev =3D nvme_dev->dev;
> +       enum dma_data_direction dma_dir;
> +       struct bio *bio =3D req->bio;
> +       struct nvme_dmabuf_map *map =3D to_nvme_dmabuf_map(bio->bi_dmabuf=
_map);
> +       dma_addr_t *dma_list =3D map->dma_list;
> +       unsigned offset =3D bio->bi_iter.bi_offset;
> +       unsigned map_idx =3D offset / NVME_CTRL_PAGE_SIZE;
> +       int length =3D blk_rq_payload_bytes(req) +
> +                    (offset & (NVME_CTRL_PAGE_SIZE - 1));
> +
> +       dma_dir =3D rq_data_dir(req) =3D=3D READ ? DMA_FROM_DEVICE : DMA_=
TO_DEVICE;
> +
> +       while (length > 0) {
> +               dma_sync_single_for_device(dev, dma_list[map_idx++],
> +                                          NVME_CTRL_PAGE_SIZE, dma_dir);
> +               length -=3D NVME_CTRL_PAGE_SIZE;
> +       }
> +}
> +
> +static void nvme_rq_clean_dmabuf_map(struct nvme_dev *dev,
> +                                     struct request *req)
> +{
> +       struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> +
> +       nvme_dmabuf_map_sync_for_cpu(dev, req);
> +
> +       if (!(iod->flags & IOD_SINGLE_SEGMENT))
> +               nvme_free_descriptors(req);
> +}
> +
> +static blk_status_t nvme_rq_setup_dmabuf_map(struct request *req,
> +                                            struct nvme_queue *nvmeq)
> +{
> +       struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> +       struct bio *bio =3D req->bio;
> +       struct nvme_dmabuf_map *map =3D to_nvme_dmabuf_map(bio->bi_dmabuf=
_map);
> +       unsigned bvec_done =3D bio->bi_iter.bi_offset;
> +       unsigned map_idx =3D bvec_done / NVME_CTRL_PAGE_SIZE;
> +       unsigned offset =3D bvec_done & (NVME_CTRL_PAGE_SIZE - 1);
> +       int length =3D blk_rq_payload_bytes(req) - (NVME_CTRL_PAGE_SIZE -=
 offset);
> +       dma_addr_t *dma_list =3D map->dma_list;
> +       u64 prp1_dma =3D dma_list[map_idx++] + offset;
> +       u64 dma_addr, prp2_dma;
> +       dma_addr_t prp_dma;
> +       __le64 *prp_list;
> +       unsigned i;
> +
> +       nvme_dmabuf_map_sync_for_device(nvmeq->dev, req);
> +
> +       if (length <=3D 0) {
> +               prp2_dma =3D 0;
> +               goto done;
> +       }
> +
> +       if (length <=3D NVME_CTRL_PAGE_SIZE) {
> +               prp2_dma =3D dma_list[map_idx];
> +               goto done;
> +       }
> +
> +       if (DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE) <=3D
> +           NVME_SMALL_POOL_SIZE / sizeof(__le64))
> +               iod->flags |=3D IOD_SMALL_DESCRIPTOR;
> +
> +       prp_list =3D dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC=
,
> +                       &prp_dma);

I wonder if it's possible to perform the PRP list page allocations and
initialization in nvme_dma_buf_io_map() instead of the I/O path. The
NVMe dma_pools are per-NUMA-node linked lists protected by spinlocks,
making them significant CPU hotspots. If the dmabuf registration set
up a contiguous DMA-coherent list of PRP entries for the pages of the
registered buffer, any command using the dmabuf and requiring at most
1 PRP list page (i.e. length <=3D 2 MB) could just set its PRP list
pointer to an offset into the dmabuf's PRP list.

Best,
Caleb


> +       if (!prp_list)
> +               return BLK_STS_RESOURCE;
> +
> +       iod->descriptors[iod->nr_descriptors++] =3D prp_list;
> +       prp2_dma =3D prp_dma;
> +       i =3D 0;
> +       for (;;) {
> +               if (i =3D=3D NVME_CTRL_PAGE_SIZE >> 3) {
> +                       __le64 *old_prp_list =3D prp_list;
> +
> +                       prp_list =3D dma_pool_alloc(nvmeq->descriptor_poo=
ls.large,
> +                                       GFP_ATOMIC, &prp_dma);
> +                       if (!prp_list)
> +                               goto free_prps;
> +                       iod->descriptors[iod->nr_descriptors++] =3D prp_l=
ist;
> +                       prp_list[0] =3D old_prp_list[i - 1];
> +                       old_prp_list[i - 1] =3D cpu_to_le64(prp_dma);
> +                       i =3D 1;
> +               }
> +
> +               dma_addr =3D dma_list[map_idx++];
> +               prp_list[i++] =3D cpu_to_le64(dma_addr);
> +
> +               length -=3D NVME_CTRL_PAGE_SIZE;
> +               if (length <=3D 0)
> +                       break;
> +       }
> +done:
> +       iod->cmd.common.dptr.prp1 =3D cpu_to_le64(prp1_dma);
> +       iod->cmd.common.dptr.prp2 =3D cpu_to_le64(prp2_dma);
> +       return BLK_STS_OK;
> +free_prps:
> +       nvme_free_descriptors(req);
> +       return BLK_STS_RESOURCE;
> +}
> +
>  static void nvme_free_prps(struct request *req, unsigned int attrs)
>  {
>         struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
> @@ -937,6 +1078,11 @@ static void nvme_unmap_data(struct request *req)
>         struct device *dma_dev =3D nvmeq->dev->dev;
>         unsigned int attrs =3D 0;
>
> +       if (blk_mq_rq_is_dmabuf(req)) {
> +               nvme_rq_clean_dmabuf_map(nvmeq->dev, req);
> +               return;
> +       }
> +
>         if (iod->flags & IOD_SINGLE_SEGMENT) {
>                 static_assert(offsetof(union nvme_data_ptr, prp1) =3D=3D
>                                 offsetof(union nvme_data_ptr, sgl.addr));
> @@ -1251,6 +1397,9 @@ static blk_status_t nvme_map_data(struct request *r=
eq)
>         struct blk_dma_iter iter;
>         blk_status_t ret;
>
> +       if (blk_mq_rq_is_dmabuf(req))
> +               return nvme_rq_setup_dmabuf_map(req, nvmeq);
> +
>         /*
>          * Try to skip the DMA iterator for single segment requests, as t=
hat
>          * significantly improves performances for small I/O sizes.
> @@ -2269,6 +2418,112 @@ static int nvme_create_queue(struct nvme_queue *n=
vmeq, int qid, bool polled)
>         return result;
>  }
>
> +#if defined(CONFIG_DMA_SHARED_BUFFER)
> +static void nvme_dmabuf_invalidate_mappings(struct dma_buf_attachment *a=
ttach)
> +{
> +       struct dma_buf_io_ctx *ctx =3D attach->importer_priv;
> +
> +       dma_buf_io_invalidate_mappings(ctx);
> +}
> +
> +const struct dma_buf_attach_ops nvme_dmabuf_importer_ops =3D {
> +       .invalidate_mappings    =3D nvme_dmabuf_invalidate_mappings,
> +       .allow_peer2peer        =3D true,
> +};
> +
> +static struct dma_buf_io_map *nvme_dma_buf_io_map(struct dma_buf_io_ctx =
*ctx)
> +{
> +       unsigned nr_entries =3D ctx->dmabuf->size / NVME_CTRL_PAGE_SIZE;
> +       struct dma_buf_attachment *attach =3D ctx->dev_priv;
> +       unsigned long tmp, i =3D 0;
> +       struct nvme_dmabuf_map *map;
> +       struct scatterlist *sg;
> +       struct sg_table *sgt;
> +       int ret;
> +
> +       dma_resv_assert_held(ctx->dmabuf->resv);
> +
> +       map =3D kmalloc_flex(*map, dma_list, nr_entries);
> +       if (!map)
> +               return ERR_PTR(-ENOMEM);
> +
> +       sgt =3D dma_buf_map_attachment(attach, ctx->dir);
> +       if (IS_ERR(sgt)) {
> +               ret =3D PTR_ERR(sgt);
> +               sgt =3D NULL;
> +               goto err;
> +       }
> +
> +       for_each_sgtable_dma_sg(sgt, sg, tmp) {
> +               dma_addr_t dma_addr =3D sg_dma_address(sg);
> +               unsigned long sg_len =3D sg_dma_len(sg);
> +
> +               if (sg_len % NVME_CTRL_PAGE_SIZE) {
> +                       ret =3D -EINVAL;
> +                       goto err;
> +               }
> +
> +               while (sg_len) {
> +                       map->dma_list[i++] =3D dma_addr;
> +                       dma_addr +=3D NVME_CTRL_PAGE_SIZE;
> +                       sg_len -=3D NVME_CTRL_PAGE_SIZE;
> +               }
> +       }
> +
> +       ret =3D dma_buf_io_init_map(ctx, &map->base);
> +       if (ret)
> +               goto err;
> +       map->nr_entries =3D nr_entries;
> +       map->sgt =3D sgt;
> +       return &map->base;
> +err:
> +       if (sgt)
> +               dma_buf_unmap_attachment(attach, sgt, ctx->dir);
> +       kfree(map);
> +       return ERR_PTR(ret);
> +}
> +
> +static void nvme_dma_buf_io_unmap(struct dma_buf_io_ctx *ctx,
> +                                 struct dma_buf_io_map *map_base)
> +{
> +       struct dma_buf_attachment *attach =3D ctx->dev_priv;
> +       struct nvme_dmabuf_map *map =3D to_nvme_dmabuf_map(map_base);
> +
> +       dma_resv_assert_held(ctx->dmabuf->resv);
> +
> +       dma_buf_unmap_attachment(attach, map->sgt, ctx->dir);
> +}
> +
> +static void nvme_dma_buf_io_release(struct dma_buf_io_ctx *ctx)
> +{
> +       struct dma_buf_attachment *attach =3D ctx->dev_priv;
> +
> +       dma_buf_detach(ctx->dmabuf, attach);
> +}
> +
> +const struct dma_buf_io_ops nvme_dma_buf_io_ops =3D {
> +       .map            =3D nvme_dma_buf_io_map,
> +       .unmap          =3D nvme_dma_buf_io_unmap,
> +       .release        =3D nvme_dma_buf_io_release,
> +};
> +
> +static int nvme_pci_init_dma_buf_io_ctx(struct nvme_ctrl *ctrl,
> +                                       struct dma_buf_io_ctx *ctx)
> +{
> +       struct dma_buf_attachment *attach;
> +       struct nvme_dev *dev =3D to_nvme_dev(ctrl);
> +
> +       attach =3D dma_buf_dynamic_attach(ctx->dmabuf, dev->dev,
> +                                       &nvme_dmabuf_importer_ops, ctx);
> +       if (IS_ERR(attach))
> +               return PTR_ERR(attach);
> +
> +       ctx->dev_priv =3D attach;
> +       ctx->dev_ops =3D &nvme_dma_buf_io_ops;
> +       return 0;
> +}
> +#endif
> +
>  static const struct blk_mq_ops nvme_mq_admin_ops =3D {
>         .queue_rq       =3D nvme_queue_rq,
>         .complete       =3D nvme_pci_complete_rq,
> @@ -3563,6 +3818,9 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops=
 =3D {
>         .print_device_info      =3D nvme_pci_print_device_info,
>         .supports_pci_p2pdma    =3D nvme_pci_supports_pci_p2pdma,
>         .get_virt_boundary      =3D nvme_pci_get_virt_boundary,
> +#if defined(CONFIG_DMA_SHARED_BUFFER)
> +       .init_dma_buf_io_ctx    =3D nvme_pci_init_dma_buf_io_ctx,
> +#endif
>  };
>
>  static int nvme_dev_map(struct nvme_dev *dev)
> @@ -4327,5 +4585,6 @@ MODULE_AUTHOR("Matthew Wilcox <willy@linux.intel.co=
m>");
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION("1.0");
>  MODULE_DESCRIPTION("NVMe host PCIe transport driver");
> +MODULE_IMPORT_NS("DMA_BUF");
>  module_init(nvme_init);
>  module_exit(nvme_exit);
> --
> 2.54.0
>
>

