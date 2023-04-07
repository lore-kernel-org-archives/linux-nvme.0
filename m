Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D9E0C77B6C
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 20:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IX64E90urNX7WMpx26VUPcwGHtWTtwI0BZbxS3ixU4k=; b=H8HCC6H5miL79YbY/SU5PX4RWT
	KRHs7UEhU6qY9ODt9pq2aICCOaGGDfSAijjBB44Cpi3mDmpGf94egDp1Jp5VLLULSxLUVVZT/gdTW
	tfAIBCMPW0Xew2Qav2McRHJmNDglnvDDTFTeQu7nGuNiS8S1snK/2rWtady1dsfqtlQ0dQ3/ZrPUY
	QAG+aRzx6hsolq/qUi6vQag87/0Au1U13MBzt1EMWEUw8+w4rllcJ8ff8MaT6JrN3fiDiAhlH0FZI
	Dt18rQ1faA5stBwF1Y0UgTJRgCy9QNFOA8e4dN5E2I7jE2HK8TEnd4N+wF8BkkF+W07fWZWuBHjRP
	9KYx+oYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pksLf-00B2WK-0r;
	Fri, 07 Apr 2023 20:06:15 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pksLc-00B2Ul-00
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 20:06:13 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337FxDxn018772;
	Fri, 7 Apr 2023 20:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=IX64E90urNX7WMpx26VUPcwGHtWTtwI0BZbxS3ixU4k=;
 b=H5poPzWX02WWPBvIgpNcjLKRnwV8EF+GXR1yW7Pu671Ux4kULB1yaZYlnr16avv3WwYx
 rPhuZx/Q/iWgf6P5ACSCtbQ11ugHp5RKhcGXkc9RKhCEo8Zc3L2Lp4lfj/o81yaAh+HC
 Mlt9ARvXsHdpODiiO4NSZZcIkHJ6Kjpkz9+E73WkNzQYgF1impXH8ZSpg4b9iIRNpdwP
 tz3dVX30LrQGLxUawdVQJYoRckT8LUSwOsYkItCThS9CjyRe8HI8M1XT0wCsbCqao9qD
 CpAz+IJeRWZxyLDJeF3Rg9QsIZ/Juv2fI/EOXkx9uvJbS2KAAg4xXWZaj8UHuV3xv+xR UA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppb1dwryg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Apr 2023 20:05:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 337J0UKA034219;
	Fri, 7 Apr 2023 20:05:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjxeedu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Apr 2023 20:05:58 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 337K5tqs010228;
	Fri, 7 Apr 2023 20:05:57 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-128-1.vpn.oracle.com [10.154.128.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptjxeeam-2;
	Fri, 07 Apr 2023 20:05:57 +0000
From: Mike Christie <michael.christie@oracle.com>
To: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, snitzer@kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        kbusch@kernel.org, target-devel@vger.kernel.org
Cc: Mike Christie <michael.christie@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v6 01/18] block: Add PR callouts for read keys and reservation
Date: Fri,  7 Apr 2023 15:05:34 -0500
Message-Id: <20230407200551.12660-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407200551.12660-1-michael.christie@oracle.com>
References: <20230407200551.12660-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070180
X-Proofpoint-GUID: fz2bR8uJalfGpOtkd4fkrJ4HH4S8UKmz
X-Proofpoint-ORIG-GUID: fz2bR8uJalfGpOtkd4fkrJ4HH4S8UKmz
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_130612_325414_19AC1706 
X-CRM114-Status: GOOD (  18.64  )
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

Add callouts for reading keys and reservations. This allows LIO to support
the READ_KEYS and READ_RESERVATION commands so it can export devices to
VMs for software like windows clustering.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
 include/linux/pr.h | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/include/linux/pr.h b/include/linux/pr.h
index 94ceec713afe..3003daec28a5 100644
--- a/include/linux/pr.h
+++ b/include/linux/pr.h
@@ -4,6 +4,18 @@
 
 #include <uapi/linux/pr.h>
 
+struct pr_keys {
+	u32	generation;
+	u32	num_keys;
+	u64	keys[];
+};
+
+struct pr_held_reservation {
+	u64		key;
+	u32		generation;
+	enum pr_type	type;
+};
+
 struct pr_ops {
 	int (*pr_register)(struct block_device *bdev, u64 old_key, u64 new_key,
 			u32 flags);
@@ -14,6 +26,19 @@ struct pr_ops {
 	int (*pr_preempt)(struct block_device *bdev, u64 old_key, u64 new_key,
 			enum pr_type type, bool abort);
 	int (*pr_clear)(struct block_device *bdev, u64 key);
+	/*
+	 * pr_read_keys - Read the registered keys and return them in the
+	 * pr_keys->keys array. The keys array will have been allocated at the
+	 * end of the pr_keys struct, and pr_keys->num_keys must be set to the
+	 * number of keys the array can hold. If there are more than can fit
+	 * in the array, success will still be returned and pr_keys->num_keys
+	 * will reflect the total number of keys the device contains, so the
+	 * caller can retry with a larger array.
+	 */
+	int (*pr_read_keys)(struct block_device *bdev,
+			struct pr_keys *keys_info);
+	int (*pr_read_reservation)(struct block_device *bdev,
+			struct pr_held_reservation *rsv);
 };
 
 #endif /* LINUX_PR_H */
-- 
2.25.1


