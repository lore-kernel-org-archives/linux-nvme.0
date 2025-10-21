Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34633CCD1A7
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Oct 2025 15:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=YnM5WXFqfo+jUfMG9FlsfDWmjAoJqU33rlAdDmBaq9E=; b=QtntYEy/r1MKrAqh2bVD1Fk606
	TNbQMdVBlxGDThVApISJEQx87D3plptRNGe3ZPS9jAJKA8svp1KqnMsWqWl2QsHE95mkiS6AJAK/B
	uN6w9RJkiaVZQmVhRYhy7FMJm6lLbaCvbuk9p8OIlATlceRdltaHVfe7tHXc80W1VW8lWLMdnigNU
	Ljyj/dUwAtZfe7e3fG6Fs5TY7TNT8ZN3kTfBf7obC2jIRVtk1gjNcy3Dc4Kur3eKoqgxHVBXb6XqT
	CkGA6EyRbjBhmSfTwTaiBcFCBo6Ma0v74QKDUs1g8qZvtjA7b8+xhoaeWCssqK/5xtccaumPEeC+8
	xbq9/sBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBE8K-0000000HTQU-3NXA;
	Tue, 21 Oct 2025 15:18:44 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBE8I-0000000HTPk-0lFt
	for linux-nvme@lists.infradead.org;
	Tue, 21 Oct 2025 15:18:43 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59LBng3Q2956392
	for <linux-nvme@lists.infradead.org>; Tue, 21 Oct 2025 08:18:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=YnM5WXFqfo+jUfMG9F
	lsfDWmjAoJqU33rlAdDmBaq9E=; b=S1lB1j9gTmriErwcarEsFk2WPuMTDJFTbP
	m4xYqctDkTVRk1fHYzSAeKB2MNixYgeQKMZNTt+OfEIHFE4TnhZMR81/pLqG65el
	AWSvmkjLbcjECEc5wTCCZ/1qhxF++GM/rzTr2FhqhAKcSYmd0pCBB90Tyc1rA0ld
	j75Jj6VS7Uvh+8u33gcOv1EdsoJEJPIM5ca6zD7Uun452zn4PWONQaBQVpNRHA6G
	G9R5Un2Iei+bJjOLO22O+e1kRoVZgHzJcvQtuikb/Aspv7cL8Pyg0yu66qwsJ1I/
	wvIqQD0g2g999yp44XzBhPtsONyp5b5lz0slPE1s9DluXVA8JLcg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 49x9mw9h3a-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 21 Oct 2025 08:18:40 -0700 (PDT)
Received: from twshared28390.17.frc2.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.20; Tue, 21 Oct 2025 15:18:38 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 2ABC62EF20E1; Tue, 21 Oct 2025 08:18:33 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: [PATCHv2] nvme-pci: use blk_map_iter for p2p metadata
Date: Tue, 21 Oct 2025 08:18:31 -0700
Message-ID: <20251021151831.2009152-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDEyMCBTYWx0ZWRfX3SMrHnjshsSr
 mgYyhtIPP96keS6y/JC1C/4nFrpM5VsZfQDMFNRrkU6RMfkB+qI0QGZQNUROy7E7grnl5Ihw3oO
 aPZXiHS1u31Qj4oJ/FvbmwbcM3rN9m3Tjx5WX7Itt64yRL2/IhC6yiScFZco7q1XPfRfIpukXvy
 6RfEVieFMR7xj4UoFxMj4B0jjfndtmV/f/B/mpCwUKHMh3ppR43faq5Aepa6gmoiQB0Do+k/hxP
 2woklkKHl3R5gz2vbjpAUgtGD7mVwUMRJtHKFsIOxVOK8gHQz24v7PKhIAbtpfox8ZjA5M+LjK9
 pWONHdIiJrnK+TnZvNpDpf6d+ssPZEx08B1OEWEA423RiMuwmpAEhdWUxjxrftGAFD0bnoEcZyg
 LOYU4HyqWyZV/X8a8NCZI/hPS+k94A==
X-Authority-Analysis: v=2.4 cv=f/dFxeyM c=1 sm=1 tr=0 ts=68f7a451 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=LJV9e_wRYO6L_CbrxMQA:9
X-Proofpoint-GUID: vuBxaEVUsnS49B71B1W9u6bkXcEANgK_
X-Proofpoint-ORIG-GUID: vuBxaEVUsnS49B71B1W9u6bkXcEANgK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251021_081842_256706_92D56C9B 
X-CRM114-Status: GOOD (  12.72  )
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

The dma_map_bvec helper doesn't work for p2p data, so use the same
blk_map_iter method that sgl uses for this memory type.

Reported-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3c1727df1e36f..4087a665fa2dc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1085,8 +1085,12 @@ static blk_status_t nvme_pci_setup_meta_sgls(struc=
t request *req)
 	 * descriptor provides an explicit length, so we're relying on that
 	 * mechanism to catch any misunderstandings between the application and
 	 * device.
+	 *
+	 * P2P DMA also needs to use the blk_dma_iter method, so mptr setup
+	 * leverages this routine when that happens.
 	 */
-	if (entries =3D=3D 1 && !(nvme_req(req)->flags & NVME_REQ_USERCMD)) {
+	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl) ||
+	    (entries =3D=3D 1 && !(nvme_req(req)->flags & NVME_REQ_USERCMD))) {
 		iod->cmd.common.metadata =3D cpu_to_le64(iter.addr);
 		iod->meta_total_len =3D iter.len;
 		iod->meta_dma =3D iter.addr;
@@ -1127,6 +1131,9 @@ static blk_status_t nvme_pci_setup_meta_mptr(struct=
 request *req)
 	struct nvme_queue *nvmeq =3D req->mq_hctx->driver_data;
 	struct bio_vec bv =3D rq_integrity_vec(req);
=20
+	if (is_pci_p2pdma_page(bv.bv_page))
+		return nvme_pci_setup_meta_sgls(req);
+
 	iod->meta_dma =3D dma_map_bvec(nvmeq->dev->dev, &bv, rq_dma_dir(req), 0=
);
 	if (dma_mapping_error(nvmeq->dev->dev, iod->meta_dma))
 		return BLK_STS_IOERR;
--=20
2.47.3


