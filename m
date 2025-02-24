Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08542C021BC
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 18:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0ta19Dj6+rytdgEwvSPxNh+ENre+OCuMKQDHtfcHyLE=; b=cvgwCKFdswz37GeKmuzVg4rPNZ
	z+GkZ8ahAPAQKJyyMFx3wmqT9EKUlkM8zA3Y/XVsqBT7h5orOAJmJqCeCEUaF1TJxcFApgKz9oS19
	ba7NA++aimjerI0UZtuoYMXYAjU5edzxKb9FjCdzLydNtcMUwvcKQpJI2ECtLC66H9ncT0RXdAbjG
	Zs9xc+BuU98coVfQ+wVkT1cEJHcZd05gzycxEm6aybWE0q39Rxf4QO5FRjny++csgN5sFN5T6jE2T
	dXpWLFbF4H0Sl6+dlrSmxYcEDrArS4d1MNjZeI1YAV/syBRm4RGXsZMP9Gb4nTI+J11eF7sksYIk9
	l5B7f88g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmdFn-0000000Eolx-1Pwx;
	Mon, 24 Feb 2025 18:32:31 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmd5O-0000000Emf6-0h1A
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 18:21:47 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 51OFDOmb008781
	for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 10:21:45 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=0ta19Dj6+rytdgEwvS
	PxNh+ENre+OCuMKQDHtfcHyLE=; b=JrnmUirb/JxdfFLrShX2m01th8JGEuVKpI
	fvXoIYP6YqfJJ7pdVrnHicKcOEAUzN82wh8ydc/6gw1JL2XAjBndMEXrmJapJNfj
	I1nWhlZ19JFp4fSvZBVjUxJWavrndbloscfvndPSwZYPz6EiT3qrOg122BfLd4Do
	+F/gk0JUlMtU2/aifR2s7yEH7ax02iLn6SdmZ8xNzwuabWq/wYPohLij2LclIuDF
	PXp8R/q8Mb7p1HIPomzsbISRewgH6jhhR1RtJf7WHmRzow76fa1vrzVO1GCHqfy+
	XSK2FHKXdvzD3M8bI9CtQsaL82PjEmBU1y/QkHE+BEKwyHpCwLSg==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 450su1a9xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 24 Feb 2025 10:21:45 -0800 (PST)
Received: from twshared32179.32.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 24 Feb 2025 18:21:36 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 6A9E218678FB1; Mon, 24 Feb 2025 10:21:29 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 0/6] nvme ioctl cleanups
Date: Mon, 24 Feb 2025 10:21:22 -0800
Message-ID: <20250224182128.2042061-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: H_Q2j_Fm118Zv2AwWPqfCbeGqeXB29TQ
X-Proofpoint-GUID: H_Q2j_Fm118Zv2AwWPqfCbeGqeXB29TQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_09,2025-02-24_02,2024-11-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_102146_321460_C6A2A809 
X-CRM114-Status: UNSURE (   6.21  )
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

Various non-functional changes in the nvme ioctl code organaization.

Keith Busch (6):
  nvme-ioctl: fold open_for_write into flags
  nvme-ioctl: use common type for user data addresses
  nvme-ioctl: fold 'vec' into flags
  nvme-ioctl: common user timeout setting
  nvme-ioctl: combine alloc and map
  nvme-ioctl: simplify parameters

 drivers/nvme/host/ioctl.c | 243 ++++++++++++++++++++------------------
 1 file changed, 129 insertions(+), 114 deletions(-)

--=20
2.43.5


