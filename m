Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B222D6EBE2
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2024 08:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EzjsWq9HnxVT+oS4MvEFF+5XxUb7XjXzmNmW2fG4MRc=; b=Ttveg+tMGMtID12HyoC7xpMvwY
	0kTr66gGbRliQfIOUo9SDl1YOGcdimeinoyXb/mayjr2tqmoSBPUu5bFib77rWT+qljOHcNnA18tk
	6kS26I63KIOBurLDPzZT4lcgL80Q74Tw/BN0qPaO4YO8m44k2RMklPvS9dHXKPwn0ZN6PlLJryuDL
	7Fnf2xtOglfYLFEG9aBibPJ94Inh3VhL8OoZzqpjWvVJkqCUVuvCdxO8I/2jVKXcESGPCLMDiBh6S
	pJtkE4DfakxeayssJHfyJJSICq8QSbG6UcD4gK2PBgwb/yvSKObQHpVycGqEdvQe2oNVNv21UhfMu
	ZyGbd7Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tGvxq-0000000H88p-27BK;
	Fri, 29 Nov 2024 08:02:58 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tGvxo-0000000H87Y-3DkP
	for linux-nvme@lists.infradead.org;
	Fri, 29 Nov 2024 08:02:57 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASIDpLY018753;
	Fri, 29 Nov 2024 08:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=EzjsWq9HnxVT+oS4M
	vEFF+5XxUb7XjXzmNmW2fG4MRc=; b=eGDmy8e8jo0GLGS3HLQfrPdeLtIF+/WmK
	SbW6AF2Qtb3Op5WDxWcKZm6FejdfCqKPkzmTY16AP5T4S6Y698sWqixz82E4CHaZ
	yuGZ1YHyWNpudshJh3wo4M3uGpqJAQxoS8FDVaRntHE5i1V+K4a1g7nQW5AVt2uR
	UKhdyFqRkfXpRnbSIT5odHP++nF+ln7+D/AgvEarVljvhD4k7yDiDfxq1CDV9NYr
	pOSR7iDJ2Rn5kv0DZtMhL8nqaJos4EpZVEW57pWboHtQrv0Kc86DM0zeM2GtLq+G
	FpRW9kh/XDKQdVIVQb1pgpgYF+3Af+P6zXJ30aKPpXOO61YPmsODQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4366ywsgyq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 08:02:42 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ASMO4Rj020400;
	Fri, 29 Nov 2024 08:02:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43672gbfsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Nov 2024 08:02:41 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4AT82eoW20447550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Nov 2024 08:02:40 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A62820191;
	Fri, 29 Nov 2024 08:02:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FAA120192;
	Fri, 29 Nov 2024 08:02:38 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.64.111])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 Nov 2024 08:02:37 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: shinichiro.kawasaki@wdc.com, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, chaitanyak@nvidia.com,
        gjoyce@linux.ibm.com
Subject: [PATCH blktests 2/2] nvme: add test for writing to file-ns just after disabling it
Date: Fri, 29 Nov 2024 13:31:37 +0530
Message-ID: <20241129080231.2994578-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241129080231.2994578-1-nilay@linux.ibm.com>
References: <20241129080231.2994578-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: LyOpjjuexDwtfR2HmT1ohmggmC44tdNY
X-Proofpoint-ORIG-GUID: LyOpjjuexDwtfR2HmT1ohmggmC44tdNY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=695 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2411290064
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241129_000256_809594_4550FE9B 
X-CRM114-Status: GOOD (  17.27  )
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

This test creates a regular file backed loop target namespace and
then write to that namespace just after disabling it in a loop.

[1] https://lore.kernel.org/linux-nvme/tqcy3sveity7p56v7ywp7ssyviwcb3w4623cnxj3knoobfcanq@yxgt2mjkbkam/

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 tests/nvme/055     | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/055.out |  2 ++
 2 files changed, 76 insertions(+)
 create mode 100755 tests/nvme/055
 create mode 100644 tests/nvme/055.out

diff --git a/tests/nvme/055 b/tests/nvme/055
new file mode 100755
index 0000000..0dbba74
--- /dev/null
+++ b/tests/nvme/055
@@ -0,0 +1,74 @@
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
+}
+
+set_conditions() {
+	_set_nvme_trtype "$@"
+}
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	local iterations=10
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
+	for ((i = 0; i < iterations; i++)); do
+
+		# wait until async request is processed and ns is created
+		if ! _nvmf_wait_for_ns "${def_subsys_uuid}" created; then
+			echo "FAIL"
+			break
+		fi
+
+		disk="/dev/$(_find_nvme_ns "${def_subsys_uuid}")"
+
+		# disable target namespace and write to it
+		echo 0 > ${ns_path}/enable
+		nvme write --start-block=1 --block-count=0 \
+			--data-size=512 --data="$img" "$disk" 2>>"$FULL"
+
+		# wait until async request is processed and ns is removed
+		if ! _nvmf_wait_for_ns "${def_subsys_uuid}" removed; then
+			echo "FAIL"
+			break
+		fi
+
+		# enable target namespace
+		echo 1 > ${ns_path}/enable
+	done
+
+	rm "$img"
+
+	_nvme_disconnect_subsys >> "$FULL" 2>&1
+
+	_nvmet_target_cleanup
+
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


