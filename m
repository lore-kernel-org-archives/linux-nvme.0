Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBFD606A7A0
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 15:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wQ930af3;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mM5CQiin
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=yIjeYITpgyANmVhrRidZVUXLeg1AGNEvbPkCjzQpHtM=; b=wQ930af3LxutYkerxEOc3c4jtJ
	lcWnqk0zuuh0La10xNmz1wT8b5URrgv953PSzT0KQ4p5g8/wGYYBboRDrh4btfOZid24fFwVPjFsp
	TxM79UqRQZ4ru0Y3vYjuxYqbPqsmCZ8pEjFVpbrI4/5icO/4ojhh4GYoLsD03CR1gGnR5ClYIVVED
	9Hfw25/DJBdlyQczHINKIVmpLXYO50XANqzQEiafyA1dZ7jPpynzDrkHEiXuiAhlksqRShGRaDWZ2
	8PUkYQCIcnfp5c7V0hpWfOMfvXUExodprIcld7dk22fnC2iI8KDWySMCKVeQaWoxFheBOnisbW0Tm
	elUN81Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGLI-00000002wt8-0TQ7;
	Tue, 03 Nov 2026 15:22:32 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOGLH-00000002wsd-1Q6Y
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 15:22:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id AA1A46021D;
	Tue,  3 Nov 2026 15:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3681D1F000C1;
	Tue,  3 Nov 2026 15:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793719350;
	bh=yIjeYITpgyANmVhrRidZVUXLeg1AGNEvbPkCjzQpHtM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mM5CQiinSp+qJckT9idxp7VZ2VKoB/K/jgH0akfUTvQB8odSMAcohdN9yLTAwGbvV
	 0uhS8WLHbFndp/UwKMAfOJLdi9D4nsB2XdYNTR3Ztw0APIurGiMnoUlfL+LKYhlHOo
	 /57oUzo34USr6CK3Y5q1dkKC73RddtvoBcFPMMfrNV4soFF7IQ0tHbppwOosNrK/aj
	 HenmHLtDKjjsbel4vo/DlMe40dgBs3bF+0FL0JM4+s+UFavZ3ifpSL4DzBS2WERzIT
	 IvM274hNe/ZLnrUOwZ7X9E2dea8xDI+bcbk8TMEot400Y/NWMhACE4mOmHoExMUiLq
	 P9DYXph5XDLMg==
Message-ID: <sashiko-outbox-195610@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] blk-mq: use a housekeeping CPU for passthrough
 requests on isolated hctxs
To: "Daniel Wagner" <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
References: <20261103-nvme-fabrics-isolcpu-v2-1-95ec70d58254@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:22:29 +0000
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] blk-mq: blk_mq_alloc_request_hctx() allocates on offline hctxs w=
hen BLK_MQ_S_INACTIVE is unset
--

commit f6824e249591ee431516fa47caa778074d8f4d22
Author: Daniel Wagner <dwagner@suse.de>

blk-mq: use a housekeeping CPU for passthrough requests on isolated hctxs

When hctx->cpumask contains no online CPUs because all CPUs mapped to the
hardware context are isolated, this commit allows passthrough requests in
blk_mq_alloc_request_hctx() to fall back to the software context of an
online housekeeping CPU unless BLK_MQ_S_INACTIVE is set on the hctx.

> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 5fca78778c31c..77685e6283fa1 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c

[ ... ]

> @@ -767,8 +786,22 @@ struct request *blk_mq_alloc_request_hctx(struct req=
uest_queue *q,
>  	if (!blk_mq_hw_queue_mapped(data.hctx))
>  		goto out_queue_exit;
>  	cpu =3D cpumask_first_and(data.hctx->cpumask, cpu_online_mask);
> -	if (cpu >=3D nr_cpu_ids)
> -		goto out_queue_exit;
> +	if (cpu >=3D nr_cpu_ids) {
> +		/*
> +		 * Isolated CPUs are not part of hctx->cpumask, so it can be
> +		 * empty although online CPUs are mapped to this hardware
> +		 * context. Passthrough requests are inserted directly into
> +		 * hctx->dispatch, so use the software context of a
> +		 * housekeeping CPU for them. Inactive hardware contexts have
> +		 * no online CPU left.
> +		 */
> +		if (!blk_op_is_passthrough(opf) ||
> +		    test_bit(BLK_MQ_S_INACTIVE, &data.hctx->state))
> +			goto out_queue_exit;
> +		cpu =3D blk_mq_housekeeping_cpu();
> +		if (cpu >=3D nr_cpu_ids)
> +			goto out_queue_exit;
> +	}

[Severity: Medium]
Can this allocate a passthrough request on a hardware context that has no
online CPUs mapped to it instead of returning ERR_PTR(-EXDEV)?

BLK_MQ_S_INACTIVE is only set in the CPU hotplug callback
blk_mq_hctx_notify_offline() when the last online CPU mapped to an hctx
transitions to offline:

block/blk-mq.c:blk_mq_hctx_notify_offline() {
	...
	if (!hctx->nr_ctx || blk_mq_hctx_has_online_cpu(hctx, cpu))
		return 0;

	set_bit(BLK_MQ_S_INACTIVE, &hctx->state);
	...
}

However, during queue initialization in blk_mq_init_allocated_queue() and
queue reconfiguration in blk_mq_update_nr_hw_queues(), blk_mq_init_hctx()
unconditionally clears BLK_MQ_S_INACTIVE, __blk_mq_add_cpuhp() registers the
hotplug state via cpuhp_state_add_instance_nocalls() (and skips registration
for BLK_MQ_F_STACKING), and blk_mq_map_swqueue() maps all present and
possible CPUs to hardware contexts without setting BLK_MQ_S_INACTIVE on
hctxs whose mapped CPUs are all currently offline.

If a queue is initialized or remapped while all CPUs assigned to data.hctx
are already offline, blk_mq_hw_queue_mapped(data.hctx) is true and
BLK_MQ_S_INACTIVE remains clear. When blk_mq_alloc_request_hctx() is called
for that hctx_idx with a passthrough operation, test_bit(BLK_MQ_S_INACTIVE,
&data.hctx->state) evaluates to false and the request is allocated using
blk_mq_housekeeping_cpu() on an offline hardware queue instead of failing
with -EXDEV.

Should this check !blk_mq_hctx_has_online_cpu(data.hctx, nr_cpu_ids) (or
ensure blk_mq_map_swqueue() sets BLK_MQ_S_INACTIVE when an hctx has no
online CPUs mapped)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-nvme-fabri=
cs-isolcpu-v2-1-95ec70d58254@suse.de?part=3D1

