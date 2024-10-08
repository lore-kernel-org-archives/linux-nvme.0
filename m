Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB1BCED25F
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Oct 2024 04:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nf8G1zFHRlgofvzb1+iUCP+QxYElvr+E/GLPLv3veaM=; b=Yi9aLlCWLnH11x3toaUre7JkNS
	HbcrV4suB7mRys1uDFvtUk3iPtfXp9xeC6oOoJXws+6mBR4x6i+5psGNDXRdwQT5NMzBarRgMxv0c
	+uMUjWA16oLzosw2kUR6a68cguJweF1HNMYjMz30MgElD8Keh2X3Q84oj8y6o4nVgQWBhDhMRAHX/
	kaEtZl4G0LtypZzw2MIAD9sKUhfhdKwRZ2l+AwGJc6Db7BEY/fNaTZFV2cnzECKijzvIU/hWLWJGI
	I0hwiijCckqppVLVDwGcBrDpPz3n7x+5QXbEmpxZyCjCWZSIBruCx+kVvM61r0ZtmG1yZAvmumzLc
	mlE8zJtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sy1ci-00000004Srb-15iW;
	Tue, 08 Oct 2024 04:15:00 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sy1ce-00000004SqG-3Qmn
	for linux-nvme@lists.infradead.org;
	Tue, 08 Oct 2024 04:14:59 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4983kBbR001383;
	Tue, 8 Oct 2024 04:14:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=nf8G1zFHRlgof
	vzb1+iUCP+QxYElvr+E/GLPLv3veaM=; b=a0HQcizRXP3VeFI9/tzRDmwqRydAr
	Ceh/vBwrQJ9kk7WxZaalNItQdrGnw8RIU/+SLODbyYhOVx3sjiARK0mcwB96VxCs
	AnlhTlM9vdaAetLoewO5C6IK6X8izs20tgGCL2x3adlv4Pp/b3ZLizDq0dxOM9aL
	3DFt6lIZYBeRf9I5A/g4RDQjKiXQptiayCu5qDbh96qFpfSLXiWOA9dOVU7jWS5D
	AKFnw4+/I64t0d8+9EcnB9eUO1qT78G7hqLhpk91vzablZkv6XSxBy6/pgTRaYJH
	0G7DQRR8Er3Vg5g5z8FwafA6DDUs24I8bNKC28jWT2hZhDQJioswFwbVg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 424w4d02qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 04:14:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4981dgRC030174;
	Tue, 8 Oct 2024 04:14:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423gsmj3g4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Oct 2024 04:14:46 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4984Egl221037368
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Oct 2024 04:14:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B5D020040;
	Tue,  8 Oct 2024 04:14:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E36220043;
	Tue,  8 Oct 2024 04:14:40 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.171.23.125])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Oct 2024 04:14:40 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 1/3] nvme-loop: flush off pending I/O while shutting down loop controller
Date: Tue,  8 Oct 2024 09:43:28 +0530
Message-ID: <20241008041436.1073281-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241008041436.1073281-1-nilay@linux.ibm.com>
References: <20241008041436.1073281-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iouozXiMa9HYSA5D0D_WNxa6ni-lP9te
X-Proofpoint-GUID: iouozXiMa9HYSA5D0D_WNxa6ni-lP9te
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_03,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=855 malwarescore=0 bulkscore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410080026
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_211457_213769_EF248F46 
X-CRM114-Status: GOOD (  14.99  )
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

While shutting down loop controller, we first quiesce the admin/IO queue,
delete the admin/IO tag-set and then at last destroy the admin/IO queue.
However it's quite possible that during the window between quiescing and
destroying of the admin/IO queue, some admin/IO request might sneak in
and if that happens then we could potentially encounter a hung task
because shutdown operation can't forward progress until any pending I/O
is flushed off.

This commit helps ensure that before destroying the admin/IO queue, we
unquiesce the admin/IO queue so that any outstanding requests, which are
added after the admin/IO queue is quiesced, are now flushed to its
completion.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/loop.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index e32790d8fc26..a9d112d34d4f 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -265,6 +265,13 @@ static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
 {
 	if (!test_and_clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags))
 		return;
+	/*
+	 * It's possible that some requests might have been added
+	 * after admin queue is stopped/quiesced. So now start the
+	 * queue to flush these requests to the completion.
+	 */
+	nvme_unquiesce_admin_queue(&ctrl->ctrl);
+
 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
 	nvme_remove_admin_tag_set(&ctrl->ctrl);
 }
@@ -297,6 +304,12 @@ static void nvme_loop_destroy_io_queues(struct nvme_loop_ctrl *ctrl)
 		nvmet_sq_destroy(&ctrl->queues[i].nvme_sq);
 	}
 	ctrl->ctrl.queue_count = 1;
+	/*
+	 * It's possible that some requests might have been added
+	 * after io queue is stopped/quiesced. So now start the
+	 * queue to flush these requests to the completion.
+	 */
+	nvme_unquiesce_io_queues(&ctrl->ctrl);
 }
 
 static int nvme_loop_init_io_queues(struct nvme_loop_ctrl *ctrl)
-- 
2.45.2


