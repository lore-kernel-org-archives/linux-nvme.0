Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748D0ECAAA1
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Sep 2022 04:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bc9/3RFQ3/BYv5GKcvhxJWM/+fz93rvd/+K14B4oPhk=; b=Luj6HGI/jgbG+h7tOxPb0yQLhE
	FQPKTQimnK7Hd1hHiyQqpTuRs5wCfRUdirrcNLTPQnPptNDKCJgSilXPz5EEZlY+oaqr3CvyoCL22
	aNjqjGEXs0hIZCefIypllwx8751UVv4E5r+l2w/y1xUmUB4q6lNpMLkd942AC9moMIrAKHRj23hG0
	rDvbrDu54dASsuzKxAH4i5XRpWr2G+tb0Lutqmmydn7TGe7ckqWFZZjmK0A4x1J4n+np51l2riPqC
	E5MBxnZ5V++FLrn3MhFd0o9dWdnCuN2ua8JetiP9VNACh9xxIV4Jy20cyUo6NCRO+3nC58EJbpRS9
	0lPnUW/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVQQt-007iVD-Lq; Tue, 06 Sep 2022 04:43:31 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVQQh-007i3z-WB
	for linux-nvme@lists.infradead.org; Tue, 06 Sep 2022 04:43:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 534B168AFE; Tue,  6 Sep 2022 06:43:17 +0200 (CEST)
Date: Tue, 6 Sep 2022 06:43:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Jonathan Nicklin <jnicklin@blockbridge.com>
Subject: Re: [PATCH] nvme-tcp: Fix regression that causes sporadic requests
 to time out
Message-ID: <20220906044317.GB32413@lst.de>
References: <20220905150706.1529358-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220905150706.1529358-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_214324_772464_80039A2F 
X-CRM114-Status: UNSURE (   9.54  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Thanks,

applied to nvme-6.0.

