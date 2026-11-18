Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90A8606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=aEFKfhq8;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=QZaDGfG8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=AQq4itrLiRWOFnto32K4h2j0KPQgzxqv/xcEtWncFc4=; b=aEFKfhq8Ibdq0K
	UBv34tNid2Q2LFx3Twqd4wHzFljvsBZAfmUrfUl6LiqfWGCxeE7apY1/bZYh+oGqJqs+Aq/pqWcKM
	vm1NIXP8P9ZX0Zg+j1T8EJoPUMHQoqJmuwCz/87TCzqqp5ZWkrt4nTavSP/Ea9nKImLYqTUNiKtB+
	XB4qmGlW3nN6USZdlFpOEArBjvnAb5Z9q2G8Ui/2tOXRs/cSd4LjcLszbKURm/tuFRu9Bxu9jcMRn
	Y0eOmA4wR/En9q/jLtNifS6xNqNn9fCxtVbIcM/NTop/9OLdcBvr2fuUo8g5NVA3PuKcCyQxzvqHI
	pZPu2RsB18u93AcpZLlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDR-000000080yd-1S9d;
	Wed, 18 Nov 2026 07:36:25 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaDP-000000080wC-01EQ
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:36:24 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2U0PK4068663;
	Wed, 18 Nov 2026 07:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AQq4itrLiRWOFnto3
	2K4h2j0KPQgzxqv/xcEtWncFc4=; b=QZaDGfG8S5FoWoOf9hy0Aa7w6bTsF2h5n
	nWxWTF4VmhdzwmdwPbnLxMyM84oGQO4L70cHP4RJrywN3MeWUHm5yIox75W6m1y1
	5SUHREHHzijse+u5zZM4KsNQ7qiwaZ6JkWU6Y4yN6CAEWBnTQR0/n9iDcLEddZQu
	79l+diR7VwI4nKU0SuHx7Dx+jTqVtUsJFw9QuMaqWKzG0KbC/POMvgXi9ZS7p/Wd
	YpAnO1wtS3PSKVcLbzbwUhJJ0A8JgrfhLirZtMockYtVy2TERad8poS+K3BpYR3R
	LAcBB5+Djkvi0PiEzHGdog9eWlW45F5TO8mV/kdBwivvAeE2oNv2g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105t1cvr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2Ywak274258;
	Wed, 18 Nov 2026 07:36:14 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j067neyxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:14 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7aA6P28705464
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:36:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1A692004D;
	Wed, 18 Nov 2026 07:36:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D17E2004E;
	Wed, 18 Nov 2026 07:36:06 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:36:05 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 05/22] nvmet: add context annotation for nvmet_ns::readonly
Date: Wed, 18 Nov 2026 13:04:46 +0530
Message-ID: <20261118073505.288910-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6afd556f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=uYnn4NJ3HOK8bXenDcAA:9
X-Proofpoint-ORIG-GUID: E8dCujTxcZUuGvyoz7pXrBAPFrzng999
X-Proofpoint-GUID: TXjAaou21OfH_nWvOhyNjS7oBaNr1gO5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfXzVi8B7kqTlBH
 yW1QFAdqQkKCUafexTfQh7gajodAvRP8l5SwSudvF/fEpKDsFTC9wWqKkUNbfjHxEF5p8ItQ8we
 tdDcdT7cczp35Klrkt2/RQkMg2yYZ3o1DZGEEg0jZfxZrTGARGmxLzZX0/RINCNNhJrF4iWsROS
 n6Fvhgnto5bgqi4pYbChDbETLf6IGRGUrxQpd2WBlAyQln8BTmQTr1JZlqJpHnUfOtU419cnRbe
 1GptO9e7acyQegxKPeem/8SxFCcbGZPFcGZfpOPj5LBU6OyeoRm7nReumXaQHuk7TbED/KOGZrw
 s7ivoGZ7bKEEpsi48SMc5e33U1drqlTamHJAk4RtVkRiYgtfrbs5x9hDcPSY/ezNLSuWMD42HX7
 BGnWwSKPozfPS+poJ8XesH9u+HslbkamvrjNTkuqc0wpdzEVa+k9YjK6loQNMQG4M+HWGQMkWpg
 XYW4RdsnTQuFqmLFYZQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfXzvA+ven/bgXx
 IKgZQsZVUAHMxptCr5Y9WyonJK1e0UETEN/HoA/VYOrXsdgrN4Zxu3hnA2/97b2QU4B3NLBesXW
 vermEe8q8+R2GyrKDQuoFBMQU7vf0wk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_233623_068884_D03CA9B0 
