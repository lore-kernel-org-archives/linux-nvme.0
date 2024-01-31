Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFC0C47DB3
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 17:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=WepX1aaJln73zpNbMY36USituu
	YwkcKwtP2T39aGmlIaaQ2r2wHtr3m2l9dXs4dVWv6sY+LXnVXYCmoLADf5w1f/s972RRBjqYsKvd4
	mlG+DCEtegM5ox+4plE9RLfLTYL19X4jbZju8II+rA7UXoJzFsPLqtcrqJlzkvOju0xoJyNMNB5nV
	H8ofU6uQXN4XEt1GqRLsNrePYeNjYDSWVSO12sZGvojNxY1y97rFvLedqs5gM6lg/fl120+PV26oJ
	WDpn6t+4Y8xF7Q/4ZMWkpP40vX2idX0e9OjpsY3cGtGrKuQZeg1FfII07WtMN6UNhEZr067xlbRh5
	S3MmkDiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVERz-00000004qnl-31Yb;
	Wed, 31 Jan 2024 17:32:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVERw-00000004ql7-2Vaf
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 17:32:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id ED7C368AFE; Wed, 31 Jan 2024 18:32:33 +0100 (CET)
Date: Wed, 31 Jan 2024 18:32:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2 3/3] nvme: parse format command's lbafu when tracing
Message-ID: <20240131173233.GD31567@lst.de>
References: <20240131091222.116190-1-kanie@linux.alibaba.com> <20240131091222.116190-4-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131091222.116190-4-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_093236_858623_5F9FDFC7 
X-CRM114-Status: UNSURE (   9.09  )
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

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

