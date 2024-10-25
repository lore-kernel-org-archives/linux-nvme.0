Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41E5D149F5
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 21:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QDSowptOyZLvK9oAHCxfP0iFBCixlqbp/+dl8U+g3G0=; b=TMPVqJfyWnKatvrMEtbo9hZ9fu
	h5D7x9Z19RC8qefM0t+p72V61ztfmhPAtF1M0jdmNgMIWD5gLOEbEZfcDVHupZ2kUUNenEJGdkM+X
	q3c8xih9lwSYpIISSKw4E26vqs56v71mwAnPAbaxbqFgbAeYCereneEg3KAymezHcknPEKuSGUAWr
	x5kG7x8JMwNVXbouI0jTrI8jRLUm+GXvsfx/PD4zd53FOCE4R27+wsztngAZNXHXei/SiCkJwb83M
	JvFr98MNzHtBF6jzxydeTj/FZqn0VMdLaFxWEjo75kAB/VsFVECViZ9OqQQRLLnoO9AlFFmw/Fijx
	cwLQZlzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4S2J-00000005KrV-3NqQ;
	Fri, 25 Oct 2024 21:39:59 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4S29-00000005KmG-1VwJ
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 21:39:51 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PKXQUQ014215
	for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 14:39:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=QDSowptOyZLvK9oAHCxfP0iFBCixlqbp/+dl8U+g3G0=; b=mQ1IgskGRUZF
	aHWIeAvxdctEjZ1ozlJxEG/DMeww3ySl+lsIJ/kdShKTO5W63NGWopSwifiIeuLr
	NjMrYPvALK8GNbcTbZnWtwsAxHqOQ8nYuub97UWRdkCxKAjOEkAfLrt1yCY4m10J
	kotD3iBXuL5/I5kA71zbLcMmVicPJ7cCfBg6tJsvvNFJpBQzpbX4ipirCOjJdCoc
	r7PbUdHzE14HEc2/mmhOBWFzIa0YRTnLRDKX+CR/L13/CtXR6FvbYlq3leSgdFxI
	7SRXa09EVoqgafM6OLC6aIf+2evSaRsXITQHTFDxJ+G2Uyh2VlRpQp4TZnfQehY1
	4xHhFHwbkQ==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42g657wbjc-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 25 Oct 2024 14:39:48 -0700 (PDT)
Received: from twshared10900.35.frc1.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Fri, 25 Oct 2024 21:39:46 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id B3E041476D744; Fri, 25 Oct 2024 14:37:06 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv9 7/7] scsi: set permanent stream count in block limits
Date: Fri, 25 Oct 2024 14:36:45 -0700
Message-ID: <20241025213645.3464331-8-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241025213645.3464331-1-kbusch@meta.com>
References: <20241025213645.3464331-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: kgwZSTR-Svz1bzONUI-smgURYwrY2gt9
X-Proofpoint-ORIG-GUID: kgwZSTR-Svz1bzONUI-smgURYwrY2gt9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_143949_448738_735C791F 
X-CRM114-Status: GOOD (  12.10  )
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


