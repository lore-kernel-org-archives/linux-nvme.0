Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEAECCA6007
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Oct 2026 12:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D8oaLiBOeyXnutecsSkzdwdFr9Xa2ksmNjevdN2sBjQ=; b=5D+OonSLy+ihqjJgLwRbNBIdvC
	KxWfUwdOifXsrdyTBAcCVC25h5X1VfaYZ8Itg7XJj0xZsz4sCHkOBHcEFP/93P1f/4rdYCEpiAfLK
	P/S7nA7r7an43JcFn2sXp2PBpA93UqemDX3kj6pFAph4GAn4EHwQc4Z+0k2IF0keWKYsg2f1CqcSl
	EnFzKhC4QdjQduwyhyC2oT5XBb/nIwCgtKXXd5IaZy8l+TAwgf54E4E+UaaaUBeseW+krsg/bJW6N
	EyT3KkinhE6Pk4UTv7/dHSObeKsgl1x5zr8z+6UX9UKERFoxFNp1/841BmMwfsU+nYdlgqf4OmWiw
	p/Wtq1Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEnNS-00000004NNq-372F;
	Thu, 08 Oct 2026 12:37:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEnNO-00000004NND-3k4O
	for linux-nvme@lists.infradead.org;
	Thu, 08 Oct 2026 12:37:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0909668BEB; Thu,  8 Oct 2026 14:37:25 +0200 (CEST)
Date: Thu, 8 Oct 2026 14:37:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.garry@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, ahuang12@lenovo.com,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	sunjw10@lenovo.com, iommu@lists.linux.dev
Subject: Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors based on DMA
 optimized limitation"
Message-ID: <20261008123724.GA22096@lst.de>
References: <20261006120248.147654-1-hch@lst.de> <8cf8a8ea-c9c9-434b-aec6-e361280a88a4@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cf8a8ea-c9c9-434b-aec6-e361280a88a4@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261008_053735_105609_CB3276DE 
X-CRM114-Status: GOOD (  12.77  )
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

On Thu, Oct 08, 2026 at 08:36:54AM +0100, John Garry wrote:
> On 10/6/26 13:02, Christoph Hellwig wrote:
>> This turns down to cause up to 15% performance regressions on standard
>> large transfer workloads.  Revert it and hope the IOVA allocator can
>> eventually be fixed to remove the need for the original workaround.
>>
>> This reverts commit 3710e2b056cb92ad816e4d79fa54a6a5b6ad8cbd.
>>
>
> What was the block size and conditions for the original issue? The commit 
> just mentions that mdts=10 and we get a 4096KB max HW sectors.

Good question.  The original submitter and reporter are on Cc.


