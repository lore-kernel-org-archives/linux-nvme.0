Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F406E8304A
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Feb 2026 03:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xe8aE3nPr+ogvsQOrWBSXN5HcLuk27znPxxBgR1K1CU=; b=CnEDyAYLcEoiNISBJg1F8WkuNT
	xe67TgNmwlcSGClOrIDOSn8ei8VIzUz5IObPLnxUKTUcC+NjdfE3pFm6QhP2aMGZyBcH8bNqwtQRX
	pV3clacgD1lH2NlCqHOh3pZuiP4dtqCQxFxG3CkGMltci8OPOYK+AmSbxgKO9l6xXdxhb44lIFRwL
	nfWPB+xQYKOhh3kHpQNw1KDfYq08M6pR9uQldsx/OdWwlp9iGo8Htx/NW/V2CTD/+ucC6UREqji5i
	BCrU06hTsU4t61IoXj0x59WB3krMRu9Pi8m5NUI7ZYuu1hIaR8Am1giOH1izdnQ3oNg+BAcRNQKYy
	mfgtsfjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn7OK-000000061jG-2TOI;
	Tue, 03 Feb 2026 03:47:52 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vn7OC-000000061iq-2VwK
	for linux-nvme@lists.infradead.org;
	Tue, 03 Feb 2026 03:47:49 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so2014794a12.3
        for <linux-nvme@lists.infradead.org>; Mon, 02 Feb 2026 19:47:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770090463; cv=none;
        d=google.com; s=arc-20240605;
        b=BK/pjMGigZQFafihfcrvKK7zc0IT7Q5shNeTfrKIFeRQPG6ZCTbFix2H4az0LRTYGi
         QyPw7U4bs7Ci9xfxB9CP4694kFP3l/7+eV47g8aGv7I89laOwUxqWzev2pfOddqaVq2A
         CjL0al0ozs6l8c+O/R1m8LhNMz3uVdrPzHu7ShiQ1ZFO1WXPGEGjrFSq00vrz5s6J6fr
         tKBiD1ae9IfnlebUwyp/LKVgl8wHbfMlDs1eKViayVj1pT/YifbS2QMg5X0aZwoSazyS
         WMStwKbdmR9ZwyTGDWovYkw9c6Vfur5lY8+pEtP/IAuHKsRxQDcewBdVOm1gsnwwHg5X
         T6dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xe8aE3nPr+ogvsQOrWBSXN5HcLuk27znPxxBgR1K1CU=;
        fh=UhcU8NN0arRB/4eqkBnjNZYFphfjC5zaArPqRKs/xsc=;
        b=WQ/5LfvYCfvquWIXQafX9UrncCsrB6gISK8p8ScVxaQ317jWQ79U2MYNDoVIbzCIpi
         f8qn3M7UOLuetE+hW4kBwbHOLK7KNOQ9bUNoYHdyH/uw470Y5CbkVKQsntQLQHn3ZAaK
         h8iKwY3u9f/lOcyV1hJdd14bJ+CZu7AjO215CbvJbvAn+lvnuONs9W0/4ljwk5eQp9rP
         8l/rEcNLQNmdfgHja7Y5e1vRcoY4D9IQZtTVDDLOcHez6pby+Qub4YPJIIuctdCKOMIg
         UgRE2ZGkhRcNKT4Un3CpyUEhhLjsUYSUFKTOPeMHBzmy0Edak2lpOAMSHpJ4623xCMmL
         zTJA==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770090463; x=1770695263; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xe8aE3nPr+ogvsQOrWBSXN5HcLuk27znPxxBgR1K1CU=;
        b=T1q9hTS7WPTLX10BMG++r5O9pev/QtxpfKGH5MBT26J1BVxSB/ytBHZB5BqZp7Hb1b
         m61XGq2Oig4nEOwfwfW8jEF2ZgPq3JHkvhRN2eSfeNd7TGcOuLYigrTlHUxekmNIYNf8
         XF79zB7PBkHNWWYAUkEBAC5evjBuNQY5cfWu8QqgQ3n7BrnTvz75ZWH3lyd6K2qpy/IY
         W0ZGoxxpIwzUaF38xkFLF+tHNsa9Gx/G/T2/vr91EHRr7kv5bT0c6v0HPlWLTN30tyU7
         3BxeQmN0hJJgiopYR5BvgqcPw4fXSKZvmQPREBsacCvm6hx/Hcp2cQarn9dmDRS7/bBK
         Ikcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770090463; x=1770695263;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xe8aE3nPr+ogvsQOrWBSXN5HcLuk27znPxxBgR1K1CU=;
        b=b7Hh7vbO97yee2b2K2rZ0DEcFum2PXT9HcV7GJSVEkqaIBSFVvU6V+IzXB9xHAFbzh
         a4gMzXaecKxq9ymOkMFdYDUUQbux3lb+7ZDwReUdWdqGU6jn9ecpxED/Q/Z72UxTk1jp
         2gV68ckVvSZQiu0nz16K8vRX0Tk1YjSw06wODJmTLS83TakBxLRr0Bj3uObdsi1JQJ+X
         yVCHO5nrVLx3Mft3yZvfXQcWCWlkJcgmOsd2EzGIdgnXijiZkCpvHySqm+GzCsHFk4Pg
         gSLNfIqTCqg1uNVJbtaPlaUC/9z6K/Ra6LU+mVgP51wbYELpsQYAURNEPGHS7jLr8ShJ
         prPw==
