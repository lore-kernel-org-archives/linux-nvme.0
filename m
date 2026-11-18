Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D446F606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Nov 2026 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mYfg5zpf;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=P4aRHgvV;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=MNaiYVwg
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=I60dOcIDTiMPvu0jrRwytd7Rzhyog7guvCefEjpvxPA=; b=mYfg5zpffrgkCJ
	m2KAO32bx2lIcdjxaVpanNhOAMCt2jZTOj5MGdypZzLgy8PMfdOaCw3NGmN3ioBtmgI+OldADQO9N
	SNfkzJ2sXYZ62tWtXvphs/gQdr9/sjr4QxYv/5XUn4veiJu2kgtyt++bbZOLHUIvdobJf4MzUfARl
	zpZKjYa3G8J9RMl/GWANA8jt/rez+5Hz0jy78aejva2WBsgUnfTsJYpBCWFNmzmB6khcPZnWx06uW
	O35CnrfmZALuN5OcGgCFute+dC9bqC8Qbdh0vHFhX+C+eqsyvuMkpa3BtwPMTWYNaEdXzvsgDzTng
	Z0NEPwYSYvFU9bHUP3sQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEb-000000081mR-1Ypw;
	Wed, 18 Nov 2026 07:37:37 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEY-000000081iH-2vbf
	for linux-nvme@bombadil.infradead.org;
	Wed, 18 Nov 2026 07:37:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=I60dOcIDTiMPvu0jrRwytd7Rzhyog7guvCefEjpvxPA=; b=P4aRHgvVWk15GxX5Xphu8uYxfm
	tUZq3O7p+nmsManXh47g9GLJEQrXxXsBn+iMl2ZEU/vWLkX4LCt7Go1y/R6WO78xlG5cczdmGPl5N
	3en729xXLrz4uyKCV/XUtSYYcb0H0x2NMIL8AOpg3L6XpHg+9GpoqdMvGdusu9O/852VB3DG0JtzK
	n4PHtQTnTLc8BFbuFhecHvsvI3UEhA2HtQuwzaiQFRkuApDTZbQiFt9PwM9c3gbbs/F/C48kSpV4d
	F8C3bFkUI77ouc2tUacUOFAbnHlT+S7GQHzem48MksGJQUQQ48DF9QVHa6pTbay1cumDVhgYuIFsQ
	P6Y4Ikew==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTaEM-0000000FkFP-0M3V
	for linux-nvme@lists.infradead.org;
	Wed, 18 Nov 2026 07:37:31 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI2S0Wh031179;
	Wed, 18 Nov 2026 07:37:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=I60dOcIDTiMPvu0jr
	Rwytd7Rzhyog7guvCefEjpvxPA=; b=MNaiYVwg+nrHXeMdtfj3TC5PkXBb4slcg
	ePDbKjmK6zFYBkisMJvx4dG0AWjPDejI014TB3pSi7zu9OkuET1kOrLJYWE30uWS
	OU8qiN4pvBGX85oWETbPCFKpdz/fD7e+EYVKlgXqEMDzNQfdfK2SiaSRhPsFB9cu
	Mf8GPqwVe49sNAmQzPR/q5p7eYmt2jnsj5qWc/8U/LzBAHh6MlWEvlwQMzzhL4Aj
	MRczMN8JUol8ax+TRK9Xg6A3b9T+gMZ+68btM7OP8VO+ela7d1ajCHYDSmazCYm8
	AKL2ETd1DSsE9m9xvrzB8Upgps4Zln98xev6d0yjilapAnjebqESg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105n9cxy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:10 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AI78F831660787;
	Wed, 18 Nov 2026 07:37:10 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j17c4r2bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 18 Nov 2026 07:37:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AI7b61t14352734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Nov 2026 07:37:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 384852004D;
	Wed, 18 Nov 2026 07:37:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C971D20040;
	Wed, 18 Nov 2026 07:37:00 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.157.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 18 Nov 2026 07:37:00 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, bvanassche@acm.org, sagi@grimberg.me,
        axboe@kernel.dk, chaitanyak@nvidia.com
