Return-Path: <SRS0=ANWg=B6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B2EC433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 08:29:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 950CF207DE
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Aug 2020 08:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Qmi8RobL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 950CF207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gBL5KXNA5Ju8dIe59YmXhn6sAiLpPFN9decda9h2kyE=; b=Qmi8RobLKJ9cCfKEm51lqBfeo
	rHOJi47cYpuS/P6az4NFyWcO+w+001l8AHmqVT6WKGkShgzuXgaDXN6trKSetCUqxTvT7Vxnp6Jwa
	3VzwTq0jAhpYd0UvloXkCPt4/GQxbN5W/0+N/7DuBfkG5aD1QpizC+LVZ+D10szt3eez7xjMLqagK
	fXL7XvGo+tHohJcUXSiltfCH2T0c9MoJWAFkU5EbxnskVZ+pB886KRvQwqq4GG2gQXO0+cvpIYTOw
	vIXTA2RIjo9+C9VTg9Z4jg6QOhv0lsUO5pWq9LaVv3VLuCWa6SDmwi+dkQKYnAYyzf/KLUGtPUu/0
	7RPtcoGwA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8fwu-0008IB-90; Thu, 20 Aug 2020 08:29:28 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8fwr-0008Hg-Fw
 for linux-nvme@lists.infradead.org; Thu, 20 Aug 2020 08:29:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id B6C3868AFE; Thu, 20 Aug 2020 10:29:18 +0200 (CEST)
Date: Thu, 20 Aug 2020 10:29:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/3] nvme-core: improve avoiding false remove namespace
Message-ID: <20200820082918.GA12926@lst.de>
References: <20200820035357.1634-1-lengchao@huawei.com>
 <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ead8ccd0-d89d-b47e-0a6f-22c976a3b3a6@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200820_042925_638282_9F30FBD1 
X-CRM114-Status: GOOD (  15.16  )
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
Cc: axboe@fb.com, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Aug 19, 2020 at 09:33:22PM -0700, Sagi Grimberg wrote:
> We really need to take a step back here, I really don't like how
> we are growing implicit assumptions on how statuses are interpreted.
>
> Why don't we remove the -ENODEV error propagation back and instead
> take care of it in the specific call-sites where we want to ignore
> errors with proper quirks?

So the one thing I'm not even sure about is if just ignoring the
errors was a good idea to start with.  They obviously are if we just
did a rescan and did run into an error while rescanning a namespace
that didn't change.  But what if it actually did change?

So I think a logic like in this patch kinda makes sense, but I think
we also need to retry and scan again on these kinds of errors.  Btw,
did you ever actually see -ENOMEM in practice?  With the small
allocations that we do it really should not happen normally, so
special casing for it always felt a little strange.

FYI, I've started rebasing various bits of work I've done to start
untangling the mess.  Here is my current WIP, which in this form
is completely untested:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/nvme-scanning-cleanup

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
