Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1114C43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:41:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDAC920836
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 14:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TyJclvnA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtEhDw9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDAC920836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=aLU666sUZV+jOfpXq4v2ZdovugDNwGLfgNfgI2BiAtw=; b=TyJclvnAiaXvkfh6uFy2JjQD2Y
	UiJuF0seiXaYl00fEfTg+VWcWG1xDZoQ9bTn+/10VidkK82bbhEgm1X2BsuwK1LrLLVnvCRsJq9Y1
	3xt0aLVqGquWoMxMAA+v92ENQuzqjXNmnr+5bM+gEI3dVAM3OtClbHpwNvTQxbsLDmMdge3Hc4k/A
	I1UMkScJNBx7lnAkDhYxY7T7MBM7ce3BGmo6M7ZK+YiLAGG2yhFKdhdB7uEVNSP1ozNROJ92ocTL9
	mZdAkcevYHqXaYuD/LrhljQ0Mp4JAlGUR8hFUO3IOOtvZ54EFFxw0VfLZWcMo+h5GNYdGyH0Kfjsz
	kSmcyJtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1if3An-0000e1-R7; Wed, 11 Dec 2019 14:41:05 +0000
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if39U-0006ve-CM
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 14:39:59 +0000
Received: by mail-pj1-x1042.google.com with SMTP id v93so9017934pjb.6
 for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2019 06:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=K3UxPRzFZME10fkLXtCYqjJd0IRSW438IJ8inomPhFc=;
 b=TtEhDw9mXoygh60t0P8tM7vAJ0ws8yOzln/xfqEuvUZQ+gxs9TGtjoWk4ijx+7Lhgj
 m/RjMwumNojsGy04ahZTfQNCqOSGq61vGvkvIu6125xhrZqtF4UylwsJXCgFrAe2H8df
 FxtqiaZyqXH6Pfs4MpJadnetPyQHFsOXN2WR9XEJnxurlElV4LEZ/QiIMDuEjbKxq8bG
 Flftq8QdH5Afm2rmNfaA0N9ZNxJCmfCMXEmJ0kzufwBpTx8PtSQrTRzrVLUIqZszZh5e
 fuhvH5Y8abqa1VpwIVVuvvijRYmXugdPHrEsG6aKfZ8rC5OWbcD4s8FVIZ3GyErGjt9B
 a7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=K3UxPRzFZME10fkLXtCYqjJd0IRSW438IJ8inomPhFc=;
 b=UBVZi7t1zs4xNBNN1aiF9yqaBsAUmNoxBCCc0OjtB9FF5HsU4fYSC7yJ6asId4VzVM
 3rhPvCV2LIdR518MJlAVeR0Em+wobpWIStXDDCE9Fl1vsthn//z6H31dPapBxYXghUi2
 CxJkWLhQK6Q3TszoWEdLBlBtwOk+CR/hGqDPfQwRl/UrR/SChjXCfbYCghtc5fv1eGK/
 pidN0blvYE8xQxDYAy7lGfTUEikEBp6ZGywivyOnJVDiV6gIRVKSdtgU0vxY8GiK2k70
 kJU2InEK5St3iE5Qg2PhSQjwWVNeNFvenNpD9eHPRMCJhmNW7gJs5rGR/zULlu4SR2NZ
 B/GA==
X-Gm-Message-State: APjAAAWBhUK7ega3P25ZcRImbNikW7DFxXqThvTDnnwbNcDPu5w9cMBN
 vaoAaaDG7B2MXR50kDsPBkrYrF6m7rk=
X-Google-Smtp-Source: APXvYqwzmKMUAxLD4W5Ax2MVMn7w223/0E+Cw8F33tmd3OWRq8B/HavfEb1OCpln/HaQH8iOvd8Onw==
X-Received: by 2002:a17:90a:cf07:: with SMTP id
 h7mr3878015pju.66.1576075178437; 
 Wed, 11 Dec 2019 06:39:38 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id q11sm3444239pff.111.2019.12.11.06.39.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 11 Dec 2019 06:39:37 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/12] wireless: iwlegacy: use <linux/units.h> helpers
Date: Wed, 11 Dec 2019 23:38:16 +0900
Message-Id: <1576075099-3441-10-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
References: <1576075099-3441-1-git-send-email-akinobu.mita@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_063944_440196_CA707D5B 
X-CRM114-Status: GOOD (  12.86  )
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
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
* New patch from v3

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
