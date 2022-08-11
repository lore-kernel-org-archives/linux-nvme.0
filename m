Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C01CC00140
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 01:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ISXPP4345jI1j7F6d/2s/d1Db+qT1zEAzEtlYqPts6o=; b=IgJA/AgieKhQNS/gCCoxGItD2Z
	1ufiDTX0pB/wGROJ7/YPQxXFiewgsNxfh5fsZWOMDc9ty32C75EIDiZn+WP/vbdWLbQW025aSyUFH
	DpsjifEB0958muWCJgIAkCrpiY87gmXmonu8GE8S+eERYi2QZ66qpfgrhbUzlo5LWAbw/6L7d8hoM
	2UCNJVsqlzXovDXmPI9HMpKfIdHAlShqrgjulYjOZvSGhia3kPj40Ib1I3LcVgZrP3yh5o48+RQQd
	/40VJpyHUOiydZ9ZGG+uxUy7hsCBGiIhEfJfQPPjLrZwi1t9T9zgpFvN9CbFKnCXH2FWaiJ2Bh1cT
	jmfuZXPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLx0k-001wJi-5k; Thu, 11 Aug 2022 01:29:22 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLx0h-001w2M-AL
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 01:29:20 +0000
Received: by mail-pj1-x102d.google.com with SMTP id o3-20020a17090a0a0300b001f7649cd317so3955507pjo.0
        for <linux-nvme@lists.infradead.org>; Wed, 10 Aug 2022 18:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=ISXPP4345jI1j7F6d/2s/d1Db+qT1zEAzEtlYqPts6o=;
        b=DfXb/cvlC5ZqpOXDlpmOTigYaswSG6kdcNbwyncKAiLiZ5OkPtVq25ZuXRMscOPfnF
         08DEdhOTjJpmKmUARHGM0BRJwUJ/rZFoK3bp5Mo/6GwCRbxzhEhjyNkfqDiDzjtAVLhg
         Gskz+u/1c1xYt7boFpBAfBlgI9hTFd3KB9TXueHMM1Jq+iyYxPLG3oa48Uuzrq/Y11dA
         foYnZv48yIIlcEXxWdpq2J9wgNw01m3IQfxN2W3R63OzGBcTbw4mcxBZ+AJvGD9d+8o6
         ryQAqebeRg6ulpG0ycQ/Om701OwYtGgNH0PqOY6qGcj9ayn00VT8sS7cSP2ONC6A4lxR
         eL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ISXPP4345jI1j7F6d/2s/d1Db+qT1zEAzEtlYqPts6o=;
        b=PKyjXwPxsS+LfNIq10wqF7HwcDOrvyTzAW87R71vsrNtbOCekyRZzI/6HJSNyVleDs
         xiGzc822zfHSPm6f0vYuKYCbiiEgWIlEOjMemcmTuLJHherSdGfWcZWFeklMasstiGQX
         sqdGEfsukpJmxrRPryeCeEEIViVfMqh/1lR24G318HgJCcuro72COReusrlT1RuGcPXz
         dwNBu3YM2u3ejrwm9V6W/abPJRwyMQFLpXcLdaJsnU38JEw+myj+KvszT8k+gWFXqeJs
         1m6FDx+pmpgA1p0Y4DAsW5Mup3Dbn9JCBDxZDaBMDuMnj2s0cOGpgU6ZBiPO9RgldCrF
         3aQg==
X-Gm-Message-State: ACgBeo39eQOBpL1I/E7t787ujgFEW+ptRcF5ecPGA1lrk+eQIj2w3ht3
	V/1+c03zfiqnlqttgaAogRE=
X-Google-Smtp-Source: AA6agR5P20X/40dLw0FhZ/g2stD77uWZbAOlSGpMNrwpQEveXolaRsAXDD4Ydp60cmaPwrLDf0dFUg==
X-Received: by 2002:a17:90b:2791:b0:1f3:c48:19d5 with SMTP id pw17-20020a17090b279100b001f30c4819d5mr6213691pjb.219.1660181354225;
        Wed, 10 Aug 2022 18:29:14 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902904600b0016bea74d11esm13404433plz.267.2022.08.10.18.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 18:29:13 -0700 (PDT)
From: cgel.zte@gmail.com
X-Google-Original-From: ye.xingchen@zte.com.cn
To: kbusch@kernel.org
Cc: axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	ye xingchen <ye.xingchen@zte.com.cn>,
	Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] nvme:Use the function kobj_to_dev()
Date: Thu, 11 Aug 2022 01:29:10 +0000
Message-Id: <20220811012910.15820-1-ye.xingchen@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_182919_403953_5F14618E 
X-CRM114-Status: GOOD (  13.47  )
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

From: ye xingchen <ye.xingchen@zte.com.cn>

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index af367b22871b..6cbc03d6bb7d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3432,7 +3432,7 @@ static struct attribute *nvme_ns_id_attrs[] = {
 static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
 
 	if (a == &dev_attr_uuid.attr) {
@@ -3843,7 +3843,7 @@ static struct attribute *nvme_dev_attrs[] = {
 static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
 	if (a == &dev_attr_delete_controller.attr && !ctrl->ops->delete_ctrl)
-- 
2.25.1

