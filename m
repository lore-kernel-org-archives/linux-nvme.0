Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C999ECCD1AB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 04:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6gcIWpCfhJL6hBxoRz2avBVbdzuoekMr6bFmgI7HFrU=; b=qtx7Q0saKbyI+4X2xo666q+CbV
	aOxvPmfS2UvhZBRPjYMggBJr1OhDgF61g1fEyTMkJvS+LorvMCOW5SL2HJGporM17qpHpIzLUQWK8
	3l8OV8N3OsQdYO6J6hHK36QNuYqsBTwAy+ct4+/k6VSU/Aqou7/3N7EHdbKCt0E3wWPGC8rIWgSp8
	3UPHKpzVGKpRlis96c57+B2rogmgULwFUgH0kbiniRZVKRf1AoSlUeba95N79nbWDjJmyJNfRxnon
	oe4vlGDr67/IDmL83bCICArWC23+zJoGFUsQhumP1ZxXZ7OIRlYbWCcrX9O7v+NiGvwGXGMCTBSqg
	CxtdINZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBQdm-00000001SGZ-3f5e;
	Wed, 22 Oct 2025 04:40:02 +0000
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBQdk-00000001SEd-21eg
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 04:40:01 +0000
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-63c4b5a1b70so8737234a12.1
        for <linux-nvme@lists.infradead.org>; Tue, 21 Oct 2025 21:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761107999; x=1761712799; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gcIWpCfhJL6hBxoRz2avBVbdzuoekMr6bFmgI7HFrU=;
        b=LUBezIZAL7b6idedizuLSEEjRdKxH83vSSDbrz/0EhXEYhwReGSF/pg0c4pVdxrJX5
         NQWrwzFxIizveqiEC+UV/+VxVe4k19XagDkdJzHdDTXDta2k0IICg2XXDycQFC9IPZ6f
         nN0mfP5KGKcMyDLSDK4Ww7ey4agVFNYQZ2OdmW4yH/NG93OC7gvrNzNEb9C0MTT9o0L1
         a9bMn4wu2w/zL3i48axf0gaqbyzkyJI8Oy8GQ2thJVP6UFoVS4gG2qyV9bsDBmJ5PFia
         PcKcbCdcBuPjPhCKEOnC0Irjk6tDFNId2CgPRNTY4MX2TUuPRhXUg4R0ZLiencDTL/vX
         I7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761107999; x=1761712799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6gcIWpCfhJL6hBxoRz2avBVbdzuoekMr6bFmgI7HFrU=;
        b=QZbINLtHtjfUH+HQbtwgiqbLUyyzVRgcse+poERvMahKEXPg3GNVu2xpvkeJR1r/v+
         H7Zk7S2MNZcPA3+2LaSE+sBxVdErkaEqO10La8tGif7ecJGkKyky7SVcSnvU83hpOutb
         7CdEFRDFKUZiuyl1vEaTeVSUu/CZoURhgphhQTLGAG/Qa4YSPpcNrGkTgZhqtpy2s2Bx
         +WAtSHHDSb5LUYQcjKZjc5vme5qEgx86937j0VMG0Bc7UdxfEWdsXKhxQarOtW3tNgWq
         SnUlDphrsJ2kKzTDU91r7pp305UnZ/Myk6tN3B7GqUvxp9qvnW6TUqG9z9KPN8WNQJ+z
         tEpA==
X-Forwarded-Encrypted: i=1; AJvYcCXrQI7qRWAH5SQjy5eGgPHuAi52UmI9HYE+yq5qamt42sZhxK8Hah9c6c214nGjkwGv/pP4N/16qjMt@lists.infradead.org
X-Gm-Message-State: AOJu0Ywmz4U9dRwX+7tWjwIzzxkdhQW4lXiwKKCDaFXY2z+JR+UF/Ubz
	uNE1egsO60oHY1ALNJYaRwmIX/XOg+BZMs2lDJ8XvrON6PALt1zwJfYXDT14W1Gx7yAYxTXIacT
	/uxWu6WSLcgKKKPU4yl5OJX5sGWjxMJg=
X-Gm-Gg: ASbGncuF0tGXbbxerEnfycUJruSXWMMOFGV2plkAZEnr9ZhB9CL3qp8u3fbwFHUzFTp
	Z4YKlKZUbUSQkuz/CT4nxyXomBNpv/SmOsaYyYVd4GirdtjGMt5ZgiQaU8dTEatRdEw+MndCkCD
	KwRRpnBMPcEJns172mM8/yu1AT6ZCWoOeigGugwKOQ6IJBhFzOA3r7a/vA93TXsDv+mZWm0k6gJ
	Dci8Q5XSyB2v3ieJkPRb17V0k+t0fSUTDVKs57kL+nljm0DhSwVj32dB4BD9US42k879ZqpQPnI
	6FBu7afPe/5P14o=
