Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5947D73EBA
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 03:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a2QD7wMCUKyL9EaG+P+AjknmKZQ/OZAHCiwDC6nXDrQ=; b=RcTBi93J11sfLqMLszoo6atBHt
	EkoDhxEUBnRhqSh2waVbrAvyqMF+eRFXVrDCQ7lDa/Zi0MBtIvuuahCyeKRROXwelJv5YsC2AfY1S
	Req2iZ1chjftFV8VhsRngBOn3lM5ezCNlb5HtVJP3P8FtiQd6CZRUCcLANBgeL2h06SpIEBMn4q5s
	/evlD+M6kwCE5FXM4n5IP8HuD8PAgvtIu8DIuxfUl/rHpcI5k26CjQbNTPqUyu0NHjwbwiaDkd1zQ
	7u13HwSx6rpGa7acgpy6brdlY+eaxKDO+QR1tKmFlhLirb/TpzkKfW0jQIvF8ryTT4nLSmjjqqrY7
	DiL9DjeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlfMN-00000000y4Q-0aI1;
	Fri, 30 Jan 2026 03:39:51 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlfMH-00000000y3T-01Ji
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 03:39:50 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2a0c09bb78cso14219135ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 29 Jan 2026 19:39:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769744384; cv=none;
        d=google.com; s=arc-20240605;
        b=QjfyEOWIyMaveilFgaGZbBX0wrHkHT0uB/8t/duW7aMf9elptDrZ2dTKqXV1zTVS7R
         uPmBVF+V7aGp4F/Ad7f57itCeTq7zfu2S02dESsZbN4wcUgzwpC17/K8RNK7mlR9fe+3
         0W0xV0OjndKiUSSxM5Xbylx35Tm6UKBsByxQz++iU2f5hQ0+dtL+3Vyr/6kjYQZo7K5r
         6f9KgqcVwwzrCSFgl+4TuvtbZaHbs05wjNtBtABfgyu6uGtHM6D2XpKDhTmH6hLUoTJ+
         YKj9/he8o1XIEGgA2eIR/5orMZpO9vDqcZB5huP7V6dVKDFdBGTfs7sAeYpEUFrsnGQy
         wHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a2QD7wMCUKyL9EaG+P+AjknmKZQ/OZAHCiwDC6nXDrQ=;
        fh=ZjNjXnCznRHIz6alFZHgCB2eoD57C58QEFV8LYFPtdE=;
        b=c0Tw0rYjVrFC9EIAtxRVIwxA7PFyjEXbUwac1JT4Fl43p3lgNNIk/LVHYcMQUveVLT
         8kEgitg6xyondl9tf74N8ZEY71LY0dEE2QXrWkvy2EBPH79+Gc3E0O5dEzknDPgV5kUB
         rYT6EvAf9zWA87ij8c5JY3E8X8Uyn9XHg6KjjnwCCTcdqdKlaCbrAjAS+tkzovm/ZcGn
         puPuGkNR3Fmv9+BV9Prwlno7AHDFlacWpYSWT7zgWuucfHVPQX6zpKV7K7mWEvUXc8Py
         pU0/fJ7m/TSAI/9ZQon8nldtmXe/nd5iNmWxdN2Zp1T1I4VwoIVUh/VWpo6Xs1ESXg7O
         7evw==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769744384; x=1770349184; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2QD7wMCUKyL9EaG+P+AjknmKZQ/OZAHCiwDC6nXDrQ=;
        b=ceXxOvq+/O0k6U2ggVsT+Xw0gXMLVw2SZ2pE5K4TT/Var4q1gMc2unXQmjIgmmmue0
         Z1HJ3hfZndXNhJQLx2r7PRsewHhAmmiLNHa64GbzFXx1ulTh/ljlgTXvsvCzPYow9S4W
         mHf1jNBVZr8fxlOBaLsp7U4WHUNvFzU+HbPWycxcHqpdtfsEAJTOGWhU1iUl6gd1GVvS
         jioLyH6/mT+DOSzWzqLBa8UBOLcIRWyoUsv3u0sJhY+uOJoIESjPRkdGF5U+TJ2thATd
         U4uzhy9Iu0vlnOBfmyprPUGMWcmuzG0zIeIla2IQTXC3L4eAUEyqaa3TSp6AewiKbHpH
         XfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769744384; x=1770349184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a2QD7wMCUKyL9EaG+P+AjknmKZQ/OZAHCiwDC6nXDrQ=;
        b=Xb1VlHAGj9AqidQvpz80HEZWuEhb57aZu02f7VkKWUHvEYajnkgy6enuRFMrMwuNlO
         Ypoq969rlBIg+XwDd9kqPfEC5TjbCx0giAvPJraX/sLjCv21CoM0urQuYGvqUHns7Gs7
         Sb8UiiTD0D9zJ2Mj+9FydfDdQbMxU3V8J1QhgV3rlF3eB8hQdkggQJFBk2Gwid00AzmP
         sb1hn9PeLZTZAEjpw41oZOgNRDuQLhFKzt/EoPTkyGlZB3WBVK+NLHYeIVrEGdBikOPC
         Tij+3DZMHlobA6UiQfkfHADq8UVdjcyNvLmGx96gHhlxlsK6GzO6kYLq82kyqDwymJ9S
         BemA==
