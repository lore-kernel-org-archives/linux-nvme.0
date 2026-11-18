Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFFE606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Xbz24tnR;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qLeiXRAc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=SKi0fgjxkVIz8zecpZL9wJfAo2auGos899sOkxgM1w4=; b=Xbz24tnRzTpcpA
	lSGrb/eqUG8fbw4stvN5rWxnpHb4e1V6sq9H+eZproVpxfAdoGtG7RKhvJw7C7MBJumwmkGKzUSZE
	ahr4kPxMXTKkHWP0XtHVpdaoWDwueZ6gzodZGaAE2Me07ClwDGfiYGYzNB0ec1An0GzHofjK+ELYr
	IGMI0eu5oYXg5bUOQDY9Cn70NKks4vE/J/dSHL8exGk5WH8QgZ+t2VPdgS0BDP445pkdiKV+hocwj
	so5FZCK143GfvSd6xee/FJQ7Gle3vsfnB5fCQvBCgr0tOob3qURcqcAawOv0CvR2HYNlbewIdlAm2
	x6TkVUvgZXv8NLr11c5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaGM-000000082uM-2Kza;
	Wed, 18 Nov 2026 07:39:26 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaGA-000000082qT-229w
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:39:24 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2SRNl4045166;
	Wed, 18 Nov 2026 07:36:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SKi0fgjxkVIz8zecp
	ZL9wJfAo2auGos899sOkxgM1w4=; b=qLeiXRAcVphtNSb8uCHKE7/vVVsIqp4lf
	Ok8kdMl0M55MLBKYEbIojy6W0m0jqy3TWyiH++AklOVpz4hwnYSn0O2v0v8/0GEm
	XHYX8O6K79IMbhBKBRZiXEWy6XKbMjd/hMWRblzDsNdNfktD3FzpWKIGBv06aAPc
	GL1t0RAw5IfpEAWEtJFkDNnHXic33lpD1Iu3ITpCOBnaf79rZe1IXsJcYmxiOlI0
	HwfQhSHpJ+clexPGMmOR9A4N6/WyY7mBM2MSp6QBemwMYFA4qTUMQ5zsfO+LFA+i
	5TZGmRSU5lOk2TlSN8FThqYaNhZrr6v9rAsPRVT59WuRGKU1sKDpQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105wsb6k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2Z29v274291;
	Wed, 18 Nov 2026 07:36:31 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067neyy6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7aRxp36241736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:36:27 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F84D20049;
	Wed, 18 Nov 2026 07:36:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CE1720040;
	Wed, 18 Nov 2026 07:36:22 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:36:22 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 08/22] nvmet: add context annotation for nvmet_ns::nguid
Date: Wed, 18 Nov 2026 13:04:49 +0530
Message-ID: <20261118073505.288910-9-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: TudV1z0QW0lLelN6vLQ8BeHbPuj3fWkM
X-Proofpoint-GUID: FBOhDevU1XFSnAHRquamVfKca5_k4ms-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfXzu7hUMzHZEGc
 HAHpH2Kppqzem7NLRrpulJLkKOVxowTOyaz7EbSetnvR056dIrmr0ToDQRA7iDeRWTd5rQ2g6/H
 6+uIPT2gXilnJPRgtSWMEsYktBA6BgT6i4z7SQyEnIo4a4/o5wwMEG54cNPB5yC3FzpFk8O67Hj
 qJmIzO/Fxga1XHtOc9Bf5aK+VgtC4M/uia4RapOXGhJ5/xyXINZHb/YUOVSTrHowZbOlDxvQT7a
 P9/AjkaoIWViwQlroUgWZ6MZJkT6DNquaeUYa5q2YGVutAlbUMtqQWFTfsmXxylNywtZr3yput6
 EjxoeSaYx0N2XDwpq069JOZjDJFfiTHVDYQc5J61LyEYJN47pq7o+EYuG49WtMmuOxYp69JEfS/
 YwqSGjt1ptMJoKEsPnfGGQoBhqFNDmPCSM0xZ4TfJrX7cga6wmyiUVFsX17QAiBTZEyOZn44Cr1
 CpMof3Hl4PZ1/Xaspqw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfXxFlINYjy6rDR
 RegLNorkkL5krPrOpkE46aRA3AkHiDyCejWwlHj9E9CUEsZo7+/KkEv9FxSy1VisTkx9islJE6B
 6ZDrsCVZ/m6W15uX9G//d+ZMyp3PqNs=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afd5580 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=JUXBJQCMN5wntnr3pyIA:9
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
X-CRM114-CacheID: sfid-20261117_233919_377548_A1379ACF 
X-CRM114-Status: GOOD (  15.50  )
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

