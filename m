Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7B2FD4F08
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 17:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UacAtq6QN+GDyWdoZ2X27YLwLSCDgvlobOOWwXEbztg=; b=oldXN9X/oe/znd2rlIE+lkBP0F
	vI8xbZa0Pvw3XpVcvODd4tAAus6bMJwCm2yLC9pvTp201nvWwBIDjLbUCOVUPnf3Pz42x8RHSW5ZD
	1a9yT3jT+uTzywiOkWSSyjW6U6fFcChK6mEfXoxz8SV1+CRBepZMwkbt94Z59M1gL08oddCbBnXZI
	ilUaSL26WseurqPJiVgyzi2y8NFIKcsezevngq/+BLwaz0CbmhhOOc/YIm8AYvbeuA7Kr8NTYUZN3
	2uAwcO2rRfAyDKwehLS2up3a4DYdXqqcbEkOcQXUOtrB8i5PsBMgzAqWQueZSMBvWMecVgRlf9061
	0X6kdQRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w01GH-0000000A15N-2CgY;
	Tue, 10 Mar 2026 17:52:53 +0000
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w01GE-0000000A14s-3uaD
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 17:52:52 +0000
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-829afe24fb5so2719022b3a.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Mar 2026 10:52:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773165170; cv=none;
        d=google.com; s=arc-20240605;
        b=bwIoCoG7B4s/sZqeC/8exRZfBNmsNMKxaqhioUsG5E8J8hQk9RHosN4YcdkE+GxHix
         bu04IavX71wfDN7Bio60DV0OGHaOftSh+6oxz4Jx0DNwRroCu8YSZHjf42M0qgGK6rjj
         5i+PL9A2Pmrni5TIdTvmUSKakcJZXB+wA7jd7G1bb6AImGYv2lT3vOqo9xgcB+kPISkY
         C2qTsAyXf+tIR3T1Dm4BCa2wSA5/YQNe6KJjK7vZrXmUeubF/tES8Re4sPJyxrCFmz8C
         yTC/E7gfHi+oklhiHhZMAW5P3amG7YubnPTjM4c0kdqQ8q0flw7jMEmRSnFG8TKfdOtN
         pLVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UacAtq6QN+GDyWdoZ2X27YLwLSCDgvlobOOWwXEbztg=;
        fh=uE1ivOsEHgBYujjbgKoDW0/oB5/9f2JFStdXSx3Og48=;
        b=Td2DZKJV2lzTCkTXDuYzpn1HqlOz0mu+bAXsmfOFx+x8F2Sa30gzhKRGJn2rlfZvbC
         IPdoIhqO0xYGmCUXhrk+2zWGiJ8sbOOK8w5xSFE+0gLm/DYz0sRDHzk4FMhgXXPX/9Cz
         g/RbJOxvtF+JRtTvpIlGgQXvjjq12ZnRy9Datxa75CmkqnV+wrrrX1Vz+hhvciX+Zlfl
         UA+0oc1Ch5jknFAa6nxqRI2CS7atuWWmXrFiq5eYIb8o6EAeGFytwH6u3VvAdq+/rVpJ
         w/eLhEKebnnuP4dOhEL45X9u23WdK2nseqURZiJ+lVN30RFFXeWB5YELB04FvQ/bR8v5
         f6Qw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773165170; x=1773769970; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UacAtq6QN+GDyWdoZ2X27YLwLSCDgvlobOOWwXEbztg=;
        b=PgnicpMnFqGkpAP4WdE6CoqBX7nA+5txESgMbKRoNi+abqMwsMorav6nryCWWO7oxt
         trnmIUButWqC0JbXV3ZRK97gSpbSd1R0sNGTHVMtfjbM3NFbtDRo3Jl/iYuRWB1TUblC
         wXYv4AnH2G8Hvv1bqd24taZ5nBLpGmcKlwUSegAf9K/UAaUJLjjZH2msm/PpslQAqE+4
         5Gsw2PnbAyFjp7nYZDkKlv/DK8ibg3kqA8EC2BJsJ2+2fyvq5N74OOV1m2SsIeNEEBQq
         hhRKJimLon0zPf1jAtenT0gZFLxMf2xRY1TY9D2ShZd9bA93rgJP11P+hoySVA3qs2JN
         BkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773165170; x=1773769970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UacAtq6QN+GDyWdoZ2X27YLwLSCDgvlobOOWwXEbztg=;
        b=w7XEXLOwcns+z3PRnwOO//U+0OXZqUIVz1zSPHYSXeaQupVcOCgoe0isgmzeGklVX6
         YYai13BG2KFAqodO5CTUScRE1EltQnRY2OttLWJ1wuaNiVn1zBwoEL2lQTLtfyaXIn6/
         2zNtiHBr07PYiGqOA+wro7LH5rcGxG6uPQEf3tO/OB/5Rm1EUWcTBD4dCE3Ph/GQN4kN
         pm40PwrDi9nfxZYNbNIjRs+DucRc6qlu2iX75IePqH0YFX3gpF4neSO4w1I28hZDpLlf
         PZ7vWfKhrmYXjUB5u9JGJFwMlBpP1ugNoLPE1I/ULeWk0D7+/5MlkLBO866gMVZnvYuG
         BbSw==
