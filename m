Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEA71C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 06:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=V5sMgGPE8G3zpY+T4f2+gAFf86
	d4rZ3suor77ueB4osRBGnhy0ValAvstmoeHDf8lIQsVGY7UgqN02uuLOF/lTYRLEcqOFT7GZiCnEY
	5q41oYGIqk1ou+TdusFHB5VHz8W8uF6HI4t3C2yn9BvwVzNreRq6qT9CExSdgoDDQIWPVCJeJqLc4
	hT7sPxj5PMOH5KudHeqAc1xXT+dy1teXsIfgPGzCA5HCZX8snfneiuBUpiLrYD+yAlFTkH8d27cKF
	MvvFePpdsaQkjsTsH7OmolO3BtTLCVsuKUiWnR/xIN0TPLwSyy9rCl8CAAkdhJzd/nZbPG3cG1vXr
	5Uwo9KUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAOh-00000008INt-2NRH;
	Mon, 13 Jul 2026 06:44:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjAOe-00000008INQ-3DsZ
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 06:44:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0A47E68BEB; Mon, 13 Jul 2026 08:44:06 +0200 (CEST)
Date: Mon, 13 Jul 2026 08:44:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-tcp: bound SGL data length before allocating
 command buffers
Message-ID: <20260713064405.GE29416@lst.de>
References: <20260709132533.44195-1-security@auditcode.ai>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709132533.44195-1-security@auditcode.ai>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260712_234408_955981_6352B908 
X-CRM114-Status: UNSURE (   8.86  )
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

