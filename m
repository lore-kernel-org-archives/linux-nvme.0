Return-Path: <SRS0=1Q2H=NB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3FDC4338F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 16:41:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9287E60F02
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Aug 2021 16:41:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9287E60F02
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iuktLIzarvHjEJlKtxuBEUVUXP0f2R+/dgHk/7kC0YA=; b=4qCI6biTzdKf/L
	zATUXjS46oSptfzO3+oMXIdJwRYESbCraMdVO47AWLKHrvmIUu1uiYqpIHIKJtLIy+ruqofT0wUaO
	W+tENcOL2Ks49axQ9kLLV5/BYLAkCbgFiKK7yL9F7ppQ4ap8OkReTMUedKf/jJmVIyAlPxwFhX3Nj
	0DmsbQNF7ePfIJXKoopEE1G2eO1o1FemqKplO3gR+VcsgzOBBEyC2yIBMIeejrvmIzvkG+D6lOSw1
	nbCPqxHOwC86pcbaWwUCTQjShcnzqck5PuC39yJ0dOSRIfcHIUuhXfvuWKYgIOd69ff2EOKK5r196
	RV8SzfhbPMnaXECx/DBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mDUo7-004Tvt-Q0; Tue, 10 Aug 2021 16:40:51 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDUo6-004TvZ-II
 for linux-nvme@bombadil.infradead.org; Tue, 10 Aug 2021 16:40:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0YHLZvLC/xYlfH0XYhEFmgV1nKxhlxOO7Z/IK6ZmpAI=; b=GMYPAlB3gX2mDt6bTpC1NBRxFQ
 xPVznLb4Ha5nEAcYMjzeqMPlwUwHZQYDhZYBd46WYa01os5Axyp1P6KAgarN3BItRXRg+MgH7hXA0
 vqwQtQjSVj1r1XcNlOGr7oCY/ZXQxVxdbWdNa8kySLmvWDCH4o3Wg0jlb2Hug8gdQmQvQB5Tc0VEm
 BKDIOk+ibTQ3zY6yi086QGCnpL3q1AaWq8a032ohUgAryqfOgdc2nkFi5MPBQeYRKeUARUqWtGEaD
 NlLQd9dBNKPgdcRbTdgcMLnHeoFleDwOHdw1R3To3kemoB2k1U73yP3mrSn2e++nTTirJxmlx/Rb9
 zY0O1TRw==;
Received: from [2001:4bb8:184:6215:66a3:ba69:96b2:9e9d] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDUmq-00CLzr-B5; Tue, 10 Aug 2021 16:40:04 +0000
Date: Tue, 10 Aug 2021 18:39:31 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Ruozhu Li <liruozhu@huawei.com>
Cc: linux-nvme@lists.infradead.org, sagi@grimberg.me, lengchao@huawei.com
Subject: Re: [PATCH] nvme-tcp: Don't update queue count when failing to set
 io queues
Message-ID: <YRKrwzq2XpdM/8DF@infradead.org>
References: <20210807035023.27368-1-liruozhu@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210807035023.27368-1-liruozhu@huawei.com>
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
