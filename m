Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB25C83F27
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Jul 2025 18:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BPDnzL8CcrJ/RooRNR+boHAaIRRdtwbS24ta/+8f6o8=; b=joAzD8pZSQEMWOQvX2S4iEpAbM
	m8PR+927cLTjpbqHgn9dMaXQLULqc0qOerUyN4/rW52K/EsH85gsBbfu9rcRdwTfTUbHIDMXpo7s9
	J45FDXgwQsAvEptnxk8Kge4y8fdOZe923CFf9PD+nXBgxC69720umZo0jETFAa3XLg4ePUA2XQtKD
	6q9Tphtu8AFwH+E/YPzR91fPu19ECSkw9wl0CmKvr/+SfYOh1dKt3KaQNhOxq07m/6+lN2IV2/44r
	X/QbaHxGc0C3Ri9P7NfcbSbW7VoevhYF35/Ar0ugbgREfsBuoo9vAOfkSFkDmdK7II7kiyrN49Kkm
	yTGeoFAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubOFn-000000034N8-0sKp;
	Mon, 14 Jul 2025 18:50:19 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ubMkJ-00000002vtr-3W3O
	for linux-nvme@lists.infradead.org;
	Mon, 14 Jul 2025 17:13:45 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EGmdEC015147
	for <linux-nvme@lists.infradead.org>; Mon, 14 Jul 2025 10:13:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=BPDnzL8CcrJ/RooRNR
	+boHAaIRRdtwbS24ta/+8f6o8=; b=hlUwPP1HyaCa5lN5E7Vm/o29GBfbhYH05/
	ephsD2NkzyUKNUKO4O388xj8ndwRkfz+0Swgpji9bgIdK0SCrEAGtYTy5V+IsbwK
	to7F3Sit0Xfv2ekhtWRM+KX5mJLgc34uDhHvSFXZB84luYoJUlBXTR7QHF9ZXW16
	sYD1habFf0yJVbJ5QwZLnmG+I9tJTdPGR4VQxfC42lWD7E6JqFOBRYlxOfkUXL+h
	W1Xw4NZemNFoDDuPpwYAX3QFY+X2p+970z8M4UeallD1M3u78Tjd1w5gK0L0385z
	EIghYcHHxQLVws6on5oi6mYhhYw90JfmO6iNtusJejLsYBgqI3nw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47vwmjums5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 14 Jul 2025 10:13:42 -0700 (PDT)
Received: from twshared21725.48.prn1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.24; Mon, 14 Jul 2025 17:13:40 +0000
Received: by devbig1708.prn1.facebook.com (Postfix, from userid 544533)
	id B9FE713E4E83; Mon, 14 Jul 2025 10:13:29 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-pci: try function level reset on init failure
Date: Mon, 14 Jul 2025 10:13:28 -0700
Message-ID: <20250714171328.681885-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SRwWE-5jMJzTA78z4NRMWtHntYf2lDeV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDEwNyBTYWx0ZWRfX1WHkaKZ1Qyav uB/HXIDcsXr22iRE/iqun9Yd1DPPBO/lfT5RY/TjpSRbMLLjqjSeSekOa4hmJsxzkdKE5/V5ZT9 8eSM8+dEDqz5W04xinCW2BxvUfC6PBQbUBNPIyE4Qnfh8AQTA76w/Ew+PjI452R2sSSrUZbebuK
 g9wLRIDIf5sDYYOG9UU+VTlYr9x5REX43K1YBKdSwUzeI0cx1IFRMdVHw1HgJPD2RYawtqHPjSz DIjw9DdXWIVa1tFho7YPmKDInyu8jI6puazcL2SJRrTA+Y9PjQ3fOpYLtFaIamn1kmV5obqnbru XIYm9PNdrOr9LcB6xmRAcAT8A7Cul7D511n0zX4eexSw7yXzCbr4j/SeLe8759nU9mgbzzXQuBE
 MXnz390r1eCo7f5kyYNuYmNq0d6JzIYo1PnkVcgnXnfvqJlcSJvG+U/CBQwIupnoOTprSgKG
X-Proofpoint-GUID: SRwWE-5jMJzTA78z4NRMWtHntYf2lDeV
X-Authority-Analysis: v=2.4 cv=ebI9f6EH c=1 sm=1 tr=0 ts=68753ac6 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=fbRKhktz8DzS-7rWtMYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_01,2025-07-14_01,2025-03-28_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250714_101343_917092_AC9B0AA5 
X-CRM114-Status: GOOD (  14.12  )
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

I've encountered various nvme devices that for whatever reason are stuck
in a reset state. Historically these have required a power cycle to make
them usable again. Vendors don't report any problem with the device when
we ship these for analysis.

In many cases, a PCIe FLR is sufficient to restart operation without a
power cycle. Try it if controller reset fails the first time.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4cf87fb5d8573..85749f19e3a23 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2067,8 +2067,18 @@ static int nvme_pci_configure_admin_queue(struct n=
vme_dev *dev)
 	 * might be pointing at!
 	 */
 	result =3D nvme_disable_ctrl(&dev->ctrl, false);
-	if (result < 0)
-		return result;
+	if (result < 0) {
+		struct pci_dev *pdev =3D to_pci_dev(dev->dev);
+
+		result =3D pcie_flr(pdev);
+		if (result < 0)
+			return result;
+		pci_restore_state(pdev);
+
+		result =3D nvme_disable_ctrl(&dev->ctrl, false);
+		if (result < 0)
+			return result;
+	}
=20
 	result =3D nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH);
 	if (result)
--=20
2.47.1


