Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF809C32771
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Sep 2022 14:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VYXPaePPkFQmtHgeaR7pqY5gEI8Hr9hwmGA4CbheL6U=; b=3UNBPuWpwUxVR1Akfhd+/2Wkkz
	arlZfuLmaAnPIY6a0QZU5h1jzRTAfLGz88H7I3oP4xuS2D8KUG7mELUoG4P2TAathlBjtGm/s/AZi
	WUq2ysrTpa8Xc/Q1A/mIimdX8Ya7FZs58+v2ADp5zp/C5ogd4dR9T9i5W+DTZL9Z4ae0R/XUN4LPR
	ln5YcTCOuaL3nLNl66RnttgWPla4dI/SePgshIoSPckZvxmkSMApLxb/yiC1gQB+zJ2OmyXiCaYhq
	KQ421z3bhwyU17UT39X9l5se1Sv4BoXW6n4cY9dDOnHbl0RSf/MCHkFXQl795oQCrWgHyeEbjNXih
	7ymyPDtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpIA-005PT2-53; Mon, 26 Sep 2022 14:41:06 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ocpI8-005PSJ-10; Mon, 26 Sep 2022 14:41:04 +0000
Date: Mon, 26 Sep 2022 07:41:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
	Stefan Roesch <shr@fb.com>
Subject: Re: [PATCH 4/5] nvme: split out metadata vs non metadata end_io
 uring_cmd completions
Message-ID: <YzG5/1zSdiMlMLnB@infradead.org>
References: <20220922182805.96173-1-axboe@kernel.dk>
 <20220922182805.96173-5-axboe@kernel.dk>
 <Yy3O7wH16t6AhC3j@infradead.org>
 <d09e1645-919f-9239-f86d-a8e85a133e5c@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d09e1645-919f-9239-f86d-a8e85a133e5c@kernel.dk>
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

On Fri, Sep 23, 2022 at 02:52:54PM -0600, Jens Axboe wrote:
> For both of these, how about we just simplify like below? I think
> at that point it's useless to name them anyway.

I think this version is better than the previous one, but I'd still
prefer a non-anonymous union.

