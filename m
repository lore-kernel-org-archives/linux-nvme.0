Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C72BDD73EB8
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 03:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F0ekrzJIa9HJVTuj7Ir+IfKbY0ginoQLXCkUQXIpdy0=; b=pOw82v92baF3U4lB9i7DwvICHf
	18J0fsl8UeZKAKc4xmnKg1P2eobDvledFNEPvkPhBhvE80KdKUBp2Cnizq2xFC9oEjQoX+dPRqCoY
	vOQcBSn+RTjLRzZt77YtGHWsiNIK3ofGlbUTLWhrwir+K0i/t77ro09GX4EkCWiGqf1Aa7NAvDmP/
	o0on/7zXFC4WTVBszwGDhSTtSxpzNk/Nn5EPinGFFU6aRF9xJEIPp+Tms9szoG6mQO3k/2EgifkGZ
	ylWzEP2YvnfeItr5gwlUTYi4AmJ4BqANAqiS/6K0NS0whdD6VvpR4vpuXw9no4puf1GjpmQL4xpk6
	fcqSzjLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlfRL-00000000yRp-3BIB;
	Fri, 30 Jan 2026 03:44:59 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlfRD-00000000yQV-0iNN
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 03:44:58 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-34c3259da34so1085458a91.2
        for <linux-nvme@lists.infradead.org>; Thu, 29 Jan 2026 19:44:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769744690; cv=none;
        d=google.com; s=arc-20240605;
        b=XF+gGVpOpxGMpqRkFPoEz7kL0O9U5mdVbPNlDczsC+dtaJs/z88Y+K11OnT7tdkUjy
         aBzPQq0wSFya0som3M1LesDKFO7hfHQHRF9yAyVxaGIZCiaDiZNSSZSj4aQT6djBvVDA
         Lq8Vc+AnU4kpU/fSC8h89DQ1sE0iHf//yD0m4UMZ/KZ1VgdP/A6BUHBhm1wUdWz51MFF
         WJRFUkNbck0FdKRF+G4Js0DZcXWinZXF0dJUsjHQu6Wn6XH6oJ5N7sfBGA1VYRZMAqgv
         yuAfDZ7Zfp+KInQawx79yaWwVNJylZRVJcz7qBqxAso0PhV3+gi2LjA7bo4hh5vB+RFF
         1yRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F0ekrzJIa9HJVTuj7Ir+IfKbY0ginoQLXCkUQXIpdy0=;
        fh=2dOyO4KW1xk7KsINhamJO/z35w43UuxhvTH/0BKz/VM=;
        b=aelTDsZT8fxh9yH7t72UsTDvRPN0dMFOfe9TlRlGxa6zRo3ebMvrvCJzLeK2RK0trH
         YXqQW0HbITnwueZtL7ZZNu4YZ5cYg6i1XkUqcBnt7Xx0ttP3MAuvH9I/S7K45eQppP5T
         LptEZQ77QmlcNQ7xwW+cI+zkqTb7UGNE5whN+3TLViDv9yvHsNSQuotYekSXjV5yh4eL
         9RHd1BjyVFsOEjAoXM8UoM2MwyUGPe0lg3u+SsopzIpVhfUEVTn0QTtFs9CfeThwjRzq
         XcF215WBzyOUTGzOzht3vEeTYi49ZXwTmhKVD6Ix33gY82Bgt/rhDA/pDtBvJ1OI5AgC
         YiPQ==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769744690; x=1770349490; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0ekrzJIa9HJVTuj7Ir+IfKbY0ginoQLXCkUQXIpdy0=;
        b=lpzocBz5wrq2hWqRKmfLww0/yE3hCxt0mOprn7H5mCBuOoV0zAy8P479PJYgAPykyt
         2sq//ndA+0zHwq2ZnbXRVNg6EFD+q8IhkRQzkchCJ6F1e17OhW1wBDabMeZQkOaZbF68
         JoxL3sfop6mpAecdNFhYPx7Y6tajS/gKAiiRpgApa2bWT56pvVBEQq2ec9StbQkSBOBr
         UGYQLStkb/Db2kSoOSg+EZ2a/VKlWq73fyl2rS8tDtVaKNkf2vexKTPngeptFBJiZ8A5
         ogZe7BNeIaJoc6VjUKd4qTyQ9UqrK64CVai39KEZHII/qxG7CD+/pQLkjQYpjETPrOdj
         hZkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769744690; x=1770349490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F0ekrzJIa9HJVTuj7Ir+IfKbY0ginoQLXCkUQXIpdy0=;
        b=HHUjZjB0Wkqt+aRm2c4iNoKGzmNThAALdbW9+gLojhQjW2nzfsDvbMsvbkX/URAaEE
         mQGDsSDt0B8GqW0bzCk45uZO9MvdBDQgIsemxfuKqoIX2/eTPyBts5QnrDR3sEr74I0v
         7jigXv+BGRKT/0k8pEx/XTmK43BEL3RCT+sTCjrjvH23s+tBVby5OymEauLV1HaskOoV
         6SO4PxAbqTwg9qramhfqxryjSMWyZEdiIg38SkbMrD7DcuC+SdkOttpKubqk97C4fqgu
         337vudbpPfRlQbMFkRZVXrQB77E1L76CkpSaC/8Q70hS76DaLMZ/lfkqWHlap5vYEfRV
         Mgww==
