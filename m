Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C579AC5479D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jan 2023 06:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WdSJer6GSyMumPEXHTpi+4fJo0tw6X9dji2BQnUjs10=; b=vZAwDmkRTXon9An/DwH7IMij2y
	S9EoW7IkjfpFej6xkT0vPukYeWuTZNvSiOrlge+xjXg6YGbCfNupr1K10oCbi6UobIAhlgfyY59Ak
	hydNqcy5YlV5b4rP+nwcM8dWrYc7U4e5AgdSsxdFai35dllYAPtoRkquqUFOOKPPYfl6drU4gF3q6
	2yRcqLKvSAD0OX6UB8iSsaFzFw4UDgLv2NyvUZhzxvoQJNgMh37H8zuI+wqcsmuGTQUJi6l6PpCJA
	o4KExxljqHF5HqXOFJ//bbhetFaB+C5vZQ4UUPU4dora3t5oZf0KVALdkJ9ae4rBMHZ32+q4fwQa+
	/E3bsqtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFUnr-009sqD-Nd; Wed, 11 Jan 2023 06:41:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pFUng-009snj-Py; Wed, 11 Jan 2023 06:41:30 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CB7D868BEB; Wed, 11 Jan 2023 07:41:20 +0100 (CET)
Date: Wed, 11 Jan 2023 07:41:20 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hector Martin <marcan@marcan.st>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Eric Curtin <ecurtin@redhat.com>, Janne Grunau <j@jannau.net>,
	Sven Peter <sven@svenpeter.dev>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] nvme-apple: Do not try to shut down the controller
 twice
Message-ID: <20230111064120.GA18581@lst.de>
References: <20230111043614.27087-1-marcan@marcan.st> <20230111043614.27087-2-marcan@marcan.st> <20230111045402.GB15520@lst.de> <fc2e03ea-5404-e768-0cab-e95adcde6da7@marcan.st> <20230111051836.GA16576@lst.de> <0e7f9ef4-6660-5842-821b-7492f7ecbc61@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e7f9ef4-6660-5842-821b-7492f7ecbc61@marcan.st>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230110_224129_025974_55D986B5 
X-CRM114-Status: GOOD (  29.43  )
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

On Wed, Jan 11, 2023 at 02:44:42PM +0900, Hector Martin wrote:
> The higher-level resume path can't do a disable since the firmware isn't
> up at that point, and the subsequent reset (which is shared with other
> conditions that cause a reset) is what brings the firmware back up. So
> the disable has to either happen in the suspend path, or in the shared
> reset path after we know the firmware is running.

Ok, that's the weird part where nvme-apply really isn't nvme at all.
Because for actual NVMe devices the register access must work all the
time.

> That's only if you issue a disable *in lieu* of a shutdown (and in fact
> if you do that on Apple controllers under some conditions, they crash).
> Issuing a disable *after* a shutdown is required by the NVMe spec if you
> want to use the controller again (and should basically do nothing at
> that point, since the controller is already cleanly shut down, but it is
> required to set EN to 0 such that the subsequent 0->1 transition
> actually kickstarts the controller again). If you don't do that, the
> controller never leaves the shutdown state (how would it know?).

Yes.  Although I would not call this a disable after shutdown, but a
disable (or rather reset) before using it again.

> To be clear, the sequence I was attempting to describe (which is what we
> were doing before the patch that regressed this) was:
> 
> (on sleep)
> - NVMe shutdown
> - NVMe disable
> - Firmware shutdown
> 
> After the firmware shutdown, we can't do anything with NVMe again until
> we start firmware back up, which requires going through the reset flow.
> 
> Right now we're doing:
> 
> (on sleep)
> - NVMe shutdown
> - Firmware shutdown
> (wakeup)
> - Oops, NVMe is enabled, let's disable it! (times out due to FW being
> down but failure isn't propagated)
> - Firmware startup
> - NVMe enable (thinks it succeeds but actually the controller is still
> in the shutdown state since it was never disabled and this persists
> across the firmware cycle!)
> - I/O (never completes)

Yes, so I guess due to the weird firmware issues doing the disable
after shutdown instead of before setting up might be the right
thing for nvme-apple, unlike real NVMe.  So I guess we need to do
that in the driver, and add a big fat comment explaining why.

