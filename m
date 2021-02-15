Return-Path: <SRS0=Cnjr=HR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E735C433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 10:40:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DACB764DF2
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Feb 2021 10:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DACB764DF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=B3sIeS9Z9sv12BkxQx7GiF3MoGnhtZiXVUbY5JfaxRc=; b=hZUa6BRineezdbB8GPTVulop4
	pc6heZ12oZFeFJopYHwTPsETuOxKfqKAroxQUrSnHkZ3xbL7BjAu9Gredha9M19UOZ6Q3hxCV/DGo
	WVxr3lo75RHoDTrHmxFm8e6tpBSJAmFVRuGYY13+AFqDC1OG/iYIvltMFssLJtyRQ6HvEDgoErH/W
	AIyMzZ219I6xsAAa/+t5NntbbvBHZkVeekVmseqs5ac2oMU4dktA7JG7GBMCWwPdfjOzEN4A4Fspx
	0kXXXqKxolKBh0rZ9eP8FjYmOwLnR/BbSIPU/oMiQS5n+sEmmGkoFPfjgOUHAPRo5KQ8jfO8U46MC
	sjOIwIqrg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lBbIn-0005LO-JA; Mon, 15 Feb 2021 10:40:25 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lBbIl-0005L1-20
 for linux-nvme@lists.infradead.org; Mon, 15 Feb 2021 10:40:24 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 8F854AC32;
 Mon, 15 Feb 2021 10:40:20 +0000 (UTC)
Date: Mon, 15 Feb 2021 11:40:20 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-tcp: Check if request has started before processing
 it
Message-ID: <20210215104020.yyithlo2hkxqvguj@beryllium.lan>
References: <20210212181738.79274-1-dwagner@suse.de>
 <c3a682d3-58f7-f5cc-caaa-75c36ca464e2@grimberg.me>
 <20210212210929.GA3851@redsun51.ssa.fujisawa.hgst.com>
 <ddf87227-1ad3-b8be-23ba-460433f70a85@grimberg.me>
 <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <73e4914e-f867-c899-954d-4b61ae2b4c33@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210215_054023_266821_3FCE114F 
X-CRM114-Status: GOOD (  23.94  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sat, Feb 13, 2021 at 09:46:41AM +0100, Hannes Reinecke wrote:
> On 2/12/21 10:49 PM, Sagi Grimberg wrote:
> > 
> > > > > blk_mq_tag_to_rq() will always return a request if the command_id is
> > > > > in the valid range. Check if the request has been started. If we
> > > > > blindly process the request we might double complete a request which
> > > > > can be fatal.
> > > > 
> > > > How did you get to this one? did the controller send a completion for
> > > > a completed/bogus request?
> > > 
> > > If that is the case, then that must mean it's possible the driver could
> > > have started the command id just before the bogus completion check. Data
> > > iorruption, right?

'during TCP LIF toggles and aggr relocates' testing the host
crashes. TBH, I do not really know what is happening or what the test
does. Still trying to figure out what's going on. I was just very
surprised how much the code trusts the other side to behave correctly.

> > Yes, which is why I don't think this check is very useful..
> 
> I actually view that as a valid protection against spoofed frames.
> Without it it's easy to crash the machine by injecting fake completions with
> random command ids.

In this test scenario it's not even a spoofed frame; maybe just a
confused controller.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
