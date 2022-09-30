Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A503C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Sep 2022 15:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PvpuoWOyuaajcsTh63FKqs/kkbd5gA4qNUVGlThQyFg=; b=icl1bGbHUQsZJcMgdrFur/Y5LA
	LGV7BtdLeF5Dbi6NKGuGrwBmh1knNtZQdfTffUYwfSsPAJq0/49iWqmdYAQ6r8pd6/NYLJ6qBr4dj
	Yo5uio3sI1ysSOG44GUtVrgcy4f8Or2a54DtNSmJ+iL0SjKGSdkaQTY+UC9Qee5eBTFaUvLXmW6ni
	6BgSKenx5zBIW0B62YFY1iY7JhwA7WFqG3+8vZ5gEs6cUfjXhmGmxi1c5J2Nt6m6ELI4qyOIsjC7A
	u8RQLcyXznrB1XTI/sjAYNLD/ih9Cybd5L9jYZ8EvSvgUGX2kKvq8VVcJRtuwvJSZ2QfqsHSHJ7Qz
	LDAC6FRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeHpW-00A9NZ-0t; Fri, 30 Sep 2022 15:21:34 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oeHpT-00A9LA-0n
	for linux-nvme@lists.infradead.org; Fri, 30 Sep 2022 15:21:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 9B8FAB828EF;
	Fri, 30 Sep 2022 15:21:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D4BC433C1;
	Fri, 30 Sep 2022 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664551288;
	bh=BoSmbyb3Mqyn2qYpFLDiWbbafCJvBTmYuFHyW7vbeBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nrXFH7AIqeW2fdIU4MJl1+rc4siW2AfNPVhJ5KjdBTWtsEIY90q9KV8qcaCDhJkd/
	 gOartcgsytYGpDmKpRk/lFf1/ru2HlMfFS4gxVi1qQapFAugTqSD8yvhhQRlx4vnIa
	 NjmHbQYuEOWfe59O0PfiC3CU0uLCFShpnnK8Emq0kla+3boyXvKmrAGB3JsoZkxiwZ
	 XJf3rKCfdgqkO7WpobcVIRqjGw0BUsxestkOra5ZiZlx3p0SZMcFmhhp0pNiADQHj5
	 CV9v2K0O02tDEGjk+GHjmauGQ79epR41BRNUldaV4KsRGHV3QobIbLNHMg+p8CITwu
	 rMFT5vuI1IwqQ==
Date: Fri, 30 Sep 2022 09:21:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Message-ID: <YzcJdeR82tHbFGAh@kbusch-mbp.dhcp.thefacebook.com>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
 <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
 <1b7feff8-48a4-6cd2-5a44-28a499630132@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b7feff8-48a4-6cd2-5a44-28a499630132@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220930_082131_241745_91D3712A 
X-CRM114-Status: GOOD (  20.52  )
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

On Thu, Sep 29, 2022 at 07:14:23PM +0300, Sagi Grimberg wrote:
> 
> > > > 3. Do you have some performance numbers (we're touching the fast path
> > > > here) ?
> > > 
> > > This is pretty light-weight, accounting is per-cpu and only wrapped by
> > > preemption disable. This is a very small price to pay for what we gain.
> > 
> > It does add up, though, and some environments disable stats to skip the
> > overhead. At a minimum, you need to add a check for blk_queue_io_stat() before
> > assuming you need to account for stats.
> > 
> > Instead of duplicating the accounting, could you just have the stats file report
> > the sum of its hidden devices?
> 
> Interesting...
> 
> How do you suggest we do that? .collect_stats() callout in fops?

Maybe, yeah. I think we'd need something to enumerate the HIDDEN disks that
make up the multipath device. Only the low-level driver can do that right now,
so perhaps either call into the driver to get all the block_device parts, or
the gendisk needs to maintain a list of those parts itself.

