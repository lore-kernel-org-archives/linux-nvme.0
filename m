Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B460C369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 21:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4sHVWUSVyu7qyPR+9bG43YKEKJ9PTMaIdTn4+x+dWuk=; b=Hn41p2a1NsWgaEwgHbusSGthh+
	BaAXzNvltlrXdk4utJQSY8icA9cDIDQooOx+NmVh6hfAS/FY5e3IhBZbi3KicWtqfpeqszMqhK9gs
	z0fMKssZQX9yJBCnEdmKtBfgzYY+VWcuAlmti5NsfJpNYGFmLE//Ey7npHz16r0MD1SVlPBhIUyho
	hcJ3ey2QXIQdACA3HDmxKEqTTX4J8rpZAB2M4U5FC1mWn/RGU14ic04U1Nh344bwjAhBIIMxeNB3n
	W/HMyRqYOqz1pA4l28nVz3QuYyaVazIiAKjp/jCRjQg8ODsiM/VUcAeaIWY5jfoQ42Yfdz0dOM1l3
	GhZuI10Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7hwK-0000000C89r-1luN;
	Wed, 23 Apr 2025 21:47:32 +0000
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7hwH-0000000C891-2Ce7
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 21:47:30 +0000
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-5259331b31eso157627e0c.0
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 14:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745444848; x=1746049648; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sHVWUSVyu7qyPR+9bG43YKEKJ9PTMaIdTn4+x+dWuk=;
        b=C3zL3cT68qFilImywljkEHoXNyUrqtSkPDaE1PlTfEg9rqcOlopgsoh/gsGsiX2g6l
         GSk5ZmTNP+DTKdIzEZ+bmFaTKLcHT7nJfbjvAekXdYcKnSPAmlJIeTleJyr+iAwiw4Uc
         ObeRtAqnl4SXMIVSCXQphY2zRSDglSoec2y3GlXoz33ZdDfMwfG+o+wG1irfb5LQfVYT
         wcEGDQBjahld5kkztpnFaNQQ/fNRmzTZZ2wGNn/Bv6dHTALTxpCHwitm19KZ1xqMnjB0
         SN9o+XgU0MYOIFnH+mo+AQnZNdFPnvJvk4+NNT/+kCvEAYunv0yrqu2J6PQtZImYMG4j
         Hm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745444848; x=1746049648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sHVWUSVyu7qyPR+9bG43YKEKJ9PTMaIdTn4+x+dWuk=;
        b=DLoyjjRwPwmt9uX9Y7rlvvnbOetzev1701cQdmxdzPDjisMl5ihJPbeQXG3NbGhWUX
         YaHszbvv1jMieO2C6YRJd5VXZhTArkLXa2IDw/zFVDdQ88DBD03Oa7qocw9FbiMvVTtG
         nfmPZQ6EpAlkFMx9TyNqTBgTSz0oLQ8WR7Afxxv9eF9Ko1d4SX5SOCICBvTUqwwKnEtK
         042k/MopzhNKHKxDxcvCo6ED79dvLcrt+1mE/gtQForhhLVkYJZ8HmRDsXMTieb///Dm
         DX0GSdqWLax1P924bTFcBlFiRKPjCHj8fRA4QKYk909QepkrCtjucQUFQYtMyYDhnwEX
         2wtA==
X-Forwarded-Encrypted: i=1; AJvYcCWVBoie+chkoGGnInlfQotRlu0E+W9QW+icggJmMjIpBORxD6lKfxDCNYF0yl+O5ktv+ICBDT1jrK8d@lists.infradead.org
X-Gm-Message-State: AOJu0YwKT85M6fhW+SPJerCPTL31b7izHQ4hsUQ4xBIYrf/rG9Hd33JF
	oiACfYYj2cuE1pTvXheX3ctJu0q5EXxuwVr5LzItzhoAOuCUu6xLeDo3qfaJTQx2mYp7Zk/9iQo
	H/QzBlKI//3C72hdHLxxBMb7ozCM=
X-Gm-Gg: ASbGncvJjzLx3fFH4XlhHroufYvgVLfoyMw2fcndeAKw45x8L4kWFifx0c/YFRe+Ldd
	NXXkeOsi2hwj3k9nGygA7624nw/1Hvu2xG6EKRkArUDuHB1exx+FAdct88e6WFkU59XnnDCSAh/
	AylaJFlVhHyqBXaCltLX6wHdEd3a7nSyi6uwnMoA2/cdiH+9yUAlH1
X-Google-Smtp-Source: AGHT+IF1Iw5t9hIYip1CYltVWmdYJ9subH9iIWt8HpCybfCDBINIFXFCY1WqE4CgkdnqUxg4T6q0MF7Lmw2+cM/mRaQ=
X-Received: by 2002:a05:6122:180f:b0:520:64ea:c479 with SMTP id
 71dfb90a1353d-52a783e4749mr321968e0c.10.1745444848135; Wed, 23 Apr 2025
 14:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250423060621.632581-1-alistair.francis@wdc.com> <ed993f55-bdfc-4376-951d-9af4a4f461a9@suse.de>
In-Reply-To: <ed993f55-bdfc-4376-951d-9af4a4f461a9@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 07:47:02 +1000
X-Gm-Features: ATxdqUH2fZjFHI9UHeN90ujII4BDW5G2U9I0iPmpwtdIW_mJw1I3eq2hy3v057o
Message-ID: <CAKmqyKOBOCV=mU0BRdZu2vPzx-+3fkp7qJXiTXF7dPM35eXguw@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: don't restore null sk_state_change
To: Hannes Reinecke <hare@suse.de>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	csander@purestorage.com, shinichiro.kawasaki@wdc.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_144729_566242_5BC54C97 
X-CRM114-Status: GOOD (  15.37  )
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

On Wed, Apr 23, 2025 at 4:21=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 4/23/25 08:06, Alistair Francis wrote:
> > queue->state_change is set as part of nvmet_tcp_set_queue_sock(), but i=
f
> > the TCP connection isn't established when nvmet_tcp_set_queue_sock() is
> > called then queue->state_change isn't set and sock->sk->sk_state_change
> > isn't replaced.
> >
> > As such we don't need to restore sock->sk->sk_state_change if
> > queue->state_change is NULL.
> >
> Good catch!
>
> [ .. ]
>
> > Resolves: https://lore.kernel.org/linux-nvme/5hdonndzoqa265oq3bj6iarwtf=
k5dewxxjtbjvn5uqnwclpwt6@a2n6w3taxxex/
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> > We could also remove the `sock->sk->sk_state !=3D TCP_ESTABLISHED` chec=
k
> > in nvmet_tcp_set_queue_sock() if that's prefered.
> >
> Please do.
> We cannot influence what the network stack did, so if there ever were a
> modification which caused the ->state_change callback _not_ to be set
> the whole issue pops up again.

If queue->state_change isn't set for any other reason this patch
should also work, but I'll remove the `sock->sk->sk_state !=3D
TCP_ESTABLISHED` check as well

Alistair

>
> Cheers,
>
> Hannes
> --
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

