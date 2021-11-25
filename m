Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E4AFC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Nov 2021 21:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	MIME-Version:References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f9hQT/oYYpnjv5idLCr/oSApnXDx3MehVTIczUWNn5E=; b=Bl6M1IO0NYFHhTFSUIzY9Of1Hz
	t6enUu6jnmKtL3pSDNCBMbWUUkwZmP47tP2hC88nVS7FPHI1e1PIP1MVw+ZNnU5zV3bufRCBMPsAX
	uiQJDKA590WUwNxZHWCPMWVbQKnWR4LLBJdou3qntaO67TOdEfBTKgnrlLpvqf4Pt3KFcbT6lRflN
	yOnetitgrcT0ecxpMCIiTjW5YqJ520rQ+DqPTn1ut5e7VZW0+6Cr9DR08NKOLKZrukagj4Qg5SYhe
	vk8OXDy9U4HXuTFF9S2H/bGg612ffMGKBH8a5/8Ei61GWUP2brmVmKNq2Xy9uP54WLZP5dwvmXhZR
	MjEuuGpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mqM1t-008emZ-Hw; Thu, 25 Nov 2021 21:11:41 +0000
Received: from mailbackend.panix.com ([166.84.1.89])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mqM1r-008em8-FA
 for linux-nvme@lists.infradead.org; Thu, 25 Nov 2021 21:11:40 +0000
Received: from [192.168.126.80] (ip98-184-250-31.oc.oc.cox.net [98.184.250.31])
 by mailbackend.panix.com (Postfix) with ESMTPSA id 4J0VtL06xBz2sbg;
 Thu, 25 Nov 2021 16:11:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=panix.com; s=panix;
 t=1637874698; bh=fVNYCI2o8Gl3FzZCspvrDjT0dqKVQsui7DbLR5TdBCE=;
 h=Date:From:Reply-To:To:cc:Subject:In-Reply-To:References;
 b=A7Ls6wj2XBnwsNg2MULnSOPdQxNiIvfc1TqbPbMJBwbHI04fPzby4HhYqHFjrwn/R
 tlAf210tFs5xMn9gdb7U85XN77OiXCbUp81PCx/xJKGLcJKyHQ+yeItR9LODMNn4np
 XmY3POWRNhMqhXfN5jYFiGWqm4aMNeqx6RPVRWcU=
Date: Thu, 25 Nov 2021 13:11:36 -0800 (PST)
From: "Kenneth R. Crudup" <kenny@panix.com>
To: Jens Axboe <axboe@kernel.dk>
cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ext4@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: Write I/O queue hangup at random on recent Linus' kernels
In-Reply-To: <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
Message-ID: <66abbccd-aff0-9b6d-5aa3-f0f17eb4b12f@panix.com>
References: <b3ba57a7-d363-9c17-c4be-9dbe86875@panix.com>
 <b9c2681f-e63a-4d3b-913d-d8a75e2c2ea0@kernel.dk>
 <be6a783-97db-c3bf-b16f-e8c62b14755d@panix.com>
 <17206ea6-506d-b1de-09e8-c935ff308bd6@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211125_131139_595705_13EE57C2 
X-CRM114-Status: UNSURE (   6.73  )
X-CRM114-Notice: Please train this message.
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
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


On Thu, 25 Nov 2021, Jens Axboe wrote:

>>> echo 0 > /sys/block/nvme0n1/queue/wbt_lat_usec

>> It's been about 48 hours and haven't seen the issue since doing this.

> Great, thanks for verifying. From your report 5.16-rc2 has the issue, is
> 5.15 fine?

I can check that out sometime in the next few days, but IIRC I pretty sure the
issue hadn't surfaced before the 3rd or 4th of November. I pull from master
at least every 2-3 days, so there's at least a timeframe.

	-Kenny

-- 
Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA

