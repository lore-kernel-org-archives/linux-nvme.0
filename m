Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013F4C02181
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jan 2025 19:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SOkwlymvbLOVY7j678BS2DtyPyJ6oeYD0OVF7GpfXkM=; b=j3//e731lP20XtKV3PA1mLQy2L
	13ZvYF2ApQVl81DMJiEORl87VMucqebdZQ1hThtezB+NHjvSYb5U7e55QjuoYQZzMWuah6gWmzcm5
	19drI20llXzffZQ2kKrqd5lLaJsBVfEqzthS3DfDxumJ3vykJNdo28lbaCYTX7+LA+8LCkEQ+rggx
	oA7izB/cw7zPH2ZDG83rYUeYcXjX1GrZZ11ju4ANyCoi6e4/xY16v+vGj4u7RVK9XOYMSmNlv1WS7
	WBUUz6FVwScIm8/iD/Qj9T6+CeHKk/lPy42f4ToeIaDQ498/eN24B93y2FDOV8hwpHBE/afHqEW56
	zjMmzqVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbPqC-0000000FQnQ-1u8o;
	Fri, 24 Jan 2025 19:59:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbPqA-0000000FQn6-2m3D
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jan 2025 19:59:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DAACF5C5FD6;
	Fri, 24 Jan 2025 19:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89DA9C4CED2;
	Fri, 24 Jan 2025 19:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737748781;
	bh=G0XmIYDBb/mkukIMGokMkHXOXMb/vPiAIHJBThcAgBE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KR8irYjPhH6XITpyWIZ2SIsHMCqdVyfrUvHyArchvhNgd6Ozm6XL26lGUevPxlqF+
	 WBPUJ06LRiHg6WEraczvrBKFcWTN1F5LWokhRaWDWiPr6XF5bveiECSN6bLub4xaaz
	 QrtZnQLUAiE4vyWeURnp2p6Zv4frMmncQjx1GBQOYtoeAodc/ngzaq/AZiiD9+fDAB
	 lQYupFilaHdwWxJSnVyMqQPofg1nPQ8YGjud0ujbDenm0j6VVwA4t/5pYlh28B4/kG
	 wctT31RRrOKGoSS+VTuBbnHfJuAruIbl/JsNdB6XW/at5CzQtfyw+AunGIhCQ7dx6W
	 jbolpm+HaxmoQ==
Date: Fri, 24 Jan 2025 12:59:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: hare@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet: move percpu handling into
 nvmet_ns_{enable,disable}
Message-ID: <Z5PxKynpEA71LKVV@kbusch-mbp>
References: <20250124082505.140258-1-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250124082505.140258-1-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_115942_741012_1FA839EE 
X-CRM114-Status: GOOD (  10.37  )
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

On Fri, Jan 24, 2025 at 09:25:05AM +0100, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> The namespace percpu counter protects pending I/O, and we can
> only safely diable the namespace once the counter drop to zero.
> So we need to init the percpu counter in nvmet_ns_enable(), and
> wait for it to drop to zero in nvmet_ns_disable() to avoid having
> I/O pending after the namespace has been disabled.
> 
> Fixes: 74d16965d7ac ("nvmet-loop: avoid using mutex in IO hotpath")

We'll have to wait for after the merge window when the block tree merges
up to apply this: the nvme-6.14 branch doesn't contain the offending
commit yet.

