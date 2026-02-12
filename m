Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F8CEEE36AB
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 16:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ucoYBPCvTnUECOgar/xP/jfg8hs1PQwW6gsNguk4xk4=; b=fWlI0teDDdvSYV87Mko1zB5DV+
	fFFZsOMAk2WNfpAjH3YI61fdHdFtLswNSsz+D7ZY/8ql8asybmFsRoYv0HWcKGXxfy3gv2t6o2Rkm
	1NDVvIs5pNYK8G8KoMJquEMhqwopzQj7enrJZQc9WgWDx+HCgeSoRM6EDgrhr61yCpy8VyCqNY/GZ
	wTBmCfDGClngxjF4qkEIjusvCt6LDgWlfzpoSLimqWHN8vHGyzDnMcoxeZmCisyu/TL/u4kZOLb9B
	enjRYhSckoVP23BfmRtsyaM7JyVCFc1FtucvMHLUUUMRYxv/NRfjQLbhf6aB/8soqF3WH0F695FDr
	47KVDgbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqZr7-00000002Nyn-2c64;
	Thu, 12 Feb 2026 16:47:53 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqZr3-00000002NwU-3Vhl
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 16:47:51 +0000
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CEfEhp2944714
	for <linux-nvme@lists.infradead.org>; Thu, 12 Feb 2026 08:47:49 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=ucoYBPCvTnUECOgar/xP/jfg8hs1PQwW6gsNguk4xk4=; b=XOvZdSMMsqgb
	elfjGFMD4vsZiklRDL0HEHPK7lvoPIISHs5trAgbl9PXQhUb3IzJoo41hwOuK8g2
	G39reE/IDfe+qs2xdouNDGj4X66EmihNSuL8JRKesn7D4M39cZEYFwG2jabKZTkM
	7YRWo5z6XX/2zrJdtzZ614DwlSnXMJoSvkQ+vf27xMesBamUE5YAH5IC/plEm2qJ
	3wvDovsHld1XVrNhAkna9FB3cv1VhNf0/G6TIaksUajYaUOPd1KWb9NkoM1krn1Z
	Rvq+I7FagIRmH8udTSSeG3ADKL2MzoKqlOiGgUTnXyaZbHU/GJqP6C4aOUoM1g4u
	C2sDOVym5g==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c97yp5hgc-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 12 Feb 2026 08:47:49 -0800 (PST)
Received: from twshared13080.31.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 12 Feb 2026 16:47:47 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 9A12F7A6B562; Thu, 12 Feb 2026 08:47:35 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 2/3] nvme-pci: cap queue creation to used queues
Date: Thu, 12 Feb 2026 08:47:32 -0800
Message-ID: <20260212164733.3006071-3-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212164733.3006071-1-kbusch@meta.com>
References: <20260212164733.3006071-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=GvJPO01C c=1 sm=1 tr=0 ts=698e0435 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=hD80L64hAAAA:8
 a=3PqamS-XlMzQfuyNXKMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEyOCBTYWx0ZWRfX5DFPYoD+tc9D
 Jt4DCv61hA7M/6hPkGYfMxHGBrNfcc7SK7O1VBzC7EpR5uVmFS2D98QGjlHQ73Dxbawz8pOoubs
 6WWS/5hX2C+BzQRR3yV9fyGRoa2UMjosarbpVGHWxTHXjYxyCxeZDn6Tkoczjk8q9DypU/K3MNJ
 z+G2lh5R5FXOWok9Pjel3DLDI3TojqLejAUJYYb8qSGpe+TfonOmi7SYM6vrvSlVUceQHfd3OpR
 AoMepcJZfuVw+iVjZ+IC3sCy7M2+9+JcIvtiXd3uV2OuiYwmkfu9Mg7TANzspjwmgtKWZ0UYWGu
 tsH2WgwEZXi31HSQkJ6KXaY7hOoXtBI+DCr+hNzpkO9GoU8sImy6+V9gaaiRVpVNpErX5OhA+zB
 4KUd1Kj3vlKTBkl2W4YeNNR0jsWVVPjdO1yPYZrugCbza4tM9iCxZ4LernfeYczVkoRrFnC1gS/
 4VS/GhMW4iqkeU9XugQ==
X-Proofpoint-GUID: DfY7OahfjTi8Gfq4a4pbvpQT6uKFwjqB
X-Proofpoint-ORIG-GUID: DfY7OahfjTi8Gfq4a4pbvpQT6uKFwjqB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_084749_877660_50B45B1D 
X-CRM114-Status: GOOD (  12.58  )
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

If the user reduces the special queue count at runtime and resets the
controller, we need to reduce the number of queues and interrupts
requested accordingly rather than start with the pre-allocated queue
count.

Tested-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed--by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4ee4d7ead5a92..c63efa49132f9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2902,7 +2902,13 @@ static int nvme_setup_io_queues(struct nvme_dev *d=
ev)
 	dev->nr_write_queues =3D write_queues;
 	dev->nr_poll_queues =3D poll_queues;
=20
-	nr_io_queues =3D dev->nr_allocated_queues - 1;
+	/*
+	 * The initial number of allocated queue slots may be too large if the
+	 * user reduced the special queue parameters. Cap the value to the
+	 * number we need for this round.
+	 */
+	nr_io_queues =3D min(nvme_max_io_queues(dev),
+			   dev->nr_allocated_queues - 1);
 	result =3D nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
--=20
2.47.3


