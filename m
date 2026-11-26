Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2D606A321
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=m2+G7Qeb;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NXYlZ026;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wOfMPPlt;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NXYlZ026;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wOfMPPlt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gTk8L3Si7BxpNzOeT1YGgtK4G5i56Xng+fRZOmwX63E=; b=m2+G7Qebgk98OK
	PeZzQktwhowCxHxNOnTDgSvCaBjoOY1zbf5IsU0JCXV32vbtbabRAVYLNpPJ0I3t/0E0ABqcCzlTa
	urrCU/VzPxdsDDEi/xwsIw66CDnffF9SN6dNMdUuohph9XqxsIzbITeqb85mgH6c0O3wPFDObKHlx
	rH8U1Jko/iuvx1uqsY61T2IoXMj2tacZo7QkHcyx5Ho3ckRbxmGoaR+wsk0JpSXDob/ByZPrM0Y6K
	28aKj+2jgggkitwfDRAwRidwo4P7SCej4MxYNNrorza7mKNUM/JXpVkMCggHuRYGCuq4Ar93qlSQO
	klHPdv6uyTSJSyTb5yfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWW9f-0000000CcdV-3VAk;
	Thu, 26 Nov 2026 09:52:39 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWW9c-0000000Ccce-1ykW
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 09:52:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 642761F800;
	Thu, 26 Nov 2026 09:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795686754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTk8L3Si7BxpNzOeT1YGgtK4G5i56Xng+fRZOmwX63E=;
	b=NXYlZ0267oBrNntgn48Slt7y/gvMYzgmqWvSIYRkI8F7M8qFSvQpXuIn9kb4rbkIVfNQug
	eOrLvatLq80jj4kREH9kKgMsgClzjCstrTf1Ab8IGPL4j2oNUitRdqJyYQCXJJ9mFXLj/X
	XzErw2Y9qOAphuRmtgHXnMRMewAWguM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795686754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTk8L3Si7BxpNzOeT1YGgtK4G5i56Xng+fRZOmwX63E=;
	b=wOfMPPltQ5M5DVil2NHCA59Z2QxwOtO0bsxySk68daw1ggHkp7YXUC4s4mjZAGt66MohrM
	0JQX+9qv3q7W4PAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795686754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTk8L3Si7BxpNzOeT1YGgtK4G5i56Xng+fRZOmwX63E=;
	b=NXYlZ0267oBrNntgn48Slt7y/gvMYzgmqWvSIYRkI8F7M8qFSvQpXuIn9kb4rbkIVfNQug
	eOrLvatLq80jj4kREH9kKgMsgClzjCstrTf1Ab8IGPL4j2oNUitRdqJyYQCXJJ9mFXLj/X
	XzErw2Y9qOAphuRmtgHXnMRMewAWguM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795686754;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTk8L3Si7BxpNzOeT1YGgtK4G5i56Xng+fRZOmwX63E=;
	b=wOfMPPltQ5M5DVil2NHCA59Z2QxwOtO0bsxySk68daw1ggHkp7YXUC4s4mjZAGt66MohrM
	0JQX+9qv3q7W4PAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 30745134C3;
	Thu, 26 Nov 2026 09:52:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0GVLA2IBCGskfQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 26 Nov 2026 09:52:34 +0000
Message-ID: <a1ddba64-d9b5-476f-b658-99f3e65744c1@suse.de>
Date: Thu, 26 Nov 2026 10:52:33 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme: reject a controller type change on
 reinitialization
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me
Cc: kamaljit.singh@opensource.wdc.com, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20261124133122.4167640-1-yhlee@isslab.korea.ac.kr>
 <20261125145902.254297-1-yhlee@isslab.korea.ac.kr>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261125145902.254297-1-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.29 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.999];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.29
