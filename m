Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4DACCCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 23:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AR4wPFHjktkbmF1P3RUZ2XEVONeLJ1E/kmPbNfs6+eA=; b=OUA51Ajlz7zXhmYicVxPZPaNph
	zyXMw5IIsUSXgN6aJUDK2rX++gK8a206fiqmVFtuCmBbSAw3Ipwj63ouCqrq6q8RH2qwCDhokDHsQ
	QvRGbfEMXRPsFdHh58JhHuvnkLYBNQ/cBsHvqkFmVX69TFJi8iESDQE5J4oZCYxrT7vKPt5yvZss4
	kMHVKU14UOoMP3rQvyt+mBgSr6oi3ehSQLPjhdKu/3kWtk80eYd++J5LrsMT0xtB2KEEJq5O5NyuD
	0rxO16AFu7ejDRev9nutsDc8j6G2ztMBtZsSsx/Qkit+iJtM6U6LoZaCSMnGyK8Q2/lqkfS7Q0toK
	ESDa7vUA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGQMM-0000000CkPf-0bIR;
	Tue, 04 Nov 2025 23:22:42 +0000
Received: from mail-qk1-x735.google.com ([2607:f8b0:4864:20::735])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGQMJ-0000000CkPE-3QaS
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 23:22:41 +0000
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-8b1bb9c3c04so20348085a.3
        for <linux-nvme@lists.infradead.org>; Tue, 04 Nov 2025 15:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1762298558; x=1762903358; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AR4wPFHjktkbmF1P3RUZ2XEVONeLJ1E/kmPbNfs6+eA=;
        b=BjJ4leqJlCNvwM97TkG7W/UrXGHJw7ooC0Im5TzkRPfuMFuhuhe3gM4C7c38w0oMKw
         sw1c/43LRDC/j8KXeNcKwZdkiZojGbtwt+1n5o5MtT5w7TOo/NHb+41ACD10MQUeiWHr
         x/xvlGJOj2gcmA7IWn5k7WjUZ5F2Y7mc8gSqAlAvbXEP9HaZ/LRzoXnz8+EDrsIybAoo
         6/SRH5r+wY1k/0UCdGeLHTL+hHoLNrsYIZa82yp7HcYWYEGoYsBIy73oZV3Qumm/OM5q
         HOyU/J8zCeWPxqkmeEFbDPN+rDNqH/FcQM2RnXtF3iyT0ldba3D0YQ/oi528NhzBsXHW
         jQvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762298558; x=1762903358;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AR4wPFHjktkbmF1P3RUZ2XEVONeLJ1E/kmPbNfs6+eA=;
        b=a1x38Isw3khzoD+OAlmT7f1dA+bRt+B1psChF3iUv+3J1AWIqo7XpnCBF8Y8ZnAoiR
         D8fc6CVnX9mUCmsKjOPjRyX0Th18jUk5DgpwE444kLEmu86JepBUHxuYmTOmzzS72rAt
         wxs7KHD6QBHc3WuTZ6LenC8p4xSewpjZz3QHDw7eFW95zUVICasA0HAlAwwlrUez7TDw
         VId8MlZYq+aiGJpEaGnBg7nSZnFVU/1VyjMvRg6ZGbzVh2tATrUqzKDchdlGWRPsa1zc
         D6ssJH5HtJaavGlX7ZBLeAVERq90w94vFriUiM7ZYBxYeZRONzaMLTXZF4Hzkfxg0+Il
         eADg==
X-Forwarded-Encrypted: i=1; AJvYcCV+m/h6rvibWFQu20nXhExjPo11gOzBh3hbwLKnpdjkLfYOKx17Yz0h/vysd0JqUz7kLsjX5XUrxldy@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5RVdrgcr0hkYi4sCHnfTDKHAe/uyZ0Luwiw0jgUNaOR+kgS9Y
	WYOjg33J0hfeeoglaLeNL2L7E8AFt0B6TSpBV+aZjf2juXOULzzIjEljV178wLcsp3qcV9kk1jO
	lHzBkh0OKl94bsIyJDXOw+lqzp+EIuuafJcYfKfctuA==
X-Gm-Gg: ASbGncuMzttESisaxclF1htBiz4crlZDL/RrZfBfCNgucoygj9zg2h/f1RMDIMwqKgX
	xLn9MwffHfvqmxhzReCFpxazowVNuTvmTLJsoErpoGu0WvlPppfkddPB5D1OX/s5jVaQ7DNTrJW
	jCF6+BvKiaq7ZN9JEVKmuFxyD3vlKtGOm+970dn5rF2BttQsM385AG5vgUkj6vmjjzBjuAKm+QT
	W1tFXhHAnWnQ1vd4a2mxojXBLWRLhZxXgz9GloNSqR9chteCyQBtR7tmoSltQ==
X-Google-Smtp-Source: AGHT+IGnyiVjMMN5aaleFjbjjOE8clwPrDj6Qg9VTvf9t+tSR1Ry39bGTkHmHIa11Mfx6RjbEYfvLdr966g1OPni7nM=
X-Received: by 2002:a05:6214:21c7:b0:801:2595:d05d with SMTP id
 6a1803df08f44-880711710c4mr13944096d6.3.1762298558408; Tue, 04 Nov 2025
 15:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20251104225939.3641605-1-kbusch@meta.com> <9d9a56a3-87fa-4d51-ba78-d3af220d5fd5@nvidia.com>
