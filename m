Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3D00CD4F37
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Nov 2025 02:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZRaD/fmerrjCeoqkuiGO/IO5MiZ5XDL7oIGJfPfg9Ao=; b=ot6w2JO9Ws+m+aKer67h/a+Coz
	EHAiybvxggnAAVIAckqyVa1tjSe8Hcj/0nooW0cvFDBZ05eYT/zLfvvDJTNRR3CCPSHSivtkOeAM/
	gnAMJIVjH/9lK425NoOK3I9L2v8QmejDv9hdJIv9Kf/s3CrFN2iuB/g/ueQOMCcwgPDFp2PimsPZG
	TN7twswz5Jbma/NIgght/15IGX069hZui1Nzj5Oa9EG6U48z8LRd+YCCdwCFObTt8T9UZZkHOgZxj
	7fZjc1MYUdPdvQmEZXOTLPI/zXLI1aaZCzeLChO5IpdK4L0w3qf/loyY9RC0XkiD1D0fjSVEXE/Ee
	OYb/ytew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJMtG-00000009n0t-0FJ5;
	Thu, 13 Nov 2025 02:16:50 +0000
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJMtD-00000009n0W-1A0K
	for linux-nvme@lists.infradead.org;
	Thu, 13 Nov 2025 02:16:48 +0000
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-787da30c53dso3257817b3.0
        for <linux-nvme@lists.infradead.org>; Wed, 12 Nov 2025 18:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763000206; x=1763605006; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRaD/fmerrjCeoqkuiGO/IO5MiZ5XDL7oIGJfPfg9Ao=;
        b=VxVZtKU7ae5Dnmw2CgVVJys/tkJCVOa47xFrv7qVBTkJ65uCfVQ+2m7SMhHaWL4zD4
         lsNlvnanLF6depbJbO8EGh6vj4/mwoVGLCMlksgNZtw6QpCuS/jAtDy3VGUL0dmCghsX
         SiauYHrsUMacC50lNDItL2tKd4ZNfyCVJ+1mDyx5j0Bmfmoh5pA/u2HJcWQurg4+lEyO
         Hlhdyqe0vnemLhyyvYIMefDN2rnuJtZyG99QTbyGW3nAg5m0reSsmLzzAjlZLQPjI4eO
         5cUHS8+XfLEBuItxnc7NK2J16RBlq5Zeq9PyuCRyM+0LGIrxMOD3X9DNmkv/ypptqYFK
         OfsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763000206; x=1763605006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZRaD/fmerrjCeoqkuiGO/IO5MiZ5XDL7oIGJfPfg9Ao=;
        b=vRcoffpZ41UIVj5aYczyhwsSXzaIWvajGxUyFOcyVWfk19Y42A4nhXWEZCSvEUZitn
         tHtYFjQD3X5f1HuUuOlR4ZdZ7sCIhXJeLE9CSetw/Xx0uOJMisHcm/Vak3XsYf7m2AY3
         oli3RgarpeIDu9aad9vdbmqrwvC7QQ3rAF0RjDk6opvRZ4ms8787knaONZVZ4M9RatD0
         6gO3OTJOOgqJ6dtLYI0tWm37ce7b/+pnthI5FnCFv2Yvo8EW3AMgHkuJqN24YCnS607V
         uOYBesCSPSy7fImJ1cLiQ30lcEAKldb2qvisLGlCKEIfxffgAyKhuMa9tbF7y201BuK5
         6PPw==
X-Forwarded-Encrypted: i=1; AJvYcCWJuKqyAdyxNpenURwDOi42nb0NChaGUrLW53X4C2w81H4Qf0moarhQGvAYjzSpMTy9FSlZG8D8++tp@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9A8BGCXMN3Psu/rvpsHxbzb4BsZtGnJCm26T0njgzxNxGCD02
	udpybG1xBBW51FqX8vcGMBzCTODX3mW87O+UcEzEbfLr16NoQbY7uFOfJlFw/dHv9clWCiDjKeK
	nY2FrYYJHeMejD7gxnCmwWGW1F19H1GU=
X-Gm-Gg: ASbGncs/MpibZGp0Rul1gYanhI9OPpi4QHZuxooXza+vIBjZxDGF6z7T0g00tgA8EH1
	9J6blL5Y5U79zAKr52EjWDItnN7SaX0y3Ri/6Ym8U576OrHz6d+XxyX3yC3jSo7yC2qDMFI9i+j
	+mv1iuxTgVFnG3VY9C+aH/5IOXjVzQGyzeLXlb50mQduRT7xK+y2XClRqQ19Wub+zTENq3Bu2io
	brntRf8DbdleuVqApbPfNx3WyUzY0jFGDf9VERQac1qcFzdOL7hmwyhtcJyZ9gW7odvHu9h18AA
	H2fA93Zjzrdo8f9x7qx/mVg36A==
X-Google-Smtp-Source: AGHT+IEoQGXbDOXpCMV0uLppel/d5OJBdh/BTOE0WrwFdCg3bNRboPUEkEHpLZDtG4hlmvXsyGaHqhvMoipnvR4oKDg=
X-Received: by 2002:a05:690c:5301:b0:787:f72d:2a57 with SMTP id
 00721157ae682-78813626ef9mr34068247b3.15.1763000205991; Wed, 12 Nov 2025
 18:16:45 -0800 (PST)
MIME-Version: 1.0
References: <20251112042720.3695972-1-alistair.francis@wdc.com>
 <20251112042720.3695972-5-alistair.francis@wdc.com> <3438a873-bda2-4a1c-af8c-76e31a200c79@oracle.com>
In-Reply-To: <3438a873-bda2-4a1c-af8c-76e31a200c79@oracle.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Nov 2025 12:16:18 +1000
X-Gm-Features: AWmQ_bmGVjeLJyvzqCH0oIhjJJEC9KDxsd28wVqF9yRjrr2nfAiVpGZrrJdTjQw
Message-ID: <CAKmqyKOj_vB3dwy2CO2JacL-w6WSm-2HYHuikndsLfYCQvwZNA@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] net/handshake: Support KeyUpdate message types
To: Chuck Lever <chuck.lever@oracle.com>
Cc: hare@kernel.org, kernel-tls-handshake@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-nfs@vger.kernel.org, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, kch@nvidia.com, hare@suse.de, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251112_181647_346387_630D4D4E 
X-CRM114-Status: GOOD (  15.33  )
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

On Thu, Nov 13, 2025 at 1:49=E2=80=AFAM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 11/11/25 11:27 PM, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > When reporting the msg-type to userspace let's also support reporting
> > KeyUpdate events. This supports reporting a client/server event and if
> > the other side requested a KeyUpdateRequest.
> >
> > Link: https://datatracker.ietf.org/doc/html/rfc8446#section-4.6.3
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>
> I was not able to apply this to either v6.18-rc5, nfsd-testing, or
> netdev-next, so I can't adequately review or test it. Is this series
> available on a public git branch?

You might have missed Hanne's "nvme-tcp: Implement recvmsg() receive
flow" patch that is required, it's mentioned in the cover letter.

You can find this series, Hanne's patch, a few other patches that
are all on list and some extra patches I'm using for testing and debugging =
here:
https://github.com/alistair23/linux/tree/alistair/tls-keyupdate

Just remove the top commits from that branch to get just this series

Alistair

>

>
> --
> Chuck Lever

