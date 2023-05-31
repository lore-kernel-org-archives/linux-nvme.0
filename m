Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0686C77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 31 May 2023 13:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JTjUFNNwRbeLnu7rGdyOMAYC53YgsnV2dLkj5Cq1Nu4=; b=y/Teu6QmEoI2/CAL1Kw3hYjSpL
	uZIND8wgsnSEey8cNnMc5Vqg+/4WOOz04fpKmC44RSOTO59357CbLhoDPSpaFF0XhQuo6bQ1jSOoM
	ybgMzDc8nTkOUykn7SSfPM+0FeXCmpZRWR3kvUEpms0lYdDKNgFwjdpK7CYlQlT8cFVoVHWjEVswV
	PaWzexK+1Iona2NGj8BQ4zEtnQNFtlLYqlouWuQD0iD8HM8zbAT7Hj2vBtAzxHl5ZU80WQm46oL/6
	qeW77hucAPabbUoq2k7kh3GVCZdOIXFZA0DRSEW4AQfTYcY6g75oPXNKk3vx0h9UdIXOcw2ghI83I
	8trEknVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q4LTE-00HTl8-0S;
	Wed, 31 May 2023 13:02:32 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q4LTC-00HTk6-03
	for linux-nvme@lists.infradead.org;
	Wed, 31 May 2023 13:02:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C3AD468BEB; Wed, 31 May 2023 15:02:25 +0200 (CEST)
Date: Wed, 31 May 2023 15:02:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
	sagi@grimberg.me, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme: improved uring polling
Message-ID: <20230531130225.GD27468@lst.de>
References: <20230530172343.3250958-1-kbusch@meta.com> <20230530172343.3250958-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530172343.3250958-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230531_060230_195616_CDF3F3A1 
X-CRM114-Status: UNSURE (   8.40  )
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

Looks good to me, but I'll wait for the rebase for a formal review.

