Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080F1606A31A
	for <linux-nvme@archiver.kernel.org>; Sat, 31 Oct 2026 08:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Surmyly6;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KAPuX/H3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=IPASYZegG5f1ilJifopcNfxEf0ILUWbu79OvMK7U49M=; b=Surmyly6wOT8EirokKi9mMgjLQ
	VgXtKJPe4qQihjOVLi2ne3FRHvlC3+sNuH0bfADL2bcTDGtuQf62XTB3YRXP+2s7727lC2TdGZ9Qz
	eJ5PoJxo3PiHbJuZYVOqaP7DpE/61rJBA+bxoaiJAmpVMjWTCertVtC0CI5Aa7glXM2XksMFuGoT/
	z2pRI4rRndd6L+YJWCR1/iwwKEifMp4VT5KhFYOwSZSimFeg/0M4Ko0PTkUsNapcVXlscIZIvu3nw
	PnA+nmIeHjtv5zcdD3Py9xzR4EJ3iHHCeEogdTKCofvDsGJwqhqxQSKCSV30s7XANEs+VtbvcY0Mw
	+4M5Z8CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN49R-0000000D2hk-0QMH;
	Sat, 31 Oct 2026 08:09:21 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xN49P-0000000D2hd-1uRr
	for linux-nvme@lists.infradead.org;
	Sat, 31 Oct 2026 08:09:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 5B5AC600C8;
	Sat, 31 Oct 2026 08:09:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27EA1F000C1;
	Sat, 31 Oct 2026 08:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793434157;
	bh=IPASYZegG5f1ilJifopcNfxEf0ILUWbu79OvMK7U49M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KAPuX/H3Idx1anYRkD5IYUp/weK89ZkHVR8GGlhCPASIWAONgloxUSgFoAZr4gLjw
	 0RVKQ9gnhT/0WyOl/pWMaORFDh4YH/xT/8LDDrTDZDmRtu1umUVr5nvrtBuDZYzC8a
	 AdJWgLiFzJCZ87QCJLADaoIswPAUZL40aACq3PMBQcTPDoADXMTpn1aRKNnK8vWsQk
	 n+ljojUQLbXXutNxjGn43+4FmTDbrkk3TXULTq/QwGYThRIrsdLoo/PkdM4mUyCOH6
	 4ucIDzS5juSFXew6fEmG/rQjGR7Fj/l87ot+DRO09MrUc6p0iDqdROZaxf+y6nsXFQ
	 gQm9hQ0TL4bdA==
Message-ID: <sashiko-outbox-191817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvmet: use appropriate types for authentication payload
 lengths
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261031075932.4345-1-sreekuttan2156239@gmail.com>
References: <20261031075932.4345-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 08:09:17 +0000
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
- [Low] nvmet: format specifier mismatch in nvmet_auth_challenge()
--

commit 53d4c9b2a209bbb82f1d82e67292975434b27d23
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

nvmet: use appropriate types for authentication payload lengths

This commit changes the payload length parameter al in nvmet_auth_challenge=
()
and nvmet_auth_success1() from int to u32, and changes data_size in
nvmet_auth_challenge() from int to size_t.

> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target=
/fabrics-cmd-auth.c
> index 70136f6c22e8c..99caad6fb87fb 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -448,13 +448,13 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
>  	nvmet_req_complete(req, status);
>  }
> =20
> -static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
> +static int nvmet_auth_challenge(struct nvmet_req *req, void *d, u32 al)
>  {
>  	struct nvmf_auth_dhchap_challenge_data *data =3D d;
>  	struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
>  	int ret =3D 0;
>  	int hash_len =3D nvme_auth_hmac_hash_len(ctrl->shash_id);
> -	int data_size =3D sizeof(*data) + hash_len;
> +	size_t data_size =3D sizeof(*data) + hash_len;
> =20
>  	if (ctrl->dh_tfm)
>  		data_size +=3D ctrl->dh_keysize;

[Severity: Low]
Now that al is u32 and data_size is size_t in nvmet_auth_challenge(), does =
the
pr_debug() immediately below also need its format specifiers updated from %d
to %u and %zu to avoid a -Wformat warning on 64-bit builds?

	if (al < data_size) {
		pr_debug("%s: buffer too small (al %d need %d)\n", __func__,
			 al, data_size);
		return -EINVAL;
	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031075932.4345=
-1-sreekuttan2156239@gmail.com?part=3D1

