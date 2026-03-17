Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFD64FD8767
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Mar 2026 13:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+PqKoxMD9pXzf27ayTNid+7h1xL/abzENdnSfttD1Nc=; b=PiqhGkRoYMRbNALCY0/h3i70Fl
	qJnRFiUcuBbTxC7/xh1B1Unt1U+5CWsggFSOU7WkNeSnheOWtBgzYCCVvy4B0Th2iK4hKoEcUKZsy
	nnlGCV270BdxSOQ0XozLRPKyhTIbd4l4mtesWuSke4DTScJag3jbDyr/0b6GznANavZstvoesfvEM
	aB9/ecDq59M41uhFAIf6XswDotW+ekgUEEVC1xU6OUrbdPbrjGSTBYK0eCOELCSAdC+AqqoFTKmy3
	EAWwRInil+qJ1EC0q+O7feVixKSp5IarUmzw7d5gh9HPeAnr/5oAHqzhr2dFO/aQinBF+9YBkIfQV
	9VNAoAbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2UAe-00000006NwJ-28a4;
	Tue, 17 Mar 2026 13:09:16 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2UAZ-00000006Ntr-3abH
	for linux-nvme@lists.infradead.org;
	Tue, 17 Mar 2026 13:09:13 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id e08e6c67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 17 Mar 2026 14:09:07 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 14:09:06 +0100
Message-Id: <DH52XYOOWNYQ.1S8KINS05UU0L@arkamax.eu>
Cc: "Sagi Grimberg" <sagi@grimberg.me>, "Keith Busch" <kbusch@kernel.org>,
 <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 1/8] nvme-auth: modify nvme_auth_transform_key() to
 return status
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Hannes Reinecke" <hare@kernel.org>, "Christoph Hellwig" <hch@lst.de>
X-Mailer: aerc 0.21.0
References: <20260317130103.107360-1-hare@kernel.org>
 <20260317130103.107360-2-hare@kernel.org>
In-Reply-To: <20260317130103.107360-2-hare@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260317_060912_219933_10763E4C 
X-CRM114-Status: GOOD (  14.43  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue Mar 17, 2026 at 2:00 PM CET, Hannes Reinecke wrote:
> In preparation for converting the DH-HMAC-CHAP code to use the
> kernel keyring modify nvme_auth_transform_key() to return a status
> and provide the transformed data as argument on the command line as
> raw data.
>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>
> ---
>  drivers/nvme/common/auth.c | 38 ++++++++++++++++----------------
>  drivers/nvme/host/auth.c   | 44 ++++++++++++++++++++------------------
>  drivers/nvme/target/auth.c | 37 ++++++++++++++++++--------------
>  include/linux/nvme-auth.h  |  4 ++--
>  4 files changed, 65 insertions(+), 58 deletions(-)
>
> diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
> index 2d325fb93083..772af9b6dccd 100644
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

Nit: unchecked kzalloc() return value

Maurizio


