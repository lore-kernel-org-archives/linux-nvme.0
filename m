Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A7EC36014
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 18:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v7qzR5AXI4e0SLQsNXjXUT1fPOth+HRnE1EaWA49tn8=; b=kvrWCOn73wkvGu6iVniHuwF6Tf
	5rW/balD51wHoE/F+QMY7HkofxmBcz+8o9XpMW55u7LHsKPX96YeYqZzlMabtIOJoOmNNVYkbW4d1
	HGYd49wDJQmWQXxfpu1iYwgaIwN8g+/Yl/ltx1WT/1mDQKm2gJgNDe4zB0xTAvtn5kU59coiWVrjL
	9NTXZ3v8qFFh4rKQJKODSIeKmURUjxWKCvD9L0rmsnPZShrCuHbCjVH5q9PwP3zQhM3XyKRktL4C4
	K31DwdDJROAgBftoU0c410dGvvu+GMscBvYFoFRMOOKqWL19c7zUzH92Wv+ZvlCOwL8BVVaKBX8Wf
	QOnZQPOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Pn7-00000009cmx-23Ax;
	Thu, 03 Apr 2025 18:59:53 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0Pn5-00000009cmX-0qRb
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 18:59:52 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C136D4386A;
	Thu,  3 Apr 2025 18:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C509CC4CEE3;
	Thu,  3 Apr 2025 18:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743706790;
	bh=6CfGUQI1hD4EaUW52YQ6sJ3ErXhwmEaa5YfDJzOh0Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZw5u8+YTSgB/geEfq2Qguz/4mFMTI4yg9I9FeNMUqGBSsETPIiSyxyyQauRAICfW
	 e4bh+mknKeohOh6ttjGp4KqU7H7yjhbUuh6hTHjLRA4DvdI7x13r+xYrznNWooUgWS
	 3Kwo2OQJsovk3jBXNZzvlDoIRtUnxHjCQ2mDFwZvxi6P1QGltbpanFHtTCb2BsteX7
	 v6w1AvCFrbSqzjPgTCXhWKvEmC5neOVSY+6zfRDxl+frylU+gOgLLybifZbwn+m0/W
	 LlTu1Y2k2Z5xwaAfkikMU/h8OWHy/TVHuMyJ0Z5g/iizhun6evtp0AFWP3eQquLB4c
	 H2LXCgb9DUEog==
Date: Thu, 3 Apr 2025 12:59:48 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kamaljit Singh <kamaljit.singh1@wdc.com>, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, niklas.cassel@wdc.com,
	damien.lemoal@wdc.com
Subject: Re: [PATCH v1 1/1] nvme: add admin controller support. prohibit ioq
 creation for admin & disco ctrlrs
Message-ID: <Z-7apFKJK5u-7xL9@kbusch-mbp>
References: <20250328213640.798910-1-kamaljit.singh1@wdc.com>
 <20250328213640.798910-2-kamaljit.singh1@wdc.com>
 <Z-qur5YnK2ZtiRR3@kbusch-mbp.dhcp.thefacebook.com>
 <20250403044901.GD22803@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403044901.GD22803@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_115951_258835_9B9412F8 
X-CRM114-Status: GOOD (  17.18  )
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

On Thu, Apr 03, 2025 at 06:49:01AM +0200, Christoph Hellwig wrote:
> On Mon, Mar 31, 2025 at 09:03:11AM -0600, Keith Busch wrote:
> > On Fri, Mar 28, 2025 at 02:36:40PM -0700, Kamaljit Singh wrote:
> > > -static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
> > > -{
> > > -	return ctrl->opts && ctrl->opts->discovery_nqn;
> > > -}
> > > -
> > 
> > I suppose it's fine to rename this function with an nvmf_ prefix, but
> > it's not really related to the rest of the patch and makes the diff
> > larger than necessary.
> 
> It isn't, nvmf_ is really for code in the fabrics library and not used
> by core code.

Yes, I'm not suggesting to use "nvmf_" in the core. This function checks
for ctrl->ops, which only applies to fabrics, so this is a fabrics
specific function that could belong there instead of the core, is all
I'm saying. Not that I'd recommend making such a move in this patch...

