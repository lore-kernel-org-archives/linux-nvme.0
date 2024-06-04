Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BCBC27C53
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 18:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p2Hg1gJ0YzOw+AbxzdVsn7s6/XfAGdkORtjhhoew0JQ=; b=HHEyF4E4oejgEGpyq+sgCVH4Oj
	D9jbP6QfpJOG4io+G6KA7G737t6V9eFBfAOOaHgX2XrzBHSaZVx72tCow0rA0HHoekCro0UrlAA5J
	RGqxs0kgTF/J11AxTXjmY329XG8O8XtG4H9VEATJLCkWO6Q/BMwSiuCkhkIH97su5YBRryORVCvZ4
	YuiwZ51y3ZfQW44XNgQQ0X6XhyBYii+iyIX/e4vZuEHR9ij7WfL5gF0vRT1gcm8zL0XOZB9PPkwxL
	G4czMl3dVorQt/ewGTu6TU+nsbF0W8hqgKoBd9B3/pEJZKVbGYDACQH7tiPi4Mpo8e6LvkPffAe9W
	DcLDuwYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEZNl-00000003W21-2BTv;
	Tue, 04 Jun 2024 18:59:41 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEZNi-00000003Vzq-1jXM
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 18:59:40 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Hmgld006342
	for <linux-nvme@lists.infradead.org>; Tue, 4 Jun 2024 11:59:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=s2048-2021-q4;
 bh=p2Hg1gJ0YzOw+AbxzdVsn7s6/XfAGdkORtjhhoew0JQ=;
 b=A3AhfsR4IkEnCZsBsYt7arZAvO9hvLjs0jBCpKNmugGoVpP/XagVIQOavIBRJFqA0SNr
 H3K4jHedGlUBPhr8es2ehb2IFtmpJsqD+n1y+Apy9qxJk4iM87qW00zUn7OyUkBdv24N
 kBcdEJp6rtnArKuUgnpHF+WHNcHv+9h0polPiPnMl7DRAeuvToL2+z8KOXFPO9xZs6JQ
 /2iQzwhvszkae0CM3Ak8hmdTjIIibC8OJB3us0qJ7XSS+5VLqWwTfD4wxNxe8+yNT/w8
 lAZewzPibAcGPDZ3QPS9PRTwo/iJvpyQqILEfIgq29fzmvwZoK2xUvI/DN4JT7nRZucv +Q== 
Received: from mail.thefacebook.com ([163.114.134.6])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yhqbxpg8m-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 04 Jun 2024 11:59:36 -0700
Received: from twshared53332.38.frc1.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 4 Jun 2024 18:59:33 +0000
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id 4EA1D35076D1; Tue,  4 Jun 2024 11:59:26 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <mlombard@redhat.com>, <hare@suse.de>,
        <shinichiro.kawasaki@wdc.com>, <james.smart@broadcom.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 3/5] nvme: rdma: split controller bringup handling
Date: Tue, 4 Jun 2024 11:59:06 -0700
Message-ID: <20240604185908.3703052-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240604185908.3703052-1-kbusch@meta.com>
References: <20240604185908.3703052-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: pO6oAvw3B17kGctoxbqK8PpxhLAVcZfO
X-Proofpoint-ORIG-GUID: pO6oAvw3B17kGctoxbqK8PpxhLAVcZfO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_115938_773350_1F8DEAD3 
X-CRM114-Status: GOOD (  14.80  )
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

Drivers must call nvme_uninit_ctrl after a successful nvme_init_ctrl.
Split the allocation side out to make the error handling boundary easier
to navigate. The nvme rdma driver's error handling had different returns
in the error goto label's, which harm readability.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/rdma.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 51a62b0c645a7..94d4f3dbac6b6 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2237,12 +2237,11 @@ nvme_rdma_existing_controller(struct nvmf_ctrl_op=
tions *opts)
 	return found;
 }
=20
-static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
+static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
 	struct nvme_rdma_ctrl *ctrl;
 	int ret;
-	bool changed;
=20
 	ctrl =3D kzalloc(sizeof(*ctrl), GFP_KERNEL);
 	if (!ctrl)
@@ -2304,6 +2303,26 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(str=
uct device *dev,
 	if (ret)
 		goto out_kfree_queues;
=20
+	return ctrl;
+
+out_kfree_queues:
+	kfree(ctrl->queues);
+out_free_ctrl:
+	kfree(ctrl);
+	return ERR_PTR(ret);
+}
+
+static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
+		struct nvmf_ctrl_options *opts)
+{
+	struct nvme_rdma_ctrl *ctrl;
+	bool changed;
+	int ret;
+
+	ctrl =3D nvme_rdma_alloc_ctrl(dev, opts);
+	if (IS_ERR(ctrl))
+		return ERR_CAST(ctrl);
+
 	changed =3D nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
 	WARN_ON_ONCE(!changed);
=20
@@ -2326,11 +2345,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(str=
uct device *dev,
 	if (ret > 0)
 		ret =3D -EIO;
 	return ERR_PTR(ret);
-out_kfree_queues:
-	kfree(ctrl->queues);
-out_free_ctrl:
-	kfree(ctrl);
-	return ERR_PTR(ret);
 }
=20
 static struct nvmf_transport_ops nvme_rdma_transport =3D {
--=20
2.43.0


