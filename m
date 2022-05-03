Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCE4EC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  3 May 2022 20:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PZiMd3Q4oO2ei8BrxWS/jm1DAna9XlyIO0npv8F07ZE=; b=3LNZnB+UeZ9UiHQG/k4S1Q01J9
	N9+DktN58+hvI3UVDH0TsTVg/AvoTrsX1fcbyNVL/+yyRaKXb1kXH1LIq5YrZsIygGTZO83ZCUUnY
	QbATx03QZcbbDs7iQcknQ16qfPDUym72QdErSBnXcBWn/1BzmGPJ9NLb6ADaKQd8yGg4G6A5nHnH+
	XsRaU2WE0dqsxKsqYFbVTpSRRrHhkRy8BKGuBa45hjeg7neVoDfuuHAUgdiEXRAxYxYlth1IOP7eF
	mvvCfDIgjE04WijXWeDHodSg9sR248rimgcXe7RviDvbPApcgkG4BteokvR9JtBm+DbvG0k4FZmqD
	WYVGrueA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nlzW7-007dyz-5F; Tue, 03 May 2022 20:53:07 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nlzW4-007dxr-EI
 for linux-nvme@lists.infradead.org; Tue, 03 May 2022 20:53:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 80F9168AFE; Tue,  3 May 2022 22:53:01 +0200 (CEST)
Date: Tue, 3 May 2022 22:53:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, asml.silence@gmail.com,
 ming.lei@redhat.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, gost.dev@samsung.com
Subject: Re: [PATCH v3 2/5] block: wire-up support for passthrough plugging
Message-ID: <20220503205301.GB9567@lst.de>
References: <20220503184831.78705-1-p.raghav@samsung.com>
 <CGME20220503184913eucas1p156abb6e2273c8dabc22e87ec8b218a5c@eucas1p1.samsung.com>
 <20220503184831.78705-3-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503184831.78705-3-p.raghav@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220503_135304_671434_38868346 
X-CRM114-Status: UNSURE (   9.88  )
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

> +	if (plug) {
> +		blk_add_rq_to_plug(plug, rq);
> +	} else {

I'd just do an eary return after the blk_add_rq_to_plug call and leave
the rest of the code untouched and unindented.

Otherwise this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

