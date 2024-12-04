Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5152E7716B
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2024 11:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jNTKmL4GEDOMnTZSbNpUxulgDxHhXasI1kY3kc+KLUs=; b=oESKIcxrkhN3zysbdVL9r8ltf2
	ZScubV8mJLYeSCbe4L+kG4jrH29qyzjkuTgF0mGvSoMCeUuCp9uSOPCIksebz5NX5zfcVFS6ZSB3e
	xJ5u3YRaRrbop1MipegnQ0SbrrJOSoSCSMKe0cqlK5hJvg29alrj4wNHOBwB9GCw8sK/CzowzNoAV
	Yb30l68yqA5eUyD4WIdSGXDTttsVEfIQifUCD+nqT6Genq7TzLrTYhnL/6KwvtFJ1WW3XW1Nmu5Ay
	Jn+yHw2/fDrhfelMeLUIa1OuAYYp+6glvYRMv6Q6Mlb4/TuIPqaWpxt22rTUiLuoOTl+lkBrXZ7Oo
	ikSBocIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tInra-0000000CQiE-0eMS;
	Wed, 04 Dec 2024 11:48:14 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tInrX-0000000CQgv-2fzd
	for linux-nvme@lists.infradead.org;
	Wed, 04 Dec 2024 11:48:12 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B48mLFX011706;
	Wed, 4 Dec 2024 11:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jNTKmL4GEDOMnTZSb
	NpUxulgDxHhXasI1kY3kc+KLUs=; b=gj4uyzv+eGRACa/AHiBt02T5K+TWHw6cL
	yW0QXz7C2CDs1+uZa21AG1OFehQA9TLU+3yQFUakgklGHuhCEcEj7XBmZlN7Gwii
	Oo0jMjvq3+opjsvX94WU86PkgeE+VdEfk054fQD9GY54dR/6px1q0xEbL+s2Qu7J
	k9k3EiyZnhBm4q+cd+H/mJPoIJgPbkf5OpBv24tjWQGHj+sMEVF1eRVyPBssF5Wr
	gmLCqe4yIxn6I0bsl84EAyuporaIUXRG+ZjMrJhYZWp93ECN8DjTohI79+CisiAt
	4Ax5fJJM7xmI9YDu+QQkD+xsV7bXiR5fIe3RGJC+HXF1eaatuACOA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437s4j785x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 11:48:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B47ToB3023568;
	Wed, 4 Dec 2024 11:48:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 438e1n3m5p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 11:48:02 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B4Bm08Z33554780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Dec 2024 11:48:00 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD38A2004B;
	Wed,  4 Dec 2024 11:48:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C67BE20040;
	Wed,  4 Dec 2024 11:47:58 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.32.56])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Dec 2024 11:47:58 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, hch@lst.de,
        kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        gjoyce@linux.ibm.com
Subject: [PATCHv2 blktests 1/2] nvme/052: move nvmf_wait_for_ns() to common/nvme
Date: Wed,  4 Dec 2024 17:17:47 +0530
Message-ID: <20241204114755.190660-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204114755.190660-1-nilay@linux.ibm.com>
References: <20241204114755.190660-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pkF82ZmgJDFsD9fGfP5ALPuAyrhyxxpB
X-Proofpoint-ORIG-GUID: pkF82ZmgJDFsD9fGfP5ALPuAyrhyxxpB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=947 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412040090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_034811_796714_A9258A2E 
X-CRM114-Status: GOOD (  14.30  )
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


