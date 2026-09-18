Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F47EC982D8
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 15:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S82gNLURUVEd42qKqLAV6CWU9l2uRU5gXjuBbJpx9XM=; b=4ji9IhJUsjDzRsRZogknZUtaUv
	5QGO/iW7/BxSo6E/kDLZUPJ4RvER1FT2y8LmN3XcmeDffsfJxGndy/ZdEpSo47CcCDO+jJ7AkDEfn
	Is83k9SCHbWJfBP4uJM2koPbDFrYXci3xP57Ozf5DV7tuNVITGNwFQuiWGVoHrn2KpxsGD3tgANIq
	f1MH6nTxeTRpRGO8WdJcL1CgUKeXPDi/mvZ+dZp0xcurwJW11lT3/5EnAkojl/bGuK7+mpEVKadcF
	fxUizUnAQF9aIT57XUlpzgi1WYM5P9WMsE+MxPppW53XsUPr/FVnafD/G0w1+FWNfrRtYOIl/aGUw
	QopD5y4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7aLn-0000000Er2K-0kiM;
	Fri, 18 Sep 2026 15:18:07 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7aLl-0000000Er2D-441q
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 15:18:06 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 6AAD1601EF;
	Fri, 18 Sep 2026 15:18:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD981F000FF;
	Fri, 18 Sep 2026 15:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789744685;
	bh=S82gNLURUVEd42qKqLAV6CWU9l2uRU5gXjuBbJpx9XM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ivgqK9iwMqXIMmVpjbsKaKPtRWJEamrW7bFCVQh8ISq9Co3a+JtxzefrAnXhj7PuF
	 wLzqRYsz4EnP0ycCGJzXkXw9psQOxzb0dvX3wTln/sxHrU/v/XWWr2PqidO81CAF31
	 cs0DH9QaEV4LUJapntbecmD75jkOoSokGNQ2h1+6eivNmLnIgIZjnJeWXeGVsy7KRL
	 OdIj6s9QBpoPd46eFAV41TFFi/pek31MZmNkml279cackF44BwaRLRGZcsB+qRP9n1
	 TceE7YfhvXi8AtQBCjNGPkmGAN1+r9AracXjL6Ua5gdoJ1uExcqekY2jRS8v5c/v6k
	 hHI0Sp9lwZCfA==
Date: Fri, 18 Sep 2026 09:18:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	co+77553a7fc66ac133@bugs.sh, Xiang Mei <xmei5@asu.edu>,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet-auth: fix out-of-bounds write in
 nvmet_auth_challenge()
Message-ID: <aq1WKv3UKpNf_3rL@kbusch-mbp>
References: <20260912171009.1513289-3-bestswngs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260912171009.1513289-3-bestswngs@gmail.com>
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

On Sun, Sep 13, 2026 at 01:10:11AM +0800, Weiming Shi wrote:
> nvmet_auth_challenge() receives its output buffer as a void pointer.
> sizeof(*d) therefore evaluates to one with GCC and undercounts the fixed
> challenge header by 15 bytes.  A short AUTH_RECEIVE buffer can pass the
> check before the challenge is copied past the end of its allocation.
> 
> Use the typed challenge pointer when calculating the response size.
> 
>   BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_receive (drivers/nvme/target/fabrics-cmd-auth.c:442 drivers/nvme/target/fabrics-cmd-auth.c:569)
>   Write of size 32 by task kworker/1:1H/64
>   Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
>   Call Trace:
>   nvmet_execute_auth_receive (drivers/nvme/target/fabrics-cmd-auth.c:442 drivers/nvme/target/fabrics-cmd-auth.c:569)
>   nvmet_tcp_try_recv_pdu (drivers/nvme/target/tcp.c:1119 drivers/nvme/target/tcp.c:1243)
>   nvmet_tcp_io_work (drivers/nvme/target/tcp.c:1350 drivers/nvme/target/tcp.c:1382 drivers/nvme/target/tcp.c:1445)
>   process_one_work (kernel/workqueue.c:3322)
>   worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3486)
>   kthread (kernel/kthread.c:436)
>   ret_from_fork (arch/x86/kernel/process.c:158)
>   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>   The buggy address is located 16 bytes inside of
>    allocated 33-byte region [ffff888000554e80, ffff888000554ea1)
>   Kernel panic - not syncing: KASAN: panic_on_warn set ...

Thanks, applied to nvme-7.3.

