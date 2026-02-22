Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C74C636B6
	for <linux-nvme@archiver.kernel.org>; Sun, 22 Feb 2026 20:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zZTwSLil6o8k5yCa0yfQKc7kgAm4MwFkLJ1cSlsEfCM=; b=WX7z1/6QNTVtibyp1NVCLgBPPB
	lowIhVV6mrkeVHaHioxHS900nztmZHwPw6v9doaPBseji6aAumCe8zXEPHGf4PO3+MnSG3U2SqvXM
	bVnRcg/lZ3+MkqAL4aJSxkaNy9K6fVr8PQrElvTPAwVrYR+TWVtDi6ardjOLirPKEkzc6qWfR9Ml5
	veIRshuQklafQS5e3M2yNpHr/8hIGhhkQT9QH4SFV53TBe7yT+ZQJNFGd0uJYfVB3ew5hg2qpJU52
	Fvg3sRB/7jeVDmQzE4pKAAA24fn5bfcLG4HXSWMlNIw7W+4l+TVkCFylVK8eizECRxpcfqtk8sLHd
	syeu4fNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuGHk-0000000Gvlf-1U7O;
	Sun, 22 Feb 2026 20:42:36 +0000
Received: from mail-ed1-f50.google.com ([209.85.208.50])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuGHh-0000000GvlI-1hmF
	for linux-nvme@lists.infradead.org;
	Sun, 22 Feb 2026 20:42:34 +0000
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-658b6757f7fso6671701a12.1
        for <linux-nvme@lists.infradead.org>; Sun, 22 Feb 2026 12:42:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771792951; x=1772397751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zZTwSLil6o8k5yCa0yfQKc7kgAm4MwFkLJ1cSlsEfCM=;
        b=UTbI6OPBWuGPWydvWel+oz55Z/ZjqYCsznpqhyr4zKUvOFHnVMK0ZWn5GRrGp33LBT
         HwnyzR9RMnYuxrZ95ra3nNrphLRU0TKnYgv4oH1n+7cZ9kEr6wl9ljC2+SaZnxOx8feL
         Pgsw5m1x0RjlasUvDTX/XHNoBL98Uv6ck+0I0vl6YizBJI30ktACgcP6XwsMKwWppQ9e
         ke7Xq4BKgUfUbDzzbO44LtIlX2CqthkAKdSAk6BmBNS+gE3pGVr5LJK32ntgNzg91vLx
         VWLD26My4aBBE16MlNwmLuFfBwlk4u0Qphr4zBXCBewIp2q4WM5VyX8Ko1km9r7nzPfd
         7spQ==
X-Forwarded-Encrypted: i=1; AJvYcCXg+HjorKXyIYFAxcEK+KnU75nxRJpCd50cxB67yrPwN1akiq59g55/Chc65hjVQL5sQjQfQ4HIEsOz@lists.infradead.org
X-Gm-Message-State: AOJu0YyW7Qd9nZrqgpfYS5VEXtSuTJ6u1w/jfmyZZpAzkbfZzjcB0osX
	Ajwdd7TU5aYfYw7RHLGJ4R25Vf8iLWAoDRitQEIJaP0OSC91wPFPOcBVGm2Mng2Tcfo=
X-Gm-Gg: AZuq6aJZuhMosU/sQGMcNDMs8002kVFBnr7Tdz8YNclAY7E3YEI0EYizPUsC4dZvHRw
	cDgQvoFtFQoSXxDbxhqmJlM+7yaWpdyuhpuXZ+16SKj4wFwt0C4xJ8G0nuXLgXq04uYihVWkN/L
	NJg6EajPTAOxGVYUExr9GHP03s6To3gOl4NsU5/apmy3DSRRutaluVeVj7IkxyhoXlbyWiJlRFW
	jzp0wyukXkR8CJaswnnBSSVI2HYS58nBaMlnI1vOeLDzi7XoRHLRzPBjofnw5H/S5sRuSxV1n1r
	3i0buYWsZpOqXYaA9QLvYLN/VlobAAxippiEZC+ubq6dGf+3BmB2U7iKMIXUyrLsVJtNgcEeH1Y
	d8LshUCAgC2kaug8RXc852jAmPt+vovBqp6oR6wFLGbOHJiH/Ylw52tcZOlEkXtlhVlK7ddK3hD
	W5M+zHtFfTMGRGG6o0c5hdKvpoNiz3wc7Fwbdxm7XaHaSPwk/+e9X5W4g=
X-Received: by 2002:a05:6402:2348:b0:65a:1b27:b64f with SMTP id 4fb4d7f45d1cf-65ea4ebe959mr3829982a12.13.1771792950740;
        Sun, 22 Feb 2026 12:42:30 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65eab9abeadsm2015520a12.12.2026.02.22.12.42.26
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 12:42:28 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4358fb60802so2695571f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 22 Feb 2026 12:42:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXcGUD2i2fkbGbrm2ZbyeKljpJYKNJhizTx7xmN43/9fA7b10n0UbRS79qnCA2t9Z1AHR0thjcZCkry@lists.infradead.org
X-Received: by 2002:a05:6000:26ce:b0:435:96e9:cde8 with SMTP id
 ffacd0b85a97d-4396fda9b18mr11126510f8f.12.1771792945976; Sun, 22 Feb 2026
 12:42:25 -0800 (PST)
