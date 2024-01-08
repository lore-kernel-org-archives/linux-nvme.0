Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79D6BC3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jan 2024 08:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=4ON6rC+JwLcuH0NjA7vw1AvzUI
	j3PkmEsB31uCzQx5y0uqq88mm0k9llM3V6AtC7OsRZef6fQWaDs13K/bW/AP7qXcIIYnagXzdn9Nx
	QhEulMGVs0smYl7kGIPjI2fpNrtkfe6UklkY8Vv4RniXh/ukM5mHdWJDvzXazd+PxsO202SmXWpq4
	Muu5IJS9GyUBV9YzcxoZiqiCqNy8S6zzy+BXds2AFwpIQmp1BMUUx5sXEkNguGZp1sSChHgrvCEi7
	9BoTSATzQhaNUltmmDW66SM8ez1WGftGIuQXD85e/Gs0IHYLYFpgSHUx7Z9VoSK9UTv/A6XtO6xRD
	Wy4vEtsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rMkx4-004I8s-2P;
	Mon, 08 Jan 2024 08:25:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rMkx2-004I8C-2V
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jan 2024 08:25:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 25DF568AFE; Mon,  8 Jan 2024 09:25:38 +0100 (CET)
Date: Mon, 8 Jan 2024 09:25:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 2/2] nvme-tcp: enhance timeout kernel log
Message-ID: <20240108082537.GC4517@lst.de>
References: <20240107002950.6233-1-mgurtovoy@nvidia.com> <20240107002950.6233-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240107002950.6233-2-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240108_002540_955223_FD5F35C3 
X-CRM114-Status: UNSURE (   9.38  )
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

