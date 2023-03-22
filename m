Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FBEC7619A
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2hgrkPgfB3GRsCK3NmF2r7zO75FK/ebcJiITpxQa4w=; b=RysCo1yXyGBE1LZwLc9xc9E7d5
	n1MrXKLiNA7ayZLFqTBe0vwiL3jxCrBYLxM9Zu0ng/shSD/FDIuBogHtGKYFOfG5fADRlJA2CPqBs
	F9jelw/ktzjE/hO260o5+tUdDtnLtYvAYoajma1h6Yka9BIrmQBCzKwUMoTkAhgFEqOTLv9zyaPEG
	PumAQwSMyRN5991X4rqZjY+noVK9BdntzU3hczK6FB2jFjKMUZm6lo4Kn7QcK7nu1zOHPXVF0Ue83
	A5SFfyKBok6DCW9f3wcGSC0wLXLvDaKdIHRL0UhTali1SxukezOxBe2C7vRNsmL/jHRuXNLDWJ6IR
	weJBFwiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1petiH-00F9J5-1D;
	Wed, 22 Mar 2023 08:20:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1petiD-00F9I5-38
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 08:20:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 03B2568C4E; Wed, 22 Mar 2023 09:20:47 +0100 (CET)
Date: Wed, 22 Mar 2023 09:20:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Caleb Sander <csander@purestorage.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Arnd Bergmann <arnd@arndb.de>, linux-nvme@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] nvme-tcp: fix nvme_tcp_term_pdu to match spec
Message-ID: <20230322082046.GC22321@lst.de>
References: <linux-m68k@lists.linux-m68k.org> <20230320155736.1492682-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320155736.1492682-1-csander@purestorage.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_012050_154865_DCD13806 
X-CRM114-Status: UNSURE (   9.74  )
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

applied to nvme-6.3.