In-Reply-To: <9d9a56a3-87fa-4d51-ba78-d3af220d5fd5@nvidia.com>
From: Casey Chen <cachen@purestorage.com>
Date: Tue, 4 Nov 2025 15:22:27 -0800
X-Gm-Features: AWmQ_blDamzYlF1DPVKB24eP8lUjRLj6mSLBUyS9_Wfq4McoJb_GqvuzXy-A-eU
Message-ID: <CALCePG16dc2Z5LnAWGehHdCQArLq+m+g04L+FLVTEXxeyt_nOA@mail.gmail.com>
Subject: Re: [PATCH] nvme: fix admin request_queue lifetime
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@meta.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>, 
	"ming.lei@redhat.com" <ming.lei@redhat.com>, Keith Busch <kbusch@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_152239_924375_F0C32852 
X-CRM114-Status: GOOD (  14.59  )
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

Looks good. Thanks

On Tue, Nov 4, 2025 at 3:08=E2=80=AFPM Chaitanya Kulkarni <chaitanyak@nvidi=
a.com> wrote:
>
> On 11/4/25 14:59, Keith Busch wrote:
> > From: Keith Busch<kbusch@kernel.org>
> >
> > The namespaces can access the controller's admin request_queue, and
> > stale references on the namespaces may exist. Ensure the request_queue
> > is active by moving the controller's 'put' after all references on the
> > controller have been released to ensure no one is trying to access the
> > request_queue. This fixes a reported use-after-free bug:
> >
> >    BUG: KASAN: slab-use-after-free in blk_queue_enter+0x41c/0x4a0
> >    Read of size 8 at addr ffff88c0a53819f8 by task nvme/3287
> >    CPU: 67 UID: 0 PID: 3287 Comm: nvme Tainted: G            E       6.=
13.2-ga1582f1a031e #15
> >    Tainted: [E]=3DUNSIGNED_MODULE
> >    Hardware name: Jabil /EGS 2S MB1, BIOS 1.00 06/18/2025
> >    Call Trace:
> >     <TASK>
> >     dump_stack_lvl+0x4f/0x60
> >     print_report+0xc4/0x620
> >     ? _raw_spin_lock_irqsave+0x70/0xb0
> >     ? _raw_read_unlock_irqrestore+0x30/0x30
> >     ? blk_queue_enter+0x41c/0x4a0
> >     kasan_report+0xab/0xe0
> >     ? blk_queue_enter+0x41c/0x4a0
> >     blk_queue_enter+0x41c/0x4a0
> >     ? __irq_work_queue_local+0x75/0x1d0
> >     ? blk_queue_start_drain+0x70/0x70
> >     ? irq_work_queue+0x18/0x20
> >     ? vprintk_emit.part.0+0x1cc/0x350
> >     ? wake_up_klogd_work_func+0x60/0x60
> >     blk_mq_alloc_request+0x2b7/0x6b0
> >     ? __blk_mq_alloc_requests+0x1060/0x1060
> >     ? __switch_to+0x5b7/0x1060
> >     nvme_submit_user_cmd+0xa9/0x330
> >     nvme_user_cmd.isra.0+0x240/0x3f0
> >     ? force_sigsegv+0xe0/0xe0
> >     ? nvme_user_cmd64+0x400/0x400
> >     ? vfs_fileattr_set+0x9b0/0x9b0
> >     ? cgroup_update_frozen_flag+0x24/0x1c0
> >     ? cgroup_leave_frozen+0x204/0x330
> >     ? nvme_ioctl+0x7c/0x2c0
> >     blkdev_ioctl+0x1a8/0x4d0
> >     ? blkdev_common_ioctl+0x1930/0x1930
> >     ? fdget+0x54/0x380
> >     __x64_sys_ioctl+0x129/0x190
> >     do_syscall_64+0x5b/0x160
> >     entry_SYSCALL_64_after_hwframe+0x4b/0x53
> >    RIP: 0033:0x7f765f703b0b
> >    Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c 89 e0 41 5c=
 c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d 01 =
f0 ff ff 73 01 c3 48 8b 0d dd 52 0f 00 f7 d8 64 89 01 48
> >    RSP: 002b:00007ffe2cefe808 EFLAGS: 00000202 ORIG_RAX: 00000000000000=
10
> >    RAX: ffffffffffffffda RBX: 00007ffe2cefe860 RCX: 00007f765f703b0b
> >    RDX: 00007ffe2cefe860 RSI: 00000000c0484e41 RDI: 0000000000000003
> >    RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
> >    R10: 00007f765f611d50 R11: 0000000000000202 R12: 0000000000000003
> >    R13: 00000000c0484e41 R14: 0000000000000001 R15: 00007ffe2cefea60
> >     </TASK>
> >
> > Reported-by: Casey Chen<cachen@purestorage.com>
> > Signed-off-by: Keith Busch<kbusch@kernel.org>
> > ---
>
>
> Looks good.
>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>
> -ck
>
>