X-Forwarded-Encrypted: i=1; AJvYcCVAqqCdMhwQXLSfTtBH1ET6vkk1FgtNony654VUoqilTKsg5EBpVHPn8cRx2lBxIgQR4PHVi0W8nsLW@lists.infradead.org
X-Gm-Message-State: AOJu0YxPX/FrxWeGGBpXMWi4JQ09Vbhwyn9g8PrBdFAc7tWmI3HKpVBF
	4Ckp/4/c64N0gBGipRfI1XJLdGuXF18ASMl/hZ83fzF1oIBLL67lGWcvtAqRzJTzs+4evUh3CVO
	M1pxnN4UPj3lp9j93qwkqBsWFCjqf4L0=
X-Gm-Gg: AZuq6aI876ZuGf5gXxl/3IszEx4lSTeYTaKwH96SVhJBTSFMyDhKkNhQYp+ue1RkJbR
	lOYk95WLO6K4DUpVAe8F+qAhUtmc3/E1aMYB9ELn5Ccu60fHNVBrXHY6HqBvMH/jHBwL7M0gErf
	gmcEPiwgC2nx8YlnQ4+HIztNWO2ROFGs6zXVABqRgY9XtgatrLM/YNovtZ1S3mJEvxLPzOlIcLe
	b1J2hQrP0NnCmxLZeiqAtsP/MlRpJdqG4obfAUYQPZkOlA+HzWDH+Cwxpqu/rLXpQH1UE1eVQ==
X-Received: by 2002:a17:90b:50c3:b0:32b:9774:d340 with SMTP id
 98e67ed59e1d1-3543b3f3682mr13387066a91.33.1770090463070; Mon, 02 Feb 2026
 19:47:43 -0800 (PST)
MIME-Version: 1.0
References: <678f42fb-521e-4b5e-b662-331e424ca003@grimberg.me>
 <20260128004136.946596-1-ioerts@kookmin.ac.kr> <CAMX6_QEujcQ6137p2uBZ=4sgpZ_4PCRE1fV6VgXha_ZiYxpNQQ@mail.gmail.com>
 <CAMX6_QG54YV-_4UDUtVrnSp006NZxOMiEEb6_dRqWAW6qSS-2g@mail.gmail.com> <CAMX6_QE+8EdnrFp6iFifK9i7aYLwmAewRn+k=2OfC_QiRkLKhw@mail.gmail.com>
In-Reply-To: <CAMX6_QE+8EdnrFp6iFifK9i7aYLwmAewRn+k=2OfC_QiRkLKhw@mail.gmail.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Tue, 3 Feb 2026 12:47:32 +0900
X-Gm-Features: AZwV_QhvnHvAnILFqXrJv-TiUVYfHId3qOvzT3gOh3oQv3TuNbH9kFLuQaPWmLQ
Message-ID: <CAMX6_QEkN=0eN68DdWMn5TukiUPvJaX09q4hWyUTWNZrQZv7nQ@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec
To: kbusch@kernel.org, sagi@grimberg.me, Christoph Hellwig <hch@lst.de>, 
	linux-nvme@lists.infradead.org
Cc: gregkh@linuxfoundation.org, security@kernel.org, 
	YunJe Shin <ioerts@kookmin.ac.kr>, joonkyoj@yonsei.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260202_194744_676157_58D80F77 
X-CRM114-Status: GOOD (  26.26  )
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

Just a gentle ping on this patch.

This fixes a crash/GPF observed in _copy_to_iter() when
nvmet_tcp_build_pdu_iovec() walks past cmd->req.sg or uses invalid
sg->length/offset, triggered by malformed PDU length/offset. The patch
adds bounds checks on sg_idx/remaining entries and validates
sg->length/offset before building the bvec.

Also, the Reviewed-by tags in the original posting were obtained via
private discussion; I=E2=80=99d appreciate an on-list re-review (or I can
resend a v2 without those tags if preferred).

Thanks,
YunJe Shin

