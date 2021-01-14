Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880D8C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 00:00:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C6422460
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 00:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C6422460
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=deDTqwuB9qG9p1GsKm1xEpbeYSxrUR1kj1JADBev7Pg=; b=wElYKxhH7mSFrL2ir20gBmIPEr
	zq5rLPIpuibdyDElFHIgaMDCUscgu4TaKMTwkQ6/edrn0nhq4YfoozRw4/XCAU4zW9O/XwBhpisTn
	2sBQLvyS2BbQaIJsBG5s4MEwa4KIx8kwRmxH5nw7Lpw8VLkxfIE4/A1c6l6ulSoD9KJUbdImvbMY8
	OEd4DKMkArGJlKZuZVCBGzz33vDN5LYf0kla08FfOm3wUkoCH3IL78+HueqSi+zoQx+XnWAhOiIe5
	b4Z0GGqi/nlHbnUoGslFkw0shz+x+MZrNAMhOXTTYU36Hs4gvVQgZ2ohDLq6GjjJeWxD3mafQBp/c
	szidJhxA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzq43-0004Oq-EN; Thu, 14 Jan 2021 00:00:35 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzq3y-0004Nb-Rs
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 00:00:32 +0000
Received: by mail-wr1-f44.google.com with SMTP id a12so3927000wrv.8
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 16:00:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rhhbWcY2Z7hVZTGQA+R2IRai8PY1Wj7RKC+E8Xt4kds=;
 b=R23BOQEyr/QS/U/NXpeMQn4hBWqEnNFfNphQ687zzXBPxQsC6P4hxLoDR5zQrOOpPM
 KUws8JaH5hunIe0qZLRHfHS7KJWxoLQNDVITJb/H5ptnpaS92Lef4OFNcW3o0M40juc7
 VHLIqOsTmrZBpLy2dQFKnSNPhFWyVWc4zFwYGXEA5vH0njqc5HH04TijY6s2o37j2CXi
 6aiF0ERwYnErH1uOOe16kYPD/Spo4ArTIeVbEafJpl4hcbfQaL38c/Mpb/ERTcPWtnBO
 OCqXSXSaDSmFxhGYf+oNl+8K7BOcleeyrY+OsONhzsqnqQ8BzZFJOEOthPLPkf9pHIXm
 eEKQ==
X-Gm-Message-State: AOAM532jZORmjGC204TtnlxgguTXAcPIpqbMHvAFUHtUyQAKlORhJvFU
 HNRHC0dRRcjCa2ZEWtFgjWo=
X-Google-Smtp-Source: ABdhPJwuj9NDuUvMU1/GuaHUTVa76bEXoG/ePab4uuctDIrezoHU2RLqiLv9KF5nmAB3MMvT+vvGLQ==
X-Received: by 2002:a5d:570e:: with SMTP id a14mr4934168wrv.126.1610582428044; 
 Wed, 13 Jan 2021 16:00:28 -0800 (PST)
Received: from localhost.localdomain ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id y11sm4911843wmi.0.2021.01.13.16.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 16:00:27 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: don't intialize hwmon for discovery controllers
Date: Wed, 13 Jan 2021 16:00:22 -0800
Message-Id: <20210114000022.1641939-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_190030_930433_A5C26E64 
X-CRM114-Status: GOOD (  14.06  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Discovery controllers usually don't support smart log page command.
So when we connect to the discovery controller we see this warning:
nvme nvme0: Failed to read smart log (error 24577)
nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 192.168.123.1:8009
nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"

Introduce a new helper to understand if the controller is a discovery
controller and use this helper to skip nvme_init_hwmon (also use it in
other places that we check if the controller is a discovery controller).

Fixes: 400b6a7b13a3 ("nvme: Add hardware monitoring support")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fff49e544fdf..a7dbc3ef79f4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2855,6 +2855,11 @@ static const struct attribute_group *nvme_subsys_attrs_groups[] = {
 	NULL,
 };
 
+static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
+{
+	return ctrl->opts && ctrl->opts->discovery_nqn;
+}
+
 static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
@@ -2874,7 +2879,7 @@ static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		}
 
 		if ((id->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
-		    (ctrl->opts && ctrl->opts->discovery_nqn))
+		    nvme_discovery_ctrl(ctrl))
 			continue;
 
 		dev_err(ctrl->device,
@@ -3143,7 +3148,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 			goto out_free;
 		}
 
-		if (!ctrl->opts->discovery_nqn && !ctrl->kas) {
+		if (!nvme_discovery_ctrl(ctrl) && !ctrl->kas) {
 			dev_err(ctrl->device,
 				"keep-alive support is mandatory for fabrics\n");
 			ret = -EINVAL;
@@ -3183,7 +3188,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	if (ret < 0)
 		return ret;
 
-	if (!ctrl->identified) {
+	if (!ctrl->identified && !nvme_discovery_ctrl(ctrl)) {
 		ret = nvme_hwmon_init(ctrl);
 		if (ret < 0)
 			return ret;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
