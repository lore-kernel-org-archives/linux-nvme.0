Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70EF4C83F1A
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 13:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BRBVZNlw5O71FzTVBq4+fzzoirvUmtVTdMwdRNKjEBw=; b=k895MsHQok0eDv4bWKrrQT62fQ
	Hu63DF3UOneI40Pc1bXIjXYqFnBURYqSjqJI3TTLLjUvSVpTFmPY0efCi5NXmdWzh/jHbsi0xS4DT
	FIEBVlwhuXpEyfvZ348Ov5fz2ASCehvKsKmDNUwgThHwuQfUPcR9MKlxPDs8PWrWFKLr2jxZ8E/m2
	ZoMTvLJ8JAwS5fo3hkfs+x2acaVZt2R2cbUaXNXlKoFteP5dyHafjKuOCWcU0jvyEzozwSwelCCTc
	1QvAJJJEVV5Qdf7EwaREYlVJAtTbaCzu2I2awDBPVwCv6S2+KCII14wcsZhPFZjNaXb15O5zEQ21t
	bf4Z6fgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubJ91-00000002H5c-22Xe;
	Mon, 14 Jul 2025 13:22:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubIpQ-00000002Dwm-3Hh7
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 13:02:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 50B22227A88; Mon, 14 Jul 2025 15:02:31 +0200 (CEST)
Date: Mon, 14 Jul 2025 15:02:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joel Granados <joel.granados@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Klaus Jensen <k.jensen@samsung.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/8] nvme: Add Controller Data Queue to the nvme
 driver
Message-ID: <20250714130230.GA7752@lst.de>
References: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-jag-cdq-v1-0-01e027d256d5@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_060244_964403_EB7D3942 
X-CRM114-Status: GOOD (  18.06  )
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

On Mon, Jul 14, 2025 at 11:15:31AM +0200, Joel Granados wrote:
> Motivation
> ==========
> The main motivation is to enable Controller Data Queues as described in
> the 2.2 revision of the NVME base specification. This series places the
> kernel as an intermediary between the NVME controller producing CDQ
> entries and the user space process consuming them. It is general enough
> to encompass different use cases that require controller initiated
> communication delivered outside the regular I/O traffic streams (like
> LBA tracking for example).

That's rather blurbish.  The only use case for CDQs in NVMe 2.2 is
tracking of dirty LBAs for live migration, and the live migration
feature in 2.2 is completely broken because the hyperscalers wanted
to win a point.  So for CDQs to be useful in Linux we'll need the
proper live migration still under heavy development.  With that I'd
very much expect the kernel to manage the CDQs just like any other
queue, and not a random user ioctl.  So what would be the use case for
a user controlled CDQ?


