Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03182CDE008
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 04:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=uDA8jfGzFLM6agy5/EAOI7aGKI
	hr+nXvnn+a/t0hjwZBzq+iO8FG1Q9o6a+9rgbshlIZPo4DhxgEll4wYNWYWdmLtE4r3Sos1SVNI4q
	18Ia0E0/QnMcKZTotK1k7JJ05IZEh6FD23osaKzemtACqtjWm9Q/7X06Ao/bUhbk/E3LpSkpRkZbc
	c+pMKV7O6HG98nWJYErxFkYX//MT4fIhYZ8utScfPmgyUVJvNrC0du+yUShhmiDmXNs/RsSyQq1+o
	1aLRDVAjdzno1L+O7av/5hKJPRDiPR2R1awTSBCcKdrqrzg12anweYDD6JT0jizZ1IsNRtEFD/dGT
	4Objk2og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcyW1-0000000AU91-31NQ;
	Fri, 26 Jun 2026 04:50:09 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcyVz-0000000AU8K-1aKT
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 04:50:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A865568C4E; Fri, 26 Jun 2026 06:50:02 +0200 (CEST)
Date: Fri, 26 Jun 2026 06:50:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvme: zns: include zone index in invalid zone
 type error
Message-ID: <20260626045002.GB8613@lst.de>
References: <cover.1782280420.git.liuxixin@kylinos.cn> <cover.v2.1782280600.git.liuxixin@kylinos.cn> <f6e5d4c3b2a1.v2.1782280600.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6e5d4c3b2a1.v2.1782280600.git.liuxixin@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_215007_567881_297B2628 
X-CRM114-Status: UNSURE (   8.54  )
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


