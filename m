Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA9EC369B1
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Apr 2025 05:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2aiSSfTARXLXB+2b6Ug2v7LTxgYSipXgqDvEptgUSWk=; b=zAOm9jYa04nPPbjREewCFFTzYT
	zJw+O08gejuOqa5s5L7c/Fxa04owWq/p07cqjZHPFeadKLTod77PUQyRcPa2D0+HIm7TLjCOzGwZL
	cSz+Z37d5MSFXLPRUX2Niqm9ufeo6Bh7G7rzcVntaZX6gNGDXmxfXswRi9/HAtsc/FepZQoa7gmNx
	nMfnl1SZVb4QTjWspYO7RXWpNcgegdeyU55lan0HpK+oXxYdTOyR1dQs2dceQ/VsOq06LzvfxbN9V
	uHCY55rdAWzLzi8mF1rXvnBeJaxOIMiaN26mV/fQZUjgd4XVJzG4IUp9ArM/XpT5QBwPrnuBluthE
	2i4+otsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4vUQ-00000008IuI-2lrI;
	Wed, 16 Apr 2025 05:39:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4vUN-00000008ItT-1xsy
	for linux-nvme@lists.infradead.org;
	Wed, 16 Apr 2025 05:39:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2C0F668BFE; Wed, 16 Apr 2025 07:39:08 +0200 (CEST)
Date: Wed, 16 Apr 2025 07:39:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v2 0/3] NVMe PCI endpoint target fixes
Message-ID: <20250416053907.GB25042@lst.de>
References: <20250411014211.1070887-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411014211.1070887-1-dlemoal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250415_223911_642692_2778123A 
X-CRM114-Status: UNSURE (   8.34  )
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

applied to nvme-6.15.


