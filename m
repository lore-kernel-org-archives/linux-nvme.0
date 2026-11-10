Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24DC606A335
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Nov 2026 08:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ZguQ7Aoq;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P08CM0jx
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=6zadcbRKYM49AnFLlyFHJpXsB0mb8mLYb5BzgKAQp1U=; b=ZguQ7AoqJ2dKXz6CqHlm1Gg/I6
	RDB9LN3sodOds5JwehRPa56go0hEYrHxtGby9u3brFtCyTrL5D7P8i9XNxCxO+Bp9eY1cspNESgC4
	UWFn0W83mWEVojmWc/IWOkkRox7iuV2unkYE1KVFzyZenWU2vU0dF/NXAJOpsy4Bwz8zCBqba+Z3k
	AgrBAIVQZCeENzwAfyRPrhO/iVdC6SL1Qfb+cKQ8J3LGesXhr+cnaPbw8gO/THB0dZugwFzqYkBwX
	p9gpWlWQw2pwCWgAm6gMZjPRvg2/nmQgixQo5bsejiXKyxUt95AC+nSBe08LtUte42WylH6YB4LfU
	/Ra9fP3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhgs-00000003Boy-1pEH;
	Tue, 10 Nov 2026 08:58:54 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQhgq-00000003Boq-1PqV
	for linux-nvme@lists.infradead.org;
	Tue, 10 Nov 2026 08:58:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E6B340654;
	Tue, 10 Nov 2026 08:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EEE1F00900;
	Tue, 10 Nov 2026 08:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794301131;
	bh=6zadcbRKYM49AnFLlyFHJpXsB0mb8mLYb5BzgKAQp1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P08CM0jxPRafvqbuvwurBcDzlTmdlroiAAaiKYRX3UOxaNSXkj9boE3wOHUOnRAR8
	 CFte5EvSa46MteRphbAQuktO31gimD6C6MuyKysgq6dAPonkZ6ZZiGVCP209fQdt72
	 2ENPGqb3DQ/d7QJTDX9rDq34bcbgCqKZpHPOpDHK8LYSHUMsNe1BvwcbH8XiDfjMxQ
	 FhssX9aBYlbTtnZrynDTgWfae6TEZ/haHE6+IuR+QXSfZmQfLXEEuIZ8j4UW1WFQnV
	 0lmhY/v9qSJJTnWYX7ngfLEF1JRQixLq7YiPHXVhQpO1GchNxyJ54wKnczGQxa+Z++
	 qXFdSINphPMUQ==
Message-ID: <sashiko-outbox-206686@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] nvmet: clean up DH group state on initialization
 failure
To: "Sreeraj S Kurup" <sreekuttan2156239@gmail.com>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261110084832.3508-1-sreekuttan2156239@gmail.com>
References: <20261110084832.3508-1-sreekuttan2156239@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:58:50 +0000
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
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Low] nvmet: missing Fixes trailer for nvmet_setup_dhgroup() error
  cleanup
- [Low] nvmet: duplicated DH group cleanup on error in
  nvmet_setup_dhgroup()
--

commit b6a4d390d8e8eebaf9899dae456023c9299ff1cc
Author: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

> nvmet: clean up DH group state on initialization failure
>
> nvmet_setup_dhgroup() leaves the DH transform and group ID
> initialized when private-key generation, public-key allocation,
> or public-key generation fails.
>
> A subsequent invocation with the same DH group incorrectly
> returns success because the existing transform and group ID
> are treated as proof of successful initialization.
>
> Release the transform and reset the group state on initialization
> failures so that subsequent attempts can properly retry setup.
>
> Signed-off-by: Sreeraj S Kurup <sreekuttan2156239@gmail.com>

[Severity: Low]
This fixes incomplete error cleanup in nvmet_setup_dhgroup().  Should the
commit message include:

  Fixes: 7a277c37d352 ("nvmet-auth: Diffie-Hellman key exchange support")

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index ccba84b1344e0..7733d50de708f 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -105,6 +105,10 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 =
dhgroup_id)
>  		if (ret < 0) {
>  			pr_debug("%s: ctrl %d failed to generate private key, err %d\n",
>  				 __func__, ctrl->cntlid, ret);
> +			crypto_free_kpp(ctrl->dh_tfm);
> +			ctrl->dh_tfm =3D NULL;
> +			ctrl->dh_gid =3D 0;
> +			ctrl->dh_keysize =3D 0;
>  			kfree_sensitive(ctrl->dh_key);
>  			ctrl->dh_key =3D NULL;
>  			return ret;
> @@ -115,6 +119,10 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 =
dhgroup_id)
>  		if (!ctrl->dh_key) {
>  			pr_warn("ctrl %d failed to allocate public key\n",
>  				ctrl->cntlid);
> +			crypto_free_kpp(ctrl->dh_tfm);
> +			ctrl->dh_tfm =3D NULL;
> +			ctrl->dh_gid =3D 0;
> +			ctrl->dh_keysize =3D 0;
>  			return -ENOMEM;
>  		}
>  		ret =3D nvme_auth_gen_pubkey(ctrl->dh_tfm, ctrl->dh_key,
> @@ -122,8 +130,12 @@ int nvmet_setup_dhgroup(struct nvmet_ctrl *ctrl, u8 =
dhgroup_id)
>  		if (ret < 0) {
>  			pr_warn("ctrl %d failed to generate public key\n",
>  				ctrl->cntlid);
> -			kfree(ctrl->dh_key);
> +			kfree_sensitive(ctrl->dh_key);
>  			ctrl->dh_key =3D NULL;
> +			crypto_free_kpp(ctrl->dh_tfm);
> +			ctrl->dh_tfm =3D NULL;
> +			ctrl->dh_gid =3D 0;
> +			ctrl->dh_keysize =3D 0;
>  		}
>  	}

[Severity: Low]
This isn't a bug, but all three error paths in nvmet_setup_dhgroup() repeat
the same teardown of ctrl->dh_tfm, ctrl->dh_gid, ctrl->dh_keysize and
ctrl->dh_key.  Since kfree_sensitive(NULL) is a no-op, could these branches
jump to a single error label at the end of the function instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110084832.3508=
-1-sreekuttan2156239@gmail.com?part=3D1

