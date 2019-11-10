Return-Path: <SRS0=U9tF=ZC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 832FDC43331
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2019 14:18:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF37214E0
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2019 14:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="epX+ycxa";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pcCHW+Xj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF37214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=xjt6yG//UNMXHGsXxTw1iMvRA/RbIbogPJvI8Ojywn8=; b=epX
	+ycxa2CndlDfQ6BJMti0BOtfVa4BHg5v4tmHNfqipSqe4M4YuqJt85gTRi4MHZ7vS3g31AdKSag7n
	p7CbaeOp13hGW4m37ZwseCh/apEJV4APqJZxqJEecWRcD7e1FScrVhWCkdo1jALiCkRPhMMYdNLK3
	U0M+pobOYSkDNLHWp013uGRvJ6vrfEAlNypxFsHs3JIryxfVd7T/EQ8v7aN9kHsoIU8U5/XLKCTzH
	b4LRpf6oYhpFGM5XlTON2vJDsMi09riZ9+W/rVjTWbGykQvMF3eVk3QHqkJvAtYWccB/XjUrLy6gw
	7Y9vLw0jN5zPYzE94CieU0zXTTFO1mg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iTo2e-0005MK-Vl; Sun, 10 Nov 2019 14:18:12 +0000
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iTo2b-0005KJ-EJ
 for linux-nvme@lists.infradead.org; Sun, 10 Nov 2019 14:18:11 +0000
Received: by mail-pl1-x641.google.com with SMTP id d29so6510826plj.8
 for <linux-nvme@lists.infradead.org>; Sun, 10 Nov 2019 06:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=56oOc1o5bBJYxyuKfO925aa4uXU941JiLicanGKQoak=;
 b=pcCHW+XjiLsSOFFtyt7KnbTPpnLPgPBU7l9nPi+1yXMbERnVFINFCpP0WIWsc5aWKX
 aEdrsacwnV5Ky1oY3bSK6ABDIIryjomBNF9oJVhdjT1Rrc1DUL+TmNP6+hM+0Lctueoy
 O/+f0i24E8XVw1TSbvUPKXLfSPw6VrTdJLX2mxNmfCfxFpD8Suo39cCdVEvKz53n5RMF
 KMUjOCInExNaF2vS3fTNIk8N3RGxMhG6w4Z3tfUnhpKPACTWpPhPUPGY8PGT/PFdnFV1
 hEP8eomaJnLwdexuv4c7PdcleO+7OWuw6Dg2Gzh2toCiGNCG0REFWfLTFmOfPkBronk3
 PhiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=56oOc1o5bBJYxyuKfO925aa4uXU941JiLicanGKQoak=;
 b=cttf4/taIWYPZmQyXY7OrZfgP+CAtG2IXsfjxX8cMOvyMSAn7ZLBz/uHtPrpjAAdTE
 n8Apphpmz33EpMVOQFvmFfhZyFvIsaRdKTeXXQseYE2+Nv66Hk4O54guMURM0CpMDF4T
 N8Ccndv10HiUXn/HDqOi4vyBCaQF/dbu0/+NHSGcaZOYaj7HEk0C9jtLAXU5ERSjBnOo
 DaKmNbU7yQazjmQjrYwtuN2zp9HYRBjTisz5+eYHMzFEidkxsZKj6wUM7yoBEknre5xy
 PU9wvKPBT3d20R1VuwH40S8T5dZwvamdjXwwa0YouRU1++N4i4ibVJk//kuJDP6gTLce
 cS5Q==
X-Gm-Message-State: APjAAAVlbMT7VJYOit2muqbxjIsl08Y0ncgjrZCu1eg4gacI4zwWVF2J
 zaqbkIfrBz3fyY9PiN5bgqWGtf65
