Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76AAFC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 06:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xBM3SjSADpCtaGTcU20MqvmhiyUnvgFDR0aC/pBuNI4=; b=rQID8AQ3olw6/ay4mGvJ8d8Vrf
	5JitctVZUvEfZvU8aaKKNb5TDSAGiNwiYM2HQcbM817iMhJNenLrFrtQxfGEqlgoQrqbEDQCSj1S6
	gyLhIy/33Du47byau5286zxM7uBfwHvRCECZNUFSIK+9NnJI536UQAn7AbwIGXMasWFfmxXzFyRnx
	eB9FK+kLT6Ppe2m+8XoAq7Edrm97pZNuyw8PTNJHk6iNkboXNhn8MWT8ELVfyGZx7qKnYtGb9KfqC
	jqfC9dtkTzBoXcFL/Hfw67Q0TELuvCGh3spNDbt2vOIsq+7X9SsHvURkk7A3Ojh3gpCgr+hmQnHg0
	Ff2aWIHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noIzj-0005j5-W4; Tue, 10 May 2022 06:05:15 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1noIzi-0005iM-51; Tue, 10 May 2022 06:05:14 +0000
Date: Mon, 9 May 2022 23:05:14 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Stefan Roese <sr@denx.de>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] nvme-pci: Harden drive presence detect in
 nvme_dev_disable()
Message-ID: <YnoAmhX/j90pnPnZ@infradead.org>
References: <20220506101534.1728011-1-sr@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506101534.1728011-1-sr@denx.de>
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

Thanks,

applied to nvme-5.19.

