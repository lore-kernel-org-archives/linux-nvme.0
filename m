Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E4B2C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 15:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y8OMKm066xBcI/LppIuOsej+IfF4C4SQuuMWSukmOFw=; b=bzjndhnac0KjRG4qEn524LKz95
	8vMva0AxUQtZgYXYzhqAj9LjbN9EaoLDwyrovDSDhAOa1Sx6+j0xDo1GjBrYkb5vG5JAiaUE+G+T3
	OKynJQV7mlYMC5ec67kbkRx7cyMp9HT/VZ9ZbYDTjlIpi1u+ZGt8+85QqQ0lPpkM0Qjbs0R8JWrJk
	9TDkFnDGNXZsiCRL4UAV93bChWdUehpzRdtLIqmUnLXndCJZy/Y4DIurxQ6enLmNGKy8xqssP26Yh
	QRpYw5ZZtzlwt4F4qPffDhpikhfAwM1VLfUv1QMIkUVHnMruJNEBVSxBJxKZX7z+Apco5IrfPTW7P
	u7JV3Irw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOIgc-00000003sr6-3GUz;
	Mon, 01 Jul 2024 15:11:22 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOIgZ-00000003spB-1Xd8
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jul 2024 15:11:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB76B68BFE; Mon,  1 Jul 2024 17:11:12 +0200 (CEST)
Date: Mon, 1 Jul 2024 17:11:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] nvme: don't set io_opt if NOWS is zero
Message-ID: <20240701151112.GA1677@lst.de>
References: <20240701051800.1245240-1-hch@lst.de> <20240701051800.1245240-4-hch@lst.de> <ZoK1WRFbr1dK86FK@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZoK1WRFbr1dK86FK@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240701_081119_569684_5875C708 
X-CRM114-Status: GOOD (  19.60  )
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

On Mon, Jul 01, 2024 at 07:55:37AM -0600, Keith Busch wrote:
> On Mon, Jul 01, 2024 at 07:17:52AM +0200, Christoph Hellwig wrote:
> > NOWS is one of the annoying "0's based values" in NVMe, where 0 means one
> > and we thus can't detect if it isn't set.  
> 
> We can detect if it is set based on the namespace features flags,
> though.

Except that the flag covers 5 different flags, for 2 different operations.

> > Thus a NOWS value of 0 means
> > that the Namespace Optimal Write Size is a single LBA, which is clearly
> > bogus.  Ignore the value in that case and don't propagate an io_opt
> > value to the block layer.
> 
> Hm, why is that clearly bogus? Optane SSDs were optimized for
> single-sector writes.

Because even if they optimize for it, the pure overhead of both
the PCIe physical layer, nvme command overhead and software overhead
will never make it more optimal to split a larger I/O down to this
size, which the optimal write size is about.

