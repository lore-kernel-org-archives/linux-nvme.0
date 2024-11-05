Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CDFBD2C114
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 14:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=CFO4y9t+Uq4DVgT26Ef6AIVWX7
	VibNTDFM5lhP1olVMzDQF/PCViOSpMArT6p3sHtgmDmwz3yQPO0BPdzaBygkM+z91/H+xpGrTKLJ0
	jYDhVIVZGcX2lI6+56b82rs27FsuvYzPzNTfvjMZlqqVY3PMb427icE1GquHmd1R3PJzBt9upPMjq
	PUJzs27Zza7idEZL2srfH3SUbZ5iBruhlKP0BsSXvcosQoYnx0M6TNR/OIwXENTd3P9Os/YEAOujp
	waItKJVvwwah5Ozcq+CaEsM5FbVCYvlBS4ms4zn5/FlM35h7tbA6zBOdxodg4MKbOgCq5pv+WLWW5
	ZpaceVRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8L1L-0000000HM8r-2gbo;
	Tue, 05 Nov 2024 14:59:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8L1J-0000000HM7Z-0o5J
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 14:59:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CE9FE68C7B; Tue,  5 Nov 2024 15:58:56 +0100 (CET)
Date: Tue, 5 Nov 2024 15:58:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Breno Leitao <leitao@debian.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH] nvme/multipath: Fix RCU list traversal to use SRCU
 primitive
Message-ID: <20241105145856.GA6583@lst.de>
References: <20241105-nvme_multipath_rcu-v1-1-2d7450c1cd84@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105-nvme_multipath_rcu-v1-1-2d7450c1cd84@debian.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_065901_380430_B1FE78F3 
X-CRM114-Status: GOOD (  10.90  )
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


