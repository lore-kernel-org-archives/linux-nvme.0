Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0435C38A2D
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 08:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ejZNdpUow7TspteSRun/NNEoVBTr7ypQr3TMWbiT/rw=; b=Mld68jNKGl5ebbhZtetvJliylT
	nuluVmGdO0GavWnufk2GOYu3Qb9SD9xzNXOVgkmeRaf0xgW5KMwoV6wkYR+ltdL8eYyr/fnqA0Gox
	XcOhmRC8wMcCpf0iLqbb0zX3/HVdTyZZUQVTE34hI57LBn/zZYEtGsAGI5Xmk80cv4uB9FBnXLn2b
	w8ELtY795GHNJRuwPVh864qR24/UE1qCFB/4sAqEPm/Q2dVqeEPxLug2gw8wjNqScgQ8/nfs2irji
	i0/0W36YWSmwihk2JoHWQvmFcwFvuDEk0M59qrDEipKo/mjDq5gFfQIu2WI7SHAgoNKG1Pf1uS5qK
	4keYwzWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onbrc-008Zdy-0C; Wed, 26 Oct 2022 08:34:16 +0000
Received: from mta-02.yadro.com ([89.207.88.252] helo=mta-01.yadro.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onbrO-008Zb0-TW
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 08:34:05 +0000
Received: from localhost (unknown [127.0.0.1])
	by mta-01.yadro.com (Postfix) with ESMTP id D10AB4120E;
	Wed, 26 Oct 2022 08:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
	content-type:content-type:content-transfer-encoding:mime-version
	:references:in-reply-to:x-mailer:message-id:date:date:subject
	:subject:from:from:received:received:received:received; s=
	mta-01; t=1666773238; x=1668587639; bh=p5HeDWgtQHJDOJsS2jNGnrRAL
	eqcSm+dlh5Rsu4SrG0=; b=rEIbAs0ark1Ue3bSRFRg7WIAH7T0VBdebQaWTWh07
	bvFaMSGaTx4wdkdcf+VQLM0cP37MhU/jH7y5k9SSabUl/ZW3wEtIyu4ESLyz1WBS
	wOSnxijb5lN4x2aIhAXjP4t8IJv9ti+90kA+4Bekd63sNILq5sMkxIVq5HDb94TY
	K0=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
	by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UHOFrkoso6tR; Wed, 26 Oct 2022 11:33:58 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (T-EXCH-02.corp.yadro.com [172.17.10.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by mta-01.yadro.com (Postfix) with ESMTPS id 7EF51403C9;
	Wed, 26 Oct 2022 11:33:42 +0300 (MSK)
Received: from T-Exch-05.corp.yadro.com (172.17.10.109) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 26 Oct 2022 11:33:42 +0300
Received: from yadro.com (10.178.113.226) by T-Exch-05.corp.yadro.com
 (172.17.10.109) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1118.9; Wed, 26 Oct
 2022 11:33:38 +0300
From: Aleksandr Miloserdov <a.miloserdov@yadro.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
CC: <linux-nvme@lists.infradead.org>, <linux@yadro.com>, Aleksandr Miloserdov
	<a.miloserdov@yadro.com>, Konstantin Shelekhin <k.shelekhin@yadro.com>,
	Dmitriy Bogdanov <d.bogdanov@yadro.com>
Subject: [PATCH 1/3] nvmet: fix memory leak in configfs
Date: Wed, 26 Oct 2022 12:31:33 +0400
Message-ID: <20221026083135.77125-2-a.miloserdov@yadro.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20221026083135.77125-1-a.miloserdov@yadro.com>
References: <20221026083135.77125-1-a.miloserdov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.178.113.226]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-Exch-05.corp.yadro.com (172.17.10.109)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_013403_154320_D2A5AD94 
X-CRM114-Status: GOOD (  12.84  )
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

Since model_number is allocated before it needs to be freed before kmemdump_nul.

Reviewed-by: Konstantin Shelekhin <k.shelekhin@yadro.com>
Reviewed-by: Dmitriy Bogdanov <d.bogdanov@yadro.com>
Signed-off-by: Aleksandr Miloserdov <a.miloserdov@yadro.com>
---
 drivers/nvme/target/configfs.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e34a2896fedb..89242b0f8614 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1215,6 +1215,7 @@ static ssize_t nvmet_subsys_attr_model_store_locked(struct nvmet_subsys *subsys,
 		const char *page, size_t count)
 {
 	int pos = 0, len;
+	char *val;
 
 	if (subsys->subsys_discovered) {
 		pr_err("Can't set model number. %s is already assigned\n",
@@ -1237,9 +1238,14 @@ static ssize_t nvmet_subsys_attr_model_store_locked(struct nvmet_subsys *subsys,
 			return -EINVAL;
 	}
 
-	subsys->model_number = kmemdup_nul(page, len, GFP_KERNEL);
-	if (!subsys->model_number)
+	val = kmemdup_nul(page, len, GFP_KERNEL);
+	if (!val)
 		return -ENOMEM;
+
+	kfree(subsys->model_number);
+
+	subsys->model_number = val;
+
 	return count;
 }
 
-- 
2.37.0


