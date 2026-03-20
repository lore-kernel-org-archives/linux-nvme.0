Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A5E1098797
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P/2oPkJBuTLFTXE0shva/ubfbhyBBNwsgkuv8vehTjI=; b=3dwxzC65irX0VHwg0ba3yVmFWi
	cPZccE/sailE9B5EVu8TM7saMFuv171KIz4CQZGNXeMPsxgpkipRiZyaPSq/dQnryvCm90aSrHksO
	M3q8gj8zD0RpTC9hsK+qWeIOiakC99m997/lpTmAnkPyXxqk0wL69T/FjzEDCXek8/++hW8bYtZbE
	P3kr6kCFENSmdPUTY66NaH7OFxqqewEti1WCSNfTy0YHRdQHPdQeJsAevHRerUBUJvuyD6O4KPbTT
	Y3pOsiuVZnGcGp1Hlh9AuvrJZOXlzrJyIkj1NwaXk+wOeQOLkWcH5HjMERErQ9esQJMu+JZKd3zUR
	OXH8ApaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3by8-0000000D3Aa-1A1P;
	Fri, 20 Mar 2026 15:41:00 +0000
Received: from mail-ej1-f48.google.com ([209.85.218.48])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3by5-0000000D39v-3bO0
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 15:40:59 +0000
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8d7f22d405so312070966b.0
        for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2026 08:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774021255; x=1774626055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P/2oPkJBuTLFTXE0shva/ubfbhyBBNwsgkuv8vehTjI=;
        b=ENBq8+3nOjWHREWyL3dcwG2wWqhoR/+7uLgo49LXts33FSU2hwvvaV6JayAHzS8tpz
         mEpX/DMshetGdOvUbGR5+QT0DM4SxkMr21F+Vrm9mHXvkw4PoB9eiqgMF7ZaOLERGHxR
         6S1xRgZLLCVkra5weNtK7zNvos3Ngjndhb4hS+op6Vd94ZtxqzSA5BNQuup8jFlQhpN+
         Fcl28A4jOWNEjl3jIf55OkXdTDNDqK21XzeCpbWXgbcvRXQ7Nxs69JqvWOipMAsuBz7F
         DKofYqfVuZrEefsB+dL2m/pHsb7lIudeS7mXRlENQHhpqIhTI7DQ7QMl6uiFi7WC143L
         8puw==
X-Forwarded-Encrypted: i=1; AJvYcCU4H+ekbd7Iuf7cMccGRz+d8MCaOEjVP9MAyC5RRP6DdfG/z1sXNLVqfQP2B8QiaH1LxOvcvZCDmhlV@lists.infradead.org
X-Gm-Message-State: AOJu0Yyip0zlsC1On5+EI/G2BXSWsMGXwA1RO9PMwAk3TTPbyj9OqD9p
	krNBqJ1ITM57ukOfxT1ZYvhfdGDdrDNp4pLsKc6q0Trkl4Y+F2J5jn3TlITDgJg3pqQ=
X-Gm-Gg: ATEYQzz5l/XgYm8nJgjZr4FRCaTKAt3RclzwdsEiQoZi4+HJetV75q8gRn3GVk3ZfFO
	AxLXd3eRP5/btCF2OkRpKrdvbCPqUpGahyzwQxLQbm8TY9RKtRVrNv21SwZGZPSz7sfEUFvJNVx
	bOFLl4HkzGEY41HWx/LzlFGFyFkQmyO4UkK21xB70BS99nn7/B7cPF8rxOWPHom3H9Ig7TauDuQ
	Vo1QOOJEA3+QlHMitkMIjVbA+Aza7j1pGUmflmbWNvDVqJ9BHBCKpWI5HijdQ8T5CmtfbQQ9RjW
	sicVPlxtemnWC11qvPHmCJC+gxD8ImyBXB3OLoDMAkdWDbeNvB+JvFoaQU102Aij0CUViKW1Fek
	T8COp4DwQ2Ze0s6J7DRuJqC9eWbQW+wO/XGWZP8ZNzKwTcIyPK/+lUvoltsHzWaa8n0HCkfXU5k
	gFcAd/4OX/DmY/gTtHZ0811XiT7Xt8wXRrwE7g2pPdJG7OD6K8R/FC4yg=
