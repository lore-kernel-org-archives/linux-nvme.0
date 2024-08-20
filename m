Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C58C531DF
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Aug 2024 10:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=b6L48GmNE/Gu7H9I70gzpd7/V9PXc93P8c/Ytunwzmo=; b=pIsOUpqAYb6w7jkszfLIwVJFys
	Uy/cJN4sQwQit44iwfUgnQfXmFxansfZsMXy/LTCzwCcODl8c6QSFbT8QM4Udi1BUfcJCCAAGtOuF
	vDDZLa5D3//4rrgiY9gfqqBDOr/xNVyn0AkQdcRawZCS45X5Uhz6eCgDexwAnN2RtcvS2yTbV1K3D
	vimis6kpW3xNqGTy5I7KZPL0FqV9guV65sUIODcgvAG7SlQZcKr540pkLlJ6JG8xSw7tMKjX6CN3V
	mGFDNGozRbdsOmxq1DvvXYAGVkd9ojOM26vwYiTEGudS62jxwK73USEWA2pNm6E2cNSzJXx8SSpsS
	8AQWKm+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgLyR-00000004lyg-1zdg;
	Tue, 20 Aug 2024 10:20:23 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgLyL-00000004lx7-2vtK
	for linux-nvme@lists.infradead.org;
	Tue, 20 Aug 2024 10:20:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724149216; x=1755685216;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4o+DhSlo/OhU/pk4QGtJc7Pdkc2s297MR/AIhOIm2/8=;
  b=MQaX4gggFXwYr3ZGuApBDqrIBUp70yOHlT5AwrkfvHiIEfPy4ADTEWLY
   LEXyE4Fcy98AV8nHvidqU2OO964NAF/NN9p9ubqMwf8IImILA9vnNEllu
   XB1RLtNfb7AYPM8gZCcmFPZ/FiSnWPVbg2jHceTLC4QHvH+rD6SIankLH
   BcAEOljC09pL/l7t0akc0EAKdAzToqtlq1/vNoDVdDOBoUdIuqTR46U6T
   XFzG4Ey8rA6fKkCzI32F/7c6u5dl1jmGDW3X2xslYWoPh1H+Kclzu5Nj3
   lv4WtZWOYHZylB2TUnuCIvUwtpCfWimjrOHB1Oqlp1q91aHsn6Vm5mG3L
   Q==;
X-CSE-ConnectionGUID: WvF9QcPMT5+2zLmgdu9PRg==
X-CSE-MsgGUID: ZNASQXQYS5eyPm4LVvGL6g==
X-IronPort-AV: E=Sophos;i="6.10,161,1719849600"; 
   d="scan'208";a="24700401"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 20 Aug 2024 18:20:13 +0800
IronPort-SDR: 66c46128_aVXNQCRkS4+idfqJFVd1scntFLDniADefMORDXe/fdC3I0o
 fLcGuXGk2Cwe6J0/lIxCic3LvwD3/h8tdTl+OSw==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Aug 2024 02:26:01 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 20 Aug 2024 03:20:14 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/052: wait for namespace removal before recreating namespace
Date: Tue, 20 Aug 2024 19:20:13 +0900
Message-ID: <20240820102013.781794-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240820_032017_774360_08EE0CB8 
X-CRM114-Status: GOOD (  18.41  )
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

The CKI project reported that the test case nvme/052 fails occasionally
with the errors below:

  nvme/052 (tr=loop) (Test file-ns creation/deletion under one subsystem) [failed]
      runtime    ...  22.209s
      --- tests/nvme/052.out    2024-07-30 18:38:29.041716566 -0400
      +++
+/mnt/tests/gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/archive/production/kernel-t\
ests-production.zip/storage/blktests/nvme/nvme-loop/blktests
+/results/nodev_tr_loop/nvme/052.out.bad        2024-07-30 18:45:35.438067452 -0400
      @@ -1,2 +1,4 @@
       Running nvme/052
      +cat: /sys/block/nvme1n2/uuid: No such file or directory
      +cat: /sys/block/nvme1n2/uuid: No such file or directory
       Test complete

The test case repeats creating and removing namespaces. When the test
case removes the namespace by echoing 0 to the sysfs enable file, this
echo write does not wait for the completion of the namespace removal.
Before the removal completes, the test case recreates the namespace.
At this point, the sysfs uuid file for the old namespace still exists.
The test case misunderstands that the the sysfs uuid file would be for
the recreated namespace, and tries to read it. However, the removal
process for the old namespace deletes the sysfs uuid file at this point.
Then the read attempt fails and results in the errors.

To avoid the failure, wait for the namespace removal before recreating
the namespace. For this purpose, add the new helper function
nvmf_wait_for_ns_removal(). To specify the namespace to wait for, get
the name of the namespace from nvmf_wait_for_ns(), and pass it to
nvmf_wait_for_ns_removal().

The test case intends to catch the regression fixed by the kernel commit
ff0ffe5b7c3c ("nvme: fix namespace removal list"). I reverted the commit
from the kernel v6.11-rc4, then confirmed that the test case still can
catch the regression with this change.

Link: https://lore.kernel.org/linux-block/tczctp5tkr34o3k3f4dlyhuutgp2ycex6gdbjuqx4trn6ewm2i@qbkza3yr5wdd/
Fixes: 077211a0e9ff ("nvme: add test for creating/deleting file-ns")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Nelay, Yi, thank you for the feedbacks for the discussion
thread at the Link. Here's the formal fix patch.

 tests/nvme/052 | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/tests/nvme/052 b/tests/nvme/052
index cf6061a..e1ac823 100755
--- a/tests/nvme/052
+++ b/tests/nvme/052
@@ -39,15 +39,32 @@ nvmf_wait_for_ns() {
 		ns=$(_find_nvme_ns "${uuid}")
 	done
 
+	echo "$ns"
 	return 0
 }
 
+nvmf_wait_for_ns_removal() {
+	local ns=$1 i
+
+	for ((i = 0; i < 10; i++)); do
+		if [[ ! -e /dev/$ns ]]; then
+			return
+		fi
+		sleep .1
+		echo "wait removal of $ns" >> "$FULL"
+	done
+
+	if [[ -e /dev/$ns ]]; then
+		echo "Failed to remove the namespace $ns"
+	fi
+}
+
 test() {
 	echo "Running ${TEST_NAME}"
 
 	_setup_nvmet
 
-	local iterations=20
+	local iterations=20 ns
 
 	_nvmet_target_setup
 
@@ -63,7 +80,7 @@ test() {
 		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$i" "${uuid}"
 
 		# wait until async request is processed and ns is created
-		nvmf_wait_for_ns "${uuid}"
+		ns=$(nvmf_wait_for_ns "${uuid}")
 		if [ $? -eq 1 ]; then
 			echo "FAIL"
 			rm "$(_nvme_def_file_path).$i"
@@ -71,6 +88,7 @@ test() {
 		fi
 
 		_remove_nvmet_ns "${def_subsysnqn}" "${i}"
+		nvmf_wait_for_ns_removal "$ns"
 		rm "$(_nvme_def_file_path).$i"
 	}
 	done
-- 
2.45.2


