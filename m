Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 620D6C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 15:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XmNlTpL1FezqqiLizXeLtS41/5lylIhlx4eScxBoMCk=; b=Fkfy8YtO5GsTB4mhj02LXzxffy
	W0pG77aZw80lztV5cMf2gQcLpX7nNM4DvjoPkYANPUKQ6pAIRaBNu+oESXRt9d+qKVJ7U0H/wjSn7
	5Ukj3RHFyFdtCLVwputm21wwCSnud4kKVgQfk3Nwnn39mNi/SO6unc86/6JwRrdxr3aKscNlKJ4k+
	7YGi3vmXGuG3Q9yEHwe917z4rYDXFGbIHGIFPK++qgueu0UqqdVQrCAx/+/HV3EvGRp91iA5DJ457
	2pNNF/aDr/+ug2m+hwd4rZyCZ2e1ulP3HT0DOkGfkZQbrkiOqDgqXZ9/50peVRBMAHOgtiCHKhu7V
	ljCwPBfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odv4c-003kG7-2X; Thu, 29 Sep 2022 15:03:38 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odv4V-003kBd-JW
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 15:03:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 52C09608D5;
	Thu, 29 Sep 2022 15:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ADC3C433B5;
	Thu, 29 Sep 2022 15:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1664463807;
	bh=oe5t3MO6suf++0Q4/eQSbeDMVNrpcAiy/4s2fqFhZP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JDoTBl9s+q259YmmTDewsSNixuD2NqzHD3dTnP6Dx8Px1CYTMGo3ow9rNQO4ouGAn
	 S3skrM+wSmSeXU1WqFSQtrIK3NY9kTWbtHkEKmIg4aqDvoRkg2ivHtohtyq8W89QB0
	 ZTsfGawiHVgbEa8oyENgZn77nSs7MKRoQiav/kDhzLCABXYjZOhFrMsD7ZwrmxNvNB
	 sVTl9+PmPyIR9ymw4RyOh4F5LCyh49P/fcf3wxtqcrdJWccqjDr0OLMKgMBIag9nQT
	 RkSMybalq0bwu/zqfRQJuj42ZplnPo3ckakRNT9hm8tAO794PCQFH5p/CoafoqcH2x
	 tiO3X54PUXFQg==
Date: Thu, 29 Sep 2022 09:03:24 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH rfc] nvme: support io stats on the mpath device
Message-ID: <YzWzvOKgoAqltAA0@kbusch-mbp.dhcp.thefacebook.com>
References: <20220928195510.165062-1-sagi@grimberg.me>
 <20220928195510.165062-2-sagi@grimberg.me>
 <760a7129-945c-35fa-6bd6-aa315d717bc5@nvidia.com>
 <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3d619a3-ccae-69ea-3e2c-9acff7b97d92@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_080331_693970_AF1CCAEA 
X-CRM114-Status: GOOD (  14.37  )
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

On Thu, Sep 29, 2022 at 12:59:46PM +0300, Sagi Grimberg wrote:
> > 3. Do you have some performance numbers (we're touching the fast path
> > here) ?
> 
> This is pretty light-weight, accounting is per-cpu and only wrapped by
> preemption disable. This is a very small price to pay for what we gain.

It does add up, though, and some environments disable stats to skip the
overhead. At a minimum, you need to add a check for blk_queue_io_stat() before
assuming you need to account for stats.

Instead of duplicating the accounting, could you just have the stats file report
the sum of its hidden devices?

