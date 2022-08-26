Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E3CECAAA6
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Aug 2022 16:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RSp+osTrgHwtvEqGPfDbXJNoRin17x53U+C/fbk5jQM=; b=CsdRYxK4AXUesaztmnmtdZ3YBN
	2vzguYPwKrCZdjpuyFDmyKZ/xHhkd4jfzw19rmGkdcs3iqdYSMD3HqC+KIt1xtOWId6JsOISfVBqg
	zPnAYJqPHgDRkMxrJxSpYR9E/iSfw4cfYsF/q6VOgmvoKZ/l2jmQQX2GYc6eZbOm0Q3O8+IKUhHPj
	gnTVqrw/Eh8+GPka53UO58t6NI6fyNzNFjsa2obUK0cRv6ktZFDpeQFvuxwsc9GsGlp+IX/MuEzSj
	q806OQTuCoHUn1UTQj2RE1k3uFddoeWW+0wOoPEzcCzLBuJRvEfxCQnlDtNrF4sNjo3UZdUBMf5ca
	sM0g91BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRcYj-008bBR-LH; Fri, 26 Aug 2022 16:51:53 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRcYg-008bAc-QO
	for linux-nvme@lists.infradead.org; Fri, 26 Aug 2022 16:51:52 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 27QG744I012621
	for <linux-nvme@lists.infradead.org>; Fri, 26 Aug 2022 09:51:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=RSp+osTrgHwtvEqGPfDbXJNoRin17x53U+C/fbk5jQM=;
 b=LKpazTRY0DDyGdb4PoGNGQ5VoqcatsBhnOWjCFqsQg0+c2PGbMvzAZqSOquzEmTW7y9G
 Qy8uK0/HD5pulQFzQh4+6AJ8Ab8mwoaJebIlKkan/LwwgbxrEiKO8HQnYxNVNKXWabRU
 aUkiIwsJDT2hBof3ubempZf0v9d+mDuQw6U= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3j71dhgau2-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 26 Aug 2022 09:51:47 -0700
Received: from twshared32421.14.frc2.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 26 Aug 2022 09:51:45 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 91FE57D3ED3B; Fri, 26 Aug 2022 09:51:41 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Shyamin Ayesh <me@shyamin.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: Lexar has bogus namespace identifiers
Date: Fri, 26 Aug 2022 09:51:40 -0700
Message-ID: <20220826165140.249418-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Qv5-WqSELmVJHvGrwPmDlL7ELWF-nsRq
X-Proofpoint-GUID: Qv5-WqSELmVJHvGrwPmDlL7ELWF-nsRq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-26_08,2022-08-25_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220826_095151_006028_50B33B1A 
X-CRM114-Status: GOOD (  13.75  )
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

From: Shyamin Ayesh <me@shyamin.com>

Apply the quirk

Signed-off-by: Shyamin Ayesh <me@shyamin.com>
[patch formatting]
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7a74f12536bf..63d4989f89a5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3807,6 +3807,8 @@ static const struct pci_device_id nvme_id_table[] =3D=
 {
 		.driver_data =3D NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
 		.driver_data =3D NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1d97, 0x2263), /* Lexar NM610 */
+		.driver_data =3D NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data =3D NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
--=20
2.30.2


