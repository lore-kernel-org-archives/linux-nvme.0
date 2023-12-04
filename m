Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF40FC4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 08:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=XM1T9yY+DC24kUWvmWRHyTK01f
	KQ3fImWtLt4kAqp7AO4q9fYSjPitMm9huxvfc4q9OphXXqQrJSH/G4NQcmtFuybmaPJiHF4uqDCQr
	dXxASPJ59tGGscsk9heuaVNCJH1WVFu4dKdGNeAkYdYhT8m8AGE7ywZoH1wRzbPU1m1NT4gdh2YB1
	6pQ7GvrRcuMjjx06q/4JWK/qCkh0Vb7zv68UvGN3Hz8aEfb2FKnY0/GXEQ+LoPGEpHxcax6yM+nUq
	dqnzoVV5YhroQRCOGFXm5co7RbJtfRAMeKmoHtGFhzOM2nhM3quRhrqO5RBVqAfw0iP6SsBiumZNv
	2Nz9agNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA40R-003DhP-0B;
	Mon, 04 Dec 2023 08:08:43 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1rA40P-003DhG-1G;
	Mon, 04 Dec 2023 08:08:41 +0000
Date: Mon, 4 Dec 2023 00:08:41 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme: improve NVME_HOST_AUTH and NVME_TARGET_AUTH config
 descriptions
Message-ID: <ZW2JCbgiYx2cMfHa@infradead.org>
References: <20231129044951.610759-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129044951.610759-1-shinichiro.kawasaki@wdc.com>
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

