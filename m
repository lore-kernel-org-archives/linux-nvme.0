Return-Path: <SRS0=7ItS=MS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B3CC4320A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jul 2021 13:24:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F09C06056C
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Jul 2021 13:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F09C06056C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gh5fLcy+aOq6zqEn3Y9rVLv6NejLHG0xeRO181BYuUM=; b=egAE6bJvdcg++d
	CN/Qv0CmKFxvBzNiNihv9DQt+Dbu2y9gmPxA35Y7MdAOcrW6CIgTpNk5pfKcJRazjI1zamGF61vTG
	JXQdV598LIpGTkqLVCzzv5xjIv3psjFntvSI6HjcaSklPRdOoW0cmjrpm89eAqCIn5pNISbZptuGL
	/Y48i+BcFTeN6CGc25uBAUfJVDu6Ni2I/kHpW605Nj6CgCCdPPa/5WCoPA8Lj9fpCadvQ4A+5wJS0
	kqYqqbnchjAF9H4kxkjCTUOkpmtKJ4hzPfvQFu8/iIA4c1Ia4I2e9FwGzzHP3qqohYmBEt9+le6o8
	mHs5QU8OLyAd6txvVlng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m80aQ-00BJ5A-Nf; Mon, 26 Jul 2021 13:24:02 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m80Zo-00BJ0o-Ja
 for linux-nvme@lists.infradead.org; Mon, 26 Jul 2021 13:23:25 +0000
Received: by mail-wr1-x431.google.com with SMTP id z7so11012533wrn.11
 for <linux-nvme@lists.infradead.org>; Mon, 26 Jul 2021 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9K67sWK8iCvxn8wA3EP4cDIU+lrlaZyWsxH1S+wkYOk=;
 b=SuZZBJipNbPUZaCppP1IpW/GUu7EREB17r3O2x4RRKUBddZb/DPJWFM2D2yPk6HaS8
 dwpZBgsZEe+JxhCYo0i9ZfC1JzogLyjFf2r4NXY+QnIUKgYevYwGkxWgCaQjr+MKV73/
 HCfSbSFgw6B9XATA8nj/GEkkYaK19r5+Uwvtl3xKUaHHhuZhwypzUw7lraPUiE/WvEcj
 haRm31qV4CQ+iVkt5bLMNpFyFx/roj6x9k4OBrqTvojR1mgBmCZ+vMIJEDf3U5jNfGXR
 vUjkTpfTW97crzw4/5wizMHsUxf99qtVe7fvTJlc6h3SXsZr4YSU5rllmc6CTuO2crzs
 PxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9K67sWK8iCvxn8wA3EP4cDIU+lrlaZyWsxH1S+wkYOk=;
 b=BKUBuFt80P8lWELULa90T5Xt0BiXk8rfW2Z+Wxzf/PWacuQcqT+aw6vc+KjN3daxxp
 Esq7ARogNfNko50V1sRWSD8W+b92GusjNL1DMx9YBJrxXvzLX8G1ETuU4kzQJqLVvwSd
 YnsRLwCAt7Ci2gbhX0rFsLK1TG0xAt86tQTGSvbXSJln98bf/gWzwIoyr2pXoYzPmkJ6
 FQw1yhMEjgdFN3SsYHQUWhT26MYI7r6UpN/cQVjb9mByX3jpsBbWt3RoTgzFu6mezJE7
 xTcb0OZQ7oHYxZlqZB5oD4KOzzcSVziBhqKZ6X0R45gNdAQAMOR2yZN3g5seQCK5JxAB
 fcUw==
X-Gm-Message-State: AOAM533tYSJlJhic8qz8mXKzzWHXFRNBoytgQYHT7KvxtvHa7pPsCMp3
 FEEXKrjeCmgI286ZtWNha1k=
