Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D9BC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 08:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jK7yXu+YUNDS/i8625dGZDbB0fYPxmquYyFZPbESBc8=; b=kXcf0sNFl2CyJT2fFAXabm0Hmb
	ofOXhlkoWKQ0Mf0sZv+k86LcG/kUWjD56Qty6IVH59KFzPBFX1eyStau1gPp0t5ZsuFU3vIYm8oQY
	bgMSEJIbXo8itOaTczxlIuQBgSAZ/3UOyyfdGK58ztJe5reuWExq8ctQSVDQAPBPLVuXOirC5CrdU
	G5Ps5Cv1vmXPIRu11H9Zpf+SPEoN7Yp4IyXScnxZyHEXHGqqMuStd0oXpcbCdkttHvy9sjgjj8lrW
	PWQkE2IsguW2As9iGo8/pjorRRd1QaciKisi1LfdzfRnJZrEgoR9x/aS0wo1rTk/AEh0sJ5K7zU69
	+c3jnoAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSEEP-00Buwr-30; Thu, 10 Mar 2022 08:33:09 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSEEM-00Buw5-KR
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 08:33:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id CE4AE68AFE; Thu, 10 Mar 2022 09:33:03 +0100 (CET)
Date: Thu, 10 Mar 2022 09:33:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com,
 logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
 mcgrof@kernel.org, a.manzanares@samsung.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com
Subject: Re: [PATCH 09/17] io_uring: plug for async bypass
Message-ID: <20220310083303.GC26614@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152711epcas5p31de5d63f5de91fae94e61e5c857c0f13@epcas5p3.samsung.com>
 <20220308152105.309618-10-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308152105.309618-10-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_003306_842597_DF826AD2 
X-CRM114-Status: GOOD (  10.06  )
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

On Tue, Mar 08, 2022 at 08:50:57PM +0530, Kanchan Joshi wrote:
> From: Jens Axboe <axboe@kernel.dk>
> 
> Enable .plug for uring-cmd.

This should go into the patch adding the
IORING_OP_URING_CMD/IORING_OP_URING_CMD_FIXED.

