Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 292C4EE3698
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Feb 2026 16:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PxQ0e70vnSUSbMohMpI7hcnb9aSam05MsUbPfk0jPV0=; b=IPvuRDZP+AZmM9/A4ipw6mFD/X
	lBnEYB1VW+dkVLjbx+B1rX5EqoePann4gk02ipVbJ1Vx1sghUqfytizFTXKhDEYb2ukdzXSnVTDqQ
	BGPU/h7o7vpqpzA4xXnFLsMusrltZ2uy60/1Om+rp9qdrG7XCQUGDJMUwygA2VMg8mBYzfcdLpdEc
	EVvyc0nAXErpQ9tS1sawmDaqwmaU3Lc2OTzxl8kuaq88eSp+mK7QuGAK1AjMf4Klyqzrbu0Nnzd/L
	BS6RyyRJTDe6dv/QlKntAWjjdqGmWBYf9qpedQ87Q0qqYvu9w0bqf80tPUrSZZ/9N4xquRpfxIVWp
	BFx6ebQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqZr9-00000002Nzn-1zaQ;
	Thu, 12 Feb 2026 16:47:55 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vqZr6-00000002Nxq-1NaI
	for linux-nvme@lists.infradead.org;
	Thu, 12 Feb 2026 16:47:53 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61CAdmMK3388110
	for <linux-nvme@lists.infradead.org>; Thu, 12 Feb 2026 08:47:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=PxQ0e70vnSUSbMohMp
	I7hcnb9aSam05MsUbPfk0jPV0=; b=vm1mkBgqnIXh8wbKLFkZOPYX8BBvqKrp/w
	Kr/APZ27i2ya/sYwL6AdTmeXoGAezlKZwqDJZe7+YjwAMS3dNPT+Va1gWL40YOC5
	eyhP6CFXP+0FCjDLBm7C9n0yg+b2QdW27SBR1bUZja2coYlcYvjq95CoUq/DSKE4
	wib3sJJOiVFa2wFm0fHmpvNwDvVaBTkWnBTMEHbWhFALGGjpeMI+FTjB8bMpez8J
	t7DiYHBNcPjV6VvzJJNWLvtcgBgOWjT1z8CJ4Xby+zQ0l2mC0TckdlDuL2tLPbxd
	6orm+YWQUqRh9PPenpQcl3XrD8YHKNMB79ncCrgJ7CRnQzQESn/w==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c9da7khdn-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 12 Feb 2026 08:47:51 -0800 (PST)
Received: from twshared18017.01.snb2.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Thu, 12 Feb 2026 16:47:47 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 562827A6B553; Thu, 12 Feb 2026 08:47:35 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/3] nvme fix handling for user changed module params
Date: Thu, 12 Feb 2026 08:47:30 -0800
Message-ID: <20260212164733.3006071-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjEyMDEyOCBTYWx0ZWRfXyoBBg5KZaiT4
 rzbRLzvTjlBNirJ2aFErspCdMTb7Cypy2BX6JdOUdy6/bu2RypDV+SQ+N8AE3eqrvGoI4QpQQBF
 XOfG8gH9XA31pfaGoiIcYOKW3nSFQZjvsRfsiMFamsKv9CcXXgQJM7r/fvN8fbnA6wXa1tLfx7m
 8inOcutfcwRsGY7fpB7TjPBRvJA21GeTM66G4dOPQeDQPutr1Uy6Rg3FmPU8ESzGsq7SjTuj93i
 wYTzG+jpeWnMUjJyaU6XwWupl44Og54LxYZOCKVsLISZ2xDjCsEjV7zLr6xFe6nMOMvcJciyFIL
 kik4xMwR+NXpkRzBa4mLxzXmWMZkwVuyKW73/MWwj+6LoFgoTCtytX3dDDhzwMTaAGl70r7lQKd
 6pS21Nl47D594COdzPlWpwZqZpNMtFuEvPg3og8rlO7Vriii3JH8d2iCntmymyQCDdOTH+NxWJv
 tZZjjAi1RY9BefgfYkg==
X-Authority-Analysis: v=2.4 cv=ddmNHHXe c=1 sm=1 tr=0 ts=698e0437 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8 a=gfsp5Ub9jtGNbJHYgxwA:9
X-Proofpoint-ORIG-GUID: tzInRQpI0XM3b6koyX7QkC7DkNAFjqsK
X-Proofpoint-GUID: tzInRQpI0XM3b6koyX7QkC7DkNAFjqsK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-12_05,2026-02-12_03,2025-10-01_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260212_084752_431589_29E2EE50 
X-CRM114-Status: UNSURE (   7.64  )
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

Changes from v1:

 * Added some code comments to explain why the queue count calculation
   needs to happen this way

 * Replaced the switch with more compact 'if' checks

 * Added reviews

Keith Busch (3):
  nvme-pci: ensure we're polling a polled queue
  nvme-pci: cap queue creation to used queues
  nvme-pci: do not try to add queue maps at runtime

 drivers/nvme/host/pci.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

--=20
2.47.3