X-Google-Smtp-Source: APXvYqyt6yKEiiKM7l7Eb6oL8y+rCt/S6h4Kzyt/e5DVmtkuZBhXbDomEbmFWe+mhhdb/oXY/WTNPg==
X-Received: by 2002:a17:902:d717:: with SMTP id
 w23mr3146303ply.142.1573395487415; 
 Sun, 10 Nov 2019 06:18:07 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:368e:e048:68f1:84e7])
 by smtp.gmail.com with ESMTPSA id c13sm12213253pfo.5.2019.11.10.06.18.03
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Sun, 10 Nov 2019 06:18:06 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org,
	linux-hwmon@vger.kernel.org
Subject: [PATCH] nvme: hwmon: provide temperature min and max values for each
 sensor
Date: Sun, 10 Nov 2019 23:17:46 +0900
Message-Id: <1573395466-19526-1-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.7.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191110_061809_504012_80356A7B 
X-CRM114-Status: GOOD (  18.98  )
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
Cc: Jean Delvare <jdelvare@suse.com>, Sagi Grimberg <sagi@grimberg.me>,
 Akinobu Mita <akinobu.mita@gmail.com>, Jens Axboe <axboe@fb.com>,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

According to the NVMe specification, the over temperature threshold and
under temperature threshold features shall be implemented for Composite
Temperature if a non-zero WCTEMP field value is reported in the Identify
Controller data structure.  The features are also implemented for all
implemented temperature sensors (i.e., all Temperature Sensor fields that
report a non-zero value).

This provides the over temperature threshold and under temperature
threshold for each sensor as temperature min and max values of hwmon
sysfs attributes.

The WCTEMP is already provided as a temperature max value for Composite
Temperature, but this change isn't incompatible.  Because the default
value of the over temperature threshold for Composite Temperature is
the WCTEMP.

This also provides alarm attributes for each temperature sensor.  But all
alarm conditions are same, because there is only a single bit in
Critical Warning field that indicates one of the temperature is outside of
a temperature threshold.

Example output from the "sensors" command:

nvme-pci-0100
Adapter: PCI adapter
Composite:    +53.0 C  (low  = -273.0 C, high = +70.0 C)
                       (crit = +80.0 C)
Sensor 1:     +56.0 C  (low  = -273.0 C, high = +65262.0 C)
Sensor 2:     +51.0 C  (low  = -273.0 C, high = +65262.0 C)
Sensor 5:     +73.0 C  (low  = -273.0 C, high = +65262.0 C)

Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
This patch depends on the patch "nvme: Add hardware monitoring support" [1]
[1] http://lists.infradead.org/pipermail/linux-nvme/2019-November/027883.html

 drivers/nvme/host/nvme-hwmon.c | 98 ++++++++++++++++++++++++++++++++++++------
 include/linux/nvme.h           |  6 +++
 2 files changed, 90 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/nvme-hwmon.c b/drivers/nvme/host/nvme-hwmon.c
index 5480cbb..79323b2 100644
--- a/drivers/nvme/host/nvme-hwmon.c
+++ b/drivers/nvme/host/nvme-hwmon.c
@@ -15,6 +15,46 @@ struct nvme_hwmon_data {
 	struct mutex read_lock;
 };
 
