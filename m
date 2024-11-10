Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683EFD5E39D
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2024 06:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LVK8MQiSzv2hY2mB93eLEy77dY6UaB78XliFQefCIfM=; b=l8XCEmLZ4ezeM5Cr/EmZeXvRBb
	91wXU8a2dLALFNfcDrdiKHQGAkQ0xQvleSzbya43IaViz/gSfPS+b9V6l4EIYRJRDje+qJ7VVSr3M
	UPAca24p7fawUNBaB2LuFDNYlIQJV68uO1rSXwqHg0sQvbz6XNQRb/MSm7uEI0uUZ+j8WH40MdERO
	thgU+xilNyFzh1/Hsx5lD3IaY077f4JmM614R8ULQIah/+FjwZM7QvkceJIVURdFB1/A4OZjz1cOM
	Ijtft+7QXLGZoZyuSi76FDq4L3n0A5iF1zeu+clGXTUSOeA2z05QFrenlCCdIt0yPoKwan2gWxYg3
	QNEZxcEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tA1VV-0000000ERqX-3tJj;
	Sun, 10 Nov 2024 06:33:09 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tA1VT-0000000ERqC-2igm
	for linux-nvme@lists.infradead.org;
	Sun, 10 Nov 2024 06:33:08 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-20e6981ca77so40597855ad.2
        for <linux-nvme@lists.infradead.org>; Sat, 09 Nov 2024 22:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731220386; x=1731825186; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LVK8MQiSzv2hY2mB93eLEy77dY6UaB78XliFQefCIfM=;
        b=IlZPXYOcSovMviFNuRIHMgHdZ/sIoCGT1xyuaXtHgpcQKGpVV94QA4/bSWa1+z9mB1
         SWdXeUeI3ViEpJapgFz1M+YZTeS4Y+gSuf3gQ4bhwCh9VK0s8UdWW2RnSTBsF85ULnk9
         Qs9PQ7o1cMuRsRyRxF7u33G3OUfb8+EWeOnp71j4k5eejN2MTKx4ek+xbI9MHaYhqVxi
         y49mXwiqCf363orJbXRAfqk4k5w2Fi8goC0y9CVZY3LVHPbSlT185o0FtZxPtL+7SpR2
         Yt8WBJ5RFPArYEh2T4d/4dVGjA7RgVHLtp/PuZo6NikhnT9iONeLIv4MT4W2VxSAE8Dx
         I13w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731220386; x=1731825186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LVK8MQiSzv2hY2mB93eLEy77dY6UaB78XliFQefCIfM=;
        b=YDiUmCbTGinpQ+rQh19AgNhM2l+6i2fRh1CuVeQyvL7PbPMktG76utcZyJUu3tbOPs
         pwxpDB94sbX3X8B/1yJUOCQO5Xjk6vrGr8spE76meDnkDPDReyxeXciWgBWiyht37Itt
         tVx3wU1Y4AK+v7WAPeeHwoyc703WlcMgSmPot9oS2JyXRXa76AfTcRJNrJCnvPBmuG5Y
         8YKINxRlI8PyKK+2t9dWc31zerHsmttTvgmtRlbiYwUTgl61IsdM3GtSjRUJZYE9O8nZ
         5x/GFIu1QWBihj3AuNbsAzhdVGfr+PRyuC4Ub7vk5D1lUZOH/D4ijmPB6zahKdiBRt76
         CC4g==
X-Gm-Message-State: AOJu0Yy7WwsxwlUDouOT42S07j5H8/naUniqv46zlUcpQcTMC0nk2IHH
	ddMSoQYZMsvqeX96nKxaZK5ND4ztEMSdnxUu8YIkqa7GIIWD7uXOuDJ7YQ==
X-Google-Smtp-Source: AGHT+IHSrQxka6arpSEqBb9amrvTZkBgJr+6+QKy0aIXUrbm+fOCeRaI1FEp88kN/aFcJwZZZy5wgw==
X-Received: by 2002:a17:902:ec87:b0:20c:70ab:b9c3 with SMTP id d9443c01a7336-2118356b46bmr128101745ad.34.1731220386476;
        Sat, 09 Nov 2024 22:33:06 -0800 (PST)
