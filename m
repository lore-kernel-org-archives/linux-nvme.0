Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704E6FD8FFF
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 19:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rLGXbc0gXctnroosx2bL2/uz0im7hCkKsBk3ALVli3I=; b=ved3BLC16H19xTQCG9gx1CK4W8
	MJeonaiC7pYRN30VF2R+Fi5BFFoR7dpw9powf04D8ax61rgftLfXbtZEGX3PhxkoyMbPeZXomP5c5
	KM9kp2Gs/3yP994ds0yupiK0YIxNAOVMd8egECK5k2mTWis5qx6zfXgYSgH5vz/f0H0I6rF4zeXRR
	51xwQN+CIcssfyHevpLhqeJ+qqXae7a5oXJkceMBY6Nt0H/nXyB6YCwgdFFJU0YRiqm0Hd1pcZg4Y
	b560sGREwZ6HCH0k+rYpkl7Fz9tXyXQUBmQ3scFHwoTlkV/lazPB8Ywrmq/rhBCoFGX6jHVg7ywnz
	jDaV50iQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvgf1-000000070ZP-2lJb;
	Thu, 26 Feb 2026 19:04:31 +0000
Received: from mail-pl1-x664.google.com ([2607:f8b0:4864:20::664])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvget-000000070So-1auj
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 19:04:26 +0000
Received: by mail-pl1-x664.google.com with SMTP id d9443c01a7336-2ab08e6c553so1553705ad.3
        for <linux-nvme@lists.infradead.org>; Thu, 26 Feb 2026 11:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772132662; x=1772737462; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLGXbc0gXctnroosx2bL2/uz0im7hCkKsBk3ALVli3I=;
        b=FnzTgniaYnRhuwBoacrG5rEmMqZ9Q+PMb0nfSkc0pIZjKInDFgFMu8KJEc8Iv/VmL/
         0bnvNizHuP9GUHOFS032+vDwJdoJ0kat/yXin2axwPUsqhCFBXsRkVS04mvtnwNE7rF+
         qFNPm/PYzEZ/wga95T8lG+vTyPHDcRnAEovjTZGVzMZpAhUqPdJVEGllcEkkD54SuZBh
         Gdc0Jdnu7pAWVRb09zK84ZpvL8SseB1gB+v+lTwCsOLgFOkRNv2z5gJ5JuZOa8MdW+tm
         uGOlwHrKztDbWmYxA0D6joPqCiy5bgYXurhdMtvZRDGh2JaeeD2A1GdSGhGqh3Y1uN7A
         H9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772132662; x=1772737462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rLGXbc0gXctnroosx2bL2/uz0im7hCkKsBk3ALVli3I=;
        b=bnZ6hHaImG8BxUuGvEpW3yKuxv2pYOuZ4SCI0mVtFcSATXCW74aJPQWsGlGYFJugja
         T7C+ep8x2swa/G2xJTJOFKHj5dJNphxKfKWYfb01ac84HVUAaDixG2+x929eTLv4W9XQ
         v4vYdlpgaZQLjpaIwjgHW0KvgEB1xG5bhuq1379LRPQ3UsjK3rxL3T8SV278kXrjtVRk
         Tk5DJFk4NtPMAP2gVabVIGw+MDkAKJnr4hTmhuCJBPZJLOBcYcmDhQTpXLhYU5WY4ffF
         JamSmM9UgyqzOP7SU04TkAgqrHWkuQpWZkwQDzFTJ6SB/UBlQAvD7FeYVr0ATovNJRkI
         xLRQ==
X-Gm-Message-State: AOJu0YwdgIhew+8eJesr1fliyIOz6yn1Xh1JEJRim6EV2w7r0vBrV86l
	vHktTxGihxqJq0Bj95aYoI3+74mZwhPAaLUiOz2RpKas6LYS3PzcYBmms9AizfK64dNkM7VEozd
	YcHXSuui0FT8GPDxCRcg8oISaonBEBPOqOL+WjD6ZM4srD6v7T3fj
X-Gm-Gg: ATEYQzwoQh2hv1iCl78/creYK5SUsQP88D1RnSib2L11J6+2XvNVLx0DkoKEuYGjRWN
	uSYkyJo8znh+H+bttKWuSDT5HrGk+ewjq3WQnfzvULkzyOUw00DSQ5UFDiNkJ5SZ4b3ypkMIpjv
	K6SxajyXDouV2Z7c/9RvN9J1OkpiHogKWbJDlzqzzDJIeP3ByLOO/jXRaW06Z87yjlqF2PY6YWW
	96XllCumiUvHBsjZO0+25vFqo4jD+7pfrS4ok3fa0+ljgm30tgfKUCKeEztRcr7hsGU0ik41hyc
	C05g4X4wJkGcj7FSze58JBZSvDRxSOmCdUayHlRqxFE7au0y5NbJBUBokhUYqVTAjxIlpZhoAKD
	a5/4xX4tBNw0gXFY3nhuL/9Pf7JNevRlYZqJ7TAc=
X-Received: by 2002:a17:902:ce8b:b0:2aa:d1e1:29d8 with SMTP id d9443c01a7336-2ad745690d1mr144139165ad.6.1772132662194;
        Thu, 26 Feb 2026 11:04:22 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2adfb61600asm3394745ad.54.2026.02.26.11.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 11:04:22 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 19AAA3402EE;
	Thu, 26 Feb 2026 12:04:21 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 14BBFE41254; Thu, 26 Feb 2026 12:04:21 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 8/8] nvmet: report NPDGL and NPDAL
Date: Thu, 26 Feb 2026 12:04:15 -0700
Message-ID: <20260226190416.297725-9-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260226190416.297725-1-csander@purestorage.com>
References: <20260226190416.297725-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_110423_476531_4ECEDC32 
X-CRM114-Status: GOOD (  18.71  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


