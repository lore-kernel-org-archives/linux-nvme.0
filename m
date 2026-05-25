Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9CDCCD5BC0
	for <linux-nvme@archiver.kernel.org>; Mon, 25 May 2026 05:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=KY2a6a21IjNFHZEps10tOalSek
	h74zHum6tNEldJhmAgTOjadokvFnY+du0xKFrAIAD+LsdXZLrz+z9k4d9BG3ZxhE2OMnNo5u8ZKCO
	zfK9dFtCwg2FtyYdLRWs1SroxkDiR5HjuWIETXBHefs4a3R0wr9kF4Kls9tUHhP68YX6vfoeUa3Q4
	+ZYX925k02dHjmll2lBkODjVlwYe60YyMFwIjCAFMMXOlZH4DE8FZr2uSUtMoQsS9iCByXlcRIRHl
	9sUha5D6r9kOgjuWq6ROalRtM4f3cK4f2je/nr69nWQgFH/kVdIFEzsT1gmPey/thTrGfAHQTBKYu
	0sHttwFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROIf-0000000GMoa-0LzS;
	Mon, 25 May 2026 05:56:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wROIc-0000000GMnc-2LzZ
	for linux-nvme@lists.infradead.org;
	Mon, 25 May 2026 05:56:28 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A57D268B05; Mon, 25 May 2026 07:56:18 +0200 (CEST)
Date: Mon, 25 May 2026 07:56:18 +0200
From: Christoph Hellwig <hch@lst.de>
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Sung-woo Kim <iam@sung-woo.kim>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-pci: fix out-of-bounds access in
 nvme_setup_descriptor_pools
Message-ID: <20260525055618.GA3293@lst.de>
References: <20260522150628.399288-1-mateusz.nowicki@posteo.net> <20260523082751.20453-1-mateusz.nowicki@posteo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523082751.20453-1-mateusz.nowicki@posteo.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260524_225626_739810_3C702A25 
X-CRM114-Status: GOOD (  10.46  )
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


