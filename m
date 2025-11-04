Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8862FCCFA08
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 11:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=36j1MV0BBUKjnBRL8wiWamNCoEnZNdmYYjMeE2B5BRo=; b=BRFQN1Wc+Qj4KRXLtNLfrLfB5j
	6SA9B9kbKI6ysTjyYgZwVdJhqTymDzg3J58fMQbhcL5iSwwhW1fVoBprgDzs69tOX0VOghGniuC61
	a7JTzPXmy5ykx4Ektjc8vw3YtPk1v39AXnbeu9oeVnrZuvCOLfoFsYrySUlI8iC9Qv5vBaoYbrkqw
	5twqAvOHvquHLwz9H+eIgbdDOq/fMG7fj0j/P+1BT2c1jp0DgRwWGCEpKOjKRvSFW3QJrK1olnMki
	PLujtmzdhDdpbxWXmzk1iKA4hZN9r44GZLbDZ4GwowUgbwhYs/QNyNLQXCPz2DkVcYhNc7r3yy5le
	tcCGGzHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGFAd-0000000BhuM-3znJ;
	Tue, 04 Nov 2025 11:25:51 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGFAb-0000000Bhro-20Do
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 11:25:51 +0000
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-640d0ec9651so2598485a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 04 Nov 2025 03:25:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762255548; x=1762860348; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=36j1MV0BBUKjnBRL8wiWamNCoEnZNdmYYjMeE2B5BRo=;
        b=JtXBUx/2PWgxcBQsS9jtOY+m6JXLWVP9zmrQjGeGca32I6b5/JmNAGDzMnVXa+LG3m
         fDkKbEWKl/ouauXmXcVxZ7zMNPDNpuGDi8/Fr1PiNUC5FeY5UTHiRTFdHzIPU6mKfGjS
         nJ+FT7gy4+uaCU5jAcvLnpgpFPawbxxRZxAxMJwPaxJCNLHF6b+jaExJXp05/6X42HWk
         zcqH9A5hKzOA/8zM+efXI8we8wN3UeR82m5tDyyjK/+VogGcg5y40TkE3VdNgXmyc4k6
         FevPZRcG9VdfXNcyliw8h7ehad/hLzUFJgKmYju78t5VCTJR/znMxyk00uYWl2fA5l5y
         LXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255548; x=1762860348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36j1MV0BBUKjnBRL8wiWamNCoEnZNdmYYjMeE2B5BRo=;
        b=Ri/knejQjf+VmSZBNq2kCygcujo/UfbRMD7PefnTyJpA7lXxThiEXkvve5vpjZgjBr
         ANuDoMebc1Onr0WW5rdKFXwhb7H4Hfvum78W+v4keDqgjy0HezGN/apikxvWoQHj521A
         Q0enwxjwLig+c/hGlrh4zfYA/9FLFexTJnJBf1MRECuRcFQsuJR1OJyGtHMt1nVLd6RW
         EhO8+DhRjRV/H5zxMPferQfVgOQy02reNdOrjF5rIxmi4H0q8f58bS7zr3SjvWn3JHa6
         A2sYZ3sT6bM157KV/+TPCPdi7oq/TahYYU5agLoq7Q5QMPiQANGKcwDb244EDanGZVhp
         ursw==
X-Forwarded-Encrypted: i=1; AJvYcCXXgKXt/lVkSOUNNDyvIxAjBen0c9hPg1B/i/zcBG28Se2Fdv368x2dlJrqL0umlw14jrvxn61+kqcN@lists.infradead.org
X-Gm-Message-State: AOJu0YyXbdtnO39RNTHkpwONv+4nCz5xOMg8Es9gPTb768bXJN3qNQyw
	86MBoWst/bhYvXZP2ucLpxhiI6Q9V8oYmVyPU1c9RioC6+NbdPPtEFqL5I/evR5gnX8=
X-Gm-Gg: ASbGnct1xsJJ62T7/pOAN6J1IeAMHo545ZmBg80YBQ0HgTrmIs43rUtDwKo9TBOtSIH
	pPutCkSge6aU5VBV7BAel8bXuTsf16gz3yk7N/6hocKmwz5qerDg1Z/5jf3s/zEgGP4KDkn5Qaj
	RC9dLM4GB7rv2hDVBPiBCOVBBV6lfVolM+xbQrDSLWtNauVeAvqQuAG72pxFbA0R7e5e41C1HHS
	KUg8G9dKdguB/N1nN5s/bXjdRhYs9JRysmFAp7AQhQ+cPVovD3ZrKX89Kxxh0iS5t1XnuDTfmOD
	vW5gCc5+mQrIFkMDQ/rUsDH43Et9HqFnwgZK5FHTQyZvcNZT4dfLxEwZ9QFNoa4IM8+uiKsdJWP
	t0p3Yu27q5TZottFiktIokoajkf9AO5ploC2SroHX/66cxj4tgpAnW811m744k5P9TKBtav0SWS
	UKlMw=
X-Google-Smtp-Source: AGHT+IGIauAMQQkqNOIjJqL/lfAch5QIY2pQHmm2/rqf5NN0Qlk/r1xJiw1HdsIBefQeKTnDF/XtWg==
X-Received: by 2002:a17:907:97cd:b0:b70:b7f8:868f with SMTP id a640c23a62f3a-b70b7f88d2bmr789376866b.27.1762255547591;
        Tue, 04 Nov 2025 03:25:47 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f33aesm184101266b.19.2025.11.04.03.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:25:47 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>
Subject: [PATCH 3/3] nvmet-fc: add WQ_PERCPU to alloc_workqueue users
Date: Tue,  4 Nov 2025 12:25:28 +0100
Message-ID: <20251104112535.139450-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104112535.139450-1-marco.crivellari@suse.com>
References: <20251104112535.139450-1-marco.crivellari@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_032549_541956_1C91533C 
X-CRM114-Status: GOOD (  17.51  )
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

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This change adds a new WQ_PERCPU flag to explicitly request alloc_workqueue()
to be per-cpu when WQ_UNBOUND has not been specified.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Cc: Justin Tee <justin.tee@broadcom.com>
Cc: Naresh Gottumukkala <nareshgottumukkala83@gmail.com>
CC: Paul Ely <paul.ely@broadcom.com>
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/nvme/target/fc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 7d84527d5a43..ac730f2e6ea1 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -795,9 +795,9 @@ nvmet_fc_alloc_target_queue(struct nvmet_fc_tgt_assoc *assoc,
 	if (!queue)
 		return NULL;
 
-	queue->work_q = alloc_workqueue("ntfc%d.%d.%d", 0, 0,
-				assoc->tgtport->fc_target_port.port_num,
-				assoc->a_id, qid);
+	queue->work_q = alloc_workqueue("ntfc%d.%d.%d", WQ_PERCPU, 0,
+					assoc->tgtport->fc_target_port.port_num,
+					assoc->a_id, qid);
 	if (!queue->work_q)
 		goto out_free_queue;
 
-- 
2.51.1