The nvmet_ns::nguid field is protected by nvmet_subsys::lock. Annotate
it with __guarded_by(&subsys->lock) so that the clang context analyzer
can validate accesses to this field.

Some accesses to nvmet_ns::nguid in the I/O hotpath do not require
holding nvmet_subsys::lock, as the namespace reference guarantees that
the namespace remains valid and the field is not modified while I/O is
in flight. However, the clang context analyzer cannot express this
access pattern directly.

Introduce nvmet_ns_nguid() as an inline helper annotated with
__context_unsafe() to allow these accesses without requiring the
subsystem lock. Convert the relevant accesses in the I/O hotpath and
request-processing paths to use this helper.

Additionally, acquire ns->subsys->lock in nvmet_ns_device_nguid_show()
before accessing ns->nguid, since this configfs control path does not
hold the lock.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c | 7 ++++---
 drivers/nvme/target/configfs.c  | 9 ++++++++-
 drivers/nvme/target/nvmet.h     | 4 +++-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index de47c64a2028..45b68f2419c8 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -930,7 +930,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	 */
 	id->endgid = cpu_to_le16(req->ns->nsid);
 
-	memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
+	memcpy(&id->nguid, nvmet_ns_nguid(req->ns), sizeof(id->nguid));
 
 	id->lbaf[0].ds = nvmet_ns_blksize_shift(req->ns);
 
@@ -1070,10 +1070,11 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 		if (status)
 			goto out;
 	}
-	if (memchr_inv(req->ns->nguid, 0, sizeof(req->ns->nguid))) {
+	if (memchr_inv(nvmet_ns_nguid(req->ns), 0, sizeof(req->ns->nguid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_NGUID,
 						  NVME_NIDT_NGUID_LEN,
-						  &req->ns->nguid, &off);
+						  nvmet_ns_nguid(req->ns),
+						  &off);
 		if (status)
 			goto out;
 	}
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 27c50fa533e7..cd2c301bc69a 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -643,7 +643,14 @@ CONFIGFS_ATTR(nvmet_ns_, device_uuid);
 
 static ssize_t nvmet_ns_device_nguid_show(struct config_item *item, char *page)
 {
-	return sprintf(page, "%pUb\n", &to_nvmet_ns(item)->nguid);
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	ssize_t ret;
+
+	mutex_lock(&ns->subsys->lock);
+	ret = sprintf(page, "%pUb\n", &ns->nguid);
+	mutex_unlock(&ns->subsys->lock);
+
+	return ret;
 }
 
 static ssize_t nvmet_ns_device_nguid_store(struct config_item *item,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c90599afcdbd..d284ec162916 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -162,7 +162,8 @@ struct nvmet_ns {
 		__guarded_by(&subsys->lock);
 	loff_t			size
 		__guarded_by(&subsys->lock);
-	u8			nguid[16];
+	u8			nguid[16]
+		__guarded_by(&subsys->lock);
 	uuid_t			uuid;
 	u32			anagrpid;
 
@@ -208,6 +209,7 @@ static inline _type nvmet_ns_##_name(struct nvmet_ns *ns)		    \
 NVMET_NS_ACCESSOR(struct block_device *, bdev)
 NVMET_NS_ACCESSOR(struct file *, file)
 NVMET_NS_ACCESSOR(u32, blksize_shift)
+NVMET_NS_ACCESSOR(u8 *, nguid)
 
 /*
  * These accessors use data_race() and READ_ONCE() marker to allow lockless
-- 
2.53.0


