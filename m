Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00ABC5DF81
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Aug 2026 00:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ymhGeasTra0VT+6Ztf7PndU10djbi5IDK4lv3hjVh7o=; b=lGDYLV5S0hGnX/ekTsqRwXoeJe
	erfeHK0uiyTHHHoX9pRHqiR/G+qjipauTorwjmJyZJSpc2rJ2re24uPpYQNFVeIj2J3sxauSvBTjx
	sjJ3xLavjoaBvTbWFE77TWh/MudKSorwluzgX36wX0SKnKs8HJLipB5lxMes7I9BUyDs5LuA5RQyM
	MdnnaYbLx7nUvZPBsdr2l1wh5T5pFyudaja+zjrgaTPAQlZNQgN14dpfzLSHzR6lzRTu7rHBDFtIP
	tIdGUEujSEJjHwOPVoutzugiD9rHGsWH7mJWb6vBjs9we2kE68xkhoMaJalUMTh/krz6w0sxXsxlt
	9tq6PSBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyfS8-0000000HaPj-175q;
	Tue, 25 Aug 2026 00:55:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyfS5-0000000HaPW-3GCf
	for linux-nvme@lists.infradead.org;
	Tue, 25 Aug 2026 00:55:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1F97E40DC3;
	Tue, 25 Aug 2026 00:55:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA951F000E9;
	Tue, 25 Aug 2026 00:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787619345;
	bh=ymhGeasTra0VT+6Ztf7PndU10djbi5IDK4lv3hjVh7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AUA30opfEo3pvPMtNC9RUzOY9VBDLvGtgYCqICq+jNKNYcqpIk8IiFgmaG6DW7ZD1
	 waE1t9j0J4QLdPcfoCiixqe+mGLl2A8g+hlNNwhBkp9o5OKzSOmCtuhvA+PGWruKrD
	 Imk6LASBNub9knucPXGFBdRc+pSaQrjeu6u0z+dP7KdBnztIwDYOxF9K7yjQRFEmGU
	 rUtL51b0fFavUBaIEXHPAN5NS222Xce90C1d7TVwY9wW+oN9hYs3Qtq0arkeIsBIIE
	 cY2TJqcuwaTbX8OIuCWfD/otbYZ1CyM7hsw15B5mSrQaNrVI01PgMuINCV09JXU7NO
	 3Ogz8LsmUKvtA==
Date: Mon, 24 Aug 2026 18:55:43 -0600
From: Keith Busch <kbusch@kernel.org>
To: Mohamed Khalfella <mkhalfella@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme: remove stale namespaces by NSID range during
 scan
Message-ID: <aozoD-9LXxA6SE4C@kbusch-mbp>
References: <20260823004641.1369895-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823004641.1369895-1-mkhalfella@purestorage.com>
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

On Sat, Aug 22, 2026 at 05:46:41PM -0700, Mohamed Khalfella wrote:
> nvme_scan_ns_list() drops the stale namespaces in each gap in the
> reported NSID list one NSID at a time. Every iteration calls
> nvme_find_get_ns() to look the namespace up and removes it if it is
> present. The loop runs once per NSID in the gap rather than once per
> namespace actually present.
> 
> NSIDs are 32-bit, so a target with a sparse NSID space can make a
> single gap spin the loop billions of times with nothing to remove.

Thanks, applied to nvme-7.3.

