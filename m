Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B7BED3B7E1
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Nov 2024 07:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=JpGEwYrXszINwFu9ZWoCoYd44K
	KMwKJuTJVW5KdCxrAU01ji3G6MKfg9dd1lCtb/cz8izMDWdRZ3A9/og05xgTNxBftXYxMuvlBdf4t
	QEkriUZnsm25oQ9lmuefcM+q7ARjM8FN8OB+UqJDrNrEfZ+lMuuEpUBdc515lVXVkWZhvOLY8226X
	2pOsdYDJIbbPQI0wNa2ITVBibigFalyFroPF/N2ir1ksLV5AleQshOiMI75glt4nff1L8uLvArVC5
	T5E7JhF0S5a/nD7KlOIBDOryOnl6rZsKEC2rdDOfDdczCSNHuC8irLAz30x++Y5UIX1Xgm2ixWkty
	rsw4VPNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tFTR1-00000007EeX-3ilc;
	Mon, 25 Nov 2024 07:23:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tFTQz-00000007Eda-1C6E
	for linux-nvme@lists.infradead.org;
	Mon, 25 Nov 2024 07:23:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C8CA568D09; Mon, 25 Nov 2024 08:22:58 +0100 (CET)
Date: Mon, 25 Nov 2024 08:22:58 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] nvme-tcp: simplify nvme_tcp_configure_admin_queue()
Message-ID: <20241125072258.GC15647@lst.de>
References: <cover.1732368538.git.chunguang.xu@shopee.com> <c7006c36681afce811e01de7686d6e2df2c4ab0e.1732368538.git.chunguang.xu@shopee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7006c36681afce811e01de7686d6e2df2c4ab0e.1732368538.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241124_232301_456741_88200798 
X-CRM114-Status: UNSURE (   9.28  )
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