X-CRM114-Status: GOOD (  18.78  )
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

The admin identify functions, nvmet_execute_identify_ns() and
nvmet_execute_id_cs_indep() as well as I/O hotpath function
nvmet_io_cmd_check_access() read nvmet_ns::readonly without holding
the lock. These lockless reads may race with updates to the field,
potentially observing a transient value. Such races are acceptable
for these accesses.

Introduce nvmet_ns_readonly() to perform these lockless reads using
data_race(READ_ONCE()). This suppresses KCSAN reports for the
intentional races and informs the context analyzer that the access
is intentionally performed without holding the lock.

Use WRITE_ONCE() for updates to nvmet_ns::readonly in
nvmet_set_feat_write_protect() to pair with the lockless
READ_ONCE() accesses.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/admin-cmd.c | 15 +++++++--------
 drivers/nvme/target/core.c      |  2 +-
 drivers/nvme/target/nvmet.h     | 18 +++++++++++++++++-
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 756bf627c16e..1f553ff3800c 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -943,7 +943,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		id->lbaf[0].ms = cpu_to_le16(req->ns->metadata_size);
 	}
 
-	if (req->ns->readonly)
+	if (nvmet_ns_readonly(req->ns))
 		id->nsattr |= NVME_NS_ATTR_RO;
 done:
 	if (!status)
@@ -1138,7 +1138,7 @@ static void nvmet_execute_id_cs_indep(struct nvmet_req *req)
 	id->nstat = NVME_NSTAT_NRDY;
 	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
 	id->nmic = NVME_NS_NMIC_SHARED;
-	if (req->ns->readonly)
+	if (nvmet_ns_readonly(req->ns))
 		id->nsattr |= NVME_NS_ATTR_RO;
 	if (nvmet_ns_bdev(req->ns) && bdev_rot(nvmet_ns_bdev(req->ns)))
 		id->nsfeat |= NVME_NS_ROTATIONAL;
@@ -1261,13 +1261,13 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
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
@@ -1458,20 +1458,19 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 
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
index 0cf0f311ed10..2c60210c14d6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1082,7 +1082,7 @@ static inline u16 nvmet_check_ana_state(struct nvmet_port *port,
 
 static inline u16 nvmet_io_cmd_check_access(struct nvmet_req *req)
 {
-	if (unlikely(req->ns->readonly)) {
+	if (unlikely(nvmet_ns_readonly(req->ns))) {
 		switch (req->cmd->common.opcode) {
 		case nvme_cmd_read:
 		case nvme_cmd_flush:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 256ffa3c08cc..5598edf53b76 100644
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
@@ -205,6 +206,21 @@ static inline _type nvmet_ns_##_name(struct nvmet_ns *ns)		    \
 NVMET_NS_ACCESSOR(struct block_device *, bdev)
 NVMET_NS_ACCESSOR(struct file *, file)
 
+/*
+ * These accessors use data_race() and READ_ONCE() marker to allow lockless
+ * access to the corresponding fields. The data_race() also helps silence the
+ * context analyser warning about lockless access to the marked field. Use them
+ * only in code paths where a concurrent update to the field is harmless and
+ * the resulting data race is acceptable.
+ */
+#define NVMET_NS_ACCESSOR_MARKED(_type, _name)				\
+static inline _type nvmet_ns_##_name(struct nvmet_ns *ns)		\
+{									\
+	return data_race(READ_ONCE(ns->_name));				\
+}
+
+NVMET_NS_ACCESSOR_MARKED(bool, readonly)
+
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
 {
 	return container_of(to_config_group(item), struct nvmet_ns, group);
-- 
2.53.0


