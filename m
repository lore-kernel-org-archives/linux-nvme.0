Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB412C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:55:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76EFE214AF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LD2/6lRu";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ug+t+gOy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RyG5UBz1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76EFE214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=CoxCN4hPMYJEwVkpbf6XM63PS5WG3qNsIiI+ty7A2Tg=; b=LD2/6lRuPs9KUK0ymjgW/0ViOD
	9u9jJMtYe74EgAx+G8WflRgX5VgtNthVt6suq6sWD+ysCPw2xj/eSi+YzRLl4drcS8lIerjHsKDE7
	qtYSCmgLV4f06UgeyLt0OdhCWdON07XQ1nAi6pvjorFCJvW6eaPQVrL+C/HqoNGtawbywEf84toO6
	BxDGZjqVT+heTJHL4qWhXDhr0G2mw2ByzLcDR+aS+FJZ4M54ES7I0nuRmCTver50ZIOACiTCvSPqB
	M08mCAwHw6CON+mCAGmzUOo0aIgfOd+0jjQeRzSJ2HsCiNWbZb/0aA47hRIpVK4xkjGOIaePCHKQN
	OsMKo0lQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1if3Ok-0002M1-Pd; Wed, 11 Dec 2019 14:55:30 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if3OG-0000OV-7N
 for linux-nvme@bombadil.infradead.org; Wed, 11 Dec 2019 14:55:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IcdhyyyraLVUQAQ3HHOSQ6YNvDlkdwwrUN22Ki1UdWw=; b=Ug+t+gOyKcq5g8LevPMhCivOC
 kvT0JBSKAzBaz+gju2Z//bKP8BngPOir/sbVDwmGsTShIJgTTgCoNk4VKQAXarKS5A6huReZAl0jm
 KcjmKZXGP/XfkZA7mExefK1B8fbCzodMiYCzG51nWuBXx62zlNTSAK4ZBAldYyg9AXs1ETlLLLvc0
 XSK5fwl+YgkDcHaZqcWiaKitro2BgRLWmIXrqGTNuafUvMmnqn5Ao0PjlNHwKGqJcgtIgZlxmSQws
 ObnvvM8HfiTxOSDG2cgKtRdu38kPFAld02AvovkeyOfThGqknvlHcwCvNDWFyRlPX3oayHZFLXWlJ
 irQ283YPg==;
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if39x-0005iq-Ir
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 14:40:15 +0000
Received: by mail-pl1-x641.google.com with SMTP id bd4so1496189plb.8
 for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2019 06:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=IcdhyyyraLVUQAQ3HHOSQ6YNvDlkdwwrUN22Ki1UdWw=;
 b=RyG5UBz1cZHPGUqtMFB5YXFkkEdKKMiMwMxa8vnkNtXJSn70Zzja6yk3iTI/el/Ji7
 7mdXDBMNf7s4VWETE4BQOzat3pRp4cFbQRhjZmJDg1kzg1dpKHj7axOgJOv1it0xkTtv
 64qDc3ri9DQ3B9rGjNLH/xQ8bXwKOeK2yQtzcOL6fP1uiZBFCyaE/HbYfL64wN2sj/FP
 PXfUm8e3jVXPvOw7YquFCs42UtzcocoIDPdohQ/cW8UE9pEGu+OHFwa8hg2C+DL9l5p0
 qGq7WkaPaYNYdqhKGd+Ea8oh+Bst+ULZgi+wmIadHtyeeZnEDTEaNlXWHo4VcdmjIp+3
 ZtzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=IcdhyyyraLVUQAQ3HHOSQ6YNvDlkdwwrUN22Ki1UdWw=;
 b=bmgpE1M7zeWm8CgTBSIGz50GmYQxsdFNJXVyaiyvPUOrXwofLUvDOzuLbJAmdI2GXi
 /YxRpynw0rhwMLYuYTcww6WOT8XDRdlHWWkRUu2nciQEo9v/xUJmNhcMC3oKXzBpBj1X
 RL6Tf0GdvkZLDocMyTvl4Cgw3KcKNjSsWHiZ0402CEOOFYhyxuTnD03WPFx6W1NWcST7
 QUuotcA05KfuGspGCWU7L1mOJp1airhsyOzy5ZDNlu9Dc9+6CxSwBm35kgyNCtLeU0Sr
 bDwU9VNLRTyFW79QX2XXhDvpXUhXmIEWJb5z+pYXWWeotIKjDj6OryUUzm++T8QcP4Vd
 BByw==
