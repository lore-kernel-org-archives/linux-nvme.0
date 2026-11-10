Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D12606A930
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 09:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ywbSpsM4;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BCNAIbFz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=jKtp2ikDT7bz38YXRHHesMusfoPzXFm29RUvS9hECbc=; b=ywbSpsM40X6IBTMw9I/ZPbenO6
	Ueio3zhhRkHgNiyf607BO+GCMI7j2ifj1WBGl0kLO7hv/uQLBZcuNMlpC3V+lLA+k4WZxdmUkBYgD
	046o3PKpTtMWPXPzorOkTuAqGTmnnrCSoUx3m9cIkMm+cQdxLnLB3cZErL4k/uhHPTBkCmhqTFppR
	gDxRTe5sZ4YdR+xg5s2561Sd4zm2Fxeu67DUogLzdwLaF2LdG/4u2R8OZlaOr1+sMqJthbjlbJUQ2
	KKwpcPquc+Ifw3kFSswk4jL2ewWwnKc7+SIPywQkXJY1Nq3nooAWCqFtZASN7azv3313Hzfs21+Kx
	OOepPX6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQiJk-00000003Iox-3wu7;
	Tue, 10 Nov 2026 09:39:04 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQiJj-00000003IoF-1cv0
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 09:39:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id B2A80403A6;
	Tue, 10 Nov 2026 09:39:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68F711F0089F;
	Tue, 10 Nov 2026 09:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794303542;
	bh=jKtp2ikDT7bz38YXRHHesMusfoPzXFm29RUvS9hECbc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BCNAIbFzNQMdImQu+CZALPDl129jIou70YU09BnwmIpeq/v2V3CH+4IhE+KakcTUU
	 V0qjU0cedXt96gfzDhk5BjR6mkmBJcFuIqkmn2c9sN/Wdyi80pWV5pnfoDBSOpib3R
	 xcEu8xl5ZPRZxY8S9y2S9J4R6J279o6tSoFrMR7K2HFarAWeXWhDkarQQz10A6X4cu
	 pCzDOzIWVmhUiIt3WTxHnaUGFsopFY9WLEwAC8zWA+g7Lp/d/Rk+iUQHvpnCX+US5w
	 oi62HCo/AEt+YjD0KON+gSpdn3FMVRRn944VpreoZ59pJUKY2kaRIw6S7pL+kdrRvd
	 yuMH6hE0QiKOQ==
Message-ID: <sashiko-outbox-206787@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] nvmet: clean up DH group state on initialization
 failure
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261110093047.4290-1-sreekuttan2156239@gmail.com>
References: <20261110093047.4290-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 09:39:01 +0000
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
- [High] nvmet: nvmet_setup_dhgroup() returns 0 when crypto_alloc_kpp()
  fails
--

commit a615cbc77d9efc8d40fbde68d3ff3d83eaa208bd
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

nvmet: clean up DH group state on initialization failure

This commit adds a shared error label in nvmet_setup_dhgroup() to free
ctrl->dh_tfm and reset DH group state when private-key generation,
public-key allocation, or public-key generation fails.

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index ccba84b1344e0..20f8c84e8ced5 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -105,9 +105,7 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 d=
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
> @@ -115,18 +113,26 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8=
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

[Severity: High]
Does nvmet_setup_dhgroup() now return 0 when crypto_alloc_kpp() fails?

drivers/nvme/target/auth.c:nvmet_setup_dhgroup() {
	...
	ctrl->dh_tfm =3D crypto_alloc_kpp(dhgroup_kpp, 0, 0);
	if (IS_ERR(ctrl->dh_tfm)) {
		...
		ret =3D PTR_ERR(ctrl->dh_tfm);
		ctrl->dh_tfm =3D NULL;
		ctrl->dh_gid =3D 0;
	} else {
	...
}

The IS_ERR(ctrl->dh_tfm) branch previously fell through the end of the
if-else block to "return ret;".  With "return 0;" placed right before
err, a crypto_alloc_kpp() failure falls through and reports success to
nvmet_setup_auth(), silently proceeding with ctrl->dh_tfm set to NULL and
ctrl->dh_gid set to NVME_AUTH_DHGROUP_NULL instead of failing with
NVME_AUTH_DHCHAP_FAILURE_DHGROUP_UNUSABLE, and leaving any prior
ctrl->dh_key and ctrl->dh_keysize in place on re-authentication.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110093047.4290=
-1-sreekuttan2156239@gmail.com?part=3D1

