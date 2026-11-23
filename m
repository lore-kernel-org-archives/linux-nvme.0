Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58529606A31E
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Nov 2026 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=I0uWl7te;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PHVl2Hb1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=VAtAcw38RoENOTchJ2eT41az4w2bJrVaK0W2EwZXYsc=; b=I0uWl7telTGXobPBfqf1JnMIby
	Dcu7kqGFu8U78phPqQNJsB5kysKe955UuareWlLYqyuHIqWDjOCGoU0nf8wAKromxBRQZ05DhqU4n
	PI6JWz+vRrlWicmJas9UufAlMNqgLRj8qXJLL2xzR+1wJVveButkQtpJuGHxRzCzYd2owH3itiC4J
	xTdoa0KrB7FuXKtX/dhdmAPpulcYmm0wEqLRAYXjg1+10KTMteOeV0ANG7Filmq+K07nJksxvh3vT
	MXXYoteFCgurlk0nHl25JShj6rE2e13G7Ufz0uRtj51kodEuuiWSFyBSx2E1fYzQx1veQXKu98VWC
	YBZmtpBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXrp-00000004Md5-3qrv;
	Mon, 23 Nov 2026 17:30:13 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVXro-00000004Mco-3nPB
	for linux-nvme@lists.infradead.org;
	Mon, 23 Nov 2026 17:30:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 8B61F43C01
	for <linux-nvme@lists.infradead.org>; Mon, 23 Nov 2026 17:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC731F000D0;
	Mon, 23 Nov 2026 17:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795455012;
	bh=VAtAcw38RoENOTchJ2eT41az4w2bJrVaK0W2EwZXYsc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PHVl2Hb1Y0nKu8WFzOGxXcBRCMLWocpzYEuTu3kJlvjIWEa0xnx6Y6lnBUlD/dpn/
	 Qpd0DVNzoZneoEIUIzwV+5VDCrdNfJG/FESH14Sa0N0Ly74QGxv0OJYcdQVHApbi0A
	 El7DnEwPIi8T4QrPLcPJmbcsa5vYyIV+ZU7nfy9LZQABjQ62fcNz715k8uO6bMarpf
	 RSk3/G6xAIQiZBEdtgV5FU5dhArL93/EowxTXnpHjOlHJwJQEC/vnLKlBafzHTgQ+L
	 ACFHwEZNdHQpU44C39bdG3YdYl+AdbUGyEkqi5DdXs/O9koE325tA3K4Qiks/WR426
	 US40GzCUculuQ==
Message-ID: <sashiko-outbox-229749@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/9] nvmet-auth: parse dhchap key from configfs
 attribute
To: "Hannes Reinecke" <hare@kernel.org>
Cc: linux-nvme@lists.infradead.org
In-Reply-To: <20261123-dhchap-keyring-v4-v6-5-5082a49715ab@kernel.org>
References: <20261123-dhchap-keyring-v4-v6-0-5082a49715ab@kernel.org>
 <20261123-dhchap-keyring-v4-v6-5-5082a49715ab@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 17:30:11 +0000
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
- [Medium] nvmet-auth: host_key reference leak in nvmet_setup_auth() on
  ctrl_key error
--

commit 0056af1c2f2c7d56f3cbd59406150e77070f9ffe
Author: Hannes Reinecke <hare@kernel.org>

nvmet-auth: parse dhchap key from configfs attribute

This commit converts the nvmet configfs DH-HMAC-CHAP key handling to
parse and store keys as struct key references on struct nvmet_host
instead of raw secret strings.

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 26457ce4acc2a..6348c810bd168 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c

[ ... ]

> @@ -186,22 +195,43 @@ u8 nvmet_setup_auth(struct nvmet_ctrl *ctrl, struct=
 nvmet_sq *sq, bool reset)
>  		goto out_unlock;
>  	}
> =20
> -	if (!host->dhchap_secret) {
> +	if (!host->dhchap_key) {
>  		pr_debug("No authentication provided\n");
>  		goto out_unlock;
>  	}
> =20
> -	host_key =3D nvme_auth_extract_key(NULL, host->dhchap_secret,
> -					 strlen(host->dhchap_secret));
> -	if (IS_ERR(host_key)) {
> +	host_key =3D key_get(host->dhchap_key);
> +	if (!host_key) {
> +		pr_warn("%s: host key %08x not found\n",
> +			__func__, key_serial(host->dhchap_key));
>  		ret =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>  		goto out_unlock;
>  	}
> -	if (host->dhchap_ctrl_secret) {
> -		ctrl_key =3D nvme_auth_extract_key(NULL, host->dhchap_ctrl_secret,
> -						 strlen(host->dhchap_ctrl_secret));
> -		if (IS_ERR(ctrl_key)) {
> -			key_put(host_key);
> +	down_read(&host_key->sem);
> +	ret =3D key_validate(host_key);
> +	key_id =3D key_serial(host_key);
> +	up_read(&host_key->sem);
> +	if (ret) {
> +		pr_warn("host key %08x invalidated\n", key_id);
> +		key_put(host_key);
> +		ret =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
> +		goto out_unlock;
> +	}
> +	if (host->dhchap_ctrl_key) {
> +		ctrl_key =3D key_get(host->dhchap_ctrl_key);
> +		if (!ctrl_key) {
> +			pr_warn("%s: ctrl key %08x not found\n",
> +				__func__, key_serial(host->dhchap_ctrl_key));
> +			ret =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
> +			goto out_unlock;
> +		}
> +		down_read(&ctrl_key->sem);
> +		ret =3D key_validate(ctrl_key);
> +		key_id =3D key_serial(ctrl_key);
> +		up_read(&ctrl_key->sem);
> +		if (ret) {
> +			pr_warn("ctrl key %08x invalidated\n", key_id);
> +			key_put(ctrl_key);
>  			ret =3D NVME_AUTH_DHCHAP_FAILURE_NOT_USABLE;
>  			goto out_unlock;
>  		}

[Severity: Medium]
Do both error paths under if (host->dhchap_ctrl_key) leak host_key by
jumping to out_unlock without calling key_put(host_key)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123-dhchap-key=
ring-v4-v6-0-5082a49715ab@kernel.org?part=3D5

