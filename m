Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F2A9C88E59
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Sep 2026 17:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4IJVOSmbNQ3bOhXTyeETR8LNIYP9BVTpAHs6ZZBuPTw=; b=OBS24eBEEfNTrqRv8iVm/frHnZ
	55JDmoFIxKAv+d4KxfuUZnxPZ2Fz4j15MCqZVsBrCf06Lyuc9JhW4ISLR8vsw7cQBsHgqWfLfD17i
	HH0YFXIt12Q5/j+S1ysmr6dntOtyGlQ1rSeReKS/teWZcfV+JrlOm9fpJzU5lAREwb+bPNcJ4ZcRO
	O/yZmsNVoGerHOsqp37j5u9Cp8it+0K/HS2C9CDBN6oNsHaMTYqM+ySvvCBlT8EL892ocInCX7p1+
	UY0d5OSHjP3r0feR0w6NS5eJPsjqgMZUN6tNDDBWm/ZcJIjA9SQqhptXe96BvfOcmlm8d9bVfik1J
	vL9UiuCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5RG4-000000011zA-3hTa;
	Sat, 12 Sep 2026 17:11:20 +0000
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x5RG1-000000011yp-0RWC
	for linux-nvme@lists.infradead.org;
	Sat, 12 Sep 2026 17:11:18 +0000
Received: by mail-pz2-x10.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so1206820b3a.3
        for <linux-nvme@lists.infradead.org>; Sat, 12 Sep 2026 10:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789233075; x=1789837875; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4IJVOSmbNQ3bOhXTyeETR8LNIYP9BVTpAHs6ZZBuPTw=;
        b=NqHyUmsoyA3e0+sSLpDQKbM0tu9S5a6tv255LuqyMWVsBDJw4NmFNmhN0KpLZoZ6SQ
         P21Wo38JYY5JvjOE3vg0i3Q7oCx2fis0jE1np3AA+V8gD9NpKq2eN31LSKSCk0+LNKJX
         39XF0fPj2IqDpk/pGuqiANbJHvBWRfGtu9VWqxahwjWHYrohkGHKMFIJqfmdlvnyilWN
         scGVTMQF86oLMoDOwT8hFUbKXmaw464401RKFlIggaiiVuR3rtSFKgvoqY1kHiZCJvJq
         ubZjmNU1wo7OnkREzHVzKfAOMX66g6JxPAg8mR7qh93Z5sV9/yrdFL836W9IPnGbtcDi
         uvLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789233075; x=1789837875;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4IJVOSmbNQ3bOhXTyeETR8LNIYP9BVTpAHs6ZZBuPTw=;
        b=HwM/KE9piq7dZuj6kUwjn6zkNAl3UicoFhi6VLeLXlB3Z4p91RrBVHhx2DG9cyP5Wg
         vexxHeGe/2pg37J2Mamnzar6i2RTZ+v0qRn6FX+0kk4w0a/rGUN+ZKIkZWE6aj6pA5n8
         ZKv1OeadsobdWu2x+yLPX+ys2pen2H72GrcSvfWQHLZhHaeslcB/HOQ/Xm1rvqnGHCfq
         4f8TDxKtBqo/JmqIzTLMf4NcyifTzft+uXTTeZggz9kB6cFrQJXaGD6dg4hucHomPXfg
         bB8ln0gxG3ux6KyABc7P6fxxmBSzIM7EZXYJFd0kEd5pYtR+CD49xceIWLyNw6g1SbjA
         AubA==
X-Gm-Message-State: AFuF++ns51hRSSRaki/ADCMufrImwJhviNUmuLVKYn2m2dEeMIZ9JZx2
	dm716j179FPyxOjA9CXplXY2lajqvirgazO8vW/mEQBaHKRs9e2l4ENq
