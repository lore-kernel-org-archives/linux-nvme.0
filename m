Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB746E83056
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 05:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xr5Ji1JTl13WOuCTcqzd0dRKXNFQ7JXgJ1JD++dgyTQ=; b=ehiTqDLUwsDnT0IY3rf2YVH5O0
	/UVDf52l0cLbIjfiw1L8ASGmJU9Gc1XhQzIS4d9gbuyD0vaUn92EScZDuWDQLbYsDW9N05TVN2Ff6
	E3ibUKfNklotUdA8slvSKOMDM9O7NGctZ/f8SP4vw7xrYZEHQRS3ddsCXbjc9OlZ5hqSTQLnU8C+t
	bNTuu7tKjNIBLDNqyfpEc/3XoOV3XNTHOTXTv9s05brKVg5WJCctJXwLtRh1Q14lLIjAkJIuOyxbb
	m7Mnp8c9YDKzJC14CRbeWi4GC/AaB3OLiEXrKeal9/kUtjSlN1HOlf0HnuheR9zdvj09YdwCn75Wl
	sIy5TXvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn8q5-000000065cm-0BCk;
	Tue, 03 Feb 2026 05:20:37 +0000
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn8px-000000065c0-3YDw
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 05:20:35 +0000
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso3389855a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 02 Feb 2026 21:20:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770096029; cv=none;
        d=google.com; s=arc-20240605;
        b=AbWeawlqdrd8qCyuIkTWFBmqcylJEFPFrzv9lQqgX5XV627AdradMMfuwKH8m6ODbq
         u9/aOOXrHMqQ7QABztfBOdgb40ZNvrQ0QD2M4SEfPwfMiwV02r54+VyiX2euK7WmV1gk
         hQoImiQ2VdJ5jsmX0ZNGCCTXSAboIoN6ws3lAFK/A+IMOX3Xenb9wByNq5YpMNrmAC5M
         CJokdADZoQSgWAgtftmAjdS0H3sy4u1LXiC2aoworpqXA4v2K5Eyrg1anrWRnDlfpkfs
         /yy1T3VOqnPFrcei3ONaOHFMDKA99pyI1iphBFnbjHoIf+7HuN/QfoT5eiEwIDWVxfrX
         CCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Xr5Ji1JTl13WOuCTcqzd0dRKXNFQ7JXgJ1JD++dgyTQ=;
        fh=AVV6iQLJ3AMIMV2PjkK6gcVSRk+ro+WldPbB/AAbbV8=;
        b=TvhUXxECaDOu/sBeRAytDn80I7sHIXnc8dURY2d+5J5x6Ted1DJK+zoxg2zDfvjseg
         Evq81ph0K11cFr+jgUFvVAumF4kT8HqSY1Zz3v9IdsVZsRHJPGFifq72lRyNefNHOuI5
         weFDzDibQJzwCkh1xFt/GAvQ8w+54X58eOmS7XPsbR30V/NaQ30HYOqNYuAgy0vTtHDg
         bN2WEy2XTfKsJ6++9NkT2FUx2VTU2dKOBkTlkIlFn8ckrixxYsRw8ArHVqJhR4iV6oAW
         MaCRV1zAXtE+nxVKqOpAUYOcfs7NbWrCY0KPQg9w+PvN4UCKdwNPH2DP91MkPEkplPMO
         JQMg==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770096029; x=1770700829; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xr5Ji1JTl13WOuCTcqzd0dRKXNFQ7JXgJ1JD++dgyTQ=;
        b=hHwzmgjBevIc5qylxD4AGxktJeBrsGeyTh3qWhJgU5cVrhocmKurBbedw1CYLL1t8B
         OU6v1UH4NUjmdh3R7bPFZKCFzJl5yGxA9Frh6Vjszt8Y3vgRr1Se7kbY2sQ22kXU7Lq7
         AhQRFfiTDqGzXds0Pk6Nlziht+gpvqcfwX0/NMsO93jGN5mnWXov3K4yQTBeveZbp4nw
         D6NBwp6cr9qP7VsatDHctsOPS3RdL8TkMbW70DMK8SPT8Jq3hYctIb+y4vMy1iy4O4We
         1du60D+7ithz+5lC8TX6Mhl51TDkkFh8fm7xmXyHxWxY90PsRNmJoUjosbG4OOrg3ozf
         ClMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770096029; x=1770700829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xr5Ji1JTl13WOuCTcqzd0dRKXNFQ7JXgJ1JD++dgyTQ=;
        b=Aei8Jlq6O2VUx8wdQZkiTLRP12We8fIUBfOWvHwquNS3m1yfpq2LvE/5WFCcgdBB9h
         6SRS99Viiua1K4XvMrojHFH+/UmE6bGs1rLAcdfRiq7gLwJf1I0Z06vKJ5vn6uzAs4KZ
         37Go83uwbQZumUBa1oupD1IwQhPM0WZDQfZqhuyIpdgRqj3+HyXNaeYYkaeNpRqtLEM8
         czB1mGhJF/ox8x5znw+C6VKzYIUSueN4KPWGqWw1C5DY4xJCFSVt0N8MPy8fQeurQ6xO
         ty5BmZv0WKySgnBGeVzBB1lEPwlhpfcwAiJqVaM/TRvw2rFBomCOmEJCq8CbuHAHIulh
         A1kw==