X-Received: by 2002:a17:906:259a:b0:b96:efe7:b04c with SMTP id a640c23a62f3a-b982f3ca834mr197240666b.38.1774021254945;
        Fri, 20 Mar 2026 08:40:54 -0700 (PDT)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9832f8c13csm170753666b.18.2026.03.20.08.40.54
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Mar 2026 08:40:54 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso18286595e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2026 08:40:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+eAajHCKUeRdbamVFwx5NPAquM0l0ARTTN3pk+pkGqLHT2tuYj/b/IAYnEwxTg8xNyXMutnmEI3TL@lists.infradead.org
X-Received: by 2002:a05:600c:a31c:b0:485:2a4b:7bc3 with SMTP id
 5b1f17b1804b1-486fede723dmr41276165e9.4.1774021254243; Fri, 20 Mar 2026
 08:40:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260228001927.382810-3-iam@sung-woo.kim> <ab0uNATxCVlnKi2p@stanley.mountain>
In-Reply-To: <ab0uNATxCVlnKi2p@stanley.mountain>
From: Sungwoo Kim <iam@sung-woo.kim>
Date: Fri, 20 Mar 2026 11:40:38 -0400
X-Gmail-Original-Message-ID: <CAJNyHpJm8rwivxM2bSvRoqi_yCeFTyXVY+z0oub4Uc8stUN55A@mail.gmail.com>
X-Gm-Features: AaiRm50NZb0zCRBWX_jHfcVOf6IIqbg6_eGI44AzoxB16M88cM2E69nGGzpEB78
Message-ID: <CAJNyHpJm8rwivxM2bSvRoqi_yCeFTyXVY+z0oub4Uc8stUN55A@mail.gmail.com>
Subject: Re: [PATCH v2] nvme: fix memory allocation in nvme_pr_read_keys()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Mike Christie <michael.christie@oracle.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.de>, Chao Shi <cshi008@fiu.edu>, 
	Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, 
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_084057_931076_28AF48CC 
X-CRM114-Status: GOOD (  34.48  )
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

On Fri, Mar 20, 2026 at 7:23=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> We were reveiwing CVEs and this patch doesn't really fix the problem.

Thank you for reviewing the CVE and this patch. I still believe that
this patch is correct.

