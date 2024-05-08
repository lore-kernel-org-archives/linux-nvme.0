Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AFDC04FFE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 13:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yvatRbDHRiDjVVcUXydySlcwvPMvLDqHenQIEZ2ULno=; b=WqupoU+De50Dv/pCfCca1SVJJk
	ArTWX0oCc6IeIrkli5hbPp1/dSrc7Wdr4G1Cd1DCXddGNomUiweqJb1ZTiC8hXyAom0pmH48uKyIl
	l4UwQvIjxgQOVGnrIinGsfo5Axw7i7rS7+op2YFwCqraOE8LYRJyjGeL6x/SeYIEhLhM2lEHF36tx
	aDRDnGRT8mcx2YnmgFmhIbNyxsa9KRk7hN9MA0tdaF557/+m4tPcQdTZBBuD6RDS/t2QEWBoePFwQ
	GFbzh/NXueCLL8eEzOamAJYpU33knk5PGnv+1xke0dMdnWiMiwEIzqsDon7X+6epOb2ASSRL55VmN
	daS9FYmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4hDc-0000000FcQQ-2oKJ;
	Wed, 08 May 2024 13:20:24 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4hDU-0000000FcOQ-44u7
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 13:20:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 35E8F61B2A;
	Wed,  8 May 2024 13:20:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98312C113CC;
	Wed,  8 May 2024 13:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715174415;
	bh=i+IyY9fL+LLz+uR111un8zhWGN0s7G/sOMZgA1dWd7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYIPaelfZPfgzHnnbwaeuOACJdTdcUd5l+FD7aJYsLn6mf7veMXQDHY6hFSanv2al
	 t6wgAd0L13EKNTs+MyDJqM02UBd01G1OeTYAup182WTk5o4ODDVIC4oofF5zXLraga
	 BW7GC39Xfvlty4PWiGTeSU8SI+aGgyrO67E2aiv6Td9zVoT+7bxYUHoKXc4yMGYHuU
	 dDrDj6ydVlu6bgwO6TSbmtpmFcJpXT4nO9h0Hsgh4yTreKzrfPmC24i0ae9kytGTou
	 QMGmZrn/fPzD7c5Mp3Usv8HvKZjvR95xd1vfEkCLvEDqYWblMemGz4MslzHx1aVc9J
	 bOgOyCER3AAXw==
Date: Wed, 8 May 2024 07:20:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v2] nvmet-rdma: fix possible bad dereference when freeing
 rsps
Message-ID: <Zjt8DdUisFi68Lh5@kbusch-mbp.dhcp.thefacebook.com>
References: <20240508075306.1835106-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240508075306.1835106-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_062017_080609_60D35B77 
X-CRM114-Status: GOOD (  17.40  )
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

On Wed, May 08, 2024 at 10:53:06AM +0300, Sagi Grimberg wrote:
> It is possible that the host connected and saw a cm established
> event and started sending nvme capsules on the qp, however the
> ctrl did not yet see an established event. This is why the
> rsp_wait_list exists (for async handling of these cmds, we move
> them to a pending list).
> 
> Furthermore, it is possible that the ctrl cm times out, resulting
> in a connect-error cm event. in this case we hit a bad deref [1]
> because in nvmet_rdma_free_rsps we assume that all the responses
> are in the free list.
> 
> We are freeing the cmds array anyways, so don't even bother to
> remove the rsp from the free_list. It is also guaranteed that we
> are not racing anything when we are releasing the queue so no
> other context accessing this array should be running.
> 
> [1]:
> --
> Workqueue: nvmet-free-wq nvmet_rdma_free_queue_work [nvmet_rdma]
> [...]
> pc : nvmet_rdma_free_rsps+0x78/0xb8 [nvmet_rdma]
> lr : nvmet_rdma_free_queue_work+0x88/0x120 [nvmet_rdma]
>  Call trace:
>  nvmet_rdma_free_rsps+0x78/0xb8 [nvmet_rdma]
>  nvmet_rdma_free_queue_work+0x88/0x120 [nvmet_rdma]
>  process_one_work+0x1ec/0x4a0
>  worker_thread+0x48/0x490
>  kthread+0x158/0x160
>  ret_from_fork+0x10/0x18
> --
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Thanks, applied to nvme-6.9.

