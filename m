Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1EFCD3A66B
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Oct 2024 15:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lpkw70ScsQg5oJhrDT3X/i9ncqvY2EB0/2EmfsOYbl0=; b=n1HHFroBiXFlm5ZQOgY0FgQQF2
	AB0nyy/RMj/u4Hk2R0ymD5rurOdHqHGG5hdeNKukt8NjhmKuyzBk+qRR++A7Pn3fUBZZyibXKtMa3
	JZ0wCOcFhFHlSAQxBXyjAzG2k6YUmskJWCnps5liP4JFlW8y9QoKb/cO0oOD3YcxsxAvM3xCEyGR5
	3ST5UqmuOrNGrDeUTSKNqQwe20Xt4WmeY3eS3yWpQHB1AELSX3xsI3My9vR0/2AlFnEV3PI298xpm
	cMk0tlTWLAdgsGZPHdasm8qTUbQWpZolk1DVZwKYs//DnNDUw+3CLdr3Nwwm4n0vwzND3Fhzj+if9
	NcsnaxSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5o6P-0000000EutE-3zdW;
	Tue, 29 Oct 2024 15:25:49 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5o2s-0000000EtNW-0njA
	for linux-nvme@lists.infradead.org;
	Tue, 29 Oct 2024 15:22:11 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49T72saN018940
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 08:22:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=lpkw70ScsQg5oJhrDT3X/i9ncqvY2EB0/2EmfsOYbl0=; b=NI3Pdccrpn9s
	1KZ0FlPkPtyF6fvqqHi9EgyUKaFA/nqfW5x968ow82SiwbIF9969BnCCVrau2nK6
	XZYtgqbOPrTN90pI9k75IN5Yei8alA2JoKnOAXpjKPQDU2xuuvg+iJ6jHdE9rvv8
	e/PiHhXTtYFu1mamJfWKLQkWaaaDc4Trepge9GFgs8XlOzGGo+iPZLU1F5ujndHB
	BAFKif/TIPJgI+HGekz0415+pDngH6ux9B/esMXWJxWNkKtuyRWK3lg0AmyF1cId
	XYJ/M9LbFVRNUk7Q/MBPK9FmfSrUJXEDTrX7W0QYOAJT9wVdCtVFTD9nYpdhI3kO
	bNve1sBzPw==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42jtygtuba-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 29 Oct 2024 08:22:09 -0700 (PDT)
Received: from twshared12347.06.ash8.facebook.com (2620:10d:c0a8:fe::f072) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 29 Oct 2024 15:22:07 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 4346D14920EAF; Tue, 29 Oct 2024 08:19:44 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-scsi@vger.kernel.org>, <io-uring@vger.kernel.org>
CC: <linux-fsdevel@vger.kernel.org>, <hch@lst.de>, <joshi.k@samsung.com>,
        <javier.gonz@samsung.com>, <bvanassche@acm.org>,
        Keith Busch
	<kbusch@kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv10 9/9] scsi: set permanent stream count in block limits
Date: Tue, 29 Oct 2024 08:19:22 -0700
Message-ID: <20241029151922.459139-10-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241029151922.459139-1-kbusch@meta.com>
References: <20241029151922.459139-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: b7hBeMd3V2a6KBJisc5uwLJcCr1_8fAx
X-Proofpoint-ORIG-GUID: b7hBeMd3V2a6KBJisc5uwLJcCr1_8fAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241029_082210_269504_BF687DE5 
X-CRM114-Status: GOOD (  12.63  )
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


