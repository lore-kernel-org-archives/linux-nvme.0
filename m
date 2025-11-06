Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1297CCFA03
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Nov 2025 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mgw/fPrHMpJPDRmtQHXy3qFjXzsQgXrjXttBI0uY/iA=; b=SLxEztGfVFDfgHzW5rqk67jHDT
	3ueldPWG0qPP5GhoI/LmOHImc1tdivfNye8zGdzxNohuU/q9TMtT1RX4wZleDOVN0XVm/0+6OOfG6
	wsyEMPWap13mO9h2LDqvkISsmJXFIgCrKjk48k9A2KKG+lCTDQNubemmTcHv+y7WAwjN5R1BzyTxI
	I2pGuYE9oW06Ls9EpentFeX14LIXRxiyGVpLVfDpbwlGFMi5VhAv9poRmbZvNqlYqS7lNZuoIRfnJ
	TdfIA5jrecxhb9Cg5RBBAGN8P4diXcqFaqSQf6rjxD+iPVU9xL3Pu0gRB5dLwfvwlcLQLHhepc8Y2
	6W18GiXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGzgb-0000000FX8L-1tER;
	Thu, 06 Nov 2025 13:05:57 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGzgY-0000000FX7t-2ldv
	for linux-nvme@lists.infradead.org;
	Thu, 06 Nov 2025 13:05:56 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-29555415c5fso12310375ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 06 Nov 2025 05:05:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762434353; x=1763039153; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mgw/fPrHMpJPDRmtQHXy3qFjXzsQgXrjXttBI0uY/iA=;
        b=l2ELsLhZKM9oas57FV5GoH32e7ipu9P9BnKIxwgwj+xnAPQrm3/p+SgxN/Cu6+mswt
         sKnAc8uf+305u9H+nQ+mlON4r3AJgU6yNlkmf4S65h+qrq0E4fs+MO6laKn6bj27uLuc
         7DiSTIW/HSon7uNxEdbQN5jGv+6jQHUZJGO1oThChsDyy63Iyd251E7g9zVuRG4eZ172
         jinsetz+wCkf4xcCxv60gyLUAdYSCn2Pd8kyuh5iAh91xAiBANAKvRg4OhdqyjuXeiGQ
         89PobtLfaDFX4fpy7gF+UwONHGPAZe0eMxxh3j8Qm0EAlbftn/8xPis0kvPEcHCOfcHZ
         IOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762434353; x=1763039153;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mgw/fPrHMpJPDRmtQHXy3qFjXzsQgXrjXttBI0uY/iA=;
        b=nS68JLOQpK1F990rhc4r6rWwlGGVEG9eM87a9txdJN8trBoeRKe+t/SS3R4X6CWSMI
         5c/eaV0iaA1lvjY2Vdshq+eYcR/GY8qazOLIlXwRNUP0aKkKdPta8W0Ts1ljRCGiJhNx
         ATbEPS+7pN/FpCyl5i/wUBXoMToxMywIj8yJc7sbtMFEzoX3qqzHGkfB9xHiWQBU6M09
         eJBPsaZyZKFpeth7kISX0V5rtoU/mg9RRMZM4pB6Q9tiuun5BlM+9dkX6vjI3lfZP4p2
         tPUhaz1fKbl4/5rkIgd1LeoXXxbVZc9gXAR2uhUMwOEpL044Q0MZD9AWCFrkFOeIVjCd
         IsTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcaxGZ/NUgZUzHvC87OMo14S9Jla2zKz9HgR5ZSuD68tBlva3if76vHX/ogi7eqHlAtOoff/XUn/iv@lists.infradead.org
X-Gm-Message-State: AOJu0YwIgJa+MLT6SGiwFLa0GmJRp4MQ26ybFPkHsNdjq/bg6eDkUWo6
	hUUZI5kbxPvW8rGUsetSRGgB+PVdIL7ni5LQF5psVCwvPxarDvkHZm05
X-Gm-Gg: ASbGncsnEQ4hvOtHgReQxwpJHfDM0J4qv9uAlbh/tcfhcP9/EUF+5K+rK4+wRF6kbhO
	Ob+PIllybVehehvH6zgj30JtBURGIyXwRb8/JSF0OsYIx61UV9OX/+TVa5Yq0+h/kq4QEt8A3lv
	B7PaRRszysxtQ82Sy0cUkuVHCcJCcRzJJ3z4nehKODxCiZICK/5Q1AMVpZhYMxBNpWzM8eCK7Cd
	gzXFZlozkTWgNcmxL6R00BAWwlzOWbd+39kHf0L0COsBm9fCDWc050/FBKkZ17rZkfCL5DTNWw5
	+yI0lPDGuFCNTBf+hRPMuHZPuSixI5oSE1LEnZ3/Y6CIK0e6cRWgPN6UsBXOZqCgPtPid8TWN2R
	mcZhcBqoGsFH4IAFJvwsbq5UXxDkJUpS0kgjSv9SPIajcP9KN1vAAaPr7bZO+zFPUpVd37msHm8
	hVSO/41ny1dgydpEQ=
