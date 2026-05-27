Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D5DECD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 13:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1JUDAwcE5nMDiCQ3CX9g7s+VH6Tb4LkTDmZqEj6qSns=; b=qa5GVmzapez1YyUIjR0f+URlhq
	k8xxNFDDRb1U+VO21NgcAV/3o5SmobTVb28d854Z/5TllJegnzJuDP2IdiLxyUPE0MSp96vrXLx3J
	n/XCvazsnBwuDvXoEgfmdTLMW6NsnwNE8ZrFR2gRh8gUddT0VauYVIjJYCljizj1y7fCZDjd/ZIi4
	UTNW7iKq79UDdBsYv4ibZQlUI2g5J408zcQorIiQmDf50Qjik7/jCPqv5WlhcKe1pJkdRxkYtPMRy
	H7E2frsr0AN5kCqBZZHIGkWiYoR8rUHnicLsRONy0fKks6wkoLzkHSorkmVzg6r0pAxiwORCMSfIM
	IvvClUJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSE6J-00000004APN-0QmE;
	Wed, 27 May 2026 13:15:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSE6F-00000004AO6-3h26
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 13:15:09 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8EE4468BEB; Wed, 27 May 2026 15:14:58 +0200 (CEST)
Date: Wed, 27 May 2026 15:14:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, nilay@linux.ibm.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] block: export passthrough stats enabled
Message-ID: <20260527131458.GA10351@lst.de>
References: <20260526153921.2402015-1-kbusch@meta.com> <20260526153921.2402015-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526153921.2402015-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_061508_068028_052651FC 
X-CRM114-Status: UNSURE (   9.22  )
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

> +static inline bool blk_rq_passthrough_stats(struct request *req,
> +					    struct request_queue *q)

The kerneldoc requested last time would be really nice to have.
Also, now that this is a public API killing the q argument and
just using req->q would make the API easier to understand.


