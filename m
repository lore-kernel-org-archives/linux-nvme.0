Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D306C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Mar 2022 23:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=maZWzlNyoZpDsYk1eu5cXGJyshqz+onlFAdchIdCFjg=; b=cvRk2yLtsm4XvvY44ZJwP3V6U5
	2CFzqI8ifyu4sic7Y+BPO8G8SXn6cZRkoDmGU6lcXuLqFRIHStSG2qa1SVclJ/CQeNGL4agnB9B8m
	HU3u1Llf2ba4abU0Doc0AYsFkWA98gKWxfZTjZBgH5JsGZq8wLV6z1s3k5zUu6jgvj0JsFzoyJP1I
	hXg7hSYCcUYs+tckmfdlQK9RZ/yHTQZ5/SKlHEdABtqqKQ4GYQT2PXi5vXWkHEiDNR1TVI/mcIJe9
	05SQmrZBuvJ+Drdd6TqsYxHUpO568rB40MVlClNylHBQ/oRX4Logx/dCJprAopngzXeqXOlF4TRaV
	S3Mt0lXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nTXqp-003VBX-7i; Sun, 13 Mar 2022 23:42:15 +0000
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nTXqm-003VB9-9S
 for linux-nvme@lists.infradead.org; Sun, 13 Mar 2022 23:42:13 +0000
Received: by mail-ej1-x633.google.com with SMTP id p15so30358615ejc.7
 for <linux-nvme@lists.infradead.org>; Sun, 13 Mar 2022 16:42:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=maZWzlNyoZpDsYk1eu5cXGJyshqz+onlFAdchIdCFjg=;
 b=P7Og9wX145wIwt+WiHHO+jaOH3N3XttCYgtEkcYGSrZYuPwGNPTvB0iDMi9TWjenH/
 HN53DQGc3S2gNCzPskdasoTXD2wXnSs8CJFiwtSGiIADxDUbz+DqVK3GEkpUEGn6rDWK
 gK44eUKRJheaIq2KHr/GJDR5hJFnSZo1HVwU30iKTPBblewQcp9q80qMlurBIManHCa9
 VdQqg/H2ignEL8oFbUw2zBLRInb69BS3FxdoDfJ/nFqqKJPCf76RIRK84EtYGAMgRJbB
 kUolbL7iOY761mWiGbZZoiwCflHChXkXgARuUDDx0wKBIIE7dXeCsQThVhaA8xh0vipC
 OmiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=maZWzlNyoZpDsYk1eu5cXGJyshqz+onlFAdchIdCFjg=;
 b=Q7AwPWna6xJAfrWv5/tmTO/0xJHakwbnpBOoXjipyBLl5pIRHqbJiW/k2Nn5ihHFW7
 TWa3NN70c8WZutsNRITVoiUEy0cta+btNb/iKLLsu5Tu9WaOqQGrYEGjHQ7Mgx0w2lxI
 ayUYOPKIHl91mydubUJDCPeuk+bvApXJUqvcMl6NtsLZ1GZFg7F89Wy6C4tAy7X5Mll6
 tc+xp8uFaDuw1doL8qEN+RJ3TTDBhRork6Yxyo0/Yg5XI/MjPmGVG5Og0Go1bFAHZBvR
 TK5qZ6+HplAghg1R4HToOkGRtT7nHUYRqpCVWaNMHcf8+7EexppCvnK2jzx3qauX+oO5
 OU1w==
X-Gm-Message-State: AOAM533mS7LUoMymGNVlYeBwhcjDpMDg3FOJgzlF4h3I7zYKhfCkGjpi
 k3z3l08zhYlsDDQ4wrnVmBl82i36Eu5Htg==
X-Google-Smtp-Source: ABdhPJw+EUCXtcB4JeGsTRnz1QS/oNVYzuGnlUizpMllqXofS/0fWS7J4fxE5fChIPxd+V3Yl8zzPA==
X-Received: by 2002:a17:906:7304:b0:6da:9243:865 with SMTP id
 di4-20020a170906730400b006da92430865mr16667622ejc.665.1647214930846; 
 Sun, 13 Mar 2022 16:42:10 -0700 (PDT)
Received: from nlaptop.localdomain
 (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be.
 [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
 by smtp.gmail.com with ESMTPSA id
 q5-20020aa7cc05000000b004129baa5a94sm6912401edt.64.2022.03.13.16.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Mar 2022 16:42:10 -0700 (PDT)
From: Niels Dossche <dossche.niels@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH v4] nvmet: add missing lock around nvmet_ns_changed in
 nvmet_ns_revalidate
Date: Mon, 14 Mar 2022 00:41:15 +0100
Message-Id: <20220313234114.37931-1-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220313_164212_360880_98B4A58C 
X-CRM114-Status: GOOD (  14.21  )
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

nvmet_ns_changed states via lockdep that the ns->subsys->lock must be
held. The only caller of nvmet_ns_changed which does not acquire that
lock is nvmet_ns_revalidate. nvmet_ns_revalidate has 3 callers,
of which 2 do not acquire that lock: nvmet_execute_identify_cns_cs_ns
and nvmet_execute_identify_ns. The other caller
nvmet_ns_revalidate_size_store does acquire the lock.

The solution is to remove the locking from the one callsite that
acquires the lock, and place all the locking necessary for
the call to nvmet_ns_changed inside the check in nvmet_ns_revalidate.

Both of those identify functions are called from a common function
nvmet_execute_identify, which itself is called indirectly via the
req->execute function pointer.

This issue was found using a static type-based analyser and manually
verified.

Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---

Changes in v4:
 - do the locking locally unconditionally

Changes in v3:
 - improve commit description
 - do the locking locally

Changes in v2:
 - added sentence about how the issue was found.
 - added missing &

 drivers/nvme/target/configfs.c | 3 ---
 drivers/nvme/target/core.c     | 5 ++++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 091a0ca16361..b67ea5772d99 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -580,14 +580,11 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
 	if (!val)
 		return -EINVAL;
 
-	mutex_lock(&ns->subsys->lock);
 	if (!ns->enabled) {
 		pr_err("enable ns before revalidate.\n");
-		mutex_unlock(&ns->subsys->lock);
 		return -EINVAL;
 	}
 	nvmet_ns_revalidate(ns);
-	mutex_unlock(&ns->subsys->lock);
 	return count;
 }
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5119c687de68..a9a2d2b02dee 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -540,8 +540,11 @@ void nvmet_ns_revalidate(struct nvmet_ns *ns)
 	else
 		nvmet_file_ns_revalidate(ns);
 
-	if (oldsize != ns->size)
+	if (oldsize != ns->size) {
+		mutex_lock(&ns->subsys->lock);
 		nvmet_ns_changed(ns->subsys, ns->nsid);
+		mutex_unlock(&ns->subsys->lock);
+	}
 }
 
 int nvmet_ns_enable(struct nvmet_ns *ns)
-- 
2.35.1


