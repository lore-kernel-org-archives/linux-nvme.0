Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3B2FD4F0F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 17:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mqqYYI33gU0K1pc4NTXKs/tF6VQTd7NbCjF9Fi24r24=; b=oSSuXuwxxWs/I/SJpIw0NoGAVK
	bzMUNTu/eNzYAvgQZBoDyz0GP0RfSIQgl+mwnw60rDhSDz5cBWF4dkWErapQBgS/HhLv5ujSBFp2Y
	E7me18ieYovodU43o/xP74kmbtIcPpAswEXBBHa6gv55sraa9/ypMq6qHBxno2Qztzw/yYMMYu5G3
	wQMQhMfuuBCRJi289LsSFu8yYVHFkl7krq7vNzV1cpu5oqyqHljwwz3duYgdxocrHkwaA941kRjs3
	UcfhTTcMaJ/X/6B31Wp/mN+Wt78eymNePtCHGb85sIyjfNuK4MYHN0O9UtJTk3RjePsN2t57CZA9Z
	Ffc9Ol9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w01C8-0000000A0nE-0Yys;
	Tue, 10 Mar 2026 17:48:36 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w01C5-0000000A0mn-2a6t
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 17:48:34 +0000
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so8061166a91.0
        for <linux-nvme@lists.infradead.org>; Tue, 10 Mar 2026 10:48:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773164912; cv=none;
        d=google.com; s=arc-20240605;
        b=BDLTVsfplf4Zt42HnYSwl5QaEn1jj3KMuSdbc3KU1tHfcVuYprK2kU/fOhfAj25FKw
         3rTSy70SaV3Ivzos4PLQneblT2UusnZILkIAck7uF0qfWr1F3JTwtoYXll+sBnupwfO2
         eC7yRpGaSzAeWmgktDDDUNPSD/zpSVmpH1Gd2JKWKV7A6XBPy/L+7XpfpKEl7gc0/rfs
         KLQmJvJC2/C+OfUZ7u691htcaco1P0QzPJ0iD6SyMDvMsqC0+9UQA/4nFMk9+7xpFNSH
         anBj0Zcv+/L9YPdObrnwe1+0icuAQglwq9gdrecTYUDoO4TxydkTIIuXw2FVYx5YGdEd
         W7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mqqYYI33gU0K1pc4NTXKs/tF6VQTd7NbCjF9Fi24r24=;
        fh=DI11UltIIrjfznnZgzz677cGnA+Esl5HXxAuBf+uHFw=;
        b=VYFpn27qUvKVXYlbBGvnIqv44YKj2fyaYt587HeIoeN7OF77/gIf7x4j7UM+vFSS7h
         GSueuvpdwc/wOPpGFNfRWoCHSBFU8JunO9p8Groz37LVec2c0rQCPr5piN3+3zTfrgQO
         5OGvzeO0uus8WDkx1HFsnZHpORURgImhmWRgRT1aOeLhLB0MSY7u0zlXFR9RGJ4uQ0tb
         1LdQFfZP9aXxKOu6N9pRNGeU3Xbxcb21uQCiJ0jYW9onznDqAN4jah2yYMotAwu7n6SH
         t3lVGxzR6WSG5sfv8DubnjcBBb5m+g9xUNSI/CLnbOegJlo/i+CKI0xuGA7n4o/W2JXR
         xVWA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164912; x=1773769712; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqqYYI33gU0K1pc4NTXKs/tF6VQTd7NbCjF9Fi24r24=;
        b=fJPL3h/kqVj9Iuw23KbHpZMra4EiEtYslyIPI+4Dm81jvhW3xq1doJKv0/PznvqrGO
         GFO1aLaz1mLyC8cGRINPe6XwtPgfL9urK5uOgsjTsJ1si5ec2PnfdZXsZ1dO3awIlIA3
         j2GgTEhT/KCMbIO9PhotFpHl80i7KJjngC79Edpuud5DkX6wZKYLpNQ28B/fqiS+NxRm
         raPyri2BtsZ9UruZKb2jRZkUoPchaNj65V/fyXZzPTKAU3W0XQBBAmI1hMwLNc4rEWAP
         E4M2cq/TZeit+08XWznzsYoflRTLW7ylKr0b6id/nqSa2aZzaWLg/jJSKfwRxFIqiQeh
         62zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164912; x=1773769712;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mqqYYI33gU0K1pc4NTXKs/tF6VQTd7NbCjF9Fi24r24=;
        b=Qg6JFEJ+K+kBLTwIFFtyn8qjHBHopvmFvYDz/kIMl5edUyW3/63z3GCyQ6YingPMY+
         geBnKKCSoctgiEPeDRD3iYgPZ5b6MVkZnplIYNCqav4XT8eEocfUomqMVUNbxs+asZUy
         +yugCiDeQ5x1WpzzomSx14Z02RSvCkmSNSDXvrJZ6Buie2gDFE+wBh2pY93+zYMDmU9k
         SJq1o38TKpGBciUYDYG4rFK8KGpyKN7PYaPpVe76ctZ5t/FYcspbmmtT0oZXtsvEi1pS
         +HdZC+Z2210fx4jmuXyO6/sXUBYZyFZs8ijDz8roq6SGEmecuJj22PgZmSOGgJNwRmXa
         VKCA==
