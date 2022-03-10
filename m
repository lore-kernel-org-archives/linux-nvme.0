Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A69DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 08:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O9sBlpHtLK1k+IEvJ9N7Qy6+kFDgXLvhZHYLp3zOMfY=; b=bxTP6S7EMolXVQnd4diG4w/S+6
	/yElOJD/GVFokTaa6e+cRbLKAZZgjW2+gXHcpJ7rIpRIL1CtpEbioi+Z6J/0IsZtK3INyb4nLJ8wD
	JvuVEzyakbhaBhueF2pjYP1eIO6zpX+U4x1m6Byyd8v3Jbso68UZoyv1F2u6dTamVbROwpwo+Hr/G
	gBoyJk7YQlE8I2IsNfb7SHxYdKXyVlU67R7F5IrJ0K5UIzM9b14cKPeJO1SjLR8o5P5g3OtvKRKPv
	/E+GqUf3lLX2NJ77GEqHqEBvCgqyKrjDKXdCb4EhAOwXbesoOOt2ZSucIkxhFS12pPTAfJYUvl7Jq
	uXalbMrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSEAw-00BuG8-Ie; Thu, 10 Mar 2022 08:29:34 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSEAs-00BuF5-R7
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 08:29:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 4F60268AFE; Thu, 10 Mar 2022 09:29:26 +0100 (CET)
Date: Thu, 10 Mar 2022 09:29:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com,
 logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
 mcgrof@kernel.org, a.manzanares@samsung.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com
Subject: Re: [PATCH 00/17] io_uring passthru over nvme
Message-ID: <20220310082926.GA26614@lst.de>
References: <CGME20220308152651epcas5p1ebd2dc7fa01db43dd587c228a3695696@epcas5p1.samsung.com>
 <20220308152105.309618-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308152105.309618-1-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_002931_197951_28FB860E 
X-CRM114-Status: GOOD (  24.45  )
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

What branch is this against?

Do you have a git tree available?

On Tue, Mar 08, 2022 at 08:50:48PM +0530, Kanchan Joshi wrote:
> This is a streamlined series with new way of doing uring-cmd, and connects
> nvme-passthrough (over char device /dev/ngX) to it.
> uring-cmd enables using io_uring for any arbitrary command (ioctl,
> fsctl etc.) exposed by the command provider (e.g. driver, fs etc.).
> 
> To store the command inline within the sqe, Jens added an option to setup
> the ring with 128-byte SQEs.This gives 80 bytes of space (16 bytes at
> the end of the first sqe + 64 bytes in the second sqe). With inline
> command in sqe, the application avoids explicit allocation and, in the
> kernel, we avoid doing copy_from_user. Command-opcode, length etc.
> are stored in per-op fields of io_uring_sqe.
> 
> Non-inline submission (when command is a user-space pointer rather than
> housed inside sqe) is also supported.
> 
> io_uring sends this command down by newly introduced ->async_cmd()
> handler in file_operations. The handler does what is required to
> submit, and indicates queued completion.The infra has been added to
> process the completion when it arrives.
> 
> Overall the patches wire up the following capabilities for this path:
> - async
> - fixed-buffer
> - plugging
> - bio-cache
> - sync and async polling.
> 
> This scales well. 512b randread perf (KIOPS) comparing
> uring-passthru-over-char (/dev/ng0n1) to
> uring-over-block(/dev/nvme0n1)
> 
> QD    uring    pt    uring-poll    pt-poll
> 8      538     589      831         902
> 64     967     1131     1351        1378
> 256    1043    1230     1376        1429
> 
> Testing/perf is done with this custom fio that turnes regular-io into
> passthru-io on supplying "uring_cmd=1" option.
> https://github.com/joshkan/fio/tree/big-sqe-pt.v1
> 
> Example command-line:
> fio -iodepth=256 -rw=randread -ioengine=io_uring -bs=512 -numjobs=1
> -runtime=60 -group_reporting -iodepth_batch_submit=64
> -iodepth_batch_complete_min=1 -iodepth_batch_complete_max=64
> -fixedbufs=1 -hipri=1 -sqthread_poll=0 -filename=/dev/ng0n1
> -name=io_uring_256 -uring_cmd=1
> 
> 
> Anuj Gupta (3):
>   io_uring: prep for fixed-buffer enabled uring-cmd
>   nvme: enable passthrough with fixed-buffer
>   nvme: enable non-inline passthru commands
> 
> Jens Axboe (5):
>   io_uring: add support for 128-byte SQEs
>   fs: add file_operations->async_cmd()
>   io_uring: add infra and support for IORING_OP_URING_CMD
>   io_uring: plug for async bypass
>   block: wire-up support for plugging
> 
> Kanchan Joshi (5):
>   nvme: wire-up support for async-passthru on char-device.
>   io_uring: add support for uring_cmd with fixed-buffer
>   block: factor out helper for bio allocation from cache
>   nvme: enable bio-cache for fixed-buffer passthru
>   io_uring: add support for non-inline uring-cmd
> 
> Keith Busch (2):
>   nvme: modify nvme_alloc_request to take an additional parameter
>   nvme: allow user passthrough commands to poll
> 
> Pankaj Raghav (2):
>   io_uring: add polling support for uring-cmd
>   nvme: wire-up polling for uring-passthru
> 
>  block/bio.c                     |  43 ++--
>  block/blk-map.c                 |  45 +++++
>  block/blk-mq.c                  |  93 ++++-----
>  drivers/nvme/host/core.c        |  21 +-
>  drivers/nvme/host/ioctl.c       | 336 +++++++++++++++++++++++++++-----
>  drivers/nvme/host/multipath.c   |   2 +
>  drivers/nvme/host/nvme.h        |  11 +-
>  drivers/nvme/host/pci.c         |   4 +-
>  drivers/nvme/target/passthru.c  |   2 +-
>  fs/io_uring.c                   | 188 ++++++++++++++++--
>  include/linux/bio.h             |   1 +
>  include/linux/blk-mq.h          |   4 +
>  include/linux/fs.h              |   2 +
>  include/linux/io_uring.h        |  43 ++++
>  include/uapi/linux/io_uring.h   |  21 +-
>  include/uapi/linux/nvme_ioctl.h |   4 +
>  16 files changed, 689 insertions(+), 131 deletions(-)
> 
> -- 
> 2.25.1
---end quoted text---