X-Gm-Message-State: AOJu0YwMc33WKKC3JrTr9HQRU0dsbg+qlVUtw4fpLIjASMqvru5WnOlz
	G/k1eGMPou5TAoQF8Q6sgd2R/acX6GxfEh9I+VT5wxcjPz6AwziGX9mam3H75G8VwD3Fk643oec
	ZZarrLfH4uEAgaRp2n9AQ9EqduWy7FjI=
X-Gm-Gg: AZuq6aI2lukwmvooDtolfQi4f9P+fBwnZ3C4Vf0HrUZ+WfJQyD8HTLseN2+rHDuOwXv
	QIj1gnq4g/4wkerjfl8x7R7ceT+moJjVUEAQwN+VBiciNo1V8pWWGd3cdg72pxKTa/gTYJD13GH
	YzyI1Elo0MlAupWJDmFMx50ViJJ7p39rY2PgJ+464pCVlGbmGLjBLsZKfzfsoUQAQTBgWx2q1DE
	oFM+3NcT2lT6tbsVM2Q5hSmE+IP6UYXNRcTqHZFQ8+/+H6rrY5+eIML47StAvp9EP8Df7EoWw==
X-Received: by 2002:a17:903:2f86:b0:2a0:9238:881d with SMTP id
 d9443c01a7336-2a8bd4c71c6mr53039455ad.15.1769744383794; Thu, 29 Jan 2026
 19:39:43 -0800 (PST)
MIME-Version: 1.0
References: <678f42fb-521e-4b5e-b662-331e424ca003@grimberg.me> <20260128004136.946596-1-ioerts@kookmin.ac.kr>
In-Reply-To: <20260128004136.946596-1-ioerts@kookmin.ac.kr>
From: yunje shin <yjshin0438@gmail.com>
Date: Fri, 30 Jan 2026 12:39:32 +0900
X-Gm-Features: AZwV_Qi22lQ5SWoq-ROY5Cyzn4scxSwTIR1tBC7nBnoayv99BB7y7S3Vw0MSeRk
Message-ID: <CAMX6_QEujcQ6137p2uBZ=4sgpZ_4PCRE1fV6VgXha_ZiYxpNQQ@mail.gmail.com>
Subject: Re: [PATCH] nvmet-tcp: add bounds checks in nvmet_tcp_build_pdu_iovec
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org, 
	Christoph Hellwig <hch@lst.de>, security@kernel.org, sagi@grimberg.me, 
	YunJe Shin <ioerts@kookmin.ac.kr>, joonkyoj@yonsei.ac.kr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260129_193945_053652_E0ED9D4F 
X-CRM114-Status: GOOD (  17.82  )
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

