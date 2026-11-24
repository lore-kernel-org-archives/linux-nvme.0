Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECECA606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Nov 2026 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Itrn5fbu;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=If+x2l3r
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=Me8KIRmzXo/bdvyOB/3ftu/EhGKIsFSgZhz0hOWyiNk=; b=Itrn5fbuVyqhWWuCD0XQxrdibG
	qlYNAImwzjcQD8EXbnsjdGoYvuFsoEn2AXeI40jKu9SzZ6DVvTV+3oOKM9BmICo0lw1pOneFcErNI
	JOqUUlusOLL6hAvRI9BD5SA97P5Odx2VQixh2JYGQon41KdtU7kAgTH7jAj2H2/XuRbvZ5ZXJ7Fyg
	Nu7egV+N/iGNwA1OcXVrMdkNjxI7+LV2zKqAx9PPiaXChnyRQeNpQFD4c9MXmEhBnMZNR4eCqrJhT
	jy3HgyiDZ7j//cEU1N4zIrWRje1hRbKoshBwtBeX68nKSiU+w+uht3Rieju1mbWcQVkCHn5QrMUM1
	shm1wTqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVqcZ-00000006dvv-3RmK;
	Tue, 24 Nov 2026 13:31:43 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xVqcP-00000006dug-1Fcl
	for linux-nvme@lists.infradead.org;
	Tue, 24 Nov 2026 13:31:39 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-cd69954c755so3208390a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 24 Nov 2026 05:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1795527090; x=1796131890; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Me8KIRmzXo/bdvyOB/3ftu/EhGKIsFSgZhz0hOWyiNk=;
        b=If+x2l3r4UDMhtyanBxoHeglTzLEf0m/bjt1TdtqbV5PgMolWPB/R9U4HQFcP2yXo0
         dPGHNbvfPfpssdnPyLP51nYlwYxjbrnPZU0y9knTw+3Mq2svDKJ4c/qbaMs1qVLD6cyU
         Rhx5Xv5M14umvQzcJeMfJQUVShpWODlrKoqSBd5g07tHmc1OWSGYxmTFsKjnzWj9IkQS
         pQdMuicMhH9p6h18OVLyk75KOXzmbLjRTQBIQCIwZGx+z6Qef0YhRMN8W6G60JNZwtwm
         VX6Wwya0+N0keOakv/7aD8c0MufPx/53v0xVbrQ/ycIuj5UPVgYultb8l2JxDDK9Drw1
         GmZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795527090; x=1796131890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Me8KIRmzXo/bdvyOB/3ftu/EhGKIsFSgZhz0hOWyiNk=;
        b=TmKxq3PLh8Fch3vAPsSyuvR7u14FNH8iMZMCigVXWMIMx03olg51ocfnL0B2QFe7z+
         UjyzfPV2OGeS1N7fCw97xpDP213ASsvHCCNNmLqjP2vR7FsVeSmQN4mBT1Kkjjt+fNiN
         m53Q2xqYGGdfQvoIafLJVm46iirDcwRJN60kgskTDAOxGBnQpkj3i8nN2uxzwrn6Lmh+
         m/zKZclfiyzdvVFM66fyiuXHQ8oq90li2FNuqk+m05yvLtVsmx8kJ0QIhH8GevyzuZYB
         gfVc12EPOGJAKO9mYBNiZKI9CCOPLOZ8Y1oi6fPO8dHVpgWhdd11hyZ1jJqfazkY4GHn
         +RNQ==
X-Gm-Message-State: APuU4Z/D43CO65DLwyG+mD6cJ52iYFz6ORyqQtRt2GrfIMpoBfv06X6V
	V0ZA/H8FKUPUdtF9wjTo0ZHhuPFFoaRk2VmmQOtFH8pf2gV9uNV3IkQu5xLRLs25lt4=
X-Gm-Gg: AZFdTZeEbamGH4EkJcPPSbkLLvyugk6J9eO1J8BQffitLvexDpkn9mdHODmAnuJCXB1
	SjzXuCLXAP019bRuIGB3hSEkCx97twLVicXBtrCzHq4UClcfZ2PpC2pnoydbOiFPXshI1Xg6iLZ
	g6JDsK1WQsJn704rbRITvoIaUrCtqwwkB0d1xkp4RasCdeKOfnpSj8GPziZK4sBK2iTQaNTY/AA
	Goh4lVlS3wbLIpBU26dNavSXZXIFdBbbHetPmChUJOm7gybe2JBEN4el6vXW9KY2hx1QGJpCRJK
	772cVmwwHT4j4erQltXz0DLEDo0hzBgYvALXJLOGz0cOdhGNqg/id+ue9kCNoeoSLku0LcCz9fl
	Ukqmz5A//AB5UCFbhmjfFhZD92CaKAmi7IZ+4IH1EVTE11+JA9f46BNm1Nd4B7hXEW+QpH1PIvt
	xSxjpqJSuyQiuMKm3m7TFcwWudTKNLoSK1XDow4xkZ6KL8S6o6SlR+UvETk5yrWsCn/Pd+ktN1y
	k+Z3W7MSlc4GTyG/ZIvumBHTzb4QunKuhA9y36LON5byc92r81/3PthfNeWBsKPTL44tWy1BqhB
	Lh6Vqfj0WHWBAnK4v6ETPu8Cf9/1921AkLDMZig22npvttoup2cl3h1KwuOywKjGl61nofSz8f5
	GuLinbtvcuiE+jFzjeprYYkxc/jvM5/tcmdEOZg==
