Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCE0606A31A
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cdgsNS2e;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WVRWC7l2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lYrh5yarw1iQl2TouYbgef09nP54PLDBwc21B6WSxBY=; b=cdgsNS2ex/AswHPS43tAoOczvm
	jmncTP/rxDJTtl6owtjHFAXOFB9+tMI3jNrYkcUnfNXwv51JVgceQFqW+xZB46IgYBRFQjvby2HMF
	zMWBrRdPH4svSTdccqLJD+0PSGfFJV4RitgrSjfx+bExGu05zJ6+qZO3ANdWWTFTSH/GqyhSXp3e/
	keP9pPVBh1/xSqI87FAa6ddFQefm04qSNm8H8CoLiA36iVNHXek92pqTPCBQIQyZoU/+R+jdCHBYK
	UFpC9Jz2uzm2XOYK5t1ON0qdSYaHudy3Cjw1V2/mSg2jP85CQCHQa0O5teIhf8hySUWpURwYsA6PL
	lOShZXDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLxco-00000006RQ9-1E6K;
	Wed, 28 Oct 2026 06:59:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLxcn-00000006RPw-0dsn
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 06:59:05 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 4510160120;
	Wed, 28 Oct 2026 06:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78241F01825;
	Wed, 28 Oct 2026 06:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793170744;
	bh=lYrh5yarw1iQl2TouYbgef09nP54PLDBwc21B6WSxBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WVRWC7l2uzmtDol7nWDIy6qlE2UkXCmTBM2+ictenWXJRotKOVO0gp/mn0in5/vm6
	 QnAZUwyCxNI/pWCWw8NLAM9mhGwvNs06Tuwuj9lDmBhMqiCiSfEQcASYeWtS4O43cO
	 rNcl4bCqAawGDyQ4bMH88l73Dl+uSUUjlonDCCDhsFMX126G8lrJrBa9stFwYvxN8H
	 0IhrT+5xDwmHdKWpyoYC7XiXHeLFCx79LOTQWwAdLlkt8e9yLUBIq2ZemjZlUsJ0Ee
	 6HSQC1gDLzdcFS/XYCvPOQihcohrzmQSC++ioeDCDVjRZgBb0JDsRreB8Vxd027qJ5
	 +n2ncxWOHbEbA==
Message-ID: <sashiko-outbox-187572@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvmet: Free the old negotiation state when restarting
 authentication
To: "Guixin Liu" <kanie@linux.alibaba.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261028064345.544504-1-kanie@linux.alibaba.com>
References: <20261028064345.544504-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 06:59:03 +0000
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
- [Critical] nvmet-auth: NULL deref on restart due to stale dhchap_skey_len
--

commit b95a68b07cb2fd80ef9528e69f5467fefe0e42a1
Author: Guixin Liu <kanie@linux.alibaba.com>

nvmet: Free the old negotiation state when restarting authentication

This commit calls nvmet_auth_sq_free() when restarting DH-HMAC-CHAP
negotiation in nvmet_execute_auth_send() so that previously allocated
c1, c2, and skey buffers on the submission queue are freed before a new
round begins.

> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target=
/fabrics-cmd-auth.c
> index 1fe21f2672f10..e68b1c6f2ce5a 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -330,6 +330,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>  			/* Restart negotiation */
>  			pr_debug("%s: ctrl %d qid %d reset negotiation\n",
>  				 __func__, ctrl->cntlid, req->sq->qid);
> +			nvmet_auth_sq_free(req->sq);

[Severity: Critical]
Can this trigger a NULL pointer dereference in nvmet_auth_host_hash() if
the host restarts negotiation after generating a DH session key and then
sends a reply with dhvlen =3D=3D 0?

In the first round, when a DH group is configured (ctrl->dh_gid !=3D
NVME_AUTH_DHGROUP_NULL) and the host sends a reply with a non-zero dhvlen,
nvmet_auth_reply() -> nvmet_auth_ctrl_sesskey() allocates
req->sq->dhchap_skey and sets req->sq->dhchap_skey_len to the hash length.
If that reply fails authentication with NVME_AUTH_DHCHAP_MESSAGE_FAILURE1,
the host can send a new negotiate message to restart authentication.

Calling nvmet_auth_sq_free() here frees sq->dhchap_skey and sets it to
NULL, but leaves sq->dhchap_skey_len non-zero:

drivers/nvme/target/auth.c:nvmet_auth_sq_free() {
	...
	kfree(sq->dhchap_skey);
	sq->dhchap_skey =3D NULL;
}

If the host then completes the negotiate and challenge steps and sends a
reply with dhvlen =3D=3D 0 in the second round, nvmet_auth_reply() skips
nvmet_auth_ctrl_sesskey():

drivers/nvme/target/fabrics-cmd-auth.c:nvmet_auth_reply() {
	...
	if (dhvlen) {
		if (!ctrl->dh_tfm)
			return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
		if (nvmet_auth_ctrl_sesskey(req, data->rval + 2 * data->hl,
					    dhvlen) < 0)
			return NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE;
	}
	...
	if (nvmet_auth_host_hash(req, response, data->hl) < 0) {
}

nvmet_auth_host_hash() then passes the NULL req->sq->dhchap_skey along with
the stale non-zero req->sq->dhchap_skey_len to
nvme_auth_augmented_challenge():

drivers/nvme/target/auth.c:nvmet_auth_host_hash() {
	...
	if (ctrl->dh_gid !=3D NVME_AUTH_DHGROUP_NULL) {
		challenge =3D kmalloc(shash_len, GFP_KERNEL);
		if (!challenge) {
			ret =3D -ENOMEM;
			goto out_free_response;
		}
		ret =3D nvme_auth_augmented_challenge(ctrl->shash_id,
						    req->sq->dhchap_skey,
						    req->sq->dhchap_skey_len,
						    req->sq->dhchap_c1,
						    challenge, shash_len);
}

Because skey_len is non-zero while skey is NULL,
nvme_auth_augmented_challenge() -> nvme_auth_hmac() ->
nvme_auth_hmac_init() dereferences NULL when preparing the HMAC key.

Should nvmet_auth_sq_free() also reset sq->dhchap_skey_len =3D 0 (or should
nvmet_auth_reply() require dhvlen !=3D 0 when ctrl->dh_gid !=3D
NVME_AUTH_DHGROUP_NULL)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028064345.5445=
04-1-kanie@linux.alibaba.com?part=3D1

