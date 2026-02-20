Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6991E9A041
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 03:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0AEEfE6xiusQnEvNeZM84fhKgvDhfLyCCrKC1bZTQl0=; b=iE3AdNO0XpG6ZVKyCyQN6MvC87
	Q4XcTgqU/4eyhyHtrpdA+iORdVi/XvQ2wbCWhrKLG4cvCC3kCUds8x4GmPLw7owFGn1WWegHStW+4
	yq0IeH6szNeTPBt1OHxkkI7lpStMzANaZaHfH56V+SBYk1NmZfkBWf+04DNw0mDIFxu/oy1MRy/M2
	9XPSxx/7Yf1Lf6cazQPh3f9R65MiEVhtrZCE7WzRRukuxRPlh1HM497UvntHvezFSGaE8YHzZQLYZ
	AlXwgn6KUEKp4uC2Kvrr/wmJOWQDnexQYRpap14uJLOUWjHYJ2GQ/EnrCaugRI0628GE/Dcg1/LAL
	ZJ4nW+uQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtHBm-0000000DA9V-1OXe;
	Fri, 20 Feb 2026 03:28:22 +0000
Received: from mail-oa1-x61.google.com ([2001:4860:4864:20::61])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtHBi-0000000DA6q-1DnM
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 03:28:20 +0000
Received: by mail-oa1-x61.google.com with SMTP id 586e51a60fabf-40efb4bceb6so81924fac.2
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 19:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771558097; x=1772162897; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AEEfE6xiusQnEvNeZM84fhKgvDhfLyCCrKC1bZTQl0=;
        b=Qnh4lSeu2IDgualN27eDr75EVN2WKDsXzau8JLJMhcPZf+BSdgUY3Le5xdFG7oQ68z
         6mPf14moHdsqvs8K6n+VfVx7bATVKK/BJklwTi1UYxgFjEPFyA5nvjvU1ALFOKNCH0rt
         2+rPEe99qjET/1MyuKIt/JkGnidX81GsLbN59mxQGDkahtXZQVHeNOt5vTOvZNn67IYF
         OJ8gD+8Aq2AFEvmlb5VthC0iDQfliqbD+q/fwLAOqAwgedvxYQZDzmjqTUfFjg9BGYvc
         NxbEl9pvIXPWB9QJsz11RpENFxeaG93d3uvBVDfQVsm/D5dZEgMsHsRQMkOdapqp4qk2
         WAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771558097; x=1772162897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0AEEfE6xiusQnEvNeZM84fhKgvDhfLyCCrKC1bZTQl0=;
        b=HA8kn6BL3NonGONIfoFwDNJ6ORT3uGzJ9bnnqs4yeLKPUCGHt7jCl7Rx2dAtwyLAA3
         d5ci/0lbjHxmLMrzuzfccwUsCy31M3+k+Tea5ayuYR921cASnbUz9bTOVvvzWzJUSpC8
         zmGOPEO1hBU94f0lDk1tS+EiPO0E8j0WGTalbhsayks655+5l6seK6DNb6N88dtp86uL
         MmOSlbkJ41J9/LwK/wuOYjrwusQ2ZmUvAjfCkUNir9R0J5JXv3ccInESJAymLW0ddN2a
         VHr0/HImS2PslkVzAwavqy+vDRCmYhqJ8viHrgK13+a2K01MTBh4XL8IHYaJOjryL0Pu
         eQMg==
X-Gm-Message-State: AOJu0YzC5p+SUXDeG5u8oZwjEl0bFrHASh0aLlpfoqM263B76OVJp9hh
	VGVv0wKmxocrwYmOimttfHaqyVQWrfRBe+7VhstNrp1z8XcMcWdoqd6nfxCTCnm/BLc3vIIPWSC
	kWD/n84UiJyzUBkMGdykpeEhlHde5WLpmFE9v
X-Gm-Gg: AZuq6aKqD4jewV+Jwbs7dxnh4V6HLepDpIoODNaxQDlQ/GG9I+3EZZKn2rN3NUebW6E
	xIz7uMFKJ1I50qrxjaChuucMKeZJk3+7gdKpL+6qstpr3hZ31unWRebsjlQWJi9H/A7VsZiOq2c
	iB/Nsq5K8PzRuNMbZcA6DCitIYUiYzO2P9NVNKDzie2cPCqNcXmNvI+YCy9IaKJW/5F8oUF4+kh
	QMTeRq9QQ9zl5LYyx8yS5mieS77/Slyo3EEROCAYTsty28vEKkgetQcWhA2mqZBBUrBaPpUC8jd
	6qSbJ+4XhNUqy8khGha+TXvXmCLeqpWdGJ/+iiegL2emI6mHvHa1Un2qaq0qkDWcPbe833khBD7
	7r5crtzFiSaBV+n+ARFrrNOPpXWfo9TUafP1cbt7D+/EF1CUtMUBTsg==
