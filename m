Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BAEC77B73
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Apr 2023 19:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MRvF12Kz+moNTB1wgkU/5pCeluYsdVIMnvAoQ8fDVB0=; b=lvsjxxgj2yZHnuhQLu8X2gC6m7
	4ChLtfleqKU11bVY19qIDvibZNJlOtkPHldl7wmJ1FV5fs02E5IKGf5broKLpL9sgMPX99Zod5pOw
	ul81bc10NsCvZuoFm7+QHNoWMPNyc2f8saB+b4DuqsvaOd5rr1orNcMwLRN9qVL1sz2PSSmwu27id
	NzPUbH+F0iT0DTUHwlJLK7RQNrCZebR8KKhij6bMRMI4VW1wPXhkIY60EkxyZ29cc5QPSoMgtUzNy
	qGAHvcy5me3Yh9m6cWpt3xuo6nNZuo8TQU9zO7hHC7/FdyWdy5EDXb/nxbEB+EPMMospHNAqXSY/m
	ABK/NVFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ps6to-007Hjm-2p;
	Thu, 27 Apr 2023 19:03:24 +0000
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ps6tk-007Hil-06
	for linux-nvme@lists.infradead.org;
	Thu, 27 Apr 2023 19:03:21 +0000
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94a34a0b9e2so1336085066b.1
        for <linux-nvme@lists.infradead.org>; Thu, 27 Apr 2023 12:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682622197; x=1685214197;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRvF12Kz+moNTB1wgkU/5pCeluYsdVIMnvAoQ8fDVB0=;
        b=G7ERfoqsbehEKBXdTrTZX0c2LkKQa7JqiSoT0EdAXEJ9oxcf1LXAvmGZkSRQIda84f
         LwtXLqcpNM8UxtYgbKOXb4FORqR1gFkDNUq9wNdF4lo8HbMMY+Q9C2lUWYhvwXy+ThCs
         xnRX4SE7GDW6BeOVjAWnPKgkkTIgKL7nrXthbO9h9UOos7Xm5beTWDfbBz+37T2QbQKY
         gSzy/PecyDAZ7bHctxgP6ecLj3uNSe6TuVpMIP8ulrCl/KZHGSwzVKnBXEsfGCQqDjAC
         8q5g6bLGXP8qFmuEbQTstGIsXvx1Udj71gCeddrGzEwQKy6zBpyqmLH05/xd9Z7PUosA
         c8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682622197; x=1685214197;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRvF12Kz+moNTB1wgkU/5pCeluYsdVIMnvAoQ8fDVB0=;
        b=iHXxi9zKEmMmBeH+ZZ+o8Y1O4wtO98F4Lq141XkdDnKRdnig9O/90+OkTPr3YexuDN
         qjiZ0cyJT/36rGcuMA3qWs55/0j/dZLiiYsMZtoaK8U1v2p2CNi3F7bMSTXN+SC/oaeS
         Oe4NyqPeAWIVuzFUXDGWrxHAWpWjUuIeQNcym5VZvNAsJ0qRhSHQgcPwjrPCWc8tQKRA
         5tHolE70PmwZuvX3KceK4nQda8Mjq6inOakI3VIo4m2iJX1XEDvpH6szVaRUckFKTywh
         8DRofZP+2N5H+D09ycGnoUUzmtw/1YpoGl02+Y1RyHTW68QJ31MgWQXVUJXJtqMvmQUE
         i9hw==
X-Gm-Message-State: AC+VfDwFEGzYimU4QeEUkhAoECBQPRXOmRqN5Bqe26oMB8mlx+xcHerv
	d5y6lgnv+qeH/CCHW4QcoFj/xOjE77OyVrC7GSU=
X-Google-Smtp-Source: ACHHUZ7mveCzt6X4rBjEhuOICqSbIKxBfysFWELD2540goQmgfj4xwfl9S84L9t++99PLbhPZee8TtD+Y3aq+OE24So=
X-Received: by 2002:a17:906:9b87:b0:94e:de35:79c5 with SMTP id
 dd7-20020a1709069b8700b0094ede3579c5mr3209703ejc.70.1682622197066; Thu, 27
 Apr 2023 12:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAPiksxOuMyosYh0Ky==jfRcgWpGs5-4SxwfxpaLND5kHsOpq+w@mail.gmail.com>
 <528f9679-1b07-f3af-c936-06ec1e316720@nvidia.com>
In-Reply-To: <528f9679-1b07-f3af-c936-06ec1e316720@nvidia.com>
From: Wang Yicheng <wangyicheng1209@gmail.com>
Date: Thu, 27 Apr 2023 12:03:05 -0700
Message-ID: <CAPiksxOQsF0-p_pwFQQhG7r5WERrRKv9R_w3Bgxp=qCBcPNc+w@mail.gmail.com>
Subject: Re: Seeking for help with NVMe arbitration questions
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230427_120320_065214_87CEA818 
X-CRM114-Status: GOOD (  14.93  )
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

Thanks Chaitanya for confirming!

Given that the kernel module doesn't support configuring device-level
arbitration, I'm now trying to leverage the I/O queues to achieve the
same goal. If you could kindly help with the following questions it
will be much appreciated!

1. Is there a way to query the type of each I/O queue and which CPU it
resides on?

2. Is there a way to control which queue a submitted I/O goes into?

3. Say I have only 1 default queue and I submit an I/O from some CPU,
then there can be a chance that the I/O would need to cross CPUs, if
the default queue happens not to be on the same core right?

Best,
Yicheng

On Tue, Apr 25, 2023 at 10:17=E2=80=AFPM Chaitanya Kulkarni
<chaitanyak@nvidia.com> wrote:
>
>
> > 3. I came across this mail thread: https://lwn.net/Articles/810726/,
> > where Weiping was trying to add WRR support in the kernel. But it
> > seems the patch was eventually dropped. Does it mean today the
> > linux-nvme kernel doesn't have WRR support?
> >
> >
>
> no WRR:-
>
> https://www.spinics.net/lists/linux-block/msg51575.html
>
> -ck
>
>

