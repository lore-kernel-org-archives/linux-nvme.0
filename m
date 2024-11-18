Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAD0D4923C
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Nov 2024 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CBSsuNRS93f0Akp93ACPcDhNi11p1TBwvpgcWbDDNJo=; b=jy1ywfmC6rsOZpA9lMpM7V1buG
	0wPnP9RflRXqxfd+7lxR0cBtR+sBcBNNRazY2yr/nDgABS6Rl0swxTP8XSg8/zwRq52XLeRdsFGdx
	hmJyh1n3G4oi4XJ/nb06FDNKrfX5AZ7s/W99VQSolGoDmWf7EBK4Eye+QWucmZcvjzjlmVuijYWUf
	TKa1IfIMKRbWn0eNakJ33qW9XGZtpF01NE6nnJrdJxc/EHEeGdmlXGxubXhqt+HGPHBwNjjPqYIdF
	3t1fTDst+rgKvLr7D3ppCBD5NBPqbzq1Zx1JKGDXBGlExNQHlnuOGBhGbNquhdXcLl2eGpydvunmw
	vpnr7sFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tD48d-00000009zLr-1osU;
	Mon, 18 Nov 2024 15:58:07 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tD48I-00000009zHi-1oRQ
	for linux-nvme@lists.infradead.org;
	Mon, 18 Nov 2024 15:57:47 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AIBFUxi012665
	for <linux-nvme@lists.infradead.org>; Mon, 18 Nov 2024 07:57:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=CBSsuNRS93f0Akp93A
	CPcDhNi11p1TBwvpgcWbDDNJo=; b=mYDidi6HC4nIDv/8dXhWHfzxTTPk8tSCSA
	ei6y7DXuM9U4jPfvObhf85ljF9Do/mw+6+cmd4uHfJLi+UUC8VUd/n7tpSuc8Lpb
	lbK3HJKVisnVVJHNAq9STc1sQl+Rdthkl201so4q3+bktnyUnJPmdfm9saDjI22g
	b4kdZclhZkNEDIiJ2Ag1LIcEG8/E5zbGZqBwyaXnUqWJY+1CwEst/JAccLpDK4rG
	WTy+z7QrhdQgHy1IdNmsCBiJ+N2VZbf8hxd8MYQHj7zjhxXNqYRf5sj3bc+29Rz6
	hQAiaycv/MJwxV1SUYR6eGQPdqngToIlZzuSkTeQQoe/CVkvwNpg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4304hx1jy4-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 18 Nov 2024 07:57:44 -0800 (PST)
Received: from twshared29075.03.ash8.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 18 Nov 2024 15:57:42 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id A0EE7152D625F; Mon, 18 Nov 2024 07:57:38 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/3] meta sgl and userspace protection
Date: Mon, 18 Nov 2024 07:57:35 -0800
Message-ID: <20241118155738.2737423-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: HgrVuqjzwUADgkZ2PQsv3VOMWqAFBz1w
X-Proofpoint-ORIG-GUID: HgrVuqjzwUADgkZ2PQsv3VOMWqAFBz1w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_03,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241118_075746_588727_61CBF735 
X-CRM114-Status: UNSURE (   8.57  )
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

Changes from v2:

  Added all the remaining sgl constants that the driver uses

  Made the meta sgl checks pci transport specific

  Fixed a coding mistake that was taking the sizeof the result of a
  sizeof

  Log a warning if the passthrough interface is used on devices that
  don't support sgl.

Keith Busch (3):
  nvme-pci: add support for sgl metadata
  nvme: define the remaining used sgls constants
  nvme-pci: use sgls for all user requests if possible

 drivers/nvme/host/ioctl.c       |  12 ++-
 drivers/nvme/host/nvme.h        |  10 ++-
 drivers/nvme/host/pci.c         | 147 ++++++++++++++++++++++++++++----
 drivers/nvme/host/rdma.c        |   4 +-
 drivers/nvme/target/admin-cmd.c |   7 +-
 include/linux/nvme.h            |   5 ++
 6 files changed, 161 insertions(+), 24 deletions(-)

--=20
2.43.5