X-Forwarded-Encrypted: i=1; AJvYcCUDaI5YnKKkXO9jdpYSwB+Fs2qTBhZNz9gwyp7dwrOoGoZy+1BNlSWMH/Y/SSdteaB2lABkgvmc+rcz@lists.infradead.org
X-Gm-Message-State: AOJu0Yylqrdm3igJOCx1wNPf+40qpnhnldKdjUpOJ/JNHv4eJvZAqQJS
	bpXi6e0TmuhrS9c8MB718VvvWsCIl4UqAnaC0fK68xGAKAzvPMlgdx4MFEgDS0Coem36WyGldCB
	1RzSt0uHNH7L/lZARI9WEKVOgn1oD3dY=
X-Gm-Gg: AZuq6aJjilEQs6q1bUzMLFtA9L9/vQFS6aTJgbujlxY70tDl8dv6dhwibg73B03u4Iq
	+uUgirj3PAlT5pqtlmDthqH8CLMfPjpr0Ht0JK5sy/b6r7kH7iANiDYvBfhGBS25cU3smMLgFQK
	gPawYejsaietUJylsO/Yg5JsYby4kLy0iWT3VZhX+AEnx/HzlWBczwrRH24k8InS6H6HCTsU0Ue
	mJIP5EgOZUHXDfUbC3Nl9j67bKcDzAJ9FutAiG7Yg4YoQpJOoqfrUNF6pYx+/lWLQDfd4/LLQ==
X-Received: by 2002:a05:6a21:2291:b0:38c:792:567e with SMTP id
 adf61e73a8af0-392dfff5b1bmr13543098637.15.1770096028772; Mon, 02 Feb 2026
 21:20:28 -0800 (PST)
MIME-Version: 1.0
References: <678f42fb-521e-4b5e-b662-331e424ca003@grimberg.me>
 <20260128004136.946596-1-ioerts@kookmin.ac.kr> <CAMX6_QEujcQ6137p2uBZ=4sgpZ_4PCRE1fV6VgXha_ZiYxpNQQ@mail.gmail.com>
 <CAMX6_QG54YV-_4UDUtVrnSp006NZxOMiEEb6_dRqWAW6qSS-2g@mail.gmail.com>
 <CAMX6_QE+8EdnrFp6iFifK9i7aYLwmAewRn+k=2OfC_QiRkLKhw@mail.gmail.com> <CAMX6_QEkN=0eN68DdWMn5TukiUPvJaX09q4hWyUTWNZrQZv7nQ@mail.gmail.com>
