Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3889606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=32t+9+0f;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=anp9lCKZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=cO97RR0jcy/y6+f97kCadWbQ8NjWc864Cd8aN2tG5uM=; b=32t+9+0fmzwHQ1
	KIYBoyEQauEwS5qfrw9suj2y4HogRUarwLWjZwNCwt/myoV4cZ51Fe0j7GpJRtPPREl0BZKWY+dq9
	7xmzcc44lt8bVplLpJVuTX5bPZgbPG8cHbLOJOyt51seUcC0MRg45GEhnPTdulQF6Nb9P2zjAgin7
	IsVd/ZKXkkKyZiRkC4PjjmWRDcVzDGUeBalA5FvpkT/4Mtu0QTCTYnzAIwwuYTDhWtwm0Y9FWAwje
	2f/TIiFEsaW9TO3K5qnO1rAc7bUWMh6g4Z1zYtvoRbKxcM2GdwFScWnYVUvavpuFEJbOmMdq4p3Jb
	ds3Rfq63eenZDWe3VVUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7M-0000000HCja-1mKW;
	Mon, 09 Nov 2026 03:32:24 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7J-0000000HCgj-3NIN
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:32:23 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90iol81958351;
	Mon, 9 Nov 2026 03:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cO97RR0jcy/y6+f97
	kCadWbQ8NjWc864Cd8aN2tG5uM=; b=anp9lCKZDGcoEmQWZTNt31OxG45ekY2cA
	6EHC9T/6xQwkD97dZkG61ZnwYWdcSIDkQNPpBX4Ye7HV3EgllMiEmFAQQZiJkKh3
	KQ5jOtrkAgmf46SmNwY4w/FKJSDjuVGQm2Cykv5YbADt3zTXKaH4pW12MfdaGZ3F
	IkOovkWMLT0IlnJBGbI7LOe0X11mn6qJ5kS2l59eATUYWIEGYhU5iUamaexmBbWB
	gZwObB8DXLrYZqS8CF2Oh8jd43r3H1MctBEWiieEuQiUxK5DCgDKvWDV4jRx4z/I
	KFCIzBUzMQ1OFnh4zTc6kbtmeswRx4D3qoxoXgSTHphTf6oeXaYmA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumuj2w5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:02 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93JxBE3674806;
	Mon, 9 Nov 2026 03:32:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthdbfk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93VvrR46203186
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:31:57 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7DF3E20043;
	Mon,  9 Nov 2026 03:31:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0331820040;
	Mon,  9 Nov 2026 03:31:51 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:31:49 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 05/23] nvmet: add context annotation for nvmet_ns::readonly
Date: Mon,  9 Nov 2026 08:58:10 +0530
Message-ID: <20261109033102.982191-30-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX3TPf5z/tkC3f
 twlLg7oBkgeCjy5Se8zUGG0eD8zLJ7+o0muU0EcBAIwSQujr+XHGW5OmiB4RxTnMmcSkiUXgTlw
 sXYLeKb8SrSDNrSjlOB/xDLLyD2a2y0=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af13eb2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=uYnn4NJ3HOK8bXenDcAA:9
X-Proofpoint-GUID: rCIQCqRxzR-z72pwYXzkbLdLry07Nwc0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX6JRdLG/suN+O
 7SwIG6JkRsDfXZRwHQF8BVF0BOB+gJQXt284gyWYFL+HEntnydqmMtzeV5dVBKvO1cBcVWOrGXa
 PoZ7bPh1f9/i4abuaAM8JH8SJbvRHs7C6+1XOXVajAw0CKMJ7ig5popsG41su8xFWYb1Stlgu4v
 TyjvS4ydPjTMOJ1KCCXOD1A1Oo/guw8KlDq3sYZXy+NY/4A4Y0OW0b2rvG0fIIIA7WArLqtcDhR
 wjKHtOZf6vs78j/A7LSR/GzuqcwwPxlqTt7qTqlPTp0qABF0wEErAVDKsYuGH0lA2Fl3/ZMUHOZ
 3sEy9m8VzUMMHDodKX1ewHSOgV8tzxTd/5Ku/KYWyv051kFbeoiabB0HVa12akgZ54bvTsj0qeZ
 qOX6jbd133M/DrXOZwVYfMHoW2i5EhqfvC+3hFM3D1hGyghw/xeehie/CBjt3sV8J5Jwc8Qi33/
 dkIHAi/kLwRkK21ae6A==
X-Proofpoint-ORIG-GUID: 7SIvo18I8rxp0TZF8WV7hsHIRGMj2CW8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193221_961415_1F50F1AF 
X-CRM114-Status: GOOD (  20.42  )
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

The nvmet_ns::readonly field is protected by nvmet_subsys::lock.
Annotate it with __guarded_by(&subsys->lock) to allow the Clang
context analyzer to validate accesses to this field.

The admin command handlers nvmet_get_feat_write_protect() and
nvmet_set_feat_write_protect() access nvmet_ns::readonly while
holding ns->subsys->lock. However, the context analyzer cannot
recognize that subsys->lock and ns->subsys->lock refer to the
same mutex. Use ns->subsys->lock directly in these functions
to avoid false positive warnings.

