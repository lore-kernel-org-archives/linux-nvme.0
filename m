Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57C1CCA476
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Oct 2025 02:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From
	:Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=95NJX+pL9ZUPYYCw3O9+SBtr8kwet9/Gfon0rHi+IrE=; b=hnVckp68GjCGJ0pD7Qx8X1GcvU
	827PwCIfII/9SE+oTiAUaKjv9OqJEkIODCEC+Pkq/ex/Jem1hQlzro4qyFyge3VIeZUZrwsy/T0aC
	o6isQyf2DgCmSUt389s6Pzc4qdllEWy94YLabrpPqQB1mHctyACaPfxOOMeEMG8l/P4ZuRv30LNOU
	LnMdhJaT66G9PUUUP2zpVk7Cy6CcCrApJKe+Vil8MkTficmUkdHaY47fuQwrpdqFcLD4rNkVbOOWb
	O1TmhoJddtJIt6wrCyXnp9p4uOpre1GP+eEa24dLUKF7rltq/TpV8NZIUUVFaIDNaHOrfYTyJia92
	FzBJMfOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6Jet-000000034Br-02mr;
	Wed, 08 Oct 2025 02:12:03 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6Jeq-000000034B6-3xPK
	for linux-nvme@lists.infradead.org;
	Wed, 08 Oct 2025 02:12:02 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3322e6360bbso6814070a91.0
        for <linux-nvme@lists.infradead.org>; Tue, 07 Oct 2025 19:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759889520; x=1760494320; darn=lists.infradead.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=95NJX+pL9ZUPYYCw3O9+SBtr8kwet9/Gfon0rHi+IrE=;
        b=SxicLHnP+6V5IB7BzU6swctEC00zL5eZUBFtytV5kYmL2qF5Ht+/F88gp+mUHZiP9/
         WT52aWLQ+Vgubfnv2yNjVrbKGTzMxHgm/6Hu81CSyVyE4aHVpoGD2wx+oIicxbQYsGf8
         qWo1Rq7H3UVH5sUjGDWc18hAiv1Tw9t6wty1n8qqQ5HGaJIe6FlUGAwbuztYfn1tJ96A
         alcXT8AznKgd/CEoKtXEvDhimTQfsMpn0G5Ga3qBjdg1eNfMxhRA7iQSmRTLTw70+7Ng
         QW7AU40R+DPS6nevzwjJPdGGYuN3FlQ2a2AMr+bbGs02D/ZpZVmA0ppBksr74o7+rKEB
         SOUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759889520; x=1760494320;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=95NJX+pL9ZUPYYCw3O9+SBtr8kwet9/Gfon0rHi+IrE=;
        b=EHJ0QQDNtdUow/2IARSAx96WIleZXk73X0kEYffA28jinbhgQTp39BeItfZIQi/UX6
         4vFZb4DFr38Fxmx39oCgAH4wh0DgNFILn0zu4fbWFiz07/qJUuohT+zP49PwFGetTCaW
         f4kTYZi3wP7yDI+ks2wT7YiF6UoDlPrR1gRpSjDF/Ah5KDZrh21agwtt287NzhQ49rar
         LGVFOd1e5d5Iw8wgIMT142fEOalCK3aGIMuZ9jwDF4mDKlyvZq9pNTAtELBHZcGtr2co
         dUYLeVZogpT8BwVLFRt4BEWN90ph+u6MTbtzSEy683AlmDNq4kfP2anIEiYq27zeqF6L
         4i7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsF387AAFc4Ml91m3c5P6+dQHNQbM1PC1jLSh/EHPYbIQitEmlBCvCUoPeZ16y3Q7JHvduXSgI1feU@lists.infradead.org
X-Gm-Message-State: AOJu0Yxeez8ozS02qmUGe84ncmJtS27Vxlt/VyabkOPyCY3tBCMCQz5g
	ehCPs9ImCm3f2eui62cDI363ky7jRhN5UigbA7WD7sas7bAbTOMhq8fE
