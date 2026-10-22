Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E950606A319
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Oct 2026 13:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=majMIJ4U;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HuWW4I4v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Nvs/O17pBoFT0kP/7U9Lwrf/xlPxuaSLW8PaLqTw0yk=; b=majMIJ4UkrPfkG
	txyMpf5icn62j4v69zNlKHIslinQkU/w8zxsYmSJrxVkD1E6wsnx18Af9VJlzzVfPcHGsEpCbs/Su
	xu7pl3yzopIpUSksfUeKgTUb3fEmYw2q15wJupwEVq9MSJcdFZCslHRxF0lj9wh9NKjt5jZSADcNi
	N8q0512hBSEvWSrbMicbAGdWW7inBM9+SRZTjNpSFWrKjswQCLktr07v8amUuTbUMjS8v1841J2Ck
	7Eq9DCbWGRRKu9LE9EDYXWIa8JerHQ9yZDFrmNpQ3EgMFykndgkgSPsU8X8qAD2LZtEV5MuV1E+kJ
	df9sTpA/94J8pis/wdyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJspz-0000000EB9f-2xee;
	Thu, 22 Oct 2026 13:28:07 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xJspw-0000000EB7t-1h0m
	for linux-nvme@lists.infradead.org;
	Thu, 22 Oct 2026 13:28:06 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-6b2232d8ef5so2952215a12.3
        for <linux-nvme@lists.infradead.org>; Thu, 22 Oct 2026 06:28:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792675682; cv=none;
        d=google.com; s=arc-20260327;
        b=a2t+bpvZu6DRemkI+8sglAJzGoIjBANiWJaRfXWDNjXIj2RjSTuE/mWJNY4hYLclFL
         JfUdMo1mBT3F4uSZUzxGlTn96xNvVMAukX78WtQdFIkG/TWldJcssamYcg+zY++CL3B6
         Snga5RpJ1jAj8Ynf6JC5vN2kB3s7MgEpVGr52MRO4cEJd+x6iWaYuo+iiMtr/xxflrHs
         LEmszIMI0KyhEBD6htos7LQQKuZJ6DY/QHVezZyhNyle0Qz260fHq0cSqGRG9K9KpDNi
         b02TYjMd765UDGlIgO5Z6mqZgcjR6bB6n+TlLOOalmg2bH/CJRp9qe560BpqA4M9FXUG
         vNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Nvs/O17pBoFT0kP/7U9Lwrf/xlPxuaSLW8PaLqTw0yk=;
        fh=VQDaMuoxkcKZ1z4JiIGwB7UT443Y+H2u8jdfbtdNPs4=;
        b=m5xnGmBnaWEnq0AmuAXcDALXl67pYkwYvjuK0Ab04z68yCrJjtCtkX5nSG7BJ19vZx
         K2d0cuwcnVacgf360Q229cILdXJIbMbjEG+m7S8Iqbh5YKvR4QMVPpzrXaYngaHDg51X
         U5AhBggmnluva+81Cq5hdz9KaKDtMoxn6GY6xZgopirk5IujIBeqhOMUxhvE3VQavLTL
         bje0s5rpSCwjtjmF5gxpJg6pQDRh9ADeZF44yn8JvqP+EP55ln0TBJ2LnFPCteEh14MN
         tXG7g8MIWFBwcizC0qlugjPsIBZbroynPRqs7dEM3GhM3+ib+U7VJlbSFnXpmcLmuykT
         TPEA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792675682; x=1793280482; darn=lists.infradead.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nvs/O17pBoFT0kP/7U9Lwrf/xlPxuaSLW8PaLqTw0yk=;
        b=HuWW4I4vo41UlX25Bo/QbdJTtdTgBMFR6hDDlPeEoAc+VC3I3qlIlF4xTqMb6qGzwk
         iERl4qLq9R+9dWhOYcUhUNY4q07PHhMLmVIM+eBLpEP5Ksq1UF8eHT0MMnknJBr+sZCW
         ch75gmDJLKbAOYT6J/qzZYhbPE3LiNQgVv5VsJdPiy6ykp6T+mOF90obDvd3Gm00OYcb
         1d6Tnl5z4eDYckCdyTprgUmOBr4Auyyj63iwm1+vYUxleQV9EQMPQ/UhTOi/inZeRyIu
         tok5qeuWC53vy9L4Z4QZQt8U3gP6Pt5HAIvBIVLDjgsX+yo16yE7Kb6lcYlko5f9gbP7
         PZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792675682; x=1793280482;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nvs/O17pBoFT0kP/7U9Lwrf/xlPxuaSLW8PaLqTw0yk=;
        b=dL4k/3kLKESFc7CiJoPTMTMDsvXjTO8MvHJwI+5kEWGAv8/6jbrgtUQZxQBWGvJy2v
         0Ve9NB9V93Wo+DVlVJulhR8JuTsGdE+X5Qbib7g8APd3e5psLEr0r6rLVtYRRHlMsse0
         hUhQAu77XjJg8K3zSXC+6DrFzEsD/4WJvnSTBKD9zjgVYeCvoralYcLp/CkW/I3UoAvt
         64XFTTfzFKR/XqI4G2ZJwBEeNx8noI4TOCn00ff4gMGKO15My+WpfT1j+Lu8X/I5Nr3h
         bK9IlK5+/URCL/clGO+3tFxockI2z2NrWL5Ph0PpFwaKleep3SztTh1ZkGgc4+engPOv
         msug==