On Fri, Jan 30, 2026 at 12:44=E2=80=AFPM yunje shin <yjshin0438@gmail.com> =
wrote:
>
> The Reviewed-by tags mentioned in the earlier thread were obtained
> through private discussion, which kbusch likely wasn't aware of. Could
> the maintainers please re-review this patch?
>
> On Fri, Jan 30, 2026 at 12:43=E2=80=AFPM yunje shin <yjshin0438@gmail.com=
> wrote:
> >
> > The Reviewed-by tags mentioned in the earlier thread were obtained
> > through private discussion, which Keith likely wasn't aware of. Could
> > the maintainers please re-review this patch?
> >
> > On Fri, Jan 30, 2026 at 12:39=E2=80=AFPM yunje shin <yjshin0438@gmail.c=
om> wrote:
> > >
> > > [  104.528480] BUG: unable to handle page fault for address: ffff8880=
02b42660
> > > [  104.528773] #PF: supervisor write access in kernel mode
> > > [  104.528938] #PF: error_code(0x0003) - permissions violation
> > > [  104.529151] PGD 3a01067 P4D 3a01067 PUD 3a02067 PMD 4f24063 PTE
> > > 8000000002b42121
> > > [  104.529476] Oops: Oops: 0003 [#1] SMP NOPTI
> > > [  104.529817] CPU: 0 UID: 0 PID: 63 Comm: kworker/0:1H Not tainted
> > > 6.19.0-rc7 #1 PREEMPT(voluntary
> > > [  104.530090] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
> > > 1996), BIOS 1.16.3-debian-1.16.34
> > > [  104.530440] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
> > > [  104.530849] RIP: 0010:_copy_to_iter+0x27e/0x7a0
> > > [  104.531077] Code: 01 48 2b 05 a4 2a 2f 01 48 c1 f8 06 48 c1 e0 0c
> > > 48 03 05 a5 2a 2f 01 48 01 f0 7
> > > [  104.531620] RSP: 0018:ffffc9000021bba8 EFLAGS: 00000246
> > > [  104.531805] RAX: ffff888002b42660 RBX: 0000000000000008 RCX: 305c7=
82f706d742f
> > > [  104.532019] RDX: 0000000000000008 RSI: ffff88800515c078 RDI: 00000=
000000009a0
> > > [  104.532243] RBP: ffff888005070218 R08: 0000000000000000 R09: ffff8=
88004ed5300
> > > [  104.532428] R10: 0000000000001000 R11: ffff888003e032e0 R12: ffff8=
8800515c078
> > > [  104.532615] R13: 0000000000000000 R14: 0000000000000008 R15: 00000=
00000004080
> > > [  104.532821] FS:  0000000000000000(0000) GS:ffff8880fa4a4000(0000)
> > > knlGS:0000000000000000
> > > [  104.533048] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  104.533222] CR2: ffff888002b42660 CR3: 0000000004fec000 CR4: 00000=
000000006f0
> > > [  104.533483] Call Trace:
> > > [  104.533957]  <TASK>
> > > [  104.534195]  ? __pfx_simple_copy_to_iter+0x10/0x10
> > > [  104.534381]  __skb_datagram_iter+0x1a7/0x2e0
> > > [  104.534541]  ? __pfx_simple_copy_to_iter+0x10/0x10
> > > [  104.534671]  skb_copy_datagram_iter+0x2f/0x90
> > > [  104.534811]  tcp_recvmsg_locked+0x784/0x9d0
> > > [  104.534936]  tcp_recvmsg+0x81/0x1e0
> > > [  104.535045]  inet_recvmsg+0x50/0x130
> > > [  104.535166]  ? security_socket_recvmsg+0x43/0x60
> > > [  104.535294]  sock_recvmsg+0xa1/0xc0
> > > [  104.535381]  nvmet_tcp_io_work+0xdb/0x720
> > > [  104.535476]  process_one_work+0x15b/0x380
> > > [  104.535570]  worker_thread+0x2a5/0x3c0
> > > [  104.535653]  ? __pfx_worker_thread+0x10/0x10
> > > [  104.535747]  kthread+0xf6/0x1f0
> > > [  104.535839]  ? __pfx_kthread+0x10/0x10
> > > [  104.535949]  ? __pfx_kthread+0x10/0x10
> > > [  104.536060]  ret_from_fork+0x131/0x190
> > > [  104.536182]  ? __pfx_kthread+0x10/0x10
> > > [  104.536296]  ret_from_fork_asm+0x1a/0x30
> > > [  104.536451]  </TASK>
> > > [  104.536545] Modules linked in:
> > > [  104.536764] CR2: ffff888002b42660
> > > [  104.537046] ---[ end trace 0000000000000000 ]---
> > > [  104.537291] RIP: 0010:_copy_to_iter+0x27e/0x7a0
> > > [  104.537412] Code: 01 48 2b 05 a4 2a 2f 01 48 c1 f8 06 48 c1 e0 0c
> > > 48 03 05 a5 2a 2f 01 48 01 f0 7
> > > [  104.537848] RSP: 0018:ffffc9000021bba8 EFLAGS: 00000246
> > > [  104.538005] RAX: ffff888002b42660 RBX: 0000000000000008 RCX: 305c7=
82f706d742f
> > > [  104.538229] RDX: 0000000000000008 RSI: ffff88800515c078 RDI: 00000=
000000009a0
> > > [  104.538416] RBP: ffff888005070218 R08: 0000000000000000 R09: ffff8=
88004ed5300
> > > [  104.538617] R10: 0000000000001000 R11: ffff888003e032e0 R12: ffff8=
8800515c078
> > > [  104.538825] R13: 0000000000000000 R14: 0000000000000008 R15: 00000=
00000004080
> > > [  104.538999] FS:  0000000000000000(0000) GS:ffff8880fa4a4000(0000)
> > > knlGS:0000000000000000
> > > [  104.539209] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  104.539340] CR2: ffff888002b42660 CR3: 0000000004fec000 CR4: 00000=
000000006f0
> > > [  104.539553] note: kworker/0:1H[63] exited with irqs disabled
> > > [  104.540201] kworker/0:1H (63) used greatest stack depth: 12976 byt=
es left
> > > ~ $ uname -a
> > > Linux (none) 6.19.0-rc7 #1 SMP PREEMPT_DYNAMIC Fri Jan 30 09:36:44 KS=
T
> > > 2026 x86_64 GNU/Linux
> > >
> > > On Wed, Jan 28, 2026 at 9:41=E2=80=AFAM YunJe Shin <yjshin0438@gmail.=
com> wrote:
> > > >
> > > > nvmet_tcp_build_pdu_iovec() could walk past cmd->req.sg when a PDU
> > > > length or offset exceeds sg_cnt and then use bogus sg->length/offse=
t
> > > > values, leading to _copy_to_iter() GPF/KASAN. Guard sg_idx, remaini=
ng
> > > > entries, and sg->length/offset before building the bvec.
> > > >
> > > > Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> > > > Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
> > > > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > > > Reviewed-by: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
> > > > ---
> > > >  drivers/nvme/target/tcp.c | 17 +++++++++++++++++
> > > >  1 file changed, 17 insertions(+)
> > > >
> > > > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > > > index 15416ff0eac4..1a62b405d8e6 100644
> > > > --- a/drivers/nvme/target/tcp.c
> > > > +++ b/drivers/nvme/target/tcp.c
> > > > @@ -349,11 +349,14 @@ static void nvmet_tcp_free_cmd_buffers(struct=
 nvmet_tcp_cmd *cmd)
