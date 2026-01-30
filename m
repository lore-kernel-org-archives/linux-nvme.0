Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87133D73EB8
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 03:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J1v6K8Wxo/OQQ6/7yS8Pfys0LG71ZDagzvFAfruJVow=; b=U3DEw/lNqdyBC5gYY90Em/dYLC
	j4nFFR+V8JlU9/jzt8SL1OGvUTVaaSGAO/8N1VjHZL1LErbj4wV1eNN/AsTR2Q3dStWi7Ssx4MtuP
	Qo2de0KmYqwUXYQMKGlHTrnTVvhXEEda86BzEUv6jU13ipl2TvSlt72YaL7vEjSiTFOHcFK6niPy5
	UvICCwPySWwVcTpGXfy2DS8D8+cVNAlH2LulzHRRxXECCr30WX0YeF7KRB29NuDx/QAoAFi/p5Doz
	0i7mxhUgMa7ILdESeTfEu4QZuzL6CqV7aNvNnKi77FSoADBeQsqiwAkesFJ5CoNrX9kvokeIBvC15
	FY1A7GTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlfQi-00000000yKw-3oEY;
	Fri, 30 Jan 2026 03:44:20 +0000
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlfQc-00000000yKZ-174b
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 03:44:19 +0000
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c626bd75628so588402a12.3
        for <linux-nvme@lists.infradead.org>; Thu, 29 Jan 2026 19:44:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769744653; cv=none;
        d=google.com; s=arc-20240605;
        b=K8kXuYlkUuQZuE+YWXwHbpftRs9+RejAF9qmWEf8TZpKM0TiGh9TvAuxJK5eTV2eU5
         J8pC1IXOmyOMfWqdGvU1XnO4Fsoa28imA42ERzMnFgON8r84EmLgWEgAmB/s727CCO93
         EVbgH0ie0p7OI9zqhNBsa8fzYZHX8eg8Yij+3506dV1pTWJRh1aNthhZCywEARmtyRr9
         y82m5Z9YuRLWMX8u8IsWLmm2wMod0PV4Byd1PoEYFWaeOxlqlBXnRzybPYlAW4Isv4F4
         f3Gec8EmGRc0zz0A1Qu70WsYToYF5/u3pUkW1Da6dEE7Y8hQSZAD1R2PsFoAPF5EdlyE
         YLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J1v6K8Wxo/OQQ6/7yS8Pfys0LG71ZDagzvFAfruJVow=;
        fh=2dOyO4KW1xk7KsINhamJO/z35w43UuxhvTH/0BKz/VM=;
        b=CGnX0gIAEAPXLAaGZAE1ICnI1h2fFlIFXA9SNXH3Z/dV6F1qya2BW7ACZcP5EChmRH
         nTSXOUnFDgfb/waedx3RoKVoScB7NFxkeyEpR44hQf3OjHNq2vKWS5Uk8qLfOL1u4Q09
         PGKlmn6xg/W0e9iUdIianRDJHjQBNdKPzdPyiGmzjJfvuubbMtmZdSFCRJ4FThahKOG/
         NB+ZhLY5RlCErh+OibBksWj9FkQznsjNyCit5Ha97SNG1rq4jgWVR2etVZsJ/qGUzPZh
         YenHj7ztRu3/jBTb7Jg++w9RGkjdQjs8K0Mg2JRha7P8lK+cc2EO7m+eNBAcFzx/8jAm
         er9g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769744653; x=1770349453; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J1v6K8Wxo/OQQ6/7yS8Pfys0LG71ZDagzvFAfruJVow=;
        b=fMWltm0TxXOxpWoIQuZL/yCFseHlKhDKa/nNDN6sVfq/R3a/ufKkmUDiVtTWQDfN3D
         Bf9mAyocllQ5Oy7RC0VuM27+gkWivdwHSGdoeM5q/aRwJfaPAzqBR3M/MCMdmW6G5scU
         xZuIQy9L0TZ+0gMnBhRgVr6N6wvc9lpZnPJG7m9gqYlyX1JZXR++PBjezcy683JqX60F
         ZCQ8bOWJhqaxftRZtaeNhXkFbocJDZuNvmOpG9mWtQfByn42yA1il1mjERUWBgvaGWpJ
         16Ev3mrIWWkc0e2VBdrY5a2sZ9MLbsXcCQCLd2MS60KqAXv4LjwLlWWcnHf9hO1uZaOt
         eTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769744653; x=1770349453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J1v6K8Wxo/OQQ6/7yS8Pfys0LG71ZDagzvFAfruJVow=;
        b=gkuVPjXN/OkWZ44NN/3Rl8YCDqDS0DoKMBx5omzEyMqf+p3iLnMUkc/YJEzMVXsWyR
         OKcWm5w94C6mHkPC+UIZZe85xeEvGetc9LRx0iKZIjb/DTLmrxf2p8F0oRCsO7Ri2nog
         +01fsxd6HLsLuY03RG5xciPAZxu7MgJ1nOIXn8nhFRaufn63ak1wxVTQR2EKeBt/UcYz
         4hkwMHvZiPkPRdZqJi207lAQr9C8tsRhq6DxHZrIkx8aJQghUanBtHRiTmpDFIWia5n0
         TD7deEHnDDdjgIKNwicvm4wpwumUgLDcPLrX+2TCZqRQ/7FLUbXxB3gS0jQHfFduemcR
         rlIg==