X-Forwarded-Encrypted: i=1; AJvYcCU2h8pM08Ke/hRZ0hkW1g5S3FZjd2nNeNSC08XRewtTNEdFvhN5o9+QfQ7JN6ECgNPv8QoujxmPOyZU@lists.infradead.org
X-Gm-Message-State: AOJu0YyearNDNibQhcMusMB3E2f7NPYH3zkl1MhzSuOK8BClFACiWCW+
	d2IvI+9LN5WhxwDbSpYYgwiGcmgy/gkio406rQvMEgJ+6ltCoMjX4D6o1LadRS0VjHAArzZL4UB
	/1RhAeWk+s8qJMkVY3wBk3UdNjuGMxwA=
X-Gm-Gg: ATEYQzwp+blQLMvva13Y9P94nhWorCDrOWIWeIIabeWUZvpovfquC6h/vo8rAm2vAV/
	mqnZkDbz1omriSkzxXSh4+gElWx3e5yvJzNRwxFGAMTtGJM7cawQK0vxH4pw+qJb686gxr9aqcD
	Q+waPwRNRV5QF4K70ePMFntH2PWjvvHPX+CRDi4FgqIIBYWyZSIrNnJut5bqfLS9qw2eC9P7+LV
	PVaxKNhkVDsIJ+jK/KKI6Ikq1vcEnquDtBfTJl24Fwn0XvcmHeAMHfctmQ7pkD9VitGU3yt07Nx
	Kc710kg=
X-Received: by 2002:a17:90b:4e86:b0:353:6373:590b with SMTP id
 98e67ed59e1d1-359be21f5e0mr13621966a91.7.1773164912045; Tue, 10 Mar 2026
 10:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260211065925.2878336-1-ioerts@kookmin.ac.kr>
 <CAMX6_QEQ0MZTPv3+ma6cESW6sXrzHSNttoRTY5wNf9p98caa8A@mail.gmail.com>
 <CAMX6_QGn=0riCV+DZewc98b+AAdemj8ani9bQg-T+epFC5kAhw@mail.gmail.com>
 <CAMX6_QH7xiTxLbF4pZHVs9Umw=j70c-dmb3t97c6XBEEEg-kpA@mail.gmail.com> <20260309-scalding-propeller-e00bf0af6519@redhat.com>
In-Reply-To: <20260309-scalding-propeller-e00bf0af6519@redhat.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Wed, 11 Mar 2026 02:48:20 +0900
X-Gm-Features: AaiRm51TplYPaOkCS4hV2hcmDfPFs4zVZUvwG0gWL2j59n_f3EGbu7jgK80XsY0
Message-ID: <CAMX6_QHe04XZR9s_eD8vg0njhkvLn4B+Xx2cW4R1gcKZFsw4TQ@mail.gmail.com>
Subject: Re: [PATCH] nvmet: auth: validate dhchap id list lengths(KASAN: slab-out-of-bounds)
To: Chris Leech <cleech@redhat.com>, Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ioerts@kookmin.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_104833_685488_064C8025 
X-CRM114-Status: GOOD (  30.79  )
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

