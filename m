Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 522AFC982D8
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 15:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x1HMooKxWdTR8MMA0vDkkoexxC1R5v4vfZJE6qbf1b8=; b=QI1iySfequri+sap9em3yGznWC
	DsNyArzb61zqXyb2hN2tb+gyvh824ZPt0MbmZ7/l5G8lM2geBHAKuDe/j3yeCSAWkyg4Z0au4t20r
	OZZVvLivrMZHlNvjMf+3UPf/toB0Eo6/zuJ3AxPCk3JzIURkKTQrtD3v9ff40kEwKzMUaSto59Ac7
	KqcaLcO0vySz/0AlqxQZk8lyvWHI8NP7VhEC2TxWhJecLsqev12xhEJnPctwNCuRgahhEQ2QtC3sy
	KaM4NMv/QES4JAlQUNxHz917xHa9COAhFLoxjC4SuAZ7SLMi7n/2XH58d0t++7W2qi1y4VxRUJ5uQ
	gVFu+VBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7aLG-0000000EquR-3sUd;
	Fri, 18 Sep 2026 15:17:34 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7aLE-0000000Eqsr-0sSD
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 15:17:33 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 652AA1F385;
	Fri, 18 Sep 2026 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789744644; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1HMooKxWdTR8MMA0vDkkoexxC1R5v4vfZJE6qbf1b8=;
	b=d+hEd4zlYJ8RMbrQQEhZpPHsdMl0V8lURdCHlaY/kR+QqzkjxniTKNS1IuaPq5hBpjxL3w
	fOwDwhtzV6QvwDpPkO9TA2ga6+h35B1+z0INsePxlECjXP0+6GFn++va2E6ZbpLOO4LvMp
	ci79Fbr9Ykb9/+qZ+ooXpyC8/VOKihk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789744644;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1HMooKxWdTR8MMA0vDkkoexxC1R5v4vfZJE6qbf1b8=;
	b=02qltcYzB0GCI4UiAO8ogU2o3WewHqd+IYqfLD3PmEYAQFc1szNUIItATZKaGUxP/5cDv2
	W8URTbuC3CCjpSDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789744640; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1HMooKxWdTR8MMA0vDkkoexxC1R5v4vfZJE6qbf1b8=;
	b=bPYuEaDrb1LoHyzzzAu3HxvTQsoxyQ29E7q5Ywa13Ev2LCMLHp/2rwcYc0MzF/MFGhHhLN
	ytLIzXhNarA4Yxvp+1MEl46H2G1jDttB0ic1biGu2eWiokpUljo+I2+mj59oVa0mby8mNp
	3sQwDdyMi4O+F+3aKGX88a8kc33GjAk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789744640;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x1HMooKxWdTR8MMA0vDkkoexxC1R5v4vfZJE6qbf1b8=;
	b=wWDNGVIB1foDfgEMxeoWCGq96/Rh8kLe+/p5JzqKxWWw2NnUknoU8JpmYtBKhKYpauIDt6
	UH8ypdyLdrZDszAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D9BAF13991;
	Fri, 18 Sep 2026 15:17:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oqnCIP9VrWqdMQAAD6G6ig
	(envelope-from <hare@suse.de>); Fri, 18 Sep 2026 15:17:19 +0000
Message-ID: <46322855-6496-482c-a63b-d0e7bd055f1b@suse.de>
Date: Fri, 18 Sep 2026 17:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvmet-auth: fix out-of-bounds write in
 nvmet_auth_challenge()
To: Weiming Shi <bestswngs@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, co+77553a7fc66ac133@bugs.sh,
 Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
References: <20260912171009.1513289-3-bestswngs@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260912171009.1513289-3-bestswngs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_TO(0.00)[gmail.com,lst.de,grimberg.me,nvidia.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[77553a7fc66ac133];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bugs.sh:email,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_081732_546913_8291B7FC 
X-CRM114-Status: GOOD (  19.16  )
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

On 9/12/26 7:10 PM, Weiming Shi wrote:
> nvmet_auth_challenge() receives its output buffer as a void pointer.
> sizeof(*d) therefore evaluates to one with GCC and undercounts the fixed
> challenge header by 15 bytes.  A short AUTH_RECEIVE buffer can pass the
> check before the challenge is copied past the end of its allocation.
> 
> Use the typed challenge pointer when calculating the response size.
> 
>    BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_receive (drivers/nvme/target/fabrics-cmd-auth.c:442 drivers/nvme/target/fabrics-cmd-auth.c:569)
>    Write of size 32 by task kworker/1:1H/64
>    Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
>    Call Trace:
>    nvmet_execute_auth_receive (drivers/nvme/target/fabrics-cmd-auth.c:442 drivers/nvme/target/fabrics-cmd-auth.c:569)
>    nvmet_tcp_try_recv_pdu (drivers/nvme/target/tcp.c:1119 drivers/nvme/target/tcp.c:1243)
>    nvmet_tcp_io_work (drivers/nvme/target/tcp.c:1350 drivers/nvme/target/tcp.c:1382 drivers/nvme/target/tcp.c:1445)
>    process_one_work (kernel/workqueue.c:3322)
>    worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3486)
>    kthread (kernel/kthread.c:436)
>    ret_from_fork (arch/x86/kernel/process.c:158)
>    ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>    The buggy address is located 16 bytes inside of
>     allocated 33-byte region [ffff888000554e80, ffff888000554ea1)
>    Kernel panic - not syncing: KASAN: panic_on_warn set ...
> 
> Cc: stable@vger.kernel.org
> Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
> Reported-by: co+77553a7fc66ac133@bugs.sh
> Closes: https://lore.kernel.org/all/Ah6QavQXwvshtqyUcYD1P1R7XE0ND9fB7lbV@bugs.sh/
> Assisted-by: Codex:gpt-5.6
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>   drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> index 92f8a76f10..dccdb55a36 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -427,7 +427,7 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
>   	struct nvmet_ctrl *ctrl = req->sq->ctrl;
>   	int ret = 0;
>   	int hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
> -	int data_size = sizeof(*d) + hash_len;
> +	int data_size = sizeof(*data) + hash_len;
>   
>   	if (ctrl->dh_tfm)
>   		data_size += ctrl->dh_keysize;

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

