Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D916E98E10
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Feb 2026 10:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E5dIJCHJACyKpCloDw8lrv0tPy1wO0MLgo1QK3atIQ4=; b=ZXeExFIgfLCPb31kWp8Nxo3Tje
	fFDe1HrfJAVLZfHqC0SAo7Wwo4FdUhOBAffzAMPd8RQWEJFdFJgAvZ/ACosSDIxEVdwvnVdBcPwEc
	Gtj2xX9PA90p3K97fTkglkxtPitTz7R7ElqUHw0yokybT1L/NXm0esj6ScAhyOJU9PtYvizon3us5
	jUOteL4/InvfcVQzHJOlVE75GKG3K+TFkDM8i8z163IAbjlVJmTGjDfTb5uLAZS05twocUSRSRvrq
	LVm6/cS+VP5JJGNoZdYHR9KY7YZ8hu5icY8+W8cbF3sOW4q/TGCsifjKOCLoNTTjTL8dttm4BX1Xn
	zss2GOUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuT6T-0000000031C-3n7r;
	Mon, 23 Feb 2026 10:23:49 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuT6Q-000000002zI-2uqL
	for linux-nvme@lists.infradead.org;
	Mon, 23 Feb 2026 10:23:48 +0000
Received: by mail-wm1-x341.google.com with SMTP id 5b1f17b1804b1-483a2338616so25839665e9.0
        for <linux-nvme@lists.infradead.org>; Mon, 23 Feb 2026 02:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1771842225; x=1772447025; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5dIJCHJACyKpCloDw8lrv0tPy1wO0MLgo1QK3atIQ4=;
        b=KXIXjoPitb7if8H4c90KHldu4+PVBM7EZyXDmeTjl4tjOIkKfqhL2kNTt8lPAteOoJ
         oHyBoATo2T4lVGIqJ9o2levlkRUEKfrM/bIkJmllSG0tLpYztVV9Uswlx7IOz/DhUn6l
         VDgQ2N+VghnvOwuWqY8YOOfgMviFtas3yXhUnwawckojcndTLV3HcxfhlI0JUI5PBnLq
         fDrrsoTf2/pmvuMsVbx/YVZcTrI4B3Rd+fI+XN6pP0X8XL/sY2P/36bAG2o5Jqwp0pkH
         0/9c2tLDJBsSYAR9jpoQYHt40bA3Z1DZheCMWF4NtbCHoSwE7AN/NXgsqnpF7ScA0xPf
         1Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771842225; x=1772447025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E5dIJCHJACyKpCloDw8lrv0tPy1wO0MLgo1QK3atIQ4=;
        b=W3BaRuIJcVS1pZcW8r/agzVPmkJRorE1fBQ1gRp2ewGBq2Ho8XuNOGseHwciGGZwEo
         wAOLnT8hj0tBr9WVuLj/xZyHk63HP4MjfrZN8BrWmIMRcnDWdyc1F3/E34txwBZG+gRK
         gtxh4j4Y+Lmpo6vUikbUNiDcNtwRg/kvCKAyjfFcXIzs0iD1dxaLRE7Hx0FpWkeAWlOJ
         vSk3ZJasNG/723FvQ20+FUcWv7ZwyITX3QXHt9bZt6qeaTsIR8Pmr+iOvyVyDLyacjDa
         wJYqCFUp9k/eFLYtFHUZUZwH8dZUSLzmVzZqQrlJ66++Jx+C4JPvCI4yUbpIJu3JWnVV
         a6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUErwDGH9LxmXmG3uIOx8yUIqnnBxdQFzcU9DgG4LcMCVoOxN1nAh0if6MtAY4626byGbYe98uyPmXG@lists.infradead.org
X-Gm-Message-State: AOJu0YxlX05ltS8AIMLJ0ZtOGVY3NKfW83ntMz2fsf7k8vqeTyPR+WB7
	3u4rMQjwTLicb8VhXu/eMsFG0MLSmRcXA/y98c6XGlerMfc/JEO9oNfx1N561oCRgKg=
X-Gm-Gg: AZuq6aKkgRsOIfMtz1b4N2g09JLMQ6wIFGD+MD4jHww7WpLDNN9PSDgXaTV+I5pexxb
	/him0tt6S9Ipv0OidGAv+PcZTRn62kzbFuPG2GLUeNuagGInv6jGGSOFEpkpFQs56C7M07gKfvw
	zfnaJsT6HcIxXsz9f7KIbPmNqD6r5Q//4a84esscCHyATLj0rqgu4bXTWnci2toDFv7Vc4iML2/
	x6KnFIKLagkA1RYL3gZpEHy0nMS5wXg4CMICN/7n29QCCRB7MGOFYsSSmbRxf6fCIunUZHMal0T
	twCw5MFlf3l8abeiJRdLCIhRMZFBIx1NFsd5eFF4kKc82GfAcz4+ru+Kq2fDkTJpkJpsPm8Njuv
	W0ieVA7tiwm72DwKYnIcvSDIhYT5Fj4fPFb0sLfkml3iV3MbLhrUnhhyl8+EhGJOI/AqHxelaWS
	2DXJJAHWnRY/1OAsS6SdY3FPTruh883zYlF1z4yd7LLh98
X-Received: by 2002:a05:600c:548e:b0:47a:935f:61a0 with SMTP id 5b1f17b1804b1-483a95643b3mr138425425e9.0.1771842224813;
        Mon, 23 Feb 2026 02:23:44 -0800 (PST)
Received: from linux.fritz.box.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31bc0e3sm237342465e9.5.2026.02.23.02.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 02:23:44 -0800 (PST)
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
Subject: [PATCH v2 1/3] nvmet: replace use of system_wq with system_percpu_wq
Date: Mon, 23 Feb 2026 11:23:27 +0100
Message-ID: <20260223102336.108512-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260223102336.108512-1-marco.crivellari@suse.com>
References: <20260223102336.108512-1-marco.crivellari@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260223_022346_780068_B9AB6AF4 
X-CRM114-Status: GOOD (  13.64  )
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

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen, workqueue users must be converted to the better named
new workqueues with no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/nvme/target/admin-cmd.c        | 2 +-
 drivers/nvme/target/fabrics-cmd-auth.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 9de93f65d7d7..ed60e48ee82f 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1603,7 +1603,7 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
 
 	pr_debug("ctrl %d update keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
-	mod_delayed_work(system_wq, &ctrl->ka_work, ctrl->kato * HZ);
+	mod_delayed_work(system_percpu_wq, &ctrl->ka_work, ctrl->kato * HZ);
 out:
 	nvmet_req_complete(req, status);
 }
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 5946681cb0e3..e039650945b1 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -391,7 +391,7 @@ void nvmet_execute_auth_send(struct nvmet_req *req)
 	    req->sq->dhchap_step != NVME_AUTH_DHCHAP_MESSAGE_FAILURE2) {
 		unsigned long auth_expire_secs = ctrl->kato ? ctrl->kato : 120;
 
-		mod_delayed_work(system_wq, &req->sq->auth_expired_work,
+		mod_delayed_work(system_percpu_wq, &req->sq->auth_expired_work,
 				 auth_expire_secs * HZ);
 		goto complete;
 	}
-- 
2.52.0


