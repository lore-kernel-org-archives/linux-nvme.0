Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A403D31769
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t2gIRaORogavENzGLn7iStmG7HBf9hEFZ55FL7D5d34=; b=0t4UxBNaTgv6l7ESUSiACZTK40
	yZIZ631nEb6J1RGwB5g+pZamOMk14PbbSzyczZYz0xmCIkjCgbb94Tm9wvoMSBTwoherK4wAvB+SY
	cH2sM8wQMCFhG3628GwyPprvCbXF6vry0RJ4V2u/w6BfpXD1/Hh9XS6Gnj5XkkzEzgRyrVkqrKLTc
	KermiFf0f9gYF5coyy7GT+UBv4Ll1Wig9hXZSGvORZolTkXYVWMpgxXfVSa1FgNFN08r7XhCD7OHf
	TbL7NuG34Q+g4EUONA6wE1jMAQ+fyE5ipSCDwGk+cpqHMaxgfdOXIgNLImIrB4Dr5KwqViL9I147i
	hCH5gTcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8NgG-00000000Gkv-2ipI;
	Tue, 05 Nov 2024 17:49:28 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8NgB-00000000Gfg-0YDl
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 17:49:24 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5HL4PX024348
	for <linux-nvme@lists.infradead.org>; Tue, 5 Nov 2024 09:49:22 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2021-q4;
	 bh=t2gIRaORogavENzGLn7iStmG7HBf9hEFZ55FL7D5d34=; b=S0HtNqd8cKXD
	jnfbDrTXCIWBaBTGYQb6MgsvcJbyoGB7jkJ8l2arrNi3dyeIYyDzKWdpH+ckM0jm
	SOFHEraeczahgZpS3t47i+a6thtm40LCAs2HQmouhrjuP8K5Tlu2Zv3Buc/tNiOF
	Kxq0Eusdxxv4KizFjah8zMmEA21gGkyivISbvpnMMdn1oVEU8h+aCKSPF89l3Y3J
	3+3fMay+d35Ni/ktVTtb1tID0CNyRE5ppCZSvwnDfL5ENN1JPmpPtiv/M6k24b9N
	QlNeOMgXTmcQcMMVzqVRklFYb/DmLk7S2X466VD7B/768G+DxlPobO4kJ8jBoW0K
	YxxDCFV35w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42qpxf0pt6-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 09:49:22 -0800 (PST)
Received: from 7be2-ac94-0300-0000.twshared25495.03.ash8.tw.fbinfra.net
 (2620:10d:c085:208::7cb7) by mail.thefacebook.com (2620:10d:c08b:78::2ac9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1544.11; Tue, 5 Nov
 2024 17:49:19 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 3B81514CB3BE0; Tue,  5 Nov 2024 09:49:06 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv3 05/11] nvmet: implement crto property
Date: Tue, 5 Nov 2024 09:48:58 -0800
Message-ID: <20241105174904.3612888-6-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241105174904.3612888-1-kbusch@meta.com>
References: <20241105174904.3612888-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: Te-67rmwLgRCTomyF2TU9qKQchLexsvg
X-Proofpoint-ORIG-GUID: Te-67rmwLgRCTomyF2TU9qKQchLexsvg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_094923_414136_D7EC86BD 
X-CRM114-Status: UNSURE (   9.33  )
X-CRM114-Notice: Please train this message.
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

This property is required for nvme 2.1. The target only supports ready
with media, so this is just the same value as CAP.TO.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/target/fabrics-cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabr=
ics-cmd.c
index c4b2eddd5666a..bb80db6a7950b 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -64,6 +64,9 @@ static void nvmet_execute_prop_get(struct nvmet_req *re=
q)
 		case NVME_REG_CSTS:
 			val =3D ctrl->csts;
 			break;
+		case NVME_REG_CRTO:
+			val =3D NVME_CAP_TIMEOUT(ctrl->csts);
+			break;
 		default:
 			status =3D NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 			break;
--=20
2.43.5


