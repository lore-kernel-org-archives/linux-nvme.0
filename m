Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51DD1CA100B
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 05:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=RQtaKnq181Pp+hUnZJT9RrLpa3
	KMTIKdurfQD3bHxTOzAiwG4MYITCVubUQX7VoR9Mz0MIAxGkyIemsagalRwajVzYjQGfUXiMTPh7S
	gGWae0Ch+rCSOKS5XVO4F6sgyQY21WHKqBUDwyDllW5gYr7ey77iAUiRxQ97i/XJqv8BCw5C+KkW7
	FTk3iVbFgx1IDbFw68nblvpxhuZSmgbQUDpYFxiap2YYut0Lk2QEKM1QqFMhS6QS5LOCrjSSOBeVL
	DvwQoO52hK0SjiyHSwX3xwBaxsuG/CfvmXjXTFnNY10simVcK9ppF0KlssOxfBrt8SwvSWRgTaMU5
	EuxuLumA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utJaS-0000000FJ4M-0nqu;
	Tue, 02 Sep 2025 05:29:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utJYY-0000000FJ1M-3ASk
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 05:27:47 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C33EC68AA6; Tue,  2 Sep 2025 07:27:41 +0200 (CEST)
Date: Tue, 2 Sep 2025 07:27:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, martin.petersen@oracle.com, jgg@nvidia.com,
	leon@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] blk-integrity: enable p2p source and destination
Message-ID: <20250902052741.GA11204@lst.de>
References: <20250829142307.3769873-1-kbusch@meta.com> <20250829142307.3769873-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829142307.3769873-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_222746_935760_A148C83D 
X-CRM114-Status: UNSURE (   9.68  )
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


