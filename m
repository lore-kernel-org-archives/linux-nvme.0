Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D83DC433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 17:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NdMRQ2rIiAM3qaQcX7l2HneV50gkEOQ321ZBQPWUF1E=; b=3spCug6fJme/nodnrRhySLjXES
	gK7yYc2X/zSjWyx8HtUoJq1oPwo/icJWuP+wCYa2H44qrzukC6McKtO6CL6+3LtvvS1EUSwBmX/Id
	NrSgy7cl7j4Bq6WanfjjdkId2Jo/6wKLhGUCLRmUV64iZaGkcGAxZJUb8I8qyIPTfHu72RWeNs9p4
	yRHOv83qAC6i+VVvDv+lvvVpGUelqI/1N5sHFRWNzYoKfgoWupiuR2vx3r7nrzDnBu0lJHG9fw9gP
	MiUJAIvU62d+8MF5EipkLHpxtyjWuPQPEjTRySOVKBnaYNwDbSxyM1OHwFst/+1X4jRieoI0DGa1d
	LHKMnsuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8mFx-001psO-5X; Tue, 05 Jul 2022 17:22:37 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8mFu-001pnq-2N
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 17:22:35 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 265H9cip008288
	for <linux-nvme@lists.infradead.org>; Tue, 5 Jul 2022 10:22:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=facebook; bh=NdMRQ2rIiAM3qaQcX7l2HneV50gkEOQ321ZBQPWUF1E=;
 b=cCh1nyjrIFtjdmMPyJPsSBzirX+4E459eY7BVf7X6Sb9Jcnqm/LcXbTohAbWlLTzolz6
 oa8fqqMpogsnxtxHiSweFPb/2AMddrVKlHFg5T3yQXibNRT+xAo8Oc8tAV8wfbZnJ3+g
 YVOAbFDqUH5rpceGoV9b5wPXWWxY1Pf5umQ= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by m0001303.ppops.net (PPS) with ESMTPS id 3h2hpvsaxy-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 05 Jul 2022 10:22:29 -0700
Received: from twshared25107.07.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 5 Jul 2022 10:22:28 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id AC8CD5C2BEA2; Tue,  5 Jul 2022 10:22:25 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>, Chris Egolf <cegolf@ugholf.net>
Subject: [PATCH] nvme-pci: phison e16 has bogus namespace ids
Date: Tue, 5 Jul 2022 10:21:02 -0700
Message-ID: <20220705172102.3522189-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: J8IHez6Oul5MXEONQf9kFOsBZte7c8sw
X-Proofpoint-ORIG-GUID: J8IHez6Oul5MXEONQf9kFOsBZte7c8sw
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-05_14,2022-06-28_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_102234_250514_2D94B981 
X-CRM114-Status: GOOD (  15.01  )
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

Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D216049
Reported-by: Chris Egolf <cegolf@ugholf.net>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e7af2234e53b..193b44755662 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3465,7 +3465,8 @@ static const struct pci_device_id nvme_id_table[] =3D=
 {
 	{ PCI_DEVICE(0x1987, 0x5012),	/* Phison E12 */
 		.driver_data =3D NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
-		.driver_data =3D NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+		.driver_data =3D NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1b4b, 0x1092),	/* Lexar 256 GB SSD */
 		.driver_data =3D NVME_QUIRK_NO_NS_DESC_LIST |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
--=20
2.30.2


