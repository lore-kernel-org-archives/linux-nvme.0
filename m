Return-Path: <SRS0=ND0+=JJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F72C433ED
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 12:49:28 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FB2661261
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Apr 2021 12:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FB2661261
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=IkiJGRVE2HXj+4x5salYukKnrZ24XAFj4Ofm74+hVfw=; b=LZggeOAeA6LIKo3GfkyQIw12t
	3F4ynPdsj3IqGylwEKyycMyRq8A3viAlKpybb1UchAeG4xhoDONZpxhNSodLN92q7Rl7bt7FoF56Q
	wv7aCNqqGIZshNgWaIko1fc42WHW0JwagXaYQqEE2npIpDXmZ14JzHRZ6J4qVAJX96Lp2HKg1Byt6
	sQUHtHPQ9lh3+8LooPnF4xF10iW5tK21weBDJGTGBUorVamW7dPj/g8F7y98Rn6SMSQxQyhsPXM/q
	xtzhBBybiYK+Hev4S4R9t2GZepz9suoLjCPmdxrYqEFS2GChGBqxtUW2JZbYVZTDE8Zj/MTQqMieP
	UM54QEINg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVw0F-006kWl-Mn; Mon, 12 Apr 2021 12:49:19 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVw0B-006kVB-BY
 for linux-nvme@desiato.infradead.org; Mon, 12 Apr 2021 12:49:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=jNhCF7zp5V3pFiYdRbx8dHBLoq+QNJgWFGUxmEU/54c=; b=zc51Nr+QoImeWTAX4v6qy3Yp9m
 meRVaPUnsDlMeOdQpCq60Iq80E2s0Zfnyg1a3lGjqYTmcY7FEdEG6ulh52L8XQ85Q5XUfj2zpB+I8
 PhpaV04chlgEY89f0wxEQbu9SLCD+XevssZovSq/2kHKDyNEi2o1QaYIlXn2Z3NyRgwsXe/ZeRuhH
 aPDhS6SoepX8Zc1bKW4glrq25CzuYA/7A8uqud1g5NZjCzIZW7DHtMWLqzQZeQ8jmgk55RRUlZYd7
 MbT/cwli2VNacqixBnxRTal8WSCsXVZeTYQlH1oWcjjb92b32YamEFHQkB6z/KbGGccWj0F9NB2Zq
 +vIw4LbQ==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVw07-006Edl-PM
 for linux-nvme@lists.infradead.org; Mon, 12 Apr 2021 12:49:14 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 01970B0E5;
 Mon, 12 Apr 2021 12:49:10 +0000 (UTC)
Date: Mon, 12 Apr 2021 14:49:09 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Steve Wise <swise@opengridcomputing.com>,
 Leon Romanovsky <leon@kernel.org>, Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH] nvme: Drop WQ_MEM_RECLAIM flag from core workqueues
Message-ID: <20210412124909.olui5hfhceakt4u4@beryllium.lan>
References: <20210412122330.5166-1-dwagner@suse.de>
 <20210412123149.GE227011@ziepe.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210412123149.GE227011@ziepe.ca>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210412_054911_988239_69E38FB9 
X-CRM114-Status: GOOD (  13.96  )
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

Hi Jason,

On Mon, Apr 12, 2021 at 09:31:49AM -0300, Jason Gunthorpe wrote:
> What does early init have to do with WQ_MEM_RECLAIM?

40c17f75dfa9 ("workqueue: allow WQ_MEM_RECLAIM on early init workqueues")

    Workqueues can be created early during boot before workqueue subsystem
    in fully online - work items are queued waiting for later full
    initialization.  However, early init wasn't supported for
    WQ_MEM_RECLAIM workqueues causing unnecessary annoyances for a subset
    of users.  Expand early init support to include WQ_MEM_RECLAIM
    workqueues.

That's the connection between WQ_MEM_RECLAIM and early init.

> WQ_MEM_RECLIAM is required when any thread in a reclaim context goes
> to sleep waiting for a WQ to complete. For instance by calling
> flush_workqueue() or many other things.
> 
> The sleeping reclaim context must be guarenteed that the work can be
> completed without the work, work queue machinery, or anything the work
> has become interconnected with, recursing back into a reclaim.
> 
> IIRC the issue here was some destroy or flush work in some error
> condition that happened to be under a reclaim context?

I understand what you are saying and I would totally agree with you but
where is the code for this?

I've grepped through the code and didn't find anything which supports
the guarantee claim. Neither mm nor schedule seems to care about this
flag nor workqueue.c (except the early init bits). Or I must miss
something.

Thanks,
Daniel



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
