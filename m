Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF612FEFB51
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Feb 2026 20:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rLGXbc0gXctnroosx2bL2/uz0im7hCkKsBk3ALVli3I=; b=ZQNz4luEfNS2FpXA1mmPn54uWv
	AauE3qMS95xmuWbBrwFMTdo862ThpsCX1pvMn422SXp08H8rAzBPX0bJqIsMjQ9S/ZnOXBkA3T0I0
	jBIGb0UW/aQKNbvG2X/cE++Kg2qB13H5QPCX/DOi1657IPSXFhQbAFge9+FHotHkunoDqZFfdYeL3
	z3+drkYk4/PY+w9u2ZUOHNw6s3y5/R81tabcaYyylYlHhNoj339uz6oFGkUHgFEamcLDnWJfXpWzE
	mOg6Vz4dzy9u9vo0BSOKeulQCx/pSkwJI0tDDOuqQl+pZUvhSuW1QCnNbytOx+qaXxvhYxkfPnj9s
	uUEOgknQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4Nm-000000096Yz-1OCx;
	Fri, 27 Feb 2026 20:24:18 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4Nj-000000096Ub-2syZ
	for linux-nvme@bombadil.infradead.org;
	Fri, 27 Feb 2026 20:24:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=rLGXbc0gXctnroosx2bL2/uz0im7hCkKsBk3ALVli3I=; b=Nmqfj/2SQdAe7MKxO7Ig/Jzt+e
	s/ap0NetTpqZet80D9qvK4wDGO7O3jxsB2jkhtouxTP8kkCulISXU1vuazxOpMMCpgkcpPc+Gzq+l
	C4g8oESL9vuwFNI4XqND+kg6JkfvMO6xECEdezV2Sd0cdLKYJo4213NhXx5qCfrqoaj9qN1tgwb9p
	QRil3gZLisMsaTzkd29BdruQMONW80ASJstuxlefGCtgn0vSXK7ETHu14M5rKrKlrzVlNUTncP0tq
	NS0cRSK35e9oFTV4b4a988j2lDe7gfVbu758uMsKK8klG3gHNo/aln1Pykn3Ep7Q715IsXirgD7dP
	9WByLl0A==;
Received: from mail-pj1-x1063.google.com ([2607:f8b0:4864:20::1063])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vw4NZ-0000000Dt7Q-3z0H
	for linux-nvme@lists.infradead.org;
	Fri, 27 Feb 2026 20:24:14 +0000
Received: by mail-pj1-x1063.google.com with SMTP id 98e67ed59e1d1-3538952a464so165202a91.2
        for <linux-nvme@lists.infradead.org>; Fri, 27 Feb 2026 12:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772223843; x=1772828643; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rLGXbc0gXctnroosx2bL2/uz0im7hCkKsBk3ALVli3I=;
        b=ViJzAXFZWg4ElSpujnSOn9zdmVAenL8p8CzhPweHnLXz5TgCata6o0YcYYRIL2QR39
         MFnxgTNUQkcTqNoWFta66TESeyr852J8j2cMVqsXMfjxz+GT3+kr1A43s5YOUfOjycS+
         Ts8T7j7eMvfardvvGvOO11JOBi1uogoyivNd59K0dLt+q9E9w8SVOITJeForlEuGAjao
         bqtcSdJ3tvX199/wNiuc95vio8TvxQrXan1cQaevkqbh9Ic1ht6sNL1nk52/2tcCh6zl
         M2cwiRt/hV/Br4ZOXUlS6eGlrAUINN/K7E6qHRVHtC02y1QgesSuinGjr0n6fD10hsCu
         PMzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772223843; x=1772828643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rLGXbc0gXctnroosx2bL2/uz0im7hCkKsBk3ALVli3I=;
        b=vf83qVEigz26xBZHG/idV4kyq+4GkiB6JJ6fRm8d8c3wW446KwXE3Ubl2cNhvbb1m5
         +oijA6vMDF79N583y/DhcXQ2s8EkINIuzOd+f7bwIpz2WKnVuLFDiOsLTTHt9/EBt8c9
         a87P1MhPOXv3qXm6x3+6PaPv9drRtJpNcruYbxCW2bROZh/t5vUu0u138f09Y3BocmuW
         AKqePXpsQBWQCBlyGMxJE2BvyMzpe3YGa7dUyD4t0vCEfBideiDEg8pU4S1kTZEbYUYV
         llxYzRKuaslrWj9qu6Z2P7gmWgeXhzl6mpt+OqSh/kFjmYPf1Y7U5ZQIy1tCmjrxPpq6
         HhMg==
X-Gm-Message-State: AOJu0YzT3L2Ip0jZgM5WqPv5hnIv37vlbR+JFr/MlBEL5PKk/opwKuLl
	wFNtEBcvkZBWkkQHPNpleKdsXtCwZ3v3M642VVL9MLG2GM04AU7vXmQtaCq7uLjLM+2cZuP83E4
	zbTEJmcSR+avS0RquGUvkTcsBnSwPjeDhteS/
X-Gm-Gg: ATEYQzxdmdAXlW5CVAqystCUBo4Tzq9Bu9rsU6w0sdYnRUMWgx73bmxnCFfR8GotE/l
	3gi7dxY2HMYWWa8ghgCU4JFNQW6C+H9bui2Qeg1e2Szv15Q6JdlfIH2uwz2Oz4jViSxddThVEtk
	ucnr/fLf7r8hcZowGS+2smXvUZA4KNg4ah1avBqy9nDYwh8ntdO0R2FUkdSMVTcTCeHcmJC7sH9
	g5o5NG8xMhns9x+WLTvYEpoVdkLpL8ikBfbAmT7P2bCYc+gURQMrfGrmM3nAwKe9mRNIWxwHtZ4
	aJwWm0SE1QFRnrDvKb/NAVtXkpRz0gJJdTNdtyYbphP99lS/VukALyoYROFzCXxWP28CxVmHsrn
	Kn0uHpzt+f5a5EiNMCA1mQjeMhj+nVgiw9x8q+lnuTvUtSNQFQjBCzg==
X-Received: by 2002:a17:90b:5688:b0:356:1dad:1b04 with SMTP id 98e67ed59e1d1-35965ccbadfmr2604765a91.3.1772223842724;
        Fri, 27 Feb 2026 12:24:02 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3593ddfa655sm758653a91.8.2026.02.27.12.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 12:24:02 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 7ECE33404A1;
	Fri, 27 Feb 2026 13:24:01 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 782C2E420D8; Fri, 27 Feb 2026 13:24:01 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v5 8/8] nvmet: report NPDGL and NPDAL
Date: Fri, 27 Feb 2026 13:23:53 -0700
Message-ID: <20260227202354.1012322-9-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260227202354.1012322-1-csander@purestorage.com>
References: <20260227202354.1012322-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260227_202410_585847_3B0D1FCE 
X-CRM114-Status: GOOD (  18.26  )
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