The I/O hotpath functions, nvmet_execute_identify_ns(),
nvmet_execute_id_cs_indep() and nvmet_io_cmd_check_access(),
read nvmet_ns::readonly without holding the lock. These lockless
reads may race with updates to the field, potentially observing a
transient value. Such races are acceptable for these accesses.

Introduce nvmet_ns_readonly() to perform these lockless reads
using data_race(READ_ONCE()). This suppresses KCSAN reports for
the intentional races and informs the context analyzer that the
access is intentionally performed without holding the lock.

Use WRITE_ONCE() for updates to nvmet_ns::readonly in
nvmet_set_feat_write_protect() to pair with the lockless
READ_ONCE() accesses.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c | 15 +++++++--------
 drivers/nvme/target/core.c      |  2 +-
 drivers/nvme/target/nvmet.h     | 16 +++++++++++++++-
 3 files changed, 23 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 517f8cc78473..6b0ba383106d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -938,7 +938,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		id->lbaf[0].ms = cpu_to_le16(req->ns->metadata_size);
 	}
 
-	if (req->ns->readonly)
+	if (nvmet_ns_readonly(req->ns))
 		id->nsattr |= NVME_NS_ATTR_RO;
 done:
 	if (!status)
@@ -1133,7 +1133,7 @@ static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
 	id->nstat = NVME_NSTAT_NRDY;
 	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
 	id->nmic = NVME_NS_NMIC_SHARED;
-	if (req->ns->readonly)
+	if (nvmet_ns_readonly(req->ns))
 		id->nsattr |= NVME_NS_ATTR_RO;
 	if (nvmet_ns_bdev(req->ns) && bdev_rot(nvmet_ns_bdev(req->ns)))
 		id->nsfeat |= NVME_NS_ROTATIONAL;
@@ -1255,13 +1255,13 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 	mutex_lock(&req->ns->subsys->lock);
 	switch (write_protect) {
 	case NVME_NS_WRITE_PROTECT:
-		req->ns->readonly = true;
+		WRITE_ONCE(req->ns->readonly, true);
 		status = nvmet_write_protect_flush_sync(req);
 		if (status)
-			req->ns->readonly = false;
+			WRITE_ONCE(req->ns->readonly, false);
 		break;
 	case NVME_NS_NO_WRITE_PROTECT:
-		req->ns->readonly = false;
+		WRITE_ONCE(req->ns->readonly, false);
 		status = 0;
 		break;
 	default:
@@ -1451,20 +1451,19 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 
 static u16 nvmet_get_feat_write_protect(struct nvmet_req *req)
 {
-	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
 	u32 result;
 
 	result = nvmet_req_find_ns(req);
 	if (result)
 		return result;
 
-	mutex_lock(&subsys->lock);
+	mutex_lock(&req->ns->subsys->lock);
 	if (req->ns->readonly == true)
 		result = NVME_NS_WRITE_PROTECT;
 	else
 		result = NVME_NS_NO_WRITE_PROTECT;
 	nvmet_set_result(req, result);
-	mutex_unlock(&subsys->lock);
+	mutex_unlock(&req->ns->subsys->lock);
 
 	return 0;
 }
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ef99c45f0f37..116b1b500790 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1090,7 +1090,7 @@ static inline u16 nvmet_check_ana_state(struct nvmet_port *port,
 
 static inline u16 nvmet_io_cmd_check_access(struct nvmet_req *req)
 {
-	if (unlikely(req->ns->readonly)) {
+	if (unlikely(nvmet_ns_readonly(req->ns))) {
 		switch (req->cmd->common.opcode) {
 		case nvme_cmd_read:
 		case nvme_cmd_flush:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index b63664250ef4..b76671672aca 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -155,7 +155,8 @@ struct nvmet_ns {
 		__guarded_by(&subsys->lock);
 	struct file		*file
 		__guarded_by(&subsys->lock);
-	bool			readonly;
+	bool			readonly
+		__guarded_by(&subsys->lock);
 	u32			nsid;
 	u32			blksize_shift;
 	loff_t			size;
@@ -205,6 +206,19 @@ static inline _type nvmet_ns_##_name(struct nvmet_ns *ns)		    \
 NVMET_NS_ACCESSOR(struct block_device *, bdev)
 NVMET_NS_ACCESSOR(struct file *, file)
 
+/*
+ * These accessors use data_race() and READ_ONCE() to allow lockless access to
+ * the corresponding fields. Use them only in code paths where a concurrent
+ * update to the field is harmless and the resulting data race is acceptable.
+ */
+#define NVMET_NS_ACCESSOR_RACE(_type, _name)				\
+static inline _type nvmet_ns_##_name(struct nvmet_ns *ns)		\
+{									\
+	return data_race(READ_ONCE(ns->_name));				\
+}									\
+
+NVMET_NS_ACCESSOR_RACE(bool, readonly)
+
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
 {
 	return container_of(to_config_group(item), struct nvmet_ns, group);
-- 
2.53.0


