Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AD4CD4857
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2024 15:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nYakPJ9rnveCc/VvRR9I1ztb2OG9ggJMLK0vhtAOxDs=; b=kP9lGOx6SmK7k2oRlgrZXvIYEm
	J3A08X7opEyAtJdq0Uk+/kQLc13wcjjTj4fesV2wLhbd/zOowcWayjSaaleAljPBm3hCID4mMFN/Y
	mIay+Lc533Cf48IwsHQ+AW5aJcPeccEmuurlzdtEdfEq3YgUEgvg9zmnypfk0x0+76pHdEq05heIS
	xhutrd/alNTPtCL98p+LiaveVFzWqmwarjDDo3UD12gILHCiklhwQzZOYtou/fXZW16njDvFj6Rvy
	PWAMBJFN1/gtkgDkLkRL/phunz5b8do2KUOyCr3aL5LsNesXnx1DkdycdzYuKpjgioCeUUR4oAlxv
	YaG0Vf3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slruK-00000004zdx-0xrV;
	Wed, 04 Sep 2024 15:26:56 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1slruG-00000004zaY-41xu
	for linux-nvme@lists.infradead.org;
	Wed, 04 Sep 2024 15:26:54 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4845F7Wm022818
	for <linux-nvme@lists.infradead.org>; Wed, 4 Sep 2024 08:26:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	s2048-2021-q4; bh=nYakPJ9rnveCc/VvRR9I1ztb2OG9ggJMLK0vhtAOxDs=; b=
	F8RfilbVxSMoFlVK8z/wsOmEiHTmIjzfYzFKHUGW8uOTfYDkPhl/6EjFBqTC2hgB
	5Es2V3DiEGOIDjVa8DjWzUofi+I0OFyTqQCt0FGOwD7wiy0HJaCUDPwLln1iTlXy
	O5Q6s97aWzHjfVYr/B6+9VXxlgHmHQ+avoT9LfP77j5CMVWl68o2kVzOrsanallK
	OCLkp1/fbEtOvjXzrVEh8myYeT8kXn2ZbtumDNr9TM5eIQY6lIaV8DAa83MgZZRQ
	8u73FAjmRYF3DTiq3VcG7LF4JnIC+grFabeaL9r8orp6KFaMGq/pUxueXkPqucRM
	8TyZ9DWVMI62HhU5m2vVIA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 41eh7v2vxw-18
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 04 Sep 2024 08:26:52 -0700 (PDT)
Received: from twshared34253.17.frc2.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 4 Sep 2024 15:26:12 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id C80ED12A036EB; Wed,  4 Sep 2024 08:26:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <martin.petersen@oracle.com>,
        <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 05/10] block: unexport blk_rq_count_integrity_sg
Date: Wed, 4 Sep 2024 08:26:00 -0700
Message-ID: <20240904152605.4055570-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240904152605.4055570-1-kbusch@meta.com>
References: <20240904152605.4055570-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 1BQjJBn-Y4Yj-ZXUk2CnTYXIGRXJ1QJK
X-Proofpoint-GUID: 1BQjJBn-Y4Yj-ZXUk2CnTYXIGRXJ1QJK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-04_13,2024-09-04_01,2024-09-02_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240904_082653_036235_ACA8407C 
X-CRM114-Status: GOOD (  10.58  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

There are no external users of this.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-integrity.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/blk-integrity.c b/block/blk-integrity.c
index 010decc892eaa..4365960153b91 100644
--- a/block/blk-integrity.c
+++ b/block/blk-integrity.c
@@ -53,7 +53,6 @@ int blk_rq_count_integrity_sg(struct request_queue *q, =
struct bio *bio)
=20
 	return segments;
 }
-EXPORT_SYMBOL(blk_rq_count_integrity_sg);
=20
 /**
  * blk_rq_map_integrity_sg - Map integrity metadata into a scatterlist
--=20
2.43.5


