Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D04B606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A/mmEJma;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f6nhcQuG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=E6vDDilHigT0pbgQ6F5/57RQD/4Ez/tKlS0CpOxOAjA=; b=A/mmEJmaLHqO19
	7OOKA6ySGxT8TZViO3dtq8BQENQRwO1SNUcNn6y03uyqP11HmXG8m2GREMg3WjWnbTAJtJdQSHBrF
	WTSgt+0qOIcFHSD0hiDVddUd/BUoHSk1D6XSCj7wlM1gYQ1b//0gZiS6NShCrBjEJRjigOUTznf/3
	UvPHdiy1FPciQEE7OUSDvKG7Om/rnvotrV/ZOlHSI3NLy6JCzUCe6SrPxjTkVRhpyklG0BLAS5hxE
	3jmFWzwNG7BEzmI74mpn0a4p9MRhLbTxSClSlWcBLcoEUYrDIK6cqdlBD4znWHHgk2v2Wv3PWZfHZ
	aYd/YPFHySiQZ3YjvUhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7q-0000000HDHy-2qHh;
	Mon, 09 Nov 2026 03:32:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7k-0000000HD8w-0DQD
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:32:53 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90iDH81957357;
	Mon, 9 Nov 2026 03:32:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=E6vDDilHigT0pbgQ6
	F5/57RQD/4Ez/tKlS0CpOxOAjA=; b=f6nhcQuGHGjO93ygUSr2dSkgbGTvQSQXC
	DliOdjyrT1v7PTtZMhsnSig+kstMw/69vV8/FnKPrdqz+zVFHNkd+tRdzxmWqQ9w
	+XckwU2gGmQGOK+6sKsSDhHY8xbvbN2SMJ1vd8HckWUMt0kCN/nZM7oGhSA8yiCI
	RisOqftxwxxCYR4KfHJmZ4sylG3JQBJhjfjbUl9Azn24d8PDou8Nr1IFqLezJRI1
	saAc5XX8iDWor7Tf0JrjJm66gTwsTn0EcT8to2sWfD4hGwHtMJ2v65UQxIwrZyvw
	KGptnPJuuZpumCVfWA90ECA5L0kfJP5qTHPgzIaOPjaKJ0WzR1HAw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumuj30y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:40 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93K2O23630227;
	Mon, 9 Nov 2026 03:32:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hth0xw4ng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93Wai153084642
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:32:36 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 42EAA20043;
	Mon,  9 Nov 2026 03:32:36 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CB1E20040;
	Mon,  9 Nov 2026 03:32:30 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:32:29 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 11/23] nvmet: add context annotation for nvmet_ns::uuid
Date: Mon,  9 Nov 2026 08:58:16 +0530
Message-ID: <20261109033102.982191-36-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX6pajempMWwqi
 sOQl/+KfrluqfgCuC2/8lvPn6xQQhKTJb74rwW2BFz/kbCPRQaZ83mIwXvF47RotgTgfl6uKBvm
 DtzyBa3JkeIGBjTwZigHr8iQbx3TIH4=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af13ed9 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=cUUimdFmrlSUHkbu_74A:9
X-Proofpoint-GUID: TI77XWICDsG6fCJHoqrnXUagm_gvI9qx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX2D4FBJP+piqS
 VfgNemk21O58zTA0KoaaAqrhPCOZmnf53VSIA5ZCkXNkZpyZGeFqe3W5LM9Q3dcK/qnDFK+geMq
 mj6Wy7ttz5OuLDXSPPtEcLZWgwihc11ZGvocq0V/ouGkl4jUJvu1RZc3R70QlzUMtYSIec3wBPb
 BgcuAOdnxPCqW1JIIs+I6MtVcmRU1uOHwp1f+2eT1u3QOFlSxnpw51hGYFy9/Ra/DpUrr/Qbe1Q
 OWeSWiFmDVn1S1MssXklTz6EeSI0Mc1EenBjMe7Jo8TdlfDGeYxtLiUjSft6AKU1sImoXcWOsII
 t/YbPnKzKC6Eo5UZg2kGb1Z2S8YwVgyV/twKWh9mJqcVexp6XogjPv1mD5g05bWZd48F5B2JQSg
 Zn/wM+NBAJwjdah/5KWp8Zyf+RNxOUpfrONSaj84K0e8RsRGyaRhupicdcbVUHzMycbLkBsAezU
 fNXpw4cJ4KZplKEJ1Aw==
X-Proofpoint-ORIG-GUID: 1HXIjwqqLgydPynrblEuEBbFQCx4bOSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193248_243230_E1277E34 
X-CRM114-Status: GOOD (  16.29  )
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
index d784498ca720..b8015054de46 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1082,15 +1082,17 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
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
index 21ed96b39a31..3e18c36e83c8 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -165,7 +165,8 @@ struct nvmet_ns {
 		__guarded_by(&subsys->lock);
 	u8			nguid[16]
 		__guarded_by(&subsys->lock);
-	uuid_t			uuid;
+	uuid_t			uuid
+		__guarded_by(&subsys->lock);
 	u32			anagrpid;
 
 	bool			buffered_io;
@@ -212,6 +213,7 @@ NVMET_NS_ACCESSOR(struct file *, file)
 NVMET_NS_ACCESSOR(u32, nsid)
 NVMET_NS_ACCESSOR(u32, blksize_shift)
 NVMET_NS_ACCESSOR(u8 *, nguid)
+NVMET_NS_ACCESSOR(uuid_t, uuid)
 
 /*
  * These accessors use data_race() and READ_ONCE() to allow lockless access to
-- 
2.53.0


