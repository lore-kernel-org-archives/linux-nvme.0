Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343C4D59F5F
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Nov 2024 00:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2CmTcH9TOVJPw94MnSHVMVSV2ugRsDwaFJLJUmCKK/E=; b=kkYaC3Ymn213+nWmA1ehIQ7AdO
	RWNZpsg3YJxWT0TopA0bxtFt58TDlty/nZpOMSu+eOpGMqLf8vGjmjmjYThB64o2hQQqTjEIvH3NF
	R8NWMTtGAuZsOhansyHd7dO3km2R2N2KgyOU4euk4A0X9Egeq6sX/c3YKxmHGQ1CPvHn/Relzmv0+
	AreDZpfIfuGKxq01+M0SdIeaePrwSZaWNIa6J+oAeM2AR+pb1YR5JwYhlcKik1pkD8e0Z+crnv26x
	M18kboa9OzC+P2QB+jthXt++JvqEbqgnOtLrH9Gxm97/jfTxjfsURkKktwHTCwC9OkNk1OZ4m42qn
	u9k0liXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8qUy-00000005AjE-1UUH;
	Thu, 07 Nov 2024 00:35:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8qUv-00000005Aio-0oZP
	for linux-nvme@lists.infradead.org;
	Thu, 07 Nov 2024 00:35:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DD85C5C476A;
	Thu,  7 Nov 2024 00:34:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE32C4CEC6;
	Thu,  7 Nov 2024 00:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730939740;
	bh=SPcNLEDUdJ+GzHVbBQWkV6fNBLql9Dh3Zp19Ilnc/Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R4SP8mhnTOa1IaX4oYO/+P2/N66yWuy9NB48ynGVG052Y06vceChqIjtYgoc/GkwT
	 Kl49ElHLGmRefO/QnthwLubbeJtdm5FMgTHwbZLqLYgYCM6OEUrdz5kKi71Abe9wdS
	 Umt/SMibg/uCzqQa2LV86u16qHoxcGhvgVOWZCctmBGIe8Xo+6wAU45AENSZUJ7c21
	 CXbBmQVP4j1yTYoo1Z9JCNxjkA5ZtKRyKNTZQUCy4IsHqyMR/LYpeOQHqaiKr1A5pQ
	 QbM3OERKIT3Q3xR+jLsEYVXngQmJctEw3LSS++x1WZBpgWhyYnZFaQWHcsjvz/0xDW
	 q14lP0CUqNnrA==
Date: Wed, 6 Nov 2024 17:35:37 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@meta.com>,
	linux-nvme@lists.infradead.org, m@bjorling.me,
	matias.bjorling@wdc.com,
	"Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCHv3 11/11] nvme: add rotational support
Message-ID: <ZywLWcxR1gN_KpmV@kbusch-mbp>
References: <20241105174904.3612888-1-kbusch@meta.com>
 <20241105174904.3612888-12-kbusch@meta.com>
 <9614c5af-7418-47b9-833e-388cdf1bdca4@linux.alibaba.com>
 <20241106082232.GA3779@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106082232.GA3779@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241106_163541_298001_CE184957 
X-CRM114-Status: GOOD (  12.31  )
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

On Wed, Nov 06, 2024 at 09:22:32AM +0100, Christoph Hellwig wrote:
> On Wed, Nov 06, 2024 at 03:57:06PM +0800, Guixin Liu wrote:
> >
> > BLK_FEAT_ADD_RANDOM flag, but I dont see any calls in the patchset.
> 
> I actually pointed that out last round and thought it got fixed,
> should have noticed it wasn't this time around.  The flag really
> should be dropped.

My bad, I applied the RFC patch here, but it was already fixed it in
subsequent version.

I'm fixing up the remaining stuff from the review comments. Will spin a
new version shortly.

