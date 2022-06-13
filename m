Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA26DCCA47B
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 14:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=88ricwhERnLUhC9DHez0Deev+fBYB1qUiFF2UnQc4bU=; b=J2hHhuIQ8GQzv+E6wiyswgnrOr
	HbvuDnxPUgE9+BD/umchF2hZjKRJdPitQL4frN2a1Tq9rCMcyiCpnV+IMisdT5jgtT+MiS///6+L3
	KdCQ5URI/GinZyyVtA06Wfr+d1+5kKnEtqv5xlDNL4hHA9AwXa/abr83q2LOb8VnalNVS+dumdbl6
	7kwOnlyv3drTxHVkWxFlElqMPPtM3gZtODvhi2rK9YWiGU20y59npUhDBF4Gh+Tdp8tHSfutjNYNL
	3y6pKv/XfoOErVFJwWl8Bonp4v+SSBmi6Qsjo1r7eyMyBXvUubGjTS6ldjHYkjcidUutDr/atvWMg
	YIsqzomw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0lKQ-004GJJ-TE; Mon, 13 Jun 2022 14:46:06 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0lKK-004GGf-20
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 14:46:02 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25CN0WO7013156
	for <linux-nvme@lists.infradead.org>; Mon, 13 Jun 2022 07:45:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=88ricwhERnLUhC9DHez0Deev+fBYB1qUiFF2UnQc4bU=;
 b=FUyiicKg6eXpGyTBR0Qi4hNrQJcRpReRmerRRVWReLeZ2T+q7tt4b791RpCN7JRCZa4P
 SG62yC+xJgQy2vls01HylqEviiwDRFnTzDH10ceGtwxIqgL9W/SOd0XSHJb2MuZybDj2
 1RGzxeMdLLFCEocCHRoAnrgL3ZX8LQha8Ds= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0089730.ppops.net (PPS) with ESMTPS id 3gmpj890d5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 13 Jun 2022 07:45:57 -0700
Received: from snc-exhub201.TheFacebook.com (2620:10d:c085:21d::7) by
 snc-exhub204.TheFacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 13 Jun 2022 07:45:55 -0700
Received: from twshared18317.08.ash9.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 13 Jun 2022 07:45:55 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 28F4950065B7; Mon, 13 Jun 2022 07:45:51 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/3] nvme-pci: phison e12 has bogus namespace ids
Date: Mon, 13 Jun 2022 07:45:47 -0700
Message-ID: <20220613144549.232686-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: wcjjp6Wu2yJfv8P3jqCpbGDdSNvav3Xm
X-Proofpoint-ORIG-GUID: wcjjp6Wu2yJfv8P3jqCpbGDdSNvav3Xm
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_06,2022-06-13_01,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_074600_275772_83088407 
X-CRM114-Status: GOOD (  14.36  )
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

Add the quirk.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216049
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 48f4f6eb877b..4b4ffb047c61 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3437,6 +3437,8 @@ static const struct pci_device_id nvme_id_table[] =3D=
 {
 		.driver_data =3D NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
 				NVME_QUIRK_DISABLE_WRITE_ZEROES|
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1987, 0x5012),	/* Phison E12 */
+		.driver_data =3D NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
 		.driver_data =3D NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1b4b, 0x1092),	/* Lexar 256 GB SSD */
--=20
2.30.2


