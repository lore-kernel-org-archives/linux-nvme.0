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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE8AC43603
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 05:18:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E2A721D7E
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Dec 2019 05:18:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="fIoXvfgA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D81//jzp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E2A721D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=GZhX4nCCY1OE/YNGdphg5GbFjwmKMp/Wsj8T38Cfxxc=; b=fIoXvfgAORJeU58aigvVHnICbB
	sZPjea7B6AiOsjtqsT1zImz1HwVe2NlslA6pNTCiBiXS9B80+eqUChpokC2yaT52tqHcSOv/nCjA7
	XyX9G6opkXK0aMO+fW0xdMGguuKefLRIebO+dgnTk2Txlt3WX1arxzXfxvmhaOi3gNV4/IWj24v3K
	vARKZkXjLlWVePLXrW2VmKKMIPPDYtRWwn04KpWQO+03jYTGlFzTf9sjXnTG4ue43R3WItF5Lb5vE
	SOdYwDRHrwKBfhNq7nMLUK7g+o9mnIwE5/zQf9vr5FuX086otMk5lPmF6Wmrl7fe4sPZgnAUkfI9Z
	3s6Svi/w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1igMIo-00031Y-6i; Sun, 15 Dec 2019 05:18:46 +0000
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1igMHf-00028r-FT
 for linux-nvme@lists.infradead.org; Sun, 15 Dec 2019 05:17:57 +0000
Received: by mail-pg1-x541.google.com with SMTP id z124so1704489pgb.13
 for <linux-nvme@lists.infradead.org>; Sat, 14 Dec 2019 21:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=7AK/TlaexQptYohFbIUq4KsseUGVisXwtLl1qNBNNIk=;
 b=D81//jzpc2vjR9Hw1Wax/s98TMZnO0WTjxCpQd4gOBTR5Wohhaz2TIwEwns2odGc1G
 6dtjro67Y37h7nFo/p5998Vs4glqeZyplsBRJR6kVRmHcKXz2pcQVbk/10HqsrEtO8Ch
 YpQXvVbntOfa2ngfgW6aFR8RII72nUFGrRkn6B1Ga0U8YjP+H1FLpqRnwg4fZFOUKu+C
 EpcSKFf6f9m5QDojhaPHSVtYNU1etCLSQzRFvUu+WKqoU1rbDZNvVn7NH1FH8Iwk2ng2
 1xDjkvz1fR8SktIraMOjjS7dsAmbGjJKeMX5iLHXjnn5TCnP4UweLtrK9284v7foqOZs
 nnSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=7AK/TlaexQptYohFbIUq4KsseUGVisXwtLl1qNBNNIk=;
 b=cN1xcxByTkSgSv4QSdnjp92JPrCihLyJFB5XAjF+o5rdvA9kjf6+Pqj0Buucb/BFiS
 3xapbdUkTR1DnAt8xKhewkLxO8tPkeykf0vGVQrEB8M5qNB4BrwaH4Tf5FvjYabneuOA
 pfW+tR4isXaqA2BfOOcNuX75hbunlExzRpksWoBAkBZbVcRCrQZLfCEG6lmfBihM8JII
 GRcnsHAf5yG1tjxJiUoq7EDcyEDgFAwnx3neFeRQfb9f4bxYq+xk7gARPQCxT5b7c8BO
 HMc50DjZFVfeZSRJoesCqzI+1YDbq09CrXJpBTcAb+28p3PJjtMNg2/TCBAhqlOxg7GQ
 pAiw==
X-Gm-Message-State: APjAAAVrJsA3Y3LicZTYbWJZKxTOMTDpOM4tpPh+gttvcBdKd0L97f6A
 /Pr5ItLdMw+yJSwE/9bLE6QRrcZvzQY=
X-Google-Smtp-Source: APXvYqxBRv2wn/eiGSZO0EPNa37cbHfApIbzp5cD39XlP29sX6Ug2mD7Qmiq5o6dpS3hCLz8ic6akg==
X-Received: by 2002:a62:e215:: with SMTP id a21mr9141541pfi.208.1576387054256; 
 Sat, 14 Dec 2019 21:17:34 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id u10sm16596528pgg.41.2019.12.14.21.17.30
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sat, 14 Dec 2019 21:17:33 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org
Subject: [PATCH v4 09/12] iwlegacy: use <linux/units.h> helpers
Date: Sun, 15 Dec 2019 14:16:12 +0900
Message-Id: <1576386975-7941-10-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
References: <1576386975-7941-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191214_211735_613495_F98B8A87 
X-CRM114-Status: GOOD (  12.51  )
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
Cc: Stanislaw Gruszka <sgruszka@redhat.com>,
 Akinobu Mita <akinobu.mita@gmail.com>, Kalle Valo <kvalo@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This switches the iwlegacy driver to use celsius_to_kelvin() and
