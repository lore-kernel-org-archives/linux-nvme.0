Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10966D64084
	for <linux-nvme@archiver.kernel.org>; Fri,  8 Nov 2024 20:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lpkw70ScsQg5oJhrDT3X/i9ncqvY2EB0/2EmfsOYbl0=; b=phItfKHnp2qOF11mlMudBlKTWF
	KVJV8PIM0O3WFwjSsv0kzNRRCRHU3wYFCV2+SOKzCSagW0tEgesx4NWATDXdwmvNPET5UNj3AtERC
	gZ+nMEZ2vCH0zQKydL12Mm8710h9hkVymOarEN2WsI5NEtTRZ4B5n0Z+pHwKxjJVn1LYRTrDD/Hl5
	rH+k+1RLwSswGSAqfc5VjWfLd44Zz4FDFFeWHmo2MT+AXUec6x5FJ2jswHo8WJ0LeVxnyQh64jexp
	udzIhF+CTkIqOhMfPbPiUVIW4ChE5t2dphU2nbl1IW7ruk2OLk2mKGsPXfnyqWpSRAvnizMAY/1RC
	8EmiD/Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t9VPS-0000000BrIN-3NdS;
	Fri, 08 Nov 2024 20:16:46 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t9VNi-0000000Br85-3PaM
	for linux-nvme@lists.infradead.org;
	Fri, 08 Nov 2024 20:15:00 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8HPdTD007943
	for <linux-nvme@lists.infradead.org>; Fri, 8 Nov 2024 12:14:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=lpkw70ScsQg5oJhrDT3X/i9ncqvY2EB0/2EmfsOYbl0=; b=YP55LyVUy/2Q
	clyzZsbYT5yOjjMmvDEiAXeeH96fXIdFbnPvlCWjM3JmcLVzzPQkIFS4Aq56tatm
	dk/9dsbGAb+JVDyLAI+US1HXeowUx7o5WV0VFpgjhNDypB473nore8fTTvkwjEOn
	a+/c3w6kWsDgVXFUaR+mm5u2ZcuUTfQ+Sep1yaGveOcIkEs/FLTMRjHkNiAAuORd
	RxuS2iPX+9PxFR0B2b/b7VFKFeNhM+scPXVDbAIKZi068Isnby0WjTIS65VPyLsc
	lHD3XieL6JUfECjfXEhu9+t+/4OjyVemqGDAuRtCrcIN9sXYkDAquLimMnRlU1v+
	/WkiuRnWuA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42sn4ua7xy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 08 Nov 2024 12:14:57 -0800 (PST)
Received: from twshared8596.05.ash9.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 8 Nov 2024 20:14:56 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id D0BFA14E3A041; Fri,  8 Nov 2024 11:36:58 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <axboe@kernel.dk>
CC: <hch@lst.de>, <martin.petersen@oracle.com>, <asml.silence@gmail.com>,
        <javier.gonz@samsung.com>, <joshi.k@samsung.com>,
        Keith Busch
	<kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke
	<hare@suse.de>
Subject: [PATCHv11 9/9] scsi: set permanent stream count in block limits
Date: Fri, 8 Nov 2024 11:36:29 -0800
Message-ID: <20241108193629.3817619-10-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241108193629.3817619-1-kbusch@meta.com>
References: <20241108193629.3817619-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: I9drFlMDe-B8Ehljgp8YGuS_iBM5w68Y
X-Proofpoint-GUID: I9drFlMDe-B8Ehljgp8YGuS_iBM5w68Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241108_121458_888384_EDFDFB2C 
X-CRM114-Status: GOOD (  11.41  )
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

The block limits exports the number of write hints, so set this limit if
the device reports support for the lifetime hints. Not only does this
inform the user of which hints are possible, it also allows scsi devices
supporting the feature to utilize the full range through raw block
device direct-io.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/scsi/sd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index ca4bc0ac76adc..235dd6e5b6688 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3768,6 +3768,8 @@ static int sd_revalidate_disk(struct gendisk *disk)
 		sd_config_protection(sdkp, &lim);
 	}
=20
+	lim.max_write_hints =3D sdkp->permanent_stream_count;
+
 	/*
 	 * We now have all cache related info, determine how we deal
 	 * with flush requests.
--=20
2.43.5


