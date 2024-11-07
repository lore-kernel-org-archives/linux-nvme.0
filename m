Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1922AD5D680
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 17:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PdE4ykKNJSNlV1pRPYoOXM/Kn1pAZdReh7vgzLa8+BU=; b=wPtOBRRRzx+1icIKIBaVt2sz0z
	qG7DVxPSRYn14QXEtfHqC+8W55qdIMqdWPuO9zVxp3hfS3SBNLjvLArPQDpg7BbnqgyXyt+RIgJlx
	GOgt9xQtTCD7dmQPoy4qOBoOEQk1pL+mFhYz0LreEwda+CV4EPXgiVCeWpQY7CV3TWSXtDHZveFH7
	AjQ4Eld0lLjWWB3VUsFuRN6gOKGemrn/dhdLt+eNmw+KGEv4QbOtoStf/kGw37doHkmb4zkuz/jFl
	3qd2hgIG0Nf5iCbxfNOR4aWgkPEvjY4DBaFOdJtrwazMyVW90aW/UkufvqfYPPMPicWVLEcfyjkMn
	xa6EKF8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t96Rf-00000007pod-2Enc;
	Thu, 07 Nov 2024 17:37:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t96Qo-00000007pe0-02nM
	for linux-nvme@bombadil.infradead.org;
	Thu, 07 Nov 2024 17:36:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Subject:References:In-Reply-To:Message-ID:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=PdE4ykKNJSNlV1pRPYoOXM/Kn1pAZdReh7vgzLa8+BU=; b=RvmeUx9TxCZSS/Hro8b4HPkPM3
	WvZkXTAxdpW0/QAwqB4vv61h5EXiVKi3QV1ebZ4uzkZWpBrYZeaR+ID1lVbcusR5jSByAXKqKRp5O
	A0buT82htkq2EibfbMX1oYbThGy+WJAO+8L9R4k1mBQPeGEaLGNI3EiTl5R+L7C3vaYl5d539uwKk
	RymoUzEu5WXC4GXkUt5CO5z2XfNvGc4GVuRUzAoiUCyhzfBhULXIH99nmOpwYGMpQ/87axb8fdvKy
	W5G23VkJKEjP0CcEn+7YQhFaXfQgUz+gl5VvO6IwgcP2/3M4hwV3OFxauTxngd9ZT/IM7nfkDbKc4
	FFWZauGQ==;
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t96Qj-0000000CBDq-1JTm
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 17:36:27 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1731000973; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=WswQFc65ea2XwcO+AzVo7CwOc9qlyRNM963ccb0A6zeXtQ4+FNoaSFHEkxfSNsTPw04yZ7qSo45zMJS5njVK2muHQa+ddD0Enej3Q7UfBl7M8VwosfBNJ4lZjHjTm0Xfii/8eWGq7nFbp6sD5IqJ7i/IQBryv/Kw5ATUmjR0I8A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1731000973; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=PdE4ykKNJSNlV1pRPYoOXM/Kn1pAZdReh7vgzLa8+BU=; 
	b=UE1e02WMQxXDaqrR6m9KRuV2f68nAPYVMOfJUYCOL33+gnn3O7Uh/LKc+yZ6kuba9IVihW0tAQjQjoBhr0nD2ESOHEEwu9V/FcfzGSzftnBoeXDPYkRNCQrtE2HfAFwpOq8DkhgVeKVpgAFFuSFk3y8xVEU32Xq8VIBc3wlBjcU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=bob.beckett@collabora.com;
	dmarc=pass header.from=<bob.beckett@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1731000973;
	s=zohomail; d=collabora.com; i=bob.beckett@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=PdE4ykKNJSNlV1pRPYoOXM/Kn1pAZdReh7vgzLa8+BU=;
	b=E8dRmb2p7qs43YSwYmzCW9k9mjTDeR6gL7jee+5btXiB2ITC3VGzQbdagqYYBh8z
	ra1xSbRavbSf0At/dCtBLa8inkl7+7E8PliQePOt/HY07nYo+1UrX5hgq6D8A0lMen8
	W03+cHA5NKJxix1Mra6Oa54ctb1nVmru1sMqW4po=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1731000942359211.08673613865676; Thu, 7 Nov 2024 09:35:42 -0800 (PST)
