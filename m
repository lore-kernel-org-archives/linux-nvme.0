Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC59CFC266
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 04:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=nzYXt7VgDFPKNmYd1Da6KYJCjj
	pJm/Li+eBo14sa8KQeOTb/y2qSVGbjNdBQ0WRflf4peessRwe88fhqI4qZidHa9hQus+k777wF6s/
	dbsnFkiaeJWP/LIUBNBTEjsyocakxyQZ2Wlj3QYsKPoMLvY31tKR2+AcZabNVtooJKzN7yCRdDZNZ
	ZwvCiGMwlhgRLpYt4lBd/ugOSKrW+G6PU2a1xtfmzryHbkt1zt0pwMtgQriqFmGsdyAHZKMyDGPTw
	wW/yXPKOHHq1T8oMj15ffVrfbVlsPJSC9QNmQLuj0DXE7SUZj6P2EV3365khoCAw2cvAckLLMag/R
	MzWKCLuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ZbM-00000007496-3NxA;
	Tue, 15 Oct 2024 04:56:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0Za8-00000007441-2tbD
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 04:54:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 79089227AA8; Tue, 15 Oct 2024 06:54:48 +0200 (CEST)
Date: Tue, 15 Oct 2024 06:54:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvmet: add tracing of reservation commands
Message-ID: <20241015045448.GC18058@lst.de>
References: <20241014101458.80491-1-kanie@linux.alibaba.com> <20241014101458.80491-3-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014101458.80491-3-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_215452_876460_80585A80 
X-CRM114-Status: UNSURE (   8.84  )
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


