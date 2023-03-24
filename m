Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C48EC76195
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Mar 2023 18:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nUDrxezizUndbrZzmqecswz8zdkIl4p6RXBXgvoqp9c=; b=TEwSHWbJ9Tcm3mPULzKMsdqaLo
	yO4klbbJsE4ZucXJ7HmQxRY4kDCCLTQqSVwC4B4kgSFB4eFkzUYefKDuIWsiAoVcduBVU0jPbfate
	Jaary/3TyDSbPz0UIWDiOyySCmjpr6WX/tIWS6NxwKY/sDYDaxbPItzC3hefQIqPexUhIK1mxnHF2
	7z4Ggy92tJe8eH+LwBlx4txGPs8vqwO/ZCVogMON9iSk23//jOVhYiY6QgCjGa5VbR7A5dOgvpeK1
	qz6SIwHC34iO/Zdw1+cWxS9uK7mgZsuVaLypaadWnUHFltn3bRc9DRm6ry+Azg/Jqq/ZTqER0DJbH
	1lN9j9Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pflzc-005HBE-2Q;
	Fri, 24 Mar 2023 18:18:24 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pflzZ-005H7z-1V
	for linux-nvme@lists.infradead.org;
	Fri, 24 Mar 2023 18:18:22 +0000
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OI051I021913;
	Fri, 24 Mar 2023 18:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=nUDrxezizUndbrZzmqecswz8zdkIl4p6RXBXgvoqp9c=;
 b=UCEY16kMdll3zfO0/xF7l/syXDk0OaRbP8PzOHAoQIz1JTZ86fi3uk/JnOVJpKh5rqkK
 O2Z4g3sn9hq9WHpuM7wGwfUbKTmBgirIxlHcmCxUHErc6rUhzF0FqG1c5/dwi+mE/M54
 r1hioHoIYafiCaFfOBbLolag/IU3VC0pzAQyTVOR8FeHxRqHD5lt+ekn9Epk7RGmUwu2
 mnSLauW9qXwyK97MVH2UIfPueVQOvOKcy0ytFn21GOKba9Leasq0A4whc+pJ9DndRz+C
 K3JLmDX9cSNMEYA6FB9GPU2ONCO3CXebppi60yLXBulaimnrzpqBw62/YaL4nI6K4K5l Ng== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3phgrg81dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Mar 2023 18:18:17 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32OGoJNH001434;
	Fri, 24 Mar 2023 18:18:16 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3pgxk4bxmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Mar 2023 18:18:16 +0000
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 32OIHiEj021017;
	Fri, 24 Mar 2023 18:18:16 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-153-54.vpn.oracle.com [10.154.153.54])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3pgxk4bx19-14;
	Fri, 24 Mar 2023 18:18:16 +0000
From: Mike Christie <michael.christie@oracle.com>
To: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, snitzer@kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        kbusch@kernel.org, target-devel@vger.kernel.org
Cc: Mike Christie <michael.christie@oracle.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH v5 13/18] nvme: Add pr_ops read_reservation support
Date: Fri, 24 Mar 2023 13:17:36 -0500
Message-Id: <20230324181741.13908-14-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230324181741.13908-1-michael.christie@oracle.com>
References: <20230324181741.13908-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303240143
X-Proofpoint-ORIG-GUID: KeEGQHFqyLXhVn33fMGtlua0eDBT3ROw
X-Proofpoint-GUID: KeEGQHFqyLXhVn33fMGtlua0eDBT3ROw
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_111821_508049_A50AC323 
X-CRM114-Status: GOOD (  24.67  )
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

This patch adds support for the pr_ops read_reservation callout by
calling the NVMe Reservation Report helper. It then parses that info to
detect if there is a reservation and if there is then convert the
returned info to a pr_ops pr_held_reservation struct.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/pr.c | 83 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index c550c172ff0d..56d24bc3371a 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -29,6 +29,26 @@ static enum nvme_pr_type nvme_pr_type_from_blk(enum pr_type type)
 	return 0;
 }
 
