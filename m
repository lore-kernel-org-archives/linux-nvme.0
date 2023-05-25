Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469AFC7EE2C
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 19:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N5VzD7qvlK9LdYKtrZ3xSx4DZZGRi+XwFSfrVyYYvWg=; b=f0fr0nEFvf+flpyTO9Z3RQeyJh
	lBE0upeiM/I58FMAPMrAkvgZyN8xvziSy+lw0SKst6POT1y9deaIjZ9ttyBUeCGj00+tdhOUi+P2x
	AYSYUj/o6jfcXHYsTMqXFlhm9DCZE1W84fXKvjNeOHWyGd7N6hpp2Sjlit8kouGNPsxM+6hn1q99q
	6Snz8zRgeaZXRf4XD/NUFWSRq+HoNA/obs6cCzlG00pAf1R1pOInC50COVoGam94/4MV8O7lq8ZiU
	OMhupuNLsBQOd1zIPEC2rnzKaO09ecMW/gsd0NLdJ+iOnvDuGGgSElRtP7Cn5eiFD/KCTkZMpU4VE
	RMbsWHAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Gyk-0001QY-22;
	Thu, 25 May 2023 19:50:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FrY-00HRXh-2m
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:39:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 77F6360BDB;
	Thu, 25 May 2023 18:39:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA14C4339E;
	Thu, 25 May 2023 18:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685039938;
	bh=qZyi7ErsXREG9QYU1Hr1utOu9+0ghjejiKodmFC8N5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=psOUKkljN2q4HYoArQKp44XMuy50+sozfJM/ldjnBJ5ecfftY80VDpbE3O9yVxc2X
	 iF58V74L/ml6QwYfWFWr/9zSxVDlgcWGtvX/lcDt+FRNNJdXJor2HjdZOgvbNczuqm
	 ftW6G6nOf8KkTV1n/N+jOFpkw0aP9bfXpGqzzNU2BtiyqfWX25Ns5H4/nq/2JFA+/L
	 UmGGpQA+Ur/c8coBcv9gE6nzVI4Wd8GR1gdwGWPm8m9HM873RfkCJlOXNbEY4hdXKv
	 Mb8ZYcNHpHnpXatPvatkBuWBtr9vS3jehmB8fb2apfppc96qlzhIV63mCTd7OrGitc
	 P74kMumI0veMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hristo Venev <hristo@venev.name>,
	Guenter Roeck <linux@roeck-us.net>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 02/43] nvme-pci: add quirk for missing secondary temperature thresholds
Date: Thu, 25 May 2023 14:38:13 -0400
Message-Id: <20230525183854.1855431-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183854.1855431-1-sashal@kernel.org>
References: <20230525183854.1855431-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_113900_975607_73CBC60D 
X-CRM114-Status: GOOD (  17.74  )
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

From: Hristo Venev <hristo@venev.name>

[ Upstream commit bd375feeaf3408ed00e08c3bc918d6be15f691ad ]

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
Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/hwmon.c | 4 +++-
 drivers/nvme/host/nvme.h  | 5 +++++
 drivers/nvme/host/pci.c   | 2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/hwmon.c b/drivers/nvme/host/hwmon.c
index 9e6e56c20ec99..316f3e4ca7cc6 100644
--- a/drivers/nvme/host/hwmon.c
+++ b/drivers/nvme/host/hwmon.c
@@ -163,7 +163,9 @@ static umode_t nvme_hwmon_is_visible(const void *_data,
 	case hwmon_temp_max:
 	case hwmon_temp_min:
 		if ((!channel && data->ctrl->wctemp) ||
-		    (channel && data->log->temp_sensor[channel - 1])) {
+		    (channel && data->log->temp_sensor[channel - 1] &&
+		     !(data->ctrl->quirks &
+		       NVME_QUIRK_NO_SECONDARY_TEMP_THRESH))) {
 			if (data->ctrl->quirks &
 			    NVME_QUIRK_NO_TEMP_THRESH_CHANGE)
 				return 0444;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 39ca48babbe82..590ffa3e1c497 100644
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
index bfb9ddec9f887..e284511ca6670 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3368,6 +3368,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x2646, 0x5013),   /* Kingston KC3000, Kingston FURY Renegade */
+		.driver_data = NVME_QUIRK_NO_SECONDARY_TEMP_THRESH, },
 	{ PCI_DEVICE(0x2646, 0x5018),   /* KINGSTON OM8SFP4xxxxP OS21012 NVMe SSD */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x5016),   /* KINGSTON OM3PGP4xxxxP OS21011 NVMe SSD */
-- 
2.39.2


