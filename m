Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10CE606A31C
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QyBKOYeg;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Qn939o7b
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=gbfx+HONdxTjnf1ShHFyGIwgvd0MAtDerLcLtj34T8g=; b=QyBKOYegU3/cKd
	HZICb+1lkvO/QwIoS+YUvR53lPQpTY68B3jGs3Vv340mTmpaKxtyylK9y4SLA7svzKo3b2wsnXCSX
	3RdLm8FL02466u/96MAltrOXBA5BM3877BOpee2FooSGqN0DN165AmJBmikqkjbgORRiEG5HD+ED6
	/SiR4h9HjAzYBF8Ptz0KKvOUkpB9/iLkpWhyVnMlOqY4N0hrIxTw1tpaUo1H+uGeiDhomPfR/Jtuo
	nQ2y9FMjkBoksoMQK/hji3qZ4J9ieHDd0qlVfQsX8OINTkGXns8UpRGyvioc0G444hrIs/DLDMNjg
	4ki82HgtgytO6SPHG5vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7k-0000000HDAq-1IFM;
	Mon, 09 Nov 2026 03:32:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG7d-0000000HD4T-45Wz
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:32:44 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90j16S1889969;
	Mon, 9 Nov 2026 03:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gbfx+HONdxTjnf1Sh
	HFyGIwgvd0MAtDerLcLtj34T8g=; b=Qn939o7b52EXTj2ssFgemswwZ05fNv7Yz
	XsFyNYjZHaz5az8oK+o8f26rsOcoREzRNj6JSZLtRwvUViha3LbKbcN8cK4Hl65P
	2KCA5DiLqiSiPi/xj/h3WBdNN+hRfu9s8+C3tJlWVvrgTTmqt/f3BSpnciF+7P+0
	2wD6AFfLFZwmJfIxHjEKSm11k/5x7QCZI/DjmQp8xLF/Cplj8nt3pMTM+/yQH4Ww
	QG0O0PT2GVhUbnlcEdNkS4lwkLbZS8amwSj2Xca6eID43nf/SUfL0iQW5tiR+XW+
	fJuDCJflzpDM+nUYIpTFWsZixUapJKHb0ZuBYFt6PxIFf5brtrLkA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdkaxr8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93JsIE2454044;
	Mon, 9 Nov 2026 03:32:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4htghfw75d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:32:33 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93WTUg43057606
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:32:29 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10D0720043;
	Mon,  9 Nov 2026 03:32:29 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5422720040;
	Mon,  9 Nov 2026 03:32:24 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:32:23 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 10/23] nvmet: add context annotation for nvmet_ns::nguid
Date: Mon,  9 Nov 2026 08:58:15 +0530
Message-ID: <20261109033102.982191-35-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af13ed2 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=JUXBJQCMN5wntnr3pyIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX8XlhadmlE7OB
 32wtmA7LJrBVazFel4FFRH2G06UxFvZa6IeHroCsJgtfJ+ru4dmJKR8EDSbGJuX0VmiwnPHJXmV
 ICSgMrF+JWRAoP0nhTIXEVhftLrKJq9FJV3+aXUSapK6nD2vephWmIM5EFFTY27Nf1lfOHQBRUg
 R1xEaKRtMkFwRUUH3D6x+7trjJSXPTJFUhTm/wX8fToUuuxdaellKblwra/Eug8umm/GOsMBR20
 G1jmKbMV1j7LyJNwxe5ScE9IDKp1wCI/AzeXQmbXhkccUn2pOSoPEK3Lcf0TFkTV4KB0ugT8g7D
 5ohuv5AwLl2GkQgKmT26nK0OoReyih32MkK2volj5tfsxyIlsua8JmQW121o9gtC42pVyDpfgIo
 6F0/avrbjObtUCT2CepYalJ6AXPPCQy/Cc9ouk0OzQqJybGyoA9g3FO3HidG3DUcgOWeic9xNBr
 TlxZ2D7QzrOa/zn0Alw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX/yMMnjckAQrb
 R8keIMsg9FeO4gF7xh4lUgQ/Wc/QAWyxIluEyqDMTqft42KHvZc+W/v49zFchz9ijmRhaTO7AHT
 TLmmaggWX2ZAi7f49gARg16audY3n7c=
X-Proofpoint-ORIG-GUID: G62BEKwdDATecjWNvAvQq0KkVVyY0_yD
X-Proofpoint-GUID: iUkP9FUcqrPVlmHpZxe_va4wkhRu5-y7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193242_139983_6712D8A4 
X-CRM114-Status: GOOD (  16.53  )
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
index 7cdf13351678..d784498ca720 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -934,7 +934,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	 */
 	id->endgid = cpu_to_le16(nvmet_ns_nsid(req->ns));
 
-	memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
+	memcpy(&id->nguid, nvmet_ns_nguid(req->ns), sizeof(id->nguid));
 
 	id->lbaf[0].ds = nvmet_ns_blksize_shift(req->ns);
 
@@ -1094,10 +1094,11 @@ static void nvmet_execute_identify_desclist(struct nvmet_req *req)
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
index 59adf99470f8..21ed96b39a31 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -163,7 +163,8 @@ struct nvmet_ns {
 		__guarded_by(&subsys->lock);
 	loff_t			size
 		__guarded_by(&subsys->lock);
-	u8			nguid[16];
+	u8			nguid[16]
+		__guarded_by(&subsys->lock);
 	uuid_t			uuid;
 	u32			anagrpid;
 
@@ -210,6 +211,7 @@ NVMET_NS_ACCESSOR(struct block_device *, bdev)
 NVMET_NS_ACCESSOR(struct file *, file)
 NVMET_NS_ACCESSOR(u32, nsid)
 NVMET_NS_ACCESSOR(u32, blksize_shift)
+NVMET_NS_ACCESSOR(u8 *, nguid)
 
 /*
  * These accessors use data_race() and READ_ONCE() to allow lockless access to
-- 
2.53.0


