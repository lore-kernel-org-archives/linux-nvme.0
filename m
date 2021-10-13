Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B60BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 13:26:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC89361040
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 13:26:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC89361040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pew/bRWxbxgXjNYQp7qIOdxFCgU5d3kO+2FcZ9SJRJU=; b=qkT/UJtUEPSBkD
	IBJe0mJISPqTSO3jEp2l7OOfciICePqVBPBsWoCSDhe2V+QYWZm9Pnu2RK4Lgy/DE3cco+LVlONyF
	Im3uYOlTKR+P/rSo8FHcYVoh5f2C3zFtXTw6GnFjXAulVAjQeRWICsc6g6bk23AE71+TrMDnP59Oe
	XyXSkQgTohhaq1i8AAtDV31DGlenyQP808VjuZN8gKtFJc8Ev7X4Ep0Ly27pnUJChGZzhUwXlDNCD
	HDmy9QzlXJ24Mv6SfF00bUNnEkSWSPZheERxvecjDqWH+H9coMZO0N/VzVPc+lKeIwZ/7wVOkuQkV
	Pq8iXwbkg7XpiUd/Lc1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maeGe-00Gspf-Vj; Wed, 13 Oct 2021 13:26:01 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1madvN-00Gkls-QM
 for linux-nvme@lists.infradead.org; Wed, 13 Oct 2021 13:04:05 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HTt3W1Xq8zWm33;
 Wed, 13 Oct 2021 21:02:15 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Wed, 13 Oct 2021 21:03:49 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 13 Oct
 2021 21:03:48 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>
CC: <sunao.sun@huawei.com>, <chengjike.cheng@huawei.com>,
 <jiangtao62@huawei.com>
Subject: [PATCH nvme-cli] delete unused header file
Date: Wed, 13 Oct 2021 21:03:48 +0800
Message-ID: <20211013130348.804-1-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211013_060402_147855_DE566839 
X-CRM114-Status: UNSURE (   7.01  )
X-CRM114-Notice: Please train this message.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The base functions have been convert to "libnvme" library, so delete unused header file "nvme-private.h".

Signed-off-by: chengjike <chengjike.cheng@huawei.com>
---
 nvme-private.h | 71 --------------------------------------------------
 1 file changed, 71 deletions(-)
 delete mode 100644 nvme-private.h

diff --git a/nvme-private.h b/nvme-private.h
deleted file mode 100644
index 1fd4eb2..0000000
--- a/nvme-private.h
+++ /dev/null
@@ -1,71 +0,0 @@
-#ifndef _NVME_PRIVATE_H
-#define _NVME_PRIVATE_H
-
-struct nvme_subsystem;
-struct nvme_ctrl;
-
-struct nvme_namespace {
-	char *name;
-	struct nvme_ctrl *ctrl;
-
-	unsigned nsid;
-	struct nvme_id_ns ns;
-};
-
-struct nvme_ctrl {
-	char *name;
-	char *path;
-	struct nvme_subsystem *subsys;
-
-	char *address;
-	char *transport;
-	char *state;
-	char *ana_state;
-	char *traddr;
-	char *trsvcid;
-	char *host_traddr;
-	char *host_iface;
-	char *hostnqn;
-	char *hostid;
-
-	struct nvme_id_ctrl id;
-
-	int    nr_namespaces;
-	struct nvme_namespace *namespaces;
-};
-
-struct nvme_subsystem {
-	char *name;
-	char *subsysnqn;
-
-	int    nr_ctrls;
-	struct nvme_ctrl *ctrls;
-
-	int    nr_namespaces;
-	struct nvme_namespace *namespaces;
-};
-
-struct nvme_topology {
-	int    nr_subsystems;
-	struct nvme_subsystem *subsystems;
-};
-
-void *mmap_registers(const char *dev);
-
-int scan_ctrl_namespace_filter(const struct dirent *d);
-int scan_namespace_filter(const struct dirent *d);
-int scan_ctrl_paths_filter(const struct dirent *d);
-int scan_ctrls_filter(const struct dirent *d);
-int scan_subsys_filter(const struct dirent *d);
-int scan_dev_filter(const struct dirent *d);
-
-int scan_subsystems(struct nvme_topology *t, const char *subsysnqn,
-		    __u32 ns_instance, int nsid, char *dev_dir);
-void free_topology(struct nvme_topology *t);
-char *get_nvme_subsnqn(char *path);
-char *nvme_get_ctrl_attr(const char *path, const char *attr);
-
-int uuid_from_dmi(char *uuid);
-int uuid_from_systemd(char *uuid);
-
-#endif /* _NVME_PRIVATE_H */
-- 
2.24.0.windows.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
