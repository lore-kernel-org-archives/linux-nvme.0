Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E58CDB465
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Oct 2023 20:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xnVDL8Ylug7++TvbNeswlaasDFrEm33OPoh5lNEGIeg=; b=Jm9fxluvmkTZek3ispXhTPM+N6
	LQJZZ/6U2DaEKaAnncst6JP69kJwuSX4diXHFpE9FkUE8ILCISitwGRxfzySgj7pNMNjME7dA7HKS
	5yR4jvl2ncSbrKbBShRaxiCi0dM7Efi22XDnVdUl+grFxPJTVrLBaJyEjkKY1eJEtGNu/SVChXjP/
	ZepeWe4ceM/OQnvZKXFsomk3B8mYykDJJfxA5GS/blovQMy81KGWIIHyzENMxn3K4d1EhrXChy78S
	+722lbGaz48bGTs8e6LZ7+GySOulXJAwLahNpMjPfScQ4oAglDsZLi0ZtUgJBXYVu68aEJhx7ADOJ
	IHerqT7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsU6B-00AUKM-1s;
	Mon, 16 Oct 2023 20:21:59 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsU65-00AUJr-1e
	for linux-nvme@lists.infradead.org;
	Mon, 16 Oct 2023 20:21:55 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39GIAcIE024938
	for <linux-nvme@lists.infradead.org>; Mon, 16 Oct 2023 13:21:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=xnVDL8Ylug7++TvbNeswlaasDFrEm33OPoh5lNEGIeg=;
 b=Xl/Ie7SfeDVa0abxLVuNCzgdmAA/jsNNv3QoVzfJtwk1hlRvhge8awcRLzfdQVsGPJfL
 M2YTs7hUV7KjA/aqKCQ/93HLjcWZzjiDKCcX4qjSbyKwDY2P9QkLlHT1OpCTkMXJmQ+y
 e5FYZRej1iMek6DgjkpGtMqJoiMVRBDS8A8CvsWC3jXbIcQ0iGpokfvpaTdCfIkmp3nk
 OD4g2PBMifjz1SMT8Wk/dJnO9UZgKBqLwbDq6YUmb4en8bkziJGGCKZMqkvZ7cKszznL
 5+ob8Pla34pu9c+5yVy+OL3rUEqgTemUGeRDEoYRoMTb1Jjl4KRDEAdPftGzOkmyTu4U ug== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ts80vt407-7
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 16 Oct 2023 13:21:49 -0700
Received: from twshared11154.02.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:11d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 16 Oct 2023 13:21:49 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id D1BA52048758D; Mon, 16 Oct 2023 13:21:29 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: sanitize metadata bounce buffer for reads
Date: Mon, 16 Oct 2023 13:21:24 -0700
Message-ID: <20231016202124.2957213-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: al7as0K6bADRYi13FSneNypvdu33j-_4
X-Proofpoint-ORIG-GUID: al7as0K6bADRYi13FSneNypvdu33j-_4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-16_10,2023-10-12_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231016_132153_683177_A85582A7 
X-CRM114-Status: GOOD (  14.56  )
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

User can request more metadata bytes than the device will write. Ensure
kernel buffer is initialized so we're not leaking unsanitized memory on
the copy-out.

Fixes: 0b7f1f26f95a51a ("nvme: use the block layer for userspace passthro=
ugh metadata")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/ioctl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 788b36e7915ab..154eb7c944e76 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -39,6 +39,8 @@ static void *nvme_add_user_metadata(struct request *req=
, void __user *ubuf,
 	ret =3D -EFAULT;
 	if ((req_op(req) =3D=3D REQ_OP_DRV_OUT) && copy_from_user(buf, ubuf, le=
n))
 		goto out_free_meta;
+	else
+		memset(buf, 0, len);
=20
 	bip =3D bio_integrity_alloc(bio, GFP_KERNEL, 1);
 	if (IS_ERR(bip)) {
--=20
2.34.1