X-Spam-Level: 
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261126_015236_717999_040A16B1 
X-CRM114-Status: GOOD (  26.92  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/26 3:59 PM, Yehyeong Lee wrote:
> nvme_init_identify() caches id->cntrltype on every initialization, and the
> Identify Controller data is read again on every reconnect.  A fabrics
> controller that reported itself as an I/O controller on the first connect
> can therefore report itself as an administrative controller on a reconnect,
> after its namespaces are in use.
> 
> nvme_init_ctrl_finish() then overrides queue_count to 1, so the transport
> skips I/O queue setup and the queues that error recovery freed are never
> reallocated, leaving queue->sock NULL.  The controller is switched to LIVE
> anyway with the namespaces still present, and nvme_check_ready() lets any
> request through once the state is LIVE, so blk-mq dispatches to the freed
> queue:
> 
>    Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN NOPTI
>    KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
>    CPU: 0 UID: 0 PID: 81 Comm: kworker/0:1H Not tainted 7.4.0-rc4 #1 PREEMPT(lazy)
>    Workqueue: kblockd blk_mq_run_work_fn
>    RIP: 0010:selinux_socket_sendmsg+0x76/0x2f0
>    RSP: 0018:ffffc900008ef528 EFLAGS: 00010206
>    RAX: dffffc0000000000 RBX: ffffc900008ef730 RCX: ffffffff822ab089
>    RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffffc900008ef738
>    RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
>    R10: 0000000000000001 R11: ffffffff84c14740 R12: 0000000000000000
>    R13: 0000000000000018 R14: 0000000000000000 R15: 0000000000000000
>    FS:  0000000000000000(0000) GS:ffff8880e6931000(0000) knlGS:0000000000000000
>    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>    CR2: 00007f52b4001b78 CR3: 0000000009275003 CR4: 0000000000770ef0
>    PKRU: 55555554
>    Call Trace:
>     <TASK>
>     security_socket_sendmsg+0x6f/0x90
>     sock_sendmsg+0x117/0x390
>     nvme_tcp_try_send_cmd_pdu+0x4b7/0x9d0
>     nvme_tcp_try_send+0x20e/0xbf0
>     nvme_tcp_queue_rq+0x1148/0x1510
>     blk_mq_dispatch_rq_list+0x3e3/0x1e30
>     __blk_mq_sched_dispatch_requests+0x218/0x15c0
>     blk_mq_sched_dispatch_requests+0xd7/0x1b0
>     blk_mq_run_work_fn+0xe4/0x190
>     process_one_work+0x747/0x11c0
>     worker_thread+0x57c/0xcb0
>     kthread+0x327/0x430
>     ret_from_fork+0x394/0x770
>     ret_from_fork_asm+0x1a/0x30
> 
> Reject any controller type change on a controller that has already been
> initialized.
> 
> Fixes: e715b8733df60a ("nvme: add capability to connect to an administrative controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
> ---
> v1: https://lore.kernel.org/linux-nvme/20261124133122.4167640-1-yhlee@isslab.korea.ac.kr/
> 
> Changes in v2, after review feedback:
> - Generalize the check and move it.  v1 rejected the change from inside
>    the administrative-controller override in nvme_init_ctrl_finish(), and
>    only for the I/O-to-administrative direction.  v2 checks in
>    nvme_init_identify(), immediately before ctrl->cntrltype is overwritten,
>    and rejects any controller type change on an already initialized
>    controller.  That also covers administrative-to-I/O and changes to or
>    from a discovery controller, both of which v1 let through.
> - Cut the commit message down to the basics: drop the walkthrough of the
>    resulting state, the CVE references and the note about the other fabrics
>    transports.
> - The subject changed with the generalization ("an administrative
>    controller type" -> "a controller type change"); say so and it goes back
>    to the v1 wording.
> 
>   drivers/nvme/host/core.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index f43582e5f6c4a9..ffe6a63d24e1dc 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3736,6 +3736,18 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
>   	ctrl->max_namespaces = le32_to_cpu(id->mnan);
>   	ctrl->ctratt = le32_to_cpu(id->ctratt);
>   
> +	/*
> +	 * The controller type fixes whether the controller has I/O queues,
> +	 * so it must not change while the controller is in use.
> +	 */
> +	if (ctrl->identified && ctrl->cntrltype != id->cntrltype) {
> +		dev_err(ctrl->device,
> +			"controller type changed from %u to %u on reinitialization\n",
> +			ctrl->cntrltype, id->cntrltype);
> +		ret = -EINVAL;
> +		goto out_free;
> +	}
> +
>   	ctrl->cntrltype = id->cntrltype;
>   	ctrl->dctype = id->dctype;
>   
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