+static enum pr_type block_pr_type_from_nvme(enum nvme_pr_type type)
+{
+	switch (type) {
+	case NVME_PR_WRITE_EXCLUSIVE:
+		return PR_WRITE_EXCLUSIVE;
+	case NVME_PR_EXCLUSIVE_ACCESS:
+		return PR_EXCLUSIVE_ACCESS;
+	case NVME_PR_WRITE_EXCLUSIVE_REG_ONLY:
+		return PR_WRITE_EXCLUSIVE_REG_ONLY;
+	case NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY:
+		return PR_EXCLUSIVE_ACCESS_REG_ONLY;
+	case NVME_PR_WRITE_EXCLUSIVE_ALL_REGS:
+		return PR_WRITE_EXCLUSIVE_ALL_REGS;
+	case NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS:
+		return PR_EXCLUSIVE_ACCESS_ALL_REGS;
+	}
+
+	return 0;
+}
+
 static int nvme_send_ns_head_pr_command(struct block_device *bdev,
 		struct nvme_command *c, void *data, unsigned int data_len)
 {
@@ -222,6 +242,68 @@ static int nvme_pr_read_keys(struct block_device *bdev,
 	return ret;
 }
 
+static int nvme_pr_read_reservation(struct block_device *bdev,
+		struct pr_held_reservation *resv)
+{
+	struct nvme_reservation_status_ext tmp_rse, *rse;
+	int ret, i, num_regs;
+	u32 rse_len;
+	bool eds;
+
+get_num_regs:
+	/*
+	 * Get the number of registrations so we know how big to allocate
+	 * the response buffer.
+	 */
+	ret = nvme_pr_resv_report(bdev, &tmp_rse, sizeof(tmp_rse), &eds);
+	if (ret)
+		return ret;
+
+	num_regs = get_unaligned_le16(&tmp_rse.regctl);
+	if (!num_regs) {
+		resv->generation = le32_to_cpu(tmp_rse.gen);
+		return 0;
+	}
+
+	rse_len = struct_size(rse, regctl_eds, num_regs);
+	rse = kzalloc(rse_len, GFP_KERNEL);
+	if (!rse)
+		return -ENOMEM;
+
+	ret = nvme_pr_resv_report(bdev, rse, rse_len, &eds);
+	if (ret)
+		goto free_rse;
+
+	if (num_regs != get_unaligned_le16(&rse->regctl)) {
+		kfree(rse);
+		goto get_num_regs;
+	}
+
+	resv->generation = le32_to_cpu(rse->gen);
+	resv->type = block_pr_type_from_nvme(rse->rtype);
+
+	for (i = 0; i < num_regs; i++) {
+		if (eds) {
+			if (rse->regctl_eds[i].rcsts) {
+				resv->key = le64_to_cpu(rse->regctl_eds[i].rkey);
+				break;
+			}
+		} else {
+			struct nvme_reservation_status *rs;
+
+			rs = (struct nvme_reservation_status *)rse;
+			if (rs->regctl_ds[i].rcsts) {
+				resv->key = le64_to_cpu(rs->regctl_ds[i].rkey);
+				break;
+			}
+		}
+	}
+
+free_rse:
+	kfree(rse);
+	return ret;
+}
+
 const struct pr_ops nvme_pr_ops = {
 	.pr_register	= nvme_pr_register,
 	.pr_reserve	= nvme_pr_reserve,
@@ -229,4 +311,5 @@ const struct pr_ops nvme_pr_ops = {
 	.pr_preempt	= nvme_pr_preempt,
 	.pr_clear	= nvme_pr_clear,
 	.pr_read_keys	= nvme_pr_read_keys,
+	.pr_read_reservation = nvme_pr_read_reservation,
 };
-- 
2.25.1


