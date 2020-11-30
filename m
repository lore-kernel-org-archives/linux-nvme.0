Return-Path: <SRS0=wRjJ=FE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43538C64E7B
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 16:40:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B0A1206F9
	for <linux-nvme@archiver.kernel.org>; Mon, 30 Nov 2020 16:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fBwv58eS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNDTOle6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B0A1206F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ozZRDca54bLLGnx/YzNJ3eZsWxaiM2F4CExJHUgwCmI=; b=fBwv58eSeZWtbM3kUcfCNIxy4
	kU2wtr8WcUnss11200EaYdzEMVTgC+VvudWm5YxFQbe4CwYQNGvHHMGtScY4Tk1hUQAMoomnccDA9
	iE0e762UjC7oK9Ijt+xkNpUziwEKUObkzxRk5j7sEn9IFkuq+MvT5Mnp0Ip59E+SAkpKzDxtEFJAv
	ryGqFkgM1W1RMpOUdhm1bMr+pWvUoY7EyIB+WkLJx8/vjT05j9m9UhOs4/m173KQzdd7/6VY1bTfX
	tFbENF4VO4AZIeCKgiHBSrQR8fi1oKc7okrjlzUqhx89qLWh8K1djuiTur0AyRvwR4jF2JXkC+2lB
	6UdhML/UQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kjmDs-0004WL-9R; Mon, 30 Nov 2020 16:40:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kjmDq-0004Vd-Um
 for linux-nvme@lists.infradead.org; Mon, 30 Nov 2020 16:40:19 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [129.253.182.57])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3B0952074A;
 Mon, 30 Nov 2020 16:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1606754416;
 bh=9jkCQZjewNqd1lr7kYUudvcgNnJUD3NU3Ulgfx5DngM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lNDTOle6R5NWpfS79yPF28GwOXK7inRJvmcUWNs1Td+hhC9+dyzQLB9wvIkZDDpxF
 cIdqQNP/Dm9p9Zcvg9oqN4YwYfnDkfBMRq1fgAVnZyb8LGcc2D7AczR5x726SOmwVH
 jynTCmVWTL01JiPS7rBBbbVp1lKzkdgjIrE4azrI=
Date: Tue, 1 Dec 2020 01:40:10 +0900
From: Keith Busch <kbusch@kernel.org>
To: Marek =?iso-8859-1?Q?Marczykowski-G=F3recki?=
 <marmarek@invisiblethingslab.com>
Subject: Re: GPF on 0xdead000000000100 in nvme_map_data - Linux 5.9.9
Message-ID: <20201130164010.GA23494@redsun51.ssa.fujisawa.hgst.com>
References: <20201129035639.GW2532@mail-itl>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201129035639.GW2532@mail-itl>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201130_114019_110303_BDD09A7C 
X-CRM114-Status: GOOD (  17.34  )
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
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Nov 29, 2020 at 04:56:39AM +0100, Marek Marczykowski-G=F3recki wrot=
e:
> I can reliably hit kernel panic in nvme_map_data() which looks like the
> one below. It happens on Linux 5.9.9, while 5.4.75 works fine. I haven't
> tried other version on this hardware. Linux is running as Xen
> PV dom0, on top of nvme there is LUKS and then LVM with thin
> provisioning. The crash happens reliably when starting a Xen domU (which
> uses one of thin provisioned LVM volumes as its disk). But booting dom0
> works fine (even though it is using the same disk setup for its root
> filesystem).
> =

> I did a bit of debugging and found it's about this part:
> =

> drivers/nvme/host/pci.c:
>  800 static blk_status_t nvme_map_data(struct nvme_dev *dev, struct reque=
st *req,
>  801         struct nvme_command *cmnd)
>  802 {
>  803     struct nvme_iod *iod =3D blk_mq_rq_to_pdu(req);
>  804     blk_status_t ret =3D BLK_STS_RESOURCE;
>  805     int nr_mapped;
>  806 =

>  807     if (blk_rq_nr_phys_segments(req) =3D=3D 1) {
>  808         struct bio_vec bv =3D req_bvec(req);
>  809 =

>  810         if (!is_pci_p2pdma_page(bv.bv_page)) {
> =

> Here, bv.bv_page->pgmap is LIST_POISON1, while page_zonenum(bv.bv_page)
> says ZONE_DEVICE. So, is_pci_p2pdma_page() crashes on accessing
> bv.bv_page->pgmap->type.

Something sounds off. I thought all ZONE_DEVICE pages require a pgmap
because that's what holds a references to the device's live-ness. What
are you allocating this memory from that makes ZONE_DEVICE true without
a pgmap?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
