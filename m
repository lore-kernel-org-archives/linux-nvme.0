Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E76D0C369CB
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Apr 2025 16:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=izolhSLfhzwZrQK7PfhoIMtyHLECubQLEJRViHMUUBg=; b=3QiAUldU1HcJStz32RLwm51Jvu
	tpLPF268SlKBwzUNqNddSbzbogH5SqivgG7eDu3mz6m0YIS1ynAemD0upW0NCW73MPvxsITKEg1sD
	gqcDQVkD9u/rjB9YfLwi6r5rmpPlAVg5TSu3WlKVgOS/MF2iyNb4xG9iuno1EUR3KxviDgNLcsqj7
	McYxxuAyOV20hFJZPaL3r6/YQUhuWodFSahUwSa3Kl/scYe/+uqkzlEA5JDSEf4Av4t6ZvHbs/Q4S
	3zzeC77silJu2kK9Lfu0hWnEcE+15bmEfX5NxHg8n0VF5GfDcOdkiIuXWhw6+s48d8x+eaXDj1N8A
	2rfWzXRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7GYq-00000007vOG-1KF3;
	Tue, 22 Apr 2025 16:33:28 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7F5t-00000007bRU-1qXz
	for linux-nvme@lists.infradead.org;
	Tue, 22 Apr 2025 14:59:31 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-af5f28ecbcaso456817a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 22 Apr 2025 07:59:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1745333968; x=1745938768; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=izolhSLfhzwZrQK7PfhoIMtyHLECubQLEJRViHMUUBg=;
        b=NogrdaiCDyyEc1pt1R5zRi4BK0pn2JhzCLW9NIZIAWmHqvaBbwtEH/gSikUxlIIf6A
         +Ha9/CXgaKXKM2jMT8RjjhIZ/9xrRgQhr7eZg1pMSZ2wLbSFT5ECXrPlwuhc3jf1Rt4V
         cEhj2hqlBxh8MvkHC8Z9sl98qstIfqRciAU0zQuJZB35BG1N9nGNrBCLRm0ydxG6maii
         5lZ7l6RF2vIEDn4HO0gNEyM/pDVja/y9BZqIKlTJVg8dR/IYnMwG9hOuDD/RdTvWlSD3
         ouU5f1XY+GY4Ca6YoFCKPXGrQqERBLkkEZZfjPVCMb0cEebr/3LBmR6zAUu59ISts+g9
         5RKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745333968; x=1745938768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=izolhSLfhzwZrQK7PfhoIMtyHLECubQLEJRViHMUUBg=;
        b=SokFpgFfwjOchaZO1UfC7B1WMRAFU0nCW3vRmKu/15wTEkp6EReL0scgHU6A1yDmae
         aQvcK8Uid98ts7iZs7gCtQo4nDt9KSTcpDpBO61sKl8lWv3UiYpggcAlhXXZDAAI36/L
         ZYcIT4SGOcYs0/xuZ7oOa0bGUlt9edfnynToQaJHFZ2yNjkKMi2n/XGzTFwyZ0xf5sVC
         kDLdyZQAr7OwAhvf3CzY2Ls5MEMVV54lIg2CrQbqFHT0uxYXhXkhFbfFzcob2MiJRlOB
         +hxRAYLAUBWl5A1hxq0//WqlF705Unbne04uVv2xx4IsNGsp8Id/0dLAvdma3CDmXeaz
         6pbA==
X-Forwarded-Encrypted: i=1; AJvYcCXaSsUC1MTpc8MRPqSyILQq/acDx8Fi51VPp+IawyrY5grjGr8xnEXzsd00DHmeKuSqdLzvKXC17mZB@lists.infradead.org
X-Gm-Message-State: AOJu0YxzQ7w4AWtQXTt0IEcHgpA/CtByqCELGbuLJNnkXazorCPEZPX4
	n2hhGxvpbTOl9deLC/XkVFh8azWh6kRk2B+tfBjJXobpKnMK95gLnMwhtItgqAVjxVKB9VnIXgo
	RdCYY4kgrHutGyyjduGT3x1MmNfKuqebba2iVsiL3T0L6JajQ
