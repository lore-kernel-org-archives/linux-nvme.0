Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17AB9D3176B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Nov 2024 17:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gBYtu4iohoYYsLdFwePfNf6aEC2dUqXBTyOhvSosefs=; b=HBdCs1LSrf262dVg35hfh+5sTF
	h+FzyUkPOIh9YVjbi/fQAdzICAHOp/d9fPupnKZczfnhzjvwhMAlPJeJEw7dfHc7cbcfuQljVnhAU
	mx+dIQckmHrn9mD24fSGcHT9ZU7i1CWOr/OL4FVqz6aa3ixZhHOKWC+SjOFPAbq5pFZCKpo/CS3z5
	eVMskoqdLvj/8PrtHStINw/IuuiUAhBuKNru/qAGf7DvLduoNGNedKTjvI65MVFmpR/OCGMckVhTc
	sAIdycSvWTZmNZ7wGJq6xZ2OzKvTgrN5Azjwe39gjfJs0E5YOBPgMiu6DyIVQlL0PKpD1+MvSyGjF
	ClI8rZAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ng6-00000000GdN-2xsU;
	Tue, 05 Nov 2024 17:49:18 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t8Ng2-00000000GbQ-22gV
	for linux-nvme@lists.infradead.org;
	Tue, 05 Nov 2024 17:49:17 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5HLCZR021443
	for <linux-nvme@lists.infradead.org>; Tue, 5 Nov 2024 09:49:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2021-q4; bh=gBYtu4iohoYYsLdFwe
	PfNf6aEC2dUqXBTyOhvSosefs=; b=g/iPrOmt+Zy5rnlATCIRmrYN13Ks7J6/Ak
	7fs19842zl39XcUOzvFuTbVhNr0B259F84IwvJWhWfWAs7XW7MbH5um2VQywMYez
	SRrm6c+jXPMlcaxSSe+XjNXOq7kA1MDDLdm5a8w04cIoymT0zShNl+OdHKAT2RV1
	8j1Z31l/n3CzcH7cx2o+X0oBd1DUGB/Jzru/EHESsiEBPmIfzBSzUEsJpATz3NHy
	jFg2y4fKQd3FYFTtVu+388rlu0ZF/yfE/qUZ/7GCE/XCG8/iCIEjl2UbEfyO8KW6
	2K0yEHRfJXAm6j60yqYLcQJ+y4T2GUrVQaz4l97GmL1fmb1kLKWQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 42qhedjtjn-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 05 Nov 2024 09:49:11 -0800 (PST)
Received: from twshared29075.03.ash8.facebook.com (2620:10d:c085:108::150d) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 5 Nov 2024 17:49:10 +0000
Received: by devbig638.nha1.facebook.com (Postfix, from userid 544533)
	id 6DAB314CB3BCC; Tue,  5 Nov 2024 09:49:05 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <m@bjorling.me>, <matias.bjorling@wdc.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv3 00/11] Rotational storage support
Date: Tue, 5 Nov 2024 09:48:53 -0800
Message-ID: <20241105174904.3612888-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
X-Proofpoint-ORIG-GUID: jQxDNgnZCIOKpEpHARhLpmy46B8mTum9
X-Proofpoint-GUID: jQxDNgnZCIOKpEpHARhLpmy46B8mTum9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-05_02,2024-10-04_01,2024-09-30_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241105_094914_924648_067C0F2A 
X-CRM114-Status: UNSURE (   9.82  )
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

The first part gets nvme-target up to 2.1 specification requirements.
There were a few identifiactions, logs and a property that nvm e2.1
requires.

The patch from Matias attempts to query the command set independent
identify, but this version has changed to do that only if the
controller's reported nvme version is 2.0 or greater.

Keith Busch (9):
  nvmet: implement id ns for nvm command set
  nvmet: implement active command set ns list
  nvmet: implement supported log pages
  nvmet: implement supported features log
  nvmet: implement crto property
  nvmet: declare 2.1 version compliance
  nvmet: implement endurance grous
  nvmet: implement rotational media information log
  nvmet: support for csi identify ns

Matias Bj=C3=B8rling (2):
  nvme: make independent ns identify default
  nvme: add rotational support

 drivers/nvme/host/core.c          |  14 +-
 drivers/nvme/target/admin-cmd.c   | 240 +++++++++++++++++++++++++++++-
 drivers/nvme/target/fabrics-cmd.c |   3 +
 drivers/nvme/target/nvmet.h       |   2 +-
 include/linux/nvme.h              |  48 +++++-
 5 files changed, 295 insertions(+), 12 deletions(-)

--=20
2.43.5


