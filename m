Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653B3C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Dec 2021 17:53:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=Ok1iBXJgO5EY6uhonpivX5vx48
	beVLlZiqcUVIgKyKcm78cjOUWYSdg/5PrxMoVsPn+zjesOtdavW4LSZJtxGXtfoNgCv1KFpNpYlu6
	YRrYjn1dYxzeYDEbJ+DwSRhdrfguezzQTbaYveTRonfAOYlu10iv0KTMGOPu/dRQwzlVLQGlJTHyZ
	JXRhcWo89mjDv1pf8JWUxMDj5EsiJxejGIkAjL9fRM+zgu900fR3qRHo+q4DwQ6Rb0vzC78vTOANC
	0PjOO8uV4oXfTEJwJ2w13wFlkiiqmHVTIXNovn8qhHsYrYotbR1REwQ7KVIzYufZqW2iw36iZd7/m
	HqFjfc8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mxuwV-0072OA-8s; Thu, 16 Dec 2021 17:53:23 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1mxuwT-0072Mo-2I; Thu, 16 Dec 2021 17:53:21 +0000
Date: Thu, 16 Dec 2021 09:53:21 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Hannes Reinecke <hare@suse.de>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH 2/4] nvme: split command copy into a helper
Message-ID: <Ybt9EZI1wQ4k/TPa@infradead.org>
References: <20211216163901.81845-1-axboe@kernel.dk>
 <20211216163901.81845-3-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211216163901.81845-3-axboe@kernel.dk>
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

