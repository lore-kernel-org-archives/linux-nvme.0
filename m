Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFE6C7618A
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 12:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cqrD0PMaFB7QGObr/aoLrh/+j2w/IO3JXuweuIkbeas=; b=tZ612eUQpCC/xKcxh+rlwBsZ+5
	TTo+zk90Q1JewTd3CwnjN1y6bbzBRbzaTLnAr20f6MNNMv+pme4UcZlW84WPTIEyGbz3l3UaP8BKO
	Ws18wLA1f+YrwO2ks0LyjIMgCucPO5Mk1guqxXSH9bJxUwVXfr4h01TTBHD7ZD0xOOoXcVkcwOWw5
	29DyIuNdyAZUX3SLeL5ow3/G7OhA0xR0PVgAhfINY1U05FEXFr1tkOgVpvzaIfYz4PopC/+MxSXn8
	fHDB4u6QrH7su0Vblo1xPM1Vzebb7UjhdqATIWzfhmw6tmgvf5w7a/AIZDHvT21QiDvIWplLL2mN7
	jmyHwfKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peEyo-0090fo-1h;
	Mon, 20 Mar 2023 12:51:14 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peEyl-0090f2-1Y
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 12:51:13 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EB80F1F85D
	for <linux-nvme@lists.infradead.org>; Mon, 20 Mar 2023 12:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679316665; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqrD0PMaFB7QGObr/aoLrh/+j2w/IO3JXuweuIkbeas=;
	b=psoeL8wRE8Xj2P81WTa7ymUaoUMYOm1BlDMjDtEtvTSajBHFR13XapS/F36qj80ZlrDIyh
	zppUQ2kZwj6DSTAKEeM1yhfBxM0blr8PsEC7XPmsDHs5b+rwGnrf9f4llT5L14QoL+HvIf
	aoM6C12mpGbMM/5n4n5GEn+U2e6wYak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679316665;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqrD0PMaFB7QGObr/aoLrh/+j2w/IO3JXuweuIkbeas=;
	b=leOhaDzsFufEUu0icRJnwHRhfpr+c6aVzzitCN6cbxfdhmUa3/4Ghf6E+VVMqkPmTWJ5B0
	im9BMu9CdiT03KDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2D0C13A00
	for <linux-nvme@lists.infradead.org>; Mon, 20 Mar 2023 12:51:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id xTEdN7lWGGSQaQAAMHmgww
	(envelope-from <hare@suse.de>)
	for <linux-nvme@lists.infradead.org>; Mon, 20 Mar 2023 12:51:05 +0000
Message-ID: <b0c41e48-b3d8-1e42-eb04-5537a2214611@suse.de>
Date: Mon, 20 Mar 2023 13:51:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] nvme-tcp: fix a possible UAF when failing to allocate
 an io queue
Content-Language: en-US
To: linux-nvme@lists.infradead.org
References: <20230319131422.14527-1-sagi@grimberg.me>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230319131422.14527-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_055111_688052_739F25A9 
X-CRM114-Status: GOOD (  24.50  )
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