X-Gm-Gg: ASbGncsHnO/33sxV3/GmuAwRWuZCs5ptrphN5XGekwiNglBdnQhIlpDjI++Od8McuPJ
	fUYfDbQNlp9kvd3Yt6Ihx6N+U4Ri5RQ3debko6DCLglC/fAhdsAMfN4Uky+goGZL7VeWVVULcNX
	E8JMdgFj9ZgaZsJyXKLV4fMzAoxyxoqphDz+zRJlg2imkz7TPN1Zuxj8Pg+T9U8H4ns74n0K8bt
	7P+1JA1JZvkpgtv4OHuf9WsAXrCHRFj3zauwbZsZ0mzkjU9TCT1KtNuXCKJm1LmOMWtVB/8ij2L
	uco4fORVfXumztuxNmd51cIdnjROgtQBadT2zuiHbnBSxMS+khbuBobzozX0KoQRQuLbyisCDp7
	R1otFu2L37CXfZvmU4/YlvTZ6tEwBbTLeix+cnyuI3mRqaL2dhlfyDTetnhOdOrFd4A==
X-Google-Smtp-Source: AGHT+IFz3FyEY2M3qBMJhmAUtAZylBJiGvc5t2kDkFXIlFjsQK/ep9L7nU3ABxehckhHpf5uib5BHA==
X-Received: by 2002:a17:90b:1d05:b0:330:6c04:a72b with SMTP id 98e67ed59e1d1-33b510ff5a6mr2002849a91.3.1759889519684;
        Tue, 07 Oct 2025 19:11:59 -0700 (PDT)
Received: from [192.168.0.69] ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b5137dea8sm1239235a91.13.2025.10.07.19.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 19:11:59 -0700 (PDT)
Message-ID: <143591bfd3499f2ee90034190a94154a965f563d.camel@gmail.com>
Subject: Re: [PATCH] nvme/tcp: handle tls partially sent records in
 write_space()
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, John Fastabend
 <john.fastabend@gmail.com>,  Jakub Kicinski	 <kuba@kernel.org>, Sabrina
 Dubroca <sd@queasysnail.net>, "David S . Miller"	 <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni	 <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>
Date: Wed, 08 Oct 2025 12:11:52 +1000
In-Reply-To: <8e5a3ff3-d17a-488f-97fb-3904684edb47@suse.de>
References: <20251007004634.38716-2-wilfred.opensource@gmail.com>
	 <0bf649d5-112f-42a8-bc8d-6ef2199ed19d@suse.de>
	 <339cbb66fbcd78d639d0d8463a3a67daf089f40d.camel@gmail.com>
	 <8e5a3ff3-d17a-488f-97fb-3904684edb47@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251007_191200_984359_F11CB6F1 
X-CRM114-Status: GOOD (  28.49  )
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

On Tue, 2025-10-07 at 11:51 +0200, Hannes Reinecke wrote:
> On 10/7/25 11:24, Wilfred Mallawa wrote:
> > On Tue, 2025-10-07 at 07:19 +0200, Hannes Reinecke wrote:
> > > On 10/7/25 02:46, Wilfred Mallawa wrote:
> > > > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > > >=20
> > >=20
> > [...]
> > > I wonder: Do we really need to check for a partially assembled
> > > record,
> > > or wouldn't it be easier to call queue->write_space() every time
> > > here?
> > > We sure would end up with executing the callback more often, but
> > > if
> > > no
> > > data is present it shouldn't do any harm.
> > >=20
> > > IE just use
> > >=20
> > > if (nvme_tcp_queue_tls(queue)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 queue->write_space(sk);
> >=20
> > Hey Hannes,
> >=20
> > This was my initial approach, but I figured using
> > tls_is_partially_sent_record() might be slightly more efficient.
> > But if
> > we think that's negligible, happy to go with this approach
> > (omitting
> > the partial record check).
> >=20
> Please do.
> Performance testing on NVMe-TCP is notoriously tricky, so for now we
> really should not assume anything here.
> And it's making the patch _vastly_ simpler, _and_ we don't have to
> involve the networking folks here.

Okay, will send a V2 with this approach.

> We have a similar patch for the data_ready() function in nvmet_tcp(),
> and that seemed to work, too.
> Nit: we don't unset the 'NOSPACE' flag there. Can you check if that's
> really required?=C2=A0
> And, if it is, fixup nvmet_tcp() to unset it?
> Or, if not, modify your patch to not clear it?

I don't see why we would need to clear the NOSPACE flag in
data_ready()? My understanding is that this flag is used when the send
buffer is full.

I would think the clear_bit() is necessary in write_space() since it
would typically get done in something like sk_stream_write_space()?=20
However, running some quick FIOs with the clear_bit() removed, things
seem to work. Not sure if removing it has any further implications
though...

Regards,
Wilfred


> Cheers,
>=20
> Hannes

