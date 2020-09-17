Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B652C43461
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 08:54:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E634520872
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 08:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="wKroS/VT";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dnqFcT0g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E634520872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PagCk4OVhz/6qOnl4Ihy7tOaU5URBM77okZ/u5KOMrU=; b=wKroS/VT1Cf7gzZB97A0bTBA3
	x8IrtXcYC99aXIlk38WOIoMHktAS3hBxbAdosKIUyDmAC4xLTc/QxeCYpe1eC1VEVD0u4bH38mW2+
	QtT2N38R5jwnLQ0cUt2uEwzBGrMzYhgOHIIPVvnv1adV7MAdYvR01msNjsOnmBQaz7t78sxAFKLrB
	RmhLbOz500auuZ1zFD0p/S5gGBz5dZFO9ER2PeKsp8kDxX0dGyQCn6qfSpxCw7OD1NVpwQmGS7S/L
	SAaCCIA2DukmQd1As4T9XCo0A6UZDw2vtSMqNZmnhfSTYSh6BKgymFi28sxKOroIMkzP56xlG6bE8
	e3Gc6w+Hw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIpgb-0004sD-QV; Thu, 17 Sep 2020 08:54:37 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIpgZ-0004ra-Bu
 for linux-nvme@merlin.infradead.org; Thu, 17 Sep 2020 08:54:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=i1BzqPS4KgcHVB6lyHr7yiPihnX3KgeNFfHtpVNsrmM=; b=dnqFcT0gHwoDZvuYGeSlChyHQx
 eg07YG1Ut39TwvZEhD+cos8ijlbamdZ2MUUZY4GKSH16YK9VzQcj89neHB9YJ+ou59yX9e7gxS/ZQ
 arqsda6A9Mejw7OXRdUnRaEfuvxIh5hskqcN+XatE5WWh5DM6bwUkIhsJ73mpQshmi/B1xIQVM+6e
 Uy2FLHGDAli/GlGJ2i7/eVoga9W4pNvHA6doCtb36bp/i4DnCHSFAsF8sj5B9C2c/F2N31ztm7VQI
 Pwh1B5m2JPO6waEGZ6UqFS6g4rVUEndfFIIaI1L6eLauFvPbrSuP6MWPUlR06s7J2fcYfem3CwrhL
 kLgeWDyQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1kIpgX-00030C-G7; Thu, 17 Sep 2020 08:54:33 +0000
Date: Thu, 17 Sep 2020 09:54:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>
Subject: Re: [PATCH 1/5] nvmet-tcp: have queue io_work context run on sock
 incoming cpu
Message-ID: <20200917085433.GA11528@infradead.org>
References: <BYAPR11MB28697B878F8E60343BB9EE91E5520@BYAPR11MB2869.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR11MB28697B878F8E60343BB9EE91E5520@BYAPR11MB2869.namprd11.prod.outlook.com>
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Applied to nvme-5.10 after fixing the duplicate subject line,
and fixing the author line to match the name order in the signoff.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
