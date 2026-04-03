Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AFFE7E345
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2026 09:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bwnzLyLdsKwWz6dZwN4NTHSVveg3ljeCZ7w00jT7s4c=; b=kUbW00CNFJUvlgAMp/iYmrhiFG
	LnX2HDQrZwUOoMe+MfkLU3zIQIWlPN1j0BEEaHPKJVPNYPMRoY1HMyHodyIh+qlbmEOBkICxeamw3
	r1QXCBNZqH7vfN2PUh2vMUCmitUUZhuJdMhRCRpFnk7AxxS6XX3FrwIcE4JWqm1UtusG40v9oVvpc
	g0++vB5K0w+ukESET+0TXPtyYbjI35u9gakvUNrf5iS4QQRbwvn/2JqnuRE6n0LXwKaYO/BoUBaYl
	Cr2/spakY+GRLqCYieWz/2k7zldZkeBwj4lyWHuZbV7DejCVjrW8zqf+KxxLvFSQgqZivHCBUZWWi
	Yj/8jIiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8aii-00000001mvq-3Li2;
	Fri, 03 Apr 2026 09:21:40 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8aig-00000001mvN-0r4C
	for linux-nvme@lists.infradead.org;
	Fri, 03 Apr 2026 09:21:39 +0000
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id 9560e005 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Apr 2026 11:21:33 +0200 (CEST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 Apr 2026 11:21:33 +0200
Message-Id: <DHJEQZRGEMDX.1KX53DW8BCUPC@arkamax.eu>
Cc: "Shinichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Subject: Re: [bug report]nvmet_auth kmemleak observed during blktests
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Yi Zhang" <yi.zhang@redhat.com>, "linux-block"
 <linux-block@vger.kernel.org>, "open list:NVM EXPRESS DRIVER"
 <linux-nvme@lists.infradead.org>
X-Mailer: aerc 0.21.0
References: <CAHj4cs-u3MWQR4idywptMfjEYi4YwObWFx4KVib35dZ5HMBDdw@mail.gmail.com>
In-Reply-To: <CAHj4cs-u3MWQR4idywptMfjEYi4YwObWFx4KVib35dZ5HMBDdw@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_022138_579783_836C57AC 
X-CRM114-Status: UNSURE (   8.95  )
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

On Fri Apr 3, 2026 at 10:46 AM CEST, Yi Zhang wrote:
> Hi
>
> I found the following kmemleak during blktests on the
> linux-block/for-next, please help check it and let me know if you need
> any test/info for it, thanks.
>
> commit:
> aac56c7b77fa (HEAD -> for-next, origin/for-next) Merge branch
> 'for-7.1/io_uring' into for-next
>
> reproducer:
> nvme_trtype=3Dloop ./check nvme/041 nvme/042 nvme/043 nvme/044 nvme/045
> nvme/051 nvme/052
>
> kmemleak:
> unreferenced object 0xff11000305c48240 (size 32):
>   comm "kworker/u48:3", pid 123223, jiffies 4401374163
>   hex dump (first 32 bytes):
>     30 1e 78 66 9b 04 e7 4a d5 d7 a3 a2 ab 1f f1 22  0.xf...J......."
>     11 4a aa 11 b5 f7 fa f6 24 a6 17 11 e6 f8 e7 dc  .J......$.......
>   backtrace (crc 58405ce8):
>     __kmalloc_noprof+0x635/0x870
>     nvmet_auth_challenge+0x329/0x9f0 [nvmet]
>     nvmet_execute_auth_receive+0x381/0x7b0 [nvmet]
>     process_one_work+0xd98/0x1390
>     worker_thread+0x60b/0x1000
>     kthread+0x36c/0x470
>     ret_from_fork+0x5dc/0x8e0
>     ret_from_fork_asm+0x1a/0x30

Maybe this has been introduced by commit 2e6eb6b277f5
("nvmet-tcp: Don't free SQ on authentication success")

If nvmet_execute_auth_receive() gets called twice and executes
nvmet_auth_challenge(), the dhchap_c1 pointer is leaked.

Maurizio

> unreferenced object 0xff1100027be14c00 (size 256):
>   comm "kworker/u48:3", pid 123223, jiffies 4401374168
>   hex dump (first 32 bytes):
>     30 96 ec 83 33 bb fc 41 ec 81 70 14 1e ad 32 fd  0...3..A..p...2.
>     39 b8 ca 9c 99 22 ff 28 f0 80 f3 e0 1d 82 36 a9  9....".(......6.
>   backtrace (crc e365275d):
>     __kmalloc_noprof+0x635/0x870
>     nvmet_auth_ctrl_sesskey+0xfa/0x3a0 [nvmet]
>     nvmet_auth_reply+0x436/0xd00 [nvmet]
>     nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
>     process_one_work+0xd98/0x1390
>     worker_thread+0x60b/0x1000
>     kthread+0x36c/0x470
>     ret_from_fork+0x5dc/0x8e0
>     ret_from_fork_asm+0x1a/0x30
> unreferenced object 0xff11000305c48d40 (size 32):
>   comm "kworker/u48:3", pid 123223, jiffies 4401374170
>   hex dump (first 32 bytes):
>     c0 8b 24 c4 c1 5a 37 d1 fc 49 ec 3e 44 05 7e 19  ..$..Z7..I.>D.~.
>     70 39 6a d0 53 22 6d 23 fc b9 94 83 e3 3a 60 e2  p9j.S"m#.....:`.
>   backtrace (crc 8284cf12):
>     __kmalloc_node_track_caller_noprof+0x637/0x880
>     kmemdup_noprof+0x22/0x50
>     nvmet_auth_reply+0x2ba/0xd00 [nvmet]
>     nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
>     process_one_work+0xd98/0x1390
>     worker_thread+0x60b/0x1000
>     kthread+0x36c/0x470
>     ret_from_fork+0x5dc/0x8e0
>     ret_from_fork_asm+0x1a/0x30
> unreferenced object 0xff1100016dd8c7c0 (size 32):
>   comm "kworker/u48:2", pid 139664, jiffies 4401374600
>   hex dump (first 32 bytes):
>     21 1e e5 a0 b9 e6 a0 6b 85 cb 62 ff 30 d6 21 0f  !......k..b.0.!.
>     05 89 bc 6a 44 fe 2a c4 bd 35 23 59 6c 56 2b 2e  ...jD.*..5#YlV+.
>   backtrace (crc e32fd56c):
>     __kmalloc_noprof+0x635/0x870
>     nvmet_auth_challenge+0x329/0x9f0 [nvmet]
>     nvmet_execute_auth_receive+0x381/0x7b0 [nvmet]
>     process_one_work+0xd98/0x1390
>     worker_thread+0x60b/0x1000
>     kthread+0x36c/0x470
>     ret_from_fork+0x5dc/0x8e0
>     ret_from_fork_asm+0x1a/0x30
> unreferenced object 0xff11000255549600 (size 256):
>   comm "kworker/u48:2", pid 139664, jiffies 4401374604
>   hex dump (first 32 bytes):
>     11 1a 6e 99 d1 bc ae 48 5d aa f1 74 62 30 68 c4  ..n....H]..tb0h.
>     07 9f 31 dc 83 a4 a4 92 47 18 9c 04 1e 7d 68 c1  ..1.....G....}h.
>   backtrace (crc db3ad817):
>     __kmalloc_noprof+0x635/0x870
>     nvmet_auth_ctrl_sesskey+0xfa/0x3a0 [nvmet]
>     nvmet_auth_reply+0x436/0xd00 [nvmet]
>     nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
>     process_one_work+0xd98/0x1390
>     worker_thread+0x60b/0x1000
>     kthread+0x36c/0x470
>     ret_from_fork+0x5dc/0x8e0
>     ret_from_fork_asm+0x1a/0x30
> unreferenced object 0xff1100016dd8cc00 (size 32):
>   comm "kworker/u48:2", pid 139664, jiffies 4401374609
>   hex dump (first 32 bytes):
>     51 ff e9 8e 10 6b b4 b3 3f 6c 7d f2 74 eb 42 98  Q....k..?l}.t.B.
>     6c f8 ab ec 10 d6 e8 0f 02 79 4a e4 ec b2 ce ed  l........yJ.....
>   backtrace (crc 7099040d):
>     __kmalloc_node_track_caller_noprof+0x637/0x880
>     kmemdup_noprof+0x22/0x50
>     nvmet_auth_reply+0x2ba/0xd00 [nvmet]
>     nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
>     process_one_work+0xd98/0x1390
>     worker_thread+0x60b/0x1000
>     kthread+0x36c/0x470
>     ret_from_fork+0x5dc/0x8e0
>     ret_from_fork_asm+0x1a/0x30
> unreferenced object 0xff1100025554a800 (size 256):
>   comm "kworker/u48:2", pid 139664, jiffies 4401374633
>   hex dump (first 32 bytes):
>     eb a9 ed 0e b7 42 c6 6c 48 ee 56 29 a4 8a 99 18  .....B.lH.V)....
>     1c 90 2a 53 22 7a ee 5a c0 6e 60 43 5b 33 a1 d2  ..*S"z.Z.n`C[3..
>   backtrace (crc 3ce24e58):
>     __kmalloc_noprof+0x635/0x870
>     nvmet_auth_ctrl_sesskey+0xfa/0x3a0 [nvmet]
>     nvmet_auth_reply+0x436/0xd00 [nvmet]
>     nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
>     process_one_work+0xd98/0x1390
>     worker_thread+0x60b/0x1000
>     kthread+0x36c/0x470
>     ret_from_fork+0x5dc/0x8e0
>     ret_from_fork_asm+0x1a/0x30
> unreferenced object 0xff11000267237a80 (size 32):
>   comm "kworker/u48:2", pid 139664, jiffies 4401374635
>   hex dump (first 32 bytes):
>     20 25 77 95 60 f2 19 5a 09 20 2c 25 8b 04 2a 4b   %w.`..Z. ,%..*K
>     b9 53 8e 10 39 b9 07 0d e0 fc 93 3f 82 50 86 0c  .S..9......?.P..
>   backtrace (crc 3f42440d):
>     __kmalloc_node_track_caller_noprof+0x637/0x880
>     kmemdup_noprof+0x22/0x50
>     nvmet_auth_reply+0x2ba/0xd00 [nvmet]
>     nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
>     process_one_work+0xd98/0x1390
>     worker_thread+0x60b/0x1000
>     kthread+0x36c/0x470
>     ret_from_fork+0x5dc/0x8e0
>     ret_from_fork_asm+0x1a/0x30
> unreferenced object 0xff11000138f46e40 (size 32):
>   comm "kworker/u48:2", pid 139664, jiffies 4401374654
>   hex dump (first 32 bytes):
>     2d da 99 66 3b e7 d6 65 aa d7 1f a6 51 b4 ab 19  -..f;..e....Q...
>     46 d7 30 0d 12 fd 55 90 c4 6a 4a 7a b8 55 7f 4f  F.0...U..jJz.U.O
>   backtrace (crc 3ab35d56):
>     __kmalloc_noprof+0x635/0x870
>     nvmet_auth_challenge+0x329/0x9f0 [nvmet]
>     nvmet_execute_auth_receive+0x381/0x7b0 [nvmet]
>     process_one_work+0xd98/0x1390
>     worker_thread+0x60b/0x1000
>     kthread+0x36c/0x470
>     ret_from_fork+0x5dc/0x8e0
>     ret_from_fork_asm+0x1a/0x30
> unreferenced object 0xff11000126860400 (size 256):
>   comm "kworker/u48:2", pid 139664, jiffies 4401374658
>   hex dump (first 32 bytes):
>     cb 48 8c 49 58 82 bd fd 21 5b e4 a5 5b 5e 7b 8b  .H.IX...![..[^{.
>     48 6a 47 3e 9f b7 76 06 c8 47 6a 5f 3e b4 20 15  HjG>..v..Gj_>. .
>   backtrace (crc b164cda1):
>     __kmalloc_noprof+0x635/0x870
>     nvmet_auth_ctrl_sesskey+0xfa/0x3a0 [nvmet]
>     nvmet_auth_reply+0x436/0xd00 [nvmet]
>     nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
>     process_one_work+0xd98/0x1390
>     worker_thread+0x60b/0x1000
>     kthread+0x36c/0x470
>     ret_from_fork+0x5dc/0x8e0
>     ret_from_fork_asm+0x1a/0x30
> unreferenced object 0xff11000138f468c0 (size 32):
>   comm "kworker/u48:2", pid 139664, jiffies 4401374662
>   hex dump (first 32 bytes):
>     01 dd af 3b af a0 f8 ec 61 80 c4 aa ad 56 9a 27  ...;....a....V.'
>     d4 f9 f9 8d 98 64 ce 5a 81 e2 14 e0 e3 5c 79 97  .....d.Z.....\y.
>   backtrace (crc b24f43c2):
>     __kmalloc_node_track_caller_noprof+0x637/0x880
>     kmemdup_noprof+0x22/0x50
>     nvmet_auth_reply+0x2ba/0xd00 [nvmet]
>     nvmet_execute_auth_send+0xc7f/0x14f0 [nvmet]
>     process_one_work+0xd98/0x1390
>     worker_thread+0x60b/0x1000
>     kthread+0x36c/0x470
>     ret_from_fork+0x5dc/0x8e0
>     ret_from_fork_asm+0x1a/0x30
> unreferenced object 0xff11000185c80580 (size 64):
>   comm "kworker/u48:2", pid 139664, jiffies 4401374716
>   hex dump (first 32 bytes):
>     bf a4 73 5a 5c a7 d7 8e f7 6e f9 39 3a 94 66 a4  ..sZ\....n.9:.f.
>     8e f9 bc f6 9a 23 ac dc c8 71 85 ef 09 4c ac 38  .....#...q...L.8
>   backtrace (crc 70f5e8bf):
>     __kmalloc_noprof+0x635/0x870
>     nvmet_auth_challenge+0x329/0x9f0 [nvmet]
>     nvmet_execute_auth_receive+0x381/0x7b0 [nvmet]
>     process_one_work+0xd98/0x1390
>     worker_thread+0x60b/0x1000
>     kthread+0x36c/0x470
>     ret_from_fork+0x5dc/0x8e0
>     ret_from_fork_asm+0x1a/0x30


