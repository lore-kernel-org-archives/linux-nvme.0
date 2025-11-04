Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF54CCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 11:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6Hz/eXxLAJrsYCSjgGA9t2bRyGKcFTsC49+GNbs5K18=; b=yYDIIC1tUClO5vsRuqVo9C/TDO
	Nz6DtBEpfSwiPx8QnOgckMMCaZ9pBYfKZp9zJ6F9IIitoVkBvGbvplf9jb81FsKwaRBEs+1RpdqPC
	5m5cIx6xr+6j5OdG8qlWl69r53zxTE3QNpADvKeKGvWiYXeKGVzOamyrbh4SC9pMCn5cz35r+Rzip
	NdECGDOqrxaXhlqn18EgkQ8P5wMAY2re6s6jmVYYCEbO/lYsXRsTKXutV12ZmFNcU4b4UjICCxZU5
	iYtFDzfxfCjqctYNkWbxhQ2LY8WuMs5xsE2dnUZDq6xCQdA2julFGX5ChJgX3Ac1vAscvCwXcXRI6
	zqpieaYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGFAc-0000000BhtJ-2Xpt;
	Tue, 04 Nov 2025 11:25:50 +0000
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGFAa-0000000BhrP-1N7F
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 11:25:49 +0000
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-b3d196b7eeeso989789966b.0
        for <linux-nvme@lists.infradead.org>; Tue, 04 Nov 2025 03:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762255546; x=1762860346; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Hz/eXxLAJrsYCSjgGA9t2bRyGKcFTsC49+GNbs5K18=;
        b=NZrsazBiTeEVz0b82PP6cizscPN1OK32nDGicr+kgkv37ZHpK3R33pOj8R29VHN7og
         SE17kmtWIoi5shOhygRcUALcTdzqFMm1jl5li0dvw0N2x/MtM64nQrsYkTecPV2haGso
         OINld2w5UqcU8cDpknRYdYTvK3iGNdASjSf8LqPyftBnuY/Yj0dm0ZAV/1hRfd+1gk9+
         bBFqoufXKFOp+pDnncWs5NMd62WMdlneUT/hjXevhP/R1QhoGmDDAwaiAGLPp5JfOpuy
         zfGnR2XHFgqoU7+LIGfuDuTQ8zHKSBgeay0gYN64Mr3tebOlyoY0kYgfCeB/2IFw8WlO
         aw+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255546; x=1762860346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Hz/eXxLAJrsYCSjgGA9t2bRyGKcFTsC49+GNbs5K18=;
        b=omT/wemhkOI4vdGFYAUgiGJkeWJsijlQiqr9C0UP40xgQdQR/OY+ewj+26GHCqgRMv
         rWgJGuSbiMGknDIJ9vOeuGw/nN2xPgPBdLSRy+TLSnOb1c2Juv5NSMDqPF/rsYhTUn/u
         vJ/kS34nYhynOszMsjbW1JkqdVGzXpqncy4titbFtfqk/37kAAsrEe8pH2KoC/qf7PES
         zHeIb+yMxtSi0NRiwGkKwPgDMbgj2Et0J2J9gFz32nqk3uhSwlcmED9i3xKFSb1Qx2XP
         oJBRZsL3QEp2u9hz65sLWBEPTxLPkaJv00Kh6gEhkPmM8NVAoZ1VcF2gUX7C6Vi9fyn4
         gE8w==
X-Forwarded-Encrypted: i=1; AJvYcCXVWXuafldkvBLt4Q5su4FxZ6218YRbW5G7QYSbCvFGIYuDF8vc+blJ9hFCmXusPy9QILHvj2/cTs/9@lists.infradead.org
X-Gm-Message-State: AOJu0YzHMYI6hUS0cbRdR1IMlNeA6zrFPtwvvTiN/VRpcXQo1FDY+ZBp
	+RcL24hJguhIfiVENMCHzFDgIjmvK98RC1cIiqhw7336eN6AYdjXsvA+Qf4/yw1gcao=
X-Gm-Gg: ASbGnct+HZWTEE8qnXWItspses0KaujxeXz+e3jVz3euVM01THQp2s5GR5IsA0vu6Zs
	BlzDTEdkYBgKUgBxq4rJkgf/L++NnUJcKzjwTzhXEBmuDBB9xom1njkNgGcrnQALzTLgI/VOFx3
	j7LbNC2BZuA+GYSpSW1l0h6B+qvwDq9y6FW8ZvupT3OafXXFDDOSz1i6xz9F2Gys1L0fBmZsnz6
	qn/YHAZax9GPXi51pCgnPJabdZ3LMsVbl6y4ohZltUByvR05CRYL7plLuCU2hJ7aqb5FBRZk+th
	z69tya7OJUPJoIwF5trxYtWtqd8feavMxGwlPBjSER4CrJ/cTzMFZr+ZsKPuKgQExA/es9Yw1hu
	ZOsZsnt4OWG3+VDtqysrdQlhnS63/cb0abPVux8WdKdPKQKb3RybMsKvJP7kg93UOyQ/UJLhlQC
	H/NmM=
X-Google-Smtp-Source: AGHT+IF1k470AEqd/HXmgoSWzg+3W3h3tiSB1rbfKQH9JA4864/MW5uhBMF5xc1yU7RXjnqRtZC1Dg==
X-Received: by 2002:a17:906:bcd5:b0:b72:52c2:b8e2 with SMTP id a640c23a62f3a-b7252c2baa2mr127511866b.26.1762255546396;
        Tue, 04 Nov 2025 03:25:46 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f33aesm184101266b.19.2025.11.04.03.25.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:25:45 -0800 (PST)
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
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/3] nvme: add WQ_PERCPU to alloc_workqueue users
Date: Tue,  4 Nov 2025 12:25:27 +0100
Message-ID: <20251104112535.139450-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104112535.139450-1-marco.crivellari@suse.com>
References: <20251104112535.139450-1-marco.crivellari@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_032548_387694_01BAB7C6 
X-CRM114-Status: GOOD (  18.47  )
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

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/nvme/target/core.c | 5 +++--
 drivers/nvme/target/tcp.c  | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5d7d483bfbe3..ae8e903b55ad 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1943,12 +1943,13 @@ static int __init nvmet_init(void)
 	if (!nvmet_bvec_cache)
 		return -ENOMEM;
 
-	zbd_wq = alloc_workqueue("nvmet-zbd-wq", WQ_MEM_RECLAIM, 0);
+	zbd_wq = alloc_workqueue("nvmet-zbd-wq", WQ_MEM_RECLAIM | WQ_PERCPU,
+				 0);
 	if (!zbd_wq)
 		goto out_destroy_bvec_cache;
 
 	buffered_io_wq = alloc_workqueue("nvmet-buffered-io-wq",
-			WQ_MEM_RECLAIM, 0);
+			WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!buffered_io_wq)
 		goto out_free_zbd_work_queue;
 
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 470bf37e5a63..fa7a56626bcc 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2198,7 +2198,7 @@ static int __init nvmet_tcp_init(void)
 	int ret;
 
 	nvmet_tcp_wq = alloc_workqueue("nvmet_tcp_wq",
-				WQ_MEM_RECLAIM | WQ_HIGHPRI, 0);
+				WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!nvmet_tcp_wq)
 		return -ENOMEM;
 
-- 
2.51.1