X-Forwarded-Encrypted: i=1; AKwUvBx0Vgm04ATKun9pQ/ZQYnSDTbGSd4rkeindIvohuyMiMX8Q6VJ6ygkZush2r5YiXZUjW0rH9g1slOwX@lists.infradead.org
X-Gm-Message-State: AFq9FYK3cIJB0J9YB4tJqXphUljtK3f3zJ53eC1WIn8SWEFRM2h/ZfWL
	jNVrw1wPt8mood+qCm2PbD7aJUM4ixVeIoENopTTSIXAjJ6tl2QTD/9nU1CF4IlzmMKxZzJVl+k
	vbVcfCMPqsrCuBRdjwZD6+mHaC6fuldA=
X-Gm-Gg: AYBFou3kads9A47ItJfN24E4kzVwsakCswXiZL5ERsL/xXe3jURk/N0WWuJkzHIIeyS
	Bv4k4ng5Kr/QyVMWO8bhm5FnkCOYeWOoJ4xfVHxohXNsqFmWbQf4UOCjdkchhGkMEM5zYoBMPII
	l//uGHZsReg20+XIC5z4rAYs8uNCz9IM+NBUzGctVbYtQgHHGd6MtKlCktRFEaWQHqjJfhC13i8
	Fhce9tymdzyixTgqZPFbx/svsGLvngAXINayeL37tb+HqZoZaSd1PZkQ7gQQOX24UBjNDGbStPs
	SLTAM3DKVVwWDai1WaHUCbt9VcHhm46t5p37MQKozlriXTLJAxVUTjQgXTCcAkCB2lw/sUJlFXN
	Nk4gpDBAsScM/uniCm5VYu3o4Sn85L6voNrhQuw==
X-Received: by 2002:a17:907:7f91:b0:c43:a881:3f4b with SMTP id
 a640c23a62f3a-c4679a3c145mr527773566b.47.1792675681566; Thu, 22 Oct 2026
 06:28:01 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016141208.2641974-1-e.velu@criteo.com> <atJXYHJa4jkUWJmP@kbusch-mbp>
 <CAL2Jzuz1qFwLSA=iivp5qLCTL6-4rvKmvFzJbOQzjPu6j_7Y2A@mail.gmail.com>
 <atJeazM_rJ0uj3vt@kbusch-mbp> <CAL2Jzux8v6zCxfcdd=MY5n0zQMVSa-_8Lki9z-fz7bFShNf7vw@mail.gmail.com>
 <atJk_2FmzjUZYO_Z@kbusch-mbp> <f665dc3e-fc5c-4352-8e41-a46b7ae97946@criteo.com>
In-Reply-To: <f665dc3e-fc5c-4352-8e41-a46b7ae97946@criteo.com>
From: Erwan Velu <erwanaliasr1@gmail.com>
Date: Thu, 22 Oct 2026 15:27:50 +0200
X-Gm-Features: AclHuK87xiVvc2aaK_iFmR5Fg-1RYRhdWb9X02-8msYtLG7XVWJO_DadPavgGY0
Message-ID: <CAL2JzuwuZp0gg1D7wSn7cdgpnhotnuLP6YpPd-SrdVyqhkeiJw@mail.gmail.com>
Subject: Re: [PATCH] nvme: honor the volatile write cache enable state
To: Erwan Velu <e.velu@criteo.com>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org, axboe@kernel.dk, 
	hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261022_062804_461420_DF036DA1 
X-CRM114-Status: UNSURE (   9.42  )
X-CRM114-Notice: Please train this message.
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Le sam. 17 oct. 2026 =C3=A0 06:25, Erwan Velu <e.velu@criteo.com> a =C3=A9c=
rit :
>
> [...]
> > Unfortunately, no: there are contradicting statements here.
[...]
> If you think it makes the commit message clearer, I can send a v2 with
> these numbers, the kernel anitly, and the driver level Flush latency abov=
e.

Hey Keith,
WDYT of these explanations and additional details?
Hope that's better and could be considered for inclusion in the next
releases, maybe as a backport to the stable ones as incorrect
detection of the volatile's cache status can lead to severe
performance impact on this type of drive.
Erwan,

