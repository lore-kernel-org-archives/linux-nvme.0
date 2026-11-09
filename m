Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAC0606A320
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2026 03:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Xl7Xqs1O;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=qi4/u2zB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=M40yuVxzae41MoO9x9Ul4RH5jv0grEON/X0dtaij3ZY=; b=Xl7Xqs1ODmR3xp
	21vZwXG/6lp+uzjLHnbCWmC9BCAmVFdZPjXV70H9yzeBuG7Q4i3ULMY/UJtekNoPoGj7Ws5lqJAqx
	oMsXIWPwx0UW8419f9y0BbwuhGxXaJqAkG56chWmYvD7dfs0t8KbGSm9w8/1NwJvan5V0yFMvspsf
	emqHapfCtJYL8e8HqAXHtr55xMqdC6aSkf6e+sJqO1VfGGuTw/1m68LWD9R9XFljdVTKLrJ6mZ8Q5
	kFzbk0BLQUHkjKgsGDKydc8r7ifTeGg+gR5GFjU1/vyb6Ty5lnk0ewKzHdGdpRxmsk3YBdS5c6PGi
	W5ArNrrAuNhnCmfQmZPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8t-0000000HEM8-23Kq;
	Mon, 09 Nov 2026 03:33:59 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQG8m-0000000HEGx-0Fhg
	for linux-nvme@lists.infradead.org;
	Mon, 09 Nov 2026 03:33:58 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A90iSfG746450;
	Mon, 9 Nov 2026 03:33:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=M40yuVxzae41MoO9x
	9Ul4RH5jv0grEON/X0dtaij3ZY=; b=qi4/u2zBEC8hA6LZdZehaX6DyIKRhU8jQ
	HNnmWO7MFP0DT4+nR46LvYwbJ3vieJSf3lLZ5yqr4htEQMYtLWlsehGNDNCX8rhG
	xcUbvhIx0/IBbU0gWBAqGWBIPqFePnYlNchhTRTBmeBGKODwn1iOltryundwZ/w9
	ao9mL/3bHjfhHeOEXeUsIcAdiBO9uGgJAGkSPDqKoIzFvvlNDBGXbVnXT9xn8FuL
	PKgTQQ+TGSGgDn/I6Wn5SIPok5c10B+yT5JJ4meRWxtQRVn5nlsdWFoTOe/X8P9N
	M70aIubXG+WThHgs5ngQb5HMWQ4HQzswR6LZHFBS1JLT3YWZvWg2A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hstdfte4m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:45 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A93K0Hv3674835;
	Mon, 9 Nov 2026 03:33:44 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4htfthdbn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Nov 2026 03:33:44 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A93XeAS30212506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Nov 2026 03:33:40 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95E6C20043;
	Mon,  9 Nov 2026 03:33:40 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30D5E20040;
	Mon,  9 Nov 2026 03:33:35 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.101.130])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Nov 2026 03:33:34 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
        chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, bvanassche@acm.org, elver@google.com,
        linux-nvme@lists.infradead.org, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 21/23] nvmet: add context annotation for integrity params in struct nvmet_ns
Date: Mon,  9 Nov 2026 08:58:26 +0530
Message-ID: <20261109033102.982191-46-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109033102.982191-25-nilay@linux.ibm.com>
References: <20261109033102.982191-25-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J+M/fwnS c=1 sm=1 tr=0 ts=6af13f19 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=BZN9Et1uhVGu1YSWURkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX0FLPODJNgAJf
 uQAGyCxdGH1ttOmhN003dLFRtYoU/OAUwznX/ATkPOkgB8E8p6M+5hpL4khIOz4uhlyr8CUEtWH
 5k27LX7icQ+JPtbomKCkA+fHjxf1xaEvg08aPmyg3SQ49iZPRlT/bF/3KXQPsoRR4Rt989lOYqn
 1VthqaeNH8g+xDFxB+huYkO4ymHXs5CByp0yxFjfp1oJxthydL5IT2P4T8Q+CMFwhSYcC0cVCX+
 Ke6i4enmGJFS/MATJTTCk+EgbnTMY9Ouw9Nyy/lbLCDrLyP02VHc/vkwbFiXiXNMTyvF+HOWMxo
 fGmdJJcr7Zimi9TxwRy1cSleBfV62FKNg3RLmJ7WgiGbmK/CagNdEBDGoZZXKLYAOpA9OaciUh7
 bwh0yUzMnbhzLU/OKu60yv2UvOwDLOtg+F7BEU/UObVeowy7oawUZIZaHRx5zwQNrEtmAyFGQWh
 sxcht2y2EVWe1ERYwNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDAxMiBTYWx0ZWRfX/gEUrevMVlCn
 bG9/C09TmJizAhI+ojXbZlJMQOa0/5AQwI73kN9vscgfOVxm+w3GaXnmqkHuMPAMvS/Zvi3DRrO
 XdhIbVeAKns3iNQlkluDVsbSvG0I198=
X-Proofpoint-GUID: pirv2fBw6D9tDaUGIpsWvQ7CKfKs8LWY
X-Proofpoint-ORIG-GUID: QnWFfX_5gghLYXvab0fIODUTlnlEaL8h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_01,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090012
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_193352_236723_565D5C04 
X-CRM114-Status: GOOD (  18.56  )
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
index b8015054de46..e40fc361f5b6 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -943,9 +943,9 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
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
index 9e7a3992bb76..082d848ea2b0 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -189,8 +189,10 @@ struct nvmet_ns {
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
@@ -221,6 +223,8 @@ NVMET_NS_ACCESSOR(u8 *, nguid)
 NVMET_NS_ACCESSOR(uuid_t, uuid)
 NVMET_NS_ACCESSOR(bool, buffered_io)
 NVMET_NS_ACCESSOR(const char *, device_path)
+NVMET_NS_ACCESSOR(int, pi_type)
+NVMET_NS_ACCESSOR(int, metadata_size)
 
 /*
  * These accessors use data_race() and READ_ONCE() to allow lockless access to
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