X-Gm-Message-State: AOJu0YyBMSG0BpXOq6YhNUG3c8ti1YNMJBbSFFH+HzfhjjJPiWEwEvzJ
	quv6MLOscQ7Ke9d+XGWeUIht+x3kRKyiyVgp71nYk9HOhuEGsZXafQTGt1dNFM5s2pg1GcPXPxi
	hUc/ARUamyVZ9Fh2h89pXPmp6TGDvD8j36vFFAJ6X7g==
X-Gm-Gg: AZuq6aInJ9kOGoPMDJAhkUxMZq9bzSwcaqFoHzlfktP8dCxGbvR8QcpFw/NuHylbij9
	Q7japr2lf9HISFXQCGx/tRkpS9xUXIn9PK07gWr29Iv+iFkvapTtkNijbO/ggyS2vVJAbtSR9jB
	AriXnzuoY+dsyIGB/4Rhpq/lLhJZYc8IWn5Xw+UZYWi1EV/bfmi5R8kpcKT1NWHSyF90pC5/Qko
	u3rOcF3faUAr/fjp+J3wfFyMIu2ajDrhU6dT8OaOSrFzk27txc5TaHNLvTuRAo0sIQiliINvA==
X-Received: by 2002:a17:90a:c2c6:b0:353:4f7:cc3a with SMTP id
 98e67ed59e1d1-3543b1b3d47mr1629832a91.0.1769744690031; Thu, 29 Jan 2026
 19:44:50 -0800 (PST)
MIME-Version: 1.0
References: <678f42fb-521e-4b5e-b662-331e424ca003@grimberg.me>
 <20260128004136.946596-1-ioerts@kookmin.ac.kr> <CAMX6_QEujcQ6137p2uBZ=4sgpZ_4PCRE1fV6VgXha_ZiYxpNQQ@mail.gmail.com>
 <CAMX6_QG54YV-_4UDUtVrnSp006NZxOMiEEb6_dRqWAW6qSS-2g@mail.gmail.com>
In-Reply-To: <CAMX6_QG54YV-_4UDUtVrnSp006NZxOMiEEb6_dRqWAW6qSS-2g@mail.gmail.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Fri, 30 Jan 2026 12:44:38 +0900
X-Gm-Features: AZwV_QhQqFGTcv3libkpeCxFWep5uJx-BkkHVc56SR_DCO_wRCDdAzIvkgIDno0
Message-ID: <CAMX6_QE+8EdnrFp6iFifK9i7aYLwmAewRn+k=2OfC_QiRkLKhw@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec
To: kbusch@kernel.org, sagi@grimberg.me, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org, 
	security@kernel.org, YunJe Shin <ioerts@kookmin.ac.kr>, joonkyoj@yonsei.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_194451_220935_95968919 
X-CRM114-Status: GOOD (  23.31  )
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

The Reviewed-by tags mentioned in the earlier thread were obtained
through private discussion, which kbusch likely wasn't aware of. Could
the maintainers please re-review this patch?

