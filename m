Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3B2E7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 19:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hxfNrrkhFfS1JNrhXHFKrcLr3+CDGz37rtaYYuYAXiI=; b=nAmNppTvdWPKIHREWIeW4irBCR
	y6PB2R3SDq0CmoUgyrAgGVBhwfckZzG1wJ//uhGJ6Fh1A3PKvF4JM6QTTGmJujTfUDZt2nfeSc4O0
	7tpOUehsH3O3FCQaNup0a6gLmVj6D14EktmSm6DQgpNiomXi3HBMl/N4knG3mX6oyZUCM2Q/Y4KtR
	wTZuaXxVRHlGRvxYphnCZ8gbj+1Qx/ZhUdWaBg/bO3qY0AQ0O/31I+SoqZPKEH5rjsJE4d6N6W61X
	X7ceT4v25ZjShakIcbrY2bXV7QgdziOHPxIATfNZuXOfYUUvSItMHju7NmH/3VdXtg9VYWPcTIOyo
	vXqRQ3kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLS9W-0000000Fsl1-0UXV;
	Wed, 11 Dec 2024 19:13:42 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLS9T-0000000Fsjp-2IHa
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 19:13:41 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BBI3ng2028746
	for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2024 11:13:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=hxfNrrkhFfS1JNrhXHFKrcLr3+CDGz37rtaYYuYAXiI=; b=J/vToKTko9o0
	otrgChbvtpXmoyKEjNEYBJ0IysZZcjnAnvwC+OKzQNXrSnRkmZ1wADEQm2fySnAd
	vNJB2nAP+o7qfOK/emXVOyf4GoYzye2BbV0FgwD1H6YUQy9YN8UC6K07EpSofN+v
	hxacH1KGSviBFeN+tmZzWi0p/bLn3WZTCK4Lky3LmLNhcbwOyHN99z04wOOxCTvF
	7mjVaDt0Z5vEPBBGIH3PVw/07o+xj/sQyOvyXBapTXeXrnw1ahZK7+d5iBo0g7/U
	Xy2GeZdhVQnxFx29GnUzT4TvTqc+R84L1Usveehwgf6ETLKY0P+khKJ1LH5TJhlv
	8jNLyZcfiA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 43ffp9ggh5-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 11 Dec 2024 11:13:39 -0800 (PST)
Received: from twshared55211.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Wed, 11 Dec 2024 19:13:36 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id BB0F015DE3969; Wed, 11 Dec 2024 10:35:16 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <axboe@kernel.dk>, <hch@lst.de>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>
CC: <sagi@grimberg.me>, <asml.silence@gmail.com>, <anuj20.g@samsung.com>,
        <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>,
        Hannes Reinecke
	<hare@suse.de>, Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCHv14 11/11] nvme: use fdp streams if write stream is provided
Date: Wed, 11 Dec 2024 10:35:14 -0800
Message-ID: <20241211183514.64070-12-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241211183514.64070-1-kbusch@meta.com>
References: <20241211183514.64070-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: FB_9pN5bcm6dE41iDE9WGEBgpIOiSVwq
X-Proofpoint-ORIG-GUID: FB_9pN5bcm6dE41iDE9WGEBgpIOiSVwq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_111339_588836_B8F8D0DC 
X-CRM114-Status: GOOD (  15.27  )
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
index 2392373415fd6..b12d904dbc495 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -675,6 +675,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	ida_free(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
+	kfree(head->plids);
 	kfree(head);
 }
=20
@@ -998,6 +999,18 @@ static inline blk_status_t nvme_setup_rw(struct nvme=
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
@@ -2233,7 +2246,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, =
struct nvme_ns_info *info)
 	struct nvme_fdp_config fdp;
 	struct nvme_command c =3D {};
 	size_t size;
-	int ret;
+	int i, ret;
=20
 	/*
 	 * The FDP configuration is static for the lifetime of the namespace,
@@ -2273,6 +2286,22 @@ static int nvme_query_fdp_info(struct nvme_ns *ns,=
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