Test environment:
  - Kernel: v7.0-rc3 (mainline, commit torvalds/linux v7.0-rc3)
  - Config: CONFIG_KASAN=3Dy, CONFIG_KASAN_GENERIC=3Dy,
            CONFIG_NVME_TARGET=3Dy, CONFIG_NVME_TARGET_TCP=3Dy,
            CONFIG_NVME_TARGET_AUTH=3Dy, CONFIG_CRYPTO_DH=3Dy,
            CONFIG_CRYPTO_HMAC=3Dy, CONFIG_CRYPTO_SHA256=3Dy
  - Boot:   QEMU x86_64, 4G RAM, KVM, slub_debug=3DFZP

KASAN report from v7.0-rc3:

[    4.240693] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    4.241646] BUG: KASAN: slab-out-of-bounds in
nvmet_execute_auth_send+0x19b8/0x2090
[    4.242874] Read of size 1 at addr ffff8881045754e8 by task kworker/1:1H=
/41
[    4.243796]
[    4.244015] CPU: 1 UID: 0 PID: 41 Comm: kworker/1:1H Not tainted
7.0.0-rc3 #2 PREEMPT(lazy)
[    4.244025] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX,
arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    4.244030] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
[    4.244047] Call Trace:
[    4.244065]  <TASK>
[    4.244071]  dump_stack_lvl+0x53/0x70
[    4.244110]  print_report+0xd0/0x660
[    4.244142]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[    4.244155]  ? nvmet_execute_auth_send+0x19b8/0x2090
[    4.244160]  kasan_report+0xce/0x100
[    4.244164]  ? nvmet_execute_auth_send+0x19b8/0x2090
[    4.244170]  nvmet_execute_auth_send+0x19b8/0x2090
[    4.244176]  nvmet_tcp_io_work+0x1709/0x2200
[    4.244181]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.244196]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.244201]  ? __pfx_nvmet_tcp_io_work+0x10/0x10
[    4.244206]  process_one_work+0x5e7/0xfe0
[    4.244227]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.244231]  ? assign_work+0x11d/0x370
[    4.244235]  worker_thread+0x446/0xd00
[    4.244241]  ? __pfx_worker_thread+0x10/0x10
[    4.244246]  ? __pfx_worker_thread+0x10/0x10
[    4.244250]  kthread+0x2c6/0x3b0
[    4.244259]  ? recalc_sigpending+0x15c/0x1e0
[    4.244266]  ? __pfx_kthread+0x10/0x10
[    4.244270]  ret_from_fork+0x38d/0x5c0
[    4.244283]  ? __pfx_ret_from_fork+0x10/0x10
[    4.244287]  ? srso_alias_return_thunk+0x5/0xfbef5
[    4.244291]  ? __switch_to+0x534/0xea0
[    4.244300]  ? __switch_to_asm+0x39/0x70
[    4.244305]  ? __switch_to_asm+0x33/0x70
[    4.244309]  ? __pfx_kthread+0x10/0x10
[    4.244312]  ret_from_fork_asm+0x1a/0x30
[    4.244320]  </TASK>
[    4.244322]
[    4.261451] Allocated by task 41:
[    4.261716]  kasan_save_stack+0x33/0x60
[    4.262034]  kasan_save_track+0x14/0x30
[    4.262338]  __kasan_kmalloc+0x8f/0xa0
[    4.262634]  __kmalloc_noprof+0x18e/0x480
[    4.262960]  nvmet_execute_auth_send+0x3be/0x2090
[    4.263339]  nvmet_tcp_io_work+0x1709/0x2200
[    4.263681]  process_one_work+0x5e7/0xfe0
[    4.263997]  worker_thread+0x446/0xd00
[    4.264327]  kthread+0x2c6/0x3b0
[    4.264591]  ret_from_fork+0x38d/0x5c0
[    4.264891]  ret_from_fork_asm+0x1a/0x30
[    4.265211]
[    4.265342] The buggy address belongs to the object at ffff8881045754a0
[    4.265342]  which belongs to the cache kmalloc-96 of size 96
[    4.266291] The buggy address is located 0 bytes to the right of
[    4.266291]  allocated 72-byte region [ffff8881045754a0, ffff8881045754e=
8)
[    4.267277]
[    4.267408] The buggy address belongs to the physical page:
[    4.267840] page: refcount:0 mapcount:0 mapping:0000000000000000
index:0x0 pfn:0x104575
[    4.268473] flags: 0x200000000000000(node=3D0|zone=3D2)
[    4.268855] page_type: f5(slab)
[    4.269120] raw: 0200000000000000 ffff888100042340 dead000000000100
dead000000000122
[    4.269714] raw: 0000000000000000 0000000000150015 00000000f5000000
0000000000000000
[    4.270337] page dumped because: kasan: bad access detected
[    4.270769]
[    4.270899] Memory state around the buggy address:
[    4.271284]  ffff888104575380: fc fc fc fc fc fc fc fc fc fc fc fc
00 00 00 00
[    4.271854]  ffff888104575400: 00 00 00 00 00 00 fc fc fc fc fc fc
fc fc fc fc
[    4.272418] >ffff888104575480: fc fc fc fc 00 00 00 00 00 00 00 00
00 fc fc fc
[    4.272971]                                                           ^
[    4.273488]  ffff888104575500: fc fc fc fc fc fc fc fc fc fc fc fc
fa fb fb fb
[    4.274053]  ffff888104575580: fb fb fb fb fb fb fb fb fc fc fc fc
fc fc fc fc
[    4.274607] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[    4.275336] Disabling lock debugging due to kernel taint