[  104.528480] BUG: unable to handle page fault for address: ffff888002b426=
60
[  104.528773] #PF: supervisor write access in kernel mode
[  104.528938] #PF: error_code(0x0003) - permissions violation
[  104.529151] PGD 3a01067 P4D 3a01067 PUD 3a02067 PMD 4f24063 PTE
8000000002b42121
[  104.529476] Oops: Oops: 0003 [#1] SMP NOPTI
[  104.529817] CPU: 0 UID: 0 PID: 63 Comm: kworker/0:1H Not tainted
6.19.0-rc7 #1 PREEMPT(voluntary
[  104.530090] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
1996), BIOS 1.16.3-debian-1.16.34
[  104.530440] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
[  104.530849] RIP: 0010:_copy_to_iter+0x27e/0x7a0
[  104.531077] Code: 01 48 2b 05 a4 2a 2f 01 48 c1 f8 06 48 c1 e0 0c
48 03 05 a5 2a 2f 01 48 01 f0 7
[  104.531620] RSP: 0018:ffffc9000021bba8 EFLAGS: 00000246
[  104.531805] RAX: ffff888002b42660 RBX: 0000000000000008 RCX: 305c782f706=
d742f
[  104.532019] RDX: 0000000000000008 RSI: ffff88800515c078 RDI: 00000000000=
009a0
[  104.532243] RBP: ffff888005070218 R08: 0000000000000000 R09: ffff888004e=
d5300
[  104.532428] R10: 0000000000001000 R11: ffff888003e032e0 R12: ffff8880051=
5c078
[  104.532615] R13: 0000000000000000 R14: 0000000000000008 R15: 00000000000=
04080
[  104.532821] FS:  0000000000000000(0000) GS:ffff8880fa4a4000(0000)
knlGS:0000000000000000
[  104.533048] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  104.533222] CR2: ffff888002b42660 CR3: 0000000004fec000 CR4: 00000000000=
006f0
[  104.533483] Call Trace:
[  104.533957]  <TASK>
[  104.534195]  ? __pfx_simple_copy_to_iter+0x10/0x10
[  104.534381]  __skb_datagram_iter+0x1a7/0x2e0
[  104.534541]  ? __pfx_simple_copy_to_iter+0x10/0x10
[  104.534671]  skb_copy_datagram_iter+0x2f/0x90
[  104.534811]  tcp_recvmsg_locked+0x784/0x9d0
[  104.534936]  tcp_recvmsg+0x81/0x1e0
[  104.535045]  inet_recvmsg+0x50/0x130
[  104.535166]  ? security_socket_recvmsg+0x43/0x60
[  104.535294]  sock_recvmsg+0xa1/0xc0
[  104.535381]  nvmet_tcp_io_work+0xdb/0x720
[  104.535476]  process_one_work+0x15b/0x380
[  104.535570]  worker_thread+0x2a5/0x3c0
[  104.535653]  ? __pfx_worker_thread+0x10/0x10
[  104.535747]  kthread+0xf6/0x1f0
[  104.535839]  ? __pfx_kthread+0x10/0x10
[  104.535949]  ? __pfx_kthread+0x10/0x10
[  104.536060]  ret_from_fork+0x131/0x190
[  104.536182]  ? __pfx_kthread+0x10/0x10
[  104.536296]  ret_from_fork_asm+0x1a/0x30
[  104.536451]  </TASK>
[  104.536545] Modules linked in:
[  104.536764] CR2: ffff888002b42660
[  104.537046] ---[ end trace 0000000000000000 ]---
[  104.537291] RIP: 0010:_copy_to_iter+0x27e/0x7a0
[  104.537412] Code: 01 48 2b 05 a4 2a 2f 01 48 c1 f8 06 48 c1 e0 0c
48 03 05 a5 2a 2f 01 48 01 f0 7
[  104.537848] RSP: 0018:ffffc9000021bba8 EFLAGS: 00000246
[  104.538005] RAX: ffff888002b42660 RBX: 0000000000000008 RCX: 305c782f706=
d742f
[  104.538229] RDX: 0000000000000008 RSI: ffff88800515c078 RDI: 00000000000=
009a0
[  104.538416] RBP: ffff888005070218 R08: 0000000000000000 R09: ffff888004e=
d5300
[  104.538617] R10: 0000000000001000 R11: ffff888003e032e0 R12: ffff8880051=
5c078
[  104.538825] R13: 0000000000000000 R14: 0000000000000008 R15: 00000000000=
04080
[  104.538999] FS:  0000000000000000(0000) GS:ffff8880fa4a4000(0000)
knlGS:0000000000000000
[  104.539209] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  104.539340] CR2: ffff888002b42660 CR3: 0000000004fec000 CR4: 00000000000=
006f0
[  104.539553] note: kworker/0:1H[63] exited with irqs disabled
[  104.540201] kworker/0:1H (63) used greatest stack depth: 12976 bytes lef=
t
~ $ uname -a
Linux (none) 6.19.0-rc7 #1 SMP PREEMPT_DYNAMIC Fri Jan 30 09:36:44 KST
2026 x86_64 GNU/Linux

