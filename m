Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792B3D5E367
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Nov 2024 12:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X10jEd65WK6ILSIIjlJKXZDA/6UE2ErD4j2jrg3d5WQ=; b=ISN2X0Aq21vDTafGKVQACaRDo0
	qwhqlxLNu8/4KuDnfTqweDfWEEP0huD46ld/IlfJnTZJIGJjPVKAHOnBxZZg8nnry1j3PLPdiVM6P
	8xV9fxdN8Zem9A9jtPYP3VZC8mXPeiuIql1viKm70b51c9Pycm4S3GQ4xAgfSZSeU9V5jyLBDnrP0
	wJehPbmQJoBWb7+RhyBxafeURZAt2l/zimXzisp/jy/RMqwkEmVweP80YmA2rzy4CFZeKTLFcsHpw
	cF67RcJumvVRfVNv9hoFUZ0LItPGaNGaRDTgHae5mR9KKkAdYjzVF98E1Su92XelIRn0VWWuptlfP
	BBhZvQRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9kRn-0000000DHop-3MfN;
	Sat, 09 Nov 2024 12:20:11 +0000
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9kRh-0000000DHoG-06D7
	for linux-nvme@lists.infradead.org;
	Sat, 09 Nov 2024 12:20:06 +0000
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-7d4f85766f0so2219019a12.2
        for <linux-nvme@lists.infradead.org>; Sat, 09 Nov 2024 04:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731154803; x=1731759603; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X10jEd65WK6ILSIIjlJKXZDA/6UE2ErD4j2jrg3d5WQ=;
        b=Ug8R3910Ecnhx2pmABIzsywCtoKbwiodJQquqFZF7EfMihE+5omIzJ/BsV5F9aA6oM
         /tCRbKWba7Qb7c2E+Pi+llc0x4JhQTmLoBJElafgv0RChP+UWea8Q+bch14qQ+R1s4/I
         wtjUGruCQmiMMetG4mBJG/zU14EzWcHg5+8sLDvRKE2ehGAyowxmmWogpA6XvcZR5ZRE
         ldKiOUadk2L+ssWvNhkF7J4dNYvn/JpVn661k8eIs+K2/rfucelG1tfL7FPYRlTqhRnU
         3EhBPKOKMOK/cSdu9MoVdMgD072T3G1/7d0HIXQzdZf0H56a6MXtz2lOMuaV87OIhTCT
         xRTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731154803; x=1731759603;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X10jEd65WK6ILSIIjlJKXZDA/6UE2ErD4j2jrg3d5WQ=;
        b=CH92HO7v6aGkQTzcyru1DAUkLbVpXIFFVLrAdnyvJXivlUAriWb5XwwLzUKB8ir2C0
         jf8lO03XFkpXQzVJ+gJys9LKtx20oCYVM1+UZRk3LnLmx8qiHvIFj+xc473waGLK8/Zj
         6B3YpvX/aXku8xWWGzGu2mY/9BKqld7v8vJWe9nQrgsasVratdXAYnpeeCDkp75KPY/V
         2u2cerAwlF07Vy+HO//MAqnA+UaOn9a+EaSY5OEe5NXxjb1+HvHYCOxXdwMZDWZ31BP6
         NC9/2JigIv5aDzp4RZuqbHTpTnv/ZoHjikz24sEKmqSd3AC2mI2zOlGeB2tUrcboZKtS
         YfDQ==
X-Gm-Message-State: AOJu0Ywa1tbDoJKrDXhhhxqT5kaOsF7hBzxcNRbeK0NdRsN8NGEKpEE8
	SQxQ86egdcZjuSTp1tI+KiuQFOT379+ry94k5PO37bgjTZk89emm7V90dA==
X-Google-Smtp-Source: AGHT+IE5YitckVAPPbvXG7cW1rg7eKlZUCNa9MU5Azh1tLEAez48zryA2ZNf3KZ5W2XAKTub3nE36g==
X-Received: by 2002:a17:90b:2642:b0:2e2:e4d3:3401 with SMTP id 98e67ed59e1d1-2e9b16ab979mr8333968a91.20.1731154803164;
        Sat, 09 Nov 2024 04:20:03 -0800 (PST)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:c1ce:644d:cdf6:d1b7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a541c95sm8004759a91.17.2024.11.09.04.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 04:20:02 -0800 (PST)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v2] nvme-hwmon: add temperature threshold hysteresis feature
Date: Sat,  9 Nov 2024 21:19:53 +0900
Message-ID: <20241109121958.6124-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241109_042005_094387_7A5BD614 
X-CRM114-Status: GOOD (  16.05  )
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

The definition TMPTHH field supported by NVMe 2.1.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
Changes since v1:
- Add hwmon temperature hysteresis sysfs files to use the hysteresis feature.

 drivers/nvme/host/core.c  |  1 +
 drivers/nvme/host/hwmon.c | 75 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h  |  1 +
 include/linux/nvme.h      |  7 +++-
 4 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b149b638453f..59608e65bc1c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3336,6 +3336,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->kas = le16_to_cpu(id->kas);
 	ctrl->max_namespaces = le32_to_cpu(id->mnan);
 	ctrl->ctratt = le32_to_cpu(id->ctratt);
+	ctrl->tmpthha = id->tmpthha;
 
 	ctrl->cntrltype = id->cntrltype;
 	ctrl->dctype = id->dctype;
diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 89a1a1043d63..86688a554f05 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -37,6 +37,33 @@ static int nvme_get_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
 	return 0;
 }
 
