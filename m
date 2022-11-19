Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7941EC433FE
	for <linux-nvme@archiver.kernel.org>; Sat, 19 Nov 2022 02:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BwO6MgIolHPZ2c7zqzgx6EbLTfhhVXJkvOcwWGT4bQY=; b=ywTviw25Pz+/YDHPrK9XLS80ar
	eo4/MKjEczqyI0Zx7uedrt3nP6z4mX6y27XJBhRnB7JgALEs7KSdDjqyp7CHcq9JysM2zZrWEc20e
	klAZmscE/iG5hpnCyOj9Juak5PcejqV/YfHqsfhH4P1aKooSNasETx/V2bUZffI6syvNg4LjBDRu8
	25h+ZYAzSDSwsd6iP86VGaUF7v/ZY9Del3go/QwRXLPUdLcKS5Av2hvJy137Xom5/Se9TAqk/b0sh
	sqjxYjaXrmpGPdc4kTjyudZF1Ki2wf3dZ9TY2xieA83Tyg4sstN7D2IjiAeyELQl7lcUe/t42FRXZ
	5lcL7nyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owDNh-00AGhH-CB; Sat, 19 Nov 2022 02:14:57 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1owDNO-00AGXb-Rr
	for linux-nvme@lists.infradead.org; Sat, 19 Nov 2022 02:14:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 6A270B82670;
	Sat, 19 Nov 2022 02:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4659AC4347C;
	Sat, 19 Nov 2022 02:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668824076;
	bh=aRsMMGmvgD/lbdqaN0JidPGzRj14aJPQ1+YlVjXftfk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=phQmmRo463SqSVptHZYhn9/eQCNXTTDYXDRXblqf6qdOkgm4Anp2zO5/OL8Cs7jyy
	 ckm8zSFLKFkNBKhrs8JGJTSy0o5j05ggXWQGYVVeMj1ON/5o6w9wYUnu+auD3+CvH5
	 vkcYI0W/zrXZIiKZg8vGnLah9z9brmmdV7T4vOiXkSKCAoV2ALT+jXrAignL400h3l
	 v9RIIKMNx/sk5JbLiWbBvTkWdXh5oUSQRDuNOHQ6va9x21/ogkcKUg64Z9GdWxbORT
	 9BDtOxlFewfqShoIGhFF2Dmf2OH+LFIwzxMYpmBdlMwojPHfq5ayR1/qCih10QRM4/
	 VSNu/hQ9QsujA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Aleksandr Miloserdov <a.miloserdov@yadro.com>,
	Konstantin Shelekhin <k.shelekhin@yadro.com>,
	Dmitriy Bogdanov <d.bogdanov@yadro.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 23/27] nvmet: fix memory leak in nvmet_subsys_attr_model_store_locked
Date: Fri, 18 Nov 2022 21:13:48 -0500
Message-Id: <20221119021352.1774592-23-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221119021352.1774592-1-sashal@kernel.org>
References: <20221119021352.1774592-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221118_181439_089680_BA5A89C9 
X-CRM114-Status: GOOD (  13.15  )
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

From: Aleksandr Miloserdov <a.miloserdov@yadro.com>

[ Upstream commit becc4cac309dc867571f0080fde4426a6c2222e0 ]

Since model_number is allocated before it needs to be freed before
kmemdump_nul.

Reviewed-by: Konstantin Shelekhin <k.shelekhin@yadro.com>
Reviewed-by: Dmitriy Bogdanov <d.bogdanov@yadro.com>
Signed-off-by: Aleksandr Miloserdov <a.miloserdov@yadro.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/configfs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index cea30e4f5053..625038057a76 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1189,6 +1189,7 @@ static ssize_t nvmet_subsys_attr_model_store_locked(struct nvmet_subsys *subsys,
 		const char *page, size_t count)
 {
 	int pos = 0, len;
+	char *val;
 
 	if (subsys->subsys_discovered) {
 		pr_err("Can't set model number. %s is already assigned\n",
@@ -1211,9 +1212,11 @@ static ssize_t nvmet_subsys_attr_model_store_locked(struct nvmet_subsys *subsys,
 			return -EINVAL;
 	}
 
-	subsys->model_number = kmemdup_nul(page, len, GFP_KERNEL);
-	if (!subsys->model_number)
+	val = kmemdup_nul(page, len, GFP_KERNEL);
+	if (!val)
 		return -ENOMEM;
+	kfree(subsys->model_number);
+	subsys->model_number = val;
 	return count;
 }
 
-- 
2.35.1