On 3/19/23 14:14, Sagi Grimberg wrote:
> When we allocate a nvme-tcp queue, we set the data_ready callback before
> we actually need to use it. This creates the potential that if a stray
> controller sends us data on the socket before we connect, we can trigger
> the io_work and start consuming the socket.
> 
> In this case reported: we failed to allocate one of the io queues, and
> as we start releasing the queues that we already allocated, we get
> a UAF [1] from the io_work which is running before it should really.
> 
> Fix this by setting the socket ops callbacks only before we start the
> queue, so that we can't accidently schedule the io_work in the initialization
> phase before the queue started.
> 
> [1]:
> [16802.107284] nvme nvme4: starting error recovery
> [16802.109166] nvme nvme4: Reconnecting in 10 seconds...
> [16812.173535] nvme nvme4: failed to connect socket: -111
> [16812.173745] nvme nvme4: Failed reconnect attempt 1
> [16812.173747] nvme nvme4: Reconnecting in 10 seconds...
> [16822.413555] nvme nvme4: failed to connect socket: -111
> [16822.413762] nvme nvme4: Failed reconnect attempt 2
> [16822.413765] nvme nvme4: Reconnecting in 10 seconds...
> [16832.661274] nvme nvme4: creating 32 I/O queues.
> [16833.919887] BUG: kernel NULL pointer dereference, address: 0000000000000088
> [16833.920068] nvme nvme4: Failed reconnect attempt 3
> [16833.920094] #PF: supervisor write access in kernel mode
> [16833.920261] nvme nvme4: Reconnecting in 10 seconds...
> [16833.920368] #PF: error_code(0x0002) - not-present page
> [16833.921086] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
> [16833.921191] RIP: 0010:_raw_spin_lock_bh+0x17/0x30
> ...
> [16833.923138] Call Trace:
> [16833.923271]  <TASK>
> [16833.923402]  lock_sock_nested+0x1e/0x50
> [16833.923545]  nvme_tcp_try_recv+0x40/0xa0 [nvme_tcp]
> [16833.923685]  nvme_tcp_io_work+0x68/0xa0 [nvme_tcp]
> [16833.923824]  process_one_work+0x1e8/0x390
> [16833.923969]  worker_thread+0x53/0x3d0
> [16833.924104]  ? process_one_work+0x390/0x390
> [16833.924240]  kthread+0x124/0x150
> [16833.924376]  ? set_kthread_struct+0x50/0x50
> [16833.924518]  ret_from_fork+0x1f/0x30
> [16833.924655]  </TASK>
> 
> Reported-by: Yanjun Zhang <zhangyanjun@cestc.cn>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> Changes from v1:
> - Fix silly compliation error
> 
> Yanjun, I'll be waiting for your Tested-by tag. Need to
> in order to apply this fix.
> 
>   drivers/nvme/host/tcp.c | 37 +++++++++++++++++++------------------
>   1 file changed, 19 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 42c0598c31f2..4ef614bf201c 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1620,22 +1620,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid)
>   	if (ret)
>   		goto err_init_connect;
>   
> -	queue->rd_enabled = true;
>   	set_bit(NVME_TCP_Q_ALLOCATED, &queue->flags);
> -	nvme_tcp_init_recv_ctx(queue);
> -
> -	write_lock_bh(&queue->sock->sk->sk_callback_lock);
> -	queue->sock->sk->sk_user_data = queue;
> -	queue->state_change = queue->sock->sk->sk_state_change;
> -	queue->data_ready = queue->sock->sk->sk_data_ready;
> -	queue->write_space = queue->sock->sk->sk_write_space;
> -	queue->sock->sk->sk_data_ready = nvme_tcp_data_ready;
> -	queue->sock->sk->sk_state_change = nvme_tcp_state_change;
> -	queue->sock->sk->sk_write_space = nvme_tcp_write_space;
> -#ifdef CONFIG_NET_RX_BUSY_POLL
> -	queue->sock->sk->sk_ll_usec = 1;
> -#endif
> -	write_unlock_bh(&queue->sock->sk->sk_callback_lock);
>   
>   	return 0;
>   
> @@ -1691,18 +1676,34 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
>   static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
>   {
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
> +	struct nvme_tcp_queue *queue = &ctrl->queues[idx];
>   	int ret;
>   
> +	queue->rd_enabled = true;
> +	nvme_tcp_init_recv_ctx(queue);
> +	write_lock_bh(&queue->sock->sk->sk_callback_lock);
> +	queue->sock->sk->sk_user_data = queue;
> +	queue->state_change = queue->sock->sk->sk_state_change;
> +	queue->data_ready = queue->sock->sk->sk_data_ready;
> +	queue->write_space = queue->sock->sk->sk_write_space;
> +	queue->sock->sk->sk_data_ready = nvme_tcp_data_ready;
> +	queue->sock->sk->sk_state_change = nvme_tcp_state_change;
> +	queue->sock->sk->sk_write_space = nvme_tcp_write_space;
> +#ifdef CONFIG_NET_RX_BUSY_POLL
> +	queue->sock->sk->sk_ll_usec = 1;
> +#endif
> +	write_unlock_bh(&queue->sock->sk->sk_callback_lock);
> +
Can't you put this into a separate function?
(Will be needing that for TLS support anyway :-)

And shouldn't we consider 'rcu_write_lock_bh' and 
'rcu_assign_sk_user_data()' here?

Cheers,

Hannes


