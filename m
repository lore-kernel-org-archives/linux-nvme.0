Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32E7606A32D
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Nov 2026 14:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GdujCjLL;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20260707.gappssmtp.com header.i=@isslab-korea-ac-kr.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ou7OYlyM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=4OeI5EFvoaAXtoZ5Eb5FS6GHhurfl3MoetK4e4Eh3dw=; b=GdujCjLLciq9+a
	0qr1i357YjX1eHFhf+ncaK/ZG2Om/YPCz71jhGHgYnqOzZDWkAqRKmBsfxsYtz3eJi4dqMjV/fjs6
	ULaK6DOBEHx/JhpP6yIdwAbhLAleVIScOALt1nZAw1WWX0zCX5njshQKR1RU+PUOQVIXFV3l6PtoE
	T02iQDpiAG8VegONiLetD1LWc8ZvUxjucH2/AZAMUMqChDcIHAsHoxj5GcV13xpMuq/TLAFa6JUVZ
	xDRBQq/6hsaNhAGlmtIxFbd+lfG4xGnTO8XPbU2AUgqJudUJE1kGOQrb9MmEbrn/zQIBvspyA0UE2
	Cd+ZOx+xhBiQCEz4gFtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWESt-0000000AHJN-464I;
	Wed, 25 Nov 2026 14:59:19 +0000
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWESn-0000000AHIM-2wJs
	for linux-nvme@lists.infradead.org;
	Wed, 25 Nov 2026 14:59:15 +0000
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-8b68e59ab33so4252382b3a.2
        for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2026 06:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20260707.gappssmtp.com; s=20260707; t=1795618752; x=1796223552; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4OeI5EFvoaAXtoZ5Eb5FS6GHhurfl3MoetK4e4Eh3dw=;
        b=ou7OYlyMkB5RebM6yx5SMRYVDM9NLf+w+bO8GFVPUHGnWT2l9zxw5fV97eFX+AGknG
         JANxrimdLX/UtO7dtR6010jFqTl9LtEhFbx9z4W81PrGU4x4XPwEO9i5tOr0y4yF/EdC
         BfJolT2Yvvm2JznUAscU630u1P0LTVN7aOVf4PCVteZ3JC/NtMjqWnwG7oZ5vgoYoFLE
         SSHvQJ6f6dgwUor5iIz9kbSXV+SvbswtuCm48n7ErFdagJq2a/D2zirqMjA1o98zNsAm
         Mq8eKrGEWMjosQhcHmpy/XBBWme960O5KnKYSZ6UbCb1nvfAhRXcEGy8wmninA3Dvukn
         ZeXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795618752; x=1796223552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4OeI5EFvoaAXtoZ5Eb5FS6GHhurfl3MoetK4e4Eh3dw=;
        b=RTGHXTTx0niSeNfd4Bi008i6EumAGRL5aEfphv9B6QF2Nx9xIXrkKdWjPfDZo7biXM
         Tr/oX597GvPy1npcaFSojihY8gz6v7HwUuWMth+DskiEmXXea1IG/VvB5QXaQsj8qLqT
         Hlh2H1x/rHnziGr7bP6JH0Z5KTTbmACtcQeZQ+/3AXGaXh+WIlnrRDKeSTDigWeNGlyC
         yIiz3o68G2n8S0BVBeZxqOdbqztr3oDY2hpPhKZRqo6moBUnU6f2F8VpI98CowefUYEN
         yyWFH4k7TyOLjoK6wo6Ltw7aw9kjcnylqueFsEUC25RctxIXAH0oK47qGMVYEHXSNzPJ
         dIRg==
X-Forwarded-Encrypted: i=1; AL+hErHDwKxsoVMuAdkUEzhQtPdh2hPIYzNyuHoHVqB+nAgMBFntM9ENATHPYM2lcVXU2s9wQMc5EAe7u8Mn@lists.infradead.org
X-Gm-Message-State: APuU4Z/dyTe/9yRgddIsqlt8jn+uc0vAG+Q1M4eK07Vdgo5dKUeAG6j5
	WgCSR3dMANG0glFgAYn/ztW6lO9RZmCLRvdWOUebsnlGIabWd9ZrC9/lXCRjJZwrlUA=