On Fri, Jan 30, 2026 at 12:43=E2=80=AFPM yunje shin <yjshin0438@gmail.com> =
wrote:
>
> The Reviewed-by tags mentioned in the earlier thread were obtained
> through private discussion, which Keith likely wasn't aware of. Could
> the maintainers please re-review this patch?
>
> On Fri, Jan 30, 2026 at 12:39=E2=80=AFPM yunje shin <yjshin0438@gmail.com=
> wrote:
> >
> > [  104.528480] BUG: unable to handle page fault for address: ffff888002=
b42660
> > [  104.528773] #PF: supervisor write access in kernel mode
> > [  104.528938] #PF: error_code(0x0003) - permissions violation
> > [  104.529151] PGD 3a01067 P4D 3a01067 PUD 3a02067 PMD 4f24063 PTE
> > 8000000002b42121
> > [  104.529476] Oops: Oops: 0003 [#1] SMP NOPTI
> > [  104.529817] CPU: 0 UID: 0 PID: 63 Comm: kworker/0:1H Not tainted
> > 6.19.0-rc7 #1 PREEMPT(voluntary
> > [  104.530090] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
> > 1996), BIOS 1.16.3-debian-1.16.34
> > [  104.530440] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
> > [  104.530849] RIP: 0010:_copy_to_iter+0x27e/0x7a0
> > [  104.531077] Code: 01 48 2b 05 a4 2a 2f 01 48 c1 f8 06 48 c1 e0 0c
> > 48 03 05 a5 2a 2f 01 48 01 f0 7
> > [  104.531620] RSP: 0018:ffffc9000021bba8 EFLAGS: 00000246
> > [  104.531805] RAX: ffff888002b42660 RBX: 0000000000000008 RCX: 305c782=
f706d742f
> > [  104.532019] RDX: 0000000000000008 RSI: ffff88800515c078 RDI: 0000000=
0000009a0
> > [  104.532243] RBP: ffff888005070218 R08: 0000000000000000 R09: ffff888=
004ed5300
> > [  104.532428] R10: 0000000000001000 R11: ffff888003e032e0 R12: ffff888=
00515c078
> > [  104.532615] R13: 0000000000000000 R14: 0000000000000008 R15: 0000000=
000004080
> > [  104.532821] FS:  0000000000000000(0000) GS:ffff8880fa4a4000(0000)
> > knlGS:0000000000000000
> > [  104.533048] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  104.533222] CR2: ffff888002b42660 CR3: 0000000004fec000 CR4: 0000000=
0000006f0
> > [  104.533483] Call Trace:
> > [  104.533957]  <TASK>
> > [  104.534195]  ? __pfx_simple_copy_to_iter+0x10/0x10
> > [  104.534381]  __skb_datagram_iter+0x1a7/0x2e0
> > [  104.534541]  ? __pfx_simple_copy_to_iter+0x10/0x10
> > [  104.534671]  skb_copy_datagram_iter+0x2f/0x90
> > [  104.534811]  tcp_recvmsg_locked+0x784/0x9d0
> > [  104.534936]  tcp_recvmsg+0x81/0x1e0
> > [  104.535045]  inet_recvmsg+0x50/0x130
> > [  104.535166]  ? security_socket_recvmsg+0x43/0x60
> > [  104.535294]  sock_recvmsg+0xa1/0xc0
> > [  104.535381]  nvmet_tcp_io_work+0xdb/0x720
> > [  104.535476]  process_one_work+0x15b/0x380
> > [  104.535570]  worker_thread+0x2a5/0x3c0
> > [  104.535653]  ? __pfx_worker_thread+0x10/0x10
> > [  104.535747]  kthread+0xf6/0x1f0
> > [  104.535839]  ? __pfx_kthread+0x10/0x10
> > [  104.535949]  ? __pfx_kthread+0x10/0x10
> > [  104.536060]  ret_from_fork+0x131/0x190
> > [  104.536182]  ? __pfx_kthread+0x10/0x10
> > [  104.536296]  ret_from_fork_asm+0x1a/0x30
> > [  104.536451]  </TASK>
> > [  104.536545] Modules linked in:
> > [  104.536764] CR2: ffff888002b42660
> > [  104.537046] ---[ end trace 0000000000000000 ]---
> > [  104.537291] RIP: 0010:_copy_to_iter+0x27e/0x7a0
> > [  104.537412] Code: 01 48 2b 05 a4 2a 2f 01 48 c1 f8 06 48 c1 e0 0c
> > 48 03 05 a5 2a 2f 01 48 01 f0 7
> > [  104.537848] RSP: 0018:ffffc9000021bba8 EFLAGS: 00000246
> > [  104.538005] RAX: ffff888002b42660 RBX: 0000000000000008 RCX: 305c782=
f706d742f
> > [  104.538229] RDX: 0000000000000008 RSI: ffff88800515c078 RDI: 0000000=
0000009a0
> > [  104.538416] RBP: ffff888005070218 R08: 0000000000000000 R09: ffff888=
004ed5300
> > [  104.538617] R10: 0000000000001000 R11: ffff888003e032e0 R12: ffff888=
00515c078
> > [  104.538825] R13: 0000000000000000 R14: 0000000000000008 R15: 0000000=
000004080
> > [  104.538999] FS:  0000000000000000(0000) GS:ffff8880fa4a4000(0000)
> > knlGS:0000000000000000
> > [  104.539209] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  104.539340] CR2: ffff888002b42660 CR3: 0000000004fec000 CR4: 0000000=
0000006f0
> > [  104.539553] note: kworker/0:1H[63] exited with irqs disabled
> > [  104.540201] kworker/0:1H (63) used greatest stack depth: 12976 bytes=
 left
