Return-Path: <SRS0=neNW=HY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF47C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 19:05:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 948F864DCF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Feb 2021 19:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 948F864DCF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Date:To:From:Subject:Message-ID:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=WEj0rU/JR+HDB3ulYiVWXsBKFRXRMcPQw0Y1pidZ1p0=; b=IxnyUf31ZYfJUzIBYSqNzb1Y6
	k1/BShadIAHsbcAEaXh95QYRzLhbF/j2uzHcyF0u2QVS779VoCb9hfcwkvwdwlzjsr3ecrtFpM/if
	XHtSkXgb7hoKT/EdMj+TAi6/LslqkJYyctlSN71sYpTHPvzZOUysn9imbjkXzsAHA82J8LYgYl0My
	Sxkvy77q7VLfKpG58tIMtv/Frj0ldZaR5D+jChTcLhaX8dLSwtNupnw2cC976jCMx1JYS5ARYrvCI
	nq2Ma2TV8OYdsQfZ+hls0TkKraIDM8HwYqs/vBa5XbO+1F1QAK1T/fIpQaPxuTOYUaPhPGZPfH5vD
	Dr18BUBvg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lEGWc-0006kO-Ss; Mon, 22 Feb 2021 19:05:42 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEGWZ-0006jV-DQ
 for linux-nvme@lists.infradead.org; Mon, 22 Feb 2021 19:05:40 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 315BDADE3;
 Mon, 22 Feb 2021 19:05:38 +0000 (UTC)
Message-ID: <70edceb03e4bf283072397f9563dfc4162aec92a.camel@suse.de>
Subject: Re: [PATCH 6/9] swiotlb: refactor swiotlb_tbl_map_single
From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To: Christoph Hellwig <hch@lst.de>, jxgao@google.com, 
 gregkh@linuxfoundation.org
Date: Mon, 22 Feb 2021 20:05:36 +0100
In-Reply-To: <20210207160327.2955490-7-hch@lst.de>
References: <20210207160327.2955490-1-hch@lst.de>
 <20210207160327.2955490-7-hch@lst.de>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210222_140539_736895_5E46C5D9 
X-CRM114-Status: GOOD (  23.73  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: saravanak@google.com, konrad.wilk@oracle.com, marcorr@google.com,
 linux-nvme@lists.infradead.org, iommu@lists.linux-foundation.org,
 kbusch@kernel.org, robin.murphy@arm.com
Content-Type: multipart/mixed; boundary="===============6653585434664837790=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


--===============6653585434664837790==
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-0N6/MlCWp/kYePTqUFa5"


--=-0N6/MlCWp/kYePTqUFa5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Sun, 2021-02-07 at 17:03 +0100, Christoph Hellwig wrote:
> Split out a bunch of a self-contained helpers to make the function easier
> to follow.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> =C2=A0kernel/dma/swiotlb.c | 179 +++++++++++++++++++++-------------------=
---
> =C2=A01 file changed, 89 insertions(+), 90 deletions(-)
>=20
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b38b1553c4663a..381c24ef1ac1d0 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -468,134 +468,133 @@ static void swiotlb_bounce(phys_addr_t orig_addr,=
 phys_addr_t tlb_addr,
> =C2=A0	}
> =C2=A0}
> =C2=A0
>=20
> -phys_addr_t swiotlb_tbl_map_single(struct device *hwdev, phys_addr_t ori=
g_addr,
> -		size_t mapping_size, size_t alloc_size,
> -		enum dma_data_direction dir, unsigned long attrs)
> -{
> -	dma_addr_t tbl_dma_addr =3D phys_to_dma_unencrypted(hwdev, io_tlb_start=
);
> -	unsigned long flags;
> -	phys_addr_t tlb_addr;
> -	unsigned int nslots, stride, index, wrap;
> -	int i;
> -	unsigned long mask;
> -	unsigned long offset_slots;
> -	unsigned long max_slots;
> -	unsigned long tmp_io_tlb_used;
> -
> -	if (no_iotlb_memory)
> -		panic("Can not allocate SWIOTLB buffer earlier and can't now provide y=
ou with the DMA bounce buffer");
> -
> -	if (mem_encrypt_active())
> -		pr_warn_once("Memory encryption is active and system is using DMA boun=
ce buffers\n");
> +#define slot_addr(start, idx)	((start) + ((idx) << IO_TLB_SHIFT))
> =C2=A0
>=20
> -	if (mapping_size > alloc_size) {
> -		dev_warn_once(hwdev, "Invalid sizes (mapping: %zd bytes, alloc: %zd by=
tes)",
> -			      mapping_size, alloc_size);
> -		return (phys_addr_t)DMA_MAPPING_ERROR;
> -	}
> -
> -	mask =3D dma_get_seg_boundary(hwdev);
> +/*
> + * Carefully handle integer overflow which can occur when boundary_mask =
=3D=3D ~0UL.
> + */
> +static inline unsigned long get_max_slots(unsigned long boundary_mask)
> +{
> +	if (boundary_mask =3D=3D ~0UL)
> +		return 1UL << (BITS_PER_LONG - IO_TLB_SHIFT);
> +	return nr_slots(boundary_mask + 1);
> +}
> =C2=A0
>=20
> -	tbl_dma_addr &=3D mask;
> +static unsigned int wrap_index(unsigned int index)
> +{
> +	if (index >=3D io_tlb_nslabs)
> +		return 0;
> +	return index;
> +}
> =C2=A0
>=20
> -	offset_slots =3D nr_slots(tbl_dma_addr);
> +/*
> + * Find a suitable number of IO TLB entries size that will fit this requ=
est and
> + * allocate a buffer from that IO TLB pool.
> + */
> +static int find_slots(struct device *dev, size_t alloc_size)
> +{
> +	unsigned long boundary_mask =3D dma_get_seg_boundary(dev);
> +	dma_addr_t tbl_dma_addr =3D
> +		phys_to_dma_unencrypted(dev, io_tlb_start) & boundary_mask;
> +	unsigned int max_slots =3D get_max_slots(boundary_mask);

'max_slots' should be 'unsigned long' here. Breaks SWIOTLB on RPi4. Do you =
want
me to send a fix or you prefer editing the patch?

Regards,
Nicolas


--=-0N6/MlCWp/kYePTqUFa5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAmA0AIAACgkQlfZmHno8
x/7nOwf8DHHip4IbMdYG8YJXxkxViw5qANwPZ+jyR0H4ngQmL/lbyFjmFteQu55c
gsG38mNa2K5EgaQywdwZXAvLF9a0CMNj9J76TDgHTTY5y79ioMnVRj9atp+57p9F
dOSa/Bq61L0Z31hhk0/oeKNtzyIVEFxZArJ+8FGIOfeik2ju6ZSJYEbDtSxvqnF5
ek4cLGYuehwHMojnMdbIPYH261AQdqqFofATdJtd/cDLqiSQeb70vJQo6Q0Hwfeb
0LnanDYcrxMGmmSahbrx+PcWUbA45RHNI0GBBz/rGp/KFyucbI+/aGNVoDPSbGGx
KRlIjSbuujswuLD1TJ1kJlDZGcCNog==
=lXJX
-----END PGP SIGNATURE-----

--=-0N6/MlCWp/kYePTqUFa5--



--===============6653585434664837790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============6653585434664837790==--