X-Forwarded-Encrypted: i=1; AJvYcCXB3nDHxl6xugR4XVXE2uJT+8J+AorvddMoGSNp2Uun4wkZ0bZ5vDWMp5JZINKqZ1+iZFd3PKgq2o3j@lists.infradead.org
X-Gm-Message-State: AOJu0YzdISWV6WJFwXrcEvyOfm5YnO4MzMlprJurGsZaL+7axgoE/a1B
	FuHAf8jIkysDQLSs7OVJmg2t2FkEK4AjXAVwCaqbY9foCgBltJc+71B/us45ncj0RqvclE7FcvY
	chWfwPZ7cQxRE6E9oYykFLwrSr+IWHXM=
X-Gm-Gg: ATEYQzw6AgIpWd1doGP8zY5DPG/bJOmo730EVDrpI0Sk1V6QzvgMNZypfHqdKc/m7vg
	aJIqWO5AJIA37az0z02KIQjSh00hRXHxihRwajJTbSSk86JoEA0SYcptXkPdUTq8kxVLSNntLD1
	J4ViNAlIZeqY3bKr7Xo6yBzxx/RSg5Hf5vD8pYzuBasrrIKXQ6oCe9td0vnNyGw0D+OCVJq+MO1
	QdvIySm2GIb384qIGmqFSsvahTNgEJRxPTVZWxQK8wCIh9qTwE89CjbIaK+MrbM19xGXDZTFQ0T
	wPmEhFjj3UdjqM5LXQ==
X-Received: by 2002:a05:6a00:4b15:b0:829:86aa:e163 with SMTP id
 d2e1a72fcca58-829a2d6e51emr12442979b3a.13.1773165169800; Tue, 10 Mar 2026
 10:52:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260211065925.2878336-1-ioerts@kookmin.ac.kr>
 <CAMX6_QEQ0MZTPv3+ma6cESW6sXrzHSNttoRTY5wNf9p98caa8A@mail.gmail.com>
 <CAMX6_QGn=0riCV+DZewc98b+AAdemj8ani9bQg-T+epFC5kAhw@mail.gmail.com>
 <CAMX6_QH7xiTxLbF4pZHVs9Umw=j70c-dmb3t97c6XBEEEg-kpA@mail.gmail.com>
 <20260309-scalding-propeller-e00bf0af6519@redhat.com> <CAMX6_QHe04XZR9s_eD8vg0njhkvLn4B+Xx2cW4R1gcKZFsw4TQ@mail.gmail.com>
