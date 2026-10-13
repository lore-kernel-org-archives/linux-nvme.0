Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89458CC6B08
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=ig+UmEWSCgewh5Oh7zglAueQks
	vXeHaibq1Hd463hKSfEEfWxT30+aeG8HgRnSK71sdkVdMuyHpGO/rgc7GE6kArgHwzULhYcQZDenr
	8x8fegfAbPKl8H+sBkOXE1U8Wrwv42CmtCjTrc1SeTvgnGG8J756Lx3cyV/jPKKw9BMhXCWDUBFM0
	YGg18gBTacUUjHyervHjjKX488pL9guq5sRxTHfsYeBYQ6lUFPMkV4qEZfIKO8GzDrt8p96sK7zGE
	6LvRG6H15JYQFfOI6OH/TdaZ9zfZ80CJpY3AOz5FVi4Q8VEkbJ4Nd358g9O4Nymxarl2uHGmM/v8L
	rlvvydng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdWS-0000000D6Xi-2ZtB;
	Tue, 13 Oct 2026 14:30:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGdWQ-0000000D6Wj-2KIK
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 14:30:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1693A227A88; Tue, 13 Oct 2026 16:30:27 +0200 (CEST)
Date: Tue, 13 Oct 2026 16:30:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sung Byeongchan <tjdqudcks0424@naver.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: require authentication before property set
Message-ID: <20261013143026.GC15192@lst.de>
References: <20261007063041.26180-1-tjdqudcks0424@naver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007063041.26180-1-tjdqudcks0424@naver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_073030_737048_35869E53 
X-CRM114-Status: UNSURE (   8.68  )
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