X-Google-Smtp-Source: AGHT+IHqcc5CJfMeCuuz9hqI9HoVghkGsu7NtrT1o4XJ7ZdhguAZZC3/CDPR1sbAfdfYDDOUGTjUOQ==
X-Received: by 2002:a17:902:f541:b0:24e:3cf2:2453 with SMTP id d9443c01a7336-2962addb63emr97589505ad.61.1762434352926;
        Thu, 06 Nov 2025 05:05:52 -0800 (PST)
Received: from 10.0.2.15 ([223.185.133.51])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c7445dsm28265955ad.62.2025.11.06.05.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Nov 2025 05:05:52 -0800 (PST)
Message-ID: <adba53a05329dc8399c3bd49c7bcd5eff5e69574.camel@gmail.com>
Subject: Re: [PATCH v2] nvmet-auth: update sc_c in target host hash
 calculation
From: Martin George <martinus.gpy@gmail.com>
To: alistair23@gmail.com, hare@suse.de, kbusch@kernel.org, axboe@kernel.dk, 
 hch@lst.de, sagi@grimberg.me, kch@nvidia.com, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Date: Thu, 06 Nov 2025 18:35:48 +0530
In-Reply-To: <20251104231414.1150771-1-alistair.francis@wdc.com>
References: <20251104231414.1150771-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251106_050554_713492_EACC4CE9 
X-CRM114-Status: GOOD (  22.18  )
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

On Wed, 2025-11-05 at 09:14 +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Commit 7e091add9c43 "nvme-auth: update sc_c in host response" added
> the sc_c variable to the dhchap queue context structure which is
> appropriately set during negotiate and then used in the host
> response.
>=20
> This breaks secure concat connections with a Linux target as the
> target
> code wasn't updated at the same time. This patch fixes this by adding
> a
> new sc_c variable to the host hash calculations.
>=20
> Fixes: 7e091add9c43 ("nvme-auth: update sc_c in host response")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v2:
> =C2=A0- Rebase on v6.18-rc4
> =C2=A0- Add Fixes tag
>=20
> =C2=A0drivers/nvme/host/auth.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0drivers/nvme/target/auth.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 5 +++--
> =C2=A0drivers/nvme/target/fabrics-cmd-auth.c | 1 +
> =C2=A0drivers/nvme/target/nvmet.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A04 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index a01178caf15b..19980122d3d5 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -492,6 +492,7 @@ static int
> nvme_auth_dhchap_setup_host_response(struct nvme_ctrl *ctrl,
> =C2=A0	ret =3D crypto_shash_update(shash, buf, 2);
> =C2=A0	if (ret)
> =C2=A0		goto out;
> +	memset(buf, 0, sizeof(buf));
> =C2=A0	*buf =3D chap->sc_c;
> =C2=A0	ret =3D crypto_shash_update(shash, buf, 1);
> =C2=A0	if (ret)

This memset in host/auth.c doesn't seem to serve any purpose. Also
given your patch is intended to modify the target behavior for sc_c
handling, maybe you should restrict the patch to target side updates
alone.

All the memset cleanup in both the host/auth.c & target/auth.c should
ideally be done in a separate patch, and not part of this current
patch.

> diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
> index 02c23998e13c..f54a1425262d 100644
> --- a/drivers/nvme/target/auth.c
> +++ b/drivers/nvme/target/auth.c
> @@ -298,7 +298,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req,
> u8 *response,
> =C2=A0	const char *hash_name;
> =C2=A0	u8 *challenge =3D req->sq->dhchap_c1;
> =C2=A0	struct nvme_dhchap_key *transformed_key;
> -	u8 buf[4], sc_c =3D ctrl->concat ? 1 : 0;
> +	u8 buf[4];
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	hash_name =3D nvme_auth_hmac_name(ctrl->shash_id);
> @@ -367,7 +367,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req,
> u8 *response,
> =C2=A0	ret =3D crypto_shash_update(shash, buf, 2);
> =C2=A0	if (ret)
> =C2=A0		goto out;
> -	*buf =3D sc_c;
> +	*buf =3D req->sq->sc_c;
> =C2=A0	ret =3D crypto_shash_update(shash, buf, 1);
> =C2=A0	if (ret)
> =C2=A0		goto out;
> @@ -378,6 +378,7 @@ int nvmet_auth_host_hash(struct nvmet_req *req,
> u8 *response,
> =C2=A0	ret =3D crypto_shash_update(shash, ctrl->hostnqn, strlen(ctrl-
> >hostnqn));
> =C2=A0	if (ret)
> =C2=A0		goto out;
> +	memset(buf, 0, sizeof(buf));
> =C2=A0	ret =3D crypto_shash_update(shash, buf, 1);
> =C2=A0	if (ret)
> =C2=A0		goto out;
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c
> b/drivers/nvme/target/fabrics-cmd-auth.c
> index 5d7d913927d8..16894302ebe1 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -43,6 +43,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req
> *req, void *d)
> =C2=A0		 data->auth_protocol[0].dhchap.halen,
> =C2=A0		 data->auth_protocol[0].dhchap.dhlen);
> =C2=A0	req->sq->dhchap_tid =3D le16_to_cpu(data->t_id);
> +	req->sq->sc_c =3D le16_to_cpu(data->sc_c);

Given sc_c is an unsigned 8bit int, is there really a need to make this
endian safe by calling le16_to_cpu()?

-Martin


