Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E359E7718D
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Dec 2024 20:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
	MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0Nhj9knVFWKgfOyDcQ4dW41LW41FRJnmwV/sgtvm0OE=; b=1YsjHFOYVkz8ELKJVcHhkRIgQr
	oVwk0adYpGlFDcoAoGvndUrlO69NPh0pwMg6DgNs0VNOx1R+o6/tkgL2Wjk6CLmn13AImsXuxUTpL
	X69dudgNK9Pm6Wnjg8euDvcLYuhVjHgXgEcIZyK6dBKU+rrzUiaY2Z8DuUd1gjiThM5UB0+WaLeDH
	fAPyPLhXLxqvtmHYwDejpUZD2XBntL8DkJPiIWJQhXrvCExnvOF6zeaK0ECDz+LNxoRayGjivjgU5
	l8jdNZmOFPN0+jGsUuF3mCyC5OnRk2/x8e7whfcRi+DxxKR0fQ3R0eCLoloxj/gdYncGlBmeDnUTG
	mhf9d6NA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tPpQP-0000000AjZM-2SzZ;
	Mon, 23 Dec 2024 20:53:13 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tPpQM-0000000AjYT-41EB
	for linux-nvme@lists.infradead.org;
	Mon, 23 Dec 2024 20:53:12 +0000
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2efdaa02378so803121a91.1
        for <linux-nvme@lists.infradead.org>; Mon, 23 Dec 2024 12:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1734987189; x=1735591989; darn=lists.infradead.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Nhj9knVFWKgfOyDcQ4dW41LW41FRJnmwV/sgtvm0OE=;
        b=dDU3xoYzLHeVHDMLeT3nzKPnpjZEEY85d3BV0kMDM7qMUZ3SApDFmY91yyIirpsnjh
         T7UMOrrQIcFZ8g0LUa48mOLFgz5oKQC1GPfGxC9/tWnmrIPFeiIDTWmslJqezfPKAbPQ
         JvuYbJ0gOZ4UiPlretIlE8QEt0Jwn+Grci9IzA+KuRZM/hYpoNfgwnW09GUF/HCdISp+
         sFN7QLTHpYnpKAku1Rq6kj/m1ruVCj7MoiVgI2KiQtpnhit2tOJ4KsN1y/VwDW0dIYET
         XtoOqIaZCEDc3BhZGY2JnPCeZm2uqLNrCeqRE7f3X5OBvrPMYizqHL76LeMhGa7Y2Kr7
         EvPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734987189; x=1735591989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Nhj9knVFWKgfOyDcQ4dW41LW41FRJnmwV/sgtvm0OE=;
        b=PKayOfYUC5if4B/HpM6SZ/4zy7JWiHqTyteEx9gVmsx1rxdL27ezRfsxY8VQ0AhS+o
         OIz7XSjOsHZcpwIXnCPHdaNQNjmtfIfU6sSNts4sXX554Yc4yApznL27jx0Hz/NwZxQa
         3XcRIPpwqd6TlaG3i6xsEGLbQtkqDbgB+JromWgL1dqnyJvOSOIT+8VUiE5J4LigtxJW
         eA32WguQ0ErOsVFrRftUa2PzTcyWHO7WJ174iFnpaECQq++LiO16E11EYtLGu+sx/5uL
         gIpjIMcD179yHwIid008VvbtwBT9cQC7fDEhx2Xkd4+lTTQzACZwWV1qNoQ3mi95oRIu
         lUCw==
X-Forwarded-Encrypted: i=1; AJvYcCWhu7fxRjzM/irwwUhjR8h/BVCDEbRVlyUTVtcnAhyz5twjGkBTogO4UBeBwazS9D+WXEnAKrUoQ4oE@lists.infradead.org
X-Gm-Message-State: AOJu0YyVB0D2q5OiVEXYaYiJz3nQYCJz1cJFz2p+esasV7u4Ee3FGzmU
	lfmu57MdWQtv61y1/kErShniknCFWposML3jyPiRivJUkcwd/87GpJfzAKDH90vcDslF3Lsd/yf
	YhOeCEZQBT7ACD2/SgzHfL9YdIkRwYyq7inIHag==
X-Gm-Gg: ASbGncvfg29Ssi5Y9NN+dlu4UVM1GzXyv/eKQNETenHHRg7fI6kKWhW9e5yXX9VOwk3
	vKLjWizgOaG61KADMlHpi8qyPO2KdXfb9rnx54n8=
X-Google-Smtp-Source: AGHT+IEwNYCz/q03cvl0NmtG4zb4kLejw2dkqOB7byKTe0SGTZPM1XYnnV5uCQbPfb5f49c+qAMeH5NQ/7BzxSQo2Lo=
X-Received: by 2002:a17:90b:1345:b0:2ee:cbc9:d50b with SMTP id
 98e67ed59e1d1-2f452eac10amr8154667a91.4.1734987189478; Mon, 23 Dec 2024
 12:53:09 -0800 (PST)