X-Gm-Gg: AYBFou3vrCceG8q+PGHXDTt9uHB9l6y9pgloEH5NC3Yo6YjfvO98FxP33ouY+9gu9gA
	DIBJvRR2krZRwwYRrrINM7Ppx1ai12FyAlo15N/QBqpgr8GP26NYMxSjOq48GjjAP/oUKOPwXWp
	UzKMqORe3UJb/YI+qg3QLiyNOWGZAK/uLub0agykJpDgwomy9aKX4Z7Hg6QW5akmcfyLvEnTze5
	Ctg/0eZJJbQjnTsLerW2iW+bH/ifOEDI/hyY7yAUjxMcIgjtpKRDe9Fw0tYy7GrY/n72DgZrZI+
	642mEKw9qo0jp1ZkwoEfX9WzsT6LWfW4Tz/sWgO0mFtqGVngqp7czPsn0LekMKtmBMtkdk8rjbQ
	WTZ2gHLw1kAxTuLI8/Q8IhiLWaV/Rr7+TrfZAsgwRfKrTeY1rwqYFH5Nj7h9Qc0ia7VdYE4h2eW
	4E9L9VtGOVJtU5yydQNHU4sknPXu4rbr4+HpwU5itqvBt6DxRBhTYmT6yDRUQnX9I+K4e1QcGQ4
	h0V6PZFlSqSakIczbAss9iLhyoTDfP8
X-Received: by 2002:a05:6a00:c488:b0:86c:bf42:fa44 with SMTP id d2e1a72fcca58-86cbf4303b4mr3739515b3a.6.1789233075465;
        Sat, 12 Sep 2026 10:11:15 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86c7b4922b2sm1133637b3a.2.2026.09.12.10.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 10:11:14 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	co+77553a7fc66ac133@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvmet-auth: fix out-of-bounds write in nvmet_auth_challenge()
Date: Sun, 13 Sep 2026 01:10:11 +0800
Message-ID: <20260912171009.1513289-3-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260912_101117_173570_741B9B24 
X-CRM114-Status: GOOD (  13.11  )
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

nvmet_auth_challenge() receives its output buffer as a void pointer.
sizeof(*d) therefore evaluates to one with GCC and undercounts the fixed
challenge header by 15 bytes.  A short AUTH_RECEIVE buffer can pass the
check before the challenge is copied past the end of its allocation.

Use the typed challenge pointer when calculating the response size.

  BUG: KASAN: slab-out-of-bounds in nvmet_execute_auth_receive (drivers/nvme/target/fabrics-cmd-auth.c:442 drivers/nvme/target/fabrics-cmd-auth.c:569)
  Write of size 32 by task kworker/1:1H/64
  Workqueue: nvmet_tcp_wq nvmet_tcp_io_work
  Call Trace:
  nvmet_execute_auth_receive (drivers/nvme/target/fabrics-cmd-auth.c:442 drivers/nvme/target/fabrics-cmd-auth.c:569)
  nvmet_tcp_try_recv_pdu (drivers/nvme/target/tcp.c:1119 drivers/nvme/target/tcp.c:1243)
  nvmet_tcp_io_work (drivers/nvme/target/tcp.c:1350 drivers/nvme/target/tcp.c:1382 drivers/nvme/target/tcp.c:1445)
  process_one_work (kernel/workqueue.c:3322)
  worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3486)
  kthread (kernel/kthread.c:436)
  ret_from_fork (arch/x86/kernel/process.c:158)
  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
  The buggy address is located 16 bytes inside of
   allocated 33-byte region [ffff888000554e80, ffff888000554ea1)
  Kernel panic - not syncing: KASAN: panic_on_warn set ...

Cc: stable@vger.kernel.org
Fixes: db1312dd9548 ("nvmet: implement basic In-Band Authentication")
Reported-by: co+77553a7fc66ac133@bugs.sh
Closes: https://lore.kernel.org/all/Ah6QavQXwvshtqyUcYD1P1R7XE0ND9fB7lbV@bugs.sh/
Assisted-by: Codex:gpt-5.6
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 92f8a76f10..dccdb55a36 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -427,7 +427,7 @@ static int nvmet_auth_challenge(struct nvmet_req *req, void *d, int al)
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	int ret = 0;
 	int hash_len = nvme_auth_hmac_hash_len(ctrl->shash_id);
-	int data_size = sizeof(*d) + hash_len;
+	int data_size = sizeof(*data) + hash_len;
 
 	if (ctrl->dh_tfm)
 		data_size += ctrl->dh_keysize;
-- 
2.55.0

