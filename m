Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B47C83F27
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Jul 2025 20:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9TNoSKc6rDxMzwX1IpPkiMnLCG6GpkxeFpw51V9kE74=; b=aziVGj8w47YeJ6x2WJOzTOX74I
	8rNpvCwQCRLntOky3JZ5ZN4ORX12PrByPwD+zbycoLxGt8WCcpbuvR/5YJgOC50ZugBJJoJKJdA64
	cqnFiyDz33rZpZEHMILdB1SzYbPCQZr92MZs+e3Q5WcfAC/oVwPAsZPwj4mhHuXQ1DnGVJ0ovfTWF
	tBsg3rDLzh4Thez4uAjKut4oZXTQxqcNlCQG7x7SA/FGppDtjHM8rS7Oi+AJceeBLeFoa1WUrHn/T
	VS0IL8JuWXx7wDDMZF9fn1mGpY6cgu7GsoWTihzJfiX7OPSk8+nOPvIIxAm3060IQAPUXQNeZkV7v
	m3vHHoWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubm9t-00000006Afq-26q6;
	Tue, 15 Jul 2025 20:21:49 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubl8u-000000060hx-0jcN
	for linux-nvme@lists.infradead.org;
	Tue, 15 Jul 2025 19:16:45 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FIbZTn012764
	for <linux-nvme@lists.infradead.org>; Tue, 15 Jul 2025 12:16:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=9TNoSKc6rDxMzwX1Ip
	PkiMnLCG6GpkxeFpw51V9kE74=; b=tHn9nb8wCqS5OMart/8uzChwNfYfL0/0uT
	BL9bOU1ULVRPAwPTJYuolToMka2KrCLOoB5ZG54CAniSNhGhLClDYHz682JcGSF/
	6Yd1pcGAQvdojaFlaeufMdNH5+D6eBRceLWOC213Puy3Qf+guPobyKU9ALpXLFl6
	f5fwZjzp4UEPTeXFbD98xAhyw14EUCpUFV09mbIljq3GYU32wDMFuGf3q1SKoA6h
	J9Rs+yYoJgOImRKosoofFj7+StXRu/CLlDavYxwGjNPm5FsTe87tsSvS26GfoIG5
	9/1p7DlHB3X7qweq9KtrXu1W39pey4fI7T9bMM1QBwcRJEQ2OebQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47wk86n71y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 15 Jul 2025 12:16:42 -0700 (PDT)
Received: from twshared91430.14.prn3.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Tue, 15 Jul 2025 19:16:41 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id F38F314A7A40; Tue, 15 Jul 2025 12:16:27 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>,
        Chaitanya Kulkarni
	<chaitanyak@nvidia.com>
Subject: [PATCHv2] nvme-pci: try function level reset on init failure
Date: Tue, 15 Jul 2025 12:16:27 -0700
Message-ID: <20250715191627.3690017-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 3WqHee5-VzgwEKYVZb69XoFBV8HtW-2t
X-Proofpoint-ORIG-GUID: 3WqHee5-VzgwEKYVZb69XoFBV8HtW-2t
X-Authority-Analysis: v=2.4 cv=T5SMT+KQ c=1 sm=1 tr=0 ts=6876a91a cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=vdxsY-APClaN4XhN5VgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE3OCBTYWx0ZWRfXxzTVEeKuvzAT Eixwh5+WbDOumj+LaSRmdY02gmW/lsU3hD77Gx4KLqCmu4wLbKjoUU42a5k+iMavZjQ19/C09GH mGSz1gqWHdEDrk03i9o9jJZmeC2bQ45/6hTGAgFxMeeXYqsv0sBUhuKMKvqEHXWHF2WcGebnV+i
 VeP97CTNOIYnCN2ra+sREycBE1fSkYGcj8DhtY5jcQvBv81Ul7td/KTr4oWBwVTfGInBG6EDBR3 NNxdG8atf0tLHG/EOUIGICEm+GbMs2/tiRTS6cxHwG2SSd729INHcoO0w2f/wOiXtK7YYdskxWq xk/CY3Ul/VGg2m2qkmTYDIL7/QtKj8gdK+eiEV0NTzjUToCtd8ulo8HMrAbggHzUUL19A+D5DZN
 v3Xg3jImtybIMFxifpWTQzBapqrqkt0jJQeCmSOPXdRnF+J++4tqTHBqItkz+JyHICb9m6ep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250715_121644_334881_138B4F34 
X-CRM114-Status: GOOD (  16.53  )
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

NVMe devices from multiple vendors appear to get stuck in a reset state
that we can't get out of with an NVMe level Controller Reset. The kernel
would report these with messages that look like:

  Device not ready; aborting reset, CSTS=3D0x1

These have historically required a power cycle to make them usable
again, but in many cases, a PCIe FLR is sufficient to restart operation
without a power cycle. Try it if the initial controller reset fails
during any nvme reset attempt.

Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Added code comment explaining whe escalation

  Add an informational kernel message that this event occured

  Use the "pcie_reset_flr()" API instead of "pcie_flr()" since that one
  checks for quirks and capabilities before writing FLR config bits.
  Note, NVMe PCI Trasnsport Spec mandates FLR capability, so the latter
  should not apply to any compliant device, but you never know...

 drivers/nvme/host/pci.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4cf87fb5d8573..f8f8cb6a4786a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2067,8 +2067,28 @@ static int nvme_pci_configure_admin_queue(struct n=
vme_dev *dev)
 	 * might be pointing at!
 	 */
 	result =3D nvme_disable_ctrl(&dev->ctrl, false);
-	if (result < 0)
-		return result;
+	if (result < 0) {
+		struct pci_dev *pdev =3D to_pci_dev(dev->dev);
+
+		/*
+		 * The NVMe Controller Reset method did not get an expected
+		 * CSTS.RDY transition, so something with the device appears to
+		 * be stuck. Use the lower level and bigger hammer PCIe
+		 * Function Level Reset to attempt restoring the device to its
+		 * initial state, and try again.
+		 */
+		result =3D pcie_reset_flr(pdev, false);
+		if (result < 0)
+			return result;
+
+		pci_restore_state(pdev);
+		result =3D nvme_disable_ctrl(&dev->ctrl, false);
+		if (result < 0)
+			return result;
+
+		dev_info(&dev->ctrl.device,
+			"controller reset completed after pcie flr\n");
+	}
=20
 	result =3D nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH);
 	if (result)
--=20
2.47.1


