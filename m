Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21441CA0EE6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Aug 2025 16:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q6HugQdWAMHeIrnmDl+pmUGJJsToydBpKBzsrH2ph+E=; b=uUMFJeHrEZhXRKJX+lr8xVCXPP
	OaPMRdV9nNjY4Y1a/1BPpKcYPg1aqTKfofJVqXNwwGBQ8boKhh7YSX4wGFmUCmVEAODnjiJIHv/wj
	Bwnp7EsgFL7RBxNI0ok5wz9bNubzHfHprrmUSRbGOlL5n6ksDBJZqHe01InIrQvsN7aXTvn6+O41N
	exHJv7wESjcVf/FSMMBvBR2wfKvE6fA2VI4wshGmlLFWwLL9dvQ4oOJvAt83SH+I3E3OzThgYjTDu
	fpkZYg7LgQ9T+rHRUbihKB/1RcvUz5NscOb3fsTdV3NDq0scDy9Okom1FNLgN5wSnJgVW8fEkG9t7
	M/2iWyiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umETO-0000000EQkW-2TQB;
	Wed, 13 Aug 2025 16:37:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDoq-0000000EGe7-1s4k
	for linux-nvme@bombadil.infradead.org;
	Wed, 13 Aug 2025 15:55:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q6HugQdWAMHeIrnmDl+pmUGJJsToydBpKBzsrH2ph+E=; b=Hx+/jj6LkTq6PB0h5Jv2PJidcS
	wDYnX3B2Kmg9YmrDJdyAFHsb+VptW6kp17nsSalx3Vp6K0qaMUc6m78kFwDP9d4YIYrQ71P6+M3i+
	HEcO99c8/YQOLk7COc9m76etJN2DB+b739PpwhN7QCoyyqB/QCQzTRs1eKrfY6mtPosNFO5dG6nBH
	BoYLOI3cOofTViJb3vC6bWqTe4IHO5daGS2BtCphViB1HeZf6ww52evfKUI7KpJMx4jrHyAvXK9D+
	uN5qJ89gcHZYS962t3OoVuEYn1ByZjoVK8y63G8wl9AK/5w9cO724EQWc6kURqP6lIJxtMC2DpuN1
	5m8TJ6XA==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umDon-0000000G7YP-1FbO
	for linux-nvme@lists.infradead.org;
	Wed, 13 Aug 2025 15:55:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 996C0227AA8; Wed, 13 Aug 2025 17:55:00 +0200 (CEST)
Date: Wed, 13 Aug 2025 17:55:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv7 6/9] blk-mq-dma: add scatter-less integrity data DMA
 mapping
Message-ID: <20250813155500.GD14188@lst.de>
References: <20250813153153.3260897-1-kbusch@meta.com> <20250813153153.3260897-7-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813153153.3260897-7-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250813_165513_495292_E3EBE23F 
X-CRM114-Status: UNSURE (   8.20  )
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

I got two copies of this which both look the same.

.. and good, so:

Reviewed-by: Christoph Hellwig <hch@lst.de>


