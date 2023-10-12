Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B47ABCDB46E
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Oct 2023 18:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kf0Q3Q6UudGGFe+/lRC5Zkv0ouSlGji4mbpd49j8YDQ=; b=iucfGnpsf+d63CjSY+G9KOZq3I
	yxO5+gT6lrNbxYvybs9i/XYmbd/8MuPseqjjmse7M59U33BUkmw1+Wad/p3ZYc9J06LnDCyQ8SnPZ
	n1yOsXf1U/Da5jucY7ll30LMLBbEPyKQCHL2GbkrDK88p2IlXcRmNM/xmsBpWVoq1XFRO6Az/KtQn
	WA0fDvWl6PWcT0n1jDlxMvTao4anPOkg2oZfD0OQvg0SEVNwZIWycfIvZdQFDYSTLgoM8aIQg53WT
	qdEhwUIvVFAHDtFiioAKRRL3PFqGQItfXJxDm+eXvSjkYtAJ47gO0RIc1D/FO6hZoThCjN+lzENBI
	QWOVfILg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qr0Ri-001cJ1-0z;
	Thu, 12 Oct 2023 18:30:06 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qr0Re-001cII-2v
	for linux-nvme@lists.infradead.org;
	Thu, 12 Oct 2023 18:30:04 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39CIAJJW001380
	for <linux-nvme@lists.infradead.org>; Thu, 12 Oct 2023 11:29:59 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=s2048-2021-q4;
 bh=kf0Q3Q6UudGGFe+/lRC5Zkv0ouSlGji4mbpd49j8YDQ=;
 b=b91KXaXQ7whBTZL7IwBDtwEYytJkZOkZ/kvFSYduNVlgueP7Lz+PU0e+jPwYa/QhdKEw
 BAs5KBAoG7mxS2eEZmPnsJxGLtPlTroMhIDFI7VYvluG77xe1v5EfrYYla714+ntqibx
 iGeWIv3KYSaVbm18SfnzbN00aG+kZpqVaxvXtv067oFwJzd6YzGAYFeiDa74RgaLrlXA
 m3Q0V3NDhM778EPbBxfxO3o+V2t0LFh7685br4xEbr77UV2dKtRHRwaXOgcihxmawod8
 vBixIHlpyK3gsbmtMS0O8uCCvwT8vpwzIREaLNNIjvQSzRGeNFZ36UiWh+TAzpgEGbh9 jA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tpjtj788r-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 12 Oct 2023 11:29:58 -0700
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 12 Oct 2023 11:29:48 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 26DCA20166247; Thu, 12 Oct 2023 11:29:43 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>, <welsh@cassens.com>
Subject: [PATCH] nvme-pci: add BOGUS_NID for Intel 0a54 device
Date: Thu, 12 Oct 2023 11:29:34 -0700
Message-ID: <20231012182934.2042397-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MBxrGiOnqbjcYoPNf48BNVUdHGDe_6hE
X-Proofpoint-GUID: MBxrGiOnqbjcYoPNf48BNVUdHGDe_6hE
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_11,2023-10-12_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_113003_111681_7D132AF2 
X-CRM114-Status: GOOD (  15.08  )
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

These ones claim cmic and nmic capable, so need special consideration to ig=
nore
their duplicate identifiers.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217981
Reported-by: welsh@cassens.com
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 60a08dfe8d75f..507bc149046dc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3328,7 +3328,8 @@ static const struct pci_device_id nvme_id_table[] =3D=
 {
 	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data =3D NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+				NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
 		.driver_data =3D NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
--=20
2.34.1


