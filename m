Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E97BEC55838
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 03:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CkYp1WYpiprfyb/YvSPH0RgVAygJsAfDlSgcU63fZrc=; b=jUylcH20zKndrId4FE3uUer4GQ
	ir2PdBrCprid1yyVxGGSWT128VqQ87ZmAshnsv7cCSR8aBJnsHqgZwEnPH2fYsLyngh4SJYK0pICr
	mgP1rY4Vw5po+Z11hma8oMoMi6dhEK6qmKnwQ6gD5F7DQwot1sZGozVU8QXx88MPnh7hhY0Fb4cnM
	OLX5QzCIwgg7PZdFPozapk31yXH9eNozjgGzfLHNl4FaAISmYCHtLDRBwcleemowM5jmoUGWSelwh
	4xh7JuqxVeoBzJa9Sz2umBswsrhkQjNpbN3mn+ioVndjZleM/X/y1VHtTFxpLsKNd6lVlzC26vUQg
	W5z8XyFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wropz-00000004sLm-0lwj;
	Thu, 06 Aug 2026 03:32:07 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wropw-00000004sLF-3k2w
	for linux-nvme@lists.infradead.org;
	Thu, 06 Aug 2026 03:32:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1785987124; x=1817523124;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CcgQU9SIa0nOkZI5uqK2jmjkrC9wQDwQKPpj98L2WOo=;
  b=iM1tcWLRq6wkzh045btOoI7w7gQkIbka8EzSveXfLZvf0TGWjAi2y+Sk
   kbCBqTzUWZoGo69A79VtAngFJkFh9qszgSJNnOkrOv6SmNcdzNbonE+Rc
   ELNX+omjvcEpVoheNnURsxMXXchJGtU+fc2z15W0z6E5otent7KeDGFAC
   g2wCiPffiorVOTZJII9obrx+tURHt/7N3jIAiUdX4pFurXqhkIOOQ84AE
   22ZX26xB2fghZZOlhHbzUamVeArFWIUKSUpQUE+Hko2CdqKcZ7D8u41PI
   b050eA+wXODlQBBwoz6tqYqt20B7Gj4VCEbj390cPzkf9bCaxusSDj2MF
   A==;
X-CSE-ConnectionGUID: ZCEXCTAQThi3mNDbDgmfxg==
X-CSE-MsgGUID: KS37u2bzTJe3UAm7KmnbPg==
X-IronPort-AV: E=Sophos;i="6.25,207,1779120000"; 
   d="scan'208";a="152572143"
Received: from unknown (HELO uls-op-esad1-o.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 06 Aug 2026 11:32:03 +0800
X-CSE-ConnectionGUID: knsvgPiRTHGFqZP2SGnZHg==
X-CSE-MsgGUID: 1Y55ucXjTnqjZo5ot1P6Bw==
IronPort-SDR: 6a740024_s9TFfMy8ZzmVW1ks79tEwYpoaAedfPOPCy8Zf40bv76325A
 fIbpfRRty/thyCf4KUOil9gDq9KT9IHH83olOww==
Received: from uls-op-esai3-o.wdc.com ([10.248.3.41])
  by uls-op-esad1-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Aug 2026 20:31:48 -0700
X-CSE-ConnectionGUID: AAxxUzfuROyHlfSNUIOgEA==
X-CSE-MsgGUID: 4fZbcrvWQ2CRfEgqQUSS9Q==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai3-o.wdc.com with ESMTP; 05 Aug 2026 20:31:47 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: John Garry <john.g.garry@oracle.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v2] nvme/068: check module reference count with patience
Date: Thu,  6 Aug 2026 12:31:46 +0900
Message-ID: <20260806033146.2067433-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260805_203204_936916_091FBDDA 
X-CRM114-Status: GOOD (  17.41  )
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

The test case nvme/068 fails depending on the system it runs on with
the failure message below:

   nvme/068 (tr=rdma) (NVMe multipath delayed removal test)     [failed]
       runtime    ...  11.357s
       --- tests/nvme/068.out    2026-08-03 17:24:32.394566266 +0000
       +++ /home/runner/blktests/results/nodev_tr_rdma/nvme/068.out.bad  2026-08-03 18:15:17.461243816 +0000
       @@ -1,3 +1,4 @@
        Running nvme/068
        pwrite: Input/output error
       +module refcount not as original
        Test complete

The test case checks the reference count of the nvme_core module. If the
count is not the expected value, it fails with the error message.
However, when the test system is slow, it takes some time until the
reference count gets updated. When the check is too early, the count
mismatch happens. To avoid the unexpected failure, repeat the reference
count check.

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
I ran the test case nvme/068 with the patch using the kernel that does
not include the commit below:

  3f150f0f010f ("nvme-multipath: put module reference when delayed removal work is canceled")

And I observed the test case failed. When the kernel includes the commit,
the test case passes. This indicates the patch does not break the
reference count sanity check capability of the test case.

Changes from v1:
- Per review comments, handled empty "$refcnt" case and explicit 0 return

 tests/nvme/068 | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/068 b/tests/nvme/068
index 4aee95b..cab57cd 100755
--- a/tests/nvme/068
+++ b/tests/nvme/068
@@ -27,6 +27,19 @@ _delayed_nvme_reconnect_ctrl() {
 	_nvme_connect_subsys
 }
 
+_check_nvme_core_ref_count() {
+	local refcnt i
+
+	for ((i = 0; i < 10; i++)); do
+		refcnt=$(_module_use_count nvme_core)
+		if [ "$refcnt" == "" ] || [ "$refcnt" -eq "$refcnt_orig" ]; then
+			return 0
+		fi
+		sleep 1
+	done
+	return 1
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
@@ -98,8 +111,7 @@ test() {
 	if ! _nvmf_wait_for_state "${def_subsysnqn}" "live" ; then
 		echo "subsystem did not return"
 	fi
-	refcnt=$(_module_use_count nvme_core)
-	if [ "$refcnt" != "" ] && [ "$refcnt" -ne "$refcnt_orig" ]; then
+	if ! _check_nvme_core_ref_count; then
 		echo "module refcount not as original"
 	fi
 
-- 
2.54.0


