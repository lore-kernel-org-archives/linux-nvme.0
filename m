Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 669EBC7EE30
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 06:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hWVNy/17sMJ0UpsPOsac7GU4xzxUd8HGyIFWggdCvyg=; b=CtMAVWIqjCFrRvt84f8EHeikzT
	MWPY01N7F8+qP3qmYqO8pKc5xzZoHh2jDvNjoZxk8qTxrVBksgzie+oEtfIfN2ZaCelYm5Ws+kSB3
	TcXL/dp+/UYJMgWs1DDVp5KhUp7YRvoxrlifQtlw7xgtqb/lB5PSMG10rv7IKrgaWB+76mCJagMmy
	M1hab+EI7CI6PQM/WyeTWmH3oGdjf6Eelt1Co9ic+lK5OamkaHSZHjRmpBCkZjcIn9wwHBFDaqE1O
	mtaadRgiLvxAxgDV/xgg3G2bU9bZE8eb3iyKNG80CsAs323r64wypwGpAjyMqaxZQwnexOb0rBtNP
	2bkClsAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWUgW-00000004B32-3BiX;
	Tue, 01 Jul 2025 06:41:40 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWUI5-000000047jU-131h
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 06:16:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AB7B268B05; Tue,  1 Jul 2025 08:16:09 +0200 (CEST)
Date: Tue, 1 Jul 2025 08:16:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: uring_cmd specific request_queue for SGLs
Message-ID: <20250701061609.GA17912@lst.de>
References: <20250624211444.2835077-1-kbusch@meta.com> <20250625060915.GB9391@lst.de> <aFxzXOZUFtt6hyPA@kbusch-mbp> <20250626051413.GC23248@lst.de> <aF1nUYSXvLE33osR@kbusch-mbp> <20250627072524.GA1329@lst.de> <aF66IGSMATG9-sLy@kbusch-mbp> <20250630060016.GA28775@lst.de> <aGKZf5gX7_JPe4-g@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGKZf5gX7_JPe4-g@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250630_231625_494154_8ADED744 
X-CRM114-Status: GOOD (  21.87  )
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

On Mon, Jun 30, 2025 at 08:04:47AM -0600, Keith Busch wrote:
> > My back on the envelope calculations (for 8 byte metadata chunks)
> > suggests otherwise, but I never got around fully benchmarking it.
> > If you do have a representation workload that you care about I'd love to
> > see the numbers.
> 
> Metadata isn't actually the important part of this patch.
> 
> The workload just receives data from a iouring zero-copy network and
> writes them out to disk using uring_cmd. The incoming data can have
> various offsets, so it often sends an iovec with page gaps.
> 
> Currently the kernel provides a bounce buffer when there are page gaps.
> That's obviously undesirable when the hardware is capable of handling
> the original vector directly.

Yes, the bounce buffer is obviously not very efficient when transferring
large amount of data.

> The options to avoid the copies are either:
> 
>   a. Force the application to split each iovec into a separate command
> 
>   b. Relax the kernel's limits to match the hardware's capabilities
> 
> This patch is trying to do "b".

a, or a variant of that (not using passthrough) would in general be
my preference.  Why is that not suitable here?

