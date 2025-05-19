Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4B96C2D0CD
	for <linux-nvme@archiver.kernel.org>; Mon, 19 May 2025 05:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HLtO9dbB24Zx877FwL/qgoWyv6R7P9TTQrpYYd2hnD8=; b=0U/sXs5E6H6aHDtilNscLeDUh5
	+lfMbD3YswCZfFBhWbrOLvQJLm4gbtvQK8H26wzWlKEOEc11gSSvcWXso4W3r/5SSN2WcbTgYF/rq
	mMkZrxgn5Db79K7H70tuR1MXc41nl3wzn2U5sLQq2xjxHzerHTe6RQR8yxvHiN7zLfLiLxuPXJae4
	ol4wt9oiGE9Eg3vUJVJdA6uA3+eLbOQU5DaXCFePXuDFuN9Zur5HOAMPyyyBVKLfssaINCrTDqobx
	YZz0nxwiku27rXuAlzN/gGAIpS2Os/dPLomlt/ki9Ai4c5Z7raiXRYDo2xSGbntmxXNH7cHun/4BF
	kRkMOxcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGtNI-000000082hS-0G89;
	Mon, 19 May 2025 05:49:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uGtND-000000082gx-3Sza
	for linux-nvme@lists.infradead.org;
	Mon, 19 May 2025 05:49:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 215A868B05; Mon, 19 May 2025 07:49:06 +0200 (CEST)
Date: Mon, 19 May 2025 07:49:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>, Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org
Subject: nvme-cli & json vs blktests
Message-ID: <20250519054905.GA6156@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250518_224916_107230_950546A7 
X-CRM114-Status: GOOD (  11.20  )
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

Hi all,

I recently did a long overdue update of blktests on my main test
machine, and a large part of the nvme tests started failing.  I
eventually bisected this down to:

commit 444f0df9f0c537335f59c1721240212852656e5b
Author: Hannes Reinecke <hare@suse.de>
Date:   Wed Oct 30 15:51:45 2024 +0900

    nvme: check for controller device in _nvme_connect_subsys()


which adds a requirements for json output from nvme connect, and
just silently fails if not present.

Now after figuring this out I went to rebuild my nvme-cli after installing
the json-c development package.

... and nothing changes.

It looks like the nvme-cli build system unfortunately doesn't pick up
changes in available dependencies even after a make clean.  It turns
out a make purge eventually fixed it, but that's a little unexpected.

Can we get proper feature check for json support in blktests and maybe
make the nvme-cli build a little less arcane?

