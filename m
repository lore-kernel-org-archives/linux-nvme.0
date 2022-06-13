Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3ED7C3F2D4
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jun 2022 14:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v1LCp8lCZaWKgj78wYB4Fp1ArLeKZDZqtnuYrtzokgo=; b=FBeV3nDJDCzKB50iWMxMW2QWha
	9SDUZxAYtEvFp+/f6yKypm53Lb/zxQBpDuL8Qvh3Ia9QL9Zdz8GfoGL9XI37INtpAjar9a0qsWr5q
	iTejHIl8Jei6El/5vOJQz0mC9QOT8yMSQ01HPX1QBd0/CY1qH/J15v1o9rEndyC6jfZnaBs7ZWTBB
	IAP8e0KQJ0CnbPx0HkhcMFjZv92C5ob6IBGhQXODT36NgA6cM8O0HfHHFT4IpXHmeOFc7Mf6vnkyA
	ZyCpZITOAviQUM3lDcnRiA3+mNTfjHefyzuvzCVrAU8mMP5FazMqNhzGGbbG4cvcB7++eBPUEqCnr
	A34dLqFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0lKV-004GL4-Do; Mon, 13 Jun 2022 14:46:11 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o0lKP-004GID-12
	for linux-nvme@lists.infradead.org; Mon, 13 Jun 2022 14:46:06 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25D2Krp2009174
	for <linux-nvme@lists.infradead.org>; Mon, 13 Jun 2022 07:46:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=v1LCp8lCZaWKgj78wYB4Fp1ArLeKZDZqtnuYrtzokgo=;
 b=TWayYo8kaylBJiwUQJz5x5M8yk6dvjxARfnKlWmHBr6y1HCXvWzconRiFZFL3MxZi4+/
 gS0a/3mORevBh9mH4Iwgkw0C0p+P72tWe9wCcds0tA6AQHhL7nKOZvFKDG5KdFHpIjg0
 f8A2aMoZhu6PvKj2pr29IZmkjptOT0RNQas= 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3gmtc40gjg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 13 Jun 2022 07:46:02 -0700
Received: from twshared34609.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 13 Jun 2022 07:46:00 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 4342B50065BA; Mon, 13 Jun 2022 07:45:51 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/3] nvme-pci: smi has bogus namespace ids
Date: Mon, 13 Jun 2022 07:45:48 -0700
Message-ID: <20220613144549.232686-2-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220613144549.232686-1-kbusch@fb.com>
References: <20220613144549.232686-1-kbusch@fb.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Gx7ZlB6ZWU5yYtaEPg5R1HUQiS8IoDvd
X-Proofpoint-ORIG-GUID: Gx7ZlB6ZWU5yYtaEPg5R1HUQiS8IoDvd
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.517,FMLib:17.11.64.514
 definitions=2022-06-13_06,2022-06-13_01,2022-02-23_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220613_074605_125952_DB00D8D1 
X-CRM114-Status: GOOD (  15.65  )
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

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216096
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b4ffb047c61..fc9b7c866a75 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3421,7 +3421,8 @@ static const struct pci_device_id nvme_id_table[] =3D=
 {
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data =3D NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
-		.driver_data =3D NVME_QUIRK_NO_NS_DESC_LIST, },
+		.driver_data =3D NVME_QUIRK_NO_NS_DESC_LIST |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
 		.driver_data =3D NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
 				NVME_QUIRK_NO_NS_DESC_LIST, },
--=20
2.30.2


