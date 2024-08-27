Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA2D2C52D6F
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 05:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gV5GygWtVaMrbStKo0+9WPbVQ1n09MQV54s29bZChak=; b=KxQTxwKyP793pI/PqwILBtYzBe
	kM6qE/8Bxabw8KW3qin/hOOvSbmIpgadtCwII66L+sEZqg8zfsBKfA64tv1igPyEzoXobqnrEkZxR
	wuCMY2xwUP99f6lwtzNCR74EPhN8eYcleUicmrHLIJ8BTT4YudzLbWcsTghT41W5liguCZiKpUUJN
	gugGmsTaju6s0tLj/l9ckhJI0EELOAmT+Jj+glm6x8vRFKRnBGxgZwHqUXVt1zhUJQ2zxeKs6zi7E
	UrLhy2SwIFPE93SwSanbSm/qSlakXvpVyQqYG/XpnwjCWttn4l1zVF6eCjw3rcqHiFxFnO3hREbOa
	OtAUSFwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sip5B-00000009uui-3XoL;
	Tue, 27 Aug 2024 05:49:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sip56-00000009uty-1i9q
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 05:49:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1EA40227AAA; Tue, 27 Aug 2024 07:49:24 +0200 (CEST)
Date: Tue, 27 Aug 2024 07:49:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] nvme-pci: allocate tagset on reset if necessary
Message-ID: <20240827054923.GA11156@lst.de>
References: <20240826182719.3830725-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826182719.3830725-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240826_224928_609587_CFD5DBFB 
X-CRM114-Status: GOOD (  10.70  )
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

On Mon, Aug 26, 2024 at 11:27:19AM -0700, Keith Busch wrote:
> +	if (!dev->ctrl.tagset) {
> +		nvme_alloc_io_tag_set(&dev->ctrl, &dev->tagset, &nvme_mq_ops,
> +				nvme_pci_nr_maps(dev), sizeof(struct nvme_iod));
> +	} else {
> +		blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);

Overly long line here.  Maybe just return early after the allocation
above?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


