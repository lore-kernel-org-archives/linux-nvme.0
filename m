Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 397F8C6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 08:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vgy4ApgW8UjdV65BZaD2hS3OgtTdYv8Vbx6K6SyNJnw=; b=pao9ym6m99CMDXcMj/g6cdPmxx
	oYMMYIIMO0vB+KO5wfguwR6AwKsCgRvF+nRqtFllC8c8zMigd7eO3UGgOUWPiNROFWcfhRUgXBOQB
	9zafHcRdnqMTp93yN0ArGAgh+kdX5V7m2fRlZm3+SXA86MbCJbj7+Iby/BHVyBFBe2mmqi50cG+/a
	USk7Q7ZF1WpSC3FRzBb0gwQW/JbyJV7/CyMI8Mdzjiqz4B4BKKzheB2NdwSY+UppI+Ck9cQkN+Pih
	G+3EIL+SjteF/YNsc1DQaaIL3aCMERaGi3QVYmL+DRg1QLhhGZpfjE99jmErZCqINVLGEk39iflQR
	8hbj7tCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHNE-00E4J3-8q; Thu, 22 Sep 2022 08:15:56 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHN3-00E4C5-2Q
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 08:15:46 +0000
Received: by mail-wr1-f44.google.com with SMTP id r7so14255816wrm.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 01:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vgy4ApgW8UjdV65BZaD2hS3OgtTdYv8Vbx6K6SyNJnw=;
        b=AOcdxCoTlaAzbnhdgw7Fc8PJSHZ+38mLHKxPQaRC4fqwljFjdzsQvbUui83Cr2WUjr
         0UpH66JDK1Qfc+WwZHNl8KZ1b3aNQHMhilcfY0f2Yto9dLZ+QAz7bWaZLBB0ycBwoVqa
         WfNCuBBJ8NDBTZQHNNeOMbXg4/mGYfzI/x2goq1wBuuhJH/8HmoRTE3E9gANlbRhm8SB
         yZ+UL9NmSDwuHm4ekF5WyMrih4cL6WoEHdwmcNgOCc06+qqNOr+HmlJqa/b1peePTNUZ
         iHKfzaB3680jiBt6rqgExjeEFZiAt57oVtIbyyclZbtJleGeC0NJIBsIHrUO/7GirQJi
         /I8Q==
X-Gm-Message-State: ACrzQf2D7zus1KfY13ry/168YPpZaXu5gnqmG2eUTkgqZLBVzqc4eZ9V
	ev8rzxZSm2NfAWDDDm1cEDT4jgIK6QE=
X-Google-Smtp-Source: AMsMyM5oGSTCQxEfjEg36WiK8KOPS8+dQKXQqMH4kT/UcC9VwxsRcWuSNPO5VFNC4p95F3KYXaSMkQ==
X-Received: by 2002:a5d:584f:0:b0:22b:f50:a41 with SMTP id i15-20020a5d584f000000b0022b0f500a41mr1146947wrf.140.1663834542039;
        Thu, 22 Sep 2022 01:15:42 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t126-20020a1c4684000000b003b32aa0fabcsm5016997wma.4.2022.09.22.01.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:15:41 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>,
	James Smart <james.smart@broadcom.com>
Subject: [PATCH v2 1/2] nvme: enumerate controller flags
Date: Thu, 22 Sep 2022 11:15:36 +0300
Message-Id: <20220922081538.13364-2-sagi@grimberg.me>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220922081538.13364-1-sagi@grimberg.me>
References: <20220922081538.13364-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_011545_154307_83FD312D 
X-CRM114-Status: GOOD (  12.47  )
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

We expect to grow a few of these flags for various purposes
so make them a proper enumeration.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/nvme.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bdc0ff7ed9ab..fcf891467e68 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -233,6 +233,11 @@ struct nvme_fault_inject {
 #endif
 };
 
+enum nvme_ctrl_flags {
+	NVME_CTRL_FAILFAST_EXPIRED	= (1 << 0),
+	NVME_CTRL_ADMIN_Q_STOPPED	= (1 << 1),
+};
+
 struct nvme_ctrl {
 	bool comp_seen;
 	enum nvme_ctrl_state state;
@@ -354,8 +359,6 @@ struct nvme_ctrl {
 	u16 maxcmd;
 	int nr_reconnects;
 	unsigned long flags;
-#define NVME_CTRL_FAILFAST_EXPIRED	0
-#define NVME_CTRL_ADMIN_Q_STOPPED	1
 	struct nvmf_ctrl_options *opts;
 
 	struct page *discard_page;
-- 
2.34.1