MIME-Version: 1.0
References: <20260216003541.161806-2-iam@sung-woo.kim>
In-Reply-To: <20260216003541.161806-2-iam@sung-woo.kim>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Sun, 22 Feb 2026 15:42:09 -0500
X-Gmail-Original-Message-ID: <CAJNyHpLi6VrrYdaLwFz_P=+FYcG2eMX6sL6MZmV-f1DjzzOwgg@mail.gmail.com>
X-Gm-Features: AaiRm53c7fpNhWFEUrY_QoCJWcdpjGz_i_HGwj6aP3YALDWDpHnpAEKdfqYib60
Message-ID: <CAJNyHpLi6VrrYdaLwFz_P=+FYcG2eMX6sL6MZmV-f1DjzzOwgg@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix memory allocator in nvme_pr_read_keys()
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Cc: Chao Shi <cshi008@fiu.edu>, Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260222_124233_471210_9607A650 
X-CRM114-Status: GOOD (  20.23  )
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

Gentle ping.

On Sun, Feb 15, 2026 at 7:35=E2=80=AFPM Sungwoo Kim <iam@sung-woo.kim> wrot=
e:
>
> If IOC_PR_READ_KEYS is called with num_keys =3D=3D PR_KEYS_MAX,
> nvme_pr_read_keys() may request more than 4MB memory via kzalloc().
> This always fails since kzalloc() does not allocate memory more than
> 4MB. As a result, ioctl() fails with ENOMEM, which is incorrect.
> To fix this, use kvzalloc() instead of kzalloc().
>
> WARNING: mm/page_alloc.c:5216 at __alloc_frozen_pages_noprof+0x5aa/0x2300=
 mm/page_alloc.c:5216, CPU#1: syz-executor117/272
> Modules linked in:
> CPU: 1 UID: 0 PID: 272 Comm: syz-executor117 Not tainted 6.19.0 #1 PREEMP=
T(voluntary)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-=
ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__alloc_frozen_pages_noprof+0x5aa/0x2300 mm/page_alloc.c:5216
> Code: ff 83 bd a8 fe ff ff 0a 0f 86 69 fb ff ff 0f b6 1d f9 f9 c4 04 80 f=
b 01 0f 87 3b 76 30 ff 83 e3 01 75 09 c6 05 e4 f9 c4 04 01 <0f> 0b 48 c7 85=
 70 fe ff ff 00 00 00 00 e9 8f fd ff ff 31 c0 e9 0d
> RSP: 0018:ffffc90000fcf450 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ffff920001f9ea0
> RDX: 0000000000000000 RSI: 000000000000000b RDI: 0000000000040dc0
> RBP: ffffc90000fcf648 R08: ffff88800b6c3380 R09: 0000000000000001
> R10: ffffc90000fcf840 R11: ffff88807ffad280 R12: 0000000000000000
> R13: 0000000000040dc0 R14: 0000000000000001 R15: ffffc90000fcf620
> FS:  0000555565db33c0(0000) GS:ffff8880be26c000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000002000000c CR3: 0000000003b72000 CR4: 00000000000006f0
> Call Trace:
>  <TASK>
>  alloc_pages_mpol+0x236/0x4d0 mm/mempolicy.c:2486
>  alloc_frozen_pages_noprof+0x149/0x180 mm/mempolicy.c:2557
>  ___kmalloc_large_node+0x10c/0x140 mm/slub.c:5598
>  __kmalloc_large_node_noprof+0x25/0xc0 mm/slub.c:5629
>  __do_kmalloc_node mm/slub.c:5645 [inline]
>  __kmalloc_noprof+0x483/0x6f0 mm/slub.c:5669
>  kmalloc_noprof include/linux/slab.h:961 [inline]
>  kzalloc_noprof include/linux/slab.h:1094 [inline]
>  nvme_pr_read_keys+0x8f/0x4c0 drivers/nvme/host/pr.c:245
>  blkdev_pr_read_keys block/ioctl.c:456 [inline]
>  blkdev_common_ioctl+0x1b71/0x29b0 block/ioctl.c:730
>  blkdev_ioctl+0x299/0x700 block/ioctl.c:786
>  vfs_ioctl fs/ioctl.c:51 [inline]
>  __do_sys_ioctl fs/ioctl.c:597 [inline]
>  __se_sys_ioctl fs/ioctl.c:583 [inline]
>  __x64_sys_ioctl+0x1bf/0x220 fs/ioctl.c:583
>  x64_sys_call+0x1280/0x21b0 mnt/fuzznvme_1/fuzznvme/linux-build/v6.19/./a=
rch/x86/include/generated/asm/syscalls_64.h:17
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x71/0x330 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7fb893d3108d
> Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffff61f2f38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> RAX: ffffffffffffffda RBX: 00007ffff61f3138 RCX: 00007fb893d3108d
> RDX: 0000000020000040 RSI: 00000000c01070ce RDI: 0000000000000003
> RBP: 0000000000000001 R08: 0000000000000000 R09: 00007ffff61f3138
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffff61f3128 R14: 00007fb893dae530 R15: 0000000000000001
>  </TASK>
>
> Fixes: 5fd96a4e15de (nvme: Add pr_ops read_keys support)
> Acked-by: Chao Shi <cshi008@fiu.edu>
> Acked-by: Weidong Zhu <weizhu@fiu.edu>
> Acked-by: Dave Tian <daveti@purdue.edu>
> Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> ---
>  drivers/nvme/host/pr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
> index ad2ecc2f4..5394b6cb0 100644
> --- a/drivers/nvme/host/pr.c
> +++ b/drivers/nvme/host/pr.c
> @@ -242,7 +242,7 @@ static int nvme_pr_read_keys(struct block_device *bde=
v,
>         if (rse_len > U32_MAX)
>                 return -EINVAL;
>
> -       rse =3D kzalloc(rse_len, GFP_KERNEL);
> +       rse =3D kvzalloc(rse_len, GFP_KERNEL);
>         if (!rse)
>                 return -ENOMEM;
>
> --
> 2.47.3
>