In-Reply-To: <CAMX6_QHe04XZR9s_eD8vg0njhkvLn4B+Xx2cW4R1gcKZFsw4TQ@mail.gmail.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Wed, 11 Mar 2026 02:52:36 +0900
X-Gm-Features: AaiRm50MINg7nvgF7g2Fwop-zPk0bMFPtgpDzNIgCeEjeU3zDXX1kbBTvyg1T2Y
Message-ID: <CAMX6_QG_Xx=1shB+76GKdMyB3-JW9nRiC+1vik=382FyFCT9cg@mail.gmail.com>
Subject: Re: [PATCH] nvmet: auth: validate dhchap id list lengths(KASAN: slab-out-of-bounds)
To: Chris Leech <cleech@redhat.com>, Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ioerts@kookmin.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_105251_028181_74C61E3D 
X-CRM114-Status: GOOD (  35.60  )
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

Thanks for the review.

Yes, I triggered the KASAN issue by injecting an invalid dhlen The
reproduction steps are:
1. Connect to the NVMe/TCP target on port 4420 (ICReq + Fabrics CONNECT).
2. Send AUTH_SEND with a crafted NEGOTIATE payload where dhlen=3D200. 3.
The kernel target code in nvmet_auth_negotiate() then iterates

    for (i =3D 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
        int tmp_dhgid =3D data->auth_protocol[0].dhchap.idlist[i + 30];

With dhlen=3D200, this reads idlist[30..229], but idlist[] is only 60
bytes (indices 0..59). The accesses at indices 60 and beyond read past
the kmalloc'd slab object into adjacent slab memory, which KASAN
catches as a slab-out-of-bounds read.

While the standard Linux NVMe host driver does use hardcoded halen=3D3
and dhlen=3D6, the NVMe target is network-facing and must validate all
fields from the wire. A malicious or non-standard host can send
arbitrary values. The same applies to halen =E2=80=94 if halen > 30, the
first loop also reads out of bounds.

Regarding idlist_half =E2=80=94 yes, idlist is currently a fixed 60-byte ar=
ray
and the DH offset is always 30. I derived it from sizeof(idlist)
rather than hardcoding 30 so that the bounds check and the DH offset
stay consistent with the array definition. If the struct ever changes,
the validation adapts automatically instead of silently going stale.

Thanks,
Yunje Shin

On Wed, Mar 11, 2026 at 2:48=E2=80=AFAM yunje shin <yjshin0438@gmail.com> w=
rote:
>
> Test environment:
>   - Kernel: v7.0-rc3 (mainline, commit torvalds/linux v7.0-rc3)
>   - Config: CONFIG_KASAN=3Dy, CONFIG_KASAN_GENERIC=3Dy,
>             CONFIG_NVME_TARGET=3Dy, CONFIG_NVME_TARGET_TCP=3Dy,
>             CONFIG_NVME_TARGET_AUTH=3Dy, CONFIG_CRYPTO_DH=3Dy,
>             CONFIG_CRYPTO_HMAC=3Dy, CONFIG_CRYPTO_SHA256=3Dy
>   - Boot:   QEMU x86_64, 4G RAM, KVM, slub_debug=3DFZP
>
> KASAN report from v7.0-rc3:
>
> [    4.240693] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    4.241646] BUG: KASAN: slab-out-of-bounds in
> nvmet_execute_auth_send+0x19b8/0x2090
> [    4.242874] Read of size 1 at addr ffff8881045754e8 by task kworker/1:=
1H/41
> [    4.243796]
> [    4.244015] CPU: 1 UID: 0 PID: 41 Comm: kworker/1:1H Not tainted
> 7.0.0-rc3 #2 PREEMPT(lazy)
> [    4.244025] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX,
> arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [    4.244030] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
> [    4.244047] Call Trace:
> [    4.244065]  <TASK>
> [    4.244071]  dump_stack_lvl+0x53/0x70
> [    4.244110]  print_report+0xd0/0x660
> [    4.244142]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> [    4.244155]  ? nvmet_execute_auth_send+0x19b8/0x2090
> [    4.244160]  kasan_report+0xce/0x100
> [    4.244164]  ? nvmet_execute_auth_send+0x19b8/0x2090
> [    4.244170]  nvmet_execute_auth_send+0x19b8/0x2090
> [    4.244176]  nvmet_tcp_io_work+0x1709/0x2200
> [    4.244181]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    4.244196]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    4.244201]  ? __pfx_nvmet_tcp_io_work+0x10/0x10
> [    4.244206]  process_one_work+0x5e7/0xfe0
> [    4.244227]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    4.244231]  ? assign_work+0x11d/0x370
> [    4.244235]  worker_thread+0x446/0xd00
> [    4.244241]  ? __pfx_worker_thread+0x10/0x10
> [    4.244246]  ? __pfx_worker_thread+0x10/0x10
> [    4.244250]  kthread+0x2c6/0x3b0
> [    4.244259]  ? recalc_sigpending+0x15c/0x1e0
> [    4.244266]  ? __pfx_kthread+0x10/0x10
> [    4.244270]  ret_from_fork+0x38d/0x5c0
> [    4.244283]  ? __pfx_ret_from_fork+0x10/0x10
> [    4.244287]  ? srso_alias_return_thunk+0x5/0xfbef5
> [    4.244291]  ? __switch_to+0x534/0xea0
> [    4.244300]  ? __switch_to_asm+0x39/0x70
> [    4.244305]  ? __switch_to_asm+0x33/0x70
> [    4.244309]  ? __pfx_kthread+0x10/0x10
> [    4.244312]  ret_from_fork_asm+0x1a/0x30
> [    4.244320]  </TASK>
> [    4.244322]
> [    4.261451] Allocated by task 41:
> [    4.261716]  kasan_save_stack+0x33/0x60
> [    4.262034]  kasan_save_track+0x14/0x30
> [    4.262338]  __kasan_kmalloc+0x8f/0xa0
> [    4.262634]  __kmalloc_noprof+0x18e/0x480
> [    4.262960]  nvmet_execute_auth_send+0x3be/0x2090
> [    4.263339]  nvmet_tcp_io_work+0x1709/0x2200
> [    4.263681]  process_one_work+0x5e7/0xfe0
> [    4.263997]  worker_thread+0x446/0xd00
> [    4.264327]  kthread+0x2c6/0x3b0
> [    4.264591]  ret_from_fork+0x38d/0x5c0
> [    4.264891]  ret_from_fork_asm+0x1a/0x30
> [    4.265211]
> [    4.265342] The buggy address belongs to the object at ffff8881045754a=
0
> [    4.265342]  which belongs to the cache kmalloc-96 of size 96
> [    4.266291] The buggy address is located 0 bytes to the right of
> [    4.266291]  allocated 72-byte region [ffff8881045754a0, ffff888104575=
4e8)
> [    4.267277]
> [    4.267408] The buggy address belongs to the physical page:
> [    4.267840] page: refcount:0 mapcount:0 mapping:0000000000000000
> index:0x0 pfn:0x104575
> [    4.268473] flags: 0x200000000000000(node=3D0|zone=3D2)
> [    4.268855] page_type: f5(slab)
> [    4.269120] raw: 0200000000000000 ffff888100042340 dead000000000100
> dead000000000122
> [    4.269714] raw: 0000000000000000 0000000000150015 00000000f5000000
> 0000000000000000
> [    4.270337] page dumped because: kasan: bad access detected
> [    4.270769]
> [    4.270899] Memory state around the buggy address:
> [    4.271284]  ffff888104575380: fc fc fc fc fc fc fc fc fc fc fc fc
> 00 00 00 00
> [    4.271854]  ffff888104575400: 00 00 00 00 00 00 fc fc fc fc fc fc
> fc fc fc fc
> [    4.272418] >ffff888104575480: fc fc fc fc 00 00 00 00 00 00 00 00
> 00 fc fc fc
> [    4.272971]                                                           =
^
> [    4.273488]  ffff888104575500: fc fc fc fc fc fc fc fc fc fc fc fc
> fa fb fb fb
> [    4.274053]  ffff888104575580: fb fb fb fb fb fb fb fb fc fc fc fc
> fc fc fc fc
> [    4.274607] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [    4.275336] Disabling lock debugging due to kernel taint
>
> On Tue, Mar 10, 2026 at 3:04=E2=80=AFAM Chris Leech <cleech@redhat.com> w=
rote:
> >
> > While validating halen and dhlen is a good idea, I don't understand the
> > reasoning behind the idlist_half calculations. idlist is a fixed sized
> > 60 byte array, and the DH IDs alway start 30 bytes in.
> >
> > How did you trigger the KASAN issue?  Are you injecting an invalid
> > dhlen?  What is the host side, as the linux host driver has a hard code=
d
> > halen of 3 and dhlen of 6.
> >
> > - Chris
> >
> > On Mon, Mar 09, 2026 at 12:09:01AM +0900, yunje shin wrote:
> > > Just following up on this patch in case it got buried.
> > > The KASAN slab-out-of-bounds read is still reproducible on my side.
> > > I'd appreciate any feedback.
> > >
> > > Thanks,
> > > Yunje Shin
> > >
> > > On Wed, Feb 18, 2026 at 1:04=E2=80=AFPM yunje shin <yjshin0438@gmail.=
com> wrote:
> > > >
> > > > I've confirmed that the issue is still present and the KASAN
> > > > slab-out-of-bounds read is still reproducible. Please let me know i=
f
> > > > there are any concerns or if a v2 is needed.
> > > >
> > > > Thanks, Yunje Shin
> > > >
> > > > On Thu, Feb 12, 2026 at 10:49=E2=80=AFAM yunje shin <yjshin0438@gma=
il.com> wrote:
> > > > >
> > > > > The function nvmet_auth_negotiate() parses the idlist array in th=
e
> > > > > struct nvmf_auth_dhchap_protocol_descriptor payload. This array i=
s 60
> > > > > bytes and is logically divided into two 30-byte halves: the first=
 half
