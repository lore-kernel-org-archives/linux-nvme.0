Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A978F4BB64
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 17:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rLGXbc0gXctnroosx2bL2/uz0im7hCkKsBk3ALVli3I=; b=jAQrepJg8qg+WE4e3gLY7RKZgk
	T+dtg3yikS3VfIcRA+4gyR7NRMomYIlLrh32/Vpl2WFfBCTLahEdiyVkSf9t8UmSasvcmBrOk0EYy
	5HQF0NU8mwyNO/uwoJvturu8sQdcwlzPrH+T+XWwwCgDM2dqASsVY5k+63bH1ebNw0UqeajTKDTRM
	abNH3JyROu2hdbjrwYhPoefgCoTqhp3Rcvd6mIKkyG+tN7SdhLvWmGHC97VRb15ycg/qrqKDjLK3r
	IL/xRoMj9kcEBiE6WNXbD2jMDeokRdQFMmiHwEjJUsCgNPlaZgKwbVfOTWmiCJEiRpl51av78dmmT
	f1L8nBpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuw07-00000002SMD-1H4B;
	Tue, 24 Feb 2026 17:15:11 +0000
Received: from mail-qt1-x862.google.com ([2607:f8b0:4864:20::862])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuw00-00000002SFo-1dVi
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 17:15:06 +0000
Received: by mail-qt1-x862.google.com with SMTP id d75a77b69052e-5032e59c8d3so6126031cf.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Feb 2026 09:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771953303; x=1772558103; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLGXbc0gXctnroosx2bL2/uz0im7hCkKsBk3ALVli3I=;
        b=PcgHIKtrV9Cm7ur0TOHZhx5Gwr5PNbbfb0Gds9WenE+inntWMi1CuFaQLANJC8sYGl
         mPprB1SAwlB2RzUOPwauTcEkV4R1dkU9OF+ols58mNF0JUpyIkbezQf1tME65k2lr9Tg
         Zy2UXQ2XXT+HHdelRMdZ3ErAi/K3hiwup+DpasAhdWWe0aGou9UeNuaEA9fVb8AeCsz0
         Cznls9SiVaIorzoIlTJuY1HNFxl3qIeAdbPjx4Y9Dj+6nD9cbnennlhi6hGPZEnCFFbk
         saNl/1TTH4t2CcAWI+3bNdIDa6xjwFBkxZ97QGCtSWuMSaNENQzXbNRVceHKjgIXZQeX
         Xvig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771953303; x=1772558103;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rLGXbc0gXctnroosx2bL2/uz0im7hCkKsBk3ALVli3I=;
        b=j1U1bCuZlVhf5g5MfU+x4xSRreNOjWT8mfz+vdnVTbjbu+iOwjja4GvdM2sCXvUxrz
         SCXIA67tI2pQFMthqkDAnTuuwJ3ZW2W1SiWBj8hqi6UstzcM1JYRzHP1BbGlP9TS5LXk
         fk2F3xQYDkFCgmMx4ALOa1qvBW1O7ALPo5y2haRJ41VHMnTQNcjGSHJD5zybDhTZ8Wlv
         SK7boSfvA7o1WR8uXb7QnhJE40dWscVAxY5Cv3xdYtnYo1oREcZiODf0dufMct3giysL
         S/zxNgwdwcxxzCoxtoRaYOtN+hv7yPBURARvDkqpmnh7igsAJ+fQU8Urjye6eR1bVSvQ
         1Tgg==
X-Gm-Message-State: AOJu0Yw34sOP6D3BDoHkFOSTPfwuwiotlZBSA/ZLVAVS+1XCwr9Sbwz/
	osDxa2dovEoZiX7VBB5DjA1mTi/f8nCh1PaJbsOBWB1IABXFWZlAu1U7zbkhNgBvV6r4CLA6Y7G
	YpEsyk3TPfum7vGsENbJGxppVm0ZT1jpYN2UjJmg9+2HgrIZz0ZrN
X-Gm-Gg: AZuq6aIYMJUv3ir8r3N6RY4oqzpd8UqiQXTcZS+BahzMTDA6iDdQPWe0OH+QbWYCluI
	GFcgvyiASu4PA+cUYpcjB+DBEUIYgySP5UnCdNZry55XjF2XYY+lgmg5eeRWK0hfGdngojJKbNG
	s7s9fioqMf1xGKhrzBv/+Bc8O7WZ8MKVdcbNJHumwLGM19KO+9h4TIpobReQgWv9fPyv7+g7t8H
	2EEDLRSvuFSpwr9ZXHfxpU+PADijohtfdR1W2dtqFuIf/1ErgYXkNZ0VTl4D2+xSE3EBaFuwMU2
	XFOzn0o33koVys69g+PseWnKKHqdgT4VazJauN967ayc8M54CIuGCbFbYZ+6cJs+jEQQW1V0G1x
	Y8mvMW6NvydAlWSEtll7NuVxqyaYloEiay8ywMUU=
X-Received: by 2002:ac8:5803:0:b0:506:1c3c:9dfc with SMTP id d75a77b69052e-5070bbe6abfmr147168361cf.3.1771953302906;
        Tue, 24 Feb 2026 09:15:02 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-5070d67ab59sm13815861cf.9.2026.02.24.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 09:15:02 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3C883341F2A;
	Tue, 24 Feb 2026 10:15:02 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 370F8E41254; Tue, 24 Feb 2026 10:15:02 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 8/8] nvmet: report NPDGL and NPDAL
Date: Tue, 24 Feb 2026 10:14:37 -0700
Message-ID: <20260224171437.3175993-9-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260224171437.3175993-1-csander@purestorage.com>
References: <20260224171437.3175993-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_091504_441141_58D69E5A 
X-CRM114-Status: GOOD (  18.84  )
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


