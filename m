Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6237FCA0EE4
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Aug 2025 06:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X6spV9KlR65G0JEcEGJiU+lMtJ/JHdeTuhVaUUvqnrM=; b=qrWFMB2bLUHaItrNXCwESz5wgQ
	qWXO8wT1Qj1VT2F6PggBWsCdrDMZ6cGRfifAtLHeXogVKZD9rw6y8cqaPOHZLaPoWERkpRfYS5ZO9
	vor+cajgx5BKtuOjpdSKyksRYNtaVSPvA7ec0Skps8Ac42LccZlaYOqNGFJr2fMfMjGnP44jKfxnD
	Lx1lCAo7cUSyrUWtNOoTHr/ybNbV7Q3VPnasZYPLZ/RiEwWR3BNejhhx/x/Og17DH/CVNOqrVaiGN
	RRJsXLFnHGNSUnFSJzYw7O/tDKi7Cv+/w60LDVtjHP8pZQeBs5chBC4o3YzFANGLZBphJIgD1Kp0a
	G14qnX0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uphrk-0000000478i-2THr;
	Sat, 23 Aug 2025 06:36:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upTir-000000031UI-0Ud7
	for linux-nvme@lists.infradead.org;
	Fri, 22 Aug 2025 15:30:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755876631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=X6spV9KlR65G0JEcEGJiU+lMtJ/JHdeTuhVaUUvqnrM=;
	b=Y7esMNp4O6fu5+XH2QKzwSou/lQcqKBACtzQM4ewNTJkzUKVgux4Xu1xFv7Agp5LG6IeNA
	y4hDACg+K+b37yzeiu6ztDeDVMutXNghj8yT/FHkxd8xvMdmUJF5mqNmMJVc8Zdpy5KVB1
	L2nGpVPxv9EraKpBx+zlvKmhT6+rjB8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-2qcncEC7MUWLbvSIMEDokA-1; Fri,
 22 Aug 2025 11:28:51 -0400
X-MC-Unique: 2qcncEC7MUWLbvSIMEDokA-1
X-Mimecast-MFC-AGG-ID: 2qcncEC7MUWLbvSIMEDokA_1755876530
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEBBA195608B;
	Fri, 22 Aug 2025 15:28:49 +0000 (UTC)
Received: from vm-10-0-76-146.hosted.upshift.rdu2.redhat.com (vm-10-0-76-146.hosted.upshift.rdu2.redhat.com [10.0.76.146])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0EE5E1800447;
	Fri, 22 Aug 2025 15:28:48 +0000 (UTC)
From: Yi Zhang <yi.zhang@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com,
	shinichiro.kawasaki@wdc.com,
	kch@nvidia.com,
	dwagner@suse.de
Subject: [PATCH blktests] nvme/054: fix nvme reservation preempt and clear operations
Date: Fri, 22 Aug 2025 11:00:06 -0400
Message-ID: <20250822150006.3248193-1-yi.zhang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: cKMl5Jh4kO7ySKKQctfr1Jhzia7ueWbQ-oDkIqN1s2k_1755876530
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250822_083033_229570_6B001182 
X-CRM114-Status: GOOD (  11.83  )
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

This patch fixes two issues in the NVMe reservation test:
1. Missing --prkey parameter for Preempt operation:
   According to the nvme-cli documentation, when using resv-acquire
   with --racqa=1 (Preempt), the --prkey parameter is required to
   specify which reservation key to preempt. Without this parameter,
   the command fails with "Invalid Field in Command" error on some
   NVMe controllers.

2. Redundant registration in Clear operation:
   After a reservation release with --rrela=0, the registration
   remains valid. The subsequent resv-register command attempts
   to register with the same key, causing a "Reservation Conflict"
   error. This redundant registration is unnecessary and should
   be removed.

These issues were discovered during my nvme reservation test with
the same steps on NetApp storage connected via NVMe/RDMA.

Link: https://github.com/linux-blktests/blktests/issues/190
Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
---
 tests/nvme/054     | 3 +--
 tests/nvme/054.out | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/nvme/054 b/tests/nvme/054
index 0a9ac80..08e3a00 100755
--- a/tests/nvme/054
+++ b/tests/nvme/054
@@ -55,7 +55,7 @@ test_resv() {
 	resv_report "${test_dev}" "${report_arg}"
 
 	echo "Preempt"
-	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=2 --racqa=1
+	nvme resv-acquire "${test_dev}" --crkey=4 --prkey=4 --rtype=2 --racqa=1
 	resv_report "${test_dev}" "${report_arg}"
 
 	echo "Release"
@@ -63,7 +63,6 @@ test_resv() {
 	resv_report "${test_dev}" "${report_arg}"
 
 	echo "Clear"
-	nvme resv-register "${test_dev}" --nrkey=4 --rrega=0
 	nvme resv-acquire "${test_dev}" --crkey=4 --rtype=1 --racqa=0
 	resv_report "${test_dev}" "${report_arg}"
 	nvme resv-release "${test_dev}" --crkey=4 --rrela=1
diff --git a/tests/nvme/054.out b/tests/nvme/054.out
index 5adb30d..9c92668 100644
--- a/tests/nvme/054.out
+++ b/tests/nvme/054.out
@@ -54,9 +54,8 @@ regctlext[0] :
   rcsts      : 0
   rkey       : 4
 Clear
-NVME Reservation  success
 NVME Reservation Acquire success
-gen       : 6
+gen       : 5
 rtype     : 1
 regctl    : 1
 regctlext[0] :
-- 
2.45.1