On Tue, Mar 10, 2026 at 3:04=E2=80=AFAM Chris Leech <cleech@redhat.com> wro=
te:
>
> While validating halen and dhlen is a good idea, I don't understand the
> reasoning behind the idlist_half calculations. idlist is a fixed sized
> 60 byte array, and the DH IDs alway start 30 bytes in.
>
> How did you trigger the KASAN issue?  Are you injecting an invalid
> dhlen?  What is the host side, as the linux host driver has a hard coded
> halen of 3 and dhlen of 6.
>
> - Chris
>
> On Mon, Mar 09, 2026 at 12:09:01AM +0900, yunje shin wrote:
> > Just following up on this patch in case it got buried.
> > The KASAN slab-out-of-bounds read is still reproducible on my side.
> > I'd appreciate any feedback.
> >
> > Thanks,
> > Yunje Shin
> >
> > On Wed, Feb 18, 2026 at 1:04=E2=80=AFPM yunje shin <yjshin0438@gmail.co=
m> wrote:
> > >
> > > I've confirmed that the issue is still present and the KASAN
> > > slab-out-of-bounds read is still reproducible. Please let me know if
> > > there are any concerns or if a v2 is needed.
> > >
> > > Thanks, Yunje Shin
> > >
> > > On Thu, Feb 12, 2026 at 10:49=E2=80=AFAM yunje shin <yjshin0438@gmail=
.com> wrote:
> > > >
> > > > The function nvmet_auth_negotiate() parses the idlist array in the
> > > > struct nvmf_auth_dhchap_protocol_descriptor payload. This array is =
60
> > > > bytes and is logically divided into two 30-byte halves: the first h=
alf
> > > > for HMAC IDs and the second half for DH group IDs. The current code
> > > > uses a hardcoded +30 offset for the DH list, but does not validate
> > > > halen and dhlen against the per-half bounds. As a result, if a
> > > > malicious host sends halen or dhlen larger than 30, the loops can r=
ead
> > > > beyond the intended half of idlist, and for sufficiently large valu=
es
> > > > read past the 60-byte array into adjacent slab memory, triggering t=
he
> > > > observed KASAN slab-out-of-bounds read.
> > > >
> > > > This patch fixes the issue by:
> > > >     - Computing the half-size from sizeof(idlist) (idlist_half)
> > > > instead of hardcoding 30
> > > >     - Validating both halen and dhlen are within idlist_half
> > > >     - Replacing the hardcoded DH offset with idlist_half
> > > >
> > > > Thanks,
> > > > Yunje Shin
> > > >
> > > > On Wed, Feb 11, 2026 at 3:59=E2=80=AFPM YunJe Shin <yjshin0438@gmai=
l.com> wrote:
> > > > >
> > > > > Validate DH-HMAC-CHAP hash/DH list lengths before indexing the id=
list halves to prevent out-of-bounds reads.
> > > > >
> > > > > KASAN report:
> > > > > [   37.160829] Call Trace:
> > > > > [   37.160831]  <TASK>
> > > > > [   37.160832]  dump_stack_lvl+0x5f/0x80
> > > > > [   37.160837]  print_report+0xd1/0x640
> > > > > [   37.160842]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> > > > > [   37.160846]  ? kfree+0x137/0x390
> > > > > [   37.160850]  ? kasan_complete_mode_report_info+0x2a/0x200
> > > > > [   37.160854]  kasan_report+0xe5/0x120
> > > > > [   37.160856]  ? nvmet_execute_auth_send+0x19a9/0x1f00
> > > > > [   37.160860]  ? nvmet_execute_auth_send+0x19a9/0x1f00
> > > > > [   37.160863]  __asan_report_load1_noabort+0x18/0x20
> > > > > [   37.160866]  nvmet_execute_auth_send+0x19a9/0x1f00
> > > > > [   37.160870]  nvmet_tcp_io_work+0x17a8/0x2720
> > > > > [   37.160874]  ? __pfx_nvmet_tcp_io_work+0x10/0x10
> > > > > [   37.160877]  process_one_work+0x5e9/0x1020
> > > > > [   37.160881]  ? __kasan_check_write+0x18/0x20
> > > > > [   37.160885]  worker_thread+0x446/0xc80
> > > > > [   37.160889]  ? __pfx_worker_thread+0x10/0x10
> > > > > [   37.160891]  kthread+0x2d7/0x3c0
> > > > > [   37.160894]  ? __pfx_kthread+0x10/0x10
> > > > > [   37.160897]  ret_from_fork+0x39f/0x5d0
> > > > > [   37.160900]  ? __pfx_ret_from_fork+0x10/0x10
> > > > > [   37.160903]  ? __kasan_check_read+0x15/0x20
> > > > > [   37.160906]  ? __switch_to+0xb45/0xf90
> > > > > [   37.160910]  ? __switch_to_asm+0x39/0x70
> > > > > [   37.160914]  ? __pfx_kthread+0x10/0x10
> > > > > [   37.160916]  ret_from_fork_asm+0x1a/0x30
> > > > > [   37.160920]  </TASK>
> > > > > [   37.160921]
> > > > > [   37.174141] Allocated by task 11:
> > > > > [   37.174377]  kasan_save_stack+0x3d/0x60
> > > > > [   37.174697]  kasan_save_track+0x18/0x40
> > > > > [   37.175043]  kasan_save_alloc_info+0x3b/0x50
> > > > > [   37.175420]  __kasan_kmalloc+0x9c/0xa0
> > > > > [   37.175762]  __kmalloc_noprof+0x197/0x480
> > > > > [   37.176117]  nvmet_execute_auth_send+0x39e/0x1f00
> > > > > [   37.176529]  nvmet_tcp_io_work+0x17a8/0x2720
> > > > > [   37.176912]  process_one_work+0x5e9/0x1020
> > > > > [   37.177275]  worker_thread+0x446/0xc80
> > > > > [   37.177616]  kthread+0x2d7/0x3c0
> > > > > [   37.177906]  ret_from_fork+0x39f/0x5d0
> > > > > [   37.178238]  ret_from_fork_asm+0x1a/0x30
> > > > > [   37.178591]
> > > > > [   37.178735] The buggy address belongs to the object at ffff888=
00aecc800
> > > > > [   37.178735]  which belongs to the cache kmalloc-96 of size 96
> > > > > [   37.179790] The buggy address is located 0 bytes to the right =
of
> > > > > [   37.179790]  allocated 72-byte region [ffff88800aecc800, ffff8=
8800aecc848)
> > > > > [   37.180931]
> > > > > [   37.181079] The buggy address belongs to the physical page:
> > > > > [   37.181572] page: refcount:0 mapcount:0 mapping:00000000000000=
00 index:0x0 pfn:0xaecc
> > > > > [   37.182393] flags: 0x100000000000000(node=3D0|zone=3D1)
> > > > > [   37.182819] page_type: f5(slab)
> > > > > [   37.183080] raw: 0100000000000000 ffff888006c41280 dead0000000=
00122 0000000000000000
> > > > > [   37.183730] raw: 0000000000000000 0000000000200020 00000000f50=
00000 0000000000000000
> > > > > [   37.184333] page dumped because: kasan: bad access detected
> > > > > [   37.184783]
> > > > > [   37.184918] Memory state around the buggy address:
> > > > > [   37.185315]  ffff88800aecc700: fa fb fb fb fb fb fb fb fb fb f=
b fb fc fc fc fc
> > > > > [   37.185835]  ffff88800aecc780: fa fb fb fb fb fb fb fb fb fb f=
b fb fc fc fc fc
> > > > > [   37.186336] >ffff88800aecc800: 00 00 00 00 00 00 00 00 00 fc f=
c fc fc fc fc fc
> > > > > [   37.186839]                                               ^
> > > > > [   37.187255]  ffff88800aecc880: fa fb fb fb fb fb fb fb fb fb f=
b fb fc fc fc fc
> > > > > [   37.187763]  ffff88800aecc900: fa fb fb fb fb fb fb fb fb fb f=
b fb fc fc fc fc
> > > > > [   37.188261] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > [   37.188938] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > >
> > > > > Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authenticat=
ion")
> > > > > Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
> > > > > ---
> > > > >  drivers/nvme/target/fabrics-cmd-auth.c | 13 ++++++++++++-
> > > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvm=
e/target/fabrics-cmd-auth.c
> > > > > index 5946681cb0e3..8ad3255aec4a 100644
> > > > > --- a/drivers/nvme/target/fabrics-cmd-auth.c
> > > > > +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> > > > > @@ -36,6 +36,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req=
 *req, void *d)