X-Gm-Gg: ASbGncvRHK7kQiN/MR5ojLiEEGoESf/UPWbqqW1jFTlqJSglutPAj9xJiMz1qcWRBPm
	ixd35giqreow99G6oFYqlGL3kFWU20VZQNM8758G27B1/+J6rPx+OfilGlPQjzthF5PFMr+UqHt
	AThmUtxJbvHbF5cIHnPQD0
X-Google-Smtp-Source: AGHT+IFUBS5IUsBu+10X4ca16j0Ntg3JLwzmjLbsVTHDlU6zPvzWH8OTHReFUT3I2Aj8cS1yr9Q2aEROrGRTkMy2Jnc=
X-Received: by 2002:a17:903:22d1:b0:21f:1365:8bcf with SMTP id
 d9443c01a7336-22c53605b60mr86126535ad.10.1745333968421; Tue, 22 Apr 2025
 07:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250421165525.1618434-1-csander@purestorage.com>
 <20250421165525.1618434-3-csander@purestorage.com> <4cf8af38-419e-4d7c-95f7-7248faf3c7bb@grimberg.me>
In-Reply-To: <4cf8af38-419e-4d7c-95f7-7248faf3c7bb@grimberg.me>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Tue, 22 Apr 2025 07:59:16 -0700
X-Gm-Features: ATxdqUFa7hpMhqNeBArzW1f7_U-MXLOc0R42TakRSbVP4GANnHTXCxIfw7jUpCY
Message-ID: <CADUfDZoJixufDq4wfdtmNpqNOxmByj6Tekw=e-5G_Yc5y5XaBw@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] nvme/pci: make PRP list DMA pools per-NUMA-node
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250422_075929_561191_10A3E8EB 
X-CRM114-Status: GOOD (  30.99  )
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

