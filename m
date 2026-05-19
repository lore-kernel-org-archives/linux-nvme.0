Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 638CECD4F3C
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 19:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JMCmbCNvC+HxXHksRWStC4bWizUWQNjAyE1M9dKurnI=; b=G6t5jnPAnJYso0oBuV/BBvb84u
	Hf9adLUH1f+62I6q2E8zDb/GnEHdhqAPfBIu7TlZNcFj3zDK8aRTp38UeTGcapTKm/E3BWArrxmB+
	ybIVAZZAZmDvKoqzbU3Ai+F8yCEMNn0OJyVE/m1irFUd7extfsfzB5E97JXeUDf4qCi0N2rvZZtvq
	fMctngCfkNP1XA3fNRPSvlmgNhG13TWVwonxnnuRTiP7cGtmSDxcAKu/CwrzuV05JsFmziVE42uSv
	o1pcYtcN6TPbgQQCoyh7CdNG1TlQ2wj3yA13IH83fJRriNszs21Ah/r4C/rx2VySlMjVeiD7Exh8q
	FWA7Se0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPPqG-00000002aY5-3WXL;
	Tue, 19 May 2026 19:11:00 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPPqF-00000002aXn-09nt
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 19:10:59 +0000
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 7F1CD60221;
	Tue, 19 May 2026 19:10:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3CE91F000E9;
	Tue, 19 May 2026 19:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779217858;
	bh=JMCmbCNvC+HxXHksRWStC4bWizUWQNjAyE1M9dKurnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EOYL5y6dMjqhCVTAWrzmYzrPfz71i1htMxoZ3O7JB/WuzmFa/T/jNfYwtWzIDl3Gq
	 hBzVN69nn/jE2ik+W7jOtsJzkwPyeIe09HnxZ+JiGJXb1HU85akKOOPwpy0w1gLOmM
	 SpQQRkHsHMcP19ixT5yJGODy9ByFs44ruPdoEXi0PSPQ3MrVoya3jFIawIGKJ/J1w+
	 2SNkqO/c3/Vx4DL9Gwl89uB+R1uR9/lbJ2jdc1FcB4lCtD8XXowFhKAP7EDfBSu/eM
	 Un8ukWILQ5iEO36qIjpFMXS1rYY0t8WAQ/eTNvhPeVgejQj2r6BoIujvrfjzdBlpXW
	 dmxTjtX/5Jh8w==
Date: Tue, 19 May 2026 13:10:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: "hch@lst.de" <hch@lst.de>
Cc: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Message-ID: <agy1wPm5QEqVf3RV@kbusch-mbp>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <agtnJb5a5uIqH-65@kbusch-mbp>
 <20260519065303.GA7918@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519065303.GA7918@lst.de>
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

On Tue, May 19, 2026 at 08:53:03AM +0200, hch@lst.de wrote:
> On Mon, May 18, 2026 at 01:23:17PM -0600, Keith Busch wrote:
> > 
> > Any reason nvme multipath can't call submit_bio_noacct_nocheck()
> > directly instead? If it's safe to skip the eod check here, then it
> > looks safe to skip everything else too.
> 
> We really shouldn't expose that, and it doesn't quite to the
> right checks here.
> 
> But I think the proper fix is to stop using bio_set_dev entirely.
> We do not want to associate the bio with a new blkg as those are
> basically not going to exist for the underlying devices.  I'm also
> not sure we want to allow another round of BPF throttling either.

Simply dropping the bio_set_dev usage doesn't really fix the problem
here. Sure, bio_set_dev clears the BIO_REMAPPED flag, but it's not
guaranteed that flag was set in the first place.

I have an alternate proposal that's part of a larger series. This can
notify the driver of an early error so it can decide how to deal with
the bio:

  https://lore.kernel.org/linux-block/20260519172326.3462354-6-kbusch@meta.com/

