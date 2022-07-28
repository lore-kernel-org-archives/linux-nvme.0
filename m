Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8008AC04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 22:12:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uwtxTKOkFPwqH8Ynr5YybJlCRJVF92etqym8tqk7oxI=; b=ACsqGkjprUgN1sbhBgte/8E9pH
	vg0nhPwEmf6kxsO4+KWkVCa96Y0mCITHp5wDytdOL0SSbcQrkU8hdZ4SBhZf/7bJlfvBVLSJ4ZcXh
	ISfR3sx5g9CxMLuKsqrxlk2k9vUMr76/+YyZ8dWch6mEGkZsqo6GmDxaz5O6WjMWaOBrNGyLV/QtW
	XVdZBUJSqb2F/FRUO0dr9HEZaq5S0HsI3gx8K5x3ytP3pnZ2fbaAuxaxAcY4qpU5YkbwIWtVOJA+3
	CutYCvM1lAKGWal9WtZl3yYtpGb69fC5i1Y9wv867KwHso5TQZFEFhmvPJc89mAXh8HVjwAy7aPAA
	yiomttFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHBju-00FI6a-5g; Thu, 28 Jul 2022 22:12:18 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oHBjj-00FI29-An
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 22:12:10 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26SIE24i013421
	for <linux-nvme@lists.infradead.org>; Thu, 28 Jul 2022 15:12:02 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=facebook; bh=uwtxTKOkFPwqH8Ynr5YybJlCRJVF92etqym8tqk7oxI=;
 b=h9NBnxOgqw9AHsbGIkFgYs6FHFMB4R2exlVoQPdhC1ElnlozWpo0t5oOXlCVldZbOHYd
 VtQXdkBK7E771e9GMHJq1hrptLLpWO5VmrtCpTbo3YPNKLnJ/pmN/A/OW+QhlLtLR4KZ
 +g63enxP4Sz9pRFJ3nXPqRgJCWGV2ZER+Fg= 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hksat4m7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 28 Jul 2022 15:12:02 -0700
Received: from twshared5413.23.frc3.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 15:12:01 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 8C8D76B202A6; Thu, 28 Jul 2022 15:11:52 -0700 (PDT)
From: Keith Busch <kbusch@fb.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/5] nvme-pci: iod optimisations
Date: Thu, 28 Jul 2022 15:11:46 -0700
Message-ID: <20220728221152.538648-1-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SsI0CaLNqi5vP5U7zdhcvnzfnpVjZ5mg
X-Proofpoint-GUID: SsI0CaLNqi5vP5U7zdhcvnzfnpVjZ5mg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-07-28_06,2022-07-28_02,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_151207_513511_89AE97F0 
X-CRM114-Status: GOOD (  11.03  )
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

The series adjusts the struct nvme_iod fields for optimal sizing. The
end result on 64-bit arch removes 24 bytes, from 152 down to 128. We
typically allocate many thousands of these, and the cache aligned size
is a nice bonus.

Keith Busch (5):
  nvme-pci: remove nvme_queue from nvme_iod
  nvme-pci: iod's 'aborted' is a bool
  nvme-pci: iod npages fits in s8
  nvme-pci: iod nents fits in s8
  nvme-pci: move iod dma_len to better pack

 drivers/nvme/host/pci.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

--=20
2.30.2


