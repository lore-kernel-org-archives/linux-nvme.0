Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A70CAC5B9
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Sep 2025 08:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=azYo/pBu05c4Lf+6DyUdsC5PhMXCfDYnULmC4Kbfuqw=; b=PiYg+UPjTsJFxzGA0fgTu5bmms
	lw36vmqKIEgS4M7+ksr0Y0X6338o0EL7XdjK8NnzZDSXmXfaMnVDvb0JKBB/K88HNystYlts2X1BH
	G9L72lsf7+FGbH+JLo/z+eHspfhlcT6+NYZSko70TVWuWgNuwTmjRaGTbXn0svgSN3f6l7Wdh6BAu
	P9F/NnpdlV2X3C8HHjKsSlqvd5JDRiX9xa4Mo3sTYaCy34JszRv5EyW5w4CPlP3hEpoNRrHxhmIFF
	52Q7Oo+wtrQrJswgbMpn/R1vyUONOnut8Md8RcSf44IdBihF64SZA2JsFro1BCfNukd954kg742qC
	OPTuVTIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3VxV-00000004gGG-2i4a;
	Tue, 30 Sep 2025 08:43:41 +0000
Received: from mx1.emlix.com ([178.63.209.131])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3VxR-00000004gES-30kl
	for linux-nvme@lists.infradead.org;
	Tue, 30 Sep 2025 08:43:39 +0000
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.emlix.com (Postfix) with ESMTPS id 2D0F25F8CE;
	Tue, 30 Sep 2025 10:43:34 +0200 (CEST)
From: Rolf Eike Beer <eb@emlix.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Yanjun Zhang <zhangyanjun@cestc.cn>
Cc: linux-nvme@lists.infradead.org, stable@kernel.org
Subject: [PATCH 5.4] nvme: fix multipath crash caused by flush request when  blktrace
 is enabled
Date: Tue, 30 Sep 2025 10:43:33 +0200
Message-ID: <3373374.aeNJFYEL58@devpool92.emlix.com>
Organization: emlix GmbH
In-Reply-To: <5015244.GXAFRqVoOG@devpool92.emlix.com>
References: <5015244.GXAFRqVoOG@devpool92.emlix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250930_014337_916617_C8D1D3C2 
X-CRM114-Status: GOOD (  15.91  )
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

=46rom: Yanjun Zhang <zhangyanjun@cestc.cn>
Date: Thu, 22 Dec 2022 09:57:21 +0800

commit 3659fb5ac29a5e6102bebe494ac789fd47fb78f4 upstream.

The flush request initialized by blk_kick_flush has NULL bio,
and it may be dealt with nvme_end_req during io completion.
When blktrace is enabled, nvme_trace_bio_complete with multipath
activated trying to access NULL pointer bio from flush request
results in the following crash:

