Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2C2606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=EEG0ZRyP;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=desbkCbk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ykRFqstvtKdWyQVi6RA0z+3R/JEK1xJit16sQiPW6go=; b=EEG0ZRyPBRBAWD
	qLJNNP9BR7r4CL9snvKbZSDPpqQIsrTEYV+xTg8FIhy8XDnitgZhNYJERWKXPvqlC8FYP1JffBeg+
	lfouGHEJBX/EXh16Si4SmoG2TDxCh6EgnRTWXSHpwVLkCC+u6/fRaFvDJpS+2h2B0QGkZ/5KX5T1h
	LO+M2ytBv4yI5EfnEvqNh4544EakdFA5F+Y6tIt2bmt7aUYjQnJOYq53FxrN897NmXQF81LhOl43Y
	tB7dXykrguxYrwWL9rtMRltWpMPUVuZrYSzOtvvRR7oREloPH6Z5N55ciSqjgmhyMtTWRMvG9aXCt
	8ZNAXi470YNfQn5S+F4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDp-000000081Ds-3YA4;
	Wed, 18 Nov 2026 07:36:49 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDn-000000081BY-00FJ
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:36:48 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2SRVH4045171;
	Wed, 18 Nov 2026 07:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ykRFqstvtKdWyQVi6
	RA0z+3R/JEK1xJit16sQiPW6go=; b=desbkCbkMaX4+sA9nk0j+fxcRWXOysNHs
	5U7gKeK+0krqIBczjh7Rmd+sFTSsrRHdJPCPtGteCS//UZvrAIkOy+vIPuXiGQ63
	RtMQUKpwBqi6hwz4mt9Q7ZLUlGvfkhdQd9cv82oLHT2IFmzRr3ooyhr4OGZ0IlF0
	f1IGA4FZo1hpy3pFAMGCv2ZyousOpqBV+4kojwCVza9OwNghL7zSgX9MwQMhpDR4
	hcUD8rKUer83cNxwgBTWU9FocPfpw4UzGJw0g9ONbQEO3LeGstwWrjGHjwdrLy9m
	lC5t2DZwHtFYO7yRa7fwrfebGSFSE/RPFP2jcPc9po0yiWPMDdMLQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105wsb6t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:37 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2nuAg680851;
	Wed, 18 Nov 2026 07:36:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hy2bvh6kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7aXEC52560274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:36:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0707720049;
	Wed, 18 Nov 2026 07:36:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BA2220040;
	Wed, 18 Nov 2026 07:36:28 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:36:27 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 09/22] nvmet: add context annotation for nvmet_ns::uuid
Date: Wed, 18 Nov 2026 13:04:50 +0530
Message-ID: <20261118073505.288910-10-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: JWnIH5a0g_UIRdP0qaUL7lWLq4NajNMK
X-Proofpoint-GUID: nD4IgyEhaE0FntVmVLHMq9AGuQfGPAAE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX4b0yJT0N3igR
 roTGbmd+vnzlqcOis+hZO4ulzPxOyA9Uatyh5HDuF2EUP2mpQkxL0/PuXo9yaxS3a2eJz97Y583
 0SCVzM7cXvQf4dw5zVYU33odQcbFAhr+FQXCiFPNmun37QGkUmO1rGlpZeyalQMlF1KX+BR+MzB
 Vo3HBXFduZKOcIm88pZempmR8ISbSSe5qtiO4K3wLXOU07w7egf3A9chgmyIL9a0FkmxY7lO82U
 l42LCc1Vo6I79ixy3v5dupkBvQ8aHoTHuYY/dBm+ONX2cwNeTU2ynmkmaR+2cm3deE6SbExEYKg
 soqeBRi23CHxOMUKg9co2JZ4hXfM3kr9wk5wIiwxiNF7WGR60JZYjCtixyL4giWLum4CSk46tew
 7jQRUFv+BBfqNoOuOTrET6Qrrg/4O+ufpAzomDRxM0gArWpAt+McXFLTv3GybL9fMdfIjSpn3Kn
 qH5p7CahnkSMHFINsSg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX2TNbbeN2HZIL
 X1vKOiYQ0T/E+1sTGdKKIuan41a+O+1fyvBkwOGp1vF+8wcsaAEEbgKNU0x+Pn6BCBpm8Iwal4v
 vUs1OEatmYC1PvLDjoSEX3Rq4a11gmY=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afd5586 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=cUUimdFmrlSUHkbu_74A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_233647_291825_9550F00F 