> > > >         cmd->req.sg =3D NULL;
> > > >  }
> > > >
> > > > +static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue);
> > > > +
> > > >  static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
> > > >  {
> > > >         struct bio_vec *iov =3D cmd->iov;
> > > >         struct scatterlist *sg;
> > > >         u32 length, offset, sg_offset;
> > > > +       unsigned int sg_remaining;
> > > >         int nr_pages;
> > > >
> > > >         length =3D cmd->pdu_len;
> > > > @@ -361,9 +364,22 @@ static void nvmet_tcp_build_pdu_iovec(struct n=
vmet_tcp_cmd *cmd)
> > > >         offset =3D cmd->rbytes_done;
> > > >         cmd->sg_idx =3D offset / PAGE_SIZE;
> > > >         sg_offset =3D offset % PAGE_SIZE;
> > > > +       if (!cmd->req.sg_cnt || cmd->sg_idx >=3D cmd->req.sg_cnt) {
> > > > +               nvmet_tcp_fatal_error(cmd->queue);
> > > > +               return;
> > > > +       }
> > > >         sg =3D &cmd->req.sg[cmd->sg_idx];
> > > > +       sg_remaining =3D cmd->req.sg_cnt - cmd->sg_idx;
> > > >
> > > >         while (length) {
> > > > +               if (!sg_remaining) {
> > > > +                       nvmet_tcp_fatal_error(cmd->queue);
> > > > +                       return;
> > > > +               }
> > > > +               if (!sg->length || sg->length <=3D sg_offset) {
> > > > +                       nvmet_tcp_fatal_error(cmd->queue);
> > > > +                       return;
> > > > +               }
> > > >                 u32 iov_len =3D min_t(u32, length, sg->length - sg_=
offset);
> > > >
> > > >                 bvec_set_page(iov, sg_page(sg), iov_len,
> > > > @@ -371,6 +387,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nv=
met_tcp_cmd *cmd)
> > > >
> > > >                 length -=3D iov_len;
> > > >                 sg =3D sg_next(sg);
> > > > +               sg_remaining--;
> > > >                 iov++;
> > > >                 sg_offset =3D 0;
> > > >         }
> > > > --
> > > > 2.43.0
> > > >

