Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7EFCEBF61
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 00:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bkBaYmn0PwVoW+xjzEnmWu4VJvyj/VSjPE0mhzoh32I=; b=SVk0pUe7nyUWtEtTW8pbtbkKcT
	H93vhHe+P/r/P+jmfJoFZaS7FgUa0MsMKv5kSu+un32K17mGza7kxI547oUz07Yh20ASgMfjXz8Hg
	2QgS9Tc23NrYWaF9YuWnpgG1sFtPFGMsJnwOY4b6QKxV4GsyYg6Eotiu+kFjrKA4l5DVIoUpowTai
	B0zz9kcNMLk3WypfElSCXtnKqTuQRntnWfFAJ4XB9HkUEnaO7FubEm05CSMelL/D5e5aoLzUbOgwF
	EVGvhzwbDyL/+36iQJA3RbU/NC0U2FHpJtHsPz1f+kYM1v/7tVzmIY7xB3HQc9d/0WVIsWM4Oylum
	iSx5pTPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL9mR-0000000H38I-1taZ;
	Tue, 18 Nov 2025 00:41:11 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vL9mP-0000000H37l-0rkD
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 00:41:10 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-7aad4823079so4455513b3a.0
        for <linux-nvme@lists.infradead.org>; Mon, 17 Nov 2025 16:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763426468; x=1764031268; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bkBaYmn0PwVoW+xjzEnmWu4VJvyj/VSjPE0mhzoh32I=;
        b=R9UKvbRa0EKFGf4O8clj/onUqC10VkWG/f41kSWGXHKQvjrM1uqpFiJUHDgEaNdwiT
         mkeHyZmkIadEHL128yLuK7HxKxDJk5qArERRHARsGmLp2YF/eqXB41wbFVoFpJcPdNuS
         V2mhXCLiGv4REryYXvuA+esHU7gu9S1HDZ2ROTW1/bNtxG4m9/33bxunxos2Q4IOyb+0
         /aK3FCk8b0BU1WpLbHpi6uQgF0Wu/uGe7h0sTeQTDE7szzXqCKX1rRa67aqDCTjAH0ST
         rzxC+23OhGm6VP6WDqh1DiBR0d6AL3yU6D9zNjROObSSnsbjJygMw3bzxnEj1hdfXAok
         b0jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763426468; x=1764031268;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkBaYmn0PwVoW+xjzEnmWu4VJvyj/VSjPE0mhzoh32I=;
        b=EtI3OQuvyzBhUHO4cx/+/kGB2a9N+k2UGWuceBufJqDawBVU8Xow8xXxCi59Pp2sWc
         tECuGnH6c9PI2xec2klExuOQPRxlIAF0rxJ5wqfQWO8aYfmir1urZT00YoFHDeJuADph
         U5qXbWORXFJzC6UHyGPeUQuNp6bJ9P63vGFFuBbAH6fSfdWwCyqfDM+nN3GdNb0DMaJ1
         eo0nJ8Px89t52VZdPT50NQ4cH65ZS9FsEkwwxxtmGyFYqrwwEJKzb8hObV0Vrva17s3Q
         dC3OjvGhpq8a4a+tpi/EAlp3XNyFZsZD6RdfG18sCmjm8DMj5S0m28g10y9RIdSYR8aM
         /QRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxup8D302InOy4sSksCLfAcI2kr4uWlyAPrk9+8yKXGMfwOtQKa9dT+UGQG/8ecbVVMEttQ017yXAX@lists.infradead.org
X-Gm-Message-State: AOJu0YxOlptD4xGr2qSbnHbHxxLvEvUf3KrySZJXm0CZDg/7Mw9Kwvbp
	BOiTuhSvq7WHHYP0QPBXFvLQ9SsZA9+qVv3xq5kpb8hqY6EsU4ESWQrQ75oHTh6a
X-Gm-Gg: ASbGnct5Njl+6w4wD8RBvdbLTsmrKrQI1QDJM1Ia/Xpjwb9AQ+Q+qIMCyG2rEAGVN+5
	nRetaSCviVTDVQ7XNWLYgdmSi5AdxzjJnYZVytJuA0O8g5jEl2aNG7rG8awm7htwX/zdJUnEAcY
	XpyY9qqoKSE1xd/mGQmqOYXBvv4bESBKqj0ozJY5Ovnq9q0eU2MqnqeaHZOngtPjBIpZuzqMrzR
	uD/zG5YqLMWkf7iKuxf2FP2PvIDD4Hrvj7YueRAgDNPyMFTgY4kMTOaLNgzbfNZF7f3TYXtwxwd
	ETl8R9gye3zJsVfJ/uyr/0M3TG4rAF0XaJGEWLr/A0mWzj6KOdKDOubomMotx+Kh632ope7wYr5
	fAZKnhXbU6fzXBFRh6q2xgiXjTCoLVghLqAhFMaaEBaIXnY9EHux+3nMZmO2U/ViQXpZSCObywX
	2NEKAmpFRSehRD2ETa
