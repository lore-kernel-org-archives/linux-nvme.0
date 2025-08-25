Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE7B0CA0EFA
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Aug 2025 08:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0+4M3BUA9zvD8BaTM7hRLHCZrT6kLmaOitXDirkEl00=; b=ueWOImcACEHwKdiiuyp8FKi8Wc
	bSSLP7pnAp+lN3KrfBXc4EFcGr3t6YLO48mHI+2+xgunxcvwJptbOkif6zoeuHyqD8CI/sKN8FSka
	lR2N/W/v0XIflTxY2594INn4XSyDQeFHDMQtllZzSNSpko2Bkyl184M4Nig8Xgku2fUnFE91bkeyI
	fwxt/wld20FpHEaij2Y/imaGBsh6YNHnFPGhMJMlt9DZO9vk+24+aGigtIPSQUw7jVf44OgsPy9zU
	hBEsGzLnEKGBlPOvJkkp0w98W8cY/CHAgb+Jn1PQ1i2vlvDMhJAZdx8SEJAxnojnzCr+a7QqsEfyF
	jvTVucJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqShV-00000007L5H-06hG;
	Mon, 25 Aug 2025 08:37:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqS3L-00000007EKI-0HcN
	for linux-nvme@lists.infradead.org;
	Mon, 25 Aug 2025 07:55:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CF51C68AA6; Mon, 25 Aug 2025 09:55:26 +0200 (CEST)
Date: Mon, 25 Aug 2025 09:55:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv7 0/9] blk dma iter for integrity metadata
Message-ID: <20250825075526.GL20853@lst.de>
References: <20250813153153.3260897-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813153153.3260897-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250825_005543_238718_A9A55E8D 
X-CRM114-Status: UNSURE (   7.64  )
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

Jens, anything blocking this?