[ 2517.831677] BUG: kernel NULL pointer dereference, address: 0000000000000=
01a
[ 2517.835213] #PF: supervisor read access in kernel mode
[ 2517.838724] #PF: error_code(0x0000) - not-present page
[ 2517.842222] PGD 7b2d51067 P4D 0
[ 2517.845684] Oops: 0000 [#1] SMP NOPTI
[ 2517.849125] CPU: 2 PID: 732 Comm: kworker/2:1H Kdump: loaded Tainted: G =
S                5.15.67-0.cl9.x86_64 #1
[ 2517.852723] Hardware name: XFUSION 2288H V6/BC13MBSBC, BIOS 1.13 07/27/2=
022
[ 2517.856358] Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
[ 2517.859993] RIP: 0010:blk_add_trace_bio_complete+0x6/0x30
[ 2517.863628] Code: 1f 44 00 00 48 8b 46 08 31 c9 ba 04 00 10 00 48 8b 80 =
50 03 00 00 48 8b 78 50 e9 e5 fe ff ff 0f 1f 44 00 00 41 54 49 89 f4 55 <0f=
> b6 7a 1a 48 89 d5 e8 3e 1c 2b 00 48 89 ee 4c 89 e7 5d 89 c1 ba
[ 2517.871269] RSP: 0018:ff7f6a008d9dbcd0 EFLAGS: 00010286
[ 2517.875081] RAX: ff3d5b4be00b1d50 RBX: 0000000002040002 RCX: ff3d5b0a270=
f2000
[ 2517.878966] RDX: 0000000000000000 RSI: ff3d5b0b021fb9f8 RDI: 00000000000=
00000
[ 2517.882849] RBP: ff3d5b0b96a6fa00 R08: 0000000000000001 R09: 00000000000=
00000
[ 2517.886718] R10: 000000000000000c R11: 000000000000000c R12: ff3d5b0b021=
fb9f8
[ 2517.890575] R13: 0000000002000000 R14: ff3d5b0b021fb1b0 R15: 00000000000=
00018
[ 2517.894434] FS:  0000000000000000(0000) GS:ff3d5b42bfc80000(0000) knlGS:=
0000000000000000
[ 2517.898299] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2517.902157] CR2: 000000000000001a CR3: 00000004f023e005 CR4: 00000000007=
71ee0
[ 2517.906053] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[ 2517.909930] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[ 2517.913761] PKRU: 55555554
[ 2517.917558] Call Trace:
[ 2517.921294]  <TASK>
[ 2517.924982]  nvme_complete_rq+0x1c3/0x1e0 [nvme_core]
[ 2517.928715]  nvme_tcp_recv_pdu+0x4d7/0x540 [nvme_tcp]
[ 2517.932442]  nvme_tcp_recv_skb+0x4f/0x240 [nvme_tcp]
[ 2517.936137]  ? nvme_tcp_recv_pdu+0x540/0x540 [nvme_tcp]
[ 2517.939830]  tcp_read_sock+0x9c/0x260
[ 2517.943486]  nvme_tcp_try_recv+0x65/0xa0 [nvme_tcp]
[ 2517.947173]  nvme_tcp_io_work+0x64/0x90 [nvme_tcp]
[ 2517.950834]  process_one_work+0x1e8/0x390
[ 2517.954473]  worker_thread+0x53/0x3c0
[ 2517.958069]  ? process_one_work+0x390/0x390
[ 2517.961655]  kthread+0x10c/0x130
[ 2517.965211]  ? set_kthread_struct+0x40/0x40
[ 2517.968760]  ret_from_fork+0x1f/0x30
[ 2517.972285]  </TASK>

To avoid this situation, add a NULL check for req->bio before
calling trace_block_bio_complete.

Signed-off-by: Yanjun Zhang <zhangyanjun@cestc.cn>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Rolf Eike Beer <eb@emlix.com>
=2D--
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Please check if I have messed up sending the original From:/Date:.

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c492d7d323987..e81bb16a19ebb 100644
=2D-- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -587,7 +587,7 @@ static inline void nvme_trace_bio_complete(struct reque=
st *req,
 {
 	struct nvme_ns *ns =3D req->q->queuedata;
=20
=2D	if (req->cmd_flags & REQ_NVME_MPATH)
+	if ((req->cmd_flags & REQ_NVME_MPATH) && req->bio)
 		trace_block_bio_complete(ns->head->disk->queue,
 					 req->bio, status);
 }
=2D-=20
2.51.0



=2D-=20
Rolf Eike Beer

emlix GmbH
Headquarters: Berliner Str. 12, 37073 G=C3=B6ttingen, Germany
Phone +49 (0)551 30664-0, e-mail info@emlix.com
District Court of G=C3=B6ttingen, Registry Number HR B 3160
Managing Directors: Heike Jordan, Dr. Uwe Kracke
VAT ID No. DE 205 198 055
Office Berlin: Panoramastr. 1, 10178 Berlin, Germany
Office Bonn: Bachstr. 6, 53115 Bonn, Germany
http://www.emlix.com

emlix - your embedded Linux partner



