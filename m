Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BF5EB2700
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Feb 2026 19:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Rwf+20VMTd2+QuwL6pXb4JgxQqWn5LY4vXUwXPa54Pw=; b=I5iri7guwXtQ13DbME8CNaXmsc
	5IZdP+SnQMFys/4VKqu23zG83/8gIT00I31GVhSFG4Uy+pRClj59BY8XgxpVvcGJtQ5Xv6mSCU0hd
	JFPr7uDnNWfpPS1goY5nZARr4gpCFottaD5kFX9E5lLnBieoiKeCo4+5AZSm4yFWPxXQ7ipsMeWsx
	6P3AcuSespWXueT6t/gaJGPzichhDOMStX5Lyd5mO3igkp9+yvPt+vNmdGARcjCBzlJuQ+zzjrSC/
	3NxamJ/wmsuI9At5+j8FL7mYP7EeB/CgPS4NiH1ojp8xaUoL+4rRzThhswBzqaW3U5Mj+OHqVC/Ly
	a9j3OEDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vptYF-0000000HRiT-1qIY;
	Tue, 10 Feb 2026 19:37:35 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vptYC-0000000HRgJ-2fMn
	for linux-nvme@lists.infradead.org;
	Tue, 10 Feb 2026 19:37:33 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61AG73Ap3098023
	for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 11:37:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=Rwf+20VMTd2+QuwL6pXb4JgxQqWn5LY4vXUwXPa54Pw=; b=SdBve3yGguV1
	7VU7WDnftD8GtK8ARM27Ph89d/lpyLw+4IoOZwkGsLwLdnBXzaZ6gDMoJUznVX+7
	b6J8tACfhE9qo1uqDkdRJn9/yEyhh2wufiRjkUjOgFF4TXkvKY2JI3mEbrHLo7cr
	hS8kpipnaw2U5qnj98qapLa6AaxBwMkgcYgQnArSW26iec/jqK0EgrGAvkzk5jiH
	peVs1DEoZZwspueOS4tFTOENOvSaH321VGpE0z4I0eYD2NvKSTqDyg1YmYI3q6dT
	9oQt6vL2feblhT+90bZguaQbpBxFHoPogjIHVNh2rPXB4CSd37+rcpcKRmvxY4H7
	PAb57iv5Wg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c87wrb3ch-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 10 Feb 2026 11:37:31 -0800 (PST)
Received: from twshared108583.15.frc2.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 10 Feb 2026 19:37:31 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 6AED477808CB; Tue, 10 Feb 2026 11:37:16 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 2/3] nvme-pci: cap queue creation to used queues
Date: Tue, 10 Feb 2026 11:37:14 -0800
Message-ID: <20260210193715.2543091-2-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210193715.2543091-1-kbusch@meta.com>
References: <20260210193715.2543091-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: X9yO290AiQd1f0HoScj0UCIeE8f4FVOA
X-Authority-Analysis: v=2.4 cv=Ta6bdBQh c=1 sm=1 tr=0 ts=698b88fb cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=hhPgRp7qUA8FP5TG6ioA:9
 a=ZXulRonScM0A:10
X-Proofpoint-GUID: X9yO290AiQd1f0HoScj0UCIeE8f4FVOA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEwMDE2MyBTYWx0ZWRfXw9mHcrMsFOIf
 xJC2VH2oMMtOy6QWGKlAPzLZFZMOM9UcyoOnGAmHnrucXW2E8FcxuW6EUmOakemPBCcYLkXzYBh
 ahVlCDHRbNJrXIV2pHd7QOdhj6Rcwx/cCA5arbcVS/AjxQgEHCja7YuVbadUGjFNQVqHFTDHVGy
 jYq2Ss/MRExGtV89rdTvubgrhjZKUf8uN5wjdf/paH4SHk4yArO6FzyIYyjuk8qLJRAghebC8RQ
 C0wLQcfEKo0qqeKCx6Lc9JwMrj2q6xAZ2r1ZFVb4KIde1VJRP+rEC57U05mHAl6hBo+DP+BNtlk
 5q8fCDpageq+0394a5SSkqU9AplkmfJXtYGRdr8nV32diatBG4wJIFZlIivuD1rom7WnqLhPs66
 S2AIIDNXBlthc/Kqjne0IN4XNQEeLIfN8eF9jbjBYdqiD3s4USSlFiTF5c0YGjG+9Dkcs/kUBLz
 H4dFJKm/0uHDyHG2qyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-10_03,2026-02-10_02,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260210_113732_794587_4A6647E5 
X-CRM114-Status: GOOD (  11.99  )
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

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a3e27305176f..f6d5c242fb689 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2775,7 +2775,8 @@ static int nvme_setup_io_queues(struct nvme_dev *de=
v)
 	dev->nr_write_queues =3D write_queues;
 	dev->nr_poll_queues =3D poll_queues;
=20
-	nr_io_queues =3D dev->nr_allocated_queues - 1;
+	nr_io_queues =3D min(nvme_max_io_queues(dev),
+			   dev->nr_allocated_queues - 1);
 	result =3D nvme_set_queue_count(&dev->ctrl, &nr_io_queues);
 	if (result < 0)
 		return result;
--=20
2.47.3


