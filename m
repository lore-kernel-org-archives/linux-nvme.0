Return-Path: <SRS0=GXcx=5N=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0ED0C43331
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2020 08:26:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F62820714
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2020 08:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="H/gPN7pF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F62820714
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oVn/PfF0HkoRtJHnGyjgWVCYk5hy9UryCVBIS+AjSqc=; b=H/gPN7pFtE43rI
	ijb62LDnHLDHI5E8cUia9CeSk2WAmn/cdOf1wCwd31tPjGyf/jint5vX+Z94fjQfJw/2/JSozXy9P
	W+gSvqfogSN+vp/4NVQDEOkCHohG+19IthOfdqmvsQ8FEocmFZaF8g/Te1QrYwVO/LkMC5yETkmgA
	+uJohTKxyQ8Cj8did6l5ewE4RrCqfvNsDtLgZLBcHQ4BOTsxqunmt2waFAwAaCJNoj6IYxAgjUpyl
	MBg3Ko2TwVsWQTth3CFC8+RjyaZBFi/WDEg+sK+d/Obw+7KjeTM4QOQMEsmfnIZBdKv9AdE+62uDx
	M+OQj6Jt/XmKqbAePKZA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jI6nk-0003yb-Te; Sat, 28 Mar 2020 08:26:44 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jI6nj-0003xm-Bp; Sat, 28 Mar 2020 08:26:43 +0000
Date: Sat, 28 Mar 2020 01:26:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Nick Bowler <nbowler@draconx.ca>
Subject: Re: [PATCH v2 2/2] nvme: Fix compat address handling in several ioctls
Message-ID: <20200328082643.GB7658@infradead.org>
References: <20200328050909.30639-1-nbowler@draconx.ca>
 <20200328050909.30639-3-nbowler@draconx.ca>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200328050909.30639-3-nbowler@draconx.ca>
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
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Looks good, and I really like the new nvme_to_user_ptr helper!

Reviewed-by: Christoph Hellwig <hch@lst.de>

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
