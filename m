Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F12FC021B8
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2025 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oiUL+FCLwDchpJtT8ks09pr8sL5AoGn7UliUHXn2hGo=; b=dsBe5R2BqcWWSUcGsTnwebVaDo
	UYFN5QcNbWX5O/vAmeiLPesa25V8+lhXYCi9ePyQl4rnCrWyIg8KsgzsiTivomtMWxrKa2uHiGVgM
	X8BGY98YghG+E1rbaq6mYM125daD+taGqTYRJC7bcsDKbfapbIjH+3sHSiRqMypnzDd/zwZM6mrMl
	KA1DXufz7OxXqheOap73YHPTi1Fb+nDg/O0zyc3KOHGwzK8i/BICnlSzDYAK2LeHFJb06MkpbbHdr
	tdlYJuhvimmwbaqgZcl5YLMBhoa4W0fmoz9ebKDwCSTuTlaxm76Mw0jihUtmXiG6qCyex5I62wuow
	mfPoWQmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tnE54-00000003A5e-1uSB;
	Wed, 26 Feb 2025 09:51:54 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tnDzw-0000000399O-2Hfc
	for linux-nvme@lists.infradead.org;
	Wed, 26 Feb 2025 09:46:37 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8B36F21163;
	Wed, 26 Feb 2025 09:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740563193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiUL+FCLwDchpJtT8ks09pr8sL5AoGn7UliUHXn2hGo=;
	b=x/YnMLWcQSUa7X224Sk3dJs23G9ejgYpCeHxnuWs2Id820puWxMPqd4U8pl8e3TJxk5RB7
	Ygo1tmMaiIKJM61WbaA+51sx82cVf1FUyP4WOqdSTqs2pkQTtpxvI6lLtzYLrsXoSePq1O
	WyLtwJRHJ+S69ns3fiXxVCYKCP3Xo0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740563193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiUL+FCLwDchpJtT8ks09pr8sL5AoGn7UliUHXn2hGo=;
	b=8zD+qkdTjYMDke3FSCuGEk76bMV/sQBtCegZV5ka8qq6VoPs5GsGeLUjnizyqQXtnbI2iZ
	eTcJS2aBni4HqcCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1740563193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiUL+FCLwDchpJtT8ks09pr8sL5AoGn7UliUHXn2hGo=;
	b=x/YnMLWcQSUa7X224Sk3dJs23G9ejgYpCeHxnuWs2Id820puWxMPqd4U8pl8e3TJxk5RB7
	Ygo1tmMaiIKJM61WbaA+51sx82cVf1FUyP4WOqdSTqs2pkQTtpxvI6lLtzYLrsXoSePq1O
	WyLtwJRHJ+S69ns3fiXxVCYKCP3Xo0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1740563193;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oiUL+FCLwDchpJtT8ks09pr8sL5AoGn7UliUHXn2hGo=;
	b=8zD+qkdTjYMDke3FSCuGEk76bMV/sQBtCegZV5ka8qq6VoPs5GsGeLUjnizyqQXtnbI2iZ
	eTcJS2aBni4HqcCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A43513A53;
	Wed, 26 Feb 2025 09:46:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 15pyHfnivmedYAAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 26 Feb 2025 09:46:33 +0000
Message-ID: <a4e352e7-52bc-41bb-bdac-bd5865de918e@suse.de>
Date: Wed, 26 Feb 2025 10:46:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-tcp: fix possible UAF in nvme_tcp_poll
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20250220111830.3185561-1-sagi@grimberg.me>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250220111830.3185561-1-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250226_014636_893663_1D984315 
X-CRM114-Status: GOOD (  20.98  )
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

On 2/20/25 12:18, Sagi Grimberg wrote:
> nvme_tcp_poll() may race with the send path error handler because
> it may complete the request while it is actively being polled for
> completion, resulting in a UAF panic [1]:
> 
> We should make sure to stop polling when we see an error when
> trying to read from the socket. Hence make sure to propagate the
> error so that the block layer breaks the polling cycle.
> 
> [1]:
> --
> [35665.692310] nvme nvme2: failed to send request -13
> [35665.702265] nvme nvme2: unsupported pdu type (3)
> [35665.702272] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [35665.702542] nvme nvme2: queue 1 receive failed:  -22
> [35665.703209] #PF: supervisor write access in kernel mode
> [35665.703213] #PF: error_code(0x0002) - not-present page
> [35665.703214] PGD 8000003801cce067 P4D 8000003801cce067 PUD 37e6f79067 PMD 0
> [35665.703220] Oops: 0002 [#1] SMP PTI
> [35665.703658] nvme nvme2: starting error recovery
> [35665.705809] Hardware name: Inspur aaabbb/YZMB-00882-104, BIOS 4.1.26 09/22/2022
> [35665.705812] Workqueue: kblockd blk_mq_requeue_work
> [35665.709172] RIP: 0010:_raw_spin_lock+0xc/0x30
> [35665.715788] Call Trace:
> [35665.716201]  <TASK>
> [35665.716613]  ? show_trace_log_lvl+0x1c1/0x2d9
> [35665.717049]  ? show_trace_log_lvl+0x1c1/0x2d9
> [35665.717457]  ? blk_mq_request_bypass_insert+0x2c/0xb0
> [35665.717950]  ? __die_body.cold+0x8/0xd
> [35665.718361]  ? page_fault_oops+0xac/0x140
> [35665.718749]  ? blk_mq_start_request+0x30/0xf0
> [35665.719144]  ? nvme_tcp_queue_rq+0xc7/0x170 [nvme_tcp]
> [35665.719547]  ? exc_page_fault+0x62/0x130
> [35665.719938]  ? asm_exc_page_fault+0x22/0x30
> [35665.720333]  ? _raw_spin_lock+0xc/0x30
> [35665.720723]  blk_mq_request_bypass_insert+0x2c/0xb0
> [35665.721101]  blk_mq_requeue_work+0xa5/0x180
> [35665.721451]  process_one_work+0x1e8/0x390
> [35665.721809]  worker_thread+0x53/0x3d0
> [35665.722159]  ? process_one_work+0x390/0x390
> [35665.722501]  kthread+0x124/0x150
> [35665.722849]  ? set_kthread_struct+0x50/0x50
> [35665.723182]  ret_from_fork+0x1f/0x30
> 
> Reported-by: Zhang Guanghui <zhang.guanghui@cestc.cn>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/tcp.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index c637ff04a052..0e390e98aaf9 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -2673,6 +2673,7 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>   {
>   	struct nvme_tcp_queue *queue = hctx->driver_data;
>   	struct sock *sk = queue->sock->sk;
> +	int ret;
>   
>   	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
>   		return 0;
> @@ -2680,9 +2681,9 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>   	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
>   	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
>   		sk_busy_loop(sk, true);
> -	nvme_tcp_try_recv(queue);
> +	ret = nvme_tcp_try_recv(queue);
>   	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
> -	return queue->nr_cqe;
> +	return ret < 0 ? ret : queue->nr_cqe;
>   }
>   
>   static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