On Wed, Jan 28, 2026 at 9:41=E2=80=AFAM YunJe Shin <yjshin0438@gmail.com> w=
rote:
>
> nvmet_tcp_build_pdu_iovec() could walk past cmd->req.sg when a PDU
> length or offset exceeds sg_cnt and then use bogus sg->length/offset
> values, leading to _copy_to_iter() GPF/KASAN. Guard sg_idx, remaining
> entries, and sg->length/offset before building the bvec.
>
> Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
> Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
> Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
> Reviewed-by: Joonkyo Jung <joonkyoj@yonsei.ac.kr>
> ---
>  drivers/nvme/target/tcp.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 15416ff0eac4..1a62b405d8e6 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -349,11 +349,14 @@ static void nvmet_tcp_free_cmd_buffers(struct nvmet=
_tcp_cmd *cmd)
>         cmd->req.sg =3D NULL;
>  }
>
> +static void nvmet_tcp_fatal_error(struct nvmet_tcp_queue *queue);
> +
>  static void nvmet_tcp_build_pdu_iovec(struct nvmet_tcp_cmd *cmd)
>  {
>         struct bio_vec *iov =3D cmd->iov;
>         struct scatterlist *sg;
>         u32 length, offset, sg_offset;
> +       unsigned int sg_remaining;
>         int nr_pages;
>
>         length =3D cmd->pdu_len;
> @@ -361,9 +364,22 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_t=
cp_cmd *cmd)
>         offset =3D cmd->rbytes_done;
>         cmd->sg_idx =3D offset / PAGE_SIZE;
>         sg_offset =3D offset % PAGE_SIZE;
> +       if (!cmd->req.sg_cnt || cmd->sg_idx >=3D cmd->req.sg_cnt) {
> +               nvmet_tcp_fatal_error(cmd->queue);
> +               return;
> +       }
>         sg =3D &cmd->req.sg[cmd->sg_idx];
> +       sg_remaining =3D cmd->req.sg_cnt - cmd->sg_idx;
>
>         while (length) {
> +               if (!sg_remaining) {
> +                       nvmet_tcp_fatal_error(cmd->queue);
> +                       return;
> +               }
> +               if (!sg->length || sg->length <=3D sg_offset) {
> +                       nvmet_tcp_fatal_error(cmd->queue);
> +                       return;
> +               }
>                 u32 iov_len =3D min_t(u32, length, sg->length - sg_offset=
);
>
>                 bvec_set_page(iov, sg_page(sg), iov_len,
> @@ -371,6 +387,7 @@ static void nvmet_tcp_build_pdu_iovec(struct nvmet_tc=
p_cmd *cmd)
>
>                 length -=3D iov_len;
>                 sg =3D sg_next(sg);
> +               sg_remaining--;
>                 iov++;
>                 sg_offset =3D 0;
>         }
> --
> 2.43.0
>

