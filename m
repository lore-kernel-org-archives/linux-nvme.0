Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E36E7716E
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Dec 2024 11:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aUC6XOGI71kplptDWHJ+khMh52hvAdAh6/oAL2ucGBM=; b=TLMa4uqOc+zG6b0wlxeZH7/O2q
	4uJGJihv7I5Av06qPwnJiVMjIOpKtTJSN0S1E6Wfvkygo5YTVLa3NUb/rkbpsWdN+lnMECsFUZ6i+
	J4HbSXr6LGIY7JMU4lrp+4HYEtWf3H5yX9C3dqiWo6cxdCjxSYnPWkALiVtj6/3XUx82b1bqRhQ2c
	kTqQayN9j06HWEth5efF0FoO3kGKxCTHmo98Xzs2SOqZWbxX2CdgssmlwEfagspGQ8SBB06GD+V0S
	l9JHKVCP7ujEL/OILEP7/KeGSUVm+sJgMtXrWoaZ+Y1Q7P5mRDyXQFGSLCEXSVq3Rz90lBQLiohYc
	5Dcw1VSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tInra-0000000CQiN-3Uwp;
	Wed, 04 Dec 2024 11:48:14 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tInrX-0000000CQgw-2frG
	for linux-nvme@lists.infradead.org;
	Wed, 04 Dec 2024 11:48:13 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B492nrX014371;
	Wed, 4 Dec 2024 11:48:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aUC6XOGI71kplptDW
	HJ+khMh52hvAdAh6/oAL2ucGBM=; b=OT2LFOJPdevNmGSPXEvERjMR3E1Q4Ys8B
	pl6UCn5jnt8qI+3d+AY7SLrMz8VwREhHLRgfMTGBgzmTZ3A1H8uYg4syZfzWYnIT
	ldDBoIxtnWO8ytK4Lgo4dZP5oxRit04aw97ie1Rq4xr+8DIx2MpoTnSBQVuQmx8c
	soxZnVxQD0NepymxOzcJKKcHu+CxyQICtbm2FPADHZf/Jb+S9p2RiR4bykm8hX2n
	8s7hxXw5f7e0jG+JPLhKg5AZa3PABySbLMaCAZOhSv9p7kbHmg93M6l15A8F+2n+
	B2wdtWqrDQfp0xMKFDpv7iuzSXiJeith0wQ40joNfJc8CBojz+4VQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 437s4j7864-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 11:48:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4AuhRm008622;
	Wed, 4 Dec 2024 11:48:04 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8jmj5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 04 Dec 2024 11:48:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B4Bm3R227001486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 4 Dec 2024 11:48:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 021BA20043;
	Wed,  4 Dec 2024 11:48:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08C0720040;
	Wed,  4 Dec 2024 11:48:01 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.32.56])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  4 Dec 2024 11:48:00 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, hch@lst.de,
        kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        gjoyce@linux.ibm.com
Subject: [PATCHv2 blktests 2/2] nvme: add test for writing to file-ns just after disabling it
Date: Wed,  4 Dec 2024 17:17:48 +0530
Message-ID: <20241204114755.190660-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241204114755.190660-1-nilay@linux.ibm.com>
References: <20241204114755.190660-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4OoRQaLiq5uqRxmhGCpPqyR3sQCeHdrV
X-Proofpoint-ORIG-GUID: 4OoRQaLiq5uqRxmhGCpPqyR3sQCeHdrV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 mlxscore=0 mlxlogscore=874 lowpriorityscore=0 bulkscore=0
 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2412040090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241204_034811_797009_9064A562 
X-CRM114-Status: GOOD (  20.05  )
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

