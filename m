Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBA0C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Nov 2022 06:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=V8X/zGisP47JLtF5sOO7yaOJ/x5byt28rgvphpM3Hj4=; b=OgHY9VFHnvC+gC4/8oWTKaO8ig
	wjCzRNftccFzKwDlnuhDq/7fjTbwYeRTPWkLmVFgaj43no18ume/iovnW0X8tgjDW5YMa59/eb/Rv
	0EuE730ax4btRflX9QK5nslbpqTdGkbuQeA1vcKAbzE+y80V1f8uM+MkTExfQ7dzjXYoW+Vzr3g5A
	jwfxYpbzeKZM3w6alejazcanyTB0KQEtTxHt5frBmGyFVap9ZYGDL8WtnwN8knXZke33UlBtTcPq7
	MTcZdfWHQmi8os1vVPDF9ZJvcWyXhPmgfToXBX0eF5TfoUdJ0NHVDEZbYzqK+kYWTlWRYBx3LYW7z
	SAD4GAPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox06T-009lTI-SS; Mon, 21 Nov 2022 06:16:25 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ox06N-009lRJ-KX
	for linux-nvme@lists.infradead.org; Mon, 21 Nov 2022 06:16:21 +0000
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NFxr25mDSzqSZk;
	Mon, 21 Nov 2022 14:12:18 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 21 Nov 2022 14:16:11 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 21 Nov
 2022 14:16:11 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <hare@suse.de>, <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>,
	<sagi@grimberg.me>
CC: <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme: fix memleak in nvme_ctrl_dhchap_secret_store()
Date: Mon, 21 Nov 2022 14:21:13 +0800
Message-ID: <20221121062113.84721-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221120_221619_887679_0D07FF85 
X-CRM114-Status: UNSURE (   9.80  )
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

If dhchap_secret is not consistent with options or
nvme_auth_generate_key() fails, we should free the
memory of dhchap_secret to avoid memleak.

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 drivers/nvme/host/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index da55ce45ac70..e06d1b3961fe 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3748,13 +3748,16 @@ static ssize_t nvme_ctrl_dhchap_secret_store(struct device *dev,
 		int ret;
 
 		ret = nvme_auth_generate_key(dhchap_secret, &ctrl->host_key);
-		if (ret)
+		if (ret) {
+			kfree(dhchap_secret);
 			return ret;
+		}
 		kfree(opts->dhchap_secret);
 		opts->dhchap_secret = dhchap_secret;
 		/* Key has changed; re-authentication with new key */
 		nvme_auth_reset(ctrl);
-	}
+	} else
+		kfree(dhchap_secret);
 	/* Start re-authentication */
 	dev_info(ctrl->device, "re-authenticating controller\n");
 	queue_work(nvme_wq, &ctrl->dhchap_auth_work);
-- 
2.25.1


