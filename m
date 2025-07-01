Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09D1C83038
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jul 2025 17:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dv8SFnw4QHK9Vp9igw/V0WvSsJQ688rKknXP7/SQp5k=; b=dmLcyvAkn+z716PvYI4hNwSC+P
	waSd/GF8fOQPqmdvEOUGVDYKfbsdYkt32egczWeadgIUWR20n4dW4dOEF41fOZASfDLOV4sf8HW9G
	oUvWldUE6wqen+OVljwMweHG6lrzccMdUIYOgk/WuEEuVXQEvACPs8yLxup+awCUEhcuebcl4BGEt
	M5A+3opb0t/x6COlvujlz+0FT+r/1dybr2pPnrHyq++iWfXKTfCABV9y9h7BS4HQgWh8fGpKCUgns
	j5hk3iLechUkncuTKZtB3vnvcPYXrvZH6o/vTkHi7zkBLtGaPtK9/L31TGWk4JgsSIhkK6RUz/OG6
	iq69BdOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWew9-00000006FY7-1nWD;
	Tue, 01 Jul 2025 17:38:29 +0000
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWcSv-00000005oXj-47z6
	for linux-nvme@lists.infradead.org;
	Tue, 01 Jul 2025 15:00:11 +0000
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-ae0bde4d5c9so1055732766b.3
        for <linux-nvme@lists.infradead.org>; Tue, 01 Jul 2025 08:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sigma-star.at; s=google; t=1751382008; x=1751986808; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dv8SFnw4QHK9Vp9igw/V0WvSsJQ688rKknXP7/SQp5k=;
        b=rCE751SfptlbUNVU6t03rugg5QBxtgL7gCDjCyDAEHcdXAFBQYgqWfJk6INmujBewd
         gNuZXa2pIBVE70+vR6ZVPbPOStie3eCidBPWNMYoASEkhsrz/46/oBYSW5ldwJoL7av3
         UI+1fPA+JNt1KVaXlTe8CoO9jEkZP0/wKreVBojMh0pYtoFSeIrU70xMvCwjrFZZd0Bi
         C3MI9maVH7BvS4Sxe6Vguce+z+RTPqJ0qULh9A+6NJqZdnvoqkp5pFA+bdyscWL9V8jB
         LgIthC9dmNjkd32NgiEm21EIyadRAMqLJVQBE8Q3WYLL3uxd3kmn8CIS5VaUeUAuP00r
         ocnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751382008; x=1751986808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dv8SFnw4QHK9Vp9igw/V0WvSsJQ688rKknXP7/SQp5k=;
        b=kRinYgev1vTgc1EBe0iYpbHS/aZBiFEFJ04QmBVA++whiLV/XlsRV+Z8TOBYsLmYSV
         r795XVKXjP+Nl8jgt2Vv6EnYL0UNIzd4remCgdnbEsg2Fwanmct3CyX4tGUbKOosuxdE
         /gJxqbVgKsd9bNmmLHLI3jr2jCONWinHrvIGE7ntwUKzDF/hIOCBfltSx9Uhub3CiFD/
         uTbv8uy6KUQuY/b1wbNOYN7+X03bxQBJNkSkWyRrSi58Uoglln+tS5uzKANI5yN0Cjg3
         msEPoJ5apjzHNPlR+5lFsntkj6u0GoWxm9EUhb6fYYZ/MKicmOlzhKC0TqVoBlXMGdBi
         aXOw==
X-Forwarded-Encrypted: i=1; AJvYcCVlmZNzUvTG9dH7JnX01oidx8I/26Vie7YPcmF3/yYP4So3x2TaNeyB0vmM6yLiyzqmDy3/IEwVpN84@lists.infradead.org
X-Gm-Message-State: AOJu0YzyhqMVbT+kKhKpxjHw8BBHpsfSoKdOcBWoNwVV4SncOdzhs10r
	D42UIgSlZjgX8VHQKgihj3xXf/PmHP0xgm5Os8PjKXvNrbT5nPuyVchoQefQnAeE0d4=
