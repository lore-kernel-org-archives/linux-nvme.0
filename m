Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B553606A328
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2026 02:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Blw199me;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e/02gwcS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=neQuyEFDUzEiL3Qtoho4Bej/ljsH+x2nP6dqyGFMBek=; b=Blw199meJhdoYZol5JTVSa1gYV
	xg0f3LG3DV/jNKRzo53xBeF4oVivRflQ60PSXEig2oBmyFk2kexly889moapv9IxWWQy5xy1kwGus
	j20wNe7RAH8+gagcbXV23A+wzf2NoECokmI655RkLndQlnVLrJEXe5en/QAKflbGbVLHzqKiv4SSY
	KzmPrABeknXxptWjqNMXYgY1rRP6xgS8vG2iWQ1RauGr51V297nyPX3PwJfzsPGPMMO750soGc+x4
	v9YXNFO8Ki6I1YN0s3rg4Ks/u/bxZaSuoc42F0fI9LgBEYyqBVts+47zd99RcBqnT+w5ICvYBnLgq
	YGSDkBTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9LT-0000000B2BG-10vX;
	Fri, 06 Nov 2026 02:06:23 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP9LS-0000000B2B9-1N3j
	for linux-nvme@lists.infradead.org;
	Fri, 06 Nov 2026 02:06:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 75A67605D7;
	Fri,  6 Nov 2026 02:06:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FFB1F0089F;
	Fri,  6 Nov 2026 02:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793930781;
	bh=neQuyEFDUzEiL3Qtoho4Bej/ljsH+x2nP6dqyGFMBek=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e/02gwcSc61730j2aXomdNx+uPw/Ef/qzEVUv98i4lvBvNuuDRqm9V2/jem/NZXLF
	 0oR3ikDqqTCm9n805uEsB7QwzJf5u91KsJ0F0uhFizCAVJyL51xOk65eEO8qZAOX9v
	 1sQT9kQt2zh7EcEEGwLIezWQCyPulwOZFjAWLckTAtJujT7lJgBFIcPorqPBLNCZGJ
	 NEEVe9lVupt8KvolWza61N3P3vwsvTu9mvhCw1R8B7ijz1LUHAY+ITv23RxFHvLPf7
	 xJLANkYqclIsAJy00svOm8XPCGzhnWzB4RNpvKxwu2VuEwU2TtXQzI7bolFyDFNdTv
	 rBvKvR6qIAMUA==
Message-ID: <sashiko-outbox-200574@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] nvme-fc: fix iterator over rport->ctrl_list in
 nvme_fc_match_disconn_ls()
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261106015842.3534898-3-kanie@linux.alibaba.com>
References: <20261106015842.3534898-1-kanie@linux.alibaba.com>
 <20261106015842.3534898-3-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 02:06:20 +0000
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
- [Critical] nvme-fc: use-after-free in nvme_fc_match_disconn_ls() after nv=
me_fc_ctrl_put()
--

commit 8782ae8cb9a0539907c2a9d660e71e6ada06052f
Author: Guixin Liu <kanie@linux.alibaba.com>

nvme-fc: fix iterator over rport->ctrl_list in nvme_fc_match_disconn_ls()

This commit switches the rport->ctrl_list traversal in
nvme_fc_match_disconn_ls() from list_for_each_entry_safe() to
list_for_each_entry() to avoid caching a next entry that could be freed whi=
le
rport->lock is dropped.

> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 0b9ff50d26ff3..edf192055618c 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -1470,14 +1470,14 @@ nvme_fc_match_disconn_ls(struct nvme_fc_rport *rp=
ort,
>  {
>  	struct fcnvme_ls_disconnect_assoc_rqst *rqst =3D
>  					&lsop->rqstbuf->rq_dis_assoc;
> -	struct nvme_fc_ctrl *ctrl, *tmp, *ret =3D NULL;
> +	struct nvme_fc_ctrl *ctrl, *ret =3D NULL;
>  	struct nvmefc_ls_rcv_op *oldls =3D NULL;
>  	u64 association_id =3D be64_to_cpu(rqst->associd.association_id);
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&rport->lock, flags);
> =20
> -	list_for_each_entry_safe(ctrl, tmp, &rport->ctrl_list, ctrl_list) {
> +	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
>  		if (!nvme_fc_ctrl_get(ctrl))
>  			continue;
>  		spin_lock(&ctrl->lock);

[Severity: Critical]
Does switching to list_for_each_entry() in nvme_fc_match_disconn_ls() in
drivers/nvme/host/fc.c still leave a use-after-free on ctrl itself when
nvme_fc_handle_ls_rqst_work() -> nvme_fc_ls_disconnect_assoc() ->
nvme_fc_match_disconn_ls() iterates past a non-matching controller that is
concurrently being torn down?

At the end of each non-matching iteration in nvme_fc_match_disconn_ls(), the
loop drops rport->lock and releases the reference on ctrl before the loop s=
tep
runs:

	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
		if (!nvme_fc_ctrl_get(ctrl))
			continue;
		...
		if (ret)
			/* leave the ctrl get reference */
			break;
		spin_unlock_irqrestore(&rport->lock, flags);
		nvme_fc_ctrl_put(ctrl);
		spin_lock_irqsave(&rport->lock, flags);
	}

Because list_for_each_entry() evaluates ctrl =3D list_next_entry(ctrl,
ctrl_list) after nvme_fc_ctrl_put(ctrl) and after rport->lock was dropped a=
nd
re-acquired, ctrl is no longer pinned when ctrl->ctrl_list.next is read. If
nvme_fc_ctrl_put(ctrl) (or a concurrent nvme_fc_free_ctrl() while rport->lo=
ck
is dropped) drops ctrl->ref to zero, nvme_fc_ctrl_free() unlinks and frees
ctrl:

	spin_lock_irqsave(&ctrl->rport->lock, flags);
	owns_opts =3D !list_empty(&ctrl->ctrl_list);
	list_del(&ctrl->ctrl_list);
	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
	...
	kfree(ctrl);

When the loop step then reads ctrl->ctrl_list.next, it reads from the freed
ctrl struct and follows LIST_POISON1 into the next iteration (or loops
forever if a concurrent nvme_fc_init_ctrl() error path ran
list_del_init(&ctrl->ctrl_list)).

Since rport->lock already serializes against list_del() in
nvme_fc_ctrl_free() and list_del_init() in nvme_fc_init_ctrl(), could
nvme_fc_match_disconn_ls() avoid dropping rport->lock in the loop altogether
by checking association_id =3D=3D ctrl->association_id first and only calli=
ng
nvme_fc_ctrl_get(ctrl) when a matching controller is found?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106015842.3534=
898-1-kanie@linux.alibaba.com?part=3D2

