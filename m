Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F3EC4332F
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Nov 2022 04:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jKZAKo/Sogm21G3uoqrsq/AUW+bDQIg97U8vU0myIxM=; b=h0aKiQtv3NTIhJ0yMc0HZ94Wy1
	FH+XHjRX2pF5QdK95Pw/VbsiMtWi70hxG6g/1znRYu3G0ZjNeFxOoPqwsHRlbujHGJrC+Cfq+VhUd
	xl7JIvcrWs7/xuKuBIhnTZNf46Z/vQLL8FCZVYpHK6FMjFzm1Q8W9cvDn8QrINFbKqVzDCmiH2n60
	hcxFfKqrxu+2vLET2L+xF++abPw91yft/5JtgWMgMtTqrIzGAsQqEN7BMTw0cjZn1qr4pqPlMrX/N
	3PFnrbTCk3D9g8CtyANcXZ46W69NP34T9zuFuqWI14rk1cJRkfbvvb40DaRc8eLd7q2Kfuxe9lMf/
	zhhd3hLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxL99-003qTj-Vv; Tue, 22 Nov 2022 04:44:36 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oxL96-003qR0-0T
	for linux-nvme@lists.infradead.org; Tue, 22 Nov 2022 04:44:34 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NGWlh4gJHzqSYG;
	Tue, 22 Nov 2022 12:40:32 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 12:44:26 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 22 Nov
 2022 12:44:26 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <sagi@grimberg.me>, <hare@suse.de>, <kbusch@kernel.org>, <hch@lst.de>,
	<axboe@fb.com>
CC: <linux-nvme@lists.infradead.org>
Subject: [PATCH v2] nvme: fix memleak in nvme_ctrl_dhchap_secret_store()
Date: Tue, 22 Nov 2022 12:49:29 +0800
Message-ID: <20221122044929.27600-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221121_204432_245083_F3CC4FD4 
X-CRM114-Status: GOOD (  11.55  )
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

If dhchap_secret is not consistent with options or
nvme_auth_generate_key() fails, we should free the
memory of dhchap_secret to avoid memleak.

We fix it by changing the check strcmp to strncmp
directly against buf and moving allocating inside
to the clause.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
v2:
- changing checking function and allocating location.
---
 drivers/nvme/host/core.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index da55ce45ac70..bfec2a63d0d8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3730,7 +3730,6 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 {
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	struct nvmf_ctrl_options *opts = ctrl->opts;
-	char *dhchap_secret;
 
 	if (!ctrl->opts->dhchap_secret)
 		return -EINVAL;
@@ -3739,17 +3738,19 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 	if (memcmp(buf, "DHHC-1:", 7))
 		return -EINVAL;
 
-	dhchap_secret = kzalloc(count + 1, GFP_KERNEL);
-	if (!dhchap_secret)
-		return -ENOMEM;
-	memcpy(dhchap_secret, buf, count);
 	nvme_auth_stop(ctrl);
-	if (strcmp(dhchap_secret, opts->dhchap_secret)) {
+	if (strncmp(buf, opts->dhchap_secret, count)) {
 		int ret;
+		char *dhchap_secret;
 
+		dhchap_secret = kmemdup(buf);
+		if (!dhchap_secret)
+			return -ENOMEM;
 		ret = nvme_auth_generate_key(dhchap_secret, &ctrl->host_key);
-		if (ret)
+		if (ret) {
+			kfree(dhchap_secret);
 			return ret;
+		}
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
 		/* Key has changed; re-authentication with new key */
-- 
2.25.1


