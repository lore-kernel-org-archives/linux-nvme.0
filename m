Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4AC606A33C
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 10:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=bUis+4/G;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXQPlVtj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=Gx/No4gR7ectZMSQQWSGtcO3qmMe2TveUBPq5zvGHyE=; b=bUis+4/G9obhh4gt4I7JoaDHu1
	YMZFEq/yGSj1UZ7ZjBwE7lF3KmyGSnC+wkL2KfvtXni41jY4wH0xBdSk7kecHA13l2WuCEb5lphKj
	bZZ39UDft1Nq3Ut6/9hWD+4pi0AUyuYwKj8zGV9R1fHdvmI9kOR0og/OPS7gSWLtutpZZCJ3eKM+V
	mV74WUj0KffGcuylOVufGtma/mzXFV72dgB8/cB/9jx1BAC0+NpUX89h8n37GSjxi3FnlDvyrlhAU
	/SPk2WgEmBxiSdvJCNMh4Tf4/wLq3QnIdCkeCsNHgr0NELwqx88qYwscCkqwRHykCjlIU3iuvN3U2
	RcpwTA8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQipr-00000003QPJ-0MyI;
	Tue, 10 Nov 2026 10:12:15 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQipp-00000003QOz-13pK
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 10:12:13 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A815261829;
	Tue, 10 Nov 2026 10:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D3A61F0089F;
	Tue, 10 Nov 2026 10:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794305532;
	bh=Gx/No4gR7ectZMSQQWSGtcO3qmMe2TveUBPq5zvGHyE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eXQPlVtjWBKBMvsitLCYHwWXS+LuPhRaX9pn+qtTlJkJBYqUw0HWsZKA6dasbTo55
	 6pJfkEC19E6u4fXLXxxy5/U5SeMtpyiL1zS0WJSZ+j4Pa8eFMgV1hcokovOTl2HpC2
	 vPGOLPIo8ingVaGXdCPTpoNdbbtB8eVPQxKCJe0G0OwoZRvIqb/tYPxFgYJ5OgyUmf
	 WX32KisdJLxQGNnKzKEajZ0GyOGV3+rFfnDCltB+QkxWygf5Az/NcicIqNaQfrZrZ4
	 P/VdUJlBRQ+obo5c5ROAeCoi3CMzoMCqPFlo+BcVZGG01Q5MV/MlutSB0P4FyNXjRF
	 Ur4vx7oJh+CXg==
Message-ID: <sashiko-outbox-206840@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] nvmet: clean up DH group state on initialization
 failure
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261110100058.4652-1-sreekuttan2156239@gmail.com>
References: <20261110100058.4652-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 10:12:11 +0000
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
- [Low] nvmet: duplicated error cleanup and stale key state in
  nvmet_setup_dhgroup()
--

commit 93030c9f4d0e5c6bd96e27ce68cc9495a6c3ffb3
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

nvmet: clean up DH group state on initialization failure

This commit cleans up the Diffie-Hellman transform, key, and group state
when DH group initialization fails in nvmet_setup_dhgroup().

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index ccba84b1344e0..33f2584973ec1 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -97,6 +97,10 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 dh=
group_id)
>  		ret =3D PTR_ERR(ctrl->dh_tfm);
>  		ctrl->dh_tfm =3D NULL;
>  		ctrl->dh_gid =3D 0;
> +		kfree_sensitive(ctrl->dh_key);
> +		ctrl->dh_key =3D NULL;
> +		ctrl->dh_keysize =3D 0;
> +		return ret;
>  	} else {
>  		ctrl->dh_gid =3D dhgroup_id;
>  		pr_debug("%s: ctrl %d setup DH group %d\n",
> @@ -105,9 +109,7 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 d=
hgroup_id)
>  		if (ret < 0) {
>  			pr_debug("%s: ctrl %d failed to generate private key, err %d\n",
>  				 __func__, ctrl->cntlid, ret);
> -			kfree_sensitive(ctrl->dh_key);
> -			ctrl->dh_key =3D NULL;
> -			return ret;
> +			goto err;
>  		}
>  		ctrl->dh_keysize =3D crypto_kpp_maxsize(ctrl->dh_tfm);
>  		kfree_sensitive(ctrl->dh_key);
> @@ -115,18 +117,26 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8=
 dhgroup_id)
>  		if (!ctrl->dh_key) {
>  			pr_warn("ctrl %d failed to allocate public key\n",
>  				ctrl->cntlid);
> -			return -ENOMEM;
> +			ret =3D -ENOMEM;
> +			goto err;
>  		}
>  		ret =3D nvme_auth_gen_pubkey(ctrl->dh_tfm, ctrl->dh_key,
>  					   ctrl->dh_keysize);
>  		if (ret < 0) {
>  			pr_warn("ctrl %d failed to generate public key\n",
>  				ctrl->cntlid);
> -			kfree(ctrl->dh_key);
> -			ctrl->dh_key =3D NULL;
> +			goto err;
>  		}
>  	}
> =20
> +	return 0;
> +err:
> +	kfree_sensitive(ctrl->dh_key);
> +	ctrl->dh_key =3D NULL;
> +	crypto_free_kpp(ctrl->dh_tfm);
> +	ctrl->dh_tfm =3D NULL;
> +	ctrl->dh_gid =3D 0;
> +	ctrl->dh_keysize =3D 0;
>  	return ret;
>  }

[Severity: Low]
Can the IS_ERR(ctrl->dh_tfm) branch set ret =3D PTR_ERR(ctrl->dh_tfm) and
jump to err instead of duplicating the teardown sequence and keeping the
else block after a return?  crypto_free_kpp() calls crypto_destroy_tfm(),
which handles error pointers safely.

Also, when ctrl->dh_tfm is already set and nvmet_setup_dhgroup() switches
to a different dhgroup_id earlier in the function, ctrl->dh_tfm is freed
without clearing ctrl->dh_key or ctrl->dh_keysize:

drivers/nvme/target/auth.c:nvmet_setup_dhgroup() {
    ...
	if (ctrl->dh_tfm) {
		if (ctrl->dh_gid =3D=3D dhgroup_id) {
			pr_debug("%s: ctrl %d reuse existing DH group %d\n",
				 __func__, ctrl->cntlid, dhgroup_id);
			return 0;
		}
		crypto_free_kpp(ctrl->dh_tfm);
		ctrl->dh_tfm =3D NULL;
		ctrl->dh_gid =3D 0;
	}

	if (dhgroup_id =3D=3D NVME_AUTH_DHGROUP_NULL)
		return 0;
    ...
}

If the new dhgroup_id is NVME_AUTH_DHGROUP_NULL (or an invalid group ID),
the early return leaves the previous group's ctrl->dh_key allocated and
ctrl->dh_keysize non-zero.  Freeing ctrl->dh_key and zeroing
ctrl->dh_keysize alongside crypto_free_kpp(ctrl->dh_tfm) there would keep
all DH state cleared on group changes and make the extra
kfree_sensitive(ctrl->dh_key) before kzalloc() unnecessary.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110100058.4652=
-1-sreekuttan2156239@gmail.com?part=3D1

