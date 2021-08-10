Return-Path: <SRS0=1Q2H=NB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F054C4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 16:31:11 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C711060527
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 16:31:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C711060527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iuktLIzarvHjEJlKtxuBEUVUXP0f2R+/dgHk/7kC0YA=; b=ntV19LSNvP3qjh
	3RFPi7cx50Hf5wXjXEUumnTyQ4punbJ4NsYcGh9ypn80Fc2SD4JS+ift2qZ7m1y/JoMTWK+x9WgvK
	IZA/o6s6bu9njqi5CmPw515W86y+KuiUnvDTB8z2x4S6cxfq1Q4L+pZkLxDgTrR8rAgKDjwRtaS2D
	rcHf4CEdHHe5ywOpXh7Yopo18B3ruY7JobO7sbb3xrYJn9+u5fECo71REgfFDc895rdXIkdcYyJVr
	DaN4mufZ030XyGo0GoNlYXCWeiTNJKk4w4jVobNT+E3vnbUFtVAjXHd1w0+DWziG9KO6OuV2UHR4T
	PMRJuIetazDIj+o/b76w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDUeB-004Ssf-HD; Tue, 10 Aug 2021 16:30:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDUe9-004SsF-SB
 for linux-nvme@bombadil.infradead.org; Tue, 10 Aug 2021 16:30:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=mGKBrHdY9IG/3hlkWy+NcMjSLP
 jBvCLjluPsp6zbgKG8G3W+QFC+a4IpjXdCvUxNQs5Ivh+Huen9ic5vNi2vEfYwiKnUm/jJJ3neNOf
 j0uKYQoSLZJxIaWcnj63WGjLenYTfBgE+FUNBzdfqpImxuhyCTlnAlhBy+NuYP7wzSg9mkEqjHk+K
 AOBBOS1qyrDY1oVbqti89sM7kqdT9lHeFz+YX0L0/ED8/LNKzFgZ0n1bTJGlwFyaRmytXti7ROdBp
 hxLHirqhNVQPbCoBvOTQkCi+rpIk8YrKxskQmcG1GMvUOzybf9JQSAWTJg/DjbROicGhxIYobz4AD
 7TB099xw==;
Received: from 089144200071.atnat0009.highway.a1.net ([89.144.200.71]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDUaw-00CKqK-55; Tue, 10 Aug 2021 16:29:34 +0000
Date: Tue, 10 Aug 2021 18:24:41 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Ruozhu Li <liruozhu@huawei.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, lengchao@huawei.com
Subject: Re: [PATCH] nvme-rdma: Don't update queue count when failing to set
 io queues
Message-ID: <YRKoSd+0QXPK2pM7@infradead.org>
References: <20210728094120.27041-1-liruozhu@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210728094120.27041-1-liruozhu@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

Thanks,

applied to nvme-5.15.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
