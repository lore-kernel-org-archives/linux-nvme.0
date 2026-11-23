Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D479A606A327
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Ip4SRums;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bdik7rPB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=ftJF8s8/PKSYLo2Ov5PSFlBeZaQ8sDR4vfDU94oNg1o=; b=Ip4SRumsXg3SE4Oz+OQ3IL2kkC
	mHi53pUKEALYzwdQnqGe8aoSWyFZfTYV/YDgH06YRgQ6+NyGxA/l0MkUpWmv3Tw5FDTS6AWtROATi
	sfkYvROiUudzYVYO4A7v4+y2NE/37JYYAl8oz8LIHhfQnA9IOEiT4XOTyROdjYwIIiLZ1UncSMAFf
	NYsshYl6dJJ1aA+CvLDdj/jLxR15CSIZhu0upTpav+UvC2bypcWEvL4qR5RvBVilof64Tc1KLnUXL
	dh8NCWCOtdD4RD/ZJIam+ON4wtLCpjTCuRuQJz6Bi9Ux4Ec93x/w+mBMHzHS78+xYEHznX4kiXZ13
	06LNrwvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXuh-00000004NIo-0m1B;
	Mon, 23 Nov 2026 17:33:11 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXuX-00000004NHf-3BeN
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 17:33:01 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D0BA860616
	for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 17:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E091F000D3;
	Mon, 23 Nov 2026 17:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795455180;
	bh=ftJF8s8/PKSYLo2Ov5PSFlBeZaQ8sDR4vfDU94oNg1o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bdik7rPBLkngQPm+PyVEITGc9LiihyI2hZJT1nElMuWjhU42iwJ7KrlsFzlpEJadp
	 onB8QdxbXoMty17P+d95S8G6Dmjm4kiwVvmLmGkjq4E9TTp9MIdEg2Oo/lu3KmXnZt
	 wYo/XTzWCFBrT7BBDPG0IwCl4eM/xqSAL85rS1kDK6+8JJSjEQ98t0Oa0CdV5UYHV1
	 44AX394ffCZkZbpsPMY5OrbWYHc69d4GjXlhGAzDQBlbtX/H4uld/oFgEXCIlDqIdF
	 CiJEFcrQ7Goseh8ufTPKBCF7pBnnHx8HoDF34zV0PZDRXljghIgSVb85fzrV2jhJJZ
	 QMR7nEkhWEkgQ==
Message-ID: <sashiko-outbox-229762@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/9] nvme-auth: switch to use 'struct key'
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261123-dhchap-keyring-v4-v6-3-5082a49715ab@kernel.org>
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123-dhchap-keyring-v4-v6-3-5082a49715ab@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 17:32:59 +0000
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
- [Medium] nvme-auth: memory leak of transformed_data in
  nvme_auth_transform_key()
--

commit 4697c9583f14fbc14890cc4dbfaed8c9987d382a
Author: Hannes Reinecke <hare@kernel.org>

nvme-auth: switch to use 'struct key'

This commit switches NVMe DH-HMAC-CHAP key storage and handling from
struct nvme_dhchap_key to struct key using the dhchap key type.

> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 308af3d7c7383..158c9cb886c15 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
[ ... ]
> @@ -317,11 +261,13 @@ static int nvme_auth_hash(u8 hmac_id, const u8 *dat=
a, size_t data_len, u8 *out)
>  	return -EINVAL;
>  }
> =20
> -int nvme_auth_transform_key(const struct nvme_dhchap_key *key, const cha=
r *nqn,
> +int nvme_auth_transform_key(struct key *key, const char *nqn,
>  			    u8 **transformed_secret)
>  {
[ ... ]
> +	transformed_len =3D nvme_auth_hmac_hash_len(key_hash);
> +	transformed_data =3D kzalloc(transformed_len, GFP_KERNEL);
> +	if (!transformed_data) {
> +		ret =3D -ENOMEM;
> +		goto out_free_data;
> +	}
> +
> +	ret =3D nvme_auth_hmac_init(&hmac, key_hash, key_data, key_len);
> +	if (ret)
> +		goto out_free_data;
>  	nvme_auth_hmac_update(&hmac, nqn, strlen(nqn));
>  	nvme_auth_hmac_update(&hmac, "NVMe-over-Fabrics", 17);
> -	nvme_auth_hmac_final(&hmac, key_data);
> -	*transformed_secret =3D key_data;
> -	return transformed_len;
> +	nvme_auth_hmac_final(&hmac, transformed_data);
> +	*transformed_secret =3D transformed_data;
> +	ret =3D transformed_len;
> +out_free_data:
> +	kfree_sensitive(key_data);
> +	return ret;
>  }

[Severity: Medium]
Does this leak transformed_data when nvme_auth_hmac_init() fails and jumps
to out_free_data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-dhchap-key=
ring-v4-v6-0-5082a49715ab@kernel.org?part=3D3

