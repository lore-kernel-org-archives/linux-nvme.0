Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1769606A32F
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 06:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fkVeOpEv;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QCNPXpN0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=1e5yiaXntYJQtqK8uc9nIplampCx3pEWFOJaZHKAJjI=; b=fkVeOpEviZYIej08iVl8u8tvjN
	KZQkR3+ziugjOlAP0l7uscY6pvPoTuZo5avXHi0o369qnR4WJ8nnM3ZUZR89nv0CyzHmjeCRIn7WF
	b+FE0S2rZOg6bPNfXy8KkVf6r/2sgI+9Bq/HSJehzllBzl98ajEW4PYmSdBT8nWfh/klBKQ9JAE2j
	dy/82LBu6rBhlvmpL5sia99RW+D29G7gt1ftqDCOKsOHMsadPu8tUp6aB5qoi3oaZe5Zuxzn6S3+/
	WjoQaA0VsluwrnNdsqzhnb6BFB/Cm1r/TJypc1UoZ65DS8vWxLSxpUXxssmbd2vcIYbos4d7vZcR0
	X1QlwMiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO82d-00000001FXl-23yU;
	Tue, 03 Nov 2026 06:30:43 +0000
Received: from mail-dy1-x1331.google.com ([2607:f8b0:4864:20::1331])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO82b-00000001FX6-1Ond
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 06:30:42 +0000
Received: by mail-dy1-x1331.google.com with SMTP id 5a478bee46e88-36c9a93a1abso41880eec.1
        for <linux-nvme@lists.infradead.org>; Mon, 02 Nov 2026 22:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793687440; x=1794292240; darn=lists.infradead.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1e5yiaXntYJQtqK8uc9nIplampCx3pEWFOJaZHKAJjI=;
        b=QCNPXpN08k3Pcd2Nooy7IJXthn5jxMrcwZhWYeoo0pnSzr4M6venebU+cSkTyzuMLu
         bsEsHFrMhL8ygC8LRtpI8/JdfLKmcAWyEQ588eM/u5hJhnq03y/tubSeJcq9yd+NHxJf
         eVi6okC+CPoO3D8LWehLvT95zASX6vpbsL+ePHLbWpJcQi8N+Zpw9weRXA9+Y/NSgRmm
         E0marWQpYxd9oH81VgD6cXUu7+kcYkkRM7el/aCSNCyGr0M3cdKe4psy8Oa9brq0uZCn
         r+8/Yh76lPYkcEk3/3qe9HOagswINDgkEqTz8g+CITmXm/Xdf2X2pcSZHaHH7AKTyXi0
         xf3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793687440; x=1794292240;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1e5yiaXntYJQtqK8uc9nIplampCx3pEWFOJaZHKAJjI=;
        b=zpXhsgjOiieCYjhJuAIxZ6+x4Src2D/MlIR0dFzRTRgU7Uutu4DNwjnQXyP8IxqmIU
         hFTjbCYS+cR/NP7akw8tMSJ/WHldOQUgkpvEFVM9FT7ceJd1A+OXIRfqEMy1V1WuZEmh
         e1QG2lIKCvG3XrZOihOPLplL2rkOzEsNJ2AIZLcfXJajmhpy6pciNh7QORpiGLdbj8N+
         y5FtMWIkWvtvxwWMUDdWXXRnTdfmOYIOhYV4P/aayYq/9GksyrBn4g4aEg1iCWQVJWHK
         uDFOGanR4Wa9YxLHX4HCLQ//8kQDuzDUsjOhrRzpgY8d1ekl487o6ZO1eJQJoErg6cUl
         x2Zw==
X-Gm-Message-State: APuU4Z/pCf18281fQPWNq+j/dopURzU/Nt7s0Rn/LQeCDVqNBLYB3Ckk
	mo5DAhM9+IzkQwIiqJGzhFJAJbOhodCaEzSj3AjvUabiPVIyhtVNxA2B
