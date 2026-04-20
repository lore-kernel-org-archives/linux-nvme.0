Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75E1DF588DF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 14:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IX/JHEqs1/hmoahIOhvWIEgiLJ8jkJKF9ndgHAzG6wE=; b=J7XbN02/XYkm1DRxl2xf8ZWQ/S
	CjOWuCxokiXtsfMaW14tVNU3wSrLGY/yEEDuJgtTk2ejzN5Fk81WITPvXWwNY2W4fmWMsjD5jJ6YL
	GCd0NSyinyRguZpeoFZFmPfqVDSRskgaWeU8Fnkzb7QZREE0uVEDL8Ey3sgph1AVWfYpuMeLs6Xba
	umufLOhKsIg3Yq1Fn9GKnWhYWtf7LIpnedgOkJ85MFmOhG6y8qRxyL7+bbsk1PtdyaNp3mkKn1H89
	21aohXmXOC/hbQFlvN8zvsHKPEMxB9jQ6LR529iv24vvWeYiBXZiv0xNSxHbKnX6rli0hZMKsR5ZH
	tg0hG29g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEq14-00000007CUs-3zRd;
	Mon, 20 Apr 2026 14:54:26 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEq12-00000007CUG-2Eta
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 14:54:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 22E4040AC5;
	Mon, 20 Apr 2026 14:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E44FC19425;
	Mon, 20 Apr 2026 14:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776696864;
	bh=o4yy5WH/m71HPtOkxuFd1gFe/seDYLMN3dzJeM1EXoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sBRRXJ8Tb9It0KcfkMkcyyXbc5D324kFK04WhGGWbG9H84QsAPC89eqL8zEsWgWbg
	 7jD52qelvR9F/EPr5nqz0UUgId3SBKEn0MyfA7+fUQazrCJPgVX5MX/9rNKjjKa015
	 /JAobfbLUsIuJyBLERiUtYdFndLZG5Iyc+/1+VGz2U9VbSe8AJqecpvFKrakTXSdKq
	 Ijm91nJ8nkVFPDQty6uaLrMy/d9OjhupkcrNPANDr+B+yHj+W/UW+olS10rO8hbeQZ
	 cj3VbZSMrYMI+ZHW0kBNW/cQMVohNXeWNAOYVV1297Yu5tMbNfazTr16LKnmPSijkn
	 G9rza4SD0Q66A==
Date: Mon, 20 Apr 2026 08:54:21 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Chao Shi <coshi036@gmail.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH] nvme: core: reject invalid LBA data size from Identify
 Namespace
Message-ID: <aeY-HYDHq1wEhLYc@kbusch-mbp>
References: <20260418042835.420281-1-coshi036@gmail.com>
 <cb2c00e2-ba72-4d6d-b17f-ef5ae3b0633e@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb2c00e2-ba72-4d6d-b17f-ef5ae3b0633e@flourine.local>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_075424_590191_21A3741E 
X-CRM114-Status: GOOD (  10.31  )
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

On Mon, Apr 20, 2026 at 02:22:04PM +0200, Daniel Wagner wrote:
> On Sat, Apr 19, 2026 at 12:28:34AM -0400, Chao Shi wrote:
> > Fixes: 9419e71b8d67 ("nvme: move ns id info to struct nvme_ns_head")
> 
> This fixes tag is wrong. The above commit doesn't touch the code line
> in question.
> 
> Probably a5b1cd61820e ("nvme: move a few things out of
> nvme_update_disk_info") is the better choice here.

We've never validated the 'ds' field though, so not sure anything
introduced a regression here that warrants a fixing tag.