X-Gm-Gg: ASbGncsbMpIq5oj1Jkv7HJVs3jxBOR6fcz8y5sjwWR9TxKqn6l2PhU1dP6oOZtQphBM
	qYY8u8r5/dWCd0QAOZRGNx7BtBThpE289qkbdeRU0KCgcObb81wlQ/E1K31QTLLNMv9dR6TKtw4
	3qGay0du2L0WHrQFv8ii3MetcoMSUMbMAQ9sEY2ZGDSaM6UMK9lbOQA+WBn7ByIGXHZODk9dUuH
	9/b/zgXFDqKnkHqN7Nje/ga2Q6ciDhnrOZPiw1YyCL3HURn+Dfz+U9rJzNi1BisFQPyuvQk3Gow
	bxwTSsQ8GvTgxFaSzenmKCgSpI8YlwNuuyVkEDfKiBRu6ex/Ccb5F2faEziEF4USBx5ubwICGYT
	ChCoEsDREe5tZI9ipfl5HzTZVGjs=
X-Google-Smtp-Source: AGHT+IGLFOb6fzmYCObV2ho5rVZPNSLZ/sa1I8TTloyJ53XBAnONtInDSsIdE/gqk3mJlbCtA06oVQ==
X-Received: by 2002:a17:907:9d17:b0:ae3:5784:2b44 with SMTP id a640c23a62f3a-ae357842c32mr1267444766b.33.1751382008065;
        Tue, 01 Jul 2025 08:00:08 -0700 (PDT)
Received: from somecomputer (85-127-104-84.dsl.dynamic.surfer.at. [85.127.104.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b244sm883840266b.30.2025.07.01.08.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:00:07 -0700 (PDT)
From: Richard Weinberger <richard@sigma-star.at>
To: Richard Weinberger <richard@nod.at>, linux-nvme@lists.infradead.org,
 upstream@sigma-star.at, Damien Le Moal <dlemoal@kernel.org>
Cc: linux-kernel@vger.kernel.org, kch@nvidia.com, sagi@grimberg.me,
 hch@lst.de, upstream+nvme@sigma-star.at
Subject: Re: [PATCH v2] nvmet: Make blksize_shift configurable
Date: Tue, 01 Jul 2025 17:00:06 +0200
Message-ID: <3078386.UTt5R2Mg1o@nailgun>
In-Reply-To: <7c5b852d-4f29-41c7-a171-c0069771a5e0@kernel.org>
References: <20250630191341.1263000-1-richard@nod.at> <2920993.eCsiYhmirv@nailgun>
 <7c5b852d-4f29-41c7-a171-c0069771a5e0@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250701_080010_307709_2D2B5009 
X-CRM114-Status: GOOD (  22.35  )
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

On Dienstag, 1. Juli 2025 09:32 Damien Le Moal wrote:
> > The initial intention of this patch was exposing the blksize_shift prop=
erty.
> > If we want to expose this as more user friendly, I'm fine with it.
> > Maybe "minimum_io_size"?
>=20
> That likely will be confusing with the existing device limit io_min. I th=
ink
> block_size is clear.

Ok!

> >=20
> >> Also, if the backend is an HDD, do we want to allow the user to config=
ure a
> >> block size that is less than the *physical* block size ? Performance w=
ill
> >> suffer on regular HDDs and writes may fail with SMR HDDs.
> >=20
> > I'm not sure whether it's worth putting more smartness into this logic.
>=20
> This may be nice to avoid users shooting themselves in the foot with a bad
> setup and us having to deal with bad performance complaints...
> If we do not do anything special, we will be stuck with it as a more
> restrictive setup later may break some (bad) user setups. That is why I r=
aised
> the point :)

Detecting whether the backend is an HDD should work via bdev_nonrot().
So, we could issue a warning if bdev_nonrot() is true and the configured
block size is less than bdev_physical_block_size()?

> >> I am confused... This is going to check both... But if you got STATX_D=
IOALIGN
> >> and it is OK, you do not need (and probably should not) do the second =
if, no ?
> >=20
> > I was not sure about that.
> > Is it guaranteed that STATX_DIOALIGN returns something sane?
>=20
> If it is defined by the FS, yes. But it may not be defined, so in that ca=
se,
> you have to use the fallback of the bdev block size.

Ok!

LG,
//richard

=2D-=20
=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8B=E2=80=8Bsigma star gmbh | Eduard-Bodem=
=2DGasse 6, 6020 Innsbruck, AUT UID/VAT Nr:
ATU 66964118 | FN: 374287y



