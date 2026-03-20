Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F2B108B901
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Mar 2026 11:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A8Mrr2DjHLNUijTGXVyAA6JoxOligLGIFxM6SYbLGzM=; b=p1u/cukkbN95BItgGR95VgtL7R
	ULm4awR08FzeZXdVFNR2PTGW5j5KYf492b2RtWzjAT3xiHuGJJnzRvdQ7bz1jPf9YyRvVxl5zCNbx
	hd5u3E1oCCuFziER4Vg6RfUJZsTQTtLLSZqaMmfiTrzfOEjrm3X3+HBZwDshrdaxzOqA0TGDcDZHx
	4LL7Hm6af63wMUmGQrcuFJ6uhhNg3bAKvPVRYqZyxS+3t/1b5uLJKN0fnJ6ljxBXLiNTb5upko+bH
	olsZoCPZjP2EJPRDAXK+TtU+GVGKdEy6f61wjNmfJ5ITI6AeXeFm4WMsk0mZ2ubhZVkc9Uk6uf0JU
	cx++Ovuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Xx6-0000000Ch4d-0WK4;
	Fri, 20 Mar 2026 11:23:40 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w3Xx4-0000000Ch3x-1F2d
	for linux-nvme@lists.infradead.org;
	Fri, 20 Mar 2026 11:23:39 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-486fd27754bso10534475e9.3
        for <linux-nvme@lists.infradead.org>; Fri, 20 Mar 2026 04:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774005816; x=1774610616; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A8Mrr2DjHLNUijTGXVyAA6JoxOligLGIFxM6SYbLGzM=;
        b=e/o11eUUIccyL2L7eaNNbCHD38wBPMTtwD5BOA+izBwQRdcRJH/bDwmEoXEIq0lTxo
         YTx3+6RbTdlsCxQU+3TS0lXcetv3OKSgPusMBr2A7mC+87VoVIX9N4a+s1l7tKWprk22
         EJWCqqrtZC64Pge1bOXvM//5HIr7U/f1xDC/zIxB/HPHn54wL3RZwA/OIg6+4sjoGKp9
         shuZ2+A3dgKGEBdH9bjpbLuXTUVDuH5SJ1SI2OmeILStJt0CDj2PB4BbAQQoax1gx0h9
         CGmfIw5tPT5oe0wCnLCFDkMyd7xVGHoQmrYeEErFfT/Sl/0nhkerwgukHsmQgQoXI3Ef
         zjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774005816; x=1774610616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A8Mrr2DjHLNUijTGXVyAA6JoxOligLGIFxM6SYbLGzM=;
        b=GLR6l+jeAAQWumlTc5q7dvCtpvZl2YZ3iZeg4vxU8H4Ia6N13kCLqSjrmPo4FMT9LS
         fSlqLDK7TgOimVYCVy01Fba0NPtmWOOt+dp1xbP35abMJuyYFSUvxX1FJjxqLoMfH8OD
         vHXtHZH8tge7MNkaz9Ft6AEyx08XUMSuZA6A6dvIGSIMQqVVXoqKw0sof1hV+aVhO13p
         57NSlp1LGBaFdxHEL05yj5Vp0iYTep1v4nqTrLlC51/6CfmkGz5CosbrdqDjTNQDuZ4K
         frII3TTUCKUUWcRK2yR2X5h74Q+0vWm6zxIpPxpfc4XIRL+g5uyzSUnNuiIFblCo6trZ
         MKDA==
X-Forwarded-Encrypted: i=1; AJvYcCUjOhBOHHDDgaQAyV/4V7vNaXEqGL1V8kT5aB+GVSUdTu1ktt4zOKI5aihhB+p+A/1rAqB8DmzwVN0a@lists.infradead.org
X-Gm-Message-State: AOJu0YxoghxRPnnOLoEoKAM0UWxSZvJKA0BRaihJwmoM2kCuzfaaBZZj
	+gnJMPDtobhRT3yJ5nxtIivt47dAtS3gqvCxxCDHGca4cJIsLKvQITRSCRdRMjQHDNY=
X-Gm-Gg: ATEYQzwabpyq7k8IG5lFnHCBJMtdh+iHsxJMSwydC7AlBtRJo7qbQjUZIIBd9R9Rvtk
	JMxIQjwsWLZ4qvgeuMGVTQT7Us/7ys6QwFzKKm8uZmd49vlBK5p73YJsWozV1RkBUEGDg9npYUL
	UyLnZR03SNy7BKAQt3YalszOOebqJrtkWAqhB5Sgy4NXKe9bP++eXSJK8Kn5K1PjGdQ4YNzUbc+
	8w9vmeRrL7GRsuaZrmi4XFmxGp/1xt5fRWdwHraDanEx/S9jjBEZd50ljMxDhVnPgP6otXty+EG
	+XwctzbeyQkjDpKKfq32Iu4Emj9WKegjN8tKdam39+lfS6iJKBO81ifI1HcyS8LC9crhco7hgX8
	2gfOoUxXYWdrG5guKE5XeZJ562hDD0vTYonpSOEysAqcVukp07kqz9q1ra3fyoAxumgSWMFKubb
	0ty5s+5nkhkWSi+oeTZ2pdNZ5W10pyO+p8INiZOkY=