X-Gm-Message-State: AOJu0Yx2TzB4Q84ecXmWT8iXbXSjov+XU5Unif2T43Sgwk1+sVcNGjY1
	2o3J97/zpx9VnFTGYWMOe0QWOP6MqHEln5O3E0VfMnQqeFLtSAV9soPtQxESz0Gbpf9oGEHdjV9
	Q6ZTN+innDd6vugOFEI2bH7SKAiuG6qs=
X-Gm-Gg: AZuq6aLDk5DFaJeAx1kbF1w2Lb9FGVuSmkcwlR2/RRRwhsRjPs37WS3m0fS7rTLaDCp
	Q9VRYUXxyJ2ipohce8WB/lqfvjmEnoEJJVhtAWV6E+Mv8Q/qhhEcv03B8OntgsCMtJPaGPDmytQ
	GuLp4Zp2t86aT0J3FH2QMUqqtNRcIBBmyS+nu9OBAqnY5jI770ThREW4Se6pDoqIaz59+/Cx8Sz
	LCdsXZw6pu0D3VR1mTB7Jhzp5TRwtgkgcR1W4jvcWpYDqHDBReDRRDAR26tsfhayKX4vwzk9A==
X-Received: by 2002:a17:90b:3dcf:b0:341:194:5e7d with SMTP id
 98e67ed59e1d1-3543b3b21f1mr1578943a91.24.1769744648866; Thu, 29 Jan 2026
 19:44:08 -0800 (PST)
MIME-Version: 1.0
References: <678f42fb-521e-4b5e-b662-331e424ca003@grimberg.me>
 <20260128004136.946596-1-ioerts@kookmin.ac.kr> <CAMX6_QEujcQ6137p2uBZ=4sgpZ_4PCRE1fV6VgXha_ZiYxpNQQ@mail.gmail.com>
In-Reply-To: <CAMX6_QEujcQ6137p2uBZ=4sgpZ_4PCRE1fV6VgXha_ZiYxpNQQ@mail.gmail.com>
From: yunje shin <yjshin0438@gmail.com>
Date: Fri, 30 Jan 2026 12:43:57 +0900
X-Gm-Features: AZwV_QjpHv_DFQUazYnI80jOYfLqKt1lKpWbpuQmhnnSfC0h0alTgPpjCY_ImQs
Message-ID: <CAMX6_QG54YV-_4UDUtVrnSp006NZxOMiEEb6_dRqWAW6qSS-2g@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec
To: kbusch@kernel.org, sagi@grimberg.me, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org, 
	security@kernel.org, YunJe Shin <ioerts@kookmin.ac.kr>, joonkyoj@yonsei.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_194414_340408_93991033 
X-CRM114-Status: GOOD (  21.88  )
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
through private discussion, which Keith likely wasn't aware of. Could
the maintainers please re-review this patch?