X-Google-Smtp-Source: AGHT+IHSd/93IEd4Mf8dHK30aphVlqAdJCT0S+NEWOivhVENBOPgJ3/RAW4iofRgxNakg4DSTQa1CtVepWHOJJL4c04=
X-Received: by 2002:a05:6402:1ed6:b0:637:dfb1:3395 with SMTP id
 4fb4d7f45d1cf-63c1f62ac10mr20025277a12.8.1761107998484; Tue, 21 Oct 2025
 21:39:58 -0700 (PDT)
MIME-Version: 1.0
References: <20251017042312.1271322-1-alistair.francis@wdc.com>
 <fe16288e-e3f2-4de3-838e-181bbb0ce3ee@suse.de> <CAKmqyKP0eB_WTZtMqtaNELPE4Bs9Ln-0U+_Oqk8fuJXTay_DPg@mail.gmail.com>
 <ddadb1f6-d7e9-427d-baf7-814d2288a407@suse.de>
In-Reply-To: <ddadb1f6-d7e9-427d-baf7-814d2288a407@suse.de>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Oct 2025 14:39:32 +1000
X-Gm-Features: AS18NWAoKKDrp8EpUQELmqxYplrpYxne55FmSrIQzh7JZ6Y-E7isTMxYgqwoeZA
Message-ID: <CAKmqyKOcuUtiv_9g07+8fU7VdAdsKZ2ufAtgarSz=j9H1YP4dA@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] nvme-tcp: Support receiving KeyUpdate requests
To: Hannes Reinecke <hare@suse.de>
Cc: chuck.lever@oracle.com, hare@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org, kbusch@kernel.org, 
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com, 
	Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_214000_558524_1863FF43 
X-CRM114-Status: GOOD (  29.92  )
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

On Tue, Oct 21, 2025 at 4:40=E2=80=AFPM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 10/21/25 03:01, Alistair Francis wrote:
> > On Tue, Oct 21, 2025 at 3:46=E2=80=AFAM Hannes Reinecke <hare@suse.de> =
wrote:
> >>
> >> On 10/17/25 06:23, alistair23@gmail.com wrote:
> >>> From: Alistair Francis <alistair.francis@wdc.com>
> >>>
> >>> The TLS 1.3 specification allows the TLS client or server to send a
> >>> KeyUpdate. This is generally used when the sequence is about to
> >>> overflow or after a certain amount of bytes have been encrypted.
> >>>
> >>> The TLS spec doesn't mandate the conditions though, so a KeyUpdate
> >>> can be sent by the TLS client or server at any time. This includes
> >>> when running NVMe-OF over a TLS 1.3 connection.
> >>>
> >>> As such Linux should be able to handle a KeyUpdate event, as the
> >>> other NVMe side could initiate a KeyUpdate.
> >>>
> >>> Upcoming WD NVMe-TCP hardware controllers implement TLS support
> >>> and send KeyUpdate requests.
> >>>
> >>> This series builds on top of the existing TLS EKEYEXPIRED work,
> >>> which already detects a KeyUpdate request. We can now pass that
> >>> information up to the NVMe layer (target and host) and then pass
> >>> it up to userspace.
> >>>
> >>> Userspace (ktls-utils) will need to save the connection state
> >>> in the keyring during the initial handshake. The kernel then
> >>> provides the key serial back to userspace when handling a
> >>> KeyUpdate. Userspace can use this to restore the connection
> >>> information and then update the keys, this final process
> >>> is similar to the initial handshake.
> >>>
> >>
> >> I am rather sceptical at the current tlshd implementation.
> >> At which place do you update the sending keys?
> >
> > The sending keys are updated as part of gnutls_session_key_update().
> >
> > gnutls_session_key_update() calls update_sending_key() which updates
> > the sending keys.
> >
> > The idea is that when the sequence number is about to overflow the
> > kernel will request userspace to update the sending keys via the
> > HANDSHAKE_KEY_UPDATE_TYPE_SEND key_update_type. Userspace updates the
> > keys and initiates a KeyUpdate.
> >
> That's also what the spec says.
> But in order to do that we would need to get hold of the sequence
> number, which currently is internal to gnutls.

The sequence number is in the kernel. After the handshake the kernel
takes over the TLS connection, so it's up to the kernel to detect a
sequence number overflow. My sending KeyUpdate patches do this, but
they aren't included in this series.

> Can we extract it from the session information?

gnutls can export the sequence number, but as above it doesn't
actually know the correct value (after the handshake).

> And can we display it in sysfs, to give users information
> whether a KeyUpdate had happened?

I don't think that's a good idea. Writing the sequence number to sysfs
seems like extra overhead in the TLS fast path. On top of that I don't
see why userspace cares or what it can do with the number

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

