Return-Path: <SRS0=SY4p=CG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C959C433E6
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 19:02:11 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D764820776
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Aug 2020 19:02:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ft+b6ah5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="I5e40vNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D764820776
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=j2/Bc/fD8q4MKQh0LxjG/0ulVsWQy7ritHsopTQf/T0=; b=ft+b6ah5bycSgFOHv4IoGFPLo9
	PjzqSiKZm4i/qL26ENP8T4QJ3raljPHlD3JRnK5llMdY99VKnn9InzxAejhmgyv5ejmFDKbll4oyb
	t5zrMXORjXAsQmMB6FRj2ZYEjfDP1YSvxeTg5/Iu5rHsQLqEhHpR/6AohuSp7/Rm3kzJ4Dk5WA+D5
	uO1atREbis3XGczj/NJssduC1Jk4Re2hXIkue80DsM9ccDwnjR9rPezEz8eIXxtoZeBte0zLVGZ9M
	lkx/ZlmKQ5/e7Hm1VDTKhedA+5eeoVrOXNPV5U/XEUeP1YKTORDp6BGTzWV3OxYvV1R5ekWCA6M6E
	z5eURFwA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBjdT-0004zh-1f; Fri, 28 Aug 2020 19:02:03 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBjdQ-0004yi-C6
 for linux-nvme@lists.infradead.org; Fri, 28 Aug 2020 19:02:01 +0000
Received: by mail-pl1-x643.google.com with SMTP id k13so86944plk.13
 for <linux-nvme@lists.infradead.org>; Fri, 28 Aug 2020 12:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yH7AbDCZOyeny7rN/VjZO9Yhu01+Xgr5P/ecl4toviU=;
 b=I5e40vNgxxInd7oVEnNiEOXaN4MBf0sUWMHJwN6aITD8/aYworWN1SOHs84D68LRA9
 +aKva5rRxua1QgCiQSFm0KY0ZP4uuBDJXbg+RqXhWHOWOU6zSRtaBuiSXOW/tOdCdPOp
 mDb5sGJ1AvN8UkUum+q1xOmH+3yflGRzLA2+o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=yH7AbDCZOyeny7rN/VjZO9Yhu01+Xgr5P/ecl4toviU=;
 b=aYgmC/xEEmFyjhoXGquvEVpsblMc4tmV39ZYpshspG5Qk7Ynt5DFzKl/It0GwsEHbF
 RAtndaARY6cWQ+LGR7QexdgqlN1KK5DCyiG26ZpAX10QksOpE9gNuVFgBUvVJrAaxMc1
 ESCgjW9yg3Egd+lni5+i+2/wlLBGt5x5ysdPht3aCLm2Yl4TlPnb4fProE2LJGutiWSu
 aSRqNBRl217n4I0x9FbWEosEWpLCOxiN8xupA9CUqws90ghOWk8kFfr38D+798OABPEZ
 pPEk0mDF/TTet1K29tOA8Ofbf+D+7hQwH08djI6G3MYLF4nf8aiue1H7dy8t5ChH68kB
 Fj5g==
X-Gm-Message-State: AOAM5311zHy5W3qEs5SG23ECOhnT34MIYT07dgckQ971fiWllC1hr9XF
 iUybw0H3YZ2lbepZNcHNsE6Jkg56zAqbUTqyPjRKcQmmsRQ6urm2mwUxun2TMw1by6e7yZcXauM
 RMtIJ9CUySI1bLuywbpasy1dZryMtKa5Gb/hmE3me1GE4OvdjyHvnuK6iddQSfo0qgwff3DqDry
 qCAFXHP0HM
X-Google-Smtp-Source: ABdhPJysDFT7EZQkaW2FnIARtbZ9pX6dZuZQO3bkb7uPr5nNGAQbW9F6NOLDNRbUahudZJzIutCxbw==
X-Received: by 2002:a17:90a:bd8f:: with SMTP id
 z15mr388074pjr.58.1598641316636; 
 Fri, 28 Aug 2020 12:01:56 -0700 (PDT)
Received: from localhost.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id t10sm154393pfq.77.2020.08.28.12.01.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 12:01:55 -0700 (PDT)
From: James Smart <james.smart@broadcom.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: Revert: Fix controller creation races with teardown flow
Date: Fri, 28 Aug 2020 12:01:50 -0700
Message-Id: <20200828190150.34455-1-james.smart@broadcom.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200828_150200_662722_15E07E06 
X-CRM114-Status: GOOD (  19.42  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Israel Rukshin <israelr@mellanox.com>,
 James Smart <james.smart@broadcom.com>, stable@vger.kernel.org,
 Keith Busch <kbusch@kernel.org>, Max Gurtovoy <maxg@mellanox.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The indicated patch introduced a barrier in the sysfs_delete attribute
for the controller that rejects the request if the controller isn't
created. "Created" is defined as at least 1 call to nvme_start_ctrl().

This is problematic in error-injection testing.  If an error occurs on
the initial attempt to create an association and the controller enters
reconnect(s) attempts, the admin cannot delete the controller until
either there is a successful association created or ctrl_loss_tmo
times out.

Where this issue is particularly hurtful is when the "admin" is the
nvme-cli, it is performing a connection to a discovery controller, and
it is initiated via auto-connect scripts.  With the FC transport, if the
first connection attempt fails, the controller enters a normal reconnect
state but returns control to the cli thread that created the controller.
In this scenario, the cli attempts to read the discovery log via ioctl,
which fails, causing the cli to see it as an empty log and then proceeds
to delete the discovery controller. The delete is rejected and the
controller is left live. If the discovery controller reconnect then
succeeds, there is no action to delete it, and it sits live doing nothing.

Cc: <stable@vger.kernel.org> # v5.7+
Fixes: ce1518139e69 ("nvme: Fix controller creation races with teardown flow")
Signed-off-by: James Smart <james.smart@broadcom.com>
CC: Israel Rukshin <israelr@mellanox.com>
CC: Max Gurtovoy <maxg@mellanox.com>
CC: Christoph Hellwig <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
CC: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 5 -----
 drivers/nvme/host/nvme.h | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 05aa568a60af..86abce864aa9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3481,10 +3481,6 @@ static ssize_t nvme_sysfs_delete(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
-	/* Can't delete non-created controllers */
-	if (!ctrl->created)
-		return -EBUSY;
-
 	if (device_remove_file_self(dev, attr))
 		nvme_delete_ctrl_sync(ctrl);
 	return count;
@@ -4355,7 +4351,6 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 		nvme_queue_scan(ctrl);
 		nvme_start_queues(ctrl);
 	}
-	ctrl->created = true;
 }
 EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index c5c1bac797aa..45cf360fefbc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -300,7 +300,6 @@ struct nvme_ctrl {
 	struct nvme_command ka_cmd;
 	struct work_struct fw_act_work;
 	unsigned long events;
-	bool created;
 
 #ifdef CONFIG_NVME_MULTIPATH
 	/* asymmetric namespace access: */
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
