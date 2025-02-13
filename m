Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C00A0C021AA
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Feb 2025 05:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=RLQrdFRytu9ho7Q5w6QYU+vUqp
	TYJlklvQIULeqIwyhYD/98H+jscf4saDK48pYGL7cWZJ1MI7g2dsXPd2GWYPmf3b2kTr8U8tEhr+r
	TBJES7Tbuo6NrQ7P3Qs93Gl/QSTBA7jEjrMwWvsZPE3mRPSHaxOrmFsW3gqPLP9G/UzPXCZJ2J3KV
	mSLV1U+4TaJSFpICZbOMj1QtNOkODHCXWvMk4efvKiaqFhgePTEzEvTXjoB9/tcII8zb+m/GUzlJX
	NyH8oB5/tMD+x7vFNnjS8s9Q21mnWgNYRNCevLDE7idUn0tVCz1KywM6cqZBtvXBEJBvC/ayOBUmI
	3/QVvWeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSCS-00000009qud-1KsV;
	Thu, 13 Feb 2025 05:55:48 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiSCM-00000009qts-3SBh
	for linux-nvme@lists.infradead.org;
	Thu, 13 Feb 2025 05:55:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8B2A567373; Thu, 13 Feb 2025 06:55:39 +0100 (CET)
Date: Thu, 13 Feb 2025 06:55:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Icenowy Zheng <uwu@icenowy.me>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-pci: clean up CMBMSC when registering CMB
 fails
Message-ID: <20250213055539.GC19370@lst.de>
References: <20250212170444.16138-1-uwu@icenowy.me> <20250212170444.16138-2-uwu@icenowy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212170444.16138-2-uwu@icenowy.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_215543_018162_E7F89C4D 
X-CRM114-Status: UNSURE (   9.41  )
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