X-Received: by 2002:a05:6870:14cb:b0:3fd:c70c:3f0b with SMTP id 586e51a60fabf-40eee7fc0fbmr11112425fac.1.1771558097095;
        Thu, 19 Feb 2026 19:28:17 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-40f18d151c8sm3221341fac.8.2026.02.19.19.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 19:28:17 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 9ACF1341D32;
	Thu, 19 Feb 2026 20:28:16 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 977F0E420F8; Thu, 19 Feb 2026 20:28:16 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 6/6] nvmet: report NPDGL and NPDAL
Date: Thu, 19 Feb 2026 20:28:09 -0700
Message-ID: <20260220032809.758089-7-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260220032809.758089-1-csander@purestorage.com>
References: <20260220032809.758089-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_192818_335470_798BC472 
X-CRM114-Status: GOOD (  18.00  )
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

A block device with a very large discard_granularity queue limit may not
be able to report it in the 16-bit NPDG and NPDA fields in the Identify
Namespace data structure. For this reason, version 2.1 of the NVMe specs
added 32-bit fields NPDGL and NPDAL to the NVM Command Set Specific
Identify Namespace structure. So report the discard_granularity there
too and set OPTPERF to 11b to indicate those fields are supported.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/target/admin-cmd.c   |  2 ++
 drivers/nvme/target/io-cmd-bdev.c | 19 +++++++++++++++----
 drivers/nvme/target/nvmet.h       |  2 ++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 3da31bb1183e..72e733b62a2c 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1056,10 +1056,12 @@ static void nvme_execute_identify_ns_nvm(struct nvmet_req *req)
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
 		status = NVME_SC_INTERNAL;
 		goto out;
 	}
+	if (req->ns->bdev)
+		nvmet_bdev_set_nvm_limits(req->ns->bdev, id);
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 	kfree(id);
 out:
 	nvmet_req_complete(req, status);
 }
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index d94f885a56d9..485b5cd42e4f 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -28,15 +28,15 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	id->nawun = lpp0b;
 	id->nawupf = lpp0b;
 	id->nacwu = lpp0b;
 
 	/*
-	 * OPTPERF = 01b indicates that the fields NPWG, NPWA, NPDG, NPDA, and
-	 * NOWS are defined for this namespace and should be used by
-	 * the host for I/O optimization.
+	 * OPTPERF = 11b indicates that the fields NPWG, NPWA, NPDG, NPDA,
+	 * NPDGL, NPDAL, and NOWS are defined for this namespace and should be
+	 * used by the host for I/O optimization.
 	 */
-	id->nsfeat |= 0x1 << NVME_NS_FEAT_OPTPERF_SHIFT;
+	id->nsfeat |= 0x3 << NVME_NS_FEAT_OPTPERF_SHIFT;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
 	id->npwg = to0based(bdev_io_min(bdev) / bdev_logical_block_size(bdev));
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
@@ -50,10 +50,21 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	/* Set WZDS and DRB if device supports unmapped write zeroes */
 	if (bdev_write_zeroes_unmap_sectors(bdev))
 		id->dlfeat = (1 << 3) | 0x1;
 }
 
+void nvmet_bdev_set_nvm_limits(struct block_device *bdev,
+			       struct nvme_id_ns_nvm *id)
+{
+	/*
+	 * NPDGL = Namespace Preferred Deallocate Granularity Large
+	 * NPDAL = Namespace Preferred Deallocate Alignment Large
+	 */
+	id->npdgl = id->npdal = cpu_to_le32(bdev_discard_granularity(bdev) /
+					    bdev_logical_block_size(bdev));
+}
+
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
 {
 	if (ns->bdev_file) {
 		fput(ns->bdev_file);
 		ns->bdev = NULL;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b664b584fdc8..3a7efd9cb81a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -547,10 +547,12 @@ void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl);
 void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl);
 
 u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
 u32 nvmet_connect_cmd_data_len(struct nvmet_req *req);
 void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id);
+void nvmet_bdev_set_nvm_limits(struct block_device *bdev,
+			       struct nvme_id_ns_nvm *id);
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_file_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_bdev_zns_parse_io_cmd(struct nvmet_req *req);
 u32 nvmet_admin_cmd_data_len(struct nvmet_req *req);
 u16 nvmet_parse_admin_cmd(struct nvmet_req *req);
-- 
2.45.2


