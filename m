Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA76C46467
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jan 2023 06:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=F7OJxmeh3U780JdbAoL+a+KwGP
	fXwHnw8fXeTbKezUXhWjmPoBMEh6KIjxGRxbPHWLMMKCi6a1JYHRZSgcS+zVySsMfVvaXxgNYAUhy
	4/w4Dachs50Hp9+anwJb9K12Tt+nvJyPchU9848yt8RTlOz68vpBpgnPOA4obUDt3IOhiCO8rGHvg
	mWuD1j+gHnSZ0zl2wtWhPy5XPaYXXLLU2DVgKr/Nn9EqU1fODBTrseh0kjTBwel03+hDisn0LCxNk
	t8iAkC/PYeNJBB8OPrOipK9j8eN3c7Yk31FxtJir+b2Hgw2JsDCZ3W9sSqIzr9ecTXeIJsPI6MHU5
	LBLZpEoA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF8VU-005WtU-WA; Tue, 10 Jan 2023 06:53:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pF8VR-005Wrk-Ef
	for linux-nvme@lists.infradead.org; Tue, 10 Jan 2023 06:53:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DE5A968BFE; Tue, 10 Jan 2023 07:52:57 +0100 (CET)
Date: Tue, 10 Jan 2023 07:52:57 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: axboe@kernel.dk, kernel@pankajraghav.com, linux-kernel@vger.kernel.org,
	hare@suse.de, bvanassche@acm.org, snitzer@kernel.org,
	dm-devel@redhat.com, damien.lemoal@opensource.wdc.com,
	linux-nvme@lists.infradead.org, hch@lst.de,
	linux-block@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [PATCH 1/7] block: remove superfluous check for request queue
 in bdev_is_zoned
Message-ID: <20230110065257.GA10289@lst.de>
References: <20230106083317.93938-1-p.raghav@samsung.com> <CGME20230106083319eucas1p1e58f4ab0d3ff59a328a2da2922d76038@eucas1p1.samsung.com> <20230106083317.93938-2-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106083317.93938-2-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230109_225309_674360_A6F25BA0 
X-CRM114-Status: UNSURE (   9.21  )
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

