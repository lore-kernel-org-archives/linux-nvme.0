Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD951125847
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Mar 2026 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0BIjwS+gbq180VGTzlx/TXLnnmlA29fWZpFQXzG3WGQ=; b=17OVs++5Llu1yRM9UP8hStkS9K
	tvCIMBZBf2KrmbPblGZ+394jtJwSs1TaQv8wpEnGtREm6cCh7KdCpJrlhpGkVaL22tfh9U6Uz26lY
	XSJaZt3ATey9GfQqCq3aqOv0S0YkCSQcnIeMzZcuIMbcV7yaFsDNI8uQugwscSPofJHbbN3oki6fm
	klrEfxFjNWFsi7MFW8zxqum+HhcsrDYsqSNRGvif1FCKJlVmamMSVaERCDUVXtaUJkHMc6brdjnw/
	HhcyKWEtf1ZsQw50LZmJa/5g7QxGBkUfS8toR3xoFVWljk1acksq0WW+LsUxNit59v0bO7imDhZ+y
	zueZc72Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Lmw-0000000Br5y-48Ef;
	Wed, 11 Mar 2026 15:47:58 +0000
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Lmu-0000000Br5Q-0dDY
	for linux-nvme@lists.infradead.org;
	Wed, 11 Mar 2026 15:47:57 +0000
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso480675ad.1
        for <linux-nvme@lists.infradead.org>; Wed, 11 Mar 2026 08:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773244075; x=1773848875; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0BIjwS+gbq180VGTzlx/TXLnnmlA29fWZpFQXzG3WGQ=;
        b=DBJ0t8+8oR04ks5sXZ/ISvX3q2GP/ww+MsPQk+mTXTq30irmz9fCVBIW44rkfbvAjO
         bhiqLY5XY9LBVCaLFkXjJhRiFx/2M+bASFSbF067YeC3M2bHQqmRYe+PsT8RO42QrVIc
         zYM0biKrwn1kZmQKZQ38Devt/lIO6v78+bLjl+qOCL2I8wxysEodUYhUA+vnsrIR/bPi
         wn+cj3pvKcNh0Z+TOcCHjzEez8p8fRIXTOkrAnRJE01iMcJMQTYRAWweHtet2TQAJIuG
         /K6pAZFruVNamN962XhZGJlcyL8gCClhoIoO966QzaJsMm8kzMfASjQL6HOrvSslPBNO
         081A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773244075; x=1773848875;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0BIjwS+gbq180VGTzlx/TXLnnmlA29fWZpFQXzG3WGQ=;
        b=ep4PYjx3GqmFE+7i7arvkZXEO0WzmWJ5q73XECOTG+cRnIGMQ4CkRMnORkc5poxQpe
         if8z2/bLAScR3p/SoqfwJgz++7Q1EMvHd6LMOyNVhc5cWVGjF39o025VJjzF/rwV/zzl
         V9RrXnioDXHZwioLYJKA9R0DyS3Zp0RJQPodh/QcRjo37P6kHH1PvwiujZbegctgBi8n
         QQmV3ZnD7w03sU2S3eD2VOwp61MbV3pVeLdeXIRmngH+SROpepO/6Dw+K6+6819Jbjzi
         RpDbu7hrlB+HcUHy7RUJNyrzmdN5ex4Yx6uMDFib2e+2INNXrZfh81N7Grm0jwUKryC9
         wC2w==
X-Forwarded-Encrypted: i=1; AJvYcCW4Bb8pQckqZPvfaHHCPCMg6AN/iMaPaHpSe4cnIAsKD3nCHeCPdedI/2Z7n45TvXmGovAbl3CSiewl@lists.infradead.org
X-Gm-Message-State: AOJu0Yxamw0F3/gHJVOSdIuJpy5dCzEcQIUvI3T66AP8xKyAWXu5/wFh
	iHpn62YnlvGNaBnXZbKpVNL86JLmIRiKSCsNBK2aobM5fchtt7wrDW6b
