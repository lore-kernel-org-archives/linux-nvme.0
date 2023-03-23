Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D43C74A5B
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 23:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2cnh0phk8isVp+qoQW6o+cCVibc0vsv6g1vv/FjaXH8=; b=0ikrqzc5xO7mUNwRpec5ohVXed
	9oUyMgc2V7m3/EMmKFiw6P7hRtqWlLSatVGKH1OyzVMIx53YDE2XuqmY1YEiCee5jnYTG6crQsjXV
	AlA1FgW+nKXCNGIlw2ZKorKL6OV4uAeVobOmOHSgrI8lkz+vIk00U1fwvtnHynFHgDFeeCctcERYB
	uqwyaDdZa7eZlvrySf57pekEb2XSj31Z7JudaQE2omAWdlQd1aDOXyloGtJzd+FuMYcOzr8O5Be9E
	f7G76p9/BlNk0vgxWitqBMxu+PByetPATCiIXZjysffFfR1pshwqwYttWFrQGneI2WOnSsJLKxgPv
	0scVzH3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfTyg-0039tE-26;
	Thu, 23 Mar 2023 23:04:14 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfTyb-0039qj-17
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 23:04:13 +0000
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32NMsiKV021909;
	Thu, 23 Mar 2023 23:03:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=2cnh0phk8isVp+qoQW6o+cCVibc0vsv6g1vv/FjaXH8=;
 b=W5mba9cG49wEG1dGW6XrNCePgV82IqdcOD5Ql6oD3A9oBZRcdQ+SocuDlZuwgpwJnPeR
 3KwA5/XN5LBAPBlKDK4EfIPqV1MlBAEkocd7bInMKEn5cjZDmwQ75hjVD8ObFD2gC505
 1HwdkV0ZFwJslfnWh4wTL0dHnJD9xf6vxjTDSJXXKZRY+NhuBdBrooqp/ZgSSi5lnXcx
 5crv9n0qBp+LGz65PXA4WUtBP7uVPvxphoLCB3RIwgkx4DhUXsHmBjMoK/rI/uqiawH6
 dSY8Etb7O89r5Y71bDTJ41jrUCD4AIohvs30doHmQtx0dcZx14qgQIaQ8pNX8/Azyk+T TQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pgyyn80av-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Mar 2023 23:03:55 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32NLJEjK001244;
	Thu, 23 Mar 2023 23:03:43 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgxk3akyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Mar 2023 23:03:43 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32NN3fh9040061;
	Thu, 23 Mar 2023 23:03:43 GMT
Received: from ca-dev94.us.oracle.com (ca-dev94.us.oracle.com [10.129.136.30])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3pgxk3akmn-4;
	Thu, 23 Mar 2023 23:03:43 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, p.raghav@samsung.com, kbusch@kernel.org,
        hch@lst.de, sagi@grimberg.me
Subject: [RFC v2 3/3] nvme: ignore starting sector while error logging for passthrough requests
Date: Thu, 23 Mar 2023 16:03:16 -0700
Message-Id: <20230323230316.2914077-4-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230323230316.2914077-1-alan.adamson@oracle.com>
References: <20230323230316.2914077-1-alan.adamson@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-23_13,2023-03-23_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303230168
X-Proofpoint-GUID: v9JwZ5J_3IzvgY3dUJ16faSZxWQGme8N
X-Proofpoint-ORIG-GUID: v9JwZ5J_3IzvgY3dUJ16faSZxWQGme8N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_160410_223669_41D83711 
X-CRM114-Status: GOOD (  18.73  )
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

Error log will print a garbage value as the starting LBA for passthrough
requests and requests with uninitialized starting sector that return an
error.

Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
---
 drivers/nvme/host/core.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 48e9abacd80b..82afe72b7cbd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -306,6 +306,33 @@ static void nvme_retry_req(struct request *req)
 	blk_mq_delay_kick_requeue_list(req->q, delay);
 }
 
+static inline u64 nvme_log_error_rq_lba(struct nvme_ns *ns, struct request *rq)
+{
+	struct nvme_request *nr = nvme_req(rq);
+
+	if (blk_rq_is_passthrough(rq)) {
+		switch (nr->cmd->common.opcode) {
+		u64 cdw11;
+
+		case nvme_cmd_flush:
+		case nvme_cmd_write:
+		case nvme_cmd_read:
+		case nvme_cmd_write_uncor:
+		case nvme_cmd_compare:
+		case nvme_cmd_write_zeroes:
+		case nvme_cmd_verify:
+			cdw11 = nr->cmd->common.cdw11;
+
+			return nr->cmd->common.cdw10 | (cdw11 << 32);
+		default:
+			return 0;
+		}
+	}
+	if (blk_rq_pos(rq) == (sector_t)-1)
+		return 0;
+	return nvme_sect_to_lba(ns, blk_rq_pos(rq));
+}
+
 static void nvme_log_error(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
@@ -316,7 +343,7 @@ static void nvme_log_error(struct request *req)
 		       ns->disk ? ns->disk->disk_name : "?",
 		       nvme_get_opcode_str(nr->cmd->common.opcode),
 		       nr->cmd->common.opcode,
-		       (unsigned long long)nvme_sect_to_lba(ns, blk_rq_pos(req)),
+		       (unsigned long long)nvme_log_error_rq_lba(ns, req),
 		       (unsigned long long)blk_rq_bytes(req) >> ns->lba_shift,
 		       nvme_get_error_status_str(nr->status),
 		       nr->status >> 8 & 7,	/* Status Code Type */
-- 
2.31.1