X-Google-Smtp-Source: ABdhPJwxNCP148AFjwK/y0hOukG4j4nAjYbmtdI5DOJLx1OPPGpFdCbRWSx3RwnrbXoJ7AnnSojlhA==
X-Received: by 2002:a5d:6708:: with SMTP id o8mr9758731wru.304.1627305803088; 
 Mon, 26 Jul 2021 06:23:23 -0700 (PDT)
Received: from microndev.lxd (ip5f5ac0ff.dynamic.kabel-deutschland.de.
 [95.90.192.255])
 by smtp.gmail.com with ESMTPSA id w15sm8580wmi.3.2021.07.26.06.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jul 2021 06:23:22 -0700 (PDT)
From: shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To: rjw@rjwysocki.net, pavel@ucw.cz, len.brown@intel.com,
 linux-pm@vger.kernel.org, kbusch@kernel.org, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
 Shivamurthy Shastri <sshivamurthy@micron.com>,
 Keith Busch <kbush@kernel.org>
Subject: [PATCH v2 1/2] PM: enable support for imminent power loss
Date: Mon, 26 Jul 2021 13:22:22 +0000
Message-Id: <20210726132223.1661-2-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210726132223.1661-1-sshivamurthy@micron.com>
References: <20210726132223.1661-1-sshivamurthy@micron.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210726_062324_692846_01EFEF11 
X-CRM114-Status: GOOD (  15.15  )
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

From: Shivamurthy Shastri <sshivamurthy@micron.com>

If the shutdown is pwerformed when the platform is running on the
limited backup power supply, some of the devices might not have enough
power to perform a clean shutdown.

It is necessary to inform the driver about the limited backup power
supply, to allow the driver to decide to perform the minimal required
operation for a fast and clean shutdown.

Signed-off-by: Keith Busch <kbush@kernel.org>
Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 include/linux/suspend.h | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 8af13ba60c7e..1898792c10d3 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -210,9 +210,10 @@ extern int suspend_valid_only_mem(suspend_state_t state);
 
 extern unsigned int pm_suspend_global_flags;
 
-#define PM_SUSPEND_FLAG_FW_SUSPEND	BIT(0)
-#define PM_SUSPEND_FLAG_FW_RESUME	BIT(1)
-#define PM_SUSPEND_FLAG_NO_PLATFORM	BIT(2)
+#define PM_SUSPEND_FLAG_FW_SUSPEND		BIT(0)
+#define PM_SUSPEND_FLAG_FW_RESUME		BIT(1)
+#define PM_SUSPEND_FLAG_NO_PLATFORM		BIT(2)
+#define PM_SUSPEND_FLAG_POWER_LOSS_IMMINENT	BIT(3)
 
 static inline void pm_suspend_clear_flags(void)
 {
@@ -234,6 +235,11 @@ static inline void pm_set_suspend_no_platform(void)
 	pm_suspend_global_flags |= PM_SUSPEND_FLAG_NO_PLATFORM;
 }
 
+static inline void pm_set_power_loss_imminent(void)
+{
+	pm_suspend_global_flags |= PM_SUSPEND_FLAG_POWER_LOSS_IMMINENT;
+}
+
 /**
  * pm_suspend_via_firmware - Check if platform firmware will suspend the system.
  *
@@ -291,6 +297,22 @@ static inline bool pm_suspend_no_platform(void)
 	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_NO_PLATFORM);
 }
 
+/**
+ * pm_power_loss_imminent - Check if platform is running on limited backup power
+ * source
+ *
+ * To be called during system-wide power management transitions to sleep states.
+ *
+ * Return 'true' if power loss may be imminent due to platform running on
+ * limited backup supply. If set during a shutdown, drivers should use any
+ * available shortcuts to prepare their device for abrupt power loss.
+ */
+static inline bool pm_power_loss_imminent(void)
+{
+	return !!(pm_suspend_global_flags &
+		  PM_SUSPEND_FLAG_POWER_LOSS_IMMINENT);
+}
+
 /* Suspend-to-idle state machnine. */
 enum s2idle_states {
 	S2IDLE_STATE_NONE,      /* Not suspended/suspending. */
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