On Tue, Apr 22, 2025 at 4:48=E2=80=AFAM Sagi Grimberg <sagi@grimberg.me> wr=
ote:
>
>
>
> On 21/04/2025 19:55, Caleb Sander Mateos wrote:
> > NVMe commands with more than 4 KB of data allocate PRP list pages from
> > the per-nvme_device dma_pool prp_page_pool or prp_small_pool. Each call
> > to dma_pool_alloc() and dma_pool_free() takes the per-dma_pool spinlock=
.
> > These device-global spinlocks are a significant source of contention
> > when many CPUs are submitting to the same NVMe devices. On a workload
> > issuing 32 KB reads from 16 CPUs (8 hypertwin pairs) across 2 NUMA node=
s
> > to 23 NVMe devices, we observed 2.4% of CPU time spent in
> > _raw_spin_lock_irqsave called from dma_pool_alloc and dma_pool_free.
> >
> > Ideally, the dma_pools would be per-hctx to minimize
> > contention. But that could impose considerable resource costs in a
> > system with many NVMe devices and CPUs.
> >
> > As a compromise, allocate per-NUMA-node PRP list DMA pools. Map each
> > nvme_queue to the set of DMA pools corresponding to its device and its
> > hctx's NUMA node. This reduces the _raw_spin_lock_irqsave overhead by
> > about half, to 1.2%. Preventing the sharing of PRP list pages across
> > NUMA nodes also makes them cheaper to initialize.
> >
> > Link: https://lore.kernel.org/linux-nvme/CADUfDZqa=3DOOTtTTznXRDmBQo1Wr=
FcDw1hBA7XwM7hzJ-hpckcA@mail.gmail.com/T/#u
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >   drivers/nvme/host/pci.c | 144 +++++++++++++++++++++++----------------=
-
> >   1 file changed, 84 insertions(+), 60 deletions(-)
> >
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 642890ddada5..7d86d1ec989a 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -16,10 +16,11 @@
> >   #include <linux/kstrtox.h>
> >   #include <linux/memremap.h>
> >   #include <linux/mm.h>
> >   #include <linux/module.h>
> >   #include <linux/mutex.h>
> > +#include <linux/nodemask.h>
> >   #include <linux/once.h>
> >   #include <linux/pci.h>
> >   #include <linux/suspend.h>
> >   #include <linux/t10-pi.h>
> >   #include <linux/types.h>
> > @@ -110,21 +111,24 @@ struct nvme_queue;
> >
> >   static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
> >   static void nvme_delete_io_queues(struct nvme_dev *dev);
> >   static void nvme_update_attrs(struct nvme_dev *dev);
> >
> > +struct nvme_prp_dma_pools {
> > +     struct dma_pool *large;
> > +     struct dma_pool *small;
> > +};
> > +
> >   /*
> >    * Represents an NVM Express device.  Each nvme_dev is a PCI function=
.
> >    */
> >   struct nvme_dev {
> >       struct nvme_queue *queues;
> >       struct blk_mq_tag_set tagset;
> >       struct blk_mq_tag_set admin_tagset;
> >       u32 __iomem *dbs;
> >       struct device *dev;
> > -     struct dma_pool *prp_page_pool;
> > -     struct dma_pool *prp_small_pool;
> >       unsigned online_queues;
> >       unsigned max_qid;
> >       unsigned io_queues[HCTX_MAX_TYPES];
> >       unsigned int num_vecs;
> >       u32 q_depth;
> > @@ -160,10 +164,11 @@ struct nvme_dev {
> >       struct nvme_host_mem_buf_desc *host_mem_descs;
> >       void **host_mem_desc_bufs;
> >       unsigned int nr_allocated_queues;
> >       unsigned int nr_write_queues;
> >       unsigned int nr_poll_queues;
> > +     struct nvme_prp_dma_pools prp_pools[];
> >   };
> >
> >   static int io_queue_depth_set(const char *val, const struct kernel_pa=
ram *kp)
> >   {
> >       return param_set_uint_minmax(val, kp, NVME_PCI_MIN_QUEUE_SIZE,
> > @@ -189,10 +194,11 @@ static inline struct nvme_dev *to_nvme_dev(struct=
 nvme_ctrl *ctrl)
> >    * An NVM Express queue.  Each device has at least two (one for admin
> >    * commands and one for I/O commands).
> >    */
> >   struct nvme_queue {
> >       struct nvme_dev *dev;
> > +     struct nvme_prp_dma_pools prp_pools;
> >       spinlock_t sq_lock;
> >       void *sq_cmds;
> >        /* only used for poll queues: */
> >       spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
> >       struct nvme_completion *cqes;
> > @@ -395,18 +401,67 @@ static int nvme_pci_npages_prp(void)
> >       unsigned max_bytes =3D (NVME_MAX_KB_SZ * 1024) + NVME_CTRL_PAGE_S=
IZE;
> >       unsigned nprps =3D DIV_ROUND_UP(max_bytes, NVME_CTRL_PAGE_SIZE);
> >       return DIV_ROUND_UP(8 * nprps, NVME_CTRL_PAGE_SIZE - 8);
> >   }
> >
> > +static struct nvme_prp_dma_pools *
> > +nvme_setup_prp_pools(struct nvme_dev *dev, unsigned numa_node)
> > +{
> > +     struct nvme_prp_dma_pools *prp_pools;
> > +     size_t small_align =3D 256;
> > +
> > +     prp_pools =3D &dev->prp_pools[numa_node < nr_node_ids ? numa_node=
 : 0];
>
> I'm assuming you are checking numa_node =3D=3D NUMA_NO_NODE ?
> Perhaps it is better to check that explicitly?

Yeah, I wasn't sure whether that was a possible value of
hctx->numa_node. The field is defined as an unsigned and NUMA_NO_NODE
is defined as -1, so I guess it shouldn't ever be set to NUMA_NO_NODE?
I can replace this with just numa_node.

Thanks,
Caleb

