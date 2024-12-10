Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 543A8E7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Dec 2024 20:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aqQPXqCRJYOiSMBd1t9cIzY+ID7bTaewWCa9SR2NLEI=; b=zfUO0ntaGn+TY4Ywq5iPk57hY9
	ahQx8stId3QLEDLIB9eeImXLPX4rSA19/wGccOi/ajlBb0xiZcIWSu1xpqqiXyZukf7jXFCoqSVwb
	lHjw/84e2MRIZiok2XFQAsLOE8DEaAxm7WcLBed+wn592JiyOvTP+Rlxs52KCaME9T4fxu5FZgwxm
	CaxV4HERPVF+PmbrVioHL45Pk8gFn63tG6//PEtgR61N1g59y0WdmVfYnYNfLvlOR0yhJCVeDSCrz
	HOP7tQO0iCOkpQ38JGhMUm6xWrz6WfnqsFjJGe+qlxFvVedKkxk/TqoBw5hOm3Rmon3ZEg4r9bo0C
	UOoOJKCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tL6tP-0000000CgIo-27Sg;
	Tue, 10 Dec 2024 20:31:39 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tL6tM-0000000CgIF-2eUw
	for linux-nvme@lists.infradead.org;
	Tue, 10 Dec 2024 20:31:37 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 4BAIaowN029059
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 12:31:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=aqQPXqCRJYOiSMBd1t9cIzY+ID7bTaewWCa9SR2NLEI=; b=ThWMu5OFGWtP
	U7/13ssMjtGG4fV4i/+H0my6qtVLIehmqq1K83dt4TcVG3CdRjb01OvfTOKvHN1z
	qsrpJR9JbbnkblA2EjwQNIkgqWH9bovFlMM4C40X9CCdWwRJTIIRMppmvW8yWypb
	TFg2H7Gfcwe4COpqrRqpFVgrv6iHSA5kzpiLYlKDA0A8VVHlwT/HJuIaFLRxWtfm
	3DNPdxjJDgMkBDTmOhlnlOJ0FZ8DAmRHjoLd1kxHZj76jg+FeJWnmRJscRKaJEyj
	diF0P+r8EHzn6UD1nfxV+lThHKB7ALfwMI7MQ/kCp6Opr05Hk5gT8+nqGh54mmGk
	cPLDN0pq7A==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 43eu2y0vdg-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 10 Dec 2024 12:31:35 -0800 (PST)
Received: from twshared9216.15.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 10 Dec 2024 20:31:33 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id DF2B215D5C7D6; Tue, 10 Dec 2024 11:48:08 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCHv13 11/11] nvme: use fdp streams if write stream is provided
Date: Tue, 10 Dec 2024 11:47:22 -0800
Message-ID: <20241210194722.1905732-12-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241210194722.1905732-1-kbusch@meta.com>
References: <20241210194722.1905732-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: sPHtDm3YKNQb8CORsLp0LH6ZwDq_iU4w
X-Proofpoint-ORIG-GUID: sPHtDm3YKNQb8CORsLp0LH6ZwDq_iU4w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241210_123136_789087_8635E27B 
X-CRM114-Status: GOOD (  14.95  )
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

Maps a user requested write stream to an FDP placement ID if possible.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 31 ++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f7aeda601fcd6..102546d3dcd4a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -674,6 +674,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	ida_free(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
+	kfree(head->plids);
 	kfree(head);
 }
=20
@@ -997,6 +998,18 @@ static inline blk_status_t nvme_setup_rw(struct nvme=
_ns *ns,
 	if (req->cmd_flags & REQ_RAHEAD)
 		dsmgmt |=3D NVME_RW_DSM_FREQ_PREFETCH;
=20
+	if (op =3D=3D nvme_cmd_write && ns->head->nr_plids) {
+		u16 write_stream =3D req->bio->bi_write_stream;
+
+		if (WARN_ON_ONCE(write_stream > ns->head->nr_plids))
+			return BLK_STS_INVAL;
+
+		if (write_stream) {
+			dsmgmt |=3D ns->head->plids[write_stream - 1] << 16;
+			control |=3D NVME_RW_DTYPE_DPLCMT;
+		}
+	}
+
 	if (req->cmd_flags & REQ_ATOMIC && !nvme_valid_atomic_write(req))
 		return BLK_STS_INVAL;
=20
@@ -2223,7 +2236,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, =
struct nvme_ns_info *info)
 	struct nvme_fdp_config fdp;
 	struct nvme_command c =3D {};
 	size_t size;
-	int ret;
+	int i, ret;
=20
 	/*
 	 * The FDP configuration is static for the lifetime of the namespace,
@@ -2267,6 +2280,22 @@ static int nvme_query_fdp_info(struct nvme_ns *ns,=
 struct nvme_ns_info *info)
 	}
=20
 	head->nr_plids =3D le16_to_cpu(ruhs->nruhsd);
+	if (!head->nr_plids)
+		goto free;
+
+	head->plids =3D kcalloc(head->nr_plids, sizeof(head->plids),
+			      GFP_KERNEL);
+	if (!head->plids) {
+		dev_warn(ctrl->device,
+			 "failed to allocate %u FDP placement IDs\n",
+			 head->nr_plids);
+		head->nr_plids =3D 0;
+		ret =3D -ENOMEM;
+		goto free;
+	}
+
+	for (i =3D 0; i < head->nr_plids; i++)
+		head->plids[i] =3D le16_to_cpu(ruhs->ruhsd[i].pid);
 free:
 	kfree(ruhs);
 	return ret;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4b412cd8001f1..50e7628296d1f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -493,6 +493,7 @@ struct nvme_ns_head {
 	struct gendisk		*disk;
=20
 	u16			nr_plids;
+	u16			*plids;
 #ifdef CONFIG_NVME_MULTIPATH
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
--=20
2.43.5


