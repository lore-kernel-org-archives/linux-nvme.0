Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5584F606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=gYeoGNPd;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Gl20F7Hj;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=BcQJZtnd
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=4Ze/7lo4cAU5WkFupXid4iXS/XFB9rIRaSXOLGj9SMs=; b=gYeoGNPdI4l0ip
	5CvDf+6i5kBytvswM9fRECtl4i6uP97BIQVIN8PDv6M7ehOzwmxeIn7OwEfbkdls1kNh3pFhfrN3F
	AzrTMmVyse4Uz2ps96nFJ3H+2OKMzb2PCw2keSq+8UzfXZM22/rL+F29iaj2a/21shJxmXBP16a/j
	1P/36gnHBD5BeQXk9IjIhkqD6myv8sC4QQZkQO6HLV1Y6AmvFMGUpwWgmoCZGIE0OlH7aYztn9r9H
	CgD/D/raoY1As2fqqc69IgGzzlbmET3unUEg/HONjLYpJPOLxYh3xy+xnJILrHjpoV0TVD3OWf7cE
	2OdkOkIvt+f9BZ6SWgcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEx-0000000822c-43DD;
	Wed, 18 Nov 2026 07:37:59 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEw-0000000820W-061X
	for linux-nvme@bombadil.infradead.org;
	Wed, 18 Nov 2026 07:37:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=4Ze/7lo4cAU5WkFupXid4iXS/XFB9rIRaSXOLGj9SMs=; b=Gl20F7HjXmb8QkGZ1KmZOj0Fx6
	ZOwUEkX6/aRGMBmoFrcOs5MC/ZVjFyFN7kFd8/Yao0tJdmE+qkwT73kqaAt1kQv8NUh2z3J3qyJ0R
	ohxzjHmp0B+7D9ZUWBCQRewHKqUZxs2NnKyiHiONDvroKUy98LIRMoApO0KpgP0cgzBLkBsF+Ptpa
	nst93I92rCSjs66rMPor8+XQDICHGymiN4eZM3jrNwQWASEU2KAjZb8+24/ALUEwLaxwUOMeGXelT
	tgFXTUYmVD9gkUSZkP/jSbRcaBerp4L7ybwRpAERYUENaEue3Y+PnhyQCEue9RiJKn9MGywes8o6a
	9oYdNtYg==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEk-0000000FkHb-0cSS
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:37:49 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2SYHd032871;
	Wed, 18 Nov 2026 07:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4Ze/7lo4cAU5WkFup
	Xid4iXS/XFB9rIRaSXOLGj9SMs=; b=BcQJZtndMHgw9Wv8KE70nSjbbIukBZHgi
	QQ/7oeyqzRmFX7lk30AI1hgL/P8UgQk2DGGV4k+pdH5c2UCSCSO1qiPGoEztatV/
	TL303qH7f0BUv7WziUdBW9eSpWlCSDZJ4YbHFDzJO15lPWUogq6R1j7bkprW31uH
	hbSzwzMmXuDrjSrJRUFYjG8cOJA1/oWXG7lyzFcjPwfGcX7Tyrih6VZZbwMT7Va0
	itrm3F1jqUw0+YB0nFT1o93yJdgIo+B5Zu5hdyK4ihFfRhpz+76Apgyxbp0JUm7v
	wA7VTnlqdsWSa4FrgWA9pIOJT9rLIbaDA2n3MEBAnQoW22kc+prgQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105n9d03-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:34 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2Ystj2766460;
	Wed, 18 Nov 2026 07:37:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt7kwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7bSKF48955802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:37:29 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D25C72004B;
	Wed, 18 Nov 2026 07:37:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 326B420040;
	Wed, 18 Nov 2026 07:37:23 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:37:22 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 19/22] nvmet: add context annotation for integrity params in struct nvmet_ns
Date: Wed, 18 Nov 2026 13:05:00 +0530
Message-ID: <20261118073505.288910-20-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX8m6uXhh1KsBF
 7ew0F2GOSOFdlTl0YT8xD1Hes/+y4jgkrHOvhDtyZUd8JqHEq6fmCUDVrTdfXQsPbq5JFqpkVOE
 WRqmpedG/VeTmj7nre4n7O9MkvUOISp7CRoFuw1m29PLzPPopDBM/eFmECDqta3ICvoZ60pyDun
 pHYTlwf/MiOyPvuXeSxqkCz441OkMqtjqSTzyPXRkmy0MHqml7Vx7WLTPI0cbIv9Y0dutMCAOd2
 cbAlhFfhQnIlY1sBY1OtdJSx/iAj8qaoBWufXLNNwvF4kk6AaRDrX2jeASv55/fFeNt9xwQR4sp
 7Ur3W0JeMxQCJf+Fjp9AmzvZFgsZrWyf6dSxkah42cvsms4FUSqeX/KAU0vRap2qcsY4BvRDVgJ
 S5mYHTRHUgsv89mUlTfSsswl7ew3cMihOMH+qDZLL2C6TLQZtyWZ7r4SzVGW5GuC/uVeGbZmAUy
 JwqEchtdsgVcfqMZPiw==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afd55be cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=BZN9Et1uhVGu1YSWURkA:9
