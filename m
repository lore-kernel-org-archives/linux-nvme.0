Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE40DC6FD18
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Apr 2023 20:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AaJs/pKhX+jaHb6DS9Xn+2k4f+ztJK6oHP/jETyXQNE=; b=BMLdZS9u2bYZjLekuVnyQyXudm
	u8DPMj1iFo6Qb1gfrHCR635GmJQ/P08WqTnyzJRqrY8Lh3QSn6uK2YaOVjcVr78P/iGix3/jBB25m
	unle97z6vjBBdbL+zKl5gv8/4mDjK0Ugb6fLHaFXJjBj9IJzGVamOFaKGy8HWIgRV501WVNNg2TbJ
	oUaz5tVxtoBE+GUGZTUd86+fMsK1HNIzL/X/nOcOBI9EtWjOANRT7UI4FE/QKc1vC+WiPszHRP1lS
	ujn54FaFH9vv2m370W8trA0AAh3nnG86F41MnsX2GTW8pKD62NnsKAIsgL06OfluK/mbc9vhHB9m+
	ihX52t4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1prOrE-0027Z6-1H;
	Tue, 25 Apr 2023 20:01:48 +0000
Received: from a1-bg02.venev.name ([213.240.239.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1prOrB-0027Xg-1K
	for linux-nvme@lists.infradead.org;
	Tue, 25 Apr 2023 20:01:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=venev.name;
	s=default; h=Content-Transfer-Encoding:Message-Id:Date:Subject:To:From:
	Content-Type:Reply-To:Sender; bh=AaJs/pKhX+jaHb6DS9Xn+2k4f+ztJK6oHP/jETyXQNE=
	; b=YyJkyFD1KMBh+kty27AyEn3lyfGACvshdSC+jA38GHQVuYMlOdHH+VX7tY+o9npavvwNfWxRJ
	WpyTZagW1SP4XHnJJ/7hTazmV4cED0h7mQ7xd/q7eOwubQHNECA5rVQyDFvPsJzCAdD0tmg+kyqU9
	qiqWEePtDpyV7LCkbuC5GI8wjyoqwVwen3XgQn4sFCAO7sMXWhwopAsM1l+iwGRE2RTU9j2wPyQDf
	ijMAU3FgAn7wv94Dk1a4JFJ3Kvkyz3Eq0qmKXaItd7ohrGTqzdxqqynp0PhYLLwEHaMF59aGAWc4M
	myrgNJYHEGtfF7yQfaMqYUMB2bLQ3UyeRhil61I/Pm7JW8hXEn85mZzgOFo5o5WwFTuEy7xr+su3y
	niO2tBqS/Bhc3RP0deDFwOL1K+P4kT+tmUNdeM0IGnmITgRNqmOJ2okwFMWYlnUd7ryZuczQwcDiB
	NzyHysY7yVOm/BDjM0LKF20OTJFsFXH7dJwSlyZl1Yt/aChtzGHWimazv8Rrbz+y25kaiKg78BEG5
	2u0Koc0zaRXwcMHFfTIvFu/2FrRqFhYzplCpfCffYvQd7H/+0sTJULpS+np/VjP/Xt3cNLnsbmx9j
	HS6MQwB/pB1oJK1c1I2h48JAb/9z1XE+eJ5Pm4henaUaQ0bgW/7QdHaXUBrJwYmmrvCx6MA=;
Received: from a1-bg02.venev.name ([213.240.239.49] helo=pmx1.venev.name)
	by a1-bg02.venev.name with esmtps
	id 1prOqf-001LrX-0Y
	(TLS1.3:TLS_AES_256_GCM_SHA384:256)
	(envelope-from <hristo@venev.name>);
	Tue, 25 Apr 2023 20:01:13 +0000
Received: from venev.name ([213.240.239.49])
	by pmx1.venev.name with ESMTPSA
	id 3zESE4cxSGQ/6wQAdB6GMg
	(envelope-from <hristo@venev.name>); Tue, 25 Apr 2023 20:01:13 +0000
From: Hristo Venev <hristo@venev.name>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hristo Venev <hristo@venev.name>
Subject: [PATCH] nvme-pci: add quirk for missing secondary temperature thresholds
Date: Tue, 25 Apr 2023 22:58:54 +0300
Message-Id: <20230425195853.322100-1-hristo@venev.name>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230425_130145_550730_D52B737D 
X-CRM114-Status: GOOD (  13.89  )
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

On Kingston KC3000 and Kingston FURY Renegade (both have the same PCI
IDs) accessing temp3_{min,max} fails with an invalid field error (note
that there is no problem setting the thresholds for temp1).

This contradicts the NVM Express Base Specification 2.0b, page 292:

  The over temperature threshold and under temperature threshold
  features shall be implemented for all implemented temperature sensors
  (i.e., all Temperature Sensor fields that report a non-zero value).

Define NVME_QUIRK_NO_SECONDARY_TEMP_THRESH that disables the thresholds
for all but the composite temperature and set it for this device.

Signed-off-by: Hristo Venev <hristo@venev.name>
---
 drivers/nvme/host/hwmon.c | 3 ++-
 drivers/nvme/host/nvme.h  | 5 +++++
 drivers/nvme/host/pci.c   | 2 ++
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 9e6e56c20ec9..7a2c4b5e018c 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -163,7 +163,8 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 	case hwmon_temp_max:
 	case hwmon_temp_min:
 		if ((!channel && data->ctrl->wctemp) ||
-		    (channel && data->log->temp_sensor[channel - 1])) {
+		    (channel && data->log->temp_sensor[channel - 1] &&
+		     !(data->ctrl->quirks & NVME_QUIRK_NO_SECONDARY_TEMP_THRESH))) {
 			if (data->ctrl->quirks &
 			    NVME_QUIRK_NO_TEMP_THRESH_CHANGE)
 				return 0444;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..a2d4f59e0535 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -149,6 +149,11 @@ enum nvme_quirks {
 	 * Reports garbage in the namespace identifiers (eui64, nguid, uuid).
 	 */
 	NVME_QUIRK_BOGUS_NID			= (1 << 18),
+
+	/*
+	 * No temperature thresholds for channels other than 0 (Composite).
+	 */
+	NVME_QUIRK_NO_SECONDARY_TEMP_THRESH	= (1 << 19),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cd7873de3121..e457ad169dcb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3416,6 +3416,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x501E),   /* KINGSTON OM3PGP4xxxxQ OS21011 NVMe SSD */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x5013),   /* Kingston KC3000, Kingston FURY Renegade */
+		.driver_data = NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, },
 	{ PCI_DEVICE(0x1f40, 0x1202),   /* Netac Technologies Co. NV3000 NVMe SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1f40, 0x5236),   /* Netac Technologies Co. NV7000 NVMe SSD */
-- 
2.40.0


