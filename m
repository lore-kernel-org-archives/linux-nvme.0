Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2536C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jun 2022 05:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QciW70HNAghgYNw85WXe2mAXWXJu69xOxrUKNGEuBZk=; b=JfQXqKuXxPKCFuYWnaKB9IjF04
	zMc5dlgbWpUSIChJTd3f+hOeg+Elqcer571sFZq7zzGzTaBw9esg/Th98/TaCac06Is3f+R2LcLa8
	fEEZ9I2vghGahA/2gQbiHrxKcSTTCxE0OiRkZ00D+x66tq/ZrgWgBugJUjAruBsIGWp5ynSft0co9
	dVTbi3FIO92Y7xBzoPjqckEvPtD1gF1kNwzbfolbD719MDVwp3MfLZGV4z9nRAzG4FEtmj8RGxbZv
	x4IZiObiN6ci+0EvqJf7FBxNxhzDKroKf568Lg31cgqYZPtNOvR40dT5gwDEbChsd7n0dn7yWVW2j
	fPEbYOXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwGxi-00Dw1M-Q7; Wed, 01 Jun 2022 05:32:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwGxg-00Dw06-9M
	for linux-nvme@lists.infradead.org; Wed, 01 Jun 2022 05:32:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8E54A68AFE; Wed,  1 Jun 2022 07:32:01 +0200 (CEST)
Date: Wed, 1 Jun 2022 07:32:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@fb.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	Kernel Team <Kernel-team@fb.com>, hch@lst.de, bvanassche@acm.org,
	damien.lemoal@opensource.wdc.com, ebiggers@kernel.org,
	pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 11/11] fs: add support for dma aligned direct-io
Message-ID: <20220601053201.GE21743@lst.de>
References: <20220531191137.2291467-1-kbusch@fb.com> <20220531191137.2291467-12-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531191137.2291467-12-kbusch@fb.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220531_223204_515505_4F2AE04B 
X-CRM114-Status: UNSURE (   8.98  )
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

Looks good with a s/fs/iomap/ in the subject:

Reviewed-by: Christoph Hellwig <hch@lst.de>


