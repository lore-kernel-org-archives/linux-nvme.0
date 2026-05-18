Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DCD2CD4F4A
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 19:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CdxyqxhlKkX3o1WePpZd4SO8P6tJfF7gjFuXyQY0sgs=; b=d28ob7TH3tPoCFmorQUlFwQvNE
	d3dnQ+GEgRgTnJ4d6DMfYG8SgLEZ+Kl513VBCfrh56chRgZP/mzVf9ZT+DFHxBnz1j6zr8s5jC47M
	/ubgneVJdt8IVvW0ija7nXB+E00gcc3Tu1axQyVAPLHd7VZTGT8OmYHo9B1K+q+1scuvxYlNmPG8u
	m0CFqiq8mQM84rserzK9oH1RIJzexLCRVunUjpiMYHSOXae9bZPnnqMBfnL0EA9TBd+s9i3KqfUcG
	7wF3yGj5rxwvJMtIjQQpYv4u0kHD2uyCw+9FFwiSJ+gyVTFnwXQRwPHUdPQaik1KMMgIn6p6hpOyU
	x4eM8tlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP3Yf-0000000GfdT-2cbH;
	Mon, 18 May 2026 19:23:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wP3Ye-0000000GfdC-2kKJ
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 19:23:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id AD2F860123;
	Mon, 18 May 2026 19:23:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A3CC2BCB7;
	Mon, 18 May 2026 19:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779132199;
	bh=YH4nu/12Er9fpJ5EGzk3UetLfoGZNCOH+QXK+VHEjAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/Cm/JV4svOkZT2PAuIcH1Uf/NhGI3JV6zXPuOUXFXpkqtWktw6076FFWVntMxaeJ
	 zsLbjp3MidWODCbo0PAW+yun3KiOFTX3hOssgL14d5RTnziesPNbV78tYy4+uu2nbz
	 QI1mZOLz487wG3uwJ7iYKl41JQF0bE+a6iiVV7MS8KELABw+WatMEAe2eYgf96rRW4
	 iM8/xEwDtjcM+VA14HGvb74a58gnqvWUP00cuSUEwKpRnP87ocbq9DRuO9sfFJvkT2
	 AzJE06Q7ux0VZzlVGC4I3OdX6JvStUN1ch+KodDouQdj+XfKUfKAlmmdQoECMj/dyu
	 VRAG5dOoOIxuQ==
Date: Mon, 18 May 2026 13:23:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>
Cc: "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
	"axboe@kernel.dk" <axboe@kernel.dk>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
Message-ID: <agtnJb5a5uIqH-65@kbusch-mbp>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
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

On Mon, May 18, 2026 at 02:52:56PM +0000, Achkinazi, Igor wrote:
> @@ -511,6 +511,13 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
>         ns = nvme_find_path(head);
>         if (likely(ns)) {
>                 bio_set_dev(bio, ns->disk->part0);
> +               /*
> +                * Mark the bio as remapped to the per-path namespace disk so
> +                * that bio_check_eod() is skipped on resubmission (e.g. from
> +                * bio splitting in blk_mq_submit_bio).  The EOD check already
> +                * passed on the multipath head disk.
> +                */
> +               bio_set_flag(bio, BIO_REMAPPED);

Any reason nvme multipath can't call submit_bio_noacct_nocheck()
directly instead? If it's safe to skip the eod check here, then it
looks safe to skip everything else too.

