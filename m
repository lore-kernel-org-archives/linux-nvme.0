Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7C2606A31E
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2026 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Hxn68jv+;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Am5N+2L1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Date:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Cc:To:Subject:
	From:Message-ID:MIME-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=lz6cIcsw2k0QrPuEE92qwSf/Xd928aDxunt/Z51hxWg=; b=Hxn68jv+QueSrIsX39w3taFFVq
	ZVFit1c29kJveWm985JDz/3GdxhZE5TBQBvYqhN4SelTjegUTAXjX8Ghfo5s1CodaIofHQTRRKZg2
	Ma5lrsj8yMuch2ATFcMJxdCKWwQwoyuMrsm6qYXZ2RhRGTcgT1kl1C2GdkZgec42coRFvOg3POP1Y
	Ju6fEkZ3J48hckuhkbn5z8jPONMMAOV87rPykJUi/7fSD5yg2PPjcehzqCzn6Uim35Oj1TpxxFSTV
	0AhOBh6NSd8qE3WR17EqElL+ZakiUfwn+qbl/hPr0oDXCquRrzHg89lS1z6XuWlx4qDxbBspiuzZo
	Itqd9k+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaTd-0000000DYGC-2Cn6;
	Thu, 26 Nov 2026 14:29:33 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWaTc-0000000DYFn-174a
	for linux-nvme@lists.infradead.org;
	Thu, 26 Nov 2026 14:29:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8172E60F0C;
	Thu, 26 Nov 2026 14:29:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672891F000C4;
	Thu, 26 Nov 2026 14:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795703371;
	bh=lz6cIcsw2k0QrPuEE92qwSf/Xd928aDxunt/Z51hxWg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Am5N+2L1Aan2DKv4AvuJiDRfoybl9OvmQrB+dOeBDezB+uIkQ3j/uKmS2b29x1gC2
	 mzgJ8DUr2fyeCu5sbvhLJeETyJgdtDuTObAJKJSxzOG5WTKJGzzPzcvBIal7ex7Vxs
	 XfEeCCmhJsw+pxkdrLhaylgVpywv1SXBfXQibFUXg/l6D7WirhqNizWj6nakgYnwho
	 JMKF6Hwyokdnl4lnScYviyR9oeVmvm4eXLXPNoVjT52cVgzX4MDWD49Ttag43L2tCF
	 HIchI2Hfz+ibkcMdlRuJHr33J9S3ewV0DoKBv4lCD4B0UhW3k6CenZD2PEkMfZhgAn
	 SlNmyVj59GXzQ==
Message-ID: <sashiko-outbox-235706@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 07/14] nvme: parse dhchap keys during option parsing
To: "Hannes Reinecke" <hare@kernel.org>, "Keith Busch" <kbusch@kernel.org>, "Jens
 Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, "Hannes
 Reinecke" <hare@suse.de>, "Chaitanya Kulkarni" <kch@nvidia.com>, "Eric
 Biggers" <ebiggers@kernel.org>, "David Howells" <dhowells@redhat.com>, "Jarkko
 Sakkinen" <jarkko@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Randy Dunlap" <rdunlap@infradead.org>, "Kees
 Cook" <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-nvme@lists.infradead.org, keyrings@vger.kernel.org
In-Reply-To: <20261126-dhchap-keyring-v4-v7-7-ee438ffea527@kernel.org>
References: <20261126-dhchap-keyring-v4-v7-0-ee438ffea527@kernel.org>
 <20261126-dhchap-keyring-v4-v7-7-ee438ffea527@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:29:29 +0000
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
- [High] nvme-auth: ERR_PTR dereference on key_lookup() in
  nvme_auth_init_ctrl()
--

commit 0df67db2f376340a8318c48ba959e7e18c9db8b6
Author: Hannes Reinecke <hare@kernel.org>

nvme: parse dhchap keys during option parsing

This commit creates DH-HMAC-CHAP keys during fabrics option parsing,
stores their key serials in struct nvmf_ctrl_options, and adds
dhchap_key and dhchap_ctrl_key sysfs attributes.

> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index d6abdb4f1e21c..285aa1c71f102 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
[ ... ]
> @@ -1028,38 +1023,100 @@ static void nvme_ctrl_auth_work(struct work_stru=
ct *work)
[ ... ]
>  int nvme_auth_init_ctrl(struct nvme_ctrl *ctrl)
>  {
>  	struct nvme_dhchap_queue_context *chap;
> +	struct key *host_key, *ctrl_key =3D NULL;
>  	int i, ret;
> =20
>  	mutex_init(&ctrl->dhchap_auth_mutex);
>  	INIT_WORK(&ctrl->dhchap_auth_work, nvme_ctrl_auth_work);
>  	if (!ctrl->opts)
>  		return 0;
> -	ctrl->host_key =3D nvme_auth_extract_key(ctrl->opts->dhchap_secret,
> -				strlen(ctrl->opts->dhchap_secret));
> -	if (IS_ERR(ctrl->host_key)) {
> -		ret =3D PTR_ERR(ctrl->host_key);
> -		ctrl->host_key =3D NULL;
> -		return ret;
> +	if (!ctrl->opts->dhchap_key) {
> +		nvme_auth_clear_host_key(ctrl);
> +		nvme_auth_clear_ctrl_key(ctrl);
> +		return 0;
>  	}
> =20
> -	ctrl->ctrl_key =3D nvme_auth_extract_key(ctrl->opts->dhchap_ctrl_secret,
> -				strlen(ctrl->opts->dhchap_ctrl_secret));
> -	if (IS_ERR(ctrl->ctrl_key)) {
> -		ret =3D PTR_ERR(ctrl->ctrl_key);
> -		ctrl->ctrl_key =3D NULL;
> -		goto err_free_dhchap_secret;
> +	host_key =3D key_lookup(ctrl->opts->dhchap_key);
> +	if (!host_key) {
> +		pr_warn("dhchap host key %08x not present\n",
> +			ctrl->opts->dhchap_key);
> +		return -ENOKEY;
> +	}
> +	down_read(&host_key->sem);
> +	ret =3D key_validate(host_key);
> +	up_read(&host_key->sem);
> +	if (ret) {
> +		pr_warn("dhchap host key %08x invalidated\n",
> +			key_serial(host_key));
> +		key_put(host_key);
> +		return -ENOKEY;
>  	}
> =20
> -	if (!ctrl->opts->dhchap_secret && !ctrl->opts->dhchap_ctrl_secret)
> -		return 0;
> +	if (ctrl->opts->dhchap_ctrl_key) {
> +		ctrl_key =3D key_lookup(ctrl->opts->dhchap_ctrl_key);
> +		if (!ctrl_key) {
> +			pr_warn("dhchap ctrl key %08x not present\n",
> +				ctrl->opts->dhchap_ctrl_key);
> +			key_put(host_key);
> +			return -ENOKEY;
> +		}
> +		down_read(&ctrl_key->sem);

[Severity: High]
Should host_key and ctrl_key be checked with IS_ERR() rather than for
NULL after key_lookup()?  key_lookup() returns ERR_PTR(-ENOKEY) when a
key serial is not found, so if either key is removed before
nvme_auth_init_ctrl() runs, down_read() will dereference an error
pointer.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-dhchap-key=
ring-v4-v7-0-ee438ffea527@kernel.org?part=3D7

