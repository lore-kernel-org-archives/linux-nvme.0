Return-Path: <SRS0=afDi=DA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18604C4363D
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 05:06:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B98321941
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2020 05:06:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="I+JGRs5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B98321941
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4jDv7/xaRb3nPD6QLfy0uQTgRfc0gs9Pmd93i08QFaM=; b=I+JGRs5CoS14Q9CngHiXrsEcI
	BqnFkGfy/I9jKBigX5/d8SuUel0ZNXS8u7zN4EmCXSkYo48QaaCsnJfysTSYOSwqSiUiBI/l+mCsR
	w/F2bsCH/SGxyQ9glFbGjk/TecQcNAJ+QHo3igFCvfEQuFiQ4FQIra6perYYgQiBTaIc+c1Mm2k1U
	kyikAHOfKLwy77jmYBmfPHm0473RRNAZiBQdIwVUbQ6AZl3b0P0UyM42Lioq/6XxaEKWH9IHUgyZY
	hrNv2wcVbQR7jJSZT0tOoehnx8DRPkEVBjE0+zEZ0k0Y6SOCqFcX/tnGPuGihFhxJINSJZoDpmewd
	/OFkEtvyQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kKwzS-0004GV-JN; Wed, 23 Sep 2020 05:06:50 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kKwzP-0004G7-UR
 for linux-nvme@lists.infradead.org; Wed, 23 Sep 2020 05:06:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9B53767373; Wed, 23 Sep 2020 07:06:41 +0200 (CEST)
Date: Wed, 23 Sep 2020 07:06:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Tong Zhang <ztong0001@gmail.com>
Subject: Re: [PATCH] nvme: fix use-after-free during booting
Message-ID: <20200923050641.GA14878@lst.de>
References: <20200916153605.5253-1-ztong0001@gmail.com>
 <20200922135956.GA23437@lst.de>
 <CAA5qM4BPKZaqH0SHS3zCO7oz=f3Ow_zB2fqtJYUrbbFBNbWsNQ@mail.gmail.com>
 <20200922164154.GA1894@lst.de>
 <61E8905E-E3FE-46EB-8283-9B35B4F069E1@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61E8905E-E3FE-46EB-8283-9B35B4F069E1@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200923_010648_089130_A922CBEE 
X-CRM114-Status: GOOD (  12.36  )
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

On Tue, Sep 22, 2020 at 04:34:45PM -0400, Tong Zhang wrote:
> Hi Christoph,
> I modified the patch a bit and now it works.

So you're still hitting the WARN_ON_ONCE?  I think we need to fix that
as well, but all the ideas I have will turn into a bigger project,
so I think I'll submit this one to Jens, and then do things
incrementally.

Can you share your reproducer?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
