Return-Path: <SRS0=1aKD=O4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A9AEC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Oct 2021 12:26:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05AE060F44
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Oct 2021 12:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 05AE060F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DGbIp7PPH/bZxPdc8x1lFamMhB3WQy/LvKgfRtgbihQ=; b=ukoNTGgMjLFVYQ
	og/inmi+d3cNFRx8xNUw++EeVlY+tetwkTRTMN63QyIcEhd8DIMoSLpJZvdqo/qy3hPmJMoxlVJ3M
	jDevrtJoXzxUw6LoCCLvNWXUhBEycgt4f7X7vo1OgV+fZlugYBtt+7DYDxpcEfV1STAYGFDAiU0KQ
	fzhTgWeVo8dNU8reo8oRec5xlNiEyjUY+p7KDBuk3LYCeGk1ne9X0HOslhFwAHFkGcveP0tpOmUY2
	OW7OtoM8S88mNf5QhDg7UuNVKliJ9S3CZBrTFJhfe2cE8D0FVfAhwio8LvaXOrC26DRAcEmTSiU8U
	8+Y3MAbFeIsmgLvAOQNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mYoxk-002hLq-73; Fri, 08 Oct 2021 12:26:56 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mYowo-002gvR-FJ
 for linux-nvme@lists.infradead.org; Fri, 08 Oct 2021 12:26:01 +0000
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HQnS82sB9zWgrY;
 Fri,  8 Oct 2021 20:24:24 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 20:25:55 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 8 Oct 2021
 20:25:54 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, 
 <chaitanyak@nvidia.com>
CC: <sunao.sun@huawei.com>, <jiangtao62@huawei.com>
Subject: [PATCH V4 nvme-cli 1/3] display faulty disk in "nvme list" command
Date: Fri, 8 Oct 2021 20:25:51 +0800
Message-ID: <20211008122553.1779-2-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20211008122553.1779-1-chengjike.cheng@huawei.com>
References: <20211008122553.1779-1-chengjike.cheng@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211008_052558_739259_FCAD4B20 
X-CRM114-Status: GOOD (  11.80  )
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

When NVMe Subsystem is connected with one or more controllers via fabric, such as NVMe-oF over RDMA,
if the link is faulty, some nvme disks on the host are unavailable and they won't be deleted immediately.
These disk should be displayed for users. So value of nsid set to be -1, and all the size info is zero,
which indicates that the namespace is "faulty" when run "nvme list" command.

Signed-off-by: chengjike <chengjike.cheng@huawei.com>
---
 src/nvme/tree.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/src/nvme/tree.c b/src/nvme/tree.c
index 2c5837a..07a687a 100644
--- a/src/nvme/tree.c
+++ b/src/nvme/tree.c
@@ -237,7 +237,8 @@ nvme_ns_t nvme_subsystem_next_ns(nvme_subsystem_t s, nvme_ns_t n)
 static void __nvme_free_ns(struct nvme_ns *n)
 {
 	list_del_init(&n->entry);
-	close(n->fd);
+	if (n->fd > 0)
+		close(n->fd);
 	free(n->name);
 	free(n->sysfs_dir);
 	free(n);
@@ -1053,9 +1054,6 @@ static int nvme_configure_ctrl(nvme_ctrl_t c, const char *path,
 	closedir(d);
 
 	c->fd = nvme_open(name);
-	if (c->fd < 0)
-		return c->fd;
-
 	c->name = strdup(name);
 	c->sysfs_dir = (char *)path;
 	c->firmware = nvme_get_ctrl_attr(c, "firmware_rev");
@@ -1552,27 +1550,23 @@ static nvme_ns_t nvme_ns_open(const char *name)
 	}
 
 	n->name = strdup(name);
+	n->nsid = -1;
 	n->fd = nvme_open(n->name);
+
 	if (n->fd < 0)
-		goto free_ns;
+		goto out;
 
-	if (nvme_get_nsid(n->fd, &n->nsid) < 0)
-		goto close_fd;
+	if (nvme_get_nsid(n->fd, &n->nsid) < 0) {
+		n->nsid = -1;
+		goto out;
+	}
 
 	if (nvme_ns_init(n) != 0)
-		goto close_fd;
-
+		n->nsid = -1;
+out:
 	list_head_init(&n->paths);
 	list_node_init(&n->entry);
-
 	return n;
-
-close_fd:
-	close(n->fd);
-free_ns:
-	free(n->name);
-	free(n);
-	return NULL;
 }
 
 static struct nvme_ns *__nvme_scan_namespace(const char *sysfs_dir, const char *name)
-- 
2.21.0.windows.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
