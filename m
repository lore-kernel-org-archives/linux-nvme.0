Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268D1D2F7D5
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 05:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=absN/FYcNmDT7ZzgQv9eUDElstTCgq+3A20f5PjY5Hc=; b=ouDcdtUM4DdQsyIj1xZ54WsNMD
	jkeZGX202NNSrASOG4v/BPyOmwKjyJyXAeFH2dG960MaldkMuQLgbtauKNsJc0YxYEvIyrXbl6TWx
	L9Pk5mNnNp9EaiG1GqQw6F6U2CFKqCRBqWud4L2N+pdToXFx+Kd8wlKEOSW1n8gjppcpseJFxAYN8
	3PeiH1Cqw7E+Z4VGQcx3GHc4/vo40gs4jv//uhTtp/mfUIsLnVO5M4fEKfgfb8HK4MnbAyHObesTX
	J4gKBjBAAicBzZaD/S/EfrpjqOeLWtsXUWefjWsuhIlECbEJAuF13g4fEEfRG7JdvMEBcL9yIhOSW
	7oopiSMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1JVh-0000000Dokr-43XH;
	Thu, 17 Oct 2024 05:57:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1JVe-0000000Dok6-1aDw
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 05:57:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CEB10227A87; Thu, 17 Oct 2024 07:57:06 +0200 (CEST)
Date: Thu, 17 Oct 2024 07:57:06 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, anuj20.g@samsung.com,
	martin.petersen@oracle.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] blk-integrity: remove seed for user mapped buffers
Message-ID: <20241017055706.GA22880@lst.de>
References: <20241016201309.1090320-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016201309.1090320-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241016_225718_582848_A10F58DC 
X-CRM114-Status: GOOD (  10.94  )
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

On Wed, Oct 16, 2024 at 01:13:09PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The seed is only used for kernel generation and verification. That
> doesn't happen for user buffers, so passing the seed around doesn't
> accomplish anything.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