+static int nvme_get_temp_thresh_hyst(struct nvme_ctrl *ctrl, bool under,
+				     long *hyst)
+{
+	unsigned int threshold = 0;
+	u32 status;
+	int ret;
+
+	if (under)
+		threshold |= NVME_TEMP_THRESH_TYPE_UNDER;
+
+	ret = nvme_get_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL, 0,
+				&status);
+	if (ret > 0)
+		return -EIO;
+	if (ret < 0)
+		return ret;
+	*hyst =
+	    kelvin_to_millicelsius((status >> NVME_TEMP_THRESH_HYST_SHIFT) &
+				   NVME_TEMP_THRESH_HYST_MASK);
+	if (under)
+		*hyst += kelvin_to_millicelsius(status & NVME_TEMP_THRESH_MASK);
+	else
+		*hyst -= kelvin_to_millicelsius(status & NVME_TEMP_THRESH_MASK);
+
+	return 0;
+}
+
 static int nvme_set_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
 				long temp)
 {
@@ -57,6 +84,40 @@ static int nvme_set_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
 	return ret;
 }
 
+static int nvme_set_temp_thresh_hyst(struct nvme_ctrl *ctrl, bool under,
+				     long hyst)
+{
+	unsigned int hysteresis = 0;
+	u32 status;
+	int ret;
+
+	if (under)
+		hysteresis |= NVME_TEMP_THRESH_TYPE_UNDER;
+
+	ret = nvme_get_features(ctrl, NVME_FEAT_TEMP_THRESH, hysteresis, NULL,
+				0, &status);
+	if (ret > 0)
+		return -EIO;
+	if (ret < 0)
+		return ret;
+
+	hyst = millicelsius_to_kelvin(hyst);
+	hysteresis = clamp_val(hyst, 0, NVME_TEMP_THRESH_HYST_MASK);
+	hysteresis <<= NVME_TEMP_THRESH_HYST_SHIFT;
+
+	hysteresis |= status & NVME_TEMP_THRESH_MASK;
+
+	if (under)
+		hysteresis |= NVME_TEMP_THRESH_TYPE_UNDER;
+
+	ret = nvme_set_features(ctrl, NVME_FEAT_TEMP_THRESH, hysteresis, NULL,
+				0, NULL);
+	if (ret > 0)
+		return -EIO;
+
+	return ret;
+}
+
 static int nvme_hwmon_get_smart_log(struct nvme_hwmon_data *data)
 {
 	return nvme_get_log(data->ctrl, NVME_NSID_ALL, NVME_LOG_SMART, 0,
@@ -83,6 +144,10 @@ static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_temp_crit:
 		*val = kelvin_to_millicelsius(data->ctrl->cctemp);
 		return 0;
+	case hwmon_temp_max_hyst:
+		return nvme_get_temp_thresh_hyst(data->ctrl, false, val);
+	case hwmon_temp_min_hyst:
+		return nvme_get_temp_thresh_hyst(data->ctrl, true, val);
 	default:
 		break;
 	}
@@ -122,6 +187,10 @@ static int nvme_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
 		return nvme_set_temp_thresh(data->ctrl, channel, false, val);
 	case hwmon_temp_min:
 		return nvme_set_temp_thresh(data->ctrl, channel, true, val);
+	case hwmon_temp_max_hyst:
+		return nvme_set_temp_thresh_hyst(data->ctrl, false, val);
+	case hwmon_temp_min_hyst:
+		return nvme_set_temp_thresh_hyst(data->ctrl, true, val);
 	default:
 		break;
 	}
@@ -160,6 +229,12 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 		if (!channel && data->ctrl->cctemp)
 			return 0444;
 		break;
+	case hwmon_temp_max_hyst:
+	case hwmon_temp_min_hyst:
+		if (channel ||
+		    !(data->ctrl->tmpthha & NVME_CTRL_TMPTHHA_TMPTHMH_MASK))
+			break;
+		fallthrough;
 	case hwmon_temp_max:
 	case hwmon_temp_min:
 		if ((!channel && data->ctrl->wctemp) ||
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 093cb423f536..4824946abca3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -339,6 +339,7 @@ struct nvme_ctrl {
 	u32 oaes;
 	u32 aen_result;
 	u32 ctratt;
+	u8 tmpthha;
 	unsigned int shutdown_timeout;
 	unsigned int kato;
 	bool subsystem;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b58d9405d65e..d2bf61f7080a 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -332,7 +332,9 @@ struct nvme_id_ctrl {
 	__u8			anacap;
 	__le32			anagrpmax;
 	__le32			nanagrpid;
-	__u8			rsvd352[160];
+	__u8			rsvd352[32];
+	__u8			tmpthha;
+	__u8			rsvd385[127];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;
@@ -388,6 +390,7 @@ enum {
 	NVME_CTRL_CTRATT_PREDICTABLE_LAT	= 1 << 5,
 	NVME_CTRL_CTRATT_NAMESPACE_GRANULARITY	= 1 << 7,
 	NVME_CTRL_CTRATT_UUID_LIST		= 1 << 9,
+	NVME_CTRL_TMPTHHA_TMPTHMH_MASK		= 7,
 };
 
 struct nvme_lbaf {
@@ -1121,6 +1124,8 @@ enum {
 	NVME_TEMP_THRESH_MASK		= 0xffff,
 	NVME_TEMP_THRESH_SELECT_SHIFT	= 16,
 	NVME_TEMP_THRESH_TYPE_UNDER	= 0x100000,
+	NVME_TEMP_THRESH_HYST_SHIFT	= 22,
+	NVME_TEMP_THRESH_HYST_MASK	= 0x7,
 };
 
 struct nvme_feat_auto_pst {
-- 
2.45.2


