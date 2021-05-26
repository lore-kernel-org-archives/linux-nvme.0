Return-Path: <SRS0=7k1C=KV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B4A6C2B9F7
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 07:25:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F3E761028
	for <linux-nvme@archiver.kernel.org>; Wed, 26 May 2021 07:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F3E761028
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yzlnDU1asU9ZEqiR2xKvblD++q9rBoYSAfAPV+V3YpU=; b=4Z3P1EB/pYBO/5
	dNlM2dfLIVIumxwnwRwU17oZkcRhavZE/Yq/fdNmc4kj6AIIyZj0s/uvDsvxqjhPZgIwZBML+tXni
	JhhEJoTW/B0wjFkz2R4T1KkwwmeA/bVV/VB84mhV4OC1JdBh3B7D8nNoC3e5FdUe/OTi5J+pA7zlw
	elkX8H76YaKlDN5C2gaRw10zCTcnTyXm0SADrIWDOjyDRJFcL2F7U0S6Ecynkf4f/UXZ+pMLB8ewn
	LtGiNAYN7cNBPRvzHSUoCviEAL3knSx3ljiKdf/2n7OQVrKutMaV2QiYMcQBA7Cht+WqOaT8oo2Ny
	WLkCHzHIDsKE16BLb6Bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llnur-00C2am-FO; Wed, 26 May 2021 07:25:21 +0000
Received: from mail-pg1-f174.google.com ([209.85.215.174])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llnuo-00C2ZL-RY
 for linux-nvme@lists.infradead.org; Wed, 26 May 2021 07:25:20 +0000
Received: by mail-pg1-f174.google.com with SMTP id m124so182784pgm.13
 for <linux-nvme@lists.infradead.org>; Wed, 26 May 2021 00:25:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Jn6Gjx9pRtY8yQZ+Dmz7OLJrRPdCK2w2Yi6u73xvDSY=;
 b=iAlCTf6dILKQSC+7FxdXC7HyMmOOACcpeh7LWsq0XX7UOxATkSWHahmbH3p3PCCxPf
 N/d7pNF1WLV3nPouTR3qJ6mkbRT//nFK/hpPhAYygKAHBh2ijt5q8epPeqo7+DeGN8gj
 C1t0//jyQWPQFA7XU+pB5UKQ4lvmAw1dxRhEGVaNhVe4f5FMarxvosXsvK8TD4qfERNU
 t9OabGNgC6D+2itl61uF05rA74RKdGLaEKBDB4AAUGNlHwZAUG4Gb6y3vevRVAR0yvTL
 r7NuXtUwhPS2exdrccLqE6rRKhiazSs3lBsb8eULoBBs7A+waLOBsRcozl/PN1WCEpSl
 oWCw==
X-Gm-Message-State: AOAM532QcZDPUUEIur7irsBRCSt/NJvbSDSY2YsPtZHWbAaGNRXbAYBS
 7UIyEwZiPtjDmUEhQvbRUMUYtcH4NWs=
X-Google-Smtp-Source: ABdhPJxMH4G1Od98b5cnf/f0C8p599nTU4xDxUqTdOy8cdQhToT4dRDi9CQXSFcQM+lo8km2Wah6WA==
X-Received: by 2002:a63:e14:: with SMTP id d20mr23986080pgl.35.1622013917389; 
 Wed, 26 May 2021 00:25:17 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:3726:dadd:2909:e6bb])
 by smtp.gmail.com with ESMTPSA id v21sm15894702pgh.12.2021.05.26.00.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 May 2021 00:25:16 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH nvme-cli] systemd/nvmf-autoconnect.service: load nvme-fabrics
 before autoconnect
Date: Wed, 26 May 2021 00:25:15 -0700
Message-Id: <20210526072515.15092-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210526_002518_914540_8589075C 
X-CRM114-Status: UNSURE (   9.11  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Upon boot nvme-fabrics needs to be loaded, so make sure to load
it before executing ExecStart. The driver will know to request
the transport module according to the transport parameter.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 nvmf-autoconnect/systemd/nvmf-autoconnect.service | 1 +
 1 file changed, 1 insertion(+)

diff --git a/nvmf-autoconnect/systemd/nvmf-autoconnect.service b/nvmf-autoconnect/systemd/nvmf-autoconnect.service
index 26904674ffe7..bf40db0b549d 100644
--- a/nvmf-autoconnect/systemd/nvmf-autoconnect.service
+++ b/nvmf-autoconnect/systemd/nvmf-autoconnect.service
@@ -6,6 +6,7 @@ Before=remote-fs-pre.target
 
 [Service]
 Type=oneshot
+ExecStartPre=/sbin/modprobe nvme-fabrics
 ExecStart=/usr/sbin/nvme connect-all
 
 [Install]
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