On Fri, Jan 30, 2026 at 12:39=E2=80=AFPM yunje shin <yjshin0438@gmail.com> =
wrote:
>
> [  104.528480] BUG: unable to handle page fault for address: ffff888002b4=
2660
> [  104.528773] #PF: supervisor write access in kernel mode
> [  104.528938] #PF: error_code(0x0003) - permissions violation
> [  104.529151] PGD 3a01067 P4D 3a01067 PUD 3a02067 PMD 4f24063 PTE
> 8000000002b42121
> [  104.529476] Oops: Oops: 0003 [#1] SMP NOPTI
> [  104.529817] CPU: 0 UID: 0 PID: 63 Comm: kworker/0:1H Not tainted
> 6.19.0-rc7 #1 PREEMPT(voluntary
> [  104.530090] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
> 1996), BIOS 1.16.3-debian-1.16.34
> [  104.530440] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
> [  104.530849] RIP: 0010:_copy_to_iter+0x27e/0x7a0
> [  104.531077] Code: 01 48 2b 05 a4 2a 2f 01 48 c1 f8 06 48 c1 e0 0c
> 48 03 05 a5 2a 2f 01 48 01 f0 7
> [  104.531620] RSP: 0018:ffffc9000021bba8 EFLAGS: 00000246
> [  104.531805] RAX: ffff888002b42660 RBX: 0000000000000008 RCX: 305c782f7=
06d742f
> [  104.532019] RDX: 0000000000000008 RSI: ffff88800515c078 RDI: 000000000=
00009a0
> [  104.532243] RBP: ffff888005070218 R08: 0000000000000000 R09: ffff88800=
4ed5300
> [  104.532428] R10: 0000000000001000 R11: ffff888003e032e0 R12: ffff88800=
515c078
> [  104.532615] R13: 0000000000000000 R14: 0000000000000008 R15: 000000000=
0004080
> [  104.532821] FS:  0000000000000000(0000) GS:ffff8880fa4a4000(0000)
> knlGS:0000000000000000
> [  104.533048] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  104.533222] CR2: ffff888002b42660 CR3: 0000000004fec000 CR4: 000000000=
00006f0
> [  104.533483] Call Trace:
> [  104.533957]  <TASK>
> [  104.534195]  ? __pfx_simple_copy_to_iter+0x10/0x10
> [  104.534381]  __skb_datagram_iter+0x1a7/0x2e0
> [  104.534541]  ? __pfx_simple_copy_to_iter+0x10/0x10
> [  104.534671]  skb_copy_datagram_iter+0x2f/0x90
> [  104.534811]  tcp_recvmsg_locked+0x784/0x9d0
> [  104.534936]  tcp_recvmsg+0x81/0x1e0
> [  104.535045]  inet_recvmsg+0x50/0x130
> [  104.535166]  ? security_socket_recvmsg+0x43/0x60
> [  104.535294]  sock_recvmsg+0xa1/0xc0
> [  104.535381]  nvmet_tcp_io_work+0xdb/0x720
> [  104.535476]  process_one_work+0x15b/0x380
> [  104.535570]  worker_thread+0x2a5/0x3c0
> [  104.535653]  ? __pfx_worker_thread+0x10/0x10
> [  104.535747]  kthread+0xf6/0x1f0
> [  104.535839]  ? __pfx_kthread+0x10/0x10
> [  104.535949]  ? __pfx_kthread+0x10/0x10
> [  104.536060]  ret_from_fork+0x131/0x190
> [  104.536182]  ? __pfx_kthread+0x10/0x10
> [  104.536296]  ret_from_fork_asm+0x1a/0x30
> [  104.536451]  </TASK>
> [  104.536545] Modules linked in:
> [  104.536764] CR2: ffff888002b42660
> [  104.537046] ---[ end trace 0000000000000000 ]---
> [  104.537291] RIP: 0010:_copy_to_iter+0x27e/0x7a0
> [  104.537412] Code: 01 48 2b 05 a4 2a 2f 01 48 c1 f8 06 48 c1 e0 0c
> 48 03 05 a5 2a 2f 01 48 01 f0 7
> [  104.537848] RSP: 0018:ffffc9000021bba8 EFLAGS: 00000246
> [  104.538005] RAX: ffff888002b42660 RBX: 0000000000000008 RCX: 305c782f7=
06d742f
> [  104.538229] RDX: 0000000000000008 RSI: ffff88800515c078 RDI: 000000000=
00009a0
> [  104.538416] RBP: ffff888005070218 R08: 0000000000000000 R09: ffff88800=
4ed5300
> [  104.538617] R10: 0000000000001000 R11: ffff888003e032e0 R12: ffff88800=
515c078
> [  104.538825] R13: 0000000000000000 R14: 0000000000000008 R15: 000000000=
0004080
> [  104.538999] FS:  0000000000000000(0000) GS:ffff8880fa4a4000(0000)
> knlGS:0000000000000000
> [  104.539209] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  104.539340] CR2: ffff888002b42660 CR3: 0000000004fec000 CR4: 000000000=
00006f0
> [  104.539553] note: kworker/0:1H[63] exited with irqs disabled
> [  104.540201] kworker/0:1H (63) used greatest stack depth: 12976 bytes l=
eft
> ~ $ uname -a
> Linux (none) 6.19.0-rc7 #1 SMP PREEMPT_DYNAMIC Fri Jan 30 09:36:44 KST
> 2026 x86_64 GNU/Linux
>
> On Wed, Jan 28, 2026 at 9:41=E2=80=AFAM YunJe Shin <yjshin0438@gmail.com>=
 wrote:
> >
> > nvmet_tcp_build_pdu_iovec() could walk past cmd->req.sg when a PDU
> > length or offset exceeds sg_cnt and then use bogus sg->length/offset
> > values, leading to _copy_to_iter() GPF/KASAN. Guard sg_idx, remaining
> > entries, and sg->length/offset before building the bvec.
> >
> > Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> > Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
> > Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> > Reviewed-by: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
> > ---
> >  drivers/nvme/target/tcp.c | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
> > diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> > index 15416ff0eac4..1a62b405d8e6 100644
> > --- a/drivers/nvme/target/tcp.c
> > +++ b/drivers/nvme/target/tcp.c
> > @@ -349,11 +349,14 @@ static void nvmet_tcp_free_cmd_buffers(struct nvm=
et_tcp_cmd *cmd)
> >         cmd->req.sg =3D NULL;
> >  }
> >
> > +static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue);
> > +
> >  static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
> >  {
> >         struct bio_vec *iov =3D cmd->iov;
> >         struct scatterlist *sg;
> >         u32 length, offset, sg_offset;
> > +       unsigned int sg_remaining;
> >         int nr_pages;
> >
> >         length =3D cmd->pdu_len;
> > @@ -361,9 +364,22 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet=
_tcp_cmd *cmd)
> >         offset =3D cmd->rbytes_done;
> >         cmd->sg_idx =3D offset / PAGE_SIZE;
> >         sg_offset =3D offset % PAGE_SIZE;
> > +       if (!cmd->req.sg_cnt || cmd->sg_idx >=3D cmd->req.sg_cnt) {
> > +               nvmet_tcp_fatal_error(cmd->queue);
> > +               return;
> > +       }
> >         sg =3D &cmd->req.sg[cmd->sg_idx];
> > +       sg_remaining =3D cmd->req.sg_cnt - cmd->sg_idx;
> >
> >         while (length) {
> > +               if (!sg_remaining) {
> > +                       nvmet_tcp_fatal_error(cmd->queue);
> > +                       return;
> > +               }
> > +               if (!sg->length || sg->length <=3D sg_offset) {
> > +                       nvmet_tcp_fatal_error(cmd->queue);
> > +                       return;
> > +               }
> >                 u32 iov_len =3D min_t(u32, length, sg->length - sg_offs=
et);
> >
> >                 bvec_set_page(iov, sg_page(sg), iov_len,
> > @@ -371,6 +387,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_=
tcp_cmd *cmd)
> >
> >                 length -=3D iov_len;
> >                 sg =3D sg_next(sg);
> > +               sg_remaining--;
> >                 iov++;
> >                 sg_offset =3D 0;
> >         }
> > --
> > 2.43.0
> >