In-Reply-To: <CAMX6_QEkN=0eN68DdWMn5TukiUPvJaX09q4hWyUTWNZrQZv7nQ@mail.gmail.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Tue, 3 Feb 2026 14:20:17 +0900
X-Gm-Features: AZwV_QgR5IgiJaSk80cF1oD2qVHvP-fDAOVHrdA3kp9h1xOrNGHemLIy3OQ4bvI
Message-ID: <CAMX6_QEQuC5uoGS_sXL0apy5OpRDjESkNzJqw3VEj+bWZUSzGg@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec
To: kbusch@kernel.org, sagi@grimberg.me, Christoph Hellwig <hch@lst.de>, 
	linux-nvme@lists.infradead.org
Cc: gregkh@linuxfoundation.org, security@kernel.org, 
	YunJe Shin <ioerts@kookmin.ac.kr>, joonkyoj@yonsei.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_212030_264046_F02F8BCA 
X-CRM114-Status: GOOD (  30.44  )
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

Hi everyone,

I have additional crash logs from testing on Kernel 6.19-rc8 that show
the same vulnerable code path being hit. The crash is consistently
reproducible by sending malformed PDUs.

Test environment:

Hardware/Hypervisor: QEMU (i440FX + PIIX) on Ubuntu 24.04
System Info (uname -a): Linux (none) 6.19.0-rc8 #2 SMP PREEMPT_DYNAMIC
Tue Feb 3 13:37:27 KST 2026 x86_64 GNU/Linux
Config: SMP, PREEMPT(voluntary), SLUB_DEBUG enabled
Crash log (6.19-rc8 - General Protection Fault via Controlled OOB Read):

[    7.626066] Oops: general protection fault, probably for
non-canonical address 0xdeadbeefdeadbef8: 0000 [#1] SMP NOPTI
[    7.626954] CPU: 0 UID: 0 PID: 42 Comm: kworker/0:1H Not tainted
6.19.0-rc8 #2 PREEMPT(voluntary)
[    7.627648] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[    7.628389] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
[    7.628771] RIP: 0010:nvmet_tcp_build_pdu_iovec+0x61/0xc0
[    7.629160] Code: 48 03 47 30 85 f6 75 22 eb 74 48 8b 50 20 48 8d
48 20 48 89 d0 48 83 e0 fc 83 e2 01 48 0f 44 c1 49 83 c1 10 31 c9 85
f6 74 32 <8b> 50 0c 4c 8b 00 29 ca 39 f2 0f 47 d6 03 48 08 49 83 e0 fc
4d 89
[    7.630423] RSP: 0018:ffffc90000167cd8 EFLAGS: 00010202
[    7.630784] RAX: deadbeefdeadbeec RBX: ffff888100349800 RCX: 00000000000=
00000
[    7.631256] RDX: 0000000000000001 RSI: 0000000000000008 RDI: ffff8881017=
40000
[    7.631739] RBP: ffff888101740000 R08: 0000000000000000 R09: ffff8881014=
8b280
[    7.632221] R10: 0000000000000001 R11: 0000000000000008 R12: ffffc900001=
67d00
[    7.632710] R13: ffff888100349918 R14: ffffc90000167dd7 R15: ffff8881003=
49810
[    7.633190] FS:  0000000000000000(0000) GS:ffff8881b84b1000(0000)
knlGS:0000000000000000
[    7.633779] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.634191] CR2: 00000000004c6000 CR3: 0000000100cd6000 CR4: 00000000000=
006f0
[    7.634710] Call Trace:
[    7.634906]  <TASK>
[    7.635072]  nvmet_tcp_try_recv_pdu+0x576/0xa50
[    7.635401]  nvmet_tcp_io_work+0x69/0x720
[    7.635724]  process_one_work+0x15b/0x380
[    7.636016]  worker_thread+0x2a5/0x3c0
[    7.636634]  kthread+0xf6/0x1f0
[    7.637463]  ret_from_fork+0x131/0x190
[    7.638067]  ret_from_fork_asm+0x1a/0x30
[    7.638336]  </TASK>
Analysis: The crash occurs in nvmet_tcp_build_pdu_iovec() during an
out-of-bounds read of the scatterlist. In our controlled test, the RAX
register correctly reflects the injected pattern 0xdeadbeefdeadbeec,
and the kernel attempts to dereference 0xdeadbeefdeadbef8 (calculated
from our input), leading to a General Protection Fault.

