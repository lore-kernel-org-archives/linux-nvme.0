Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08941CFC266
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Oct 2024 04:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rzdYTI0TjidoYnh7ZfUT+V5IRATIW6eNQl4ssyTwvYU=; b=Zm4ZiU+6bu+BCSmJq8cG0IlkN3
	NwN6TZ/7kCIRaCxs3RgnjyfNU06D7Bqx7V+aIjqLLV499Xhr8FmlGGqHiGcdct64L5qA4VR7k/3JY
	Bad4lCgq/YbtNA6bEvsElenBDqQZHNeBhu+rvQ9KOc0ibmQwvZPI3BDDvVEyH3cl1LM7L0cLgTzss
	WlIjaUC4wNeSczHzEeWgmK/bwa32Tm5ieIFEPLmzm7ZX+nGl+N3rfqikcwO9xhjQDgtE9svyx7QWr
	XA7Ick57m5hxK9PQzf5SraKFcbpwJt4jlnCFCIXQHuVRWFQoKU6dFrMttxQ/AGRHpHWpkh/4xd46B
	r7bXO/Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ZcN-000000074Qr-1YP2;
	Tue, 15 Oct 2024 04:57:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t0ZcJ-000000074PK-3scr
	for linux-nvme@lists.infradead.org;
	Tue, 15 Oct 2024 04:57:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0B2C0227AA8; Tue, 15 Oct 2024 06:57:04 +0200 (CEST)
Date: Tue, 15 Oct 2024 06:57:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme-pci: fix race condition between reset and
 nvme_dev_disable()
Message-ID: <20241015045703.GA18171@lst.de>
References: <20241014132013.786770-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014132013.786770-1-mlombard@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241014_215708_195087_A9CD8F93 
X-CRM114-Status: GOOD (  10.86  )
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

On Mon, Oct 14, 2024 at 03:20:13PM +0200, Maurizio Lombardi wrote:
> -static void nvme_pci_update_nr_queues(struct nvme_dev *dev)
> +static int nvme_pci_update_nr_queues(struct nvme_dev *dev)

It would probably be nicer to return a bool here instead of a negative
error that is always -ENODEV.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


