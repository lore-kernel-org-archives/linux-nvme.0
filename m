Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90804E7717B
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 11:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=erHMzwiJKozq1v13y4UfUXpZ89QIbeeOXbN5YlQeyi4=; b=ax/5Xvgy2U9mFaLqaD1o/kPIH8
	truce0ACqUpcqYlRJwC8uMPRPip6aFF6WhxJVF4/ByvjV2wjbV3A6QChSn3lc5xJmsd08CbzuPpiT
	5C4qlyIWsM8g5uVBMViaFOnGasFFfonU2prumyU+mcobCJewj6RNiDYNiuF1Jf6jznijwL15oBsJI
	a67tWA8ePaMIqCtKaQaijkXfi7MdcqvPyl4Zj77xi9mbA2ZOqnk1eE4kUKVp/bFvFhCZI67r+pSpL
	ZGBi0LNrg37jbpGv5ZMntjjponPM97FXvl7otyaE9FXYJRtfbqYsfDZ2gtUq/JVR/kJ3c/QlPeguC
	utiJIHAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJWLy-00000001QYA-3pb9;
	Fri, 06 Dec 2024 11:18:34 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJWLw-00000001QVb-01Zz
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 11:18:33 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B67UYsr000748;
	Fri, 6 Dec 2024 11:18:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=erHMzwiJKozq1v13y
	4UfUXpZ89QIbeeOXbN5YlQeyi4=; b=LV5hsj5OP/z/2YUpVsSJewHUY7H28RUBQ
	0qhxxFrJgj/I3YHAAgg15DLuzKvVILxb8jQcjRAxcepWHlbDrjTUlyOWSo/9nuZQ
	YBMlvzPRPZpIbxK8zw+dlqYs0avlLSwUIJWxgdy+6gwnO/5hGo/WnN53kdNVUuQM
	jT+AtVsk045kqWW0yEVabfxm0yiavOu6Kn2ni2UljmtG4W/vU5l7cwAzu5mhIIBx
	90iLaevmawLfzQ945ycwgtXvh8E0VERhJypEcC/m5DuS6oxd2SZLZdm0tiRgDqcC
	u215pFkxymiSyTNh+unllKpv8TQrVVVt/WB5u+TN2jRDVmqXDLuxA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43bvxkrwb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 11:18:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B6A2bWJ008622;
	Fri, 6 Dec 2024 11:18:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 438f8jx9n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Dec 2024 11:18:22 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B6BIKwo35455486
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Dec 2024 11:18:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 649B520049;
	Fri,  6 Dec 2024 11:18:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4146320040;
	Fri,  6 Dec 2024 11:18:18 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.179.0.162])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Dec 2024 11:18:18 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, dwagner@suse.de,
        hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@kernel.dk,
        gjoyce@linux.ibm.com
Subject: [PATCHv3 2/2] nvme: add test for writing to file-ns just after disabling it
Date: Fri,  6 Dec 2024 16:48:08 +0530
Message-ID: <20241206111812.489140-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206111812.489140-1-nilay@linux.ibm.com>
References: <20241206111812.489140-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: es9Xyj-Png8uWBGRDDFQ4PUCYgPgYFhg
X-Proofpoint-ORIG-GUID: es9Xyj-Png8uWBGRDDFQ4PUCYgPgYFhg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=811 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412060081
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_031832_165138_F6A20E37 
X-CRM114-Status: GOOD (  20.54  )
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
index 0000000..e53a759
--- /dev/null
+++ b/tests/nvme/055
@@ -0,0 +1,117 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Nilay Shroff
+#
+# Regression test for commit 505363957fad ("nvmet: fix nvme
+# status code when namespace is disabled"). We may hit this
+# regression using nvme/052 however that depends on the udev
+# rules which triggers the IO to a ns after it's enabled.
+# The udev rules could change from one distro to another and
+# it's not in our control. So we implemented this test where
+# we have full control of the test.
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
+	# mask async ns change event notfication
+	mask_ns_change=$(( aen_conf & 0xFEFF ))
+
+	# stop receiving aen event for ns change from target
+	nvme set-feature "$disk" --feature-id=0xB \
+			--value="$mask_ns_change" 2>>"$FULL" 1>&2
+
+	start_time=$(date +%s)
+
+	while true; do
+		aen_conf=$(nvme get-feature "$disk" \
+			--feature-id=0xB | cut -d':' -f3)
+
+		# Validate whether ns-changed notification is masked or not;
+		# If it's already masked then break and return success
+		if ! (( aen_conf & 0x100 )); then
+			break
+		fi
+
+		sleep 1
+
+		end_time=$(date +%s)
+
+		if (( end_time - start_time > timeout )); then
+			echo "can't mask ns-changed async event "\
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
+		# Mask ns change async event notification from target. It
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
+			--data-size=512 --data="/dev/urandom" "$disk" 2>>"$FULL"
+
+		((i++))
+	done
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


