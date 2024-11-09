Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAC5D5E36C
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Nov 2024 13:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cbGb0CVicw3cnqULX+M62hr9ELyeSELBYC1ltxU6TxA=; b=coPr7l+Wrg/V5iRoIYVLXdrEZP
	oY6Il2iJAasyKv7gjdBRyzcPVhOFcMn8BzRyKV0At2oDFx88MxemkQu66YGCBO79Dh+ijSDJH0qiI
	umW0OLs2PRk0jBVWhfGOeRf18xNLSal/9Kz6gi4PBZ9MXUTGroHn4ylI9v2oEf2XDEsFX3GazuF5u
	7s0HxAOa5mekwak/iohNBPhOvldccMfuAlNQQtCZms0YzUhfjnpgnomjh9N3U+IojRXzWKhpO93e2
	qeGZZV/TbC3MpZKPQvXQkA1/g36OuZqr4b2tCh1aX0bTQDX9D1aRtPfA+O70z+ZyEhfzxDlLP4GJh
	0orvxYlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9lao-0000000DPFt-3oxp;
	Sat, 09 Nov 2024 13:33:34 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9lal-0000000DPFP-3Owv
	for linux-nvme@lists.infradead.org;
	Sat, 09 Nov 2024 13:33:33 +0000
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-723f37dd76cso3280043b3a.0
        for <linux-nvme@lists.infradead.org>; Sat, 09 Nov 2024 05:33:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731159211; x=1731764011; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cbGb0CVicw3cnqULX+M62hr9ELyeSELBYC1ltxU6TxA=;
        b=Ti8o6yG7Ttki6byRYBAGbmfPoyxrfjZ31XrjnUxIC0ggiDSz4N4Pz0wEkTarfmH1XM
         8dInGtbhYt/nbn9ed1UUwWAw/z1wKGXcsA8s3+NWx/VXCiERWVoFR/fypKp5CTrtqc7u
         gvCsrZ1CU4lc0SjtZZbtrNtOKf0LGzieyol38FM14ZxpR8t/eeQN5wilr0O6iA14y29y
         +AVVRL+SituJIuxxsSKik/cQg8hHxEbrubR3jNCy7M9OHO1RNw/FEyeZ4nPaIgBHZnZD
         Xg0quV6bdrkx9UJ8oJkbWx6+N+WG+WUFfFgEFVm16P5+G1IFT0bHF56iGOU6HF9tsZ4k
         mnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731159211; x=1731764011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbGb0CVicw3cnqULX+M62hr9ELyeSELBYC1ltxU6TxA=;
        b=QcIg/FYtIQIepaDXrM/20vDJiEgf7xDfYzemlCwa13xzlJpBPFW9u/jDwhW2VAuZhq
         ODEQ3D15fS9LSHvhWp2b2aCbIiDvnXZXwQ6JTUEllLIsHs35kbE0hxlge2yBFPreGtzd
         ZQM6dOnSfuivAjCb+jW6q5n66lrwnyCIUPuQPS9JuwLlZ27hpYzwf6yDMik8Spk2U4M3
         tRrqZmbgXmFpJ0nmvZljx239rIj+BvELrHqHP7C4T8p8xmHGYDc/sHHWcMGC8U03XmWO
         y4CLDYJAcg/ar5jpUPk3O/A2Jj3wY8twCyK18zf3Nt0aDlNcoXu0EGYZg5CnVePDF2/a
         veIA==
X-Gm-Message-State: AOJu0YwxpHHiZsMoKlGLFt5MILu29UanQhU9Raj7wKXUR0lk0wTFYUu+
	a4kUMYaTRSg8qx20xpx2a5edDQOWVVITMGSnzL5FkJdS2CymWcR9PpXyeQ==
X-Google-Smtp-Source: AGHT+IFKgH1V6gEJ9ckjX3pTLS8XplBD3ArvBUPX9GOZduxF2u2W88AOtTuKhJVh1cQGRcTGfKk89w==
X-Received: by 2002:a05:6a21:32a3:b0:1db:dd9e:43af with SMTP id adf61e73a8af0-1dc22b58121mr8075575637.34.1731159210716;
        Sat, 09 Nov 2024 05:33:30 -0800 (PST)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:c1ce:644d:cdf6:d1b7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a8a6asm5538713b3a.76.2024.11.09.05.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 05:33:30 -0800 (PST)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH v3] nvme-hwmon: add temperature threshold hysteresis feature
Date: Sat,  9 Nov 2024 22:33:21 +0900
Message-ID: <20241109133325.12174-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241109_053331_876477_37384C2A 
X-CRM114-Status: GOOD (  16.55  )
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
 drivers/nvme/host/core.c  |  1 +
 drivers/nvme/host/hwmon.c | 87 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h  |  1 +
 include/linux/nvme.h      |  7 +++-
 4 files changed, 95 insertions(+), 1 deletion(-)

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
index 89a1a1043d63..4f210787824e 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -37,6 +37,37 @@ static int nvme_get_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
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
+	/*
+	 * Must be reported as an absolute temperature, NOT a delta from the max
+	 * or min value.
+	 */
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
@@ -57,6 +88,48 @@ static int nvme_set_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
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
+	/*
+	 * Must be reported as an absolute temperature, NOT a delta from the max
+	 * or min value.
+	 */
+	if (under)
+		hyst -= status & NVME_TEMP_THRESH_MASK;
+	else
+		hyst = (status & NVME_TEMP_THRESH_MASK) - hyst;
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
@@ -83,6 +156,10 @@ static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
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
@@ -122,6 +199,10 @@ static int nvme_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
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
@@ -160,6 +241,12 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
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


