Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F39C433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 10 May 2022 10:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sCueAiZ8pX86I1R/1I9WgSZcskWDRYR0Da8bJxkVfcs=; b=2MHCIflknbObeQEKIjyWK+KYqn
	710CjFZ7xb/wFiPZMSHUov1VGU478wFjmrDHfGDGGvL9IeO0cDkUVNV/sVNffJ+EK5ekHfJzZu3xY
	lqrj90aKX1K28DyTmSea9ZKty024WWq2CLHjVUmSa8prN6PLU7Ma6hwDr+Q6Bzk+yUYauQQfAds4w
	NM0/yt0ReasZhlTBbd/Ztg5KjtZ2UmUapkh1dyK06QqbzzrDNznhwHXNJlOOJMB4HpV6rtLMt1ibc
	rIIqoyVAiM+SNoDB+mqtTngHp9H6HZmBEYAFtjC28VihJtzVjFfazpJKhouNAnRL1crO2ef46HY6O
	16t+5XMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noNUQ-001LZB-AH; Tue, 10 May 2022 10:53:14 +0000
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noNUM-001LUt-S3
 for linux-nvme@lists.infradead.org; Tue, 10 May 2022 10:53:12 +0000
Received: by mail-pj1-x1029.google.com with SMTP id
 cu23-20020a17090afa9700b001d98d8e53b7so1752271pjb.0
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 03:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sCueAiZ8pX86I1R/1I9WgSZcskWDRYR0Da8bJxkVfcs=;
 b=IPa6eL5aJa33heazIEv4jx+xlu5moXTQqaUnxxLpqMDpO8aGZZD8fYVApyYetHOyGg
 Kharz/D0Y90BOeII9ErtoiT1nAzQbr+8/uZ+6IiEh9YCcWBwJ+2Bk4lCLuoJZkd/Ueu0
 lXjBAAXZ/99vy2K6naeDpByfcz/54J8z2Tewefk6W6DpoOqXCsWEa4Hx7cVcQ1g5augC
 n221LoIraRQuX3oIIXRi0qYNUbr/1wANb6rJLLG+0kliVfQnXIMF8LACB2MLXuVkqP0g
 uFYLpxfj54oSbzV0x/AcbNRyjII4LdWqomR7faogAhyo2Znt0R48C59yLNK6e7PCHygm
 2rvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=sCueAiZ8pX86I1R/1I9WgSZcskWDRYR0Da8bJxkVfcs=;
 b=AMvkSTKOdXy6aFUnup1/LouppZSI659mFqGQXdfjar7weFMbXE0Sc9cBtR23tSC6us
 znW8xpyhPlfOAiyX9AlEXDm0S6JBVMAKy/57mMhCAgP4CdHxTuFXO3VoMI2jUDAS2oK9
 fgr1gTRfG+ghuYTg7vv9U4eiqnfOtymC9QxJ2Ngxx5sOwEhm7LW+85M2cyljN6c4GFxu
 XdLBTjgwiGU437qu6mklL8jQqdGoPSR+t1noLvVuSEAJ7SrMnOT82OXk0bDgTO1MUY/q
 Ose6u4UmNNNQLVuAdrZ6xAmUdI72yHe9gpX1dGsoDrlF0U+LIogbz58v4jEIvFoaEl7Z
 PRpQ==
X-Gm-Message-State: AOAM531f7IS6qM1Swwq6tD25dO6BeSHw2mluRAiZzQpfMkHPheGT7Bmn
 jVfHh/vaf5jYek5NCOXGDhA=
X-Google-Smtp-Source: ABdhPJx67ZlYTKYPHWjl22QUBHOCM+xy2RlMtychZuLoqjEZdoH+ht0H5OxHxYMrQPiy2NvxpAKV5w==
X-Received: by 2002:a17:902:70c3:b0:15e:f8ef:67b5 with SMTP id
 l3-20020a17090270c300b0015ef8ef67b5mr15377289plt.115.1652179987322; 
 Tue, 10 May 2022 03:53:07 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
 by smtp.gmail.com with ESMTPSA id
 a3-20020a1709027d8300b0015e8d4eb2ccsm1651840plm.278.2022.05.10.03.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 03:53:07 -0700 (PDT)
From: cgel.zte@gmail.com
X-Google-Original-From: chi.minghao@zte.com.cn
To: kbusch@kernel.org
Cc: axboe@fb.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Minghao Chi <chi.minghao@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] NVMe: use kobj_to_dev()
Date: Tue, 10 May 2022 10:53:03 +0000
Message-Id: <20220510105303.1352342-1-chi.minghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_035310_990017_A6E0C882 
X-CRM114-Status: GOOD (  13.45  )
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

From: Minghao Chi <chi.minghao@zte.com.cn>

Use kobj_to_dev() instead of open-coding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 510e3860358b..48d2bb0a4fad 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3267,7 +3267,7 @@ static struct attribute *nvme_ns_id_attrs[] = {
 static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
 
 	if (a == &dev_attr_uuid.attr) {
@@ -3572,7 +3572,7 @@ static struct attribute *nvme_dev_attrs[] = {
 static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
-	struct device *dev = container_of(kobj, struct device, kobj);
+	struct device *dev = kobj_to_dev(kobj);
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 
 	if (a == &dev_attr_delete_controller.attr && !ctrl->ops->delete_ctrl)
-- 
2.25.1



