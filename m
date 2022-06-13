Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D022C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 14:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cCQdn6y444oc3YMR1jPc12CxG8KAUd28wL9BBX9Back=; b=XRn2hz9Dp+irx4LsMgREJGSjSW
	QQxkXRcHbckLX5xdrUyzdM/lw2k8jLgLgOuu5wViuxEsX2sulbfyxpKagT6sNr7HKxu1vJ/9xueHx
	koRyHi0ZBpg9BUS6gx0z7lXVrnfTNkzR11irofwPMpDwzIKye3mL7PXXZILOZ6kaFb1WwXp2XEnJy
	Y5oYLzW1nMBpn5kEy6nL86+0v1R5pZike+hbJha5smPNcurvQDg/DwfmZtaZLzUk93L4EFBNwisx+
	Bt6iBtbYcnz5JvXG9KFa7kuxMJY0J3IzEzAVBfpQzYpdIjfsaNLFYqThYboa0bPk1LozMGYqPIlIe
	NojfL3XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0lKM-004GIE-Kg; Mon, 13 Jun 2022 14:46:02 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0lKJ-004GG2-Ez
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 14:46:01 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 25CNiXDU019264
	for <linux-nvme@lists.infradead.org>; Mon, 13 Jun 2022 07:45:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=cCQdn6y444oc3YMR1jPc12CxG8KAUd28wL9BBX9Back=;
 b=jF9Ue7lK6c0KEGhEzIilwsOctWStZm+uKew8GtY+OagJ83DMpgmtvuuwt2LEBsxFQszF
 PngnJrB53gkPt1lv4tISyg4/vrUQQ6C3b5tddq2eIpCS5idsByy5Ry2kvosJgSmHwHYU
 6JZUJOz2cRpXk6jA4COTLhVnZ2GpQysijWo= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3gmpqx119d-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 13 Jun 2022 07:45:54 -0700
Received: from twshared25478.08.ash9.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::d) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 13 Jun 2022 07:45:53 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 4D70250065BB; Mon, 13 Jun 2022 07:45:51 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/3] nvme-pci: sk hynix p31 has bogus namespace ids
Date: Mon, 13 Jun 2022 07:45:49 -0700
Message-ID: <20220613144549.232686-3-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144549.232686-1-kbusch@fb.com>
References: <20220613144549.232686-1-kbusch@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: B_tJet-P8po9Laji1075DyrRIyzLDcua
X-Proofpoint-ORIG-GUID: B_tJet-P8po9Laji1075DyrRIyzLDcua
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_06,2022-06-13_01,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_074559_665375_95CCBF1D 
X-CRM114-Status: GOOD (  15.06  )
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
index fc9b7c866a75..8bc6edb7b617 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3452,6 +3452,8 @@ static const struct pci_device_id nvme_id_table[] =3D=
 {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
 		.driver_data =3D NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1c5c, 0x174a),   /* SK Hynix P31 SSD */
+		.driver_data =3D NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
 		.driver_data =3D NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
--=20
2.30.2


