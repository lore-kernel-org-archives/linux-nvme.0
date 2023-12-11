Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D154C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Dec 2023 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=aMKX/xeG0j2NJIz+/9Md4Pu0EB
	hULyAsaU2VB7KiRacrdE62GzismvG6yCE1zxunPQ6YIS1//M77FApGPFl47hq4CdU87tbMCU3LJhJ
	B7VinwbrcphDvLDIsWU0aN0cwSnspCeC6j3DHDnLRg69Az1FnJ/QFN9c3IuAJGhzsaTowKIDkd746
	QQFmCB0sDRDYYu0apZCQEONno2y5om/zx6iJ0LRzsPkRMgKhAj7wW+rU/u+WoFPlB//8L1P2KL4Ax
	CU+4aNXXS0+Nu6dWLwXu/t7X37Oyct3w47T4U9XDotlKPFi3O3GuuPBKWE3L6Kw/A4FPwo2RvCrlK
	LKIfEmOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCj91-005oeu-2m;
	Mon, 11 Dec 2023 16:28:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCj8s-005ocN-0y
	for linux-nvme@lists.infradead.org;
	Mon, 11 Dec 2023 16:28:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A8F1168B05; Mon, 11 Dec 2023 17:28:23 +0100 (CET)
Date: Mon, 11 Dec 2023 17:28:23 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v5 3/6] nvme: refactor ns info setup function
Message-ID: <20231211162823.GC24001@lst.de>
References: <20231208105337.23409-1-dwagner@suse.de> <20231208105337.23409-4-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208105337.23409-4-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231211_082826_645757_051E1ABB 
X-CRM114-Status: UNSURE (   9.00  )
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

