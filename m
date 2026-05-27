Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1BBCD5BD0
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 15:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WN2eycs/ujPks6xgujkmedWhK8TsKJSPP2kHz2LiIIg=; b=MJpTxwMDxcfnm+YG5gVXSAjvIm
	vo0aCi0DtrVp9DVjQ8S5QnnSEnGiD6VrLb8gbqYOSfMz12tBC7HyinA9DP3d9v8roW8ke0W+Xt8Ud
	BYL3nzDhK/DIArGgos4vKa7IuLbpL7+F7c3VF5VRMX3vutMLytGY2sqqhAg0PKiJAa8djvu3qP9l1
	3BTrRnOHUQmvhZ8xdIEX/vO6mMoL6zuTcdsk+GorU9lAnNpgS9fMM0NHboleaySZlEgjoeeYqarFr
	m5eTHr6Ryp/ar+gBcfAwneQ5SXD25lMVe7C/oh+V6TagL88KxVnYvXHzNgT3drvrEpVNxddke9WGz
	T4Do0j6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFk4-00000004Lvu-48f2;
	Wed, 27 May 2026 15:00:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSFk4-00000004Lvb-0uDZ
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 15:00:20 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4B44B6021C;
	Wed, 27 May 2026 15:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9406C1F000E9;
	Wed, 27 May 2026 15:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779894019;
	bh=WN2eycs/ujPks6xgujkmedWhK8TsKJSPP2kHz2LiIIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N5y+8VfD44ic5nYieykQ5UQQMspzv7yUzHTkHqTVOzHbUihJJUkKRj9gFTcR/DJzn
	 JsIfbir+U5iN2aODgHCjDMcvwXF1xBBARoq0WzA2fJ2nBvCRdCcbfPwFSeN446TCME
	 AemygGppWFIQzCQxFrrKcf0vbqyj7U0NYD8A29SvaH2naH9eDGtVXSl681B+appMWH
	 XiTLmhoHNsYzWk36GcdTRxSgCIMOljOtkCxS3+zAozDiKdNyhC1VMFSxtkJ+SBo2tM
	 PI6ngBDhfAidBiXLDJP80R0KtHCMsgjzKowvfRpxDbvS83wosgOEth/NEapa3gfmFs
	 BQiiUioOnC/fg==
Date: Wed, 27 May 2026 09:00:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Chao Shi <coshi036@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH] nvme: reject completions for requests that are not in
 flight
Message-ID: <ahcHAT6Mj3d2Jrqq@kbusch-mbp>
References: <20260522153034.2168862-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522153034.2168862-1-coshi036@gmail.com>
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

On Fri, May 22, 2026 at 11:30:34AM -0400, Chao Shi wrote:
>   Oops: general protection fault ... KASAN: null-ptr-deref
>   RIP: blk_mq_complete_request_remote+0xe5/0xa80 block/blk-mq.c:1319
>    nvme_handle_cqe drivers/nvme/host/pci.c:1418 [inline]
>    nvme_poll_cq drivers/nvme/host/pci.c:1449
>    nvme_irq drivers/nvme/host/pci.c:1463

This scenario doesn't sound specific to nvme. Should blk-mq completion
check for the IN_FLIGHT state instead?

