Return-Path: <SRS0=Os7y=ZX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5317CC432C0
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Dec 2019 08:14:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1985520725
	for <linux-nvme@archiver.kernel.org>; Sun,  1 Dec 2019 08:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N9fGle32"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1985520725
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kioxia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Uu2OJL5S9b9shLFYAnEfViXp1gKn4ZnO+8qQI8HSPB8=; b=N9fGle32X1tek0
	qllMFpdBqrPphmP9HhYa3cGO7/Y3L3Efd/Khk2y7dVQ4JJSO6zuGlOtM7O9LguC0Oyt7aDg5ubPyp
	yVUJEzWZirs1LNaYL9gkMXfuedDZGjJcUJ8q00f0OeAfpJG4RIaYSY6XlyTPLc2sRLpRPseztW/0R
	qF/uYEAsGrz+5Xk5iJoKmPv2vxhMqXjYRofSLrB60vDx483Fa6nZKvzZBSU9E+Bl3jm8oiFPIKrEH
	tiM6+PUENDDP5nDu+O1hO01118G9IIGgi8PmN5/SCMvt6kpikVOYAK1KUlsDKBH/T31JQIsr7Eb/W
	Hd7AEZklh1U0F4ey4fLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibKNW-0000vC-4b; Sun, 01 Dec 2019 08:14:50 +0000
Received: from ip-12-0-68-226-us.kioxia.com ([12.0.68.226]
 helo=SJSMAIL01.us.kioxia.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibKNS-0000uv-R4
 for linux-nvme@lists.infradead.org; Sun, 01 Dec 2019 08:14:48 +0000
Received: from SJSMAIL01.us.kioxia.com (10.90.133.90) by
 SJSMAIL01.us.kioxia.com (10.90.133.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Sat, 30 Nov 2019 23:59:35 -0800
Received: from SJSMAIL01.us.kioxia.com ([fe80::8056:cf5f:fb1f:e123]) by
 SJSMAIL01.us.kioxia.com ([fe80::8056:cf5f:fb1f:e123%3]) with mapi id
 15.01.1779.004; Sat, 30 Nov 2019 23:59:35 -0800
From: Victor Gladkov <Victor.Gladkov@kioxia.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme-fabrics: reject I/O to offline device
Thread-Topic: [PATCH] nvme-fabrics: reject I/O to offline device
Thread-Index: AdWoHEM2hZCp1trGT5CqiIXVszcBJg==
Date: Sun, 1 Dec 2019 07:59:35 +0000
Message-ID: <2caa40133c444771b706406b928ad88a@kioxia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.93.66.127]
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191201_001446_874718_4281529F 
X-CRM114-Status: UNSURE (   6.37  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Issue Description:
Commands get stuck while Host NVMe controller (TCP or RDMA) is in reconnect state. 
NVMe controller enters into reconnect state when it loses connection with the target. It tries to reconnect every 10 seconds (default) until successful reconnection or until reconnect time-out is reached. The default reconnect time out is 10 minutes.
This behavior is different than ISCSI where Commands during reconnect state returns with the following error: "rejecting I/O to offline device"

Fix Description:
Added a kernel module parameter "nvmef_reconnect_failfast" for nvme-fabrics module (default is true).
Interfere in the decision whether to queue IO command or retry IO command. The interface takes into account the controller reconnect state, in a way that during reconnect state, IO commands shall fail immediacy (default) or according to IO command timeout (depends on the module parameter value), and IO retry is prevented. As a result, commands do not get stuck in in reconnect state.

branch nvme-5.5

---
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 74b8818..ef89aff 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -13,6 +13,10 @@
 #include "nvme.h"
 #include "fabrics.h"

+static bool nvmef_reconnect_failfast = 1;
+module_param_named(nvmef_reconnect_failfast, nvmef_reconnect_failfast, bool, S_IRUGO);
+MODULE_PARM_DESC(nvmef_reconnect_failfast, "failfast flag for I/O when controler is reconnecting, else use I/O command timeout (default true).");
+
 static LIST_HEAD(nvmf_transports);
 static DECLARE_RWSEM(nvmf_transports_rwsem);

@@ -549,6 +553,7 @@ blk_status_t nvmf_fail_nonready_command(struct nvme_ctrl *ctrl,
 {
        if (ctrl->state != NVME_CTRL_DELETING &&
            ctrl->state != NVME_CTRL_DEAD &&
+           !(ctrl->state == NVME_CTRL_CONNECTING && (((ktime_get_ns() - rq->start_time_ns) > jiffies_to_nsecs(rq->timeout)) || nvmef_reconnect_failfast)) &&
            !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
                return BLK_STS_RESOURCE;


Regards,
Victor


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
