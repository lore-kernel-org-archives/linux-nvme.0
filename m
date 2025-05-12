Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 226E3C3ABBC
	for <linux-nvme@archiver.kernel.org>; Mon, 12 May 2025 04:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=Lp7EohmoqgV5vnTrsqsRtntsdN
	3ev5PuWX9+I5Y07WguNCdvMHmUdS6a4nEdbEx4A6/O5YNkKkmtl9q7rUXqsUNVLl/52uIWrfEdBlH
	An38t2quXgqO4+TjdJ+0f+DaCenAa5GSAC5Q4uQVHa7+ToKL9DyYL3HpstY/1YXgcBQZUv7A29HH1
	V/9+6fBD+WU/3eYDSBvBNj1jFDgazRSHI0s689VYqApsiBcUBsQasdiRF9dAMwH3ZyRy807FEK3In
	9swcc3tAk9Hkse9BLtynA38oaOrkkL1z1PYFpXf9+Eq6b88reUDIDWxso8g6WSKxosj9gS4KjNEX7
	PnCp43xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEKfH-00000008KS1-3yog;
	Mon, 12 May 2025 04:21:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEKfA-00000008KRW-15OX
	for linux-nvme@lists.infradead.org;
	Mon, 12 May 2025 04:21:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4517768AA6; Mon, 12 May 2025 06:21:02 +0200 (CEST)
Date: Mon, 12 May 2025 06:21:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
	martin.petersen@oracle.com, hch@lst.de,
	linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4] block: always allocate integrity buffer when required
Message-ID: <20250512042102.GA600@lst.de>
References: <20250509153802.3482493-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509153802.3482493-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250511_212112_432796_59B87A24 
X-CRM114-Status: UNSURE (   8.11  )
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


