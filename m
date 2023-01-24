Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 356F4C25B4E
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 17:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yD7Dp60AZd3K0NWbyKU+vWkD8rJ6qXE8MUo57cZw3Nc=; b=ztCtruvJzIQfqeSyv4DMw9/qSN
	H/de0Z0xJGsHLZf9Gd8oojQsz78WvO8a48vKRO61frchWsLRrcFPZJ/f6HtRNY4HA4+FVhQH+jW7k
	bp8i/sglJze4aUavCnJP22Ray3bWI8wxrHVPwS4xywdQpZiHT9NDU2n/0JNUv3L5/3UQvsYXD/+GA
	T+5diquh6xGIGPhG93uEvxkStUhQwc5xs7F7PCDSZCSAm8pZSLZaBlpZxNMDG1flsfaSB5Kjwhsr1
	D8SWnGlxJM0H5pdjmEeDhhc9m0HXdJTx9us95nFnOeRFgqjhzY0Qv9guvZQZk+AJ7o/LFUl1KPXiZ
	lbiL+Mqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKMvq-004nNw-I5; Tue, 24 Jan 2023 17:18:02 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKMvm-004nKQ-KD
	for linux-nvme@lists.infradead.org; Tue, 24 Jan 2023 17:18:00 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OGSVsS018543
	for <linux-nvme@lists.infradead.org>; Tue, 24 Jan 2023 09:17:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=s2048-2021-q4;
 bh=yD7Dp60AZd3K0NWbyKU+vWkD8rJ6qXE8MUo57cZw3Nc=;
 b=KlNE9BUFmHxM1xQvfifUiNWiPBMxdDxBns65I4sKYx0uJA7JKbcSUnb78tCZ/f5e30Qo
 oRnwT8Z18wdyM8Q/h3ewlK3R77Rp7OEY85Wsan0JQlMlpjCOQQF/344k/HG6l8XvPPmy
 TKkC8RiNRtg8IAMIopk38ye0Y+VPGr+7FPJJ9jmW3raNaKm/UksYb5NcWRiPuBJc5q9N
 jErd5hLmBXcJq9m+21+JKI3h6nrnyMiIkukP1CfrEdx3y68V8wIiPSYem77tfo4eE5Jl
 zWpjhjJqu48biSiEORYrDJhu8d7OQb7BXASMKZUMOm5hUQ4YhI//TfyU6yCz/fBA6oxj vA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3najv1gevs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 24 Jan 2023 09:17:55 -0800
Received: from twshared25601.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.6; Tue, 24 Jan 2023 09:17:54 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 335F7FBBB950; Tue, 24 Jan 2023 09:17:39 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Klaus Jensen
	<its@irrelevant.dk>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?=
	<ville.syrjala@linux.intel.com>
Subject: [PATCH] nvme-pci: flush initial scan_work for async probe
Date: Tue, 24 Jan 2023 09:17:38 -0800
Message-ID: <20230124171738.2311160-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-GUID: 7rbM_rfQiSPSFuwjqfj4D-_zEbytsB3k
X-Proofpoint-ORIG-GUID: 7rbM_rfQiSPSFuwjqfj4D-_zEbytsB3k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-24_13,2023-01-24_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230124_091759_048896_49C83AA2 
X-CRM114-Status: GOOD (  13.09  )
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

The nvme device may have a namespace with the root partition, so make
sure we've completed scanning before returning from the async probe.

Fixes: eac3ef262941 ("nvme-pci: split the initial probe from the rest pat=
h")
Reported-by: Klaus Jensen <its@irrelevant.dk>
Tested-by: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b294b41a149a7..ff97426749976 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3046,6 +3046,7 @@ static int nvme_probe(struct pci_dev *pdev, const s=
truct pci_device_id *id)
=20
 	nvme_start_ctrl(&dev->ctrl);
 	nvme_put_ctrl(&dev->ctrl);
+	flush_work(&dev->ctrl.scan_work);
 	return 0;
=20
 out_disable:
--=20
2.30.2


