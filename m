Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBD7606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 22:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=3hO+O6RW;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fxgiJiz3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=E47EXlv1qOfO8mL2nAcVFLDY1Fx4XbQtr8FKJeWWJU4=; b=3hO+O6RWp6YfMcuP/u2NVOI1RV
	uf3ILZdw7XS7unQ/qZjpbSTwjyAsLbZ2agj4ZuMbQJcXQh8zxyfcEGDVYGQv2cXxXYdkuOzCJAL7g
	v8LOjbwMCKrogu6vQgALLzyRJEcQhnh3ZgeH160ga0iQYkYL7twAjBZ6eqM6TbFidfpRlYhPlvQOR
	pirNPB83FfD4FyQ9FtDYTQoSMPwikaA4Rif/3o0aYUWtmQE1cPSb03VbmOpkeppYe1xVlv+dHIre9
	cbPa47s6lzpWU4Te5u0YbJl7ukdb6fWT8CH+sl97Qyep1tOpypTj4eNCGruTu4uchDPJ1v8+TfnZk
	Ox+vM44Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKNxB-0000000H3dO-1tBl;
	Fri, 23 Oct 2026 22:41:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKNxA-0000000H3dD-2m87
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 22:41:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B7E006020F;
	Fri, 23 Oct 2026 22:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F79C1F01825;
	Fri, 23 Oct 2026 22:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792795295;
	bh=E47EXlv1qOfO8mL2nAcVFLDY1Fx4XbQtr8FKJeWWJU4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fxgiJiz3UX6jCdH3kZioLJ+OQKKAzj0EqlyGeGsWBGAIoSpvDETWYi4Pf0zD9thuB
	 LCba+rWgk1TJb/nMdQk4S0CiSbYXFO/xWlly9uo4F9Hyu9h0isS6ogw9tw6xMi4l9/
	 F2lzSu1431VPkLgtAgD8HcjPYsH70lQe8Nkuv2ezd8ueXG4wqlThEZPp9M1TTxjTn2
	 UYH9M+kHcwzSfP1ByCLjoWsWMX5XrFfq5DALUubZSyqRcjw+mbYr/a7P4KLdp9k83B
	 q7mKq08+ehBUNdtrPZJJxDv1OL41OSY5SbpgD7maexREqmbdO18Eb24KITNzH9ivPQ
	 UqDnxngOZcOsg==
Date: Fri, 23 Oct 2026 16:41:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@opensource.wdc.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Surabhi Gogte <sgogte@purestorage.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH] nvmet-rdma: handle commands of established queue outside
 the CM handler
Message-ID: <atvinQcDcpB7pzjK@kbusch-mbp>
References: <20260922124447.588057-1-shinichiro.kawasaki@opensource.wdc.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922124447.588057-1-shinichiro.kawasaki@opensource.wdc.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Sep 22, 2026 at 09:44:47PM +0900, Shin'ichiro Kawasaki wrote:
>     WARNING: possible circular locking dependency detected
>     rm/7346 is trying to acquire lock:
>      (&id_priv->handler_mutex){+.+.}-{4:4}, at: rdma_destroy_id+0x17/0x20 [rdma_cm]
>     but task is already holding lock:
>      (nvmet_config_sem){++++}-{4:4}, at: nvmet_port_subsys_drop_link+0x52/0x340 [nvmet]
> 
>     -> #1 (nvmet_config_sem){++++}-{4:4}:
>            down_read+0xa6/0x530
>            nvmet_find_get_subsys+0x1f4/0x630 [nvmet]
>            nvmet_ctrl_find_get+0xaa/0x320 [nvmet]
>            nvmet_execute_io_connect+0x1e0/0x480 [nvmet]
>            nvmet_rdma_execute_command+0x18e/0x480 [nvmet_rdma]
>            nvmet_rdma_handle_command+0x428/0xb30 [nvmet_rdma]
>            nvmet_rdma_cm_handler+0x8a8/0x30f0 [nvmet_rdma]
>            CPU0 cma_cm_event_handlercma_cm_event_handler+0xb0/0x3c0 [rdma_cm]
>            cma_ib_handler+0x28a/0x9b1 [rdma_cm]
>            cm_process_work+0x4b/0x3e1 [ib_cm]
>            cm_work_handler+0x2485/0xac10 [ib_cm]
> 
>     -> #0 (&id_priv->handler_mutex){+.+.}-{4:4}:
>            rdma_destroy_id+0x17/0x20 [rdma_cm]
>            nvmet_rdma_disable_port+0x44/0x300 [nvmet_rdma]
>            nvmet_rdma_remove_port+0x42/0x60 [nvmet_rdma]
>            nvmet_disable_port+0x120/0x1f0 [nvmet]
>            nvmet_port_subsys_drop_link+0x261/0x340 [nvmet]
>            configfs_unlink+0x36d/0x790
>            vfs_unlink+0x278/0xb40
>            filename_unlinkat+0x31d/0x670
>            __x64_sys_unlinkat+0xae/0x100
> 
>     other info that might help us debug this:
> 
>      Possible unsafe locking scenario:
> 
>            CPU0                    CPU1
>            ----                    ----
>       lock(nvmet_config_sem);
>                                    lock(&id_priv->handler_mutex);
>                                    lock(nvmet_config_sem);
>       lock(&id_priv->handler_mutex);
> 
>      *** DEADLOCK ***
> 
> This WARN can be recreated by repeating the blktests test case nvme/004
> or nvme/032 for rdma transport and rxe driver.

I think this might be a false positive. The handler_mutex taken in
rdma_destroy_id() belongs to the listener, while the one held across
ESTABLISHED belongs to the child cm_id. Is there ever an actual hang, or
just the lockdep splat?

