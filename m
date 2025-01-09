Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304CCE77199
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 08:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NQZSn6rjyASNRqeKVmoDj4wpcedhvi52LQ1++EYrZl0=; b=o+c3cDitAS+Oer804UKokpww1n
	uKuCM68Wg6RSGm7Fyz8c8v1QC2hNvMqGGq40e35nbFYTQmhCRSRIOQwhBtQ1gikH8/TnYMgRWglyx
	ppinBSr/VQHVYtjMeky3oUaxwCgXHtUd9oRbCcCbVXN2G214P38eiHEIV5tdVii6BYBXlQxdWeFmI
	gZ82J9IHOEKOKTTPQ5HuZ7utGjt7w/oMOPnbEXRJyPqJQcFQ/EU3iGuGjV1/munikfSEP8fYq4Cxw
	6vNObtK3H9vUpJOG7a2Bv4BxKslN3vo3HRMP6xTzdmdcQoO2/katvjWj42S/lPrVTj+2C0deoEttN
	fQZyCXAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVnuX-0000000BBAW-2EY5;
	Thu, 09 Jan 2025 08:29:01 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVnuU-0000000BB96-2ImR
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 08:28:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E215468AFE; Thu,  9 Jan 2025 09:28:49 +0100 (CET)
Date: Thu, 9 Jan 2025 09:28:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Adrian Huang <ahuang12@lenovo.com>, Christoph Hellwig <hch@lst.de>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] File corruptions on SSD in 1st M.2 socket of
 AsRock X600M-STX
Message-ID: <20250109082849.GC20724@lst.de>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info> <Z36UsE5dj6j5HhkX@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z36UsE5dj6j5HhkX@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250109_002858_725104_0B7F6B09 
X-CRM114-Status: GOOD (  14.83  )
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

On Wed, Jan 08, 2025 at 08:07:28AM -0700, Keith Busch wrote:
> It should always be okay to do smaller transfers as long as everything
> stays aligned the logical block size. I'm guessing the dma opt change
> has exposed some other flaw in the nvme controller. For example, two
> consecutive smaller writes are hitting some controller side caching bug
> that a single larger trasnfer would have handled correctly. The host
> could have sent such a sequence even without the patch reverted, but
> happens to not be doing that in this particular test.

Yes.  This somehow reminds of the bug with an Intel SSD that got
really upset with quickly following writes to different LBAs inside the
same indirection unit.  But as the new smaller size is nicely aligned
that seems unlikely.  Maybe the higher number of commands simply overloads
the buggy firmware?

Of course the real question is why we're even seeing the limitation.
The value suggests it's the swiotlb one.  Does the system use AMD SEV
(memory encryption)?

