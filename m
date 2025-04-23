Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6521FC369CB
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Apr 2025 22:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2nz+gipDjmANXat/46iFhAh6Yk8nUwnIL8n2w46JbNo=; b=33RX5Z2B6OwcivGNxjH6aLld4D
	fQ6jRwOPS7ZSLoygfQakXbBqcsftnA7iGgVVo/DTID8S5xae1M5QPP3O2PeziiRFve8YMkLUAQGLe
	T+BVLKKzWT3zYSpLZZYxasBfTak/xU+w7c5gv0Ecjja2Ret0wyMqcOgQD47nTYJ5OQ3f8zDKB3PpB
	MuTjVqLhjmuV0q0odHR23/ftu0+oa4faCmGbxJdBx3PvDM8/I5WFxIN6YxWI3/UjmgPQ8YX1s+155
	VGtcohY/g8nKiuhLlxJe/Q4yxZqtCZppNOPN+XDAz+4kasRQ+/lzorByFo0YwY3+VRmNAdIcwCmyy
	3cWOJTfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7iid-0000000CD1B-0SOq;
	Wed, 23 Apr 2025 22:37:27 +0000
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7iia-0000000CD0n-1RI2
	for linux-nvme@lists.infradead.org;
	Wed, 23 Apr 2025 22:37:25 +0000
Received: by mail-vk1-xa2c.google.com with SMTP id 71dfb90a1353d-52403e39a23so257638e0c.2
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 15:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745447843; x=1746052643; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nz+gipDjmANXat/46iFhAh6Yk8nUwnIL8n2w46JbNo=;
        b=GIteAbqmHHNeM/kf1yYq232yYveXI4PXgj9mdXmohclkhAV5Yvp/6apW65LlJ2r5oO
         +RwcDhZqE75iletXLLEWTuTmFAPWPzweWzkrfHPbg9thgeX639pWtdz/UGwK/Cgr4TiW
         EMlvu2YgEjQP+8JE2usheQjep9uV/1f6+kNthUdXfNeuwplIfUO6DSrr2lYT3vsfByZX
         uBIP8eo32qIFbWxTJYyLmjPXFsdV2c3pMx6Po5Pg8MEMfMJpNl19NXgHuQGgqO2IfFhw
         bu/zzA0dmK6ISFPZlbkNFsHae1pCHF70rPhbUWQjO+btYAvNsLtvfTqDyyvQxFX6mn5B
         u8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745447843; x=1746052643;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2nz+gipDjmANXat/46iFhAh6Yk8nUwnIL8n2w46JbNo=;
        b=AQY965uZ0TzdlW/t4i/HPmJDm2kWiOa6QhTCiJsftmRQcpYKCHB/51DUduTctb7Rop
         GfGcxqlSZb0Ud9JZop/MR4mPigf59d1CRPw3iYh1DRl13/c7EUvLb/mLIo66uAH+FGb8
         ZL6AO7EY09TubpOQGpAR+yM41ad1HIoxSbxOtGvIjOAH6ce4o5tsuUsjcOkL0s6BJuJf
         +p5E4HuDedLaBM2+Lz1j3QFLn/MmZ9+poxY5dfL9LfANhoMSj7fEpgWiHMEhrW7bMkKn
         l7CAqH2xdcbKSA4z1acHkg+DyYqWBFWcBn6Zl59JgkBv88Ll8Ga/NafjvF4HS8nB2Yd+
         G0Ww==
X-Forwarded-Encrypted: i=1; AJvYcCVk4CYKiD0TfubJ5WRF8u4fvY2bcju/pn9wFAA8ofM1/peBDTuRC4Ci6I4drUiSr5Y7HZ+2AekIlT8b@lists.infradead.org
X-Gm-Message-State: AOJu0Yyw0wYuuqfGpre+LfOK+zT2cCkrTcO5xKM9HkGlShgCF0BnJ3c0
	MdS8wWcAzC1GkIAf/fsthdyfe4dHnaRgipHIOY2XUmBKs8ijAIChc/Br5my4CmCSQ4q/VyTv7sn
	WlkvlQNw45t6n54PabDIYPLUrGNA=
