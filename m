Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1973DC02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 08:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=YLbnOaIbl6eft82jmggoOyF1qY
	TRqiCECNk1JThsgrrcDrf76w84p4M9yVoVcIwS4XeY3Un9HEn96BQBhr4JvIqAd66QWNt+NJ8KB0l
	iXvAjmIeFBH2jDGSpL1M1xgVA6wVLGyekAFBtJzstSkuu82NAPznfd37PxmtmlCLIvp9rbYhbSMYH
	n4ECsffb1tL0oibaV1sZfHO9lPFyuRJEorQmdCZLqvPzFA50viU3OVQOT2NNfbv96MHDpi+ZLkm6R
	LHpodDqa8rcbZEmHnh2OVgkzbS1s0nRK/XHwhagMq5hq9vw5A6h3YvBQ77H0zrw8syHvARSpsPEHD
	zFVsYDyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYhSk-0000000HIJv-2eC4;
	Fri, 17 Jan 2025 08:12:18 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYhSi-0000000HIIi-2rb3
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 08:12:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5C9D068BFE; Fri, 17 Jan 2025 09:12:13 +0100 (CET)
Date: Fri, 17 Jan 2025 09:12:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Georg Gottleuber <ggo@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] nvme-pci: Add TUXEDO IBP Gen9 to Samsung sleep
 quirk
Message-ID: <20250117081212.GB26937@lst.de>
References: <20241216223145.135942-1-wse@tuxedocomputers.com> <20241216223145.135942-2-wse@tuxedocomputers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216223145.135942-2-wse@tuxedocomputers.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_001216_865425_47E245C0 
X-CRM114-Status: GOOD (  10.61  )
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