X-Received: by 2002:a17:90b:3fc7:b0:3a8:5cab:1009 with SMTP id 98e67ed59e1d1-3b41cafe282mr14638129a91.46.1795527089980;
        Tue, 24 Nov 2026 05:31:29 -0800 (PST)
Received: from yhlee-960QFG.Davolink ([2406:5900:1044:110c:2bd9:e105:537c:ed15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad46ef5sm22800276a91.8.2026.11.24.05.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 05:31:29 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	kamaljit.singh@opensource.wdc.com
Subject: [PATCH] nvme: reject an administrative controller type on reinitialization
Date: Tue, 24 Nov 2026 22:31:22 +0900
Message-ID: <20261124133122.4167640-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261124_053133_448030_85AFF5BC 
X-CRM114-Status: GOOD (  17.71  )
X-Spam-Score: -1.0 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

nvme_init_ctrl_finish() takes the controller type from the Identify
Controller data, and for an administrative controller it overrides
ctrl->queue_count to 1 so that only an admin queue is created.  The
Identify data is read again on every reconnect, so a controller that
reported itself as an I/O controller on the first connect, and whose
namespaces are in use, can report itself as an administrative controller
on a reconnect.

Nothing absorbs that.  nvme_tcp_setup_ctrl() skips
nvme_tcp_configure_io_queues() because queue_count is 1, so the I/O
queues that nvme_tcp_error_recovery_work() freed are not reallocated and
queue->sock stays NULL.  The controller is switched to NVME_CTRL_LIVE
anyway, while the namespace, its gendisk and its tag set are all still
there, and the I/O queues have been unquiesced on purpose to fail fast
the pending requests.  nvme_check_ready() returns true for any request
once the state is LIVE, without consulting NVME_TCP_Q_LIVE, so blk-mq
dispatches to the freed queue and the send path dereferences the NULL
socket:

  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN NOPTI
  KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
  CPU: 0 UID: 0 PID: 81 Comm: kworker/0:1H Not tainted 7.4.0-rc4 #1 PREEMPT(lazy)
  Workqueue: kblockd blk_mq_run_work_fn
  RIP: 0010:selinux_socket_sendmsg+0x76/0x2f0
  RSP: 0018:ffffc900008ef528 EFLAGS: 00010206
  RAX: dffffc0000000000 RBX: ffffc900008ef730 RCX: ffffffff822ab089
  RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffffc900008ef738
  RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
  R10: 0000000000000001 R11: ffffffff84c14740 R12: 0000000000000000
  R13: 0000000000000018 R14: 0000000000000000 R15: 0000000000000000
  FS:  0000000000000000(0000) GS:ffff8880e6931000(0000) knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 00007f52b4001b78 CR3: 0000000009275003 CR4: 0000000000770ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   security_socket_sendmsg+0x6f/0x90
   sock_sendmsg+0x117/0x390
   nvme_tcp_try_send_cmd_pdu+0x4b7/0x9d0
   nvme_tcp_try_send+0x20e/0xbf0
   nvme_tcp_queue_rq+0x1148/0x1510
   blk_mq_dispatch_rq_list+0x3e3/0x1e30
   __blk_mq_sched_dispatch_requests+0x218/0x15c0
   blk_mq_sched_dispatch_requests+0xd7/0x1b0
   blk_mq_run_work_fn+0xe4/0x190
   process_one_work+0x747/0x11c0
   worker_thread+0x57c/0xcb0
   kthread+0x327/0x430
   ret_from_fork+0x394/0x770
   ret_from_fork_asm+0x1a/0x30

The state it leaves behind is stable, not a teardown race: the
controller stays live with cntrltype "admin", queue_count 1 and the
namespace still present, and every I/O submitted to it from then on
takes the host down.

So only override queue_count for a controller that has not been
initialized yet.  A controller that already completed initialization
with I/O queues cannot lose them, so fail the reinitialization and let
the transport retry the reconnect or remove the controller.

An nvme-tcp controller is a remote network peer, and the host driver
already validates its response data as untrusted input elsewhere
(CVE-2026-89481, CVE-2026-89973).  This is the same kind of validation,
on one byte of Identify Controller data.

nvme-rdma and nvme-fc gate their I/O queue setup on queue_count the same
way, so they are exposed to the same sequence; only nvme-tcp was tested.

Fixes: e715b8733df60a ("nvme: add capability to connect to an administrative controller")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
 drivers/nvme/host/core.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f43582e5f6c4a9..831f4c184ddc7c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3826,7 +3826,17 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 		/*
 		 * An admin controller has one admin queue, but no I/O queues.
 		 * Override queue_count so it only creates an admin queue.
+		 *
+		 * Only do that for a controller that has not been initialized
+		 * yet: dropping the I/O queues of a controller that already
+		 * has namespaces leaves them without a transport queue to
+		 * submit to.
 		 */
+		if (ctrl->identified && ctrl->queue_count > 1) {
+			dev_err(ctrl->device,
+				"rejecting administrative controller type for an initialized I/O controller\n");
+			return -EINVAL;
+		}
 		dev_dbg(ctrl->device,
 			"Subsystem %s is an administrative controller",
 			ctrl->subsys->subnqn);
-- 
2.43.0