>
> On Fri, Feb 27, 2026 at 07:19:28PM -0500, Sungwoo Kim wrote:
> > nvme_pr_read_keys() takes num_keys from userspace and uses it to
> > calculate the allocation size for rse via struct_size(). The upper
> > limit is PR_KEYS_MAX (64K).
> >
> > A malicious or buggy userspace can pass a large num_keys value that
> > results in a 4MB allocation attempt at most, causing a warning in
> > the page allocator when the order exceeds MAX_PAGE_ORDER.
> >
> > To fix this, use kvzalloc() instead of kzalloc().
> >
> > This bug has the same reasoning and fix with the patch below:
> > https://lore.kernel.org/linux-block/20251212013510.3576091-1-kartikey40=
6@gmail.com/
>
> We never merged this patch.  The fix that went in was correct.
> It is commit a58383fa45c7 ("block: add allocation size check in
> blkdev_pr_read_keys()").

My bad. Thanks for referring to the correct commit ID.

>
> >
> > Warning log:
> > WARNING: mm/page_alloc.c:5216 at __alloc_frozen_pages_noprof+0x5aa/0x23=
00 mm/page_alloc.c:5216, CPU#1: syz-executor117/272
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 272 Comm: syz-executor117 Not tainted 6.19.0 #1 PREE=
MPT(voluntary)
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-=
0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > RIP: 0010:__alloc_frozen_pages_noprof+0x5aa/0x2300 mm/page_alloc.c:5216
> > Code: ff 83 bd a8 fe ff ff 0a 0f 86 69 fb ff ff 0f b6 1d f9 f9 c4 04 80=
 fb 01 0f 87 3b 76 30 ff 83 e3 01 75 09 c6 05 e4 f9 c4 04 01 <0f> 0b 48 c7 =
85 70 fe ff ff 00 00 00 00 e9 8f fd ff ff 31 c0 e9 0d
> > RSP: 0018:ffffc90000fcf450 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ffff920001f9ea0
> > RDX: 0000000000000000 RSI: 000000000000000b RDI: 0000000000040dc0
> > RBP: ffffc90000fcf648 R08: ffff88800b6c3380 R09: 0000000000000001
> > R10: ffffc90000fcf840 R11: ffff88807ffad280 R12: 0000000000000000
> > R13: 0000000000040dc0 R14: 0000000000000001 R15: ffffc90000fcf620
> > FS:  0000555565db33c0(0000) GS:ffff8880be26c000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 000000002000000c CR3: 0000000003b72000 CR4: 00000000000006f0
> > Call Trace:
> >  <TASK>
> >  alloc_pages_mpol+0x236/0x4d0 mm/mempolicy.c:2486
> >  alloc_frozen_pages_noprof+0x149/0x180 mm/mempolicy.c:2557
> >  ___kmalloc_large_node+0x10c/0x140 mm/slub.c:5598
> >  __kmalloc_large_node_noprof+0x25/0xc0 mm/slub.c:5629
> >  __do_kmalloc_node mm/slub.c:5645 [inline]
> >  __kmalloc_noprof+0x483/0x6f0 mm/slub.c:5669
> >  kmalloc_noprof include/linux/slab.h:961 [inline]
> >  kzalloc_noprof include/linux/slab.h:1094 [inline]
> >  nvme_pr_read_keys+0x8f/0x4c0 drivers/nvme/host/pr.c:245
> >  blkdev_pr_read_keys block/ioctl.c:456 [inline]
> >  blkdev_common_ioctl+0x1b71/0x29b0 block/ioctl.c:730
> >  blkdev_ioctl+0x299/0x700 block/ioctl.c:786
> >  vfs_ioctl fs/ioctl.c:51 [inline]
> >  __do_sys_ioctl fs/ioctl.c:597 [inline]
> >  __se_sys_ioctl fs/ioctl.c:583 [inline]
> >  __x64_sys_ioctl+0x1bf/0x220 fs/ioctl.c:583
> >  x64_sys_call+0x1280/0x21b0 mnt/fuzznvme_1/fuzznvme/linux-build/v6.19/.=
/arch/x86/include/generated/asm/syscalls_64.h:17
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0x71/0x330 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > RIP: 0033:0x7fb893d3108d
> > Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffff61f2f38 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
> > RAX: ffffffffffffffda RBX: 00007ffff61f3138 RCX: 00007fb893d3108d
> > RDX: 0000000020000040 RSI: 00000000c01070ce RDI: 0000000000000003
> > RBP: 0000000000000001 R08: 0000000000000000 R09: 00007ffff61f3138
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> > R13: 00007ffff61f3128 R14: 00007fb893dae530 R15: 0000000000000001
> >  </TASK>
> >
> > Fixes: 5fd96a4e15de (nvme: Add pr_ops read_keys support)
> > Acked-by: Chao Shi <cshi008@fiu.edu>
> > Acked-by: Weidong Zhu <weizhu@fiu.edu>
> > Acked-by: Dave Tian <daveti@purdue.edu>
> > Signed-off-by: Sungwoo Kim <iam@sung-woo.kim>
> > ---
> > v2: add missing kvfree
> >
> >  drivers/nvme/host/pr.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
> > index ad2ecc2f49a97..fe7dbe2648158 100644
> > --- a/drivers/nvme/host/pr.c
> > +++ b/drivers/nvme/host/pr.c
> > @@ -242,7 +242,7 @@ static int nvme_pr_read_keys(struct block_device *b=
dev,
> >       if (rse_len > U32_MAX)
> >               return -EINVAL;
>
> This "rse_len > U32_MAX" check is kind of nonsense.  Anything larger

This check is pre-existing and irrelevant to this bug.

> than INT_MAX will trigger a stack trace (which is the bug that this
> patch is trying to fix).

No. This patch fixes a warning that occurs when get_order(rse_len) >
MAX_PAGE_ORDER.

>
> Copy the other fix for blkdev_pr_read_keys().

This patch already copied the fix. Changing kzalloc() to kvzalloc() is
what it had done.
If I missed something, please let me know.

Best,
Sungwoo.

>
> regards,
> dan carpenter
>
> >
> > -     rse =3D kzalloc(rse_len, GFP_KERNEL);
> > +     rse =3D kvzalloc(rse_len, GFP_KERNEL);
> >       if (!rse)
> >               return -ENOMEM;
> >
> > @@ -267,7 +267,7 @@ static int nvme_pr_read_keys(struct block_device *b=
dev,
> >       }
> >
> >  free_rse:
> > -     kfree(rse);
> > +     kvfree(rse);
> >       return ret;
> >  }
> >
> > --
> > 2.47.3
> >
>

