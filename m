Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211B7CA0ED3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Sep 2024 10:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LoSlXJHF6Q4V8Becaw6dU3ss7kD6Fg4HZcRLSN0Pfuc=; b=WDPennrx4Gxbe6SOYfvO2yBMAS
	/pqi1IbwYDDNeh8JefxJRV5mw3mFBvsVijBZG3NUxYKMvR4T8h8ysR7k6anYrEr75FwZh8I1GTFHT
	iFLIp2r7znSeqJvDsxMdBJ0e30ns/J84yIoT0RZKticOkHxd7ulsE4b9DfBYHnrwwDheZR02ZroaG
	4t/zSeCn7JBHeSskai5fuvN8tixvrkBfUJb77lLkkcc0s73vQmdOFKiZ4ppPbNGkOJxFQSNOPdp3f
	uzu2Qo40pabrglHnHbKKgdAjJu6qM/PbGb8O5tbV4RNge/M9FPJycn4CENKYAhA6fdMSqEim0pg1o
	98M339TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl4i5-0000000E0MI-2BPy;
	Mon, 02 Sep 2024 10:55:01 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sl4i2-0000000E0KD-0xsu
	for linux-nvme@lists.infradead.org;
	Mon, 02 Sep 2024 10:54:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1725274498; x=1756810498;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JyPcls83KWw9SuUDl/7+enyapQXtuGJ/1njd0TwRkzY=;
  b=rjHBf4s5bm8O+e2PlQ7V0GVzDDEM5vuL0rg+GCf5LhEi6kuB9zGR+MZg
   SZ2dqBd7S4d53x15VYOIvmvBNmTdk9zc285Q/enje5ct72G97IrCd/jgy
   ct5bSWCAUR7I3MUljZaq9LaQADeUFcc2UzvLionGtoJb5wgcXKFA692Lv
   3WGxDoZibdhLwPcwslK/ddnjF6e91NsZJZ7RoKYlgMAYY1NX7dVLmvYN7
   HSTsXxmZSxhvuy4JQDrOsehw4gENepG453CAjCUCgmZWuVz6emYlyNXKQ
   x3UICndoP4Gjkdo54tdYIoflc7WBWFtq3eWKU+BfkO/v7K2DKibLHjwI2
   g==;
X-CSE-ConnectionGUID: GEH/e7V5TDiNB4m4W+c/Rw==
X-CSE-MsgGUID: OHxn3rx/QNWBbQw8s2A1IA==
X-IronPort-AV: E=Sophos;i="6.10,195,1719849600"; 
   d="scan'208";a="25743028"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2024 18:54:56 +0800
IronPort-SDR: 66d58b65_qvEZABUcGVUsu4RJ1tJg0Ze/aJS0xYLA8uaYCP8kEvdVhce
 rS8n+Tn55pLqkG6AvVPZIQHRTTueZ9W/FvgvNrA==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 02:54:46 -0700
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 02 Sep 2024 03:54:55 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Nilay Shroff <nilay@linux.ibm.com>,
	Yi Zhang <yi.zhang@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests v3] nvme/052: wait for namespace removal before recreating namespace
Date: Mon,  2 Sep 2024 19:54:54 +0900
Message-ID: <20240902105454.1244406-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240902_035458_352237_E982629C 
X-CRM114-Status: GOOD (  18.24  )
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
the namespace. Modify nvmf_wait_for_ns() so that it can wait for
namespace creation and removal. Call nvmf_wait_for_ns() for removal
after _remove_nvmet_ns() call. While at it, reduce the wait time unit
from 1 second to 0.1 second to shorten test time.

The test case intends to catch the regression fixed by the kernel commit
ff0ffe5b7c3c ("nvme: fix namespace removal list"). I reverted the commit
from the kernel v6.11-rc4, then confirmed that the test case still can
catch the regression with this change.

Link: https://lore.kernel.org/linux-block/tczctp5tkr34o3k3f4dlyhuutgp2ycex6gdbjuqx4trn6ewm2i@qbkza3yr5wdd/
Fixes: 077211a0e9ff ("nvme: add test for creating/deleting file-ns")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v2:
* Avoided conditional stderr redirect of _find_nvme_ns

Changes from v1:
* Reused nvmf_wait_for_ns() instead of introuducing nvmf_wait_for_ns_removal()
* Added check of nvme_wait_for_ns() return value

 tests/nvme/052 | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/tests/nvme/052 b/tests/nvme/052
index cf6061a..401f043 100755
--- a/tests/nvme/052
+++ b/tests/nvme/052
@@ -20,23 +20,27 @@ set_conditions() {
 	_set_nvme_trtype "$@"
 }
 
+# Wait for the namespace with specified uuid to fulfill the specified condtion,
+# "created" or "removed".
 nvmf_wait_for_ns() {
 	local ns
 	local timeout="5"
 	local uuid="$1"
+	local condition="$2"
 
-	ns=$(_find_nvme_ns "${uuid}")
+	ns=$(_find_nvme_ns "${uuid}" 2>> "$FULL")
 
 	start_time=$(date +%s)
-	while [[ -z "$ns" ]]; do
-		sleep 1
+	while [[ -z "$ns" && "$condition" == created ]] ||
+		      [[ -n "$ns" && "$condition" == removed ]]; do
+		sleep .1
 		end_time=$(date +%s)
 		if (( end_time - start_time > timeout )); then
 			echo "namespace with uuid \"${uuid}\" not " \
-				"found within ${timeout} seconds"
+				"${condition} within ${timeout} seconds"
 			return 1
 		fi
-		ns=$(_find_nvme_ns "${uuid}")
+		ns=$(_find_nvme_ns "${uuid}" 2>> "$FULL")
 	done
 
 	return 0
@@ -63,14 +67,21 @@ test() {
 		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$i" "${uuid}"
 
 		# wait until async request is processed and ns is created
-		nvmf_wait_for_ns "${uuid}"
-		if [ $? -eq 1 ]; then
+		if ! nvmf_wait_for_ns "${uuid}" created; then
 			echo "FAIL"
 			rm "$(_nvme_def_file_path).$i"
 			break
 		fi
 
 		_remove_nvmet_ns "${def_subsysnqn}" "${i}"
+
+		# wait until async request is processed and ns is removed
+		if ! nvmf_wait_for_ns "${uuid}" removed; then
+			echo "FAIL"
+			rm "$(_nvme_def_file_path).$i"
+			break
+		fi
+
 		rm "$(_nvme_def_file_path).$i"
 	}
 	done
-- 
2.45.2


