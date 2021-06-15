Return-Path: <SRS0=Oc5T=LJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB4DC48BDF
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 20:24:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5755613B3
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jun 2021 20:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5755613B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=+Hi2I45aWSInn4o8J8XNNx6L92PaGDyFcGKfzCeSLww=; b=FaH0orLzS/Uq6h
	T2y9Coe1HOz3Z19mU/JW95eI7GcwDqIAAXdnIIcuDEJ21m1aPjcz40DNZyzpaFlOZnJCdX8637jMj
	GYc4vRSsUwcFTdsM0VHt8H/DEchP1Coe3ciWXm5Ms7rg5xrk2W4j0Qen4K7/5SzQsF6VnMuMf5zLO
	PcyMvEepTRM1un+Y/CVhemBkQOQwG+EryZMejeu4eGWGJjwFNXlLko0ujZQdeuJTqBw6nK2WLCvDB
	rKSVc1hBwYPTIHqe/gX2yPVKS4UoLvysKtCRR9PrXAYnJNaSPgdveSUpuX/tj99rOIytOzEEseTDl
	pnbN24m1yo6vJJoUJEfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ltFby-002luM-NS; Tue, 15 Jun 2021 20:24:38 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ltBa3-001DRK-5M
 for linux-nvme@lists.infradead.org; Tue, 15 Jun 2021 16:06:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AB5D067373; Tue, 15 Jun 2021 18:06:19 +0200 (CEST)
Date: Tue, 15 Jun 2021 18:06:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 Jeffle Xu <jefflexu@linux.alibaba.com>, Ming Lei <ming.lei@redhat.com>,
 Damien Le Moal <Damien.LeMoal@wdc.com>, Sagi Grimberg <sagi@grimberg.me>,
 "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "Vasudevan, Anil" <anil.vasudevan@intel.com>,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: switch block layer polling to a bio based model v4
Message-ID: <20210615160619.GA32435@lst.de>
References: <20210615131034.752623-1-hch@lst.de>
 <20210615143706.GB646237@dhcp-10-100-145-180.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210615143706.GB646237@dhcp-10-100-145-180.wdc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210615_090623_436026_654B06CB 
X-CRM114-Status: GOOD (  18.00  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jun 15, 2021 at 07:37:06AM -0700, Keith Busch wrote:
> On Tue, Jun 15, 2021 at 03:10:18PM +0200, Christoph Hellwig wrote:
> > Chances since v3:
> >  - rebased to the latests for-5.14/block tree
> >  - fix the refcount logic in __blkdev_direct_IO
> >  - split up a patch to make it easier to review
> >  - grab a queue reference in bio_poll
> >  - better document the RCU assumptions in bio_poll
> 
> It still doesn't look like a failover will work when polling through
> pvsync2. We previously discussed that here:
> 
>   https://marc.info/?l=linux-block&m=162100971816071&w=2

Yes, sorry for losing this.  I'll resend with that added after a short
delay to see if anything else needs attention.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
