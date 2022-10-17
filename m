Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA56C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Oct 2022 13:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VQbyy/D7LC97SzscywIrFQwO7dBWQP+ez+pmd16FoqA=; b=mM5vi3TvO69hK3PSmLATcz8Cb9
	dpOTJogZjOjbHMO5rnipGr0R6AHsN3T7RSpLH5uL2ARMTzIm3goMgooOUHNvE9AlLZCyNkipTwBfW
	WC2pMX1UINj7cLTsfnrOp3pGHBAzfD40DDVMjEysksYBLmc9iNO4yRNwZass5hJCVodMm9/m7p3nI
	7bUzNzaPlYdADZTiv8/GjM705HFF2CjC/t018O8bvMTHLflwGUC/8O/swR7HgTUWl2XgA0+x5O163
	oW/w7PRtC/IakK1VGPiYkvcI8fgul48L8X2rpWbyulNsbFpoVoZUaGflxt+Z6JfvNrpFa0aA1kYCL
	WhXz0lAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okQU6-00CJ3Q-0W; Mon, 17 Oct 2022 13:48:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okQU3-00CJ2C-S1
	for linux-nvme@lists.infradead.org; Mon, 17 Oct 2022 13:48:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0FD9768BFE; Mon, 17 Oct 2022 15:48:44 +0200 (CEST)
Date: Mon, 17 Oct 2022 15:48:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Chao Leng <lengchao@huawei.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
	ming.lei@redhat.com, axboe@kernel.dk
Subject: Re: [PATCH v2 2/2] nvme: use blk_mq_[un]quiesce_tagset
Message-ID: <20221017134843.GB24959@lst.de>
References: <20221013094450.5947-1-lengchao@huawei.com> <20221013094450.5947-3-lengchao@huawei.com> <0b28653b-b133-ec4b-b09e-54090f374086@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b28653b-b133-ec4b-b09e-54090f374086@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221017_064848_067911_7576C610 
X-CRM114-Status: UNSURE (   9.60  )
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

> Something like this:

That definitively seems like a sensible prep patch.

In the long run NVME_CTRL_STOPPED probably needs to be integrated
with the controller state machine, and moving it from the ns to
the ctrl is a good step towards that.

