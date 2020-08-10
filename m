Return-Path: <SRS0=L2sc=BU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7ACC433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 12:40:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A52120678
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2020 12:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L8jzjxyV";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="chL+UlvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A52120678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wuFEmsVLNVFcvBAuE6LOqP9TWbKxHZvYCzxN4sKJeGw=; b=L8jzjxyVjpuQ0ifc35rzTp4Nv
	IJIqfOjW1/kAIdmASd4b1lWRPL5XQA2cAyiEpXIAmY00JRSfpWbqfqBSa4iyECSp4h4hl1+VHAE98
	M+T1YDQehecgxQtU0ryR84iGtcVTcW3HAp2aI84Ax0LkyrNvoeLcu+I6QUTKO42FwmdlDbtPZXR80
	x7qO1lKCfCvO/jC1uBnm9adESVubYx5cHarouZIUkkslo5+ea4fKfzyfQr132XyzV6WB1qWMzKFh+
	krafu3AdLw2t8GJYX0EmSimiXKf/En5wrrV8YoTbJyM5XZAq4CqVjIxehp0BBhdSkFHTSX+gXBW7S
	dS+yl8Lsg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k576V-0004Km-NO; Mon, 10 Aug 2020 12:40:39 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k576U-0004KR-1s
 for linux-nvme@merlin.infradead.org; Mon, 10 Aug 2020 12:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=nve5hjg62RcuifCk3pYH2qb2k5CUs/S9dBkqeHh7iWs=; b=chL+UlvPXmngzG+sOpJAWBI5qn
 QUeVfw/fcroPDLmcGuysVDBSeSiq5TMtnZ//dfTN5PEhsNPTUUU5/CdcVOVif4NL+2CDy9oAC32f0
 5HB0qd9W646DeVBi382eMvvOuHodRGWlKgbwboH2zKv7rRYHvyLlfGQKreTcbSmPU+zcvqvDr4ULP
 DDvxWVQfEXzVZf/mrkoQ5GK9vf0jr+EfrQU84cknPXQI2FJRK7Dt8TBBcrHOq9TzGm/5zdWRl2y1y
 GritnLDjkaaidKr3pzdCg2SznAzxMEggOyMJ+xRZPjDicYEkz/paeqbXXfYxEK1iKjweHEqNvHGRD
 7nS25cYQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k576S-0006cF-EV; Mon, 10 Aug 2020 12:40:36 +0000
Date: Mon, 10 Aug 2020 13:40:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: nvme reservation commands during controller reset
Message-ID: <20200810124036.GA25070@infradead.org>
References: <MN2PR19MB30052441F4F22A4CAC8D396FEE4B0@MN2PR19MB3005.namprd19.prod.outlook.com>
 <20200809161016.GA63121@C02WT3WMHTD6>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200809161016.GA63121@C02WT3WMHTD6>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: "Anner, Ran" <Ran.Anner@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "Engel,
 Amit" <Amit.Engel@dell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Sun, Aug 09, 2020 at 10:10:16AM -0600, Keith Busch wrote:
> On Wed, Aug 05, 2020 at 07:14:22AM +0000, Engel, Amit wrote:
> > What is the reason for setting REQ_FAILFAST_DRIVER flag in nvme_alloc_request ?
> > The original intention was to mark only sync cmds as failfast ?
> 
> Special requests don't get generic error handling. The caller gets to decide
> how to handle it.

Although I wonder if we want to allow to opt in into the normal retries,
as for some cases that might actually make sense.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