X-Gm-Gg: AZFdTZdgiIEVMMZ7r0XdWOirIhfMaMcJXRwyQBH9MxCI8uNHTGUJnruyTViWoCg93Pf
	c8aQKO6DTqL/M4Kmz+MQh3dDI1PpgsuOBy/Hrj5Rsx74aFAlIDsy/LfrzsuB7bfIv+qv2gCFSuB
	9DulNxUXQoO0dkHMO6rmbTtIycKjk3EKoiZA5zm96r1zfWDACa4vFqITDUf5X8W0+2InnmWOIBt
	+HcsEP3QNrKobvBYTHfipZ1ewD2rvfXoEreLX8nOwflPNwrtT4w3CyJCTFQGydp1pnCBMPjckNk
	v9q2OPn0SV7LwUFtMlLUNIyCl/wjp5kAL+mUYDFBdmikmZ+6XoVwBEyz7RIr8CN8/Dgv/a6f2JY
	m6aZlFLMHy1HEbcttRanYhgS+an2ulXyAQ/lGI5zHS+3GPBW9bxYo6e7JBA9Qx+HuQaI0wB+YAg
	W8a83TdaNtZVGwIUuf8tI35KYAw35kZK+20bNeM+1xfJz93Bdm1bHIJIE2W6bj1nLc0/KNO+Jp+
	pEwPR837fIlqse5KkkfM7IfaGZmnVYcp8r+IJFgO6SCGXjr32ONtbK9u10NmouMGEzjmVTGfJwU
	kOQYgPx4VfVGUsgOzB+Ul47KriLKz4RsRr7jS6FgRJPp8pAT6RRq9ctBqC6dqxvPP/8kOL52k40
	HsoPchrO87mTO795euBdkHCdasdL9wuMSoIwd2w==
X-Received: by 2002:a05:6a00:410f:b0:89e:71df:d6da with SMTP id d2e1a72fcca58-8c8796a7bbcmr14809643b3a.5.1795618752315;
        Wed, 25 Nov 2026 06:59:12 -0800 (PST)
Received: from localhost.localdomain ([2406:5900:1044:110c:6ad4:29a9:2f98:35a3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e45756sm9117488b3a.27.2026.11.25.06.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 06:59:11 -0800 (PST)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me
Cc: kamaljit.singh@opensource.wdc.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvme: reject a controller type change on reinitialization
Date: Wed, 25 Nov 2026 23:59:02 +0900
Message-ID: <20261125145902.254297-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261124133122.4167640-1-yhlee@isslab.korea.ac.kr>
References: <20261124133122.4167640-1-yhlee@isslab.korea.ac.kr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261125_065913_827622_B7C0D46F 
X-CRM114-Status: GOOD (  19.17  )
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

nvme_init_identify() caches id->cntrltype on every initialization, and the
Identify Controller data is read again on every reconnect.  A fabrics
controller that reported itself as an I/O controller on the first connect
can therefore report itself as an administrative controller on a reconnect,
after its namespaces are in use.

nvme_init_ctrl_finish() then overrides queue_count to 1, so the transport
skips I/O queue setup and the queues that error recovery freed are never
reallocated, leaving queue->sock NULL.  The controller is switched to LIVE
anyway with the namespaces still present, and nvme_check_ready() lets any
request through once the state is LIVE, so blk-mq dispatches to the freed
queue:

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

Reject any controller type change on a controller that has already been
initialized.

Fixes: e715b8733df60a ("nvme: add capability to connect to an administrative controller")
Cc: stable@vger.kernel.org
Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
---
v1: https://lore.kernel.org/linux-nvme/20261124133122.4167640-1-yhlee@isslab.korea.ac.kr/

Changes in v2, after review feedback:
- Generalize the check and move it.  v1 rejected the change from inside
  the administrative-controller override in nvme_init_ctrl_finish(), and
  only for the I/O-to-administrative direction.  v2 checks in
  nvme_init_identify(), immediately before ctrl->cntrltype is overwritten,
  and rejects any controller type change on an already initialized
  controller.  That also covers administrative-to-I/O and changes to or
  from a discovery controller, both of which v1 let through.
- Cut the commit message down to the basics: drop the walkthrough of the
  resulting state, the CVE references and the note about the other fabrics
  transports.
- The subject changed with the generalization ("an administrative
  controller type" -> "a controller type change"); say so and it goes back
  to the v1 wording.

 drivers/nvme/host/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f43582e5f6c4a9..ffe6a63d24e1dc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3736,6 +3736,18 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->max_namespaces = le32_to_cpu(id->mnan);
 	ctrl->ctratt = le32_to_cpu(id->ctratt);
 
+	/*
+	 * The controller type fixes whether the controller has I/O queues,
+	 * so it must not change while the controller is in use.
+	 */
+	if (ctrl->identified && ctrl->cntrltype != id->cntrltype) {
+		dev_err(ctrl->device,
+			"controller type changed from %u to %u on reinitialization\n",
+			ctrl->cntrltype, id->cntrltype);
+		ret = -EINVAL;
+		goto out_free;
+	}
+
 	ctrl->cntrltype = id->cntrltype;
 	ctrl->dctype = id->dctype;
 
-- 
2.43.0


