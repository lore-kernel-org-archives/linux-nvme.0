Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 777D8E77188
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jan 2025 07:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=51M4k8xEGlSa/3RksqnF8+qMsOs/hHDHxf4Vu47OMo4=; b=3gAeX28JP99rTlibrHdQQfAJwQ
	vxKu4bUrOd6Wokl7dEPqzLfEJdW6L836Qp4EORPKNVbNriuyuSJfewwSXBQ93cedJ7o8Ebpv2+KQk
	OQj6/kdus18fadR5rAFud5H5AT91fs26iBqsLvStXltVM3OsNgQZoNZXpqcQszItSpD5qKpPdrr+s
	qDwwG8UUgqr5Hkb+5ADKJ3efBPsDNAiI4uzTa4Ec72ThLTzXpJPl6s7mHP+Az9n8/TgtPe3Jy+5o9
	aayqpBACXQCgT/SSOVhTV+vJMRulk1sAffxPk9eJ4B0EbmMvPrGtIKpfUCRtjH0t/67n9Mbrb7XN8
	6vIHkudw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYK8f-0000000E1Hw-3DYM;
	Thu, 16 Jan 2025 07:18:01 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYK8d-0000000E1HV-3nCc
	for linux-nvme@lists.infradead.org;
	Thu, 16 Jan 2025 07:18:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737011880; x=1768547880;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pbD+DT7qqtb70lmFhSoqJ6+Jxdzx93WFHz9jDMO5/pU=;
  b=G0yOJzDf58WIVrMbivMFuD8JkbtdUK4hflxwTCeKCvvkyPjcEI8qDFQD
   YVX8ZdR4SKNVFSdoBropZbcWwbNkN8w/ddhPDBpGlbgn/jOy8lvqeNVgV
   PobLucA0q5cR0geXNK5PTB9hG6Cx4uvafcVWt+fk0kYsv+B7Buz49JyBK
   LdhMrw1uUaoJ+TWOFQwUk4ePDuh925UgqxEP+WukIt0wLVRRsnznQZqBQ
   koAP+lG8q1tKJgvg4Zl5Du1S4yXXkYH7wnRmfiSJBtaEE1wThAZEBSzVZ
   rcJTvMjBvrBg9zpRL8VzWtkRMPvh9UCq65jkDC2j+SGmXLM8hVSxMTYPE
   A==;
X-CSE-ConnectionGUID: Lns+C7R8RD+XBCZg1tV8Pg==
X-CSE-MsgGUID: 74pHRMQOTByFCHvguaDDkg==
X-IronPort-AV: E=Sophos;i="6.13,208,1732550400"; 
   d="scan'208";a="36059833"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jan 2025 15:17:56 +0800
IronPort-SDR: 6788a3ca_iFQcBE7p0mwiigG7R26TwNAYgKfYHZ+9UhxEZ8AhRBxzjKr
 jj966amFOijrDkP+cDg9OQQ1F9+IilfqDYDVopA==
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 15 Jan 2025 22:14:34 -0800
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip02.wdc.com with ESMTP; 15 Jan 2025 23:17:55 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Martin Wilck <martin.wilck@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH blktests] nvme/053: do not use awk
Date: Thu, 16 Jan 2025 16:17:54 +0900
Message-ID: <20250116071754.1161787-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250115_231759_949143_15BFE246 
X-CRM114-Status: UNSURE (   9.61  )
X-CRM114-Notice: Please train this message.
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

Luis observed that the test case nvme/053 fails in his environment [1]
due to the following awk error message:

 awk: ...rescan.awk:2: warning: The time extension is obsolete.
 Use the timex extension from gawkextlib

To avoid the failure and reduce dependencies, do not use awk in the test
case. Instead, introduce the bash function get_sleep_time() to calculate
the sleep time. Also implement the controller rescan loop in bash,
following Martin's original patch [2].

[1] https://lore.kernel.org/linux-block/20241218111340.3912034-1-mcgrof@kernel.org/
[2] https://lore.kernel.org/linux-nvme/20240822193814.106111-3-mwilck@suse.com/

Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/nvme/053 | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/tests/nvme/053 b/tests/nvme/053
index 3ade8d3..99dbd38 100755
--- a/tests/nvme/053
+++ b/tests/nvme/053
@@ -12,8 +12,15 @@ DESCRIPTION="test controller rescan under I/O load"
 TIMED=1
 : "${TIMEOUT:=60}"
 
+get_sleep_time() {
+	local duration=$((RANDOM % 50 + 1))
+
+	echo "$((duration / 10)).$((duration % 10))"
+}
+
 rescan_controller() {
-	local path
+	local path finish
+
 	path="$1/rescan_controller"
 
 	[[ -f "$path" ]] || {
@@ -21,24 +28,12 @@ rescan_controller() {
 		return 1
 	}
 
-	awk -f "$TMPDIR/rescan.awk" \
-	    -v path="$path" -v timeout="$TIMEOUT" -v seed="$2" &
-}
-
-create_rescan_script() {
-	cat >"$TMPDIR/rescan.awk" <<EOF
-@load "time"
-
-BEGIN {
-    srand(seed);
-    finish = gettimeofday() + strtonum(timeout);
-    while (gettimeofday() < finish) {
-	sleep(0.1 + 5 * rand());
-	printf("1\n") > path;
-	close(path);
-    }
-}
-EOF
+	finish=$(($(date +%s) + TIMEOUT))
+	while [[ $(date +%s) -le $finish ]]; do
+		# sleep interval between 0.1 and 5s
+		sleep "$(get_sleep_time)"
+		echo 1 >"$path"
+	done
 }
 
 test_device() {
@@ -46,7 +41,6 @@ test_device() {
 	local i st line
 
 	echo "Running ${TEST_NAME}"
-	create_rescan_script
 
 	while IFS= read -r line; do
 		ctrls+=("$line")
-- 
2.47.0


