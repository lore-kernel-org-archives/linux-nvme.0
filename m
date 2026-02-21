Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40CAC5DF7B
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Feb 2026 03:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0AEEfE6xiusQnEvNeZM84fhKgvDhfLyCCrKC1bZTQl0=; b=Wcx7QyFK1ZyZK7w9MWDJ/AeGvO
	7NhhBVh7mPxipCChnA9XeA8AYF99Xtd7xYJS9CpY3CI6D8jWXZIJbs3px6DKvrpXjrOz2I7LuaGum
	jWCYwomWrcNvevGy9DEKN9F8wGRm/AVurTlEWsDLJBW0xQ448qh0Cc75VAkmi7Nsta+MN/+WaHree
	9eFGgmsPlZfyzdtwg1nEi1e+j6y5UP7I9FoCdzkTVoMzReqOH5tD4hPfyCMmMUxflMfHlYf4F0okN
	ksYOv+N9gXEoCsOuLvSIwiUolYNekL5Yyxb6FcopupcikOqQ50FAboSrjRtndMrmcqMPFn6PR5gaE
	pxrVlE0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtdk0-0000000Fnbk-4B87;
	Sat, 21 Feb 2026 03:33:12 +0000
Received: from mail-pf1-x461.google.com ([2607:f8b0:4864:20::461])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtdjw-0000000FnWv-0bq6
	for linux-nvme@lists.infradead.org;
	Sat, 21 Feb 2026 03:33:10 +0000
Received: by mail-pf1-x461.google.com with SMTP id d2e1a72fcca58-8218237420eso220427b3a.1
        for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 19:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771644787; x=1772249587; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AEEfE6xiusQnEvNeZM84fhKgvDhfLyCCrKC1bZTQl0=;
        b=LkbbnZvi1JNpnVJ1vgOWSa3vRduM/Di6ENvx/qMjBJPLKtIQIkIR2hhtATiG6n9A7/
         MBIW4HkKmtyuPyQq77mpfmBWphploXfqrlyctyZ1iO0mt1kmM9MgbtsHzDKTUcxlVMoo
         Vh2UI+9zybCqglnSu5AcBj6CwE1EWYBJFuj1JeQpBOWe0XQpY43bPfuifYRfCNm1mcKk
         ykrtYJfVsnvsLhd33TTPcgcyPQjBgpXUYBP1DoQ0p+oiK6RBYHseCyiaKy+OU0OECRXA
         It0FDtSPh3uVwdCK3dH7V6HjDH+IB7K9yI44Lhqfe46I1z7MLOsWjl9fNa/pFzn7TBZA
         oniQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771644787; x=1772249587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0AEEfE6xiusQnEvNeZM84fhKgvDhfLyCCrKC1bZTQl0=;
        b=P78pKMI98L0H71zta23WXDm8q5zOeD2yzqDfbn6WErrlgfaZ9xRIMg/E8Zw4iyB50/
         vjcBUAT4yUkNc4OkKYUOvmwvdM9RiOFO8mV/bG4PlTiivmy/eO+F4OcasuZ+8ykuN/b1
         1r5m5RUYSQ8OOYPQptM5eEQQK9fEwEPqde1/iOOe90LIsqR/ybp9NmqX7fEZ2s6qgOcD
         WL40ip8fTgmSWoOT9DZX7/2+O61n+/qFUxIkCTUGWID9HfETKyCkHnj4YZ2CLHz0A7aq
         wKH2rlOuRXz3nFEHqZsEGeNkdrwXTWveb4RUiCtbkoY4vyPm6cNeVsjwckBGm/+efkAw
         rAiQ==
X-Gm-Message-State: AOJu0Yw9ybMHLACpf7ahup7hzENhFmSC6QaHQfaIDMij2DpZRpQRTEKx
	5iC4ATqGhv2AnxoZZIm5Br6O3PLJriNKAsX/vEfgd9ED8s4u7hL45dp1fJ2Yd6MCHbsgp7Fm+9x
	0n8t2L++raUG6nYcasn+NT0xpYsnW7N7uZ71cpyeiLTDDXUtvo5PR
X-Gm-Gg: AZuq6aI2UxKL2PanWFHjVBvHDMH1HSPfjDA8d08jutPGcATYgd+5SM0lBxmMFX12l4T
	fgkFRp0SZ+/XejQskbrSFSTTilrQJAFoABWDA0oYpF54eF+XwjYSdw95lAwNDe2jRvF2RO/mWWN
	SS5QrNZ5R4I8ONn4BYLHARqqRnE7KI/G5ohHYPMisw5NeYxKn8ZE8ElHRMZj1HQyd7BLhcGv2/P
	v45Oz1rMuDNutJ/bkltrN4+QwE8RYoXfq++s+ICVXhCiRht2BSUsgrNUogubN9tC6YQCvXzbUEe
	enMFkMoHvj1P9+DXFguv1qIDglGHmc5nbw16H786w4+pgmntz3BA/H0NJHkYYDGGEPZiMLYr0yU
	SY7/3lCCTjjKp2OxG6206OiSKfOpY0n2oymk6cwQ=
X-Received: by 2002:a05:6a00:1993:b0:7b7:90de:e18d with SMTP id d2e1a72fcca58-826daaf4226mr1064232b3a.6.1771644787098;
        Fri, 20 Feb 2026 19:33:07 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-826dd844942sm164449b3a.7.2026.02.20.19.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 19:33:07 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 55EEC340648;
	Fri, 20 Feb 2026 20:33:06 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 51094E427CB; Fri, 20 Feb 2026 20:33:06 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 7/7] nvmet: report NPDGL and NPDAL
Date: Fri, 20 Feb 2026 20:33:02 -0700
Message-ID: <20260221033302.1451669-8-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260221033302.1451669-1-csander@purestorage.com>
References: <20260221033302.1451669-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_193308_178056_8A763BDE 
X-CRM114-Status: GOOD (  17.90  )
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


