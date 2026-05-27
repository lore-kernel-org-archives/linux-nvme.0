Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F41CD5BD5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 May 2026 13:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YVX08wy9EDmWmFdJhXjRDCPmezWy2eJk8Dpk/tYKqDE=; b=ckBXrv2Vg5Y/zsfSFxkKM80yi9
	W/RQRqhbKqKvo630T+2/y22npcjCJBmxSBl5w9yRV5S/zuByNZOIVVZ8SI2Ik4or2mmWQMfT+GM9a
	nC0FE2gopgi3RR0akibjeu7WQG+Wx5riNTzXJCSHGeZ7KfhinM0Og0WmHDNLVOdteSoCdus3sTC5D
	IveYgl6HxJ2szVfcv9qsbTKv4bzH48BD72LKrQU1EoNMQaAJGXXGBTKQrKce6Erg2LgPRoSU3cmps
	C/Yang7Uqrk50rz/atvic+4ebQVT1z8WCHm/SWjIH6xsE2cjTwNherfiQGjihSfaBgiwMKhtwuwnE
	DJwgrArQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEHp-00000004BoG-34xy;
	Wed, 27 May 2026 13:27:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSEHn-00000004BnP-0lDj
	for linux-nvme@lists.infradead.org;
	Wed, 27 May 2026 13:27:04 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 30FE968B05; Wed, 27 May 2026 15:26:59 +0200 (CEST)
Date: Wed, 27 May 2026 15:26:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Chao Shi <coshi036@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sungwoo Kim <iam@sung-woo.kim>,
	Dave Tian <daveti@purdue.edu>, Weidong Zhu <weizhu@fiu.edu>
Subject: Re: [PATCH] nvme: bound the freeze drain in passthrough commands
Message-ID: <20260527132658.GA11713@lst.de>
References: <20260527055923.456769-1-coshi036@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527055923.456769-1-coshi036@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_062703_367533_87E08C0B 
X-CRM114-Status: GOOD (  17.17  )
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

On Wed, May 27, 2026 at 01:59:23AM -0400, Chao Shi wrote:
> nvme_passthru_start() drains in-flight I/O via the unbounded
> nvme_wait_freeze() before submitting a command with command-set
> effects (Format NVM, Sanitize, Namespace Management, vendor unique).
> If a completion is silently dropped or the device hangs, the calling
> task wedges with ctrl->scan_lock and ctrl->subsys->lock held, fanning
> out into hung-task reports on any concurrent open/close/passthru on
> the same controller:
> 
>   INFO: task syz-executor:NNNN blocked for more than 123 seconds.
>    nvme_wait_freeze+0x82/0x100
>    nvme_passthru_start drivers/nvme/host/core.c:1249 [inline]
>    nvme_submit_user_cmd+0x1ee/0x3d0 drivers/nvme/host/ioctl.c:189
> 
> The other freeze-drain sites (pci shutdown, tcp/rdma reset) already
> bound the wait with nvme_wait_freeze_timeout(NVME_IO_TIMEOUT).  Apply
> it here too; on timeout, unwind the freeze and return -EBUSY (or
> NVME_SC_INTERNAL on the nvmet path) instead of submitting the command.
> 
> Found by FuzzNvme(Syzkaller with FEMU fuzzing framework).

So not blocking forever sounds useful, but this might break existing
uses.  I guess we could do it based on the O_NONBLOCK flag if people
really cared.

Note that the blocked message itself is not a problem, but around
this time we should have done a controller reset and fixed up the
issue.  Does that not happen for your test case?


