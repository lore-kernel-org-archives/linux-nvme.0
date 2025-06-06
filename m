Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0223C5B555
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Jun 2025 00:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2BIVafMI0Oiq8YofLUS/H24Ia3+J+tAPeN/YnyScJDU=; b=ZhhMy8WtSreXSvBzLTALl6hmWH
	RExr8ZrgzN8i1bC3392cZrbeIix1dr0Nh/+JKD2e0tYwVsMKPxRoWZnXBJYgBqpsg4IyVgoVz7i9V
	3LPaL+Ekr1K1fip2NN6e1WT+WktpN5coG+6JGfG0wl77H1rrgkyL1sktQvo4lBhIrwevvpwzPjFGW
	pHIp9qAc7U3+LAjCodY9r1A/PWnjETOKMxQk74j31j4JO1hqArYoj3OkqbVjVL1cJc3zyuLui/HMW
	MH3zaE6BgYV1BAAwZA6ZqL2V4JZYEw8AD3s1OZWSNJXF8E9S0ZGxSS3ZGwwgaLWwuJFLvokW2Yt7m
	bKsY9w4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNKyp-0000000Gqcv-1Exw;
	Fri, 06 Jun 2025 00:30:43 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uNKym-0000000GqcY-1ziy
	for linux-nvme@lists.infradead.org;
	Fri, 06 Jun 2025 00:30:42 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5560JCdf019551
	for <linux-nvme@lists.infradead.org>; Thu, 5 Jun 2025 17:30:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=2BIVafMI0Oiq8YofLU
	S/H24Ia3+J+tAPeN/YnyScJDU=; b=Adzo2q0Hl68YMTnm1U9vT29lFbd8JvbVrn
	rCFAFbdbJmpdsnAp6V+08aqJFiSLH2H4RH9IfWEKHbliYM00YbV+w09qmSdlQS+p
	x/3HpXogkhMZU85UCuTkokXaOUT7s3V/w473fv0Fn+JQ7abVTETkK3MEBw4dbQ5r
	AdgyCnlH9WAmC6D0naghc5p+Zc4fcychHHyi0wlwbcQD9hj+ha3Lo/Vws3uC5/0r
	Fn9kAUv7vktguKov/ule2xFlUGNLgDZpAHtb5zVteRcJ+Sc8uBQhxNoQ13FQSPwD
	Dvf/3mwRty9143mjpBUIQEOYYqWjBavT9tP7xt4jZRpkjtcdzWvg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 473np681nq-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 05 Jun 2025 17:30:37 -0700 (PDT)
Received: from twshared53813.03.ash8.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Fri, 6 Jun 2025 00:30:34 +0000
Received: by devbig209.atn5.facebook.com (Postfix, from userid 544533)
	id E6A765ECE9C; Thu,  5 Jun 2025 17:30:18 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <shinichiro.kawasaki@wdc.com>
CC: <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH blktests] block tests: nvme metadata passthrough
Date: Thu, 5 Jun 2025 17:30:15 -0700
Message-ID: <20250606003015.3203624-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=LONmQIW9 c=1 sm=1 tr=0 ts=684236ad cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=WTJdmG3rAAAA:8 a=MSKyxBDuZ79kajtTfYUA:9 a=q3NGepEMMmKWaCv8Sx90:22
X-Proofpoint-GUID: TdE2RysLLunLeoCXhEjCktYc_E_MCox_
X-Proofpoint-ORIG-GUID: TdE2RysLLunLeoCXhEjCktYc_E_MCox_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDAwMyBTYWx0ZWRfX/LUeZAIuB7sT hYXC4MwVxcJr77wtG4eAP2g5P3x1JmUv3XhEz26wERTrVvIIKsoYNrDaO0vV8vzThc11W1Jh3Xz IL2E9NofqtpAHMv26+P4zJkFIgBwbd1QscUXYUDC0SaaVE73KMi8pok9wOGWxqwGO6WwfpMvWrq
 DCmjQtaNRTsU6V4PmzatSJg4t3hS/4GSu/Pg4HtOHeF1ElcPkzP3Bkp6yMWUPQvmNHK8Kn8n1gZ jOo9kdUOQMI52v33BSAxRLHnQa9/I3V+qbhkpmYre3vyz1NXvDL+hFDOkCIQxu63jHxqUARfYJM nHQ0xQqbKQO1jsDxZPRmwTVDvvlQ8diwp6sPC6LZw6Zc3+QCUPOQpno40VqbBgLLHrC1wRlmtYC
 mRWLtI3XRawp4mMLhOCnnzj4qAntYSFU3lybUHrxNcOIOSWBvgzEEjtytdDyUIWzoxYcS/ZV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_08,2025-06-05_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250605_173040_743855_AD1A9DCD 
