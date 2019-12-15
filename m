Return-Path: <SRS0=GgRz=2F=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E489C43603
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 05:38:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A52D22B48
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 05:38:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="u6t0/EZx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DqsKeoIM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erojmZQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A52D22B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=CAIXkap0c4GlHndSgsqbWQXTKCrEo/Teok+503Yzh8g=; b=u6t0/EZxXriLuxcwwmUYiR6dM+
	BnPgOV443sRfxyWmupChFPIjHhZZU5+PwxB61BlOzAuGbhKSl/jzwz8cy1zXrK0KhzUlj+uizN38T
	3JG9d7r1rHOoCherkql0KzzQQLSZ+hTzTVXTEI0TllcyVlkSY7gY1GeVI3oozSiykK11ZWs1vYPQy
	s8PyYWaBuzzJFdZ40LF9HqGxSCmzjUqnyeccEVyWSIHt653Jfio3saA9fxN6ygCq1u/PnoDTuzpBZ
	FKrZOSDHTWGopHYLfx3CSQTnD7Yz95qUBgH/OSBdAK7NeD9oIq2DtUa1m54+ybQGJe3aCAAcnh9yf
	Ls+MSICA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1igMby-0001hH-BI; Sun, 15 Dec 2019 05:38:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igMbx-0001fa-5P
 for linux-nvme@bombadil.infradead.org; Sun, 15 Dec 2019 05:38:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=References:In-Reply-To:Message-Id:Date:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=o0nAQcnsb+T5h9bhgeYIzbak+OeGPv1PHTKsTeCIoXY=; b=DqsKeoIMFHPqTYZ3yLQoMNPJb
 T3P8onOAeyrYED/uM3DDUv7RFW35b/AwB+BW8q8UhQtZt7GkfT0OuWsdCCny3QwOqt9GQLyhlw6Ga
 QqNqr9Un88J392iNwfsvYh2Fqxj4J/9uYT9qmpjJIhp5HxMX+OTI2Zf2DDwujkBe5eRQOZV0ss9iS
 uI+6JrbGG06Xl2f0o4Am4V96PIDM+cM2KNNKeVplAh2NgA7QdoK2qU0Ad0IcPrO8mlQnIaOBtP6uu
 c11jb7UYcuhvKqi5sfVUm4yG8Q0P5uRYw6zQhLYzUhyS3QDjsbqhUAblubQXAQ03XRUTrcgCmVOyh
 WCPAi/Liw==;
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igMID-0006OD-PC
 for linux-nvme@lists.infradead.org; Sun, 15 Dec 2019 05:18:14 +0000
Received: by mail-pf1-x443.google.com with SMTP id s18so3759244pfd.8
 for <linux-nvme@lists.infradead.org>; Sat, 14 Dec 2019 21:17:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=o0nAQcnsb+T5h9bhgeYIzbak+OeGPv1PHTKsTeCIoXY=;
 b=erojmZQu2yIt3sG10pk8q7D162SAcRjxoBKbUaHuIhQ9qCS8Ovsrir9CSC6ymhCozZ
 FqJbFyL+b7YifQFa/0j7JxpknZq8Q2X9TeL1mjAJCnQEZo0ZaUgUDC3SmpcLnC97qrcz
 6+zdTV3ejXQXKXZW4bWUv3pwgL4xdnBcdl4GiSkW2HOo6e+sUTG07tQiiOZOVyEKlvGZ
 8LWNoxfJfejbBmxVEhjyX3vtC9aLJQopm1lxsyysNlSrJnFGkIcEn/CigYEybtUr7B++
 WTxENH/IzJk+aDB4t8OozPOkKfLmn3HRsMt9cVmg1exjUHP4KQqCK1sXC5J6ExTdjFWA
 aPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=o0nAQcnsb+T5h9bhgeYIzbak+OeGPv1PHTKsTeCIoXY=;
 b=rkjXRAnHrH7jM9ZW2kU8qsyEEpBXp/Bijh2FTWLbSMG5eMeOzhg4tjOzk3/dDtwri2
 VFdhof5Io9T+7GqL4L0dYhz1E96lObyXQk9ryJFvrtTnnPwqcPt05ZipdHMcgidQUEDq
 DXfpYqxK0v7D1fBCio7N8iDRdKojKSPEBSOT4/VdYwQv5ro5t4FmAISelJF9s61uOs1e
 F1DqPtO4fe7q01jdDN2JkyGAJdsrU7BXqD7K11PETE8iCHpJSZJ+5P5z9lZiEBefWKCj
 UB07QiiZqsZ8O1OTo6UvldtwTO93PWquqIvijW3f/OZemxQ+hhLK6hk3gj0/aNn+gZS9
 sk+Q==
X-Gm-Message-State: APjAAAVeSAcJCjH0zCMEIE7AjtS8Tpa5Ll6kJGdQGq/k0v8f8yyItShh
 jqT1lShwVQ/UrGMTbxBfB1s9lXplcxo=
X-Google-Smtp-Source: APXvYqxoUa7OEVWIs7gSylEoHGyOHkaN4si8hTmYB1eDQDWpbT6CBXJiWnAxrimODPovU2iUuCMwpg==
X-Received: by 2002:a63:7705:: with SMTP id s5mr9996843pgc.379.1576387058498; 
 Sat, 14 Dec 2019 21:17:38 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.17.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 14 Dec 2019 21:17:37 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
Subject: [PATCH v4 10/12] iwlwifi: use <linux/units.h> helpers
Date: Sun, 15 Dec 2019 14:16:13 +0900
Message-Id: <1576386975-7941-11-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191215_051809_930335_8EB446D7 
X-CRM114-Status: GOOD (  13.72  )
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
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v4
- add Reviewed-by and Acked-by tags
- remove "wireless: " in the title

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
