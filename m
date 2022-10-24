Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0228FA373E
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 12:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bvPuoAbeDVoOnLBP0QUVvKraWAF2FCrSPymJ3YB+DVQ=; b=hfo+Mx8OHc+TbBCZFiqxzkVZpu
	Smrdo/kCb6VyHlEKbH39/kZcbQ1qVPel+cnssxA/ZMr3MS4kGYnwVawKJM5VTAMVWjjknRvkNomDA
	47bGXclVBzEeU15OmMu0YCZ+9Wm/tzji/FVL6FvF+HJHHtOT33BDoAsABtKjv2dCMNCEfzGcgHHBy
	5ByLn20iwlqMWAzEZwfXSnaVt6c2kESrpnOQieHzzlMJH+jEnhTZAu4epCfpzSE8ab9Elm89dqQ6N
	yidlkMzB+2Zeau+p3sdikSPKj5QDkw1C6IFbZKnLKEvol0lUQIhRO3++lyrupxdCHL7Z1azGW8HZf
	RV701LHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omwQn-001Kkn-Js; Mon, 24 Oct 2022 12:19:49 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omwQf-001Ki3-QE
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 12:19:43 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 977C91FD74;
	Mon, 24 Oct 2022 12:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1666613978; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bvPuoAbeDVoOnLBP0QUVvKraWAF2FCrSPymJ3YB+DVQ=;
	b=Hg7kN4pvOIQntEuSRqCam9nD84j/0K2Syez6+vErGAHBivByYw4Ban8HhMJE3KQhF9AMlE
	aKCSsET74BENDO8JS3/f/KreXJ0f4kXj832dwRi57adPl84MuvQ4fzjF3loLKrt9mIocYX
	vHUIeN3n8ZUb6dItcIB71F6qJk8tUK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1666613978;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bvPuoAbeDVoOnLBP0QUVvKraWAF2FCrSPymJ3YB+DVQ=;
	b=yeMIam+FB4B+Lq4y+z0P6BZkB8t5DMAhKPzqSpllRKn6qKyMw+TxRGtRG22Xj0mvyw/XWd
	7xqpfgeReP1pZeDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8A36E13A79;
	Mon, 24 Oct 2022 12:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id Jb2vIdqCVmMIVQAAMHmgww
	(envelope-from <dwagner@suse.de>); Mon, 24 Oct 2022 12:19:38 +0000
Date: Mon, 24 Oct 2022 14:19:38 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] nvme-tcp: Fix possible circular locking when deleting a
 controller under memory pressure
Message-ID: <20221024121938.an457jsv55se3y6l@carbon.lan>
References: <20221023080443.592097-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221023080443.592097-1-sagi@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_051942_032624_0897D7D3 
X-CRM114-Status: GOOD (  19.22  )
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

On Sun, Oct 23, 2022 at 11:04:43AM +0300, Sagi Grimberg wrote:
> When destroying a queue, when calling sock_release, the network stack
> might need to allocate an skb to send a FIN/RST. When that happens
> during memory pressure, there is a need to reclaim memory, which
> in turn may ask the nvme-tcp device to write out dirty pages, however
> this is not possible due to a ctrl teardown that is going on.
> 
> Set PF_MEMALLOC to the task that releases the socket to grant access
> to PF_MEMALLOC reserves. In addition, do the same for the nvme-tcp
> thread as this may also originate from the swap itself and should
> be more resilient to memory pressure situations.
> 
> This fixes the following lockdep complaint:
> --
> ======================================================
>  WARNING: possible circular locking dependency detected
>  6.0.0-rc2+ #25 Tainted: G        W
>  ------------------------------------------------------
>  kswapd0/92 is trying to acquire lock:
>  ffff888114003240 (sk_lock-AF_INET-NVME){+.+.}-{0:0}, at: tcp_sendpage+0x23/0xa0
> 
>  but task is already holding lock:
>  ffffffff97e95ca0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x987/0x10d0
> 
>  which lock already depends on the new lock.
> 
>  the existing dependency chain (in reverse order) is:
> 
>  -> #1 (fs_reclaim){+.+.}-{0:0}:
>         fs_reclaim_acquire+0x11e/0x160
>         kmem_cache_alloc_node+0x44/0x530
>         __alloc_skb+0x158/0x230
>         tcp_send_active_reset+0x7e/0x730
>         tcp_disconnect+0x1272/0x1ae0
>         __tcp_close+0x707/0xd90
>         tcp_close+0x26/0x80
>         inet_release+0xfa/0x220
>         sock_release+0x85/0x1a0
>         nvme_tcp_free_queue+0x1fd/0x470 [nvme_tcp]
>         nvme_do_delete_ctrl+0x130/0x13d [nvme_core]
>         nvme_sysfs_delete.cold+0x8/0xd [nvme_core]
>         kernfs_fop_write_iter+0x356/0x530
>         vfs_write+0x4e8/0xce0
>         ksys_write+0xfd/0x1d0
>         do_syscall_64+0x58/0x80
>         entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
>  -> #0 (sk_lock-AF_INET-NVME){+.+.}-{0:0}:
>         __lock_acquire+0x2a0c/0x5690
>         lock_acquire+0x18e/0x4f0
>         lock_sock_nested+0x37/0xc0
>         tcp_sendpage+0x23/0xa0
>         inet_sendpage+0xad/0x120
>         kernel_sendpage+0x156/0x440
>         nvme_tcp_try_send+0x48a/0x2630 [nvme_tcp]
>         nvme_tcp_queue_rq+0xefb/0x17e0 [nvme_tcp]
>         __blk_mq_try_issue_directly+0x452/0x660
>         blk_mq_plug_issue_direct.constprop.0+0x207/0x700
>         blk_mq_flush_plug_list+0x6f5/0xc70
>         __blk_flush_plug+0x264/0x410
>         blk_finish_plug+0x4b/0xa0
>         shrink_lruvec+0x1263/0x1ea0
>         shrink_node+0x736/0x1a80
>         balance_pgdat+0x740/0x10d0
>         kswapd+0x5f2/0xaf0
>         kthread+0x256/0x2f0
>         ret_from_fork+0x1f/0x30
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(fs_reclaim);
>                                lock(sk_lock-AF_INET-NVME);
>                                lock(fs_reclaim);
>   lock(sk_lock-AF_INET-NVME);
> 
>  *** DEADLOCK ***
> 
> 3 locks held by kswapd0/92:
>  #0: ffffffff97e95ca0 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat+0x987/0x10d0
>  #1: ffff88811f21b0b0 (q->srcu){....}-{0:0}, at: blk_mq_flush_plug_list+0x6b3/0xc70
>  #2: ffff888170b11470 (&queue->send_mutex){+.+.}-{3:3}, at: nvme_tcp_queue_rq+0xeb9/0x17e0 [nvme_tcp]
> 
> Reported-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>

Tested-by: Daniel Wagner <dwagner@suse.de>


