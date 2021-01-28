Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D6EC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 12:39:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8374664DDD
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 12:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8374664DDD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gu8qDoifQBwhzWnILhdyhHxmHoH2ZL+zlOJGNI4pMzo=; b=mFCaEtbGTGIjmf/bsZDfs8STc
	ValGhZ9TFtgEzvFg6s2zDzY7EYnUYEd9eEFuYFS08+MeQxoSanVU0AOe26tbbkdH4kg/thcCXt7M2
	SRNa35JgY3rsYM86jx3Ax4svLBBRvyKLiWNgg2DSoftRv178fGJ114piYfTfS28KVFc3wqCaIU7w+
	/YQgBYpIJOU/xhW2itfGJJQptljJJqusjjJzlhyJG75VuC2OxDga1qaoQwcswUKwUP+FLkJhVxi6G
	VsupyqXjzE6WfJNouNDWITk3VpWH1ogb4o78rLY569Sa46Dm5PlEH6O8Ca5WJM+5EEkd/laTN+2Xc
	YhUYTf/ZQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l56a8-0002Z3-82; Thu, 28 Jan 2021 12:39:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l56a5-0002YQ-9T
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 12:39:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6A67168AFE; Thu, 28 Jan 2021 13:39:20 +0100 (CET)
Date: Thu, 28 Jan 2021 13:39:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michal Krakowiak <michal.krakowiak@linux.intel.com>
Subject: Re: [PATCH] nvme: trace: parse format nvm command in detail
Message-ID: <20210128123920.GA16013@lst.de>
References: <20210104155343.GA26034@michal-desk>
 <20210127174606.GA28180@lst.de> <20210128122501.GA2579222@michal-desk>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210128122501.GA2579222@michal-desk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_073925_454183_3F79BB8A 
X-CRM114-Status: GOOD (  12.63  )
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
Cc: Michal Krakowiak <michal.krakowiak@intel.com>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jan 28, 2021 at 01:25:01PM +0100, Michal Krakowiak wrote:
> Thanks,
>
> I'd like to ask about future nvme tracing development: Will preparing 
> similar patches (for more commands) be welcome? I'd like to do it, but I 
> got some concerns after the discussion raised due to this patch.

I'm a little worried to that we grow decoders for every obscure NVMe
command in the long run.  I think everything that is either issued by
the kernel driver or very commonly used by administrators (e.g. Format
NVM) is a fair game, but at some point we have to draw a line.


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
