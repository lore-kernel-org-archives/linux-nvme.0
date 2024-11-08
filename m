Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74CAD64083
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 19:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YaxUJJnRZ28AJAdK6cvper+b/ynFQDqHd29QjSNk8fc=; b=OZMX400FH8aIhz1VOqqLgI78YT
	iMPZO6gh6wHKIFvPCItk7tK7K8H0IRoEK7cAFmew+jtYjfNUzTbJvwbqgxsqOHO36biWGccfrxICT
	aYUzM85FWs3ZY7TKn4ARzhIcUMgzD763ZrqQZGu0dyqMKUGnFgtLzvWo1ntHC8iHy4X6UUBgyZQ5a
	ka6KBlSBz6cpCmjFojzfBBx8NAL7/O87WZ+qXLvBEFg5qeTKuTL1f1LALaFn0vAD0ESiKWwkW/Eaw
	Z4Mlt1qIKtlGaeIJkBuOlqLtmp/x9sbZ98l0hvu0BdJovVoeQRxxiQdJdhBrulFhSskUpu+0xBdJi
	xNRZDQxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Uyk-0000000BmcP-1FEA;
	Fri, 08 Nov 2024 19:49:10 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Uyh-0000000Bmau-0smq
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 19:49:08 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8HPeew008078
	for <linux-nvme@lists.infradead.org>; Fri, 8 Nov 2024 11:49:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=YaxUJJnRZ28AJAdK6cvper+b/ynFQDqHd29QjSNk8fc=; b=naVfa/97F2RL
	efmByA/AvA/pL3j+JJmsm4Wr597WLBdbJ50RmC/Lf0AaOcW3vRDzzCrKJcfo6w7S
	OZHp72Se7FEaabkj160022BRyiZ4JQtsbrVm03lr4q+bT3rHmtlycT81abd9WvKJ
	6spJdc/R8j7gCjHhcsUogwonn6eVGdbBxfqQTJrtg+eGuO0tajfoAPdg56ByGJxC
	Rwi6lpvTF4jPKYXPZJytCN/6MznMSpuk6wQk1dmC0bsRbESRfIV0jQcXJyS0Y/BK
	gfKb+X5iFSHR5srE3TA1Zdp9dYYPQRkQt8F7WZ6VJjXZt6afqUI86SFq6KsJqarh
	5Rjq2oc8Dg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42sn4ua2fp-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 08 Nov 2024 11:49:06 -0800 (PST)
Received: from twshared35181.07.ash9.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 8 Nov 2024 19:49:04 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 8375014E3A032; Fri,  8 Nov 2024 11:36:58 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <axboe@kernel.dk>
CC: <hch@lst.de>, <martin.petersen@oracle.com>, <asml.silence@gmail.com>,
        <javier.gonz@samsung.com>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv11 3/9] statx: add write hint information
Date: Fri, 8 Nov 2024 11:36:23 -0800
Message-ID: <20241108193629.3817619-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241108193629.3817619-1-kbusch@meta.com>
References: <20241108193629.3817619-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 8aVabRHdHsj_CGG9X29O68VQE1U3C_0O
X-Proofpoint-GUID: 8aVabRHdHsj_CGG9X29O68VQE1U3C_0O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_114907_284739_2198F595 
X-CRM114-Status: GOOD (  15.08  )
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

If requested on a raw block device, report the maximum write hint the
block device supports.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/bdev.c              | 5 +++++
 fs/stat.c                 | 1 +
 include/linux/stat.h      | 1 +
 include/uapi/linux/stat.h | 3 ++-
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/block/bdev.c b/block/bdev.c
index 738e3c8457e7f..9a59f0c882170 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1296,6 +1296,11 @@ void bdev_statx(struct path *path, struct kstat *s=
tat,
 		stat->result_mask |=3D STATX_DIOALIGN;
 	}
=20
+	if (request_mask & STATX_WRITE_HINT) {
+		stat->write_hint_max =3D bdev_max_write_hints(bdev);
+		stat->result_mask |=3D STATX_WRITE_HINT;
+	}
+
 	if (request_mask & STATX_WRITE_ATOMIC && bdev_can_atomic_write(bdev)) {
 		struct request_queue *bd_queue =3D bdev->bd_queue;
=20
diff --git a/fs/stat.c b/fs/stat.c
index 41e598376d7e3..60bcd5c2e2a1d 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -704,6 +704,7 @@ cp_statx(const struct kstat *stat, struct statx __use=
r *buffer)
 	tmp.stx_atomic_write_unit_min =3D stat->atomic_write_unit_min;
 	tmp.stx_atomic_write_unit_max =3D stat->atomic_write_unit_max;
 	tmp.stx_atomic_write_segments_max =3D stat->atomic_write_segments_max;
+	tmp.stx_write_hint_max =3D stat->write_hint_max;
=20
 	return copy_to_user(buffer, &tmp, sizeof(tmp)) ? -EFAULT : 0;
 }
diff --git a/include/linux/stat.h b/include/linux/stat.h
index 3d900c86981c5..48f0f64846a02 100644
--- a/include/linux/stat.h
+++ b/include/linux/stat.h
@@ -57,6 +57,7 @@ struct kstat {
 	u32		atomic_write_unit_min;
 	u32		atomic_write_unit_max;
 	u32		atomic_write_segments_max;
+	u32		write_hint_max;
 };
=20
 /* These definitions are internal to the kernel for now. Mainly used by =
nfsd. */
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index 887a252864416..10f5622c21113 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -132,7 +132,7 @@ struct statx {
 	__u32	stx_atomic_write_unit_max;	/* Max atomic write unit in bytes */
 	/* 0xb0 */
 	__u32   stx_atomic_write_segments_max;	/* Max atomic write segment coun=
t */
-	__u32   __spare1[1];
+	__u32   stx_write_hint_max;
 	/* 0xb8 */
 	__u64	__spare3[9];	/* Spare space for future expansion */
 	/* 0x100 */
@@ -164,6 +164,7 @@ struct statx {
 #define STATX_MNT_ID_UNIQUE	0x00004000U	/* Want/got extended stx_mount_i=
d */
 #define STATX_SUBVOL		0x00008000U	/* Want/got stx_subvol */
 #define STATX_WRITE_ATOMIC	0x00010000U	/* Want/got atomic_write_* fields=
 */
+#define STATX_WRITE_HINT	0x00020000U	/* Want/got write_hint_max */
=20
 #define STATX__RESERVED		0x80000000U	/* Reserved for future struct statx=
 expansion */
=20
--=20
2.43.5


