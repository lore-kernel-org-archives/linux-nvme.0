Return-Path: <SRS0=k+Rq=MI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18D1C07E95
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 06:11:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7615461026
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Jul 2021 06:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7615461026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=G69iq9LeaZPMzd6BuIxe3iLy+yn+SDfaqasUrEXJXdA=; b=0XhgMrwD1tez5G
	cx/aJh7e0DQ+9/JAcOuXb/pe72UlbDpl4z19D+Oqxo7mPpa2Cu/ojqczuSZTZ5z8zZCataZ+TH/nQ
	KAC1Ib8z7JUSdAn8cLQDsP/EBzgIaBXJh1aw1w3vwoX+b3Karxpw+MrszaP8EX1qW7G8j99XJYx3j
	JhOdH4JvdrntvohvDZR8tObEj/bQWEpHVed3m7z4FxhwRR1+lgGgiCtJJJufveXVitb3xGGkAUIAK
	vtInc0ZxLyaIfHMvvlp/cVt2cVKhO+D5cx6JkWleHdQs6/SdIaQiLgCKUbUgMH7P1X64HRMqKEAjc
	YV1lvdbJs55OBz1UIBsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m4H3p-003Jf6-Dg; Fri, 16 Jul 2021 06:10:57 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m4H3m-003Jef-CM
 for linux-nvme@lists.infradead.org; Fri, 16 Jul 2021 06:10:56 +0000
Received: from dggeme719-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4GR12W076Wz7tYr;
 Fri, 16 Jul 2021 14:06:11 +0800 (CST)
Received: from huawei.com (10.169.46.19) by dggeme719-chm.china.huawei.com
 (10.1.199.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 16
 Jul 2021 14:10:41 +0800
From: Ruozhu Li <liruozhu@huawei.com>
To: <kbusch@kernel.org>, <linux-nvme@lists.infradead.org>
CC: <jiangtao62@huawei.com>
Subject: [PATCH nvme-cli] nvme: fix some memory leak bugs
Date: Fri, 16 Jul 2021 14:10:40 +0800
Message-ID: <20210716061040.21614-1-liruozhu@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.169.46.19]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggeme719-chm.china.huawei.com (10.1.199.115)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210715_231054_721058_09D991CA 
X-CRM114-Status: GOOD (  11.64  )
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

Signed-off-by: Ruozhu Li <liruozhu@huawei.com>
---
 nvme-print.c | 6 +++++-
 nvme-rpmb.c  | 5 ++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index 9444154..e808851 100755
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -2618,6 +2618,8 @@ void nvme_show_relatives(const char *name)
 			comma = true;
 		}
 		fprintf(stderr, "\n\n");
+		for (i = 0; i < n; i++)
+			free(paths[i]);
 		free(paths);
 	}
 	free(path);
@@ -6382,8 +6384,10 @@ static void json_simple_ns(struct nvme_namespace *n, struct json_object *devices
 		return;
 
 	ret = stat(devnode, &st);
-	if (ret < 0)
+	if (ret < 0) {
+		free(devnode);
 		return;
+	}
 
 	device_attrs = json_create_object();
 	json_object_add_value_int(device_attrs, "NameSpace", n->nsid);
diff --git a/nvme-rpmb.c b/nvme-rpmb.c
index 0e11ef3..7dc0b58 100644
--- a/nvme-rpmb.c
+++ b/nvme-rpmb.c
@@ -278,7 +278,10 @@ static void rpmb_nonce_init(struct rpmb_data_frame_t *req)
 {
 	int num = rand();
 	unsigned char *hash = rpmb_md5((unsigned char *)&num, sizeof(num));
-	if (hash) memcpy(req->nonce, hash, sizeof(req->nonce));
+	if (hash) {
+		memcpy(req->nonce, hash, sizeof(req->nonce));
+		free(hash);
+	}
 }
 
 /* Read key from a given key buffer or key file */
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
