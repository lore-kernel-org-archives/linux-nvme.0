Return-Path: <SRS0=ZvdC=KH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA94BC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 14:46:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C269611AB
	for <linux-nvme@archiver.kernel.org>; Wed, 12 May 2021 14:46:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C269611AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=TYJkWIkguCbO/8YJ9Bsh2ldoUjPikey8tJS/SdtniDo=; b=eAUfnDIriNjPLY1bkCAWYt2c4
	LtBtC+TtaxMn33Un9mQmYC7/uWcpediNdHiZIwpjJf+J5aOoerFxT7BJJMHtKd1jl+ysLunArjrZw
	JUGO4HzFIPTOeAHuZ+uOX8++89VSsSy5pfFv+xPFlIT0PGn1P5Rstk7fdksMrWQIrtFCGEd9oqqq6
	dj92DGoTuC92XaKZF6ZxgeS+W/VMiJc+vpGYC0J4pYVA2Qx0GatbHYr4+2xDBFyRveONMOEPk3iKt
	hdaJomZwuQ/QYc8tZsD+7+52uBO5zjt0C98lyexJ8zDnZXQkfwYi1h+lfOjn4kK/ybMJSuqoenBhU
	UyIQCb3uw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lgq8B-0034MR-4L; Wed, 12 May 2021 14:46:35 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgq88-0034MH-Ke
 for linux-nvme@desiato.infradead.org; Wed, 12 May 2021 14:46:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=3F77IAs5+apPy1obkepjXLHS8ulxZczD5gRq2/zU/BM=; b=AupSSbiNIDOs2WuDapaaMWP9Za
 sPTk6kRUVl8VOcNivmAzT1o2etksdNTrlVh/3udXXULWQr7rt0bZbkxCmmq+cxadRtMW/4QGLxbmP
 cmayUqEhvN5mG+dL0LLhfb0xmKyCXzb3DqGa3C/fJmi3+tGSZJrJcJ6UlW+nJhp5KHfXlO43+ANOo
 jY1u+jTwxARtcr8f9pmbUnEwVdc6NijGK7LZx3FXq/QQ/pNhk1DiXEAFFBQu2Uaj49Gz+/dyYKqAr
 OUwKJYDgJiCM+IMMhC+FETIJT7/eLMQPJanXk5yNYhg8nBcxM4HKTibGDhLnq9NB0cCoLsMmU5xmj
 mUDAqHcg==;
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lgq86-00ASXk-2z
 for linux-nvme@lists.infradead.org; Wed, 12 May 2021 14:46:31 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id C326EAECB;
 Wed, 12 May 2021 14:46:28 +0000 (UTC)
Date: Wed, 12 May 2021 16:46:28 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Enzo Matsumiya <ematsumiya@suse.com>
Subject: Re: [PATCH v2] nvmet: Reset ns->file when open fails
Message-ID: <20210512144628.ofxf5rwjwytcjiip@beryllium.lan>
References: <20210512144228.103396-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210512144228.103396-1-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210512_074630_290184_65FEEDCB 
X-CRM114-Status: UNSURE (   5.18  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Argh, obvious failed again....

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