Cc: gjoyce@linux.ibm.com, elver@google.com, linux-nvme@lists.infradead.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 15/22] nvmet: add context annotation for nvmet_ns::device_path
Date: Wed, 18 Nov 2026 13:04:56 +0530
Message-ID: <20261118073505.288910-16-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261118073505.288910-1-nilay@linux.ibm.com>
References: <20261118073505.288910-1-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfXyEvnu/HHwq6N
 qQ5P1nlTZu9rcRwlN9Ctu8OTY21bEZyS1R/D+M2cyvrmGBJXUACMef5xniHzxbEtJk30j+RdsDW
 rLEZxnVqcf0Ob4QylHxI0cj8R2oiba6rJDoXd70cT7eNiE8rOKTFww3eq1Zv5Qgf8edqWA3G4EA
 SOJA5xXlq8kvlr3jTPu/DxDjkAMGF3MYcL6+Dp3QQwiSojPKK+E3XDROxPpbKXs3p8FuULZPqmO
 zmMy2b+FNN/hYyLJJXlbvY0NACF3LaLh++T8yac+ZjvOwj8F01SKmiK2OvWexXy1j+T583lo/pa
 y0Hv5itLFCjjJ+JZvwGJL4l9kN5XjRTl+iOSE0J1SHBGrF4lZqOKj+HLcMWVkr5AqHTPoFuN6qS
 8j16Ir6WMELzNUKLFBL5rtnGF62yBCWRMcW1GhsIMN1tmvzrG7D2AWjuTqNVGxpGNr67MwRZMSw
 Yga//TQAkgz5yM4RD9w==
X-Authority-Analysis: v=2.4 cv=HN9WhYtv c=1 sm=1 tr=0 ts=6afd55a7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=1pHAsNxKj0yKW5Bc50kA:9
X-Proofpoint-GUID: u727PSoG5hQ9pawEKEx467K8TRua2LFe
X-Proofpoint-ORIG-GUID: ExGRoXhki2bKshDMRQkQzXJ6ZUk6Ciwu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDAyOSBTYWx0ZWRfX2VIk1uPLI2F+
 qb9tdCsS2INiX0qp7y3SUoFZqdDy42P6x9suC1egLNlDaY37raEYhzoeeiqF6LzNVj7A14B7iHK
 4XoOyTCms3dvL/uzIfQmKihtra4k6zc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_01,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180029
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261118_073724_277425_F1AFC9B5 
X-CRM114-Status: GOOD (  16.62  )
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

The nvmet_ns::device_path field is protected by
nvmet_subsys::lock. Annotate it with
__guarded_by(&subsys->lock) to allow the Clang context
analyzer to validate accesses to this field.

Some request-processing paths access ns->device_path without
holding subsys->lock. This is safe because the namespace
reference held by the request prevents the ns->device_path from
being modified while I/O is in flight. However, the context
analyzer cannot express this access pattern directly.

Introduce nvmet_ns_device_path() as an inline helper
annotated with __context_unsafe() to allow these lockless
accesses without triggering context analyzer warnings.

Additionally, update __assign_req_name() to use this accessor
when copying device_path into the trace event's request name.
This is safe because the tracing function is invoked after
the namespace reference has been acquired.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/nvmet.h | 4 +++-
 drivers/nvme/target/trace.h | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6a1c27cc08e5..db5d5a3fec3d 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -175,7 +175,8 @@ struct nvmet_ns {
 #define NVMET_NS_IO_LIVE	0
 	unsigned long		flags;
 	struct nvmet_subsys	*subsys;
-	const char		*device_path;
+	const char		*device_path
+		__guarded_by(&subsys->lock);
 
 	struct config_group	device_group;
 	struct config_group	group;
@@ -215,6 +216,7 @@ NVMET_NS_ACCESSOR(u32, blksize_shift)
 NVMET_NS_ACCESSOR(u8 *, nguid)
 NVMET_NS_ACCESSOR(uuid_t, uuid)
 NVMET_NS_ACCESSOR(bool, buffered_io)
+NVMET_NS_ACCESSOR(const char *, device_path)
 
 /*
  * These accessors use data_race() and READ_ONCE() marker to allow lockless
diff --git a/drivers/nvme/target/trace.h b/drivers/nvme/target/trace.h
index 7f7ebf9558e5..b15294e24793 100644
--- a/drivers/nvme/target/trace.h
+++ b/drivers/nvme/target/trace.h
@@ -59,7 +59,7 @@ static inline void __assign_req_name(char *name, struct nvmet_req *req)
 		return;
 	}
 
-	strscpy_pad(name, req->ns->device_path, DISK_NAME_LEN);
+	strscpy_pad(name, nvmet_ns_device_path(req->ns), DISK_NAME_LEN);
 }
 #endif
 
-- 
2.53.0


