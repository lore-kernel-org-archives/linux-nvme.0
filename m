Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D23EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 13:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=WJf3pthuQHlA4c7snIWPnXubmD
	VZnQttKF8VqaS5FIEnKp2ZT6ScP98JNvb/bLJDIiTFtoJIy0f2ay/Cgig0Yo9ypCiY4SeiMTogTqa
	pOo8LgI/i+zGJ9/9Pe43ROCH5Eie5LxsxhlHmE1K0EOKzw+51nEKN9mZEnLsRzVm6BDBWkESUDR6U
	e14Ckkl6emv7owkBTuN7lQqNFN8nkuS2Wbfriof8nlajocC1VJ6NLtt6Ywm3C4f8Yw657CEFod9ww
	oimzw6B91UFDpn6xLZ0qN3WmcNaE4+0Gr7Z+krcRlZ4cYDwE4y0mVzxDsIrxtYat74MHatKifc0BB
	SHaY5HxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odtZN-003Gth-Bq; Thu, 29 Sep 2022 13:27:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odtZL-003Gsp-0E
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 13:27:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4EE9B68C4E; Thu, 29 Sep 2022 15:27:12 +0200 (CEST)
Date: Thu, 29 Sep 2022 15:27:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH for-next v11 09/13] nvme: pass ubuffer as an integer
Message-ID: <20220929132712.GD27768@lst.de>
References: <20220929120632.64749-1-anuj20.g@samsung.com> <CGME20220929121701epcas5p287a6d3f851626a5c7580d9a534432e9b@epcas5p2.samsung.com> <20220929120632.64749-10-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929120632.64749-10-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_062715_192151_B4D243CB 
X-CRM114-Status: UNSURE (   8.25  )
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