> > > > > for HMAC IDs and the second half for DH group IDs. The current co=
de
> > > > > uses a hardcoded +30 offset for the DH list, but does not validat=
e
> > > > > halen and dhlen against the per-half bounds. As a result, if a
> > > > > malicious host sends halen or dhlen larger than 30, the loops can=
 read
> > > > > beyond the intended half of idlist, and for sufficiently large va=
lues
> > > > > read past the 60-byte array into adjacent slab memory, triggering=
 the
> > > > > observed KASAN slab-out-of-bounds read.
> > > > >
> > > > > This patch fixes the issue by:
> > > > >     - Computing the half-size from sizeof(idlist) (idlist_half)
> > > > > instead of hardcoding 30
> > > > >     - Validating both halen and dhlen are within idlist_half
> > > > >     - Replacing the hardcoded DH offset with idlist_half
> > > > >
> > > > > Thanks,
> > > > > Yunje Shin
> > > > >
> > > > > On Wed, Feb 11, 2026 at 3:59=E2=80=AFPM YunJe Shin <yjshin0438@gm=
ail.com> wrote:
> > > > > >
> > > > > > Validate DH-HMAC-CHAP hash/DH list lengths before indexing the =
idlist halves to prevent out-of-bounds reads.
> > > > > >
> > > > > > KASAN report:
> > > > > > [   37.160829] Call Trace:
> > > > > > [   37.160831]  <TASK>
> > > > > > [   37.160832]  dump_stack_lvl+0x5f/0x80
> > > > > > [   37.160837]  print_report+0xd1/0x640
> > > > > > [   37.160842]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> > > > > > [   37.160846]  ? kfree+0x137/0x390
> > > > > > [   37.160850]  ? kasan_complete_mode_report_info+0x2a/0x200
> > > > > > [   37.160854]  kasan_report+0xe5/0x120
> > > > > > [   37.160856]  ? nvmet_execute_auth_send+0x19a9/0x1f00
> > > > > > [   37.160860]  ? nvmet_execute_auth_send+0x19a9/0x1f00
> > > > > > [   37.160863]  __asan_report_load1_noabort+0x18/0x20
> > > > > > [   37.160866]  nvmet_execute_auth_send+0x19a9/0x1f00
> > > > > > [   37.160870]  nvmet_tcp_io_work+0x17a8/0x2720
> > > > > > [   37.160874]  ? __pfx_nvmet_tcp_io_work+0x10/0x10
> > > > > > [   37.160877]  process_one_work+0x5e9/0x1020
> > > > > > [   37.160881]  ? __kasan_check_write+0x18/0x20
> > > > > > [   37.160885]  worker_thread+0x446/0xc80
> > > > > > [   37.160889]  ? __pfx_worker_thread+0x10/0x10
> > > > > > [   37.160891]  kthread+0x2d7/0x3c0
> > > > > > [   37.160894]  ? __pfx_kthread+0x10/0x10
> > > > > > [   37.160897]  ret_from_fork+0x39f/0x5d0
> > > > > > [   37.160900]  ? __pfx_ret_from_fork+0x10/0x10
> > > > > > [   37.160903]  ? __kasan_check_read+0x15/0x20
> > > > > > [   37.160906]  ? __switch_to+0xb45/0xf90
> > > > > > [   37.160910]  ? __switch_to_asm+0x39/0x70
> > > > > > [   37.160914]  ? __pfx_kthread+0x10/0x10
> > > > > > [   37.160916]  ret_from_fork_asm+0x1a/0x30
> > > > > > [   37.160920]  </TASK>
> > > > > > [   37.160921]
> > > > > > [   37.174141] Allocated by task 11:
> > > > > > [   37.174377]  kasan_save_stack+0x3d/0x60
> > > > > > [   37.174697]  kasan_save_track+0x18/0x40
> > > > > > [   37.175043]  kasan_save_alloc_info+0x3b/0x50
> > > > > > [   37.175420]  __kasan_kmalloc+0x9c/0xa0
> > > > > > [   37.175762]  __kmalloc_noprof+0x197/0x480
> > > > > > [   37.176117]  nvmet_execute_auth_send+0x39e/0x1f00
> > > > > > [   37.176529]  nvmet_tcp_io_work+0x17a8/0x2720
> > > > > > [   37.176912]  process_one_work+0x5e9/0x1020
> > > > > > [   37.177275]  worker_thread+0x446/0xc80
> > > > > > [   37.177616]  kthread+0x2d7/0x3c0
> > > > > > [   37.177906]  ret_from_fork+0x39f/0x5d0
> > > > > > [   37.178238]  ret_from_fork_asm+0x1a/0x30
> > > > > > [   37.178591]
> > > > > > [   37.178735] The buggy address belongs to the object at ffff8=
8800aecc800
> > > > > > [   37.178735]  which belongs to the cache kmalloc-96 of size 9=
6
> > > > > > [   37.179790] The buggy address is located 0 bytes to the righ=
t of
> > > > > > [   37.179790]  allocated 72-byte region [ffff88800aecc800, fff=
f88800aecc848)
> > > > > > [   37.180931]
> > > > > > [   37.181079] The buggy address belongs to the physical page:
> > > > > > [   37.181572] page: refcount:0 mapcount:0 mapping:000000000000=
0000 index:0x0 pfn:0xaecc
> > > > > > [   37.182393] flags: 0x100000000000000(node=3D0|zone=3D1)
> > > > > > [   37.182819] page_type: f5(slab)
> > > > > > [   37.183080] raw: 0100000000000000 ffff888006c41280 dead00000=
0000122 0000000000000000
> > > > > > [   37.183730] raw: 0000000000000000 0000000000200020 00000000f=
5000000 0000000000000000
> > > > > > [   37.184333] page dumped because: kasan: bad access detected
> > > > > > [   37.184783]
> > > > > > [   37.184918] Memory state around the buggy address:
> > > > > > [   37.185315]  ffff88800aecc700: fa fb fb fb fb fb fb fb fb fb=
 fb fb fc fc fc fc