X-Gm-Gg: ASbGncvP2ZW1FjkZ+Gmta726IqS7eMmUaQqeo9yV/54mlLHcUjyy4uqyxkRocv+4ion
	uTP0xJi06dChaPwDJQ5DyH6CtAG0+NvpVXOBnZCaJNuanBAJR1BnxIe0rYXpwy7fFRPqmN6eS5E
	5I7Lz+wsE2l8Byz3vhNz9vI4ipezMf3RacDWcOOP+cct9okfDRPCZo
X-Google-Smtp-Source: AGHT+IHI49KmhaFnzTJnRm4xJm2Aet7c253pNW/wHNviVly6fNSvQqCW25sHSp8xGsWqLRlJRP+9TlfgYP5nWK4UgN8=
X-Received: by 2002:a05:6102:2b83:b0:4c3:6ba1:3aac with SMTP id
 ada2fe7eead31-4d38cf2f542mr835602137.3.1745447843065; Wed, 23 Apr 2025
 15:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20250423060621.632581-1-alistair.francis@wdc.com>
 <ed993f55-bdfc-4376-951d-9af4a4f461a9@suse.de> <CAKmqyKOBOCV=mU0BRdZu2vPzx-+3fkp7qJXiTXF7dPM35eXguw@mail.gmail.com>
In-Reply-To: <CAKmqyKOBOCV=mU0BRdZu2vPzx-+3fkp7qJXiTXF7dPM35eXguw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 24 Apr 2025 08:36:57 +1000
X-Gm-Features: ATxdqUELk8bpIDMoB69M1_GWUpYFpptzfdIs_SlWACvuN0IwPs0Ca46TI0LrsUg
Message-ID: <CAKmqyKMby=+0-dwCeVGYS5rPqGqS26yabbw1K6Kg_j3NdGXMLQ@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: don't restore null sk_state_change
To: Hannes Reinecke <hare@suse.de>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	csander@purestorage.com, shinichiro.kawasaki@wdc.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_153724_390501_D0311F3B 
X-CRM114-Status: GOOD (  20.65  )
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

On Thu, Apr 24, 2025 at 7:47=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Wed, Apr 23, 2025 at 4:21=E2=80=AFPM Hannes Reinecke <hare@suse.de> wr=
ote:
> >
> > On 4/23/25 08:06, Alistair Francis wrote:
> > > queue->state_change is set as part of nvmet_tcp_set_queue_sock(), but=
 if
> > > the TCP connection isn't established when nvmet_tcp_set_queue_sock() =
is
> > > called then queue->state_change isn't set and sock->sk->sk_state_chan=
ge
> > > isn't replaced.
> > >
> > > As such we don't need to restore sock->sk->sk_state_change if
> > > queue->state_change is NULL.
> > >
> > Good catch!
> >
> > [ .. ]
> >
> > > Resolves: https://lore.kernel.org/linux-nvme/5hdonndzoqa265oq3bj6iarw=
tfk5dewxxjtbjvn5uqnwclpwt6@a2n6w3taxxex/
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > ---
> > > We could also remove the `sock->sk->sk_state !=3D TCP_ESTABLISHED` ch=
eck
> > > in nvmet_tcp_set_queue_sock() if that's prefered.

Actually that by itself isn't enough to fix the NULL dereference. We
still need the NULL check from this patch.

So I think this patch as it currently is should be the fix

Alistair

> > >
> > Please do.
> > We cannot influence what the network stack did, so if there ever were a
> > modification which caused the ->state_change callback _not_ to be set
> > the whole issue pops up again.
>
> If queue->state_change isn't set for any other reason this patch
> should also work, but I'll remove the `sock->sk->sk_state !=3D
> TCP_ESTABLISHED` check as well
>
> Alistair
>
> >
> > Cheers,
> >
> > Hannes
> > --
> > Dr. Hannes Reinecke                  Kernel Storage Architect
> > hare@suse.de                                +49 911 74053 688
> > SUSE Software Solutions GmbH, Frankenstr. 146, 90461 N=C3=BCrnberg
> > HRB 36809 (AG N=C3=BCrnberg), GF: I. Totev, A. McDonald, W. Knoblich

