Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F4060C36002
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Mar 2025 17:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pOiHfP9p0mlqSIoELkUxcyuZubPUyJkOsyllMOrSXD8=; b=ydPJBnYYtvXTRsx8m61Ni6AWAU
	48DM6NlVCgL+iIly1lCQCj0y4PL32Y7WevcKSvFYKXpzhyK7ukStb4Z8zH7rjOF8mufuyv9xUIOIp
	2/ZnJD69S+nGq4TiAxJMu7NVrwc3RYiTZHEvRelgimWo78MZYLIQhZhriJKkPqtVXK0pQKzAhrTyX
	h+05OjnEivS3yMsyfB0a4JoAtEkugADtJAO+zR9ilbiPA7tKO6Tz9C7qriOa5L9t064N75Ol/rQ9M
	T5kkfr6SO8TqZfnZHGuU+sLukf1pfD9nqc9f/O3WQtTASqUs11bOHvKofjvUVHdL1xsytLXoQqzfJ
	afHIZVOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1twlvm-00000003rSc-1I40;
	Mon, 24 Mar 2025 17:49:46 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1twlvj-00000003rNv-0AwL
	for linux-nvme@lists.infradead.org;
	Mon, 24 Mar 2025 17:49:44 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-22403cbb47fso89635135ad.0
        for <linux-nvme@lists.infradead.org>; Mon, 24 Mar 2025 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1742838582; x=1743443382; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pOiHfP9p0mlqSIoELkUxcyuZubPUyJkOsyllMOrSXD8=;
        b=PNA58BTqBQYk3mTxsXK/TBMaO7wEjJH0MT23yOKeRLZGR6mj0u4b2Fp7Hfj4EqDdbC
         TZ3fUTfb5ol334PPXzA/jDXwGLDjJjU8MEtkqgWCHVGBWCpeOxonnOLIXyJBKSenThwH
         Vyt4vdQdk/rmNIh+yP2xE1ZztXE+vMbUUpDaSZkfwN9mMkJlxClBNmXoKvanHEjp1zlB
         mNUnfcMv5ok5jwvSEGNcZaliel2EbDrVzp1A7Pvejlx1eEhqa0w9x6vxN3XGD94qxlYs
         F+rzAD1TOvOqKNI7Y84Wnnx0moi63XrwlWFGEYe8QUl6RR1ECVBkpDPmBYvP9D0D03KJ
         lmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742838582; x=1743443382;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pOiHfP9p0mlqSIoELkUxcyuZubPUyJkOsyllMOrSXD8=;
        b=uwqC8b/3eeaHx+PQ6u42bYqLexIcHw/y06qUE1oX0Sp1JA/zqQgAeCkidFO9NA1hpT
         piCm1INNyhT5ovDtsMsDcZoxM8k+XihiG2nNpx6Cd5cixIikjiirnXyFpeBpK2e9HkoQ
         lUjIESp/IV5knPkJ5y4FNi7h1e9/txWZpFqRnCh86DfA7Ly6FA1CmboeGt+kKT223oYk
         6Fh5GNwvIqH9HDRPX63n1Qn2a+njA5+67QYhxPM3FJUFjnCsM+BCueareXHaF/ItazYR
         Uc60HYChn//i+OjdS98uFfC16xL4AiJ5n+CfkfGvhJRnWlB3qQrnCLwVoL4oAMST2LD2
         mT9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNZ2ABRj0XfPHzAAetVuHTYqKVCdnVJYF2sQvtjU4nu/yYHTihEeqmNIBQVMaQLirMP7TKkvnRbBBU@lists.infradead.org
X-Gm-Message-State: AOJu0Yy6OwuOkMUP4EtwZdplvQptlymmAsQ8Lbhvh52sr06Xjwnl+ONw
	niJRu1D1aUqr1q2bVey6OGFc6F8T6LY8QjG5G0kFHEN2ndtMupfzc0Z9xKcATNU=
X-Gm-Gg: ASbGnctTjHRZJIL2XoK6XtX2+enK/t5aAwPeyU5TU6FN49Wbzf5AU578hw5aogQbHHw
	fUEAUkwGqdjicKfpXVbgfuv1YskF1FltSrUxvz+gnVezD16VU5/r23vVOqe5cOoWFXm502qCkTG
	pTi0H+Og5B/Y74h+xyjoQIamXvmPIX2rArRIzNFCykGZQ6LEnYK25ibryyT9IR9Kfxr0sVQDX/f
	Q+N78z1jYM/QeMCP35il2EULDzt4EJkIOWe1FCN3jPfpt2HYfjBAWl5hcR9cTUBHarXq40CZEBB
	u4e+YBAGTTQBQUO0wFvn6R6ddv8XYbEUgorkI4t/CkhXrJjQg1A=