This is a regression test for commit 505363957fad ("nvmet: fix nvme
status code when namespace is disabled")[1].

This test creates a regular file backed loop target namespace, disables
the asynchronous event notification for ns-changed events and then write
to the namespace just after disabling it.

[1] https://lore.kernel.org/linux-nvme/tqcy3sveity7p56v7ywp7ssyviwcb3w4623cnxj3knoobfcanq@yxgt2mjkbkam/

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 tests/nvme/055     | 117 +++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/055.out |   2 +
 2 files changed, 119 insertions(+)
 create mode 100755 tests/nvme/055
 create mode 100644 tests/nvme/055.out

diff --git a/tests/nvme/055 b/tests/nvme/055
new file mode 100755
index 0000000..f1f19fe
--- /dev/null
+++ b/tests/nvme/055
@@ -0,0 +1,117 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Nilay Shroff
+#
+# Regression test for commit 505363957fad ("nvmet: fix nvme
+# status code when namespace is disabled").
+
+. tests/nvme/rc
+
+DESCRIPTION="Test nvme write to a loop target ns just after ns is disabled"
+
+QUICK=1
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_nvme_trtype_is_loop
+	_have_kernel_option DEBUG_ATOMIC_SLEEP
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+nvmf_disable_ns_change_aen() {
+
+	local disk="$1"
+	local timeout="5"
+
+	# get async event configuration value
+	aen_conf=$(nvme get-feature "$disk" --feature-id=0xB | cut -d':' -f3)
+
+	# disable async ns change event notfication
+	disable_ns_change=$(( aen_conf & 0xFEFF ))
+
+	# stop receiving aen event for ns change from target
+	nvme set-feature "$disk" --feature-id=0xB \
+			--value="$disable_ns_change" 2>>"$FULL" 1>&2
+
+	start_time=$(date +%s)
+
+	while true; do
+		aen_conf=$(nvme get-feature "$disk" \
+			--feature-id=0xB | cut -d':' -f3)
+
+		# Validate whether ns-changed notification is disabled or not;
+		# If it's already disabled then break and return success
+		if ! (( aen_conf & 0x100 )); then
+			break
+		fi
+
+		sleep 1
+
+		end_time=$(date +%s)
+
+		if (( end_time - start_time > timeout )); then
+			echo "can't disable ns-changed async event "\
+				"notification within $timeout seconds"
+			return 1
+		fi
+	done
+
+	return 0
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local iteration=1 i=0
+
+	_setup_nvmet
+
+	_nvmet_target_setup
+
+	_nvme_connect_subsys
+
+	img="$(mktemp /tmp/blk_img_XXXXXX)"
+	dd if=/dev/urandom of="$img" bs=512 count=1 status=none
+
+	subsys_path="${NVMET_CFS}/subsystems/${def_subsysnqn}"
+	ns_path="${subsys_path}/namespaces/${def_nsid}"
+
+	while (( i < iteration )); do
+		# Wait until async request is processed and default ns
+		# is created
+		if ! _nvmf_wait_for_ns "${def_subsys_uuid}" created; then
+			echo "FAIL"
+			break
+		fi
+
+		disk="/dev/$(_find_nvme_ns "${def_subsys_uuid}")"
+
+		# Disable ns change async event notification from target. It
+		# would ensure that when we disable the target ns, the host
+		# would not receive ns removal notification from target and
+		# so from host we can attempt writing to a disabled ns.
+		if ! nvmf_disable_ns_change_aen "${disk}"; then
+			echo "FAIL"
+			break
+		fi
+
+		# disable target namespace and write to it
+		echo 0 > ${ns_path}/enable
+		nvme write --start-block=1 --block-count=0 \
+			--data-size=512 --data="$img" "$disk" 2>>"$FULL"
+
+		((i++))
+	done
+
+	rm "$img"
+
+	_nvme_disconnect_subsys >> "$FULL" 2>&1
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/055.out b/tests/nvme/055.out
new file mode 100644
index 0000000..bbefc28
--- /dev/null
+++ b/tests/nvme/055.out
@@ -0,0 +1,2 @@
+Running nvme/055
+Test complete
-- 
2.45.2