X-Gm-Message-State: APjAAAVNq8Xhmeh7rSobizbZVRJvaWz+sQF0/WQso0a8F4z8YSh2N9Lq
 fVlfRqhbQ7ts3ND2PpkYxMCwB7d93+8=
X-Google-Smtp-Source: APXvYqxp6M46sXtPZT2HvGlWuv1Os2BTC76wIST3HLZF+6k8rsAvHXrRSJFlwIPCfdqDACr2l48xrw==
X-Received: by 2002:a17:902:968b:: with SMTP id
 n11mr3347664plp.120.1576075182587; 
 Wed, 11 Dec 2019 06:39:42 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 11 Dec 2019 06:39:41 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/12] wireless: iwlwifi: use <linux/units.h> helpers
Date: Wed, 11 Dec 2019 23:38:17 +0900
Message-Id: <1576075099-3441-11-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_144013_647291_133CCD7E 
X-CRM114-Status: GOOD (  13.99  )
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
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
 Johannes Berg <johannes.berg@intel.com>,
 Intel Linux Wireless <linuxwifi@intel.com>,
 Akinobu Mita <akinobu.mita@gmail.com>, Luca Coelho <luciano.coelho@intel.com>,
 Kalle Valo <kvalo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This switches the iwlwifi driver to use celsius_to_kelvin() and
kelvin_to_celsius() in <linux/units.h>.

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Cc: Luca Coelho <luciano.coelho@intel.com>
Cc: Intel Linux Wireless <linuxwifi@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* New patch from v3

 drivers/net/wireless/intel/iwlwifi/dvm/dev.h     | 5 -----
 drivers/net/wireless/intel/iwlwifi/dvm/devices.c | 6 ++++--
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
index be5ef4c..8d83800 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/dev.h
@@ -237,11 +237,6 @@ struct iwl_sensitivity_ranges {
 	u16 nrg_th_cca;
 };
 
-
-#define KELVIN_TO_CELSIUS(x) ((x)-273)
-#define CELSIUS_TO_KELVIN(x) ((x)+273)
-
-
 /******************************************************************************
  *
  * Functions implemented in core module which are forward declared here
diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
index dc3f197..d42bc46 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/devices.c
@@ -10,6 +10,8 @@
  *
  *****************************************************************************/
 
+#include <linux/units.h>
+
 /*
  * DVM device-specific data & functions
  */
@@ -345,7 +347,7 @@ static s32 iwl_temp_calib_to_offset(struct iwl_priv *priv)
 static void iwl5150_set_ct_threshold(struct iwl_priv *priv)
 {
 	const s32 volt2temp_coef = IWL_5150_VOLTAGE_TO_TEMPERATURE_COEFF;
-	s32 threshold = (s32)CELSIUS_TO_KELVIN(CT_KILL_THRESHOLD_LEGACY) -
+	s32 threshold = (s32)celsius_to_kelvin(CT_KILL_THRESHOLD_LEGACY) -
 			iwl_temp_calib_to_offset(priv);
 
 	priv->hw_params.ct_kill_threshold = threshold * volt2temp_coef;
@@ -381,7 +383,7 @@ static void iwl5150_temperature(struct iwl_priv *priv)
 	vt = le32_to_cpu(priv->statistics.common.temperature);
 	vt = vt / IWL_5150_VOLTAGE_TO_TEMPERATURE_COEFF + offset;
 	/* now vt hold the temperature in Kelvin */
-	priv->temperature = KELVIN_TO_CELSIUS(vt);
+	priv->temperature = kelvin_to_celsius(vt);
 	iwl_tt_handler(priv);
 }
 
-- 
2.7.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
