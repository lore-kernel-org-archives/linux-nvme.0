Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA57D10F5B
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3sSpygihFESqWcD4iszc/pgNwUF60xxW9TKd506OJX4=; b=bwMtO2YtraLP7bSOYkV3PLckAw
	hJ0/q/wmVKHLvwsqIz2WAxFlDaFhgMW88f4NNr6ZCXYDID+AJFT2Q1feXEdxvw1Xd9P3Il83RvDbI
	CFkqpR0mnL94Sa3d67B03QaUGixLFCjp9ZKYUum6DGqmqG/8T27WtoecyYa7zrxPZLdLvBcJOoUeg
	WSopeMlxL9P+VSlivIBm51HX/U2SQAfmtxui9d2lMdUBtc4SPxYDNakCu4TSbD2oBPaBTgEU1v0bh
	F2R7d/aUNI+vBFNy4vGS7Oy8DXp6LTGW0M0/866z8IK947kdxWpKPZgD9SKzu2A2I2/88l6Bte+uS
	6GIl8JcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD48e-00000009zMC-0UBv;
	Mon, 18 Nov 2024 15:58:08 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD48J-00000009zI5-03e9
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 15:57:48 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIBFUxk012665
	for <linux-nvme@lists.infradead.org>; Mon, 18 Nov 2024 07:57:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=3sSpygihFESqWcD4iszc/pgNwUF60xxW9TKd506OJX4=; b=KfhNRYAy5ZC8
	zTHWYZJcYR/7a6jbh5glOvFaqzdsR29MU66d3Yh9FfQ6RSjMYQ1B7F+r+kluGOHW
	SqtH0I4oFU+k5MQhIsrcBy9Gl834is1Lqsr2ElKkyUWzWX6PcoEdGPR23G4ye7Y0
	3XJoZGNOmd1amdaSwsQn3tEI+Nq9CZ9wf7oogsk8uhhosvhOrmByQulh8IFIdSyM
	TxTXx0tCpdmsaEh740zmivNejIDPzs+I3QTsPy0nbz+gDvbDV+f+E/KhMHaJ5Vxf
	4DdJckIoVrl6VLDxlfCbNn5IV7a1Kp0fcY78A4ps7CueyHhP8yGfoqAN398FIMFq
	bLjaW8l/HA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4304hx1jy4-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 18 Nov 2024 07:57:46 -0800 (PST)
Received: from twshared29075.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 18 Nov 2024 15:57:42 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 7D19C152D626D; Mon, 18 Nov 2024 07:57:39 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 3/3] nvme-pci: use sgls for all user requests if possible
Date: Mon, 18 Nov 2024 07:57:38 -0800
Message-ID: <20241118155738.2737423-4-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241118155738.2737423-1-kbusch@meta.com>
References: <20241118155738.2737423-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 8utCLtscoLHBRsj92McCzg6jAWSeNkAb
X-Proofpoint-ORIG-GUID: 8utCLtscoLHBRsj92McCzg6jAWSeNkAb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_075747_167406_B5FCF0B5 
X-CRM114-Status: GOOD (  15.51  )
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

If the device supports SGLs, use these for all user requests. This
format encodes the expected transfer length so it can catch short buffer
errors in a user command, whether it occurred accidently or maliciously.

For controllers that support SGL data mode, this is a viable mitigation
to CVE-2023-6238. For controllers that don't support SGL, log a warning
in the passthrough path since not having the capability can corrupt
data if the interface is not use correctly.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 12 ++++++++++--
 drivers/nvme/host/pci.c   |  5 +++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index cb7f61e2077d0..64b5542fb3b79 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -120,12 +120,20 @@ static int nvme_map_user_request(struct request *re=
q, u64 ubuffer,
 	struct nvme_ns *ns =3D q->queuedata;
 	struct block_device *bdev =3D ns ? ns->disk->part0 : NULL;
 	bool supports_metadata =3D bdev && blk_get_integrity(bdev->bd_disk);
+	struct nvme_ctrl *ctrl =3D nvme_req(req)->ctrl;
 	bool has_metadata =3D meta_buffer && meta_len;
 	struct bio *bio =3D NULL;
 	int ret;
=20
-	if (has_metadata && !supports_metadata)
-		return -EINVAL;
+	if (!nvme_ctrl_sgl_supported(ctrl))
+		dev_warn_once(ctrl->device, "using unchecked data buffer\n");
+	if (has_metadata) {
+		if (!supports_metadata)
+			return -EINVAL;
+		if (!nvme_ctrl_meta_sgl_supported(ctrl))
+			dev_warn_once(ctrl->device,
+				      "using unchecked metadata buffer\n");
+	}
=20
 	if (ioucmd && (ioucmd->flags & IORING_URING_CMD_FIXED)) {
 		struct iov_iter iter;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c6c3ae3a7c434..4c644bb7f0692 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -515,7 +515,8 @@ static inline bool nvme_pci_metadata_use_sgls(struct =
nvme_dev *dev,
 {
 	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl))
 		return false;
-	return req->nr_integrity_segments > 1;
+	return req->nr_integrity_segments > 1 ||
+		nvme_req(req)->flags & NVME_REQ_USERCMD;
 }
=20
 static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct reques=
t *req,
@@ -533,7 +534,7 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev =
*dev, struct request *req,
 	if (nvme_pci_metadata_use_sgls(dev, req))
 		return true;
 	if (!sgl_threshold || avg_seg_size < sgl_threshold)
-		return false;
+		return nvme_req(req)->flags & NVME_REQ_USERCMD;
 	return true;
 }
=20
--=20
2.43.5


