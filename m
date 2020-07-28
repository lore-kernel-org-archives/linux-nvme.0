Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED6EC433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 10:50:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C2B020714
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 10:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Iqsry5Nq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C2B020714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sSxIIpxv89iSDrdBpwwJDNA4Iso/qQqHXDsSgFR6SV8=; b=Iqsry5NqpdEfOVVpezDyOdL70
	nGwajkAyk1nZ4Q6UskM96hqoyFjQdJO7daVvNiNoKR31GQVtup2d9fTRhIneTraGFVj35V0yJ2umT
	Pg68xvdOnRw48pfabi9l0JkPzKZ+FvyRskdTrrJWE/ZK2R8Ma2de/x6WiDnxbV3bpDPxnbACe7ZRz
	0D6NKrrjzBin8RKVW1K3rpwyWnVAV+NROQoIlGzBEdoDVHYX9DB35eAXGiw0+NBbyPoMm6WTqhY5D
	nxyyLKmjEZBr3B6eXzsOq80pGzBCDs0Gd3Yv2/GxHzfhr17auHxWf0pebzIpx3qe2B3hBAYhyyv/E
	s7G9hS1/g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0NBM-0001ov-Hp; Tue, 28 Jul 2020 10:50:04 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0NBJ-0001o1-L9
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 10:50:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 45A3368C4E; Tue, 28 Jul 2020 12:49:59 +0200 (CEST)
Date: Tue, 28 Jul 2020 12:49:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/2] nvme-tcp: fix controller reset hang during traffic
Message-ID: <20200728104959.GA29442@lst.de>
References: <20200724221013.28828-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200724221013.28828-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_065002_094680_5B67D131 
X-CRM114-Status: GOOD (  15.79  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jul 24, 2020 at 03:10:12PM -0700, Sagi Grimberg wrote:
> commit fe35ec58f0d3 ("block: update hctx map when use multiple maps")
> exposed an issue where we may hang trying to wait for queue freeze
> during I/O. We call blk_mq_update_nr_hw_queues which in case of multiple
> queue maps (which we have now for default/read/poll) is attempting to
> freeze the queue. However we never started queue freeze when starting the
> reset, which means that we have inflight pending requests that entered the
> queue that we will not complete once the queue is quiesced.
> 
> So start a freeze before we quiesce the queue, and unfreeze the queue
> after we successfully connected the I/O queues (and make sure to call
> blk_mq_update_nr_hw_queues only after we are sure that the queue was
> already frozen).
> 
> This follows to how the pci driver handles resets.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Applied to nvme-5.9.  I've also addeda fixes tag.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
