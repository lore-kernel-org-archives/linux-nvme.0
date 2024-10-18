Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 567F3D3C549
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 05:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=85SnbBBkefMZUzVxJ0mbqeomf8fXAjh2h8VzC0FU1rc=; b=XMF68v3s0783fOJUqeMVyGVLzG
	yKC/696+FjKHE6Sy1aR4QWGANVclb5oofJk6PjOq1uheVdS/HV9bCJkhOfwmdInOcuWDtVj8zL/9X
	/+84+/NZaiy8qlh5MfZja+90fLqxP1rzSw5x4FfP3Or1SrNx1BgJrOSrZVTGrBet+DmnAyLXq5Fhl
	dglvuHL3ovc0pfP/prRPnA8qLh+LwCzW/SBQAcP2P94WKw3+tUka9ek0NqKhv+gwsLpw6BUbTRZ7W
	1YA3Djl9A5bwfOMDCVG0jYqRjYKm1BVE7TAMK08kdCwzUOI2xHw1t9fVzp/jvYvlf+oqkvP2QmL8c
	vP2UR3ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fHS-0000000Gvvq-316g;
	Fri, 18 Oct 2024 05:12:06 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fHQ-0000000Gvuu-2NKW
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 05:12:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1CD84227A8E; Fri, 18 Oct 2024 07:12:01 +0200 (CEST)
Date: Fri, 18 Oct 2024 07:12:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2] nvme: enhance cns version checking
Message-ID: <20241018051201.GD19831@lst.de>
References: <20241017181231.2937468-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017181231.2937468-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_221204_776253_CF3FA861 
X-CRM114-Status: GOOD (  11.67  )
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

On Thu, Oct 17, 2024 at 11:12:31AM -0700, Keith Busch wrote:
> +	if (ctrl->vs >= NVME_VS(1, 1, 0) &&
> +	    (!(ctrl->quirks & NVME_QUIRK_IDENTIFY_CNS)))

No need for the braces around the ngation here.

> +		return cns <= 3;
> +
> +	/*
> +	 * NVMe 1.0 used a single bit for the CNS value.
> +         */
> +	return cns <= 1;

Slightly messed up indentation.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