+static int nvme_get_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
+				long *temp)
+{
+	unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
+	int status;
+	int ret;
+
+	if (under)
+		threshold |= NVME_TEMP_THRESH_TYPE_UNDER;
+
+	ret = nvme_get_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL, 0,
+				&status);
+	if (!ret)
+		*temp = ((status & NVME_TEMP_THRESH_MASK) - 273) * 1000;
+
+	return ret <= 0 ? ret : -EIO;
+}
+
+static int nvme_set_temp_thresh(struct nvme_ctrl *ctrl, int sensor, bool under,
+				long temp)
+{
+	unsigned int threshold = sensor << NVME_TEMP_THRESH_SELECT_SHIFT;
+	int status;
+	int ret;
+
+	temp = temp / 1000 + 273;
+	if (temp > NVME_TEMP_THRESH_MASK)
+		return -EINVAL;
+
+	threshold |= temp;
+
+	if (under)
+		threshold |= NVME_TEMP_THRESH_TYPE_UNDER;
+
+	ret = nvme_set_features(ctrl, NVME_FEAT_TEMP_THRESH, threshold, NULL, 0,
+				&status);
+
+	return ret <= 0 ? ret : -EIO;
+}
+
 static int nvme_hwmon_get_smart_log(struct nvme_hwmon_data *data)
 {
 	int ret;
@@ -39,8 +79,12 @@ static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	 */
 	switch (attr) {
 	case hwmon_temp_max:
-		*val = (data->ctrl->wctemp - 273) * 1000;
+		err = nvme_get_temp_thresh(data->ctrl, channel, false, val);
+		if (err)
+			*val = (data->ctrl->wctemp - 273) * 1000;
 		return 0;
+	case hwmon_temp_min:
+		return nvme_get_temp_thresh(data->ctrl, channel, true, val);
 	case hwmon_temp_crit:
 		*val = (data->ctrl->cctemp - 273) * 1000;
 		return 0;
@@ -73,6 +117,23 @@ static int nvme_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 	return err;
 }
 
+static int nvme_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
+			    u32 attr, int channel, long val)
+{
+	struct nvme_hwmon_data *data = dev_get_drvdata(dev);
+
+	switch (attr) {
+	case hwmon_temp_max:
+		return nvme_set_temp_thresh(data->ctrl, channel, false, val);
+	case hwmon_temp_min:
+		return nvme_set_temp_thresh(data->ctrl, channel, true, val);
+	default:
+		break;
+	}
+
+	return -EOPNOTSUPP;
+}
+
 static const char * const nvme_hwmon_sensor_names[] = {
 	"Composite",
 	"Sensor 1",
@@ -105,13 +166,13 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 			return 0444;
 		break;
 	case hwmon_temp_max:
+	case hwmon_temp_min:
 		if (!channel && data->ctrl->wctemp)
-			return 0444;
+			return 0644;
+		else if (data->log.temp_sensor[channel - 1])
+			return 0644;
 		break;
 	case hwmon_temp_alarm:
-		if (!channel)
-			return 0444;
-		break;
 	case hwmon_temp_input:
 	case hwmon_temp_label:
 		if (!channel || data->log.temp_sensor[channel - 1])
@@ -126,16 +187,24 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 static const struct hwmon_channel_info *nvme_hwmon_info[] = {
 	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
 	HWMON_CHANNEL_INFO(temp,
-			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_CRIT |
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
+				HWMON_T_CRIT | HWMON_T_LABEL | HWMON_T_ALARM,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
+				HWMON_T_LABEL | HWMON_T_ALARM,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
+				HWMON_T_LABEL | HWMON_T_ALARM,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
+				HWMON_T_LABEL | HWMON_T_ALARM,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
+				HWMON_T_LABEL | HWMON_T_ALARM,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
+				HWMON_T_LABEL | HWMON_T_ALARM,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
+				HWMON_T_LABEL | HWMON_T_ALARM,
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
 				HWMON_T_LABEL | HWMON_T_ALARM,
-			   HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_LABEL,
-			   HWMON_T_INPUT | HWMON_T_LABEL),
+			   HWMON_T_INPUT | HWMON_T_MAX | HWMON_T_MIN |
+				HWMON_T_LABEL | HWMON_T_ALARM),
 	NULL
 };
 
@@ -143,6 +212,7 @@ static const struct hwmon_ops nvme_hwmon_ops = {
 	.is_visible	= nvme_hwmon_is_visible,
 	.read		= nvme_hwmon_read,
 	.read_string	= nvme_hwmon_read_string,
+	.write		= nvme_hwmon_write,
 };
 
 static const struct hwmon_chip_info nvme_hwmon_chip_info = {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 269b2e8..347a44f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -803,6 +803,12 @@ struct nvme_write_zeroes_cmd {
 
 /* Features */
 
+enum {
+	NVME_TEMP_THRESH_MASK		= 0xffff,
+	NVME_TEMP_THRESH_SELECT_SHIFT	= 16,
+	NVME_TEMP_THRESH_TYPE_UNDER	= 0x100000,
+};
+
 struct nvme_feat_auto_pst {
 	__le64 entries[32];
 };
-- 
2.7.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