X-Google-Smtp-Source: AGHT+IEM/yLUwXJP7N3P3WF56yw/23PQR0e+8cuU/GNlUwJVkJQrhfhISkf2JbYKy6Ip2DaGzPuglw==
X-Received: by 2002:a05:6a00:14c9:b0:7b2:1fb0:6da0 with SMTP id d2e1a72fcca58-7ba3c6729c3mr17383406b3a.28.1763426468130;
        Mon, 17 Nov 2025 16:41:08 -0800 (PST)
Received: from [192.168.0.233] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b9250cd969sm14475738b3a.23.2025.11.17.16.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:41:07 -0800 (PST)
Message-ID: <9d351634fd1324ed00830d7af1d0406dfffa261d.camel@gmail.com>
Subject: Re: [PATCH v3 2/4] nvmet-tcp: Don't free SQ on authentication
 success
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: alistair23@gmail.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, hare@suse.de, kch@nvidia.com,
 linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Alistair Francis <alistair.francis@wdc.com>
Date: Tue, 18 Nov 2025 10:41:02 +1000
In-Reply-To: <20251114045850.1898865-3-alistair.francis@wdc.com>
References: <20251114045850.1898865-1-alistair.francis@wdc.com>
	 <20251114045850.1898865-3-alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251117_164109_249882_1711FC9D 
X-CRM114-Status: GOOD (  18.09  )
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

On Fri, 2025-11-14 at 14:58 +1000, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
>=20
> Curently after the host sends a REPLACETLSPSK we free the TLS keys as
> part of calling nvmet_auth_sq_free() on success. This means when the
> host sends a follow up REPLACETLSPSK we return CONCAT_MISMATCH as the
> check for !nvmet_queue_tls_keyid(req->sq) fails.
>=20
> This patch ensures we don't free the TLS key on success as we might
> need
> it again in the future.
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
> v3:
> =C2=A0- No change
> v2:
> =C2=A0- Don't call nvmet_auth_sq_free() in nvmet_execute_auth_send()
> either
>=20
> =C2=A0drivers/nvme/target/fabrics-cmd-auth.c | 9 ++++-----
> =C2=A01 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/nvme/target/fabrics-cmd-auth.c
> b/drivers/nvme/target/fabrics-cmd-auth.c
> index 2e828f7717ad..0cd722ebfa75 100644
> --- a/drivers/nvme/target/fabrics-cmd-auth.c
> +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> @@ -397,9 +397,10 @@ void nvmet_execute_auth_send(struct nvmet_req
> *req)
> =C2=A0		goto complete;
> =C2=A0	}
> =C2=A0	/* Final states, clear up variables */
> -	nvmet_auth_sq_free(req->sq);
> -	if (req->sq->dhchap_step =3D=3D
> NVME_AUTH_DHCHAP_MESSAGE_FAILURE2)
> +	if (req->sq->dhchap_step =3D=3D
> NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
> +		nvmet_auth_sq_free(req->sq);
> =C2=A0		nvmet_ctrl_fatal_error(ctrl);
> +	}
> =C2=A0
> =C2=A0complete:
> =C2=A0	nvmet_req_complete(req, status);
> @@ -575,9 +576,7 @@ void nvmet_execute_auth_receive(struct nvmet_req
> *req)
> =C2=A0	status =3D nvmet_copy_to_sgl(req, 0, d, al);
> =C2=A0	kfree(d);
> =C2=A0done:
> -	if (req->sq->dhchap_step =3D=3D
> NVME_AUTH_DHCHAP_MESSAGE_SUCCESS2)
> -		nvmet_auth_sq_free(req->sq);
> -	else if (req->sq->dhchap_step =3D=3D
> NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
> +	if (req->sq->dhchap_step =3D=3D
> NVME_AUTH_DHCHAP_MESSAGE_FAILURE1) {
> =C2=A0		nvmet_auth_sq_free(req->sq);
> =C2=A0		nvmet_ctrl_fatal_error(ctrl);
> =C2=A0	}
Reviewed-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Wilfred

