Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF895C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Jul 2022 01:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lUkCsJ5DN3kftd3mr3A/6PytKKPn/UwfLSeE9B4oWms=; b=ZyXJont3t4XIpv
	zTaqcrXmg2Ctf2TPN6EAXJ2240Fj8+mpq+LyVxbUFBUkT4T/YBvXuFUsO+A3oRqUl8kJXJrpvUKLp
	AkTwSR4vwLowMUjR4Y/cQcZcqdRl9Yp1Qt6GhPMXUdPF9zfSzuCfgqwBBHth8HSdXW4giqlmWjLjA
	xQJAV6zgooK7fN2S9QEKOOarV0dt32gl9a7GD+0SMiegx/ZjX/8aN0yusgfr36J5Weom7EYEpJ8Zr
	+JKtQrSM+JvbIfNU2ttPdRnmY54gTzjKidaxfUNNrBb/smK3zAS/56y4bXMeBoLp/L5O2KVbbJ0L6
	W0tcm3Xqwcw9KUxw8Ysg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG9pl-006l9P-Hv; Tue, 26 Jul 2022 01:58:05 +0000
Received: from szxga08-in.huawei.com ([45.249.212.255])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oG9ph-006l6I-Pz
	for linux-nvme@lists.infradead.org; Tue, 26 Jul 2022 01:58:03 +0000
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LsKjW4Pytz1M8ML;
	Tue, 26 Jul 2022 09:54:55 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Jul 2022 09:57:27 +0800
From: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To: <linux-nvme@lists.infradead.org>, <hare@suse.de>, <hch@lst.de>,
	<sagi@grimberg.me>, <kch@nvidia.com>, <zhangxiaoxu5@huawei.com>
Subject: [-next v2] nvmet-auth: use kmemdup instead of kmalloc + memcpy
Date: Tue, 26 Jul 2022 10:56:32 +0800
Message-ID: <20220726025632.1401689-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220725_185802_059039_DFD5FED7 
X-CRM114-Status: UNSURE (   7.82  )
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

For code neat purpose, we can use kmemdup to replace
kmalloc + memcpy.

Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index cc56e8c821ce..e89edc39aca8 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -160,10 +160,9 @@ static u16 nvmet_auth_reply(struct nvmet_req *req, void *d)
 	pr_debug("%s: ctrl %d qid %d host authenticated\n",
 		 __func__, ctrl->cntlid, req->sq->qid);
 	if (data->cvalid) {
-		req->sq->dhchap_c2 = kmalloc(data->hl, GFP_KERNEL);
+		req->sq->dhchap_c2 = kmemdup(data->rval + data->hl, data->hl, GFP_KERNEL);
 		if (!req->sq->dhchap_c2)
 			return NVME_AUTH_DHCHAP_FAILURE_FAILED;
-		memcpy(req->sq->dhchap_c2, data->rval + data->hl, data->hl);
 
 		pr_debug("%s: ctrl %d qid %d challenge %*ph\n",
 			 __func__, ctrl->cntlid, req->sq->qid, data->hl,
-- 
2.31.1


