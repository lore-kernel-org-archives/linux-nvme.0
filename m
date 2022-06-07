Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36F9AC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 10:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBM3SjSADpCtaGTcU20MqvmhiyUnvgFDR0aC/pBuNI4=; b=bRo1cDgkzGIatmsOYFuGq9wgFf
	6G8RAEPPBsmn3sQFbSXyKwDUIkJD3TK+nOw+6xIyjkkznTSYiCmZm9MUAo8Yka1xDmQ5e6roKJmzb
	hIgtcH5bjD9q6yMdD/Lzx0aAaJ/z3uqUz5qe/kZDo4qgS4Ffq6CxS5yRx1MqJ/smCZ0osJdU7X6WI
	yH4i3Arx0Mc6Xtg99nonq2dFsi1uX7QAMzY6U0eOxA1oIkouUhJdS7HsC0gGqP2GEuRSQKda1vsub
	RjdNRjrB8No4XPIQmlELsKLrjclRUUoD8ZwHfGtGxZhS+4XxtTd3T51GHkZSoB1i+zXEee0WuJeUE
	RP7G4jpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyWQ8-006djK-1K; Tue, 07 Jun 2022 10:26:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyWGZ-006Zr1-5Z
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 10:16:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6F05E67373; Tue,  7 Jun 2022 12:16:48 +0200 (CEST)
Date: Tue, 7 Jun 2022 12:16:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stefan Reiter <stefan@pimaker.at>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG
 GAMMIX S50
Message-ID: <20220607101648.GC23881@lst.de>
References: <20220606130116.87146-1-stefan@pimaker.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606130116.87146-1-stefan@pimaker.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_031651_376549_89C2D3B4 
X-CRM114-Status: UNSURE (   8.57  )
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

Thanks,

applied to nvme-5.19.

