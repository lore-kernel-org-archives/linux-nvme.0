Return-Path: <SRS0=eYyw=5R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46379C43331
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 05:44:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12DA02072E
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Apr 2020 05:44:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GpZs3MlV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12DA02072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XlVza4Hf7sa+t5PFEX2VxmeLVNs4Rp8vqFUUUjJu1rs=; b=GpZs3MlVbHYVUb
	+XS2vbpS2o790RXr/puKX0lfGTRRyBpRD6KD6TePyaOGHX+jv8p/qRElXRp58iOIBfbU0rQOKVDwq
	3C3ZKAXZnyLEQ1xUGlGx7L9TvQoqkwWEM871uKCQz/9gv6KeDGMWS+X1Or7KsKUX4XaZGcC41Nf13
	EDaopxdwu9vKzQneXExKcs/lgYpRJDqOe5zoISQhP2y252rXstv1UfWbjDO/CyK2tLGOpihbzTdC0
	wBnYEVc0LjuMcqcn3RYMVPHpEVFz9fXnchYRQGkPsKS7Z8nQjy0zo79ruwZ7/JB2jplIFN83HU6jP
	2hBqTKS7EaQACKghcqug==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJWB0-0003OE-5c; Wed, 01 Apr 2020 05:44:34 +0000
Received: from [2601:647:4802:9070:cca1:4ce7:5ea6:1461]
 (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJWAy-0003M9-DX; Wed, 01 Apr 2020 05:44:32 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/2] nvme-tcp: fix possible crash in recv error flow
Date: Tue, 31 Mar 2020 22:44:23 -0700
Message-Id: <20200401054423.4592-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If the target misbehaves and sends us unexpected payload we
need to make sure to fail the controller and stop processing
the input stream. We clear the rd_enabled flag and stop
the io_work, but we may still requeue it if we still have pending
sends and then in the next invocation we will process the input
stream as the check is only in the .data_ready upcall.

To fix this we need to make sure not to self-requeue io_work
upon a recv flow error.

This fixes the crash:
 nvme nvme2: receive failed:  -22
 BUG: unable to handle page fault for address: ffffbeb5816c3b48
 nvme_ns_head_make_request: 29 callbacks suppressed
 block nvme0n5: no usable path - requeuing I/O
 block nvme0n5: no usable path - requeuing I/O
 block nvme0n7: no usable path - requeuing I/O
 block nvme0n7: no usable path - requeuing I/O
 block nvme0n3: no usable path - requeuing I/O
 block nvme0n3: no usable path - requeuing I/O
 block nvme0n3: no usable path - requeuing I/O
 block nvme0n7: no usable path - requeuing I/O
 block nvme0n3: no usable path - requeuing I/O
 block nvme0n3: no usable path - requeuing I/O
 #PF: supervisor read access inkernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 1039157067 P4D 1039157067 PUD 103915a067 PMD 102719f067 PTE 0
 Oops: 0000 [#1] SMP PTI
 CPU: 8 PID: 411 Comm: kworker/8:1H Not tainted 5.3.0-40-generic #32~18.04.1-Ubuntu
 Hardware name: Supermicro Super Server/X10SRi-F, BIOS 2.0 12/17/2015
 Workqueue: nvme_tcp_wq nvme_tcp_io_work [nvme_tcp]
 RIP: 0010:nvme_tcp_recv_skb+0x2ae/0xb50 [nvme_tcp]
 RSP: 0018:ffffbeb5806cfd10 EFLAGS: 00010246
 RAX: ffffbeb5816c3b48 RBX: 00000000000003d0 RCX: 0000000000000008
 RDX: 00000000000003d0 RSI: 0000000000000001 RDI: ffff9a3040684b40
 RBP: ffffbeb5806cfd90 R08: 0000000000000000 R09: ffffffff946e6900
 R10: ffffbeb5806cfce0 R11: 0000000000000001 R12: 0000000000000000
 R13: ffff9a2ff86501c0 R14: 00000000000003d0 R15: ffff9a30b85f2798
 FS:  0000000000000000(0000) GS:ffff9a30bf800000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffbeb5816c3b48 CR3: 000000088400a006 CR4: 00000000003626e0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  tcp_read_sock+0x8c/0x290
  ? __release_sock+0x9d/0xe0
  ? nvme_tcp_write_space+0xb0/0xb0 [nvme_tcp]
  nvme_tcp_io_work+0x4b4/0x830 [nvme_tcp]
  ? finish_task_switch+0x163/0x270
  process_one_work+0x1fd/0x3f0
  worker_thread+0x34/0x410
  kthread+0x121/0x140
  ? process_one_work+0x3f0/0x3f0
  ? kthread_park+0xb0/0xb0
  ret_from_fork+0x35/0x40

Reported-by: Roy Shterman <roys@lightbitslabs.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ed5a60a6bfa5..d86e7f6d9ae3 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1093,7 +1093,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		if (result > 0)
 			pending = true;
 		else if (unlikely(result < 0))
-			break;
+			return;
 
 		if (!pending)
 			return;
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