> > ~ $ uname -a
> > Linux (none) 6.19.0-rc7 #1 SMP PREEMPT_DYNAMIC Fri Jan 30 09:36:44 KST
> > 2026 x86_64 GNU/Linux
> >
> > On Wed, Jan 28, 2026 at 9:41=E2=80=AFAM YunJe Shin <yjshin0438@gmail.co=
m> wrote:
> > >
> > > nvmet_tcp_build_pdu_iovec() could walk past cmd->req.sg when a PDU
> > > length or offset exceeds sg_cnt and then use bogus sg->length/offset
> > > values, leading to _copy_to_iter() GPF/KASAN. Guard sg_idx, remaining
> > > entries, and sg->length/offset before building the bvec.
> > >
> > > Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> > > Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
> > > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > > Reviewed-by: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
> > > ---
> > >  drivers/nvme/target/tcp.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > >
> > > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > > index 15416ff0eac4..1a62b405d8e6 100644
> > > --- a/drivers/nvme/target/tcp.c
> > > +++ b/drivers/nvme/target/tcp.c
> > > @@ -349,11 +349,14 @@ static void nvmet_tcp_free_cmd_buffers(struct n=
vmet_tcp_cmd *cmd)
> > >         cmd->req.sg =3D NULL;
> > >  }
> > >
> > > +static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue);
> > > +
> > >  static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
> > >  {
> > >         struct bio_vec *iov =3D cmd->iov;
> > >         struct scatterlist *sg;
> > >         u32 length, offset, sg_offset;
> > > +       unsigned int sg_remaining;
> > >         int nr_pages;
> > >
> > >         length =3D cmd->pdu_len;
> > > @@ -361,9 +364,22 @@ static void nvmet_tcp_build_pdu_iovec(struct nvm=
et_tcp_cmd *cmd)
> > >         offset =3D cmd->rbytes_done;
> > >         cmd->sg_idx =3D offset / PAGE_SIZE;
> > >         sg_offset =3D offset % PAGE_SIZE;
> > > +       if (!cmd->req.sg_cnt || cmd->sg_idx >=3D cmd->req.sg_cnt) {
> > > +               nvmet_tcp_fatal_error(cmd->queue);
> > > +               return;
> > > +       }
> > >         sg =3D &cmd->req.sg[cmd->sg_idx];
> > > +       sg_remaining =3D cmd->req.sg_cnt - cmd->sg_idx;
> > >
> > >         while (length) {
> > > +               if (!sg_remaining) {
> > > +                       nvmet_tcp_fatal_error(cmd->queue);
> > > +                       return;
> > > +               }
> > > +               if (!sg->length || sg->length <=3D sg_offset) {
> > > +                       nvmet_tcp_fatal_error(cmd->queue);
> > > +                       return;
> > > +               }
> > >                 u32 iov_len =3D min_t(u32, length, sg->length - sg_of=
fset);
> > >
> > >                 bvec_set_page(iov, sg_page(sg), iov_len,
> > > @@ -371,6 +387,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvme=
t_tcp_cmd *cmd)
> > >
> > >                 length -=3D iov_len;
> > >                 sg =3D sg_next(sg);
> > > +               sg_remaining--;
> > >                 iov++;
> > >                 sg_offset =3D 0;
> > >         }
> > > --
> > > 2.43.0
> > >

