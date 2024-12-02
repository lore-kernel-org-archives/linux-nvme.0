Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B937FE69E81
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 19:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KsKjA06IoAvdN+CUxD7FgE0Zh9ivSMTponT7Lds4ToU=; b=D/JQEnwa7PbA+oNy7aqWnOlYuL
	Lwt8+ec9G3UpCWqec8N4FTYAD9XVtFG97lV1S47urX+mmFz0nfP59hBLIYSm19m6rzWtNJritmatF
	S1pF6iA1OXl9EbQOpmgjFu84Sb3aUNCpir1KXG9dAYfq7jvkrOcVT2UiR4qIyfWSNOzC+c1EOc4c+
	Dyn5ieUtkbZt5uuOnLKoJBo+zGyaTVkUfL4H+pTquOh4uRyf93DjuHV+Dg1mXxuvJy3dPF58vnEgc
	C0ozFEspYimmgQwRsJhm0/0xKFcA1Ll0Di3HL8jZIGTmIbtUXnLZdhfVu8vxnVfEjwoUeoJBAyANm
	Toonx++A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIBk3-00000007F6a-1Amk;
	Mon, 02 Dec 2024 19:05:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIBk1-00000007F6Q-3HgN
	for linux-nvme@bombadil.infradead.org;
	Mon, 02 Dec 2024 19:05:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=KsKjA06IoAvdN+CUxD7FgE0Zh9ivSMTponT7Lds4ToU=; b=Ta7TvPlOFaDL4aH+UUWkBN9S/I
	OJRJDXt/Vzcv6B4O/lfi6sNqwQrMXJPBr1wW2Gh6sQkvZTZNi1BnH10LJ8DLnqLDzZy6ScyfGzYnN
	6C+IFGBL104jS7plR4AKzAQms31VNf58yr9Q307CgqErDtLXCZM8OHO2h7Cu5n2HEbGa9WgbaDeZQ
	2qhF2kwzHUK1z3ForXoHBUrAz5HjvM8k7hwNm8rCBWKspQMpra+8M9uLCJI84cfcLNblGo85wTuzc
	8dorOcF8pFc1kmCRFMipoiizWIsz4zjyZvDCBch7I4ZzLJxaaJKxOmI9622HNMa1nDNSG/HKFvXzD
	PVpHYSfw==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIBjy-00000002Ey7-1idO
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 19:05:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1036E5C6681;
	Mon,  2 Dec 2024 19:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CC0EC4CED6;
	Mon,  2 Dec 2024 19:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733166345;
	bh=2t77hz/nIvSXX7HUEtLIaRDpQ2o6HJ+2VzB98ShmlNo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S0656D+8i84CeELbJzb0vRAIJhzySo3a1aJAUgQ3dD7AI1oyrytOibGXQ8yJSSE0L
	 EFGXu+5j00FjdG3ehAnmyVvqsWwG8MVIn/tCYApujLCR55gDmLX0uuLDGaUFfSOwx/
	 RabS3sMM2exzYRhQaMFf6ixSc46ys24VVN1CONA63WqX+a7AcCt1azi1rSGMt01Yfp
	 VLb5fT72SL9rLoI0AnK8KzRsdorpj/cDWju59iX/nUufIWg0sdBlxfYW+WHp60+gvj
	 JPFNRLlRlxU3L9SdCqRl6qnzkQ7h3KBo77WNpITmeYru52PpyA2qZU0cFnMn5FmSic
	 M/Ae4RRQCza2g==
Date: Mon, 2 Dec 2024 21:05:41 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH 2/2] nvme-pci: use dma_alloc_noncontigous if possible
Message-ID: <20241202190541.GA2434798@unreal>
References: <20241101044016.405265-1-hch@lst.de>
 <20241101044016.405265-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20241101044016.405265-3-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_190550_862821_FE183E01 
X-CRM114-Status: GOOD (  23.38  )
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

On Fri, Nov 01, 2024 at 05:40:05AM +0100, Christoph Hellwig wrote:
> Use dma_alloc_noncontigous to allocate a single IOVA-contigous segment
> when backed by an IOMMU.  This allow to easily use bigger segments and
> avoids running into segment limits if we can avoid it.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/nvme/host/pci.c | 58 +++++++++++++++++++++++++++++++++++++----
>  1 file changed, 53 insertions(+), 5 deletions(-)

<...>

