Return-Path: <SRS0=FouH=6Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CA8C3A5A9
	for <linux-nvme@archiver.kernel.org>; Sat,  2 May 2020 06:38:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC52D20836
	for <linux-nvme@archiver.kernel.org>; Sat,  2 May 2020 06:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rREgBSh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC52D20836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Q1hh4vguJQbIWbNPt7eh8xbTOMe/6aY1OhAEHAuttQc=; b=rREgBSh43ztXtZ
	QnLsAQABSu+mpf8may+Qh/V78kIzbXNvq/YxrelcbRduGoMP40rYFzk1S3HmMdWE//AMvbXGoM3EX
	uEKvpTjVNT6s2KzqAB5pk23lt+t4TIZQAIzdvq0EJLm/S4i/PafWK41/Da6DaW6LP/yWlqgD1nH48
	rNOoQ06KWscg6BSG/kxRZW5vbBrw4G2aLlm5q6TJXP1P5PBkzI/CsZigGbXTLxKJgGWuUgXI0FzC5
	K9nH9rgM+sYMQ0DeDuiGZHZvzAJa5XrT/gCoiiIvSuLOjyLe35xXwqWL+jHhXy6XPKXupjGAkSzve
	c82C2MBxMS+4zJ2kojlA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUlna-0007hc-Lk; Sat, 02 May 2020 06:38:54 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1jUlnZ-0007hJ-6j; Sat, 02 May 2020 06:38:53 +0000
Date: Fri, 1 May 2020 23:38:53 -0700
From: Christoph Hellwig <hch@infradead.org>
To: James Smart <jsmart2021@gmail.com>
Subject: Re: [PATCH] nvme-fc: change default devloss_tmo to 30s
Message-ID: <20200502063853.GA28925@infradead.org>
References: <20200501214549.95949-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200501214549.95949-1-jsmart2021@gmail.com>
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
Cc: Himanshu Madhani <himanshu.madhani@oracle.com>,
 Arun Easi <aeasi@marvell.com>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, May 01, 2020 at 02:45:49PM -0700, James Smart wrote:
> Transport default devloss_tmo is 60s. However, both lldd's use a
> driver default devloss_tmo of 30s.  Rather having an inconsistency if
> the transport value is used, set the transport default to 30s.

Can we just have an interface that queries the LLDD instead of
relying on the drivers and the transport having the same value?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