> > > > >         struct nvmet_ctrl *ctrl =3D req->sq->ctrl;
> > > > >         struct nvmf_auth_dhchap_negotiate_data *data =3D d;
> > > > >         int i, hash_id =3D 0, fallback_hash_id =3D 0, dhgid, fall=
back_dhgid;
> > > > > +       size_t idlist_half;
> > > > >
> > > > >         pr_debug("%s: ctrl %d qid %d: data sc_d %d napd %d authid=
 %d halen %d dhlen %d\n",
> > > > >                  __func__, ctrl->cntlid, req->sq->qid,
> > > > > @@ -72,6 +73,15 @@ static u8 nvmet_auth_negotiate(struct nvmet_re=
q *req, void *d)
> > > > >             NVME_AUTH_DHCHAP_AUTH_ID)
> > > > >                 return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD=
;
> > > > >
> > > > > +       /*
> > > > > +        * idlist[0..idlist_half-1]: hash IDs
> > > > > +        * idlist[idlist_half..]: DH group IDs
> > > > > +        */
> > > > > +       idlist_half =3D sizeof(data->auth_protocol[0].dhchap.idli=
st) / 2;
> > > > > +       if (data->auth_protocol[0].dhchap.halen > idlist_half ||
> > > > > +           data->auth_protocol[0].dhchap.dhlen > idlist_half)
> > > > > +               return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD=
;
> > > > > +
> > > > >         for (i =3D 0; i < data->auth_protocol[0].dhchap.halen; i+=
+) {
> > > > >                 u8 host_hmac_id =3D data->auth_protocol[0].dhchap=
.idlist[i];
> > > > >
> > > > > @@ -98,7 +108,8 @@ static u8 nvmet_auth_negotiate(struct nvmet_re=
q *req, void *d)
> > > > >         dhgid =3D -1;
> > > > >         fallback_dhgid =3D -1;
> > > > >         for (i =3D 0; i < data->auth_protocol[0].dhchap.dhlen; i+=
+) {
> > > > > -               int tmp_dhgid =3D data->auth_protocol[0].dhchap.i=
dlist[i + 30];
> > > > > +               int tmp_dhgid =3D
> > > > > +                       data->auth_protocol[0].dhchap.idlist[i + =
idlist_half];
> > > > >
> > > > >                 if (tmp_dhgid !=3D ctrl->dh_gid) {
> > > > >                         dhgid =3D tmp_dhgid;
> > > > > --
> > > > > 2.43.0
> > > > >
> >
>