This confirms that by sending a malformed PDU with a large data_length
or data_offset, an attacker can force the kernel to walk past the
allocated cmd->req.sg pointers and treat adjacent heap data as a
struct scatterlist.

Proposed Mitigation: The proposed patch adds critical bounds checks on
sg_idx and sg_remaining within nvmet_tcp_build_pdu_iovec(). These
checks ensure the loop terminates correctly even when provided with
inconsistent PDU metadata.

I would appreciate any feedback or suggestions on this patch.

Thanks, YunJe Shin

On Tue, Feb 3, 2026 at 12:47=E2=80=AFPM yunje shin <yjshin0438@gmail.com> w=
rote:
>
> Just a gentle ping on this patch.
>
> This fixes a crash/GPF observed in _copy_to_iter() when
> nvmet_tcp_build_pdu_iovec() walks past cmd->req.sg or uses invalid
> sg->length/offset, triggered by malformed PDU length/offset. The patch
> adds bounds checks on sg_idx/remaining entries and validates
> sg->length/offset before building the bvec.
>
> Also, the Reviewed-by tags in the original posting were obtained via
> private discussion; I=E2=80=99d appreciate an on-list re-review (or I can
> resend a v2 without those tags if preferred).
>
> Thanks,
> YunJe Shin
>
> On Fri, Jan 30, 2026 at 12:44=E2=80=AFPM yunje shin <yjshin0438@gmail.com=
> wrote:
> >
> > The Reviewed-by tags mentioned in the earlier thread were obtained
> > through private discussion, which kbusch likely wasn't aware of. Could
> > the maintainers please re-review this patch?
> >
> > On Fri, Jan 30, 2026 at 12:43=E2=80=AFPM yunje shin <yjshin0438@gmail.c=
om> wrote:
> > >
> > > The Reviewed-by tags mentioned in the earlier thread were obtained
> > > through private discussion, which Keith likely wasn't aware of. Could
> > > the maintainers please re-review this patch?
> > >
> > > On Fri, Jan 30, 2026 at 12:39=E2=80=AFPM yunje shin <yjshin0438@gmail=
.com> wrote:
> > > >
> > > > [  104.528480] BUG: unable to handle page fault for address: ffff88=
8002b42660
> > > > [  104.528773] #PF: supervisor write access in kernel mode
> > > > [  104.528938] #PF: error_code(0x0003) - permissions violation
> > > > [  104.529151] PGD 3a01067 P4D 3a01067 PUD 3a02067 PMD 4f24063 PTE
> > > > 8000000002b42121
> > > > [  104.529476] Oops: Oops: 0003 [#1] SMP NOPTI
> > > > [  104.529817] CPU: 0 UID: 0 PID: 63 Comm: kworker/0:1H Not tainted
> > > > 6.19.0-rc7 #1 PREEMPT(voluntary
> > > > [  104.530090] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
> > > > 1996), BIOS 1.16.3-debian-1.16.34
> > > > [  104.530440] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
> > > > [  104.530849] RIP: 0010:_copy_to_iter+0x27e/0x7a0
> > > > [  104.531077] Code: 01 48 2b 05 a4 2a 2f 01 48 c1 f8 06 48 c1 e0 0=
c
> > > > 48 03 05 a5 2a 2f 01 48 01 f0 7
> > > > [  104.531620] RSP: 0018:ffffc9000021bba8 EFLAGS: 00000246
> > > > [  104.531805] RAX: ffff888002b42660 RBX: 0000000000000008 RCX: 305=
c782f706d742f
> > > > [  104.532019] RDX: 0000000000000008 RSI: ffff88800515c078 RDI: 000=
00000000009a0
> > > > [  104.532243] RBP: ffff888005070218 R08: 0000000000000000 R09: fff=
f888004ed5300
> > > > [  104.532428] R10: 0000000000001000 R11: ffff888003e032e0 R12: fff=
f88800515c078
> > > > [  104.532615] R13: 0000000000000000 R14: 0000000000000008 R15: 000=
0000000004080
> > > > [  104.532821] FS:  0000000000000000(0000) GS:ffff8880fa4a4000(0000=
)
> > > > knlGS:0000000000000000
> > > > [  104.533048] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [  104.533222] CR2: ffff888002b42660 CR3: 0000000004fec000 CR4: 000=
00000000006f0
> > > > [  104.533483] Call Trace:
> > > > [  104.533957]  <TASK>
> > > > [  104.534195]  ? __pfx_simple_copy_to_iter+0x10/0x10
> > > > [  104.534381]  __skb_datagram_iter+0x1a7/0x2e0
> > > > [  104.534541]  ? __pfx_simple_copy_to_iter+0x10/0x10
> > > > [  104.534671]  skb_copy_datagram_iter+0x2f/0x90
> > > > [  104.534811]  tcp_recvmsg_locked+0x784/0x9d0
> > > > [  104.534936]  tcp_recvmsg+0x81/0x1e0
> > > > [  104.535045]  inet_recvmsg+0x50/0x130
> > > > [  104.535166]  ? security_socket_recvmsg+0x43/0x60
> > > > [  104.535294]  sock_recvmsg+0xa1/0xc0
> > > > [  104.535381]  nvmet_tcp_io_work+0xdb/0x720
> > > > [  104.535476]  process_one_work+0x15b/0x380
> > > > [  104.535570]  worker_thread+0x2a5/0x3c0
> > > > [  104.535653]  ? __pfx_worker_thread+0x10/0x10
> > > > [  104.535747]  kthread+0xf6/0x1f0
> > > > [  104.535839]  ? __pfx_kthread+0x10/0x10
> > > > [  104.535949]  ? __pfx_kthread+0x10/0x10
> > > > [  104.536060]  ret_from_fork+0x131/0x190
> > > > [  104.536182]  ? __pfx_kthread+0x10/0x10
> > > > [  104.536296]  ret_from_fork_asm+0x1a/0x30
> > > > [  104.536451]  </TASK>
> > > > [  104.536545] Modules linked in:
> > > > [  104.536764] CR2: ffff888002b42660
> > > > [  104.537046] ---[ end trace 0000000000000000 ]---
> > > > [  104.537291] RIP: 0010:_copy_to_iter+0x27e/0x7a0
> > > > [  104.537412] Code: 01 48 2b 05 a4 2a 2f 01 48 c1 f8 06 48 c1 e0 0=
c
> > > > 48 03 05 a5 2a 2f 01 48 01 f0 7
> > > > [  104.537848] RSP: 0018:ffffc9000021bba8 EFLAGS: 00000246
> > > > [  104.538005] RAX: ffff888002b42660 RBX: 0000000000000008 RCX: 305=
c782f706d742f
> > > > [  104.538229] RDX: 0000000000000008 RSI: ffff88800515c078 RDI: 000=
00000000009a0
> > > > [  104.538416] RBP: ffff888005070218 R08: 0000000000000000 R09: fff=
f888004ed5300
> > > > [  104.538617] R10: 0000000000001000 R11: ffff888003e032e0 R12: fff=
f88800515c078
> > > > [  104.538825] R13: 0000000000000000 R14: 0000000000000008 R15: 000=
0000000004080
> > > > [  104.538999] FS:  0000000000000000(0000) GS:ffff8880fa4a4000(0000=
)
> > > > knlGS:0000000000000000
> > > > [  104.539209] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > [  104.539340] CR2: ffff888002b42660 CR3: 0000000004fec000 CR4: 000=
00000000006f0
> > > > [  104.539553] note: kworker/0:1H[63] exited with irqs disabled
> > > > [  104.540201] kworker/0:1H (63) used greatest stack depth: 12976 b=
ytes left
> > > > ~ $ uname -a
> > > > Linux (none) 6.19.0-rc7 #1 SMP PREEMPT_DYNAMIC Fri Jan 30 09:36:44 =
KST
> > > > 2026 x86_64 GNU/Linux
> > > >
> > > > On Wed, Jan 28, 2026 at 9:41=E2=80=AFAM YunJe Shin <yjshin0438@gmai=
l.com> wrote:
> > > > >
> > > > > nvmet_tcp_build_pdu_iovec() could walk past cmd->req.sg when a PD=
U
> > > > > length or offset exceeds sg_cnt and then use bogus sg->length/off=
set
> > > > > values, leading to _copy_to_iter() GPF/KASAN. Guard sg_idx, remai=
ning
> > > > > entries, and sg->length/offset before building the bvec.
> > > > >
> > > > > Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver"=
)
> > > > > Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
> > > > > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > > > > Reviewed-by: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
> > > > > ---
> > > > >  drivers/nvme/target/tcp.c | 17 +++++++++++++++++
> > > > >  1 file changed, 17 insertions(+)
> > > > >
> > > > > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.=
c
> > > > > index 15416ff0eac4..1a62b405d8e6 100644
> > > > > --- a/drivers/nvme/target/tcp.c
> > > > > +++ b/drivers/nvme/target/tcp.c
> > > > > @@ -349,11 +349,14 @@ static void nvmet_tcp_free_cmd_buffers(stru=
ct nvmet_tcp_cmd *cmd)
> > > > >         cmd->req.sg =3D NULL;
> > > > >  }
> > > > >
> > > > > +static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue)=
;
> > > > > +
> > > > >  static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
> > > > >  {
> > > > >         struct bio_vec *iov =3D cmd->iov;
> > > > >         struct scatterlist *sg;
> > > > >         u32 length, offset, sg_offset;
> > > > > +       unsigned int sg_remaining;
> > > > >         int nr_pages;
> > > > >
> > > > >         length =3D cmd->pdu_len;
> > > > > @@ -361,9 +364,22 @@ static void nvmet_tcp_build_pdu_iovec(struct=
 nvmet_tcp_cmd *cmd)
> > > > >         offset =3D cmd->rbytes_done;
> > > > >         cmd->sg_idx =3D offset / PAGE_SIZE;
> > > > >         sg_offset =3D offset % PAGE_SIZE;
> > > > > +       if (!cmd->req.sg_cnt || cmd->sg_idx >=3D cmd->req.sg_cnt)=
 {
> > > > > +               nvmet_tcp_fatal_error(cmd->queue);
> > > > > +               return;
> > > > > +       }
> > > > >         sg =3D &cmd->req.sg[cmd->sg_idx];
> > > > > +       sg_remaining =3D cmd->req.sg_cnt - cmd->sg_idx;
> > > > >
> > > > >         while (length) {
> > > > > +               if (!sg_remaining) {
> > > > > +                       nvmet_tcp_fatal_error(cmd->queue);
> > > > > +                       return;
> > > > > +               }
> > > > > +               if (!sg->length || sg->length <=3D sg_offset) {
> > > > > +                       nvmet_tcp_fatal_error(cmd->queue);
> > > > > +                       return;
> > > > > +               }
> > > > >                 u32 iov_len =3D min_t(u32, length, sg->length - s=
g_offset);
> > > > >
> > > > >                 bvec_set_page(iov, sg_page(sg), iov_len,
> > > > > @@ -371,6 +387,7 @@ static void nvmet_tcp_build_pdu_iovec(struct =
nvmet_tcp_cmd *cmd)
> > > > >
> > > > >                 length -=3D iov_len;
> > > > >                 sg =3D sg_next(sg);
> > > > > +               sg_remaining--;
> > > > >                 iov++;
> > > > >                 sg_offset =3D 0;
> > > > >         }
> > > > > --
> > > > > 2.43.0
> > > > >