X-Received: by 2002:a05:600c:3f16:b0:485:3f38:3de3 with SMTP id 5b1f17b1804b1-486fedab1aamr39704215e9.3.1774005815555;
        Fri, 20 Mar 2026 04:23:35 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f8b949e1sm218072865e9.9.2026.03.20.04.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 04:23:35 -0700 (PDT)
Date: Fri, 20 Mar 2026 14:23:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Hannes Reinecke <hare@suse.de>, Chao Shi <cshi008@fiu.edu>,
	Weidong Zhu <weizhu@fiu.edu>, Dave Tian <daveti@purdue.edu>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v2] nvme: fix memory allocation in nvme_pr_read_keys()
Message-ID: <ab0uNATxCVlnKi2p@stanley.mountain>
References: <20260228001927.382810-3-iam@sung-woo.kim>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228001927.382810-3-iam@sung-woo.kim>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260320_042338_397371_DD6B3734 
X-CRM114-Status: GOOD (  28.32  )
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

We were reveiwing CVEs and this patch doesn't really fix the problem.

On Fri, Feb 27, 2026 at 07:19:28PM -0500, Sungwoo Kim wrote:
> nvme_pr_read_keys() takes num_keys from userspace and uses it to
> calculate the allocation size for rse via struct_size(). The upper
> limit is PR_KEYS_MAX (64K).
> 
> A malicious or buggy userspace can pass a large num_keys value that
> results in a 4MB allocation attempt at most, causing a warning in
> the page allocator when the order exceeds MAX_PAGE_ORDER.
> 
> To fix this, use kvzalloc() instead of kzalloc().
> 
> This bug has the same reasoning and fix with the patch below:
> https://lore.kernel.org/linux-block/20251212013510.3576091-1-kartikey406@gmail.com/

We never merged this patch.  The fix that went in was correct.
It is commit a58383fa45c7 ("block: add allocation size check in
blkdev_pr_read_keys()").

> 
> Warning log:
> WARNING: mm/page_alloc.c:5216 at __alloc_frozen_pages_noprof+0x5aa/0x2300 mm/page_alloc.c:5216, CPU#1: syz-executor117/272
> Modules linked in:
> CPU: 1 UID: 0 PID: 272 Comm: syz-executor117 Not tainted 6.19.0 #1 PREEMPT(voluntary)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> RIP: 0010:__alloc_frozen_pages_noprof+0x5aa/0x2300 mm/page_alloc.c:5216
> Code: ff 83 bd a8 fe ff ff 0a 0f 86 69 fb ff ff 0f b6 1d f9 f9 c4 04 80 fb 01 0f 87 3b 76 30 ff 83 e3 01 75 09 c6 05 e4 f9 c4 04 01 <0f> 0b 48 c7 85 70 fe ff ff 00 00 00 00 e9 8f fd ff ff 31 c0 e9 0d
> RSP: 0018:ffffc90000fcf450 EFLAGS: 00010246
> RAX: 0000000000000000 RBX: 0000000000000000 RCX: 1ffff920001f9ea0
> RDX: 0000000000000000 RSI: 000000000000000b RDI: 0000000000040dc0
> RBP: ffffc90000fcf648 R08: ffff88800b6c3380 R09: 0000000000000001
> R10: ffffc90000fcf840 R11: ffff88807ffad280 R12: 0000000000000000
> R13: 0000000000040dc0 R14: 0000000000000001 R15: ffffc90000fcf620
> FS:  0000555565db33c0(0000) GS:ffff8880be26c000(0000) knlGS:0000000000000000
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
>  x64_sys_call+0x1280/0x21b0 mnt/fuzznvme_1/fuzznvme/linux-build/v6.19/./arch/x86/include/generated/asm/syscalls_64.h:17
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0x71/0x330 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> RIP: 0033:0x7fb893d3108d
> Code: 28 c3 e8 46 1e 00 00 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
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
> v2: add missing kvfree
> 
>  drivers/nvme/host/pr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
> index ad2ecc2f49a97..fe7dbe2648158 100644
> --- a/drivers/nvme/host/pr.c
> +++ b/drivers/nvme/host/pr.c
> @@ -242,7 +242,7 @@ static int nvme_pr_read_keys(struct block_device *bdev,
>  	if (rse_len > U32_MAX)
>  		return -EINVAL;

This "rse_len > U32_MAX" check is kind of nonsense.  Anything larger
than INT_MAX will trigger a stack trace (which is the bug that this
patch is trying to fix).

Copy the other fix for blkdev_pr_read_keys().

regards,
dan carpenter

>  
> -	rse = kzalloc(rse_len, GFP_KERNEL);
> +	rse = kvzalloc(rse_len, GFP_KERNEL);
>  	if (!rse)
>  		return -ENOMEM;
>  
> @@ -267,7 +267,7 @@ static int nvme_pr_read_keys(struct block_device *bdev,
>  	}
>  
>  free_rse:
> -	kfree(rse);
> +	kvfree(rse);
>  	return ret;
>  }
>  
> -- 
> 2.47.3
> 