X-Gm-Gg: AYBFou28Mk38d9v1LznzKn2W9ZMNP8GBH5yYxjG/3le2SBjytXfek8FDyM3/q3uPP72
	rErngAsf41s/s0Ijct86LUdItsdRusBUeNw2aba5yOdc5Ewq2NeJbWy6sHNQMUddz8k/alSaEO9
	nkAJn2ECrcLwUEJM1b7aeUh9UqGP6fYidlDyZ1I8VMPQDewrfGFwwHhA89v0RQdBS8AcZu8YDNT
	3ROBN0rFrPmlc11M1zIoydBiCxBZy4Uy3Fe2ZYeHrFQh2/2T/MRwaq1BZYrHcQ09Trq8CtZq0I4
	gjL0aOAj3gYJK0NPp8OPw2yqc1suxk6/FcBDupa1kCb4QsDLdacqOfLxQ/0+IwlDc8GaZbgK+oQ
	1P2Qz/AvsmMBZHxhZJ3YkKX1x365DvjrqGGTRMJcUg+3fd2EZc8V8I941qpymHkqg2cnqE2e1eo
	hgUzJ03A0/LS6HrBAEOpYsFn2yvh/y8KZkrtxeSQ9sRdFtqF3yYTbkToFTuWLtmwtB0Cnz7T18u
	t7cqEwyb6xPjIHg30kFptSa6wRakx7564M6fumBHgV1sQm4vKnsQ6KFmNgcodelUMg2smJrKeX5
	KZhIHiVSFzEz+SLL0Uo7bpZTIxuMMjYP1NaOcf46U4Z67JA=
X-Received: by 2002:a05:7300:3b05:b0:369:fe82:8d3f with SMTP id 5a478bee46e88-36a3002ef31mr30681503eec.14.1793687440182;
        Mon, 02 Nov 2026 22:30:40 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a429000f8sm44608720eec.13.2026.11.02.22.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 22:30:39 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Tue, 03 Nov 2026 01:30:35 -0500
Subject: [PATCH] nvme: wait for SRCU readers before splicing the namespace
 list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-bug-nvme-remove-ns-srcu-v1-1-e239087d63ac@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIp/6WoC/x3MPQqAMAxA4atIZgO24u9VxKHVqBmskmARxLtbH
 L/hvQeUhEmhzx4Qiqx8hASTZzBtLqyEPCeDLWxtTGHRXyuGuBMK7UckDIoq04VdObeuqVznjYd
 Un0IL3/95GN/3A5ZD3BNpAAAA
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_223041_378438_6DEE1008 
X-CRM114-Status: GOOD (  16.11  )
X-Spam-Score: -2.1 (--)
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Readers walk ctrl->namespaces under ctrl->srcu, and some of them sleep
there, e.g. nvme_wait_freeze() waiting for I/O to drain.

nvme_remove_namespaces() moves the list onto its on-stack ns_list with
list_splice_init_rcu(), which only waits for RCU readers before
relinking the entries. A reader still on the last namespace then follows
its next pointer to ns_list instead of ctrl->namespaces and treats the
stack as a namespace. Deleting a controller while a Format NVM
passthrough waits for a delayed read on the last namespace gives:

  BUG: KASAN: stack-out-of-bounds in nvme_wait_freeze+0x102/0x120
  Read of size 8 at addr ff110001d2f3fc38 by task nvme/4413
  Call Trace:
   nvme_wait_freeze
   nvme_passthru_start
   nvme_submit_user_cmd
   nvme_user_cmd
   nvme_dev_ioctl
  BUG: unable to handle page fault for address: ffffffff8af04850

Open-code the splice and wait for SRCU readers instead. This also takes
the RCU grace period out of every controller deletion:

  64 tcp controllers, 1 namespace each   before        after
  nvme disconnect-all (ms)               3543 / 3474   3221 / 3146
  nvme_remove_namespaces() avg (ms)      39.6 / 38.9   34.4 / 33.7

Fixes: be647e2c76b2 ("nvme: use srcu for iterating namespace list")
Cc: stable@vger.kernel.org
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 drivers/nvme/host/core.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a7a4d09644c13..8f032b3edde9a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4754,10 +4754,25 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	/* this is a no-op when called from the controller reset handler */
 	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
 
+	/*
+	 * Readers walk the list under ctrl->srcu, so hide the namespaces from
+	 * new readers and wait for the current ones before moving them over.
+	 * list_splice_init_rcu() can't be used as it only waits for RCU
+	 * readers.
+	 */
 	mutex_lock(&ctrl->namespaces_lock);
-	list_splice_init_rcu(&ctrl->namespaces, &ns_list, synchronize_rcu);
+	if (!list_empty(&ctrl->namespaces)) {
+		struct list_head *first = ctrl->namespaces.next;
+		struct list_head *last = ctrl->namespaces.prev;
+
+		INIT_LIST_HEAD_RCU(&ctrl->namespaces);
+		synchronize_srcu(&ctrl->srcu);
+		ns_list.next = first;
+		ns_list.prev = last;
+		first->prev = &ns_list;
+		last->next = &ns_list;
+	}
 	mutex_unlock(&ctrl->namespaces_lock);
-	synchronize_srcu(&ctrl->srcu);
 
 	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261102-bug-nvme-remove-ns-srcu-93d8a75a9b1b

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>


