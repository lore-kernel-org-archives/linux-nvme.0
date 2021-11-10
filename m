Return-Path: <SRS0=m9zU=P5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B79C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 12:59:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5164E6103C
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Nov 2021 12:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5164E6103C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pbhXMzma7yH8YOcVaHZkAGcmPrAOtY5d5QHcK5iXL9Y=; b=0mzN4XH39Rl59Bg0RRjAOjdESL
	Fpvv0V9J8MhMNgZQi4edAYSZv0wKAL/rljZeRDRB03p0a8lMdFj9OSVpdd8u2nafrA8I6qi4lTsCP
	UmNaA/nAKXrw3/wJcbhoRWEBncB8/kUjX0SPsFLq0gppgNpbcAVPQfKA+XEn2zEnVf60OYFy3CgOH
	wH2EGz8qmOZOWehN7DQopkxgPFm0xCCiSuIN0YG1vPuoHgap72DsBsdS6lAD/Dj59P5uHdcLT0PWU
	2qKVTPHVvAKyMZIlnY8yvNdhWc2e5rSlxDFXtF4kiTXPzUMZZBwoKIlU9ZcdXLJOnuoTRXhUZ6sdG
	5wF77yQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mknBv-005UjZ-0t; Wed, 10 Nov 2021 12:59:03 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mknBs-005UiO-Cy
 for linux-nvme@lists.infradead.org; Wed, 10 Nov 2021 12:59:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2872768AA6; Wed, 10 Nov 2021 13:58:57 +0100 (CET)
Date: Wed, 10 Nov 2021 13:58:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: sorting out the freeze / quiesce mess
Message-ID: <20211110125856.GA25614@lst.de>
References: <20211110091407.GA8396@lst.de> <YYuQ9mhHtDNDVFQ3@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYuQ9mhHtDNDVFQ3@T590>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211110_045900_609110_E0B77015 
X-CRM114-Status: GOOD (  20.51  )
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

On Wed, Nov 10, 2021 at 05:29:26PM +0800, Ming Lei wrote:
> On Wed, Nov 10, 2021 at 10:14:07AM +0100, Christoph Hellwig wrote:
> > Hi Jens and Ming,
> > 
> > I've been looking into properly supporting queue freezing for bio based
> > drivers (that is only release q_usage_counter on bio completion for them).
> > And the deeper I look into the code the more I'm confused by us having
> > the blk_mq_quiesce* interface in addition to blk_freeze_queue.  What
> > is a good reason to do a quiesce separately from a freeze?
> 
> freeze can make sure that all requests are done, quiesce can make sure that
> dispatch critical area(covered by hctx lock/unlock) is done.

Yeah, but why do we need to still call quiesce after we just did a
freeze, which is about half of the users?

