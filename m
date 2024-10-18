Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E904D3C552
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2024 05:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JB5MbG8WsMtAxcb9JSABks/FbabojuuFqKWOdRSLDHc=; b=Yw6OPG/K6NHM0emtfTnheBccch
	v9ZPqRHaRTIXzvaA6Eh54Rs1AmSoQZNOYZRu2wUYSsJuI3FnZfM6MaVQQmOyj4asci/8cvD4YGYzA
	djxhwHcwQzc4AsR9badZG1kFet0C1+GIQcpHZfr/+wrTVc/tLm/djMNgNlvThGb3LMSDo4DwK7ek+
	34bL60D58ekNV/A6zfEaM5G4pBPyOKI8pPyOLdxwvTDJsikBRoop1gKspe1nTAzaDb4ArMmBC/cGF
	ORUxd21yu2gEcQeQAAu0YhfVBUMvqrs61kiZ7+psExlhmm66c30IE7Sr2dK9oGP6pQMMzdtmpM2c2
	FSsvc4yQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fyC-0000000H2a8-1r51;
	Fri, 18 Oct 2024 05:56:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1fp1-0000000H0CE-2mhr
	for linux-nvme@lists.infradead.org;
	Fri, 18 Oct 2024 05:46:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2D4E3227AAF; Fri, 18 Oct 2024 07:46:44 +0200 (CEST)
Date: Fri, 18 Oct 2024 07:46:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, hch@lst.de, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv8 2/6] block: use generic u16 for write hints
Message-ID: <20241018054643.GA20262@lst.de>
References: <20241017160937.2283225-1-kbusch@meta.com> <20241017160937.2283225-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017160937.2283225-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_224647_870318_09EB1F01 
X-CRM114-Status: GOOD (  15.53  )
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

On Thu, Oct 17, 2024 at 09:09:33AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This is still backwards compatible with lifetime hints. It just doesn't
> constrain the hints to that definition.

So in the end we'll end up with two uses of it - the existing 5
temperature hints and the new stream separation.  I think it
would be cleaner to make it a union, but I don't care that
strongly.

But we probably want a way to distinguish which one is supported.

E.g. for SCSI we set a net BLK_FEAT_WRITE_HINTS, for NVMe we'll set
BLK_FEAT_STREAM_SEPARATION.

Either way this should probably be the first patch in the series.

