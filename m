Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A7BEC433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Nov 2022 11:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m5pBn5QAyjGTWBcAG5Oc0FfA9y9imzZFeJbtz5BX/XI=; b=ohmHYMl+DGEYgfJ3xDLBJq0iz4
	PH+Fx/I/Tl7qM1bu7u/3t68RQP4ynx/ZUbA08WebsQ48V4MkgfDW/F6pGFzyD0/BxxzZAXjYILWY9
	RGfswI8j6JgzsIhgZA70viA6tybFeM84Edb+BX/ZCzgQhykEbD3rKNf/jOTo/riVwXmjMP5f6n/XY
	WtOsJuOSAagAmdiC025JKmEH69BG5BPg56URNuhBvcdcV9/EIEQ+riYM7dC/7aZaycEAD2ItpcXom
	kEAcV5K0B7h0AOOA20YUesYEZXYHcb9JbcFGSPFU/ycnqRyCjBCIw3KvX5RjsK+ZTMXHihQ15iBM5
	Joa0WDUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB7T-00B6xx-E2; Sun, 13 Nov 2022 11:25:47 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouB6O-00B6Lk-M2
	for linux-nvme@lists.infradead.org; Sun, 13 Nov 2022 11:24:41 +0000
Received: by mail-wr1-f42.google.com with SMTP id k8so12427896wrh.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Nov 2022 03:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5pBn5QAyjGTWBcAG5Oc0FfA9y9imzZFeJbtz5BX/XI=;
        b=4SRJx9LGMG59w1uJ8dJh/dEIjKYusjrzHVo7asUGb7Ne0gJjwaEhQakkfpS2HnZShQ
         pWLBKgvHC/izgIsfUNAAiudKgHntkE+pNXeYaQd63rMnuz1oNL9AMWkm76MiB2xW2j1W
         hm3hT9A40eXYfGp8UR3poAlmICYSqU6GIvPkfjhTJBj6lxomHn8ck8SpA4Zdi9PuL4jS
         l1/+c95ZK+9xamra0+P8X1A3gZvec1M3i5DW6zcLvIOcJddeNyCsL5XT31pi2XkTH/Aa
         D0BP4UgQsMCiOUI7EoxPi7SgWxZF5/gcj25WRY0hfX1hfgKkQ8MbxactrhziCIncxbwm
         5o3A==
X-Gm-Message-State: ANoB5pkucZjsdFafC9aKxWAGmw6meooKT3nCmXVTFYC9VoiVIXJ7f5+u
	6dCS61bnOTUvJ27eRYJbtIuhFfXkKUk=
X-Google-Smtp-Source: AA0mqf7om45cUa9k88h/73T1ZVaGoZU+LZF3wuIpbSysw2OIXs+2eJQd90Q5dLdVlu632WDZJHSi5g==
X-Received: by 2002:a5d:6641:0:b0:236:57f3:c9e6 with SMTP id f1-20020a5d6641000000b0023657f3c9e6mr5125142wrw.21.1668338679959;
        Sun, 13 Nov 2022 03:24:39 -0800 (PST)
Received: from localhost.localdomain (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id p1-20020a1c5441000000b003b4868eb71bsm14318393wmi.25.2022.11.13.03.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 03:24:39 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v2 11/20] nvme-auth: clear sensitive info right after authentication completes
Date: Sun, 13 Nov 2022 13:24:15 +0200
Message-Id: <20221113112424.1049834-12-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221113112424.1049834-1-sagi@grimberg.me>
References: <20221113112424.1049834-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221113_032440_762124_1E53BA50 
X-CRM114-Status: GOOD (  10.17  )
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

We don't want to keep authentication sensitive info in memory for unlimited
amount of time.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/auth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 4bfe9ecda12a..e6f07c7f76d0 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -910,6 +910,8 @@ int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 		mutex_unlock(&ctrl->dhchap_auth_mutex);
 		flush_work(&chap->auth_work);
 		ret = chap->error;
+		/* clear sensitive info */
+		nvme_auth_reset_dhchap(chap);
 		return ret;
 	}
 	mutex_unlock(&ctrl->dhchap_auth_mutex);
-- 
2.34.1


