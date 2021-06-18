Return-Path: <SRS0=tf27=LM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F361C48BDF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 14:18:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80647611B0
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 14:18:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80647611B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JZ5oGTVT9gWV9HI/egoBRzGTpij2WnVmt7fB/HTB7LY=; b=LMVSMJ01EO6jKm
	UJQRW+7bBJ95HSPNi9aJmq9H0EZ4CgdMXAMh18lPDU6wtp6Y8fpIwCLc+Y7/HZo/TwG7yTiNR8K07
	2MBxZVbtRf7kGAIq7xr2Pkn2+d32pIU4X9DX+b8aIIJqnZaFNJYOTi4efMol7bShDY4IK38a6F1r5
	1QYM7MHJIwYWB1skvO24OtE2kF9IalJCyo7eumFocXxTRZk+fIuwtsBr4Gu2NqJez+U8EdVMqKye0
	kM+p+iwYKRdKVo/kGWT2DkwKk6Lvjj1sW+zgCvxpP/J8WbZ33y/6/zFmSlSEMJWJuBq+gvHcLnaFg
	aZ09TGHJAejtgWFk4xFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1luFKA-00ES7G-QS; Fri, 18 Jun 2021 14:18:22 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luFK8-00ES6f-Dx
 for linux-nvme@lists.infradead.org; Fri, 18 Jun 2021 14:18:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 92AA668D08; Fri, 18 Jun 2021 16:18:17 +0200 (CEST)
Date: Fri, 18 Jun 2021 16:18:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: zhouchuangao <zhouchuangao@vivo.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/nvme/host: Use kobj_to_dev() API
Message-ID: <20210618141817.GA18781@lst.de>
References: <1624025458-56465-1-git-send-email-zhouchuangao@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1624025458-56465-1-git-send-email-zhouchuangao@vivo.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210618_071820_657842_E093A865 
X-CRM114-Status: UNSURE (   9.83  )
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

On Fri, Jun 18, 2021 at 07:10:58AM -0700, zhouchuangao wrote:
> Use kobj_to_dev() API instead of container_of().

Why?  That just makes the code harder to read.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