X-CRM114-Status: GOOD (  22.31  )
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

Get more coverage on nvme metadata passthrough. Specifically in this
test, read-only metadata is targeted as this had been a gap in previous
test coveraged.

Link: https://lore.kernel.org/linux-block/20250603184752.1185676-1-csande=
r@purestorage.com/
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 src/Makefile                |   1 +
 src/nvme-passthrough-meta.c | 219 ++++++++++++++++++++++++++++++++++++
 tests/nvme/064              |  22 ++++
 tests/nvme/064.out          |   2 +
 4 files changed, 244 insertions(+)
 create mode 100644 src/nvme-passthrough-meta.c
 create mode 100755 tests/nvme/064
 create mode 100644 tests/nvme/064.out

diff --git a/src/Makefile b/src/Makefile
index a94e5f2..f91ac62 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -13,6 +13,7 @@ C_TARGETS :=3D \
 	loop_change_fd \
 	loop_get_status_null \
 	mount_clear_sock \
+	nvme-passthrough-meta \
 	nbdsetsize \
 	openclose \
 	sg/dxfer-from-dev \
diff --git a/src/nvme-passthrough-meta.c b/src/nvme-passthrough-meta.c
new file mode 100644
index 0000000..a8a5b1b
--- /dev/null
+++ b/src/nvme-passthrough-meta.c
@@ -0,0 +1,219 @@
+#define _GNU_SOURCE
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <inttypes.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <linux/types.h>
+
+#ifndef _LINUX_NVME_IOCTL_H
+#define _LINUX_NVME_IOCTL_H
+struct nvme_passthru_cmd {
+	__u8    opcode;
+	__u8    flags;
+	__u16   rsvd1;
+	__u32   nsid;
+	__u32   cdw2;
+	__u32   cdw3;
+	__u64   metadata;
+	__u64   addr;
+	__u32   metadata_len;
+	__u32   data_len;
+	__u32   cdw10;
+	__u32   cdw11;
+	__u32   cdw12;
+	__u32   cdw13;
+	__u32   cdw14;
+	__u32   cdw15;
+	__u32   timeout_ms;
+	__u32   result;
+};
+
+#define NVME_IOCTL_ID		_IO('N', 0x40)
+#define NVME_IOCTL_ADMIN_CMD    _IOWR('N', 0x41, struct nvme_passthru_cm=
d)
+#define NVME_IOCTL_IO_CMD       _IOWR('N', 0x43, struct nvme_passthru_cm=
d)
+#endif /* _UAPI_LINUX_NVME_IOCTL_H */
+
+struct nvme_lbaf {
+	__le16	ms;
+	__u8	ds;
+	__u8	rp;
+};
+
+struct nvme_id_ns {
+	__le64	nsze;
+	__le64	ncap;
+	__le64	nuse;
+	__u8	nsfeat;
+	__u8	nlbaf;
+	__u8	flbas;
+	__u8	mc;
+	__u8	dpc;
+	__u8	dps;
+	__u8	nmic;
+	__u8	rescap;
+	__u8	fpi;
+	__u8	dlfeat;
+	__le16	nawun;
+	__le16	nawupf;
+	__le16	nacwu;
+	__le16	nabsn;
+	__le16	nabo;
+	__le16	nabspf;
+	__le16	noiob;
+	__u8	nvmcap[16];
+	__le16	npwg;
+	__le16	npwa;
+	__le16	npdg;
+	__le16	npda;
+	__le16	nows;
+	__u8	rsvd74[18];
+	__le32	anagrpid;
+	__u8	rsvd96[3];
+	__u8	nsattr;
+	__le16	nvmsetid;
+	__le16	endgid;
+	__u8	nguid[16];
+	__u8	eui64[8];
+	struct nvme_lbaf lbaf[64];
+	__u8	vs[3712];
+};
+
+#define BUFFER_SIZE (32768)
+
+int main(int argc, char **argv)
+{
+	int ret, fd, nsid, blocks, meta_buffer_size;
+	void *buffer, *mptr =3D NULL, *meta =3D NULL;
+	struct nvme_passthru_cmd cmd;
+	struct nvme_lbaf lbaf;
+	struct nvme_id_ns ns;
+
+	__u64 block_size;
+	__u16 meta_size;
+
+	if (argc < 2) {
+		fprintf(stderr, "usage: %s /dev/nvmeXnY", argv[0]);
+		return EINVAL;
+	}
+
+	fd =3D open(argv[1], O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	nsid =3D ioctl(fd, NVME_IOCTL_ID);
+	if (nsid < 0) {
+		perror("namespace id");
+		return errno;
+	}
+
+	cmd =3D (struct nvme_passthru_cmd) {
+		.opcode	=3D 0x6,
+		.nsid	=3D nsid,
+		.addr	=3D (__u64)(uintptr_t)&ns,
+		.data_len       =3D 4096,
+	};
+
+	ret =3D ioctl(fd, NVME_IOCTL_ADMIN_CMD, &cmd);
+	if (ret < 0) {
+		perror("id-ns");
+		return errno;
+	}
+
+	lbaf =3D ns.lbaf[ns.flbas & 0xf];
+	block_size =3D 1 << lbaf.ds;
+	meta_size =3D lbaf.ms;
+
+	/* format not appropriate for this test */
+	if (meta_size =3D=3D 0)
+		return 0;
+
+	blocks =3D BUFFER_SIZE / block_size;
+	meta_buffer_size =3D blocks * meta_size;
+
+	buffer =3D malloc(BUFFER_SIZE);
+	mptr =3D mmap(NULL, 8192, PROT_READ | PROT_WRITE,
+		MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	if (mptr =3D=3D MAP_FAILED) {
+		perror("mmap");
+		return errno;
+	}
+
+	/* this should directly use the user space buffer */
+	meta =3D mptr;
+	cmd =3D (struct nvme_passthru_cmd) {
+		.opcode		=3D 1,
+		.nsid		=3D 1,
+		.addr		=3D (uintptr_t)buffer,
+		.metadata       =3D (uintptr_t)meta,
+		.data_len       =3D BUFFER_SIZE,
+		.metadata_len   =3D meta_buffer_size,
+		.cdw12		=3D blocks - 1,
+	};
+	ret =3D ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret < 0) {
+		perror("nvme-write");
+		return ret;
+	}
+
+	cmd.opcode =3D 2;
+	ret =3D ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret < 0) {
+		perror("nvme-read");
+		return ret;
+	}
+
+	/*
+	 * this offset should either force a kernel copy if we don't have
+	 * contiguous pages, or test the device's metadata sgls
+	 */
+	meta =3D mptr + 4096 - 16;
+	cmd.opcode =3D 1;
+	cmd.metadata =3D (uintptr_t)meta;
+
+	ret =3D ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret < 0) {
+		perror("nvme-write");
+		return errno;
+	}
+
+	cmd.opcode =3D 2;
+	ret =3D ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret < 0) {
+		perror("nvme-read");
+		return errno;
+	}
+
+	/* This should not be mappable for write commands */
+	mptr =3D mmap(NULL, 8192, PROT_READ, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0);
+	if (mptr =3D=3D MAP_FAILED) {
+		perror("mmap");
+		return errno;
+	}
+
+	meta =3D mptr;
+
+	cmd.opcode =3D 1;
+	cmd.metadata =3D (uintptr_t)meta;
+	ret =3D ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret =3D=3D 0) {
+		perror("nvme-write (expect Failure)");
+		return EFAULT;
+	}
+
+	cmd.opcode =3D 2;
+	ret =3D ioctl(fd, NVME_IOCTL_IO_CMD, &cmd);
+	if (ret < 0) {
+		perror("nvme-read");
+		return ret;
+	}
+
+	return 0;
+}
diff --git a/tests/nvme/064 b/tests/nvme/064
new file mode 100755
index 0000000..ed9c565
--- /dev/null
+++ b/tests/nvme/064
@@ -0,0 +1,22 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-3.0+
+# Copyright (C) 2025 Keith Busch <kbusch@kernel.org>
+#
+# Test out metadata through the passthrough interfaces
+
+. tests/nvme/rc
+
+requires() {
+	_nvme_requires
+}
+
+DESCRIPTION=3D"exercise the nvme metadata usage with passthrough command=
s"
+QUICK=3D1
+
+test() {
+	echo "Running ${TEST_NAME}"
+
+	src/nvme-passthrough-meta ${TEST_DEV}
+
+	echo "Test complete"
+}
diff --git a/tests/nvme/064.out b/tests/nvme/064.out
new file mode 100644
index 0000000..5b34d4e
--- /dev/null
+++ b/tests/nvme/064.out
@@ -0,0 +1,2 @@
+Running nvme/064
+Test complete
--=20
2.47.1