X-Google-Smtp-Source: AGHT+IH0d58rGWHCXEpkj7PaCzoJMt0vqxtCsjEoJi4vb1FwzxgpckX9h31G9WT2Is6kAP/nriGNww==
X-Received: by 2002:a17:902:f605:b0:224:2207:5130 with SMTP id d9443c01a7336-22780e260d3mr210963105ad.45.1742838581913;
        Mon, 24 Mar 2025 10:49:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8900:32c0::e120])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-301bf576c7dsm12505821a91.3.2025.03.24.10.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:49:41 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <wagi@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	randyj@purestorage.com,
	adailey@purestorage.com,
	jrani@purestorage.com,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com
Subject: [RFC PATCH v1 7/7] nvme-tcp: Do not immediately cancel inflight requests during recovery
Date: Mon, 24 Mar 2025 10:49:00 -0700
Message-ID: <20250324174909.3919131-8-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324174909.3919131-1-mkhalfella@purestorage.com>
References: <20250324174909.3919131-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250324_104943_087633_EE36B45A 
X-CRM114-Status: GOOD (  13.13  )
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

In case of controller recovery, reset, or deletion it is possible there
are inflight requests for which no response was received from target
controller. TP4129 requires such inflight requests to not be canceled
immediately. Instead these requests should be held until the target
learns about disconnection and quiesce pending nvme commands. Implement
this for nvme-tcp.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/tcp.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 327e37a25281..822e6329e332 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2252,12 +2252,14 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	return error;
 }
 
-static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl)
+static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
+					  bool hold_reqs)
 {
 	nvme_quiesce_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
-	nvme_cancel_admin_tagset(ctrl);
+	if (!hold_reqs)
+		nvme_cancel_admin_tagset(ctrl);
 	nvme_tcp_free_admin_queue(ctrl);
 	if (ctrl->tls_pskid) {
 		dev_dbg(ctrl->device, "Wipe negotiated TLS_PSK %08x\n",
@@ -2274,12 +2276,14 @@ static void nvme_tcp_suspend_io_queues(struct nvme_ctrl *ctrl)
 	nvme_sync_io_queues(ctrl);
 }
 
-static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl)
+static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
+					bool hold_reqs)
 {
 	if (ctrl->queue_count <= 1)
 		return;
 	nvme_tcp_stop_io_queues(ctrl);
-	nvme_cancel_tagset(ctrl);
+	if (!hold_reqs)
+		nvme_cancel_tagset(ctrl);
 	nvme_tcp_free_io_queues(ctrl);
 }
 
@@ -2375,7 +2379,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 	}
 destroy_admin:
 	nvme_stop_keep_alive(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl);
+	nvme_tcp_teardown_admin_queue(ctrl, false);
 	if (new) {
 		nvme_unquiesce_admin_queue(ctrl);
 		nvme_remove_admin_tag_set(ctrl);
@@ -2418,10 +2422,12 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	nvme_tcp_suspend_io_queues(ctrl);
-	nvme_tcp_teardown_io_queues(ctrl);
+	nvme_tcp_teardown_io_queues(ctrl, true);
+	nvme_tcp_teardown_admin_queue(ctrl, true);
+	if (nvme_queue_held_requests_work(ctrl))
+		nvme_wait_for_held_requests(ctrl);
 	/* unquiesce to fail fast pending requests */
 	nvme_unquiesce_io_queues(ctrl);
-	nvme_tcp_teardown_admin_queue(ctrl);
 	nvme_unquiesce_admin_queue(ctrl);
 	nvme_auth_stop(ctrl);
 
@@ -2439,11 +2445,15 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
+	bool hold_reqs;
+
 	nvme_tcp_suspend_io_queues(ctrl);
-	nvme_tcp_teardown_io_queues(ctrl);
 	nvme_quiesce_admin_queue(ctrl);
-	nvme_disable_ctrl(ctrl, shutdown);
-	nvme_tcp_teardown_admin_queue(ctrl);
+	hold_reqs = nvme_disable_ctrl(ctrl, shutdown);
+	nvme_tcp_teardown_io_queues(ctrl, hold_reqs);
+	nvme_tcp_teardown_admin_queue(ctrl, hold_reqs);
+	if (hold_reqs && nvme_queue_held_requests_work(ctrl))
+		nvme_wait_for_held_requests(ctrl);
 }
 
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
-- 
2.48.1