MIME-Version: 1.0
References: <6769bf7b.050a0220.226966.0041.GAE@google.com> <2f80272f-6cab-489d-ba2b-c1d545ac3485@kernel.dk>
In-Reply-To: <2f80272f-6cab-489d-ba2b-c1d545ac3485@kernel.dk>
From: Caleb Sander <csander@purestorage.com>
Date: Mon, 23 Dec 2024 12:52:58 -0800
Message-ID: <CADUfDZqtiT8B_LvTRuzT9QB+7z+7pNqYJd_n2gQYK1d8cKkxqA@mail.gmail.com>
Subject: Re: [syzbot] [io-uring?] BUG: unable to handle kernel NULL pointer
 dereference in percpu_ref_put_many
To: Jens Axboe <axboe@kernel.dk>
Cc: syzbot <syzbot+3dcac84cc1d50f43ed31@syzkaller.appspotmail.com>, 
	asml.silence@gmail.com, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Hannes Reinecke <hare@suse.de>, 
	Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241223_125311_162967_BF12A72D 
X-CRM114-Status: GOOD (  15.35  )
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

This is probably the same bug that is being addressed by
https://lore.kernel.org/lkml/20241218185000.17920-2-leocstone@gmail.com/T/

On Mon, Dec 23, 2024 at 12:35=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote=
:
>
> On 12/23/24 12:52 PM, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    eabcdba3ad40 Merge tag 'for-6.13-rc3-tag' of git://git.=
ker..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D10871f44580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc22efbd20f8=
da769
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D3dcac84cc1d50=
f43ed31
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D141bccf85=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D135f7730580=
000
>
> I ran this one but his this instead:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in nvmet_root_discovery_nqn_store+0x110/0x=
180
> Write of size 256 at addr ffff000009e71180 by task refcrash/775
>
> CPU: 0 UID: 0 PID: 775 Comm: refcrash Not tainted 6.13.0-rc4 #2
> Hardware name: linux,dummy-virt (DT)
> Call trace:
>  show_stack+0x1c/0x30 (C)
>  __dump_stack+0x24/0x30
>  dump_stack_lvl+0x60/0x80
>  print_address_description+0x88/0x220
>  print_report+0x4c/0x60
>  kasan_report+0x94/0xf0
>  kasan_check_range+0x248/0x288
>  __asan_memset+0x30/0x60
>  nvmet_root_discovery_nqn_store+0x110/0x180
>  configfs_write_iter+0x220/0x2e8
>  do_iter_readv_writev+0x2e0/0x458
>  vfs_writev+0x220/0x728
>  do_writev+0xf8/0x1a8
>  __arm64_sys_writev+0x80/0x98
>  invoke_syscall+0x7c/0x258
>  el0_svc_common+0x108/0x1d0
>  do_el0_svc+0x4c/0x60
>  el0_svc+0x4c/0xa0
>  el0t_64_sync_handler+0x70/0x100
>  el0t_64_sync+0x170/0x178
>
> Allocated by task 1:
>  kasan_save_track+0x2c/0x60
>  kasan_save_alloc_info+0x3c/0x48
>  __kasan_kmalloc+0x80/0x98
>  __kmalloc_node_track_caller_noprof+0x2f0/0x590
>  kstrndup+0x4c/0xb8
>  nvmet_subsys_alloc+0x1c4/0x498
>  nvmet_init_discovery+0x20/0x48
>  nvmet_init+0x18c/0x1c0
>  do_one_initcall+0x1a4/0x718
>  do_initcall_level+0x178/0x348
>  do_initcalls+0x58/0xa0
>  do_basic_setup+0x7c/0x98
>  kernel_init_freeable+0x268/0x380
>  kernel_init+0x24/0x148
>  ret_from_fork+0x10/0x20
>
> The buggy address belongs to the object at ffff000009e71180
>  which belongs to the cache kmalloc-64 of size 64
> The buggy address is located 0 bytes inside of
>  allocated 37-byte region [ffff000009e71180, ffff000009e711a5)
>
> The buggy address belongs to the physical page:
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x49e7=
1
> anon flags: 0x3ffe00000000000(node=3D0|zone=3D0|lastcpupid=3D0x1fff)
> page_type: f5(slab)
> raw: 03ffe00000000000 ffff0000070028c0 fffffdffc0523d80 dead000000000005
> raw: 0000000000000000 0000000000200020 00000001f5000000 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff000009e71080: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>  ffff000009e71100: 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc fc
> >ffff000009e71180: 00 00 00 00 05 fc fc fc fc fc fc fc fc fc fc fc
> Zero length message leads to an empty skb
>                                ^
>  ffff000009e71200: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
>  ffff000009e71280: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Disabling lock debugging due to kernel taint
>
> which makes me think something else is the culprit here. The test case
> doesn't do much outside of creating two rings, it doesn't actually use
> them.
>
> CC'ing likely suspects on the nvme front. This is on 6.13-rc4 fwiw.
>
> --
> Jens Axboe
>

