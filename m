Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A355C48285
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 06:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JQ1K+MNxntxzlJ3HvG048dfjnQn1oAxwWi7aNakinjA=; b=Ur85JjYDYJb8L71GVlGnvUzXgH
	xKDsCQSPxditctgG1KF24X3tscQYRkfffVwXO38TEflM63cm4sMJAAEGzb3F23aO3otuqFnB2mWnc
	qhnKeYfQlsKQCZVQa/OZL+8x1UMFwR1FxwrQ6BzjRvTSDGfbhvZ0GMGl3CtzsZ4SFnehiGk9Exvxl
	9kFd8dzRjki145arBsafTihkJniPD3jbY7lwcU6F8vOQelGYVUQS4Una6BVc7ZZFZ4qmkGIFtuR9b
	v6Kx58E9X9GDFTWoiECtmQINCfbARCyHQLVJFpyKgoaDw8GKn8xj12oGkN9A9GtdLOh9hnH7DpNFD
	9PC/TjIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV42w-00000001dxt-45vF;
	Wed, 31 Jan 2024 06:26:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV42t-00000001dvv-02nJ
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 06:26:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 661FE68B05; Wed, 31 Jan 2024 07:26:00 +0100 (CET)
Date: Wed, 31 Jan 2024 07:26:00 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/12] nvmet-fcloop: swap the list_add_tail arguments
Message-ID: <20240131062600.GA16225@lst.de>
References: <20240130094938.1575-1-dwagner@suse.de> <20240130094938.1575-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130094938.1575-3-dwagner@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_222603_215002_8CEF035A 
X-CRM114-Status: GOOD (  13.92  )
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

On Tue, Jan 30, 2024 at 10:49:28AM +0100, Daniel Wagner wrote:
> The first argument of list_add_tail function is the new element which
> should be added to the list which is the second argument. Swap the
> arguments to allow processing more than one element at a time.

Ooops.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