X-CRM114-Status: GOOD (  15.47  )
X-Spam-Score: -2.6 (--)
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

The nvmet_ns::uuid field is protected by nvmet_subsys::lock. Annotate
it with __guarded_by(&subsys->lock) so that the clang context analyzer
can validate accesses to this field.

Some accesses to nvmet_ns::uuid in the I/O hotpath do not require
holding nvmet_subsys::lock, as the namespace reference guarantees that
the namespace remains valid and the field is not modified while I/O is
in flight. However, the clang context analyzer cannot express this
access pattern directly.

Introduce nvmet_ns_uuid() as an inline helper annotated with
__context_unsafe() to allow these accesses without requiring the
subsystem lock. Convert the relevant accesses in the I/O hotpath and
request-processing paths to use this helper.

Additionally, acquire ns->subsys->lock in nvmet_ns_device_uuid_show()
before accessing ns->uuid, since this configfs control path does not
hold the lock.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c | 6 ++++--
 drivers/nvme/target/configfs.c  | 9 ++++++++-
 drivers/nvme/target/nvmet.h     | 4 +++-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 45b68f2419c8..75a833253545 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1058,15 +1058,17 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 {
 	off_t off = 0;
 	u16 status;
+	uuid_t uuid;
 
 	status = nvmet_req_find_ns(req);
 	if (status)
 		goto out;
 
-	if (memchr_inv(&req->ns->uuid, 0, sizeof(req->ns->uuid))) {
+	uuid = nvmet_ns_uuid(req->ns);
+	if (memchr_inv(&uuid, 0, sizeof(uuid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
 						  NVME_NIDT_UUID_LEN,
-						  &req->ns->uuid, &off);
+						  &uuid, &off);
 		if (status)
 			goto out;
 	}
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index cd2c301bc69a..f8a4d0d88946 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -615,7 +615,14 @@ CONFIGFS_ATTR(nvmet_ns_, p2pmem);
 
 static ssize_t nvmet_ns_device_uuid_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%pUb\n", &to_nvmet_ns(item)->uuid);
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	ssize_t size;
+
+	mutex_lock(&ns->subsys->lock);
+	size = sprintf(page, "%pUb\n", &ns->uuid);
+	mutex_unlock(&ns->subsys->lock);
+
+	return size;
 }
 
 static ssize_t nvmet_ns_device_uuid_store(struct config_item *item,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index d284ec162916..847115759985 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -164,7 +164,8 @@ struct nvmet_ns {
 		__guarded_by(&subsys->lock);
 	u8			nguid[16]
 		__guarded_by(&subsys->lock);
-	uuid_t			uuid;
+	uuid_t			uuid
+		__guarded_by(&subsys->lock);
 	u32			anagrpid;
 
 	bool			buffered_io;
@@ -210,6 +211,7 @@ NVMET_NS_ACCESSOR(struct block_device *, bdev)
 NVMET_NS_ACCESSOR(struct file *, file)
 NVMET_NS_ACCESSOR(u32, blksize_shift)
 NVMET_NS_ACCESSOR(u8 *, nguid)
+NVMET_NS_ACCESSOR(uuid_t, uuid)
 
 /*
  * These accessors use data_race() and READ_ONCE() marker to allow lockless
-- 
2.53.0


