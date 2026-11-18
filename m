Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A989E606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2m+d5kRF;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=N+jTfJcV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=MvyFmuOONQykNdozlYNUzoLQ/vvVFs4m8PqkEi9v/5A=; b=2m+d5kRFWKjOuR
	o7nB7ZZ0TgrlvbmFCqzUgm/F8m8trjbJh62ra1g2D/ClvSIynfhflfxOCL3rYjnmOTeO7T0hPalTz
	nk5I8XesBjfz5xok3g0VfxY54OXP/TfwkFuFe2IMiHqn1MwPnGdOoZVqi2gbi7YYNibGSASOoPQx+
	Ny9ADzMkuWzOrak7qpTVuq4x/DlJXxmQwcceHeKrSj7z3a40KOUf4kLDZXhkx8UzgU73SzEFq6AEW
	MaDFiaUqjWwzUXPvyUdVQq/1ERnia0yqYDYpc+Crme2r4Z4m5XBYfafje/j/lcRHx6C4MvoGSMI3x
	kggRJXiu5NEee1LJV8GA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaE9-000000081Po-14xV;
	Wed, 18 Nov 2026 07:37:09 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaE6-000000081OY-0UEs
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:37:08 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2SRVJ4045171;
	Wed, 18 Nov 2026 07:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=MvyFmuOONQykNdozl
	YNUzoLQ/vvVFs4m8PqkEi9v/5A=; b=N+jTfJcViYA0iOqk8e8W4Tretx8t7xzSf
	1mCt/dmV6WLjMCP59qlgxuLmpuhp/DyZBYonsCbAuUopsAKHwro+09M8W9e5pCwz
	CofjVl3MNl4QuDGhNg/IqVSvDSiGwJpf5/XSTnuHyVHZPJC4f2cMumSSab+WT2WO
	Bd3FHGmBqfzM15QMWkQyuGm3WX92lggEzF/bqsptY1PLtzWt39GTVacNI8jZOyCa
	8FSEQqqg006yvLbDuQhrM0rvBCcGgxGxuujcZRbZciyLNOxt5+pH2fYL7Ryn3PHP
	LyEeyFVQ+J0I/lsURihNADuYHWsfvpkwsuV6IpX/QAyiqkYOIMaqA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105wsb7f-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:49 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2YvDS2766497;
	Wed, 18 Nov 2026 07:36:48 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hyxwt7kuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:36:48 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7ai4455312834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:36:44 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7553120040;
	Wed, 18 Nov 2026 07:36:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 062F120049;
	Wed, 18 Nov 2026 07:36:39 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:36:38 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 11/22] nvmet: add context annotation for nvmet_ns::buffered_io
Date: Wed, 18 Nov 2026 13:04:52 +0530
Message-ID: <20261118073505.288910-12-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: AuzaCtNv2UPkEpnzII4KIoFNv3D7Xlf1
X-Proofpoint-GUID: Wt1tEqXkf_xPr4W3vXjn0AWb1mFHmToc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfXx83Q7GLQymcW
 ptpFgrVktgQuJ/iqH3kClkS0XwQzHSbZyFN0W6pyRqSOo5rHFGgkpBcyGXq192JBLWLAna3rbo/
 8rIfv1un53ri2HHnBCkXdQQqc6P9ZrqIEIpbm6kyd7Vf/cFdoe1ketGXgB6XAOlMC0AZdv7FuEK
 FESKvvx2R1KxuWlsvHIb8AiFcQlEAZIqO2MPhuPdr56YDqztWMSWEZYf5AbTdam2TRjnA4neabm
 ixXERdoYDH0E8m4lLKch5JC+EsxNaHF3b9JQIuwRVhhOw3e5pkGEcO8liMi+JfLsQ7I3Q9vaXiZ
 4JlqTffg+Fske2OIO+DebSOBINmajwHfT/269jspW+tDRv2bzS6B/ZaRJemdqtz3K7JXuT646Vk
 KrURktK7Va10WCYHyL3faHR8y6TP+yJGwpWJLKQlJtXKGSwpM88bLcgADwY4Eb/VNSIwI66N5ml
 dkL6H8xI+LsKjIbCy+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX7yHMNmNiV+rI
 moQxKY/JwOfmf8r5C1n/npdClDoRHlvHhsrA++ielR0nd2zXrd6Mg2qmF/8h+7GJen+O5KcwXeO
 eqUcB/4gN6WH5UZ2Hq/0JLfm6FSij0A=
X-Authority-Analysis: v=2.4 cv=K+m3jCWI c=1 sm=1 tr=0 ts=6afd5591 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=wyQYIfH3qne7WvDzmQEA:9
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
X-CRM114-CacheID: sfid-20261117_233706_223539_B9C4B5CD 
X-CRM114-Status: GOOD (  15.61  )
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

The nvmet_ns::buffered_io field is protected by nvmet_subsys::lock.
Annotate it with __guarded_by(&subsys->lock) so that the clang context
analyzer can validate accesses to this field.

Some accesses to nvmet_ns::buffered_io in the I/O hotpath do not require
holding nvmet_subsys::lock, as the namespace reference guarantees that
the namespace remains valid and the field is not modified while I/O is
in flight. However, the clang context analyzer cannot express this
access pattern directly.

Introduce nvmet_ns_buffered_io() as an inline helper annotated with
__context_unsafe() to allow these accesses without requiring the
subsystem lock. Convert the relevant accesses in the I/O hotpath and
request-processing paths to use this helper.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/io-cmd-file.c | 2 +-
 drivers/nvme/target/nvmet.h       | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index c87de131037d..31538c8cc759 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -257,7 +257,7 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 	} else
 		req->f.mpool_alloc = false;
 
-	if (req->ns->buffered_io) {
+	if (nvmet_ns_buffered_io(req->ns)) {
 		if (likely(!req->f.mpool_alloc) &&
 		    (nvmet_ns_file(req->ns)->f_mode & FMODE_NOWAIT) &&
 		    nvmet_file_execute_io(req, IOCB_NOWAIT))
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 01132beb5904..5e9bfec2d384 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -168,7 +168,8 @@ struct nvmet_ns {
 		__guarded_by(&subsys->lock);
 	u32			anagrpid;
 
-	bool			buffered_io;
+	bool			buffered_io
+		__guarded_by(&subsys->lock);
 	bool			enabled;
 #define NVMET_NS_IO_LIVE	0
 	unsigned long		flags;
@@ -212,6 +213,7 @@ NVMET_NS_ACCESSOR(struct file *, file)
 NVMET_NS_ACCESSOR(u32, blksize_shift)
 NVMET_NS_ACCESSOR(u8 *, nguid)
 NVMET_NS_ACCESSOR(uuid_t, uuid)
+NVMET_NS_ACCESSOR(bool, buffered_io)
 
 /*
  * These accessors use data_race() and READ_ONCE() marker to allow lockless
-- 
2.53.0


