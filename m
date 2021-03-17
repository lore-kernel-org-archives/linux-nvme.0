Return-Path: <SRS0=uaVC=IP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BBDC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 00:32:19 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0ECF64F8C
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Mar 2021 00:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0ECF64F8C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:Cc:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=MAHk9xD5q2L/kYReQcovlVP6J8lfmS+FJzlosE5cvOw=; b=X5alwnPXEsjjD/z18cdlFGxJP
	0pRaDtA9mQoL5R7IFr7c3RBWCCe7icAMmKGAnnW//3OsX86yf6i69d/lE/zxGgNJ1hiX6X6XS3lCj
	vXIYOaun7epQlR0Qp+XLITq7GLpwFLFSFSObdgRS8hl3F2pCnJ6r+/1L7xR5mVP5q+frG++qzmZGf
	Fy90oJEHiKipgjLrUwldBcEIJfDuZc2HHIpKSCytTKaA6Nwaw22YLQ0vnsUUtIklwcS+tjNdSSFHD
	/yinQ8q97+qcstONzJwyRvcRM+kA2wEr6a+d4b08NNZuth1IFz9E3PeL3+iod72NaZTkuhFT5aPLY
	gXdsXOSlg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMK6a-0025Vj-3u; Wed, 17 Mar 2021 00:32:08 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMK6W-0025VO-Bz
 for linux-nvme@lists.infradead.org; Wed, 17 Mar 2021 00:32:06 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1615941122; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bWasTT60IQ64dFspkGVzgJ48YXH9pjzG2WYX98YzhUI=;
 b=ps3P+fp8TNN7qOrSPVxt4U9BWdSPjZ0gJ/jnPRmCk5U99IMSw505/j7GuDy24LztyGwJYK
 ZwWMTixKIl5/xOd3DDGZYsa0joU+VuvK/KRCAC9iziB9Ud5ZvC4TraYXsKIGzcHe+Vg9O4
 KSGnbpXljHz3ItbfVumXS0bz+IBbBGE=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AC2C4AC1E;
 Wed, 17 Mar 2021 00:32:02 +0000 (UTC)
Message-ID: <6a967733e2c997ef75ff29522931003d0ac9e6cf.camel@suse.com>
Subject: Re: [PATCH v2 02/16] nvme-cli: add code for event and timeout handling
From: Martin Wilck <mwilck@suse.com>
To: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>, Keith
 Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>, 
 linux-nvme@lists.infradead.org, Enzo Matsumiya <ematsumiya@suse.de>
Date: Wed, 17 Mar 2021 01:32:01 +0100
In-Reply-To: <20210306003659.21207-3-mwilck@suse.com>
References: <20210306003659.21207-1-mwilck@suse.com>
 <20210306003659.21207-3-mwilck@suse.com>
User-Agent: Evolution 3.38.4 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210317_003204_651202_AEE7C96F 
X-CRM114-Status: GOOD (  12.73  )
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

On Sat, 2021-03-06 at 01:36 +0100, mwilck@suse.com wrote:
> From: Martin Wilck <mwilck@suse.com>
> 
> For the nvme monitor functionality, an event handling mechanism
> will be necessary which deals with event timeouts. While there are
> standard
> solutions for this (e.g. libevent), these add unnecessary complexity
> and dependencies to nvme-cli.
> 
> Add a small, straighforward event and timeout handling code based
> on epoll and timerfd.
> 
> This code is identical to what I've pushed recently to
> https://github.com/mwilck/minivent, where I added a couple of unit
> tests to make sure the code is as robust as it needs to be.

FTR, I found a use-after-free condition in this code. It's will be
fixed in the next iteration of this patch set.

Martin



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
