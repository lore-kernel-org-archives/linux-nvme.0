Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D276606A325
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Nov 2026 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=HRDNZx86;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GQaDDGKZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=4De//PstuAfYtp4WBScUJuqFlnqEsvTLiD3MJ9mQQgU=; b=HRDNZx86JU4sLI7vpMAR8x6XWw
	1BFZPYsBJ4U910xxdS91QQuZsvrxShjuhhCWX51e4ePLcqZC9sv4csewhFsoD8p4Db8VHJEPI57D0
	f8m6atMK23Mdt2lKqhiK1armfR04mUtV25zaFpruy/6HNzoE/853lb11szK4iVc9Q8gzyR4/QNGtH
	ukcOvD/1JgkNp/qoHw1QwKuWIx7SnKoF9s8SfHdkGrZAh02YMN1qZhcYXemf368BrFNG+CXr0UXJj
	2Bela6Y3cri+HPuhK1Vo59RgEOIjrVsH9f69lgJ8x/4KKqKSblyAShhrLDlHaIg10zDj3CYNm42gt
	rnQjd97A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMep-0000000Elsv-45Qu;
	Fri, 20 Nov 2026 11:19:55 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xUMeo-0000000Elsl-2fcz
	for linux-nvme@lists.infradead.org;
	Fri, 20 Nov 2026 11:19:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id ABE406145E
	for <linux-nvme@lists.infradead.org>; Fri, 20 Nov 2026 11:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76A91F000EF;
	Fri, 20 Nov 2026 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795173593;
	bh=4De//PstuAfYtp4WBScUJuqFlnqEsvTLiD3MJ9mQQgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GQaDDGKZddoTdIsGik2w7wzZeEYRiMWL+eO2KrXqhP5ElGeoaWqWDe0F623lekWYv
	 kjOviNG5EOMjqy+kF0Nts/1Qh7tL7OBiriMqtAfS/Bdxa+h9baKfiOnCIAlisUg00j
	 4quKuuQ7U2AYd0c9bajw/ZWra6Wvne8B3iunZpHqRQkBXuOT9wce4XwbSN9yMWVixE
	 FNwo9+YmXbRr0IVnhVBM8Ul+h0AMgJDwEmhTFd2ILrHtOVJtc3SmSgQs7TypAFjXhJ
	 9/gD0wSgTUtBMnQxxuvmhcMWfKTPuEwdDZUdBbclZtI3lPCEoZWmx5mKeLOssFrs1U
	 OJ6fzBg5KZksA==
Message-ID: <sashiko-outbox-225021@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/9] nvme-auth: modify nvme_auth_transform_key() to
 return status
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261120-dhchap-keyring-v4-v4-1-5f8c7d9926ee@kernel.org>
References: <20261120-dhchap-keyring-v4-v4-0-5f8c7d9926ee@kernel.org>
 <20261120-dhchap-keyring-v4-v4-1-5f8c7d9926ee@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Nov 2026 11:19:52 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] nvme-auth: NULL pointer dereference in
  nvme_auth_transform_key()
- [Low] nvme-auth: unused variable transformed_data in
  nvme_auth_transform_key()
- [Low] nvme-auth: missing memzero_explicit() on error in
  nvme_auth_transform_key()
--

commit b03dd5c2705fd9466c887dbc6671b901be8cc15b
Author: Hannes Reinecke <hare@kernel.org>

nvme-auth: modify nvme_auth_transform_key() to return status

This commit changes nvme_auth_transform_key() to return the transformed key
length or a negative error code and pass the allocated raw secret buffer via
an output pointer, updating all callers in the NVMe host and target auth co=
de.

> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 1fdc4e4ed0b94..569f21ad4fc7e 100644
> --- a/drivers/nvme/common/auth.c
> +++ b/drivers/nvme/common/auth.c
> @@ -317,37 +317,37 @@ static int nvme_auth_hash(u8 hmac_id, const u8 *dat=
a, size_t data_len, u8 *out)
>  	return -EINVAL;
>  }
> =20
> -struct nvme_dhchap_key *nvme_auth_transform_key(
> -		const struct nvme_dhchap_key *key, const char *nqn)
> +int nvme_auth_transform_key(const struct nvme_dhchap_key *key, const cha=
r *nqn,
> +			    u8 **transformed_secret)
>  {
>  	struct nvme_auth_hmac_ctx hmac;
> -	struct nvme_dhchap_key *transformed_key;
> -	int ret, key_len;
> +	u8 *transformed_data;
> +	u8 *key_data;
> +	size_t transformed_len;
> +	int ret;

[Severity: Low]
Is transformed_data unused in this patch?  Declaring it here triggers a
-Wunused-variable warning until later commit "nvme-auth: switch to use
'struct key'" uses it.

> =20
>  	if (!key) {
>  		pr_warn("No key specified\n");
> -		return ERR_PTR(-ENOKEY);
> +		return -ENOKEY;
>  	}
>  	if (key->hash =3D=3D 0) {
> -		key_len =3D nvme_auth_key_struct_size(key->len);
> -		transformed_key =3D kmemdup(key, key_len, GFP_KERNEL);
> -		if (!transformed_key)
> -			return ERR_PTR(-ENOMEM);
> -		return transformed_key;
> +		key_data =3D kzalloc(key->len, GFP_KERNEL);
> +		memcpy(key_data, key->key, key->len);
> +		*transformed_secret =3D key_data;
> +		return key->len;
>  	}

[Severity: High]
Can this cause a NULL pointer dereference in memcpy() if kzalloc() fails
when key->hash =3D=3D 0?  A later patch in the series, commit "nvme-auth: s=
witch
to use 'struct key'", adds a NULL check on key_data, but intermediate
commits can crash here on allocation failure.

>  	ret =3D nvme_auth_hmac_init(&hmac, key->hash, key->key, key->len);
>  	if (ret)
> -		return ERR_PTR(ret);
> -	key_len =3D nvme_auth_hmac_hash_len(key->hash);
> -	transformed_key =3D nvme_auth_alloc_key(key_len, key->hash);
> -	if (!transformed_key) {
> -		memzero_explicit(&hmac, sizeof(hmac));
> -		return ERR_PTR(-ENOMEM);
> -	}
> +		return ret;
> +	transformed_len =3D nvme_auth_hmac_hash_len(key->hash);
> +	key_data =3D kzalloc(transformed_len, GFP_KERNEL);
> +	if (!key_data)
> +		return -ENOMEM;

[Severity: Low]
Should this error path call memzero_explicit(&hmac, sizeof(hmac)) before
returning -ENOMEM, as the code did prior to this patch so key-derived HMAC
state is not left on the stack?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261120-dhchap-key=
ring-v4-v4-0-5f8c7d9926ee@kernel.org?part=3D1

