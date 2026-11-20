Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5835E606A325
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 08:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=SnVFByBU;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFnN4RJ0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=F0PQk0mjIdh5yOwN+HU0VDSXiYE3ewlqa7cQwwSm7R0=; b=SnVFByBUtd7as/0IFOYeW55MSf
	n8ElQOxKgqrmcyNW4CECMuwtbOZFK88Mtv9z/v2/6duubt9wVLg97QBUN23ROl6GP0drKaWpoihPd
	kb52MWYfzAUNXAkt9Hfn9ybZzhdSj+HIkGETJwj2LT6ro5n+2VbR9/gy+bz6FgkdrSFV+a66bEQc3
	Pj6wdgoHTjinmpqsflFknxly6nXfyGQ2/av85EJqp6iRFoWTN8icBCcBHKoIRn9HShTrQg28neIP1
	bDSAgx6Hbd+KSau/hUpotzU03xwnJn370gc2tqKHQtWsrwEGe1KNhMwpwGz82sPL6q3shr+KkBY4e
	muEdTtRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUJpq-0000000EJc4-1tGO;
	Fri, 20 Nov 2026 08:19:06 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUJpe-0000000EJaF-1ilU
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 08:19:02 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id E544340A6E;
	Fri, 20 Nov 2026 08:18:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBD21F000C6;
	Fri, 20 Nov 2026 08:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795162733;
	bh=F0PQk0mjIdh5yOwN+HU0VDSXiYE3ewlqa7cQwwSm7R0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KFnN4RJ0YiIs7a1631fzG+e4orXgUIyoawv+bi3IdU6crxH2Sb7UmFk9rRCPKeaQ/
	 Z6HF2W3F55lUc7YpILO7WLarpZ5oEXdvrZlsxoKmiiFbC9BA+JPaTMvkHPsbCMroIx
	 meNoxquWYFd/YwLWRUql8U20Em2zwwTL919PUYhcWhLN8PrOaoacLkCc1RjdiKIKfg
	 8/zzL2x8O8QEMWCKUgt6sFlGWUmDqdXZAlTo5OR5w+fzECdreQK+vF5r5SaVcxzCej
	 3IqNdIBBSV3UvoqqqSSEnv91ksGg/AI/YKBCQ+HzBo+zcSbiWKXXwiDvmj8+dMOiIB
	 IQu7NvEF+kUCw==
Message-ID: <sashiko-outbox-224708@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvmet: don't abort the preempting host itself
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261120080642.1179691-1-kanie@linux.alibaba.com>
References: <20261120080642.1179691-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 08:18:53 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] nvmet: nvmet_pr_unreg_all_host_by_prkey() skips abort on
  false pc_ref premise
--

commit 07f50eedfd5f5e5d148cd9fefe65d629fc37077e
Author: Guixin Liu <kanie@linux.alibaba.com>

nvmet: don't abort the preempting host itself

This commit skips calling nvmet_pr_set_ctrl_to_abort() for the issuing
host in nvmet_pr_unreg_all_host_by_prkey() when handling a Reservation
Acquire command with the Preempt and Abort action.

> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
> index 8c818f24815bd..ed530d7362f5b 100644
> --- a/drivers/nvme/target/pr.c
> +++ b/drivers/nvme/target/pr.c
> @@ -502,7 +502,14 @@ static u16 nvmet_pr_unreg_all_host_by_prkey(struct n=
vmet_req *req, u64 prkey,
>  		if (reg->rkey =3D=3D prkey) {
>  			status =3D NVME_SC_SUCCESS;
>  			uuid_copy(&hostid, &reg->hostid);
> -			if (abort)
> +			/*
> +			 * Aborting is best effort (NVMe Base Specification
> +			 * section 8.1.25.7): skip the issuing host, as the
> +			 * abort flow would otherwise wait for the preempt
> +			 * command itself, which holds a reference on its
> +			 * controller's per-controller ref until it completes.
> +			 */
> +			if (abort && !uuid_equal(&hostid, send_hostid))
>  				nvmet_pr_set_ctrl_to_abort(req, &hostid);
>  			nvmet_pr_unregister_one(pr, reg);
>  			if (!uuid_equal(&hostid, send_hostid))

[Severity: Medium]
Does a Reservation Acquire command actually hold a reference on pc_ref?

In nvmet_parse_io_cmd(), nvmet_parse_pr_cmd() returns 0 for reservation
opcodes and returns early before reaching nvmet_pr_get_ns_pc_ref():

drivers/nvme/target/core.c:nvmet_parse_io_cmd() {
	...
	if (req->ns->pr.enable) {
		ret =3D nvmet_parse_pr_cmd(req);
		if (!ret)
			return ret;
	}
	...
	if (req->ns->pr.enable) {
		ret =3D nvmet_pr_check_cmd_access(req);
		if (ret)
			return ret;

		ret =3D nvmet_pr_get_ns_pc_ref(req);
	}
	...
}

Because that is the only caller of nvmet_pr_get_ns_pc_ref(), the preempt
command itself never holds a reference on pc_ref->ref and cannot cause the
self-deadlock described here.  Skipping nvmet_pr_set_ctrl_to_abort() for
send_hostid instead stops nvmet from waiting for in-flight I/O commands on
the newly unregistered issuing host's controllers to drain before
completing the Preempt and Abort command.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120080642.1179=
691-1-kanie@linux.alibaba.com?part=3D1

