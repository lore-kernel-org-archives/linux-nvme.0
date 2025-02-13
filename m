Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CF0C021A4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 16:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LMYKZBB6Lwu1KXc2pApJntLSaHOHjeDAYKss1JDPqUg=; b=h2/Bh+UqiKlUdef6e03FHFUev4
	iGz1z2TckCLdGrh0MXuLggkuaesL+DZy/NFD9m1J3truaytwznieidNfRFhCSj12hYl5IjMoqDFuG
	ntnpP3YugnJAgPXf75fQbuUwKHnztYsbvMvAo36yid+IQWHbg84lJv9e3ygci3KWZ8eOPZo1SqUIa
	7nxJFLumti4PW7aKzJxaa1HdqX9sdmejx4ypgpNj+YnG0TtCMjTkgEh6rYH9LJeO1zIjar8cFK6RV
	KX6UFB+rMiM7NRW5tG1m4Mfa+qnDLZ7uY8Uu7t3cygrJZzQLah/IumL957sVerOcNwyQTul1ybeSs
	JkSuXY/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ticGy-0000000BoaQ-051Z;
	Thu, 13 Feb 2025 16:41:08 +0000
Received: from out-174.mta1.migadu.com ([2001:41d0:203:375::ae])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tibmx-0000000Bh6T-48BM
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 16:10:09 +0000
Date: Thu, 13 Feb 2025 11:09:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1739462995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LMYKZBB6Lwu1KXc2pApJntLSaHOHjeDAYKss1JDPqUg=;
	b=kw6jO4Ia+fc0+hRWz5NBslXI4AxoBaap9J7j7JkJr3oMdJIAlggaIP9jQkT7m8adeZE3u4
	sjozzu76MUWQ6UMRI9BhHg26Alhi4Ih0SG5fEqiUOzLNOmTs4Lq7SlpIRIhzJs7KxFKZxr
	mp6GUpgBVFLkQanqmK3JiLm7hzJwiR//QPm3gyRiAz2m3icIQbtPiTaz7sL8GyJBBSbhsl
	gQkq4x/O9/KpG3O5/yVyOEKB3llflHo1gZXdWWB370m4lHBMVz4ZXyMtFLvC2/ajDbFKD0
	uhuS6+r7ShCjjTAPcMRDTM6HguF3fS3DdTKOHbrnC/KPr2T8h1buvoCQJrJdcw==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Christoph Hellwig <hch@lst.de>
Cc: Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Philipp Zabel <p.zabel@pengutronix.de>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] apple-nvme: defer cache flushes by a specified amount
Message-ID: <Z64ZTixWKoYdF8KN@blossom>
References: <20250211-nvme-fixes-v1-0-6958b3aa49fe@rosenzweig.io>
 <20250211-nvme-fixes-v1-3-6958b3aa49fe@rosenzweig.io>
 <20250213062013.GC19608@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213062013.GC19608@lst.de>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250213_081008_160279_05AB21A5 
X-CRM114-Status: GOOD (  15.71  )
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

> > Cache flushes on the M1 nvme are really slow, taking 17-18 msec to
> > complete. This can slow down workloads considerably, pure random writes
> > end up being bound by the flush latency and hence run at 55-60 IOPS.
> > 
> > Add a deferred flush work around to provide better performance, at a
> > minimal risk. By default, flushes are delayed at most 1 second, but this
> > is configurable.
> > 
> > With this work-around, a pure random write workload runs at ~12K IOPS
> > rather than 56 IOPS.
> 
> Just as last time this really is not a driver feature.  Cache flushes
> are slow on consumer hardware, it's just apple is worse than usual.
> Breaking file system transactional guarantee by ignoring data integrity
> command in the driver is a no-go.
> 
> If we want to allow an opt-in policy for those whole feel adventurous,
> it belongs into the core flush state machine.  Fortunately the patch
> author seems qualified to touch that :)

Fair enough. I didn't realize this patch was previously discussed, my
apologies. I'll drop this change in v2, and hopefully somebody is
inspired later to do that 'adventure'.

