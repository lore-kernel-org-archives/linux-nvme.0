Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37667C2BA15
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jun 2024 10:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9cviPDMkSoytLVdNjIT5PIyf2EgfbdePnFfNSotHAb8=; b=igMtMcJq0s+IGq
	AKi3bMOgD3/oWTIG/zv/sxynYeJK9nnRWxV3ZCUCPD/JEJdFmB1genewE4q2PnLATmRKascxeA7Ij
	v+R6oDmLz1qHfrVBnAhNQOuD/1G7hxtacF79eOi12WpN6KTkHzmhxSjMGUw82A0iJpGDngT4ULrZN
	cp9+m3p17acf3HsvPpBSMD9YHDdu5wDEujYq2eq3IFSm3E0k+rSAPXyF8Gny1eqzJlMCN3WeQDv6W
	mrrA/nfT0ytG/RTaTKlLANeM3fC/TFQxdm5xzjI6O0w1/5B8XKnd0hRY0tDFQjZMfqKB6g875J6lM
	dC06ZnPN42yJXs7OXMNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJsr0-00000000qW7-3y93;
	Wed, 19 Jun 2024 10:47:50 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJsqu-00000000qTw-2gU7
	for linux-nvme@lists.infradead.org;
	Wed, 19 Jun 2024 10:47:48 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J9A6WF013786;
	Wed, 19 Jun 2024 10:47:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:content-transfer-encoding
	:mime-version; s=pp1; bh=9cviPDMkSoytLVdNjIT5PIyf2EgfbdePnFfNSot
	HAb8=; b=Ojd57aHMsEj7eSTi3ovRU1C3rPCRHZ09N4j00c+ywQLJh1Knnuy8CBf
	/JwD35gjzCtRjYyx/f4qD2NyPOP25MEcG1XXfAUwJZOpceyPMRv35/Ei5bKGwbko
	8eyZvzLdhyqG3bggAzhAIN74+qzdZTym2deW258LNfi/uK0rsf/tWKQMP4m9JQxi
	hp4uHY0cvMA1u1nnjVmT8zvrRYXunC/X8NAJkXQhIlaZjq+j2VvfPQBgGlA4QPOF
	Zx7e5DSSHbgMKlePfKBR87fldB2x6y6OTYD+QYibFWSrV0McrjnABxGBVhqlexoP
	zafkPlE9aKXTjNuPog3K2IliPIDh5XA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yuvf206ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 10:47:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45J9NZmx006285;
	Wed, 19 Jun 2024 10:47:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysn9uut8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 10:47:31 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JAlPt852494716
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 10:47:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A83122004F;
	Wed, 19 Jun 2024 10:47:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE94C20043;
	Wed, 19 Jun 2024 10:47:22 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.43.48.107])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Jun 2024 10:47:22 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: shinichiro.kawasaki@wdc.com, chaitanyak@nvidia.com, dwagner@suse.de
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de,
        linux-nvme@lists.infradead.org, venkat88@linux.vnet.ibm.com,
        sachinp@linux.vnet.ibm.com, linux-block@vger.kernel.org,
        gjoyce@linux.ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv3 blktests] nvme: add test for creating/deleting file-ns
Date: Wed, 19 Jun 2024 16:16:40 +0530
Message-ID: <20240619104705.2921801-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6LGaCSBAxQSLYp8M2txVeK7B7VR4CZ-h
X-Proofpoint-GUID: 6LGaCSBAxQSLYp8M2txVeK7B7VR4CZ-h
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 phishscore=0 mlxlogscore=824
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190077
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240619_034746_346539_09DAE8E1 
X-CRM114-Status: GOOD (  19.38  )
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

This is regression test for commit be647e2c76b2 (nvme: use srcu for
iterating namespace list)[1]. It is fixed in commit ff0ffe5b7c3c(nvme:
fix namespace removal list)[2].

This test uses a regular file backed loop device for creating and then
deleting an NVMe namespace in a loop.

[1] https://lore.kernel.org/all/2312e6c3-a069-4388-a863-df7e261b9d70@linux.vnet.ibm.com/
[2] https://lore.kernel.org/all/20240613164246.75205-1-kbusch@meta.com/

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Changes from v2:
    - Use defaults for creating and connecting to nvme target (Daniel)
Changes from v1:
    - Add nvme prefix in the subject line instead of loop (Chaitanya)
    - Enrich the commit log with details including link to regression 
      discussion and fix commit (Chaitanya)
    - Few other formatting cleanup (Chaitanya)
    - Add fix commit information in the test header (Shinichiro)
    - Instead of using default 1000 iteration for test,
      set the test iteration count to 20 (Shinichiro)
    - Update test case no. to nvme/052 (Shinichiro)

---
 tests/nvme/052     | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/052.out |  2 ++
 2 files changed, 56 insertions(+)
 create mode 100755 tests/nvme/052
 create mode 100644 tests/nvme/052.out

diff --git a/tests/nvme/052 b/tests/nvme/052
new file mode 100755
index 0000000..ec72e1f
--- /dev/null
+++ b/tests/nvme/052
@@ -0,0 +1,54 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Nilay Shroff
+#
+# Regression test for commit be647e2c76b2(nvme: use srcu for iterating
+# namespace list). This regression is resolved with commit ff0ffe5b7c3c
+# (nvme: fix namespace removal list)
+
+. tests/nvme/rc
+
+DESCRIPTION="Test file-ns creation/deletion under one subsystem"
+
+requires() {
+	_nvme_requires
+	_have_loop
+	_require_nvme_trtype_is_loop
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	_setup_nvmet
+
+	local iterations=20
+
+	_nvmet_target_setup
+
+	_nvme_connect_subsys
+
+	# start iteration from ns-id 2 because ns-id 1 is created
+	# by default when nvme target is setup. Also ns-id 1 is
+	# deleted when nvme target is cleaned up.
+	for ((i = 2; i <= iterations; i++)); do {
+		truncate -s "${NVME_IMG_SIZE}" "$(_nvme_def_file_path).$i"
+		_create_nvmet_ns "${def_subsysnqn}" "${i}" "$(_nvme_def_file_path).$i"
+
+		# allow async request to be processed
+		sleep 1
+
+		_remove_nvmet_ns "${def_subsysnqn}" "${i}"
+		rm "$(_nvme_def_file_path).$i"
+	}
+	done
+
+	_nvme_disconnect_subsys >> "${FULL}" 2>&1
+
+	_nvmet_target_cleanup
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/052.out b/tests/nvme/052.out
new file mode 100644
index 0000000..f2d186d
--- /dev/null
+++ b/tests/nvme/052.out
@@ -0,0 +1,2 @@
+Running nvme/052
+Test complete
-- 
2.45.1