X-Proofpoint-GUID: DT_daY8rgd-z-sF6cxySxNMbq133fO55
X-Proofpoint-ORIG-GUID: 8uhwlSPk5MeS37mjXMF4LrtH7IQGp9Z6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX+3lNO+D/e5A0
 PT08ElzOP2AfBRLsf4JK4wCvxd6JcLETNMlClEBvGXBLLUrBrgAH2jpZLM7tUJDybeQ7/q2cyKo
 lb/HxvTNW1ZkSbD6UmCg9nQcnvlUPag=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_073746_793033_884B2D4F 
X-CRM114-Status: GOOD (  18.00  )
X-Spam-Score: -0.7 (/)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The nvmet_ns::pi_type and nvmet_ns::metadata_size fields are protected
by nvmet_subsys::lock. Annotate them with __guarded_by(&subsys->lock)
to allow the Clang context analyzer to validate accesses to these fields.

Some request-processing and I/O paths access these fields without
holding subsys->lock. This is safe because the namespace reference held
by the request prevents the integrity parameters from being modified
while I/O is in flight. However, the context analyzer cannot express
this access pattern directly.

Introduce nvmet_ns_pi_type() and nvmet_ns_metadata_size() as inline
helpers annotated with __context_unsafe() to allow these lockless
accesses without triggering context analyzer warnings.

Use these helpers in the namespace identify path, metadata length
calculation, PI capability check, and RDMA signature attribute setup.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c |  4 ++--
 drivers/nvme/target/nvmet.h     | 13 +++++++++----
 drivers/nvme/target/rdma.c      |  2 +-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 75a833253545..ea43d83d269b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -939,9 +939,9 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 			  NVME_NS_DPC_PI_TYPE1 | NVME_NS_DPC_PI_TYPE2 |
 			  NVME_NS_DPC_PI_TYPE3;
 		id->mc = NVME_MC_EXTENDED_LBA;
-		id->dps = req->ns->pi_type;
+		id->dps = nvmet_ns_pi_type(req->ns);
 		id->flbas = NVME_NS_FLBAS_META_EXT;
-		id->lbaf[0].ms = cpu_to_le16(req->ns->metadata_size);
+		id->lbaf[0].ms = cpu_to_le16(nvmet_ns_metadata_size(req->ns));
 	}
 
 	if (nvmet_ns_readonly(req->ns))
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 08cf6364c4a6..1da9cfacfc4c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -188,8 +188,10 @@ struct nvmet_ns {
 		__guarded_by(&subsys->lock);
 	int			use_p2pmem
 		__guarded_by(&subsys->lock);
-	int			pi_type;
-	int			metadata_size;
+	int			pi_type
+		__guarded_by(&subsys->lock);
+	int			metadata_size
+		__guarded_by(&subsys->lock);
 	u8			csi;
 	struct nvmet_pr		pr;
 	struct xarray		pr_per_ctrl_refs;
@@ -219,6 +221,8 @@ NVMET_NS_ACCESSOR(u8 *, nguid)
 NVMET_NS_ACCESSOR(uuid_t, uuid)
 NVMET_NS_ACCESSOR(bool, buffered_io)
 NVMET_NS_ACCESSOR(const char *, device_path)
+NVMET_NS_ACCESSOR(int, pi_type)
+NVMET_NS_ACCESSOR(int, metadata_size)
 
 /*
  * These accessors use data_race() and READ_ONCE() marker to allow lockless
@@ -830,7 +834,7 @@ static inline u32 nvmet_rw_metadata_len(struct nvmet_req *req)
 	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
 		return 0;
 	return ((u32)le16_to_cpu(req->cmd->rw.length) + 1) *
-			req->ns->metadata_size;
+			nvmet_ns_metadata_size(req->ns);
 }
 
 static inline u32 nvmet_dsm_len(struct nvmet_req *req)
@@ -1010,7 +1014,8 @@ static inline bool nvmet_ns_has_pi(struct nvmet_ns *ns)
 {
 	if (!IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY))
 		return false;
-	return ns->pi_type && ns->metadata_size == sizeof(struct t10_pi_tuple);
+	return nvmet_ns_pi_type(ns) &&
+	       nvmet_ns_metadata_size(ns) == sizeof(struct t10_pi_tuple);
 }
 
 static inline __le64 nvmet_sect_to_lba(struct nvmet_ns *ns, sector_t sect)
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 0b351d39340c..2cec457f12fd 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -591,7 +591,7 @@ static void nvmet_rdma_set_sig_attrs(struct nvmet_req *req,
 {
 	struct nvme_command *cmd = req->cmd;
 	u16 control = le16_to_cpu(cmd->rw.control);
-	u8 pi_type = req->ns->pi_type;
+	u8 pi_type = nvmet_ns_pi_type(req->ns);
 	struct blk_integrity *bi;
 
 	bi = bdev_get_integrity(nvmet_ns_bdev(req->ns));
-- 
2.53.0


