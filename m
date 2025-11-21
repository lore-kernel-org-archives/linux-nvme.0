Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 940F1CFA76E
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 10:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zp3TKlTxdZlSsgsBn6EkPyeGu/Ie/JJn00zi5VBT4ZA=; b=BQQOJjUVRqAKzBu7b/uec9jQ0F
	973dTRVxbsQpyMx0cW91++exeZtIka5EFOp/QRuOld0EGh69Xx+gAV3R/aWlKNuLC/e8u+OtOrQH6
	60lOxaWcc8/WeMQLIs4LsbHVVVybPoKxIQigIBwroqqtpE2WWZ4tm+dMEnyOtgt+0ZNtI9A2Lz3ui
	kSMihJM8zgk14Y5Mzx9iKyb7O/VTcSFuPWnYDigmgYHABGayZt2+2GAXBQYNNPQ9748bn/2btacwJ
	3FkXP03kyP2J154ORrvLWoytaguYVIxs4/iQ8ESfNS+jDAywBe7C3P2CvWq+ww1LEuo+9y8RHG1sG
	PE2VGjiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMOW5-00000008FLN-2jZp;
	Fri, 21 Nov 2025 10:37:25 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMOW3-00000008FLE-3gSW;
	Fri, 21 Nov 2025 10:37:23 +0000
Date: Fri, 21 Nov 2025 02:37:23 -0800
From: Christoph Hellwig <hch@infradead.org>
To: zhangshida <starzhangzsd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev, virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org, gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev, linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn
Subject: Re: Fix potential data loss and corruption due to Incorrect BIO
 Chain Handling
Message-ID: <aSBA4xc9WgxkVIUh@infradead.org>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
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

On Fri, Nov 21, 2025 at 04:17:39PM +0800, zhangshida wrote:
> We have captured four instances of this corruption in our production
> environment.
> In each case, we observed a distinct pattern:
>     The corruption starts at an offset that aligns with the beginning of
>     an XFS extent.
>     The corruption ends at an offset that is aligned to the system's
>     `PAGE_SIZE` (64KB in our case).
> 
> Corruption Instances:
> 1.  Start:`0x73be000`, **End:** `0x73c0000` (Length: 8KB)
> 2.  Start:`0x10791a000`, **End:** `0x107920000` (Length: 24KB)
> 3.  Start:`0x14535a000`, **End:** `0x145b70000` (Length: 8280KB)
> 4.  Start:`0x370d000`, **End:** `0x3710000` (Length: 12KB)

Do you have a somwhat isolate reproducer for this?

> After analysis, we believe the root cause is in the handling of chained
> bios, specifically related to out-of-order io completion.
> 
> Consider a bio chain where `bi_remaining` is decremented as each bio in 
> the chain completes.
> For example,
> if a chain consists of three bios (bio1 -> bio2 -> bio3) with
> bi_remaining count:
> 1->2->2
> if the bio completes in the reverse order, there will be a problem. 
> if bio 3 completes first, it will become:
> 1->2->1
> then bio 2 completes:
> 1->1->0
> 
> Because `bi_remaining` has reached zero, the final `end_io` callback
> for the entire chain is triggered, even though not all bios in the
> chain have actually finished processing. This premature completion can
> lead to stale data being exposed, as seen in our case.

It sounds like there is a problem because bi_remaining is only
incremented after already submittin a bio.  Which code path do you
see this with?  iomap doesn't chain bios, so is this the buffer cache
or log code?  Or is there a remapping driver involved?


