Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04F5DC04A94
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Aug 2023 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l2WBiCb5duYJRA9nKpihqrJOH1Qjg6utSrFiu8qAdtc=; b=4pRZzoBrFA8Eo+iRxG5DNw2VOM
	kzu2dO5A0n7x2PDGADOwqvDfJ6UqmY+OR/Bdw43xNkKoTdGXLmiO/AnBjsjmb8DLkySqfesoBOe0m
	75OZB5xq7+b2bbhAfcdOgPX6B6Shl/2oLAR+/kW5ZB3j66FoCh0NjrWrKm/QR108XEGIgLJg8xVFc
	5Odw2dDWq/Jm6LysTNTkEVQUtUaAHWos0XyAcEVomPr0BWfC/tYLeI/X5dzG6RNl+SRsXmh76g5Gx
	MfIyIKRDxrhp/iiQ0M4m5hA/kyqMR/x/d/y0nPBFNceGcv9W/ylNlQcq8AQd1XEI4SZy/a0a9NBVz
	7VraBrnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQpcm-002TGX-1L;
	Tue, 01 Aug 2023 13:41:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQpcj-002TGB-38
	for linux-nvme@lists.infradead.org;
	Tue, 01 Aug 2023 13:41:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 65A356732D; Tue,  1 Aug 2023 15:41:11 +0200 (CEST)
Date: Tue, 1 Aug 2023 15:41:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Varun Prakash <varun@chelsio.com>
Cc: sagi@grimberg.me, hch@lst.de, linux-nvme@lists.infradead.org,
	Rakshana Sridhar <rakshanas@chelsio.com>
Subject: Re: [PATCH v2] nvmet-tcp: pass iov_len instead of sg->length to
 bvec_set_page()
Message-ID: <20230801134111.GA10235@lst.de>
References: <20230801115731.4806-1-varun@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801115731.4806-1-varun@chelsio.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_064118_170011_1D32CCF0 
X-CRM114-Status: GOOD (  10.39  )
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

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

