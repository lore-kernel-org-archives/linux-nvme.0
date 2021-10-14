Return-Path: <SRS0=o8oB=PC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92166C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 09:11:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37EC961029
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Oct 2021 09:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 37EC961029
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IJTjI3TR/GefsYiahPi2LnEi5+/mAwBdS6+/CJaPV5g=; b=IVB2OEKREOEvG/O2P5qkQrQeMs
	9JFnslN9FuFQ1FRuVWbcbbSP/YrA8PuGlbdJRmbl+6SMxdyoCADF6VQflckTX28YDRQWut6ti/wi/
	ewCUbcLRt/SbjgEdeomHp+/Q3v0RC5BMf4U8FbjVg6YuEmnTHvxrfcjRP0YRyyhBeYogT8mmhHrKF
	T1Elkvz8/YUaWZsmceuBhQuKjAhx61Ft/rUUflwwjCpceMkXjpdlCAQaGZ//iqG1cbS5PL+hkjsP7
	RrMfkcviAutCYKOIDQQtjBTxD1p1LlfTUUm7OUydE2GKRfbfYhhejDxSgcX1ihi+VL10nH5QABxGG
	+98Ds1vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mawm5-002JaG-BR; Thu, 14 Oct 2021 09:11:41 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mawm2-002JZY-5w
 for linux-nvme@lists.infradead.org; Thu, 14 Oct 2021 09:11:40 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HVNry2Js0z1DHb5;
 Thu, 14 Oct 2021 17:09:54 +0800 (CST)
Received: from dggpeml500006.china.huawei.com (7.185.36.76) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 17:11:31 +0800
Received: from huawei.com (10.169.63.14) by dggpeml500006.china.huawei.com
 (7.185.36.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Thu, 14 Oct
 2021 17:11:31 +0800
From: chengjike <chengjike.cheng@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>
CC: <sunao.sun@huawei.com>, <chengjike.cheng@huawei.com>,
 <jiangtao62@huawei.com>
Subject: [PATCH nvme-cli] huawei: filter out the partition disks
Date: Thu, 14 Oct 2021 17:11:30 +0800
Message-ID: <20211014091130.2083-1-chengjike.cheng@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.169.63.14]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500006.china.huawei.com (7.185.36.76)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211014_021138_420573_96F4F796 
X-CRM114-Status: UNSURE (   8.83  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When using "nvme huawei list" command, if the current disk has partitions,
disk partitions will be displayed. This is not expected!
So filter out the disk partitions through disk name.

Signed-off-by: chengjike <chengjike.cheng@huawei.com>
---
 plugins/huawei/huawei-nvme.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/plugins/huawei/huawei-nvme.c b/plugins/huawei/huawei-nvme.c
index 679578f..96de335 100644
--- a/plugins/huawei/huawei-nvme.c
+++ b/plugins/huawei/huawei-nvme.c
@@ -296,6 +296,8 @@ static int huawei_list(int argc, char **argv, struct command *command,
 	unsigned int i, n, fd, ret;
 	unsigned int huawei_num = 0;
 	int fmt;
+	int ctrl, ns, part;
+
 	const char *desc = "Retrieve basic information for the given huawei device";
 	struct config {
 		char *output_format;
@@ -326,6 +328,8 @@ static int huawei_list(int argc, char **argv, struct command *command,
 	}
 
 	for (i = 0; i < n; i++) {
+		if (sscanf(devices[i]->d_name, "nvme%dn%dp%d", &ctrl, &ns, &part) == 3) 
+			continue;
 		snprintf(path, sizeof(path), "/dev/%s", devices[i]->d_name);
 		fd = open(path, O_RDONLY);
 		ret = huawei_get_nvme_info(fd, &list_items[huawei_num], path);
-- 
2.21.0.windows.1