kelvin_to_celsius() in <linux/units.h>.

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: Stanislaw Gruszka <sgruszka@redhat.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Kalle Valo <kvalo@codeaurora.org>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* v4
- add Reviewed-by and Acked-by tags
- remove "wireless: " in the title

 drivers/net/wireless/intel/iwlegacy/4965-mac.c |  3 ++-
 drivers/net/wireless/intel/iwlegacy/4965.c     | 11 ++++++-----
 drivers/net/wireless/intel/iwlegacy/common.h   |  3 ---
 3 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlegacy/4965-mac.c b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
index 3664f56..d6766eb 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965-mac.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965-mac.c
@@ -27,6 +27,7 @@
 #include <linux/firmware.h>
 #include <linux/etherdevice.h>
 #include <linux/if_arp.h>
+#include <linux/units.h>
 
 #include <net/mac80211.h>
 
@@ -6467,7 +6468,7 @@ il4965_set_hw_params(struct il_priv *il)
 	il->hw_params.valid_rx_ant = il->cfg->valid_rx_ant;
 
 	il->hw_params.ct_kill_threshold =
-	   CELSIUS_TO_KELVIN(CT_KILL_THRESHOLD_LEGACY);
+	   celsius_to_kelvin(CT_KILL_THRESHOLD_LEGACY);
 
 	il->hw_params.sens = &il4965_sensitivity;
 	il->hw_params.beacon_time_tsf_bits = IL4965_EXT_BEACON_TIME_POS;
diff --git a/drivers/net/wireless/intel/iwlegacy/4965.c b/drivers/net/wireless/intel/iwlegacy/4965.c
index 32699b6..31b346c 100644
--- a/drivers/net/wireless/intel/iwlegacy/4965.c
+++ b/drivers/net/wireless/intel/iwlegacy/4965.c
@@ -17,6 +17,7 @@
 #include <linux/sched.h>
 #include <linux/skbuff.h>
 #include <linux/netdevice.h>
+#include <linux/units.h>
 #include <net/mac80211.h>
 #include <linux/etherdevice.h>
 #include <asm/unaligned.h>
@@ -1104,7 +1105,7 @@ il4965_fill_txpower_tbl(struct il_priv *il, u8 band, u16 channel, u8 is_ht40,
 	/* get current temperature (Celsius) */
 	current_temp = max(il->temperature, IL_TX_POWER_TEMPERATURE_MIN);
 	current_temp = min(il->temperature, IL_TX_POWER_TEMPERATURE_MAX);
-	current_temp = KELVIN_TO_CELSIUS(current_temp);
+	current_temp = kelvin_to_celsius(current_temp);
 
 	/* select thermal txpower adjustment params, based on channel group
 	 *   (same frequency group used for mimo txatten adjustment) */
@@ -1611,7 +1612,7 @@ il4965_hw_get_temperature(struct il_priv *il)
 	    (temperature * 97) / 100 + TEMPERATURE_CALIB_KELVIN_OFFSET;
 
 	D_TEMP("Calibrated temperature: %dK, %dC\n", temperature,
-	       KELVIN_TO_CELSIUS(temperature));
+	       kelvin_to_celsius(temperature));
 
 	return temperature;
 }
@@ -1671,11 +1672,11 @@ il4965_temperature_calib(struct il_priv *il)
 	if (il->temperature != temp) {
 		if (il->temperature)
 			D_TEMP("Temperature changed " "from %dC to %dC\n",
-			       KELVIN_TO_CELSIUS(il->temperature),
-			       KELVIN_TO_CELSIUS(temp));
+			       kelvin_to_celsius(il->temperature),
+			       kelvin_to_celsius(temp));
 		else
 			D_TEMP("Temperature " "initialized to %dC\n",
-			       KELVIN_TO_CELSIUS(temp));
+			       kelvin_to_celsius(temp));
 	}
 
 	il->temperature = temp;
diff --git a/drivers/net/wireless/intel/iwlegacy/common.h b/drivers/net/wireless/intel/iwlegacy/common.h
index e7fb8e6..bc9cd7e 100644
--- a/drivers/net/wireless/intel/iwlegacy/common.h
+++ b/drivers/net/wireless/intel/iwlegacy/common.h
@@ -779,9 +779,6 @@ struct il_sensitivity_ranges {
 	u16 nrg_th_cca;
 };
 
-#define KELVIN_TO_CELSIUS(x) ((x)-273)
-#define CELSIUS_TO_KELVIN(x) ((x)+273)
-
 /**
  * struct il_hw_params
  * @bcast_id: f/w broadcast station ID
-- 
2.7.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
