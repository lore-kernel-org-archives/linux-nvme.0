Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B63BC4828D
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Feb 2024 18:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Eb2gZrzL02LXPYb2urhwB+JVOAHnMBfOqpkw5mMCCbA=; b=hA207Vy8rMBKlnLTZO9eOva+el
	uvgfk5ADWsPQCUwzwFxib9XRfJFuC0lz5BvWVkI4LqqJg+AwwZ3TxDnpAme0vtT1j+FZSXfDAQoSu
	hhARKIqKChLZyn6kVyFYzk3xa3BnGytdQGaUHQtnJOV50B5sUiwKEnQHaU6Ar6XxuBhze7lsVM/xK
	GY7DbRqDeSi2UUhDoIK+l9OQX3x8XBk6G+gJpEoAlM1K5NTIsXyOBpwypoW+H3kzjpgh7ZUVQdKb8
	FeIZTxahs95a8Sh4jN7LqTBOiCOfQJX6BBMD+3J11hVNZDTA7hC3HXDMOqDTyQZHLtBD6UPj4nV0X
	0bQv3+KA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX45D-00000004Re9-1jFF;
	Mon, 05 Feb 2024 18:52:43 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX45B-00000004RdI-1WI3
	for linux-nvme@lists.infradead.org;
	Mon, 05 Feb 2024 18:52:42 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 415HKavA027388
	for <linux-nvme@lists.infradead.org>; Mon, 5 Feb 2024 10:52:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=Eb2gZrzL02LXPYb2urhwB+JVOAHnMBfOqpkw5mMCCbA=;
 b=FknZ2t+bKGr87opwRbe0jCU5aTwQ3YtmL++f9UCNjGw+7+kW8VRciZ68ZHD6YMGxB3Um
 20M42zmmBntsGAc3hMWFglZmjSscqr95REOJ5O4QD2subGxPQmdLq+pcwkOZ7GyyKEuN
 dkYWHbEuJ08uFLvlGaqKjfDL7NDuNVKBEA7YpRzPmTeVUSP844TF7lWRXBMZq4TFMdf5
 bD6sj4KW1n8ORQN3ICk6avdb0IY3Mc8MRhAQcbykmK9AW8A2c8qyi3Ys5ngBSn1igWoc
 Rb4FtYVOQO0wM54jpaMG8HeeKCOujbI+rKpIhz5w7iX/wjgZ9Uw5AEH334Cc5ZW4dAZA RQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3w2pu1mej8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 05 Feb 2024 10:52:38 -0800
Received: from twshared7800.08.ash8.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 10:52:37 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 0B4B424DA8C0F; Mon,  5 Feb 2024 10:52:30 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <shinichiro.kawasaki@wdc.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH blktests] nvme: test log page offsets
Date: Mon, 5 Feb 2024 10:52:25 -0800
Message-ID: <20240205185225.2878642-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: v6sYeurD59SqIJ5-4ozVOXLsJ1jYwDTK
X-Proofpoint-ORIG-GUID: v6sYeurD59SqIJ5-4ozVOXLsJ1jYwDTK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_13,2024-01-31_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_105241_442698_CACE582D 
X-CRM114-Status: GOOD (  17.30  )
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

From: Keith Busch <kbusch@kernel.org>

I've encountered a device that fails catastrophically if the host
requests to an error log with a non-zero LPO. The fallout has been bad
enough to warrant a sanity check against this scenario.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 tests/nvme/051     | 26 ++++++++++++++++++++++++++
 tests/nvme/051.out |  2 ++
 2 files changed, 28 insertions(+)
 create mode 100755 tests/nvme/051
 create mode 100644 tests/nvme/051.out

diff --git a/tests/nvme/051 b/tests/nvme/051
new file mode 100755
index 0000000..ef30ad8
--- /dev/null
+++ b/tests/nvme/051
@@ -0,0 +1,26 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2024 Keith Busch
+
+. tests/nvme/rc
+
+DESCRIPTION=3D"Tests device support for log page offsets"
+CAN_BE_ZONED=3D1
+QUICK=3D1
+
+requires() {
+	_nvme_requires
+}
+
+test_device() {
+	echo "Running ${TEST_NAME}"
+
+	lpa=3D$(sudo nvme id-ctrl "${TEST_DEV}"  | grep lpa | cut -d":" -f 2 | =
xargs)
+	lpo=3D$((lpa & 0x4))
+
+	if [ $lpo -ne 0 ]; then
+		nvme get-log "${TEST_DEV}" --log-id=3D1 --log-len=3D128 --lpo=3D0x1000=
 > /dev/NULL
+	fi
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/051.out b/tests/nvme/051.out
new file mode 100644
index 0000000..156f068
--- /dev/null
+++ b/tests/nvme/051.out
@@ -0,0 +1,2 @@
+Running nvme/051
+Test complete
--=20
2.34.1


