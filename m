Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E6EC02193
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 19:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=raajg5avx+fq9AX5OMM0mwkW4PDBCkUTI/pbYReQ04s=; b=04dhDNpf+GMyKOHUrMldgWe9xa
	gmv2E/8tXU+CtdMrBPF8glZg6fZEfro92ek+EwRQ8vDZAT+IegyUCfbT4Kf505hgvr2Z8PbtyeRVs
	J9A+oF38Uvsg6bBwHWEHqrX0X0LhrkYheLGEEd+Dudgd31vY3asjjvW6eHxdYZqDfhB0rr5sYH+tj
	txKSDvT0n6K5xhBqgz/0khXLT+ZY5wZ8Y5YrjCrJOOmUID+AGG2qkrXik8cbjm5gYbxXMoTgFIAw7
	CpBDfvkFLFOtDNrq3Uawi4Bqjrro4fNRNo9+XddWkjuNq3xZhwvjkuUdQMgMaqRo8Drntc10fJWh0
	r594KU6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1it-0000000GOLN-3P74;
	Mon, 03 Feb 2025 19:03:07 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tf1ZW-0000000GLCN-1zef
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 18:53:28 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513IpBCH028010
	for <linux-nvme@lists.infradead.org>; Mon, 3 Feb 2025 10:53:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=raajg5avx+fq9AX5OMM0mwkW4PDBCkUTI/pbYReQ04s=; b=TP/yXlkXOHst
	DYoFp6tJvlECP05vSj6LWmM3PboiyEXU2MFcJZJh/iiGpxa+4+qpeJd5fSD/BCAk
	2M+eAXXzlZBbgLqf2RtsysQj7JTB1hPVfIroePfXuy8uLwe9IMV/6bOOyqKhYAIN
	xEuSTkPVSkcmKGD9xfyiUcfWGJZYVHDHO7NK4nOnU8KFBaYRV3ohLHliG5/0fhD2
	Q1znhZHzkYPxhW+wrxJKprAWCxH0dYPntm0SFeJBbhy4Yi7OWkIucbbLr0QFxpzH
	9qwyUmEWhlke58h++NTIN/+hs8LJ3wFo7tVJDMrahLoM5cfagNS1OxmAKOD/FFzK
	2WT/2T7iWQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 44k3epr0h5-19
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 03 Feb 2025 10:53:26 -0800 (PST)
Received: from twshared3815.08.ash9.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 3 Feb 2025 18:52:50 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 08C5A179C263B; Mon,  3 Feb 2025 10:41:34 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <io-uring@vger.kernel.org>,
        <linux-block@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <asml.silence@gmail.com>,
        <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>,
        Keith Busch
	<kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Nitesh Shetty
	<nj.shetty@samsung.com>
Subject: [PATCHv2 11/11] nvme: use fdp streams if write stream is provided
Date: Mon, 3 Feb 2025 10:41:29 -0800
Message-ID: <20250203184129.1829324-12-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250203184129.1829324-1-kbusch@meta.com>
References: <20250203184129.1829324-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: DkAmsjV5Zy36nf3MB89y_OEhLLM_FPL7
X-Proofpoint-GUID: DkAmsjV5Zy36nf3MB89y_OEhLLM_FPL7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_08,2025-01-31_02,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_105326_521639_5A00C72C 
X-CRM114-Status: GOOD (  15.36  )
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
index c8bc58b8ee3aa..d14c23916671d 100644
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
@@ -2241,7 +2254,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, =
struct nvme_ns_info *info)
 	struct nvme_fdp_config fdp;
 	struct nvme_command c =3D {};
 	size_t size;
-	int ret;
+	int i, ret;
=20
 	/*
 	 * The FDP configuration is static for the lifetime of the namespace,
@@ -2281,6 +2294,22 @@ static int nvme_query_fdp_info(struct nvme_ns *ns,=
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
index b63164cf6b274..59ba31c48cf66 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -498,6 +498,7 @@ struct nvme_ns_head {
 	struct gendisk		*disk;
=20
 	u16			nr_plids;
+	u16			*plids;
 #ifdef CONFIG_NVME_MULTIPATH
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
--=20
2.43.5