> > > > > > [   37.185835]  ffff88800aecc780: fa fb fb fb fb fb fb fb fb fb=
 fb fb fc fc fc fc
> > > > > > [   37.186336] >ffff88800aecc800: 00 00 00 00 00 00 00 00 00 fc=
 fc fc fc fc fc fc
> > > > > > [   37.186839]                                               ^
> > > > > > [   37.187255]  ffff88800aecc880: fa fb fb fb fb fb fb fb fb fb=
 fb fb fc fc fc fc
> > > > > > [   37.187763]  ffff88800aecc900: fa fb fb fb fb fb fb fb fb fb=
 fb fb fc fc fc fc
> > > > > > [   37.188261] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > > [   37.188938] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > >
> > > > > > Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentic=
ation")
> > > > > > Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
> > > > > > ---
> > > > > >  drivers/nvme/target/fabrics-cmd-auth.c | 13 ++++++++++++-
> > > > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/n=
vme/target/fabrics-cmd-auth.c
> > > > > > index 5946681cb0e3..8ad3255aec4a 100644
> > > > > > --- a/drivers/nvme/target/fabrics-cmd-auth.c
> > > > > > +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> > > > > > @@ -36,6 +36,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_r=
eq *req, void *d)
> > > > > >         struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
> > > > > >         struct nvmf_auth_dhchap_negotiate_data *data =3D d;
> > > > > >         int i, hash_id =3D 0, fallback_hash_id =3D 0, dhgid, fa=
llback_dhgid;
> > > > > > +       size_t idlist_half;
> > > > > >
> > > > > >         pr_debug("%s: ctrl %d qid %d: data sc_d %d napd %d auth=
id %d halen %d dhlen %d\n",
> > > > > >                  __func__, ctrl->cntlid, req->sq->qid,
> > > > > > @@ -72,6 +73,15 @@ static u8 nvmet_auth_negotiate(struct nvmet_=
req *req, void *d)
> > > > > >             NVME_AUTH_DHCHAP_AUTH_ID)
> > > > > >                 return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLO=
AD;
> > > > > >
> > > > > > +       /*
> > > > > > +        * idlist[0..idlist_half-1]: hash IDs
> > > > > > +        * idlist[idlist_half..]: DH group IDs
> > > > > > +        */
> > > > > > +       idlist_half =3D sizeof(data->auth_protocol[0].dhchap.id=
list) / 2;
> > > > > > +       if (data->auth_protocol[0].dhchap.halen > idlist_half |=
|
> > > > > > +           data->auth_protocol[0].dhchap.dhlen > idlist_half)
> > > > > > +               return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLO=
AD;
> > > > > > +
> > > > > >         for (i =3D 0; i < data->auth_protocol[0].dhchap.halen; =
i++) {
> > > > > >                 u8 host_hmac_id =3D data->auth_protocol[0].dhch=
ap.idlist[i];
> > > > > >
> > > > > > @@ -98,7 +108,8 @@ static u8 nvmet_auth_negotiate(struct nvmet_=
req *req, void *d)
> > > > > >         dhgid =3D -1;
> > > > > >         fallback_dhgid =3D -1;
> > > > > >         for (i =3D 0; i < data->auth_protocol[0].dhchap.dhlen; =
i++) {
> > > > > > -               int tmp_dhgid =3D data->auth_protocol[0].dhchap=
.idlist[i + 30];
> > > > > > +               int tmp_dhgid =3D
> > > > > > +                       data->auth_protocol[0].dhchap.idlist[i =
+ idlist_half];
> > > > > >
> > > > > >                 if (tmp_dhgid !=3D ctrl->dh_gid) {
> > > > > >                         dhgid =3D tmp_dhgid;
> > > > > > --
> > > > > > 2.43.0
> > > > > >
> > >
> >

