Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 739F1C636CD
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Feb 2023 18:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eoTlONx5KdTAaDio2J2Bcv2O3WhzPOXiviiUr74AsKI=; b=3lTYtRPY8eRJDRUKSbhbpmMY4X
	IvhCxFZfXNH3UbCU5lzBHIAdkdTMxgyawwQnRSTFxuwIKJs7vpWofKCPskVeNldJCdkWNLYmGJWEf
	b3l267v8WyyjJSyiV1mPBgz4N8HD6Ewd1ZBINSO2WpAIjyN0kwaH0JnBp/3wsRg5fd6iWq4iGXppH
	ZNmOU2R/oLIYRVNhSU6wIxbmi1DlxdM89j6vkkzIJokXRbs87tJvic426DZHw/S0a3Z2gnuAOJvZ/
	JS9vK5TZj73J0Kg2nUsMDDsQ8P84M6fz1/tDCKbVaXeutEf0MLNcGXcTNejvA4NNIMxn/g8OVrIrk
	JVqkp/9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQXkv-006p3D-E4; Fri, 10 Feb 2023 18:04:17 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQXkf-006oum-U3
	for linux-nvme@lists.infradead.org; Fri, 10 Feb 2023 18:04:06 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 31AFtVXC002728
	for <linux-nvme@lists.infradead.org>; Fri, 10 Feb 2023 10:03:57 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=eoTlONx5KdTAaDio2J2Bcv2O3WhzPOXiviiUr74AsKI=;
 b=mtSYvmpDWAvcghRzAKSXVPLQ5nZ65xyvLAiGHvcc1JUDxDOo28LoXp/SupF5gsLAB9me
 V6lruK84dZmCOC4yQWLbDJoJbLRkbnKyPAPobfIbWOcCCaDXfw9kUa3v1FjZlNJwiqQe
 D9Vt5BNixJSq1zQNnftjdoWPLFKXGmWEEp0QoDyLK7GwnVt/YzlEmalGgK2V86JwufGt
 KriWgVA0c1tw5OUqgYeCIza95x0QBabd747D3BTn05d6LPxej8NjX2fZifa5unvwwOjc
 dq4iYrM1o+eXw2JcM5uWt0EvKodjqcsVyPbzed3NodXuHLbmYqo5grDTqV/vXKYF8zNa BA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3nmsern56k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 10 Feb 2023 10:03:57 -0800
Received: from twshared43869.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 10 Feb 2023 10:03:56 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 0185C11097D1D; Fri, 10 Feb 2023 10:03:49 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <schnelle@linux.ibm.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/2] nvme-pci: remove iod use_sgls
Date: Fri, 10 Feb 2023 10:03:47 -0800
Message-ID: <20230210180347.3613573-2-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230210180347.3613573-1-kbusch@meta.com>
References: <20230210180347.3613573-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: lKnU6NDYFfMHXUvP9seyoBFqsKy1mI8z
X-Proofpoint-ORIG-GUID: lKnU6NDYFfMHXUvP9seyoBFqsKy1mI8z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_13,2023-02-09_03,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230210_100402_199218_152A7946 
X-CRM114-Status: GOOD (  14.24  )
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

It's not used anywhere anymore, so remove it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 47d6b0023e3a8..d68e2db00d0d0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -230,7 +230,6 @@ union nvme_descriptor {
 struct nvme_iod {
 	struct nvme_request req;
 	struct nvme_command cmd;
-	bool use_sgl;
 	bool aborted;
 	s8 nr_allocations;	/* PRP list pool allocations. 0 means small
 				   pool in use */
@@ -808,8 +807,7 @@ static blk_status_t nvme_map_data(struct nvme_dev *de=
v, struct request *req,
 		goto out_free_sg;
 	}
=20
-	iod->use_sgl =3D nvme_pci_use_sgls(dev, req, iod->sgt.nents);
-	if (iod->use_sgl)
+	if (nvme_pci_use_sgls(dev, req, iod->sgt.nents))
 		ret =3D nvme_pci_setup_sgls(dev, req, &cmnd->rw);
 	else
 		ret =3D nvme_pci_setup_prps(dev, req, &cmnd->rw);
--=20
2.30.2


