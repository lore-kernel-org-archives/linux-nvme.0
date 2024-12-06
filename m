Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FB89E77173
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 11:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jNTKmL4GEDOMnTZSbNpUxulgDxHhXasI1kY3kc+KLUs=; b=oKH/wyf6msEoBjPqvVYnk9s8dJ
	FRjQSfcbaR/k4lyV2j8C8xcSB32eWLIC9X8dxKCTGeXOSvr63arpJUK7Mtc5xtZt5vtBz0NJjXi0E
	VyLQwKNb9jw7SSfedB69MgaNyTgeu/Lz5LUTleSRZEy8uzZClUvy+NVih/IiOGJsUPJQTAU/W8XsH
	OPILbqtPaYiqJtUehj2m4mRa7XlGIbKl/+J24UsWU2yNE78QtHKF+cW6mknRcosemkY7F1cidsbQD
	HnjJQKkPIkr16qb9GM91t2X+sqDJpnzWTZGnKH8TcdKpJt5Kh4ONdkLF7udXOHiJcHtUtjskt7+VB
	WwWgs2sw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJWLw-00000001QWN-23nz;
	Fri, 06 Dec 2024 11:18:32 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJWLu-00000001QVW-3vHb
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 11:18:32 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B627O6T030944;
	Fri, 6 Dec 2024 11:18:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jNTKmL4GEDOMnTZSb
	NpUxulgDxHhXasI1kY3kc+KLUs=; b=fCnYKIFrbAKO+/qS9KCxZ5E52QW+OD4TO
	EqV/ksuLI8lqn+dWcVKjfLQ1r9djVBVbAVgfi54lnkLFj8b18NHMZiOWbstpHYvS
	w46j8P8jJcvh/5zicDKN6q6LZaSorem09r9o4CkNrAk46DwgEUB8dW8dl90V14jw
	QpmNjm/51Ney94wYr/AfDT2mH9moVFGj1GnhSbZmlyHdSkif706iCkc57bL14spD
	EZM0uzVtkGwYxNk52AjWOe99K+PXug1xvP4Z/Ej5Exevb+M/bJuSPcH9YEEhp3no
	tDxzCocj8nJomC8bdT4pxrBSdTlYZD5fCWnb+8zT5q0IjzA1DN6jw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43b6hb7qdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 11:18:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6A2J9U031778;
	Fri, 6 Dec 2024 11:18:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438ehmacp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 11:18:19 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B6BIHWB33096380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 11:18:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E11AE20040;
	Fri,  6 Dec 2024 11:18:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA57020049;
	Fri,  6 Dec 2024 11:18:15 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.179.0.162])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Dec 2024 11:18:15 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, dwagner@suse.de,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        gjoyce@linux.ibm.com
Subject: [PATCHv3 1/2] nvme/052: move nvmf_wait_for_ns() to common/nvme
Date: Fri,  6 Dec 2024 16:48:07 +0530
Message-ID: <20241206111812.489140-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206111812.489140-1-nilay@linux.ibm.com>
References: <20241206111812.489140-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YTJjs4B-R59xFpMV7e_s8wi2QZ5Xybvn
X-Proofpoint-GUID: YTJjs4B-R59xFpMV7e_s8wi2QZ5Xybvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxlogscore=947 clxscore=1015 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_031830_978921_5B84BD9F 
X-CRM114-Status: GOOD (  13.26  )
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

In a preparation for the use of nvmf_wait_for_ns function from
other nvme test script, move nvmf_wait_for_ns from nvme/052 to
common/nvme file so that we can reuse the nvmf_wait_for_ns from
multiple test scripts.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 common/nvme    | 26 ++++++++++++++++++++++++++
 tests/nvme/052 | 30 ++----------------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/common/nvme b/common/nvme
index fd472fe..6b8a57a 100644
--- a/common/nvme
+++ b/common/nvme
@@ -483,6 +483,32 @@ _remove_nvmet_port() {
 	rmdir "${NVMET_CFS}/ports/${port}"
 }
 
+# Wait for the namespace with specified uuid to fulfill the specified condtion,
+# "created" or "removed".
+_nvmf_wait_for_ns() {
+    local ns
+    local timeout="5"
+    local uuid="$1"
+    local condition="$2"
+
+    ns=$(_find_nvme_ns "${uuid}" 2>> "$FULL")
+
+    start_time=$(date +%s)
+    while [[ -z "$ns" && "$condition" == created ]] ||
+              [[ -n "$ns" && "$condition" == removed ]]; do
+        sleep .1
+        end_time=$(date +%s)
+        if (( end_time - start_time > timeout )); then
+            echo "namespace with uuid \"${uuid}\" not " \
+                "${condition} within ${timeout} seconds"
+            return 1
+        fi
+        ns=$(_find_nvme_ns "${uuid}" 2>> "$FULL")
+    done
+
+    return 0
+}
+
 _create_nvmet_ns() {
 	local subsysnqn="${def_subsysnqn}"
 	local nsid="${def_nsid}"
diff --git a/tests/nvme/052 b/tests/nvme/052
index 8443c90..22d8a9e 100755
--- a/tests/nvme/052
+++ b/tests/nvme/052
@@ -20,32 +20,6 @@ set_conditions() {
 	_set_nvme_trtype "$@"
 }
 
-# Wait for the namespace with specified uuid to fulfill the specified condtion,
-# "created" or "removed".
-nvmf_wait_for_ns() {
-	local ns
-	local timeout="5"
-	local uuid="$1"
-	local condition="$2"
-
-	ns=$(_find_nvme_ns "${uuid}" 2>> "$FULL")
-
-	start_time=$(date +%s)
-	while [[ -z "$ns" && "$condition" == created ]] ||
-		      [[ -n "$ns" && "$condition" == removed ]]; do
-		sleep .1
-		end_time=$(date +%s)
-		if (( end_time - start_time > timeout )); then
-			echo "namespace with uuid \"${uuid}\" not " \
-				"${condition} within ${timeout} seconds"
-			return 1
-		fi
-		ns=$(_find_nvme_ns "${uuid}" 2>> "$FULL")
-	done
-
-	return 0
-}
-
 test() {
 	echo "Running ${TEST_NAME}"
 
@@ -65,7 +39,7 @@ test() {
 		uuid=$(_create_nvmet_ns --blkdev "$filepath" --nsid "${nsid}")
 
 		# wait until async request is processed and ns is created
-		if ! nvmf_wait_for_ns "${uuid}" created; then
+		if ! _nvmf_wait_for_ns "${uuid}" created; then
 			echo "FAIL"
 			rm "$filepath"
 			break
@@ -74,7 +48,7 @@ test() {
 		_remove_nvmet_ns "${def_subsysnqn}" "${nsid}"
 
 		# wait until async request is processed and ns is removed
-		if ! nvmf_wait_for_ns "${uuid}" removed; then
+		if ! _nvmf_wait_for_ns "${uuid}" removed; then
 			echo "FAIL"
 			rm "$filepath"
 			break
-- 
2.45.2