> +static int nvme_alloc_host_mem_multi(struct nvme_dev *dev, u64 preferred,
>  		u32 chunk_size)
>  {
>  	struct nvme_host_mem_buf_desc *descs;
> @@ -2049,9 +2086,18 @@ static int nvme_alloc_host_mem(struct nvme_dev *de=
v, u64 min, u64 preferred)
>  	u64 hmminds =3D max_t(u32, dev->ctrl.hmminds * 4096, PAGE_SIZE * 2);
>  	u64 chunk_size;
> =20
> +	/*
> +	 * If there is an IOMMU that can merge pages, try a virtually
> +	 * non-contiguous allocation for a single segment first.
> +	 */
> +	if (!(PAGE_SIZE & dma_get_merge_boundary(dev->dev))) {
> +		if (!nvme_alloc_host_mem_single(dev, preferred))
> +			return 0;
> +	}

We assume that the addition of the lines above are the root cause of the
following panic during boot. It is happening when we are trying to allocate
61 MiB chunk.

[    4.373307] ------------[ cut here ]------------
[    4.373316] WARNING: CPU: 5 PID: 11 at mm/page_alloc.c:4727 __alloc_page=
s_noprof+0x84c/0xd88
[    4.373332] Modules linked in: crct10dif_ce mlx5_core(+) nvme gpio_mlxbf=
3 nvme_core mlxfw psample i2c_mlxbf pinctrl_mlxbf3 mlxbf_gige mlxbf_tmfifo =
pwr_mlxbf ipv6 crc_ccitt
[    4.373353] CPU: 5 UID: 0 PID: 11 Comm: kworker/u64:0 Not tainted 6.12.0=
-for-upstream-bluefield-2024-11-29-01-33 #1
[    4.373357] Hardware name: https://www.mellanox.com BlueField-3 SmartNIC=
 Main Card/BlueField-3 SmartNIC Main Card, BIOS 4.9.0.13378 Oct 30 2024
[    4.373360] Workqueue: async async_run_entry_fn
[    4.373365] pstate: 20400009 (nzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[    4.373368] pc : __alloc_pages_noprof+0x84c/0xd88
[    4.373371] lr : __dma_direct_alloc_pages.constprop.0+0x234/0x358
[    4.373377] sp : ffffffc08011b890
[    4.373378] x29: ffffffc08011b890 x28: 000000000000000e x27: 0000000003d=
00000
[    4.373382] x26: ffffff80803cb840 x25: ffffff808197a0c8 x24: 00000000000=
0000e
[    4.373385] x23: 0000000000000cc1 x22: 00000000ffffffff x21: 0000000003c=
fffff
[    4.373388] x20: 0000000000000000 x19: ffffffffffffffff x18: 00000000000=
00100
[    4.373391] x17: 0030737973627573 x16: ffffffd634e9d488 x15: 00000000000=
03a98
[    4.373394] x14: 0000000013ffffff x13: ffffffd636c18d88 x12: 00000000000=
00001
[    4.373396] x11: 0000000104ab200c x10: f56b3ce21ad3b435 x9 : ffffffd634e=
9ecbc
[    4.373399] x8 : ffffff808647ba80 x7 : ffffffffffffffff x6 : 00000000000=
00cc0
[    4.373402] x5 : 0000000000000000 x4 : ffffff80809b9140 x3 : 00000000000=
00000
[    4.373405] x2 : 0000000000000000 x1 : 0000000000000001 x0 : ffffffd636e=
5d000
[    4.373408] Call trace:
[    4.373410]  __alloc_pages_noprof+0x84c/0xd88 (P)
[    4.373414]  __dma_direct_alloc_pages.constprop.0+0x234/0x358 (L)
[    4.373418]  __dma_direct_alloc_pages.constprop.0+0x234/0x358
[    4.373421]  dma_direct_alloc_pages+0x40/0x190
[    4.373424]  __dma_alloc_pages+0x40/0x80
[    4.373428]  dma_alloc_noncontiguous+0xb4/0x218
[    4.373431]  nvme_setup_host_mem+0x370/0x400 [nvme]
[    4.373442]  nvme_probe+0x688/0x7e8 [nvme]
[    4.373446]  local_pci_probe+0x48/0xb8
[    4.373451]  pci_device_probe+0x1e0/0x200
[    4.373454]  really_probe+0xc8/0x3a0
[    4.373457]  __driver_probe_device+0x84/0x170
[    4.373460]  driver_probe_device+0x44/0x120
[    4.373462]  __driver_attach_async_helper+0x58/0x100
[    4.373465]  async_run_entry_fn+0x40/0x1e8
[    4.373468]  process_one_work+0x16c/0x3e8
[    4.373472]  worker_thread+0x284/0x448
[    4.373476]  kthread+0xec/0xf8
[    4.373479]  ret_from_fork+0x10/0x20
[    4.373483] ---[ end trace 0000000000000000 ]---
[    4.378989] nvme nvme0: allocated 61 MiB host memory buffer (16 segments=
).
[    4.534672] nvme nvme0: 16/0/0 default/read/poll queues
[    4.537784]  nvme0n1: p1 p2

  4715 struct page *__alloc_pages_noprof(gfp_t gfp, unsigned int order,
  4716                                       int preferred_nid, nodemask_t =
*nodemask)
=2E..
  4723         /*
  4724          * There are several places where we assume that the order v=
alue is sane
  4725          * so bail out early if the request is out of bound.
  4726          */
  4727         if (WARN_ON_ONCE_GFP(order > MAX_PAGE_ORDER, gfp))
  4728                 return NULL;

I see at least two possible solutions, add GFP_NOWARN in nvme_alloc_host_me=
m_single()
or the following patch:

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4c644bb7f069..baed4059d8a5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2172,7 +2172,8 @@ static int nvme_alloc_host_mem_multi(struct nvme_dev =
*dev, u64 preferred,

 static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferre=
d)
 {
-       u64 min_chunk =3D min_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PA=
GES);
+       u64 max_chunk =3D PAGE_SIZE * MAX_ORDER_NR_PAGES;
+       u64 min_chunk =3D min_t(u64, preferred, max_chunk);
        u64 hmminds =3D max_t(u32, dev->ctrl.hmminds * 4096, PAGE_SIZE * 2);
        u64 chunk_size;

@@ -2180,7 +2181,7 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, =
u64 min, u64 preferred)
         * If there is an IOMMU that can merge pages, try a virtually
         * non-contiguous allocation for a single segment first.
         */
-       if (!(PAGE_SIZE & dma_get_merge_boundary(dev->dev))) {
+       if (!(PAGE_SIZE & dma_get_merge_boundary(dev->dev)) && preferred < =
max_chunk) {
                if (!nvme_alloc_host_mem_single(dev, preferred))
                        return 0;
        }
(END)

What is the preferred way to overcome the warning?

Thanks

