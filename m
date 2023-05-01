Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1E3EC77B61
	for <linux-nvme@archiver.kernel.org>; Mon,  1 May 2023 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R3QDeXh55fnTIvcRbRzVRlMMfaK54UFaOPj/dGklld8=; b=BvBEizlJY8CVFbFomX7iC06r+s
	VkW+W+V4spbiPCoFYoGdp2K+ZGFGks6aFgOuWk7upkzZzLGM7EIOHDYNljOT8TDnRyLfArfOdcQzL
	y05QjgjaheaTg/m5bk0ju0fQX2hL1cnCcYbJjTlRPHgafViwNb9NFS4N2u80doEu6ipq5GhM0W5hZ
	U/R0+Slv3Q5OyClz4enxOqRqiIUTI6NbU0hyMkjMqVccvoe0vBX1pvhtygAnlScZfJM1NbmoheRcV
	I14oiP0HJ4HAUX5PudIGtfgK8fuAO4JE+5acKuQTti5cYzVP6iL3Pb3VUjiZywJtlBVV/d+5mAYU5
	I4clwSAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptVWt-00GEWR-1K;
	Mon, 01 May 2023 15:33:31 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptVWp-00GEU4-0B
	for linux-nvme@lists.infradead.org;
	Mon, 01 May 2023 15:33:30 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34146rYZ005073
	for <linux-nvme@lists.infradead.org>; Mon, 1 May 2023 08:33:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=R3QDeXh55fnTIvcRbRzVRlMMfaK54UFaOPj/dGklld8=;
 b=Pyvw3ykE1yQFrizdi+qBwCoEir6xYr6NZHHxw5mWMku27gZzjfHb6ZCIoXkHig41y8fI
 iEWivfI1oCWTaYnzoln79y6Gt2GtiNQPGJKRVgghJd9p7LFIMWJhpSkR9eXKIAxoERS9
 hNISlkgXu0W6+Yl6qp2jl15bYmA9ncrgKkj9LdFCvHrDWObMlg+vrgLbQzsW4aXnDYE/
 CSUiivRUkU8hnOYx3dlnZKtGKpgfygoUtVDXUkf/eAgOqowfKpptVlK1n6LQPapmfNRl
 xIpQEcpW/jtVd/NjNVXD4vYo53cTK5tsKd/cMarUm4ESa9xMPJFrgdx5yNBllBM9Poks +g== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q923huhsj-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 01 May 2023 08:33:26 -0700
Received: from twshared31955.05.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 1 May 2023 08:33:24 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 900FC1777ADC0; Mon,  1 May 2023 08:33:07 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <joshi.k@samsung.com>, <axboe@kernel.dk>, <hch@lst.de>,
        <xiaoguang.wang@linux.alibaba.com>
CC: Keith Busch <kbusch@kernel.org>
Subject: [RFC 2/3] nvme: fix cdev name leak
Date: Mon, 1 May 2023 08:33:05 -0700
Message-ID: <20230501153306.537124-3-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230501153306.537124-1-kbusch@meta.com>
References: <20230501153306.537124-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 1Hmysp_J_990Th4ghJMCwvE1nwv-OT99
X-Proofpoint-ORIG-GUID: 1Hmysp_J_990Th4ghJMCwvE1nwv-OT99
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-01_08,2023-04-27_01,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_083327_208658_E6B095E5 
X-CRM114-Status: GOOD (  16.67  )
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

If we fail to add the device, free the name allocated for it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1bfd52eae2eeb..0f1cb6f418182 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4079,8 +4079,16 @@ static int nvme_add_ns_cdev(struct nvme_ns *ns)
 	if (ret)
 		return ret;
=20
-	return nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
+	ret =3D nvme_cdev_add(&ns->cdev, &ns->cdev_device, &nvme_ns_chr_fops,
 			     ns->ctrl->ops->module);
+	if (ret)
+		goto out_free_name;
+
+	return 0;
+
+out_free_name:
+	kfree_const(ns->cdev_device.kobj.name);
+	return ret;
 }
=20
 static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
--=20
2.34.1