X-Gm-Gg: ATEYQzzUCGJLKAw8c9KgTxaGXVxWcBxyc1DaTviEceaJEP6eO1OVyi6zYvhb3gtznxe
	PTUnxe052RCiRtjd7vX1L8RR7tzwOozLQNVlAt7eQC0h/FaNfEkYoLvXGb5d7GwYmpb02Z5UuNm
	kMvYfFdgLuONShigqlJ+NEq3aybjawGk3ctmrMs2eiCSo/81wgW11yWllDsbrVE8qvClYXIIAJo
	hY+xp80ziJPRw0kE4YuCEcUAd/KtEN7Y1jdC0poHY2yhTEYv33zWPFnGdbrm7bHyTmaY/IvOIm8
	f7W/AF7GRp5JHLnbNBoN0SVIWyy7K4XNOh9zyAN/hQRhvKNV8LPKM4fGM4lrUggKVDxsMlGIFno
	iA2aEZHvmeOSIPBMhV2KJuc2R30/VT3S7VpPfsEvTu8swHSXmqBLNvqasQ4vPkutWXqhImckk7P
	hO3JqUDhg1WzVOWWffYM38iZjfmO48viQhs6P2
X-Received: by 2002:a17:902:ef43:b0:2ad:da28:98d with SMTP id d9443c01a7336-2aeae8ba653mr31681565ad.37.1773244074668;
        Wed, 11 Mar 2026 08:47:54 -0700 (PDT)
Received: from [10.0.2.15] ([202.3.121.5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae222944sm30058135ad.9.2026.03.11.08.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 08:47:54 -0700 (PDT)
Message-ID: <2fbad8b9c5e100bf04854b20b3790578fb724f89.camel@gmail.com>
Subject: Re: [PATCH] nvme-auth: Hash DH shared secret to create session key
From: Martin George <martinus.gpy@gmail.com>
To: Chris Leech <cleech@redhat.com>, linux-nvme@lists.infradead.org, Hannes
 Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi
 Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Eric
 Biggers <ebiggers@kernel.org>
Date: Wed, 11 Mar 2026 21:17:49 +0530
In-Reply-To: <20260311012116.2504291-1-cleech@redhat.com>
References: <20260311012116.2504291-1-cleech@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260311_084756_192686_688C62EA 
X-CRM114-Status: GOOD (  13.22  )
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

On Tue, 2026-03-10 at 18:21 -0700, Chris Leech wrote:
> The NVMe Base Specification 8.3.5.5.9 states that the session key Ks
> shall be computed from the ephemeral DH key by applying the hash
> function selected by the HashID parameter.
>=20
> The current implementation stores the raw DH shared secret as the
> session key without hashing it. This causes redundant hash
> operations:
>=20
> 1. Augmented challenge computation (section 8.3.5.5.4) requires
> =C2=A0=C2=A0 Ca =3D HMAC(H(g^xy mod p), C). The code compensates by hashi=
ng the
> =C2=A0=C2=A0 unhashed session key in nvme_auth_augmented_challenge() to p=
roduce
> =C2=A0=C2=A0 the correct result.
>=20
> 2. PSK generation (section 8.3.5.5.9) requires PSK =3D HMAC(Ks, C1 ||
> C2)
> =C2=A0=C2=A0 where Ks should already be H(g^xy mod p). As the DH shared s=
ecret
> =C2=A0=C2=A0 is always larger than the HMAC block size, HMAC internally h=
ashes
> =C2=A0=C2=A0 it before use, accidentally producing the correct result.
>=20
> When using secure channel concatenation with bidirectional
> authentication, this results in hashing the DH value three times:
> twice
> for augmented challenge calculations and once during PSK generation.
>=20

But secure channel concatenation is supported only with unidirectional
auth and not really with bidirectional auth, isn't it? As per NVMe base
spec 2.1, section 8.3.4.5.9 Generated PSK for TLS:
=20
"The host may request secure channel concatenation with the TLS
protocol by setting the SC_C field in the AUTH_Negotiate message to
NEWTLSPSK while performing only unidirectional authentication. In this
case the host shall still send a challenge value C2 to the controller
and clear the sequence number S2 to 0h to indicate that controller
authentication is not requested."

-Martin