Date: Thu, 07 Nov 2024 17:35:42 +0000
From: Robert Beckett <bob.beckett@collabora.com>
To: "Keith Busch" <kbusch@kernel.org>
Cc: "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
	"Sagi Grimberg" <sagi@grimberg.me>, "kernel" <kernel@collabora.com>,
	"linux-nvme" <linux-nvme@lists.infradead.org>,
	"linux-kernel" <linux-kernel@vger.kernel.org>
Message-ID: <19307b23f01.fcb555461012595.2202335253480073101@collabora.com>
In-Reply-To: <Zyz2oiQ2pco15HHT@kbusch-mbp>
References: <ZyE0kYvRZbek7H_g@kbusch-mbp.dhcp.thefacebook.com>
 <20241107165131.3462171-1-bob.beckett@collabora.com> <Zyz2oiQ2pco15HHT@kbusch-mbp>
Subject: Re: [PATCH] nvme-pci: 512 byte dma pool segment quirk
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241107_173625_733250_80049EA8 
X-CRM114-Status: GOOD (  17.64  )
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



 ---- On Thu, 07 Nov 2024 17:19:30 +0000  Keith Busch  wrote ---=20
 > On Thu, Nov 07, 2024 at 04:50:46PM +0000, Bob Beckett wrote:
 > > @@ -611,7 +612,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvm=
e_dev *dev,
 > >  =C2=A0=C2=A0=C2=A0=C2=A0}
 > > =20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0nprps =3D DIV_ROUND_UP(length, NVME_CTRL_PAGE=
_SIZE);
 > > -=C2=A0=C2=A0=C2=A0=C2=A0if (nprps <=3D (256 / 8)) {
 > > +=C2=A0=C2=A0=C2=A0=C2=A0if (nprps small_dmapool_seg_size / 8)) {
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pool =3D dev->prp_sma=
ll_pool;
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0iod->nr_allocations =
=3D 0;
 > >  =C2=A0=C2=A0=C2=A0=C2=A0} else {
 >=20
 > We have a constant expression currently, and this is changing it a full
 > division in the IO path. :(

yeah, that's fair. Does it get high enough throughput that this is a signif=
icant issue here? (I have little intuition for this driver).
how about pre-computing the nprps threshold during pool creation where we d=
etect the quirk, it would then be variable comparison instead of a const co=
mparison, but no divide?

 >=20
 > Could we leave the pool selection check size as-is and just say the cost
 > of the quirk is additional memory overhead?
 >=20
 > > @@ -2700,8 +2701,9 @@ static int nvme_setup_prp_pools(struct nvme_dev =
*dev)
 > >  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
 > > =20
 > >  =C2=A0=C2=A0=C2=A0=C2=A0/* Optimisation for I/Os between 4k and 128k =
*/
 > > -=C2=A0=C2=A0=C2=A0=C2=A0dev->prp_small_pool =3D dma_pool_create("prp =
list 256", dev->dev,
 > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
256, 256, 0);
 > > +=C2=A0=C2=A0=C2=A0=C2=A0dev->prp_small_pool =3D dma_pool_create("prp =
list small", dev->dev,
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dev->small_dmapool_seg_size,
 > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
dev->small_dmapool_seg_size, 0);
 >=20
 > I think it should work if we only change the alignment property of the
 > pool. Something like this:
 >=20
 > =C2=A0=C2=A0=C2=A0=C2=A0if (dev->ctrl.quirks & NVME_QUIRK_SMALL_DMAPOOL_=
512)
 > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->prp_small_pool =3D =
dma_pool_create("prp list 256", dev->dev,
 > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0   =
   256, 512, 0);

I actually already tested a change of 512, 512 while keeping the 256 devisi=
on above during testing (i.e. waste half of the segment). I'll confirm with=
 a test again against latest and send a v2 assuming it tests fine.

 > =C2=A0=C2=A0=C2=A0=C2=A0else
 > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev->prp_small_pool =3D =
dma_pool_create("prp list 256", dev->dev,
 > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0   =
   256, 256, 0);
 >=20


