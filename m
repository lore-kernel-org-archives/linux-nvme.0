Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8991CCF9E3
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 11:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=stYzH45VwWUKNAgerNUBsncouNNyJb4yUgnMDG8eTks=; b=t6MetpDqvGhiq4mZd87k4YO+FF
	bEIfRi5bBw0PEPKWiALUO/A+/CyM8Dc1i9YnQrlKC2tKlss0VpppDFAVQLARg2E2o2Sf1Aw8CYnMj
	IjErLBZ5O03Wij2NNfdyyPTWtJi7zFfAdOfWEJRm7nStel2nxO64M7A2NAFhaq1oUbXWeu8zhzBzG
	OfxfoASoYT+fhyEky6G5Wyz4rajiJyLJ8BAVpFjpi9uSB+k19U41isJOQTLIgA8Y301abJtwCQfi2
	Spyd3YEsqzQJa8ybhBUVV6IsyUqKvZjLvKT6eL3wGFISPQA4weORTh2HlhAJP/cg/f1yklcEwRxT5
	eMftB8DQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGFAb-0000000BhsM-1H6E;
	Tue, 04 Nov 2025 11:25:49 +0000
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGFAZ-0000000Bhqc-049p
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 11:25:48 +0000
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-6406f3dcc66so9252837a12.3
        for <linux-nvme@lists.infradead.org>; Tue, 04 Nov 2025 03:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762255545; x=1762860345; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stYzH45VwWUKNAgerNUBsncouNNyJb4yUgnMDG8eTks=;
        b=fIHPdHwifgrThS9ha68cGF7uax5w87aLK+IvAX3deEoY5Pxfc79ZuTDnU3yVunii6H
         YD/bHrsihq7UKbIMjvjvt8LFYsNQIw1gsFrJ1xZk0PF0/uMfjcNDqNx1e65genhs1z1d
         INFELrk5/OcaYWTdHf7ac1zB2OgscnMJ1SIKBUsNI3+JvNcr6b7pQPuGS2/za8v5e7wM
         eBczrq7gxlrT9xOh6uSUDti4r3nT6Ybe79vOZ8YYL3ZwhYTUDEM7lJEBWLK+teUDCwGj
         14AbfOJ4ikDobp8XC1WK94N4eeDOZpAM6RU7kTqBYccAO21gBMdP3vv0a57RKk3FYvX+
         zCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762255545; x=1762860345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=stYzH45VwWUKNAgerNUBsncouNNyJb4yUgnMDG8eTks=;
        b=MhBTqO5kQvLH3DFOJTcM1NXUFMY5gYGIqC06ldjMqiChxFu34GmtQX3YxLmYLMb8sc
         A/X0iM6LntUhDQdyLAFBEFv//EQ6PSeVRN95W5s4znTwI/KAwsE3xxHU7/KFl4jzdPqh
         sTacnQnBdOvrYOWSdsySjC8jZLDvtpIGp5fDTKmT8mYcqxl1bS08BztF9aAWzuhVefhi
         3wHDSDwh8RJ9L7XFmD5oc+e+sbGojO2LsJXl04InoZNhdYS7rorkuczzTzDmXdVBg7An
         0f7KvmmNZDDzrYf+qmbCL/9yKkouq7plcOfN2PCqslCn26qFUPo8NMCzr4phqAhy8H5D
         G+bA==
X-Forwarded-Encrypted: i=1; AJvYcCU9CIzz46xzEmKWAWRUKljUjWiEOax5LRKrEZ1wYMbyCqBsy7gz3gnM892nZpAW2o4nIwZLm97JRCmC@lists.infradead.org
X-Gm-Message-State: AOJu0Yy/lbX6w59mp4MG/Hzkd41Q8c0NdpvhU26T9Yz0X55AbgW9ULYc
	JjA8v1l5zgFGJZf0b8XyI3sEl+et5dzuOAXH8O9x2Ao4uiipZSqnVydGDO81Y0YLtU8=
X-Gm-Gg: ASbGnctoAVNV3XicXB6WmqgNDknbMII+Qp6qY9dhLClTZDan8EH4Wl6eW94rDL5VluS
	Bz3BQMbCMVNibypyaE3bUGJyu9QmOk/j418AhJ95aMjnFq9zoBF/ucdzGwZ1Hbqn3BZNqeaT/Bz
	BgEIW13TTcWzDVZ1wja4dvITyrWDsRu06HlYDJxTZhmtrr1P7CWLrSN2J4ZKe2XVTG5dP7/Tva9
	LTsG5anMzTmd5YGfTAqp6ASVNxt6MjVCwqGb+vmj6T/HhsyaazehH5J91VHE47NYsVBJQS4YXlx
	QNb4xpsR8pyiHB6eDpbiT5dSZJrYJroRS+nI57P5lyzjyZEIjyHY8DJpNsVuLJqM7L1G8XoM+l6
	JQcOIrn/Ytd/O7QhMQn45oAqORexecWp+YRHxxXaQGLIrB7JVXz5YTDxsQchJA+ER9C94UjsjSb
	37eiM=
X-Google-Smtp-Source: AGHT+IE6JQ2SIkOePpolRdtpQwBCWa1MbJb7n/XyJv+jCBR3fHY/bgWDSuf1lU4NTorSPgPC4CHpEw==
X-Received: by 2002:a17:907:1c17:b0:b50:a067:2d85 with SMTP id a640c23a62f3a-b7070137f35mr1576695566b.15.1762255545149;
        Tue, 04 Nov 2025 03:25:45 -0800 (PST)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723d6f33aesm184101266b.19.2025.11.04.03.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 03:25:44 -0800 (PST)
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
Subject: [PATCH 1/3] nvmet: replace use of system_wq with system_percpu_wq
Date: Tue,  4 Nov 2025 12:25:26 +0100
Message-ID: <20251104112535.139450-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251104112535.139450-1-marco.crivellari@suse.com>
References: <20251104112535.139450-1-marco.crivellari@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_032547_095904_AA405BB0 
X-CRM114-Status: GOOD (  14.88  )
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

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/nvme/target/admin-cmd.c        | 2 +-
 drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 3e378153a781..29281f410cc6 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1604,7 +1604,7 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
 
 	pr_debug("ctrl %d update keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
-	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
+	mod_delayed_work(system_percpu_wq, &ctrl->ka_work, ctrl->kato * HZ);
 out:
 	nvmet_req_complete(req, status);
 }
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index bf01ec414c55..8f504bf891de 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -390,7 +390,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
 		unsigned long auth_expire_secs = ctrl->kato ? ctrl->kato : 120;
 
-		mod_delayed_work(system_wq, &req->sq->auth_expired_work,
+		mod_delayed_work(system_percpu_wq, &req->sq->auth_expired_work,
 				 auth_expire_secs * HZ);
 		goto complete;
 	}
-- 
2.51.1