Received: from tokunori-desktop.flets-east.jp ([240b:10:2720:5500:38cb:be4c:c1d9:adb8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc9068sm54665395ad.2.2024.11.09.22.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 22:33:06 -0800 (PST)
From: Tokunori Ikegami <ikegami.t@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Tokunori Ikegami <ikegami.t@gmail.com>
Subject: [PATCH] nvme-sysfs: add tmt1 and tmt2 attributes
Date: Sun, 10 Nov 2024 15:32:52 +0900
Message-ID: <20241110063300.6272-1-ikegami.t@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241109_223307_709597_D6C8829C 
X-CRM114-Status: GOOD (  13.64  )
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

The throttling temperature feature not supported by hwmon.
So add temperature feature values as sysfs attributes.

Signed-off-by: Tokunori Ikegami <ikegami.t@gmail.com>
---
 drivers/nvme/host/sysfs.c | 90 +++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h      |  5 +++
 2 files changed, 95 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index b68a9e5f1ea3..d376b51e67b3 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/nvme-auth.h>
+#include <linux/units.h>
 
 #include "nvme.h"
 #include "fabrics.h"
@@ -664,6 +665,93 @@ static DEVICE_ATTR(dhchap_ctrl_secret, S_IRUGO | S_IWUSR,
 	nvme_ctrl_dhchap_ctrl_secret_show, nvme_ctrl_dhchap_ctrl_secret_store);
 #endif
 
+static ssize_t nvme_ctrl_tmt_show(struct device *dev, bool tmt2,
+				  struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	int ret;
+	u32 status;
+	long val;
+
+	ret = nvme_get_features(ctrl, NVME_FEAT_HCTM, 0, NULL, 0, &status);
+	if (ret)
+		return sysfs_emit(buf, "error\n");
+
+	if (tmt2)
+		val = status & NVME_HCTM_TMT_MASK;
+	else
+		val = status >> NVME_HCTM_TMT1_SHIFT;
+	if (!val)
+		return sysfs_emit(buf, "off\n");
+
+	return sysfs_emit(buf, "%ld\n", kelvin_to_millicelsius(val));
+}
+
+static ssize_t nvme_ctrl_tmt_store(struct device *dev,
+				   struct device_attribute *attr, bool tmt2,
+				   const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned int v = 0;
+	int err;
+	int ret;
+	u32 status;
+
+	err = kstrtou32(buf, 10, &v);
+	if (err)
+		return err;
+
+	if (tmt2)
+		v <<= NVME_HCTM_TMT1_SHIFT;
+
+	ret = nvme_get_features(ctrl, NVME_FEAT_HCTM, 0, NULL, 0, &status);
+	if (ret > 0)
+		return -EIO;
+	if (ret < 0)
+		return ret;
+
+	if (tmt2)
+		v |= status << NVME_HCTM_TMT1_SHIFT;
+	else
+		v |= status & NVME_HCTM_TMT_MASK;
+
+	ret = nvme_set_features(ctrl, NVME_FEAT_HCTM, v, NULL, 0, NULL);
+	if (ret > 0)
+		return -EIO;
+
+	return count;
+}
+
+static ssize_t nvme_ctrl_tmt1_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return nvme_ctrl_tmt_show(dev, false, attr, buf);
+}
+
+static ssize_t nvme_ctrl_tmt1_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	return nvme_ctrl_tmt_store(dev, attr, false, buf, count);
+}
+static DEVICE_ATTR(tmt1, S_IRUGO | S_IWUSR, nvme_ctrl_tmt1_show,
+		   nvme_ctrl_tmt1_store);
+
+static ssize_t nvme_ctrl_tmt2_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return nvme_ctrl_tmt_show(dev, true, attr, buf);
+}
+
+static ssize_t nvme_ctrl_tmt2_store(struct device *dev,
+				    struct device_attribute *attr,
+				    const char *buf, size_t count)
+{
+	return nvme_ctrl_tmt_store(dev, attr, true, buf, count);
+}
+static DEVICE_ATTR(tmt2, S_IRUGO | S_IWUSR, nvme_ctrl_tmt2_show,
+		   nvme_ctrl_tmt2_store);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -692,6 +780,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_dhchap_ctrl_secret.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
+	&dev_attr_tmt1.attr,
+	&dev_attr_tmt2.attr,
 	NULL
 };
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b58d9405d65e..89db23b57e6d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1144,6 +1144,11 @@ enum {
 	NVME_ENABLE_LBAFEE	= 1,
 };
 
+enum {
+	NVME_HCTM_TMT_MASK	= 0xffff,
+	NVME_HCTM_TMT1_SHIFT	= 16,
+};
+
 /* Admin commands */
 
 enum nvme_admin_opcode {
-- 
2.45.2


