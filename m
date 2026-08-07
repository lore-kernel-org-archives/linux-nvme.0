Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D392C5AC7C
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2026 09:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0EDvfVhZgoGwud2BqRLuZ6zdNWhFYuwWCkTH0F2yl84=; b=l9tckb3jJIanJZINkZwQQVfJJp
	0WteDgC8+sDBwogxw+dfIiSJO7CD57fxzerjf0qyoS6tKskhELLZoCo3LMn4A+LQ04iVpyae6JpST
	lph/m10jYkhRVPtfBb12SfvUyMTTvjC7CD8Mg6rZH2p9yvAvrMyJ2KDTX39VAV9P/110zKejcrASL
	ST4b8YC1XJ3tqJJiBo45/4wqTPxSMuThDR5ruCVHvmk1dNuovFqf6/hK6/cQ6hDf6Nvu52jgGujXd
	gPivyo7wzuL40d0sXjdLLW9lAMfPqYPGeUTJjxT1ygusBKCR5De96uE33ZTh14y8uT5m5zEXlAHOF
	prwVCoZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsHKC-00000007ZLr-13BO;
	Fri, 07 Aug 2026 09:57:12 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsHK9-00000007ZL1-0uRK
	for linux-nvme@lists.infradead.org;
	Fri, 07 Aug 2026 09:57:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=c9vpbLZs/3M63v
	f4hlNhbhIZqxdjTilzH6Ei5RsNZaw=; h=in-reply-to:references:to:from:
	subject:date; d=arkamax.eu; b=JAhRQVtWQSsLdNVmUDsYuBt6sPCAlvIA4ABQRmLT
	udxV6d80oa+IFIFjGuugeY34CmwisTMxTotBV7mPg8yDyrW83QoqutOtF8q4JunCLR+doS
	QwW0VzPVRkq/5yy7rzxjkBm17zY6JIpXYrViwxvzym4HCg545gyizoipIeuVdrzqQSac2h
	UUqrzohQbm7RbB0w3Xk4IFfqrqAaMc+C5RBJRq9uJ8xNIDOsvEdVTc5hpvBIJT+ocFb26x
	rueDBpzn+9ou5Q1jnG8aqLlAGyDpxrchG3G5bvXJgSt0cGVV1lR54Jrxkxhtvt4AO1o/Kc
	NlNN7klcYpE4SER7fIwz2Q==
Received: from localhost (norvmij1-3.customer.nettuno.it [193.207.172.59])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id cf292f19 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 11:57:05 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 07 Aug 2026 11:57:03 +0200
Message-Id: <DKIMETMU4QA5.1AKCUK7BJ9XTH@arkamax.eu>
Subject: Re: [syzbot] [nvme?] KASAN: slab-out-of-bounds Read in
 nvmet_install_queue
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "syzbot" <syzbot+2626e846cd2585c9aa67@syzkaller.appspotmail.com>,
 <hch@lst.de>, <kch@nvidia.com>, <linux-kernel@vger.kernel.org>,
 <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <syzkaller-bugs@googlegroups.com>
X-Mailer: aerc 0.21.0
References: <6a75205c.01d0871a.3a0d52.0033.GAE@google.com>
In-Reply-To: <6a75205c.01d0871a.3a0d52.0033.GAE@google.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260807_025709_587619_CCBDFCB3 
X-CRM114-Status: UNSURE (   8.52  )
X-CRM114-Notice: Please train this message.
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

On Fri Aug 7, 2026 at 2:01 AM CEST, syzbot wrote:
> Hello,
>
> syzbot found the following issue on:
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in nvmet_install_queue+0x522/0x590 drivers=
/nvme/target/fabrics-cmd.c:189
> Read of size 8 at addr ffff888058219a70 by task kworker/u33:8/1166
>
> CPU: 1 UID: 0 PID: 1166 Comm: kworker/u33:8 Not tainted syzkaller #0 PREE=
MPT(full)=20
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
> Workqueue: nvmet-wq nvme_loop_execute_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:378 [inline]
>  print_report+0x13d/0x4b0 mm/kasan/report.c:482
>  kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
>  nvmet_install_queue+0x522/0x590 drivers/nvme/target/fabrics-cmd.c:189
>  nvmet_execute_io_connect+0x294/0x490 drivers/nvme/target/fabrics-cmd.c:3=
80

I am able to reproduce it, the problem is that
nvmet_subsys_attr_qid_max_store() can race against
nvmet_alloc_control().

Suppose max_qid is 64.
nvmet_alloc_ctrl() executed ctrl->sqs =3D kzalloc_objs(struct nvmet_sq *, s=
ubsys->max_qid + 1);

at this point a userspace process changes max_qid to 128.
nvmet_subsys_attr_qid_max_store() sets the new max_qid value but
the new controller won't be deleted because it hasn't been added to the
subsys->ctrls list yet.


nvmet_alloc_ctrl() proceeds and adds the new controller to the
subsys->ctrls list.

Now nvmet_install_queue() will be called with max_qid set to 128, but
the memory allocated for sqs is just for 64 entries, hence the KASAN
warning.

I will try to prepare a patch.

Maurizio


