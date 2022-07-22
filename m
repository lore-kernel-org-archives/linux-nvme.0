Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075A4C43334
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 04:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OKoPl6pkKwqfVXv0tkCsZkhTLVRcHEZ8byA5r6vMqzE=; b=vEnH+g+goV5yTC22CvBZnX6rEB
	uef/vzzhtZ+j1Kuvlxcjpkvh/K/XTxS6tFgAlx2GrCGNyOXcpPqlGmzwnbhcEFVrd6uqiwrxZdh9S
	Rs0qDpI10i3IoSWkquc47bKFNYPqJO6n7qpTi0W822sfeK4A3K7ufrS6rxHIWyx9Rdz48zmi+fXyM
	8jZeh8+rMhXk2JzpNXvJdDytZ+iBOE0oAjK3n6VGnU9xL5FMRYNWjLIMokRSK+/SjZz6+NbK49WEw
	iWyj1qHhf8frrhORil/ahKWY2AKZCco4WzIU3R2X8+lnDWI/n60twLIbM/FdQrptKguGUuTpiCR1u
	W4tn5XkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEkbd-00HYcx-MS; Fri, 22 Jul 2022 04:49:41 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEkbc-00HYci-Ep; Fri, 22 Jul 2022 04:49:40 +0000
Date: Thu, 21 Jul 2022 21:49:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: consider also host_iface when checking ip options
Message-ID: <YtosZB0mt7qTG3eG@infradead.org>
References: <20220721174414.28294-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721174414.28294-1-dwagner@suse.de>
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

Thanks,

applied to nvme-5.20.

