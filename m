Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84CDFC4167D
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Nov 2023 18:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=odnZPto2VpQTjSlzW8QIGWMZGMtfKkdfykXo55I89hs=; b=pISVHkZs+aZJd64m7/J50srkcw
	Sk/LVUbDKP/7I3ODanCyJLDYM0RzIkKyDzgzVjCHXWAGwTN7HW6/AGS5fbzO7vIq//E56IZZN5/1v
	b6GlStZu6qlnHBZzioMybaPOb4w80rKw3yZtKxYR60p5iibVZv5eKdnIXVLEDEW4QMGHWEV+f3WVA
	A23ziCoOW4UpBC/7cMr3gQ1H8X+dl6ZfePVWB7QumqYGFgiFUYQKBfVHjE0ulhDJc9OiMe0owCQE8
	t0CeTuK0LWVSMPGSVbP8aWVaepnhZPhEff7zR9Zz6SiWOcC+/H2Z+Z5qfqAtR8yszn9cLp69O0i/0
	hiTP+mDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0QbP-002AZf-10;
	Tue, 07 Nov 2023 18:15:03 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0QbK-002AZ0-1U
	for linux-nvme@lists.infradead.org;
	Tue, 07 Nov 2023 18:15:00 +0000
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3A7FwrSZ031936
	for <linux-nvme@lists.infradead.org>; Tue, 7 Nov 2023 10:14:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=odnZPto2VpQTjSlzW8QIGWMZGMtfKkdfykXo55I89hs=;
 b=erJiTR1gL1J3XdBhqSNVbQHlyF/xojqXpKvF9lPMQ3f7vkylxb4pESS+Hs3k8oQR5DeV
 UGP1VQJXHTP3FaBB4O8/PhXAsiJoUB/fEFnS4B+L9DxV8mbu+wJMN+ilMNfgzPSZ+Pth
 gJqYq6cncyYz/hmKsRLNJunvtCp7t/gRykBbov6Cjaf7SdGtgSuXPACb73NGAnmL/1R0
 08cXVPCJk4RbWoGprzVysI7Hr9ldxcaoq9yNEi+5QEq2+NwfENCggnEe/ONpUNc9oq/7
 0d8jxIhHFSkZ5IYMIXIEhgLTIm3B7GyeW23SbB/BY/2CcAjJ4fAwEgw2Zqc4pMEA7WT7 IA== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3u7pvej388-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 07 Nov 2023 10:14:56 -0800
Received: from twshared4634.37.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 10:14:52 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 4360E215360B8; Tue,  7 Nov 2023 10:14:42 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <hare@suse.de>, <rnd@arndb.de>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv5 0/2] nvme: fixup module compilation
Date: Tue, 7 Nov 2023 10:14:19 -0800
Message-ID: <20231107181421.593353-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: D3wvPOZYh1vlwxk10jJw2IMvawUCJFql
X-Proofpoint-GUID: D3wvPOZYh1vlwxk10jJw2IMvawUCJFql
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-07_10,2023-11-07_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231107_101458_767757_B7E8559C 
X-CRM114-Status: GOOD (  13.70  )
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

Trying to sort this out before rc1, here's my take on bringing this
together after reading through the history on it.

Changes from previous version:

I updated patch one's keyring stub check to use IS_ENABLED rather than
ifdef. The patch makes CONFIG_NVME_SYMBOL possible to be a module now,
so ifdef doesn't work correctly with that.

For patch 2, I removed all the Kconfig stuff from the previous,
otherwise it's the same. nvme-keyring will not be built-in unless a
dependency is also built-in, otherwise it will be a module if another
module depends on it.

Arnd Bergmann (1):
  nvme: common: make keyring and auth separate modules

Hannes Reinecke (1):
  nvme: keyring: fix conditional compilation

 drivers/nvme/Makefile         |  2 +-
 drivers/nvme/common/Kconfig   |  7 ++-----
 drivers/nvme/common/Makefile  |  7 ++++---
 drivers/nvme/common/keyring.c | 11 +++++++----
 drivers/nvme/host/Kconfig     |  2 --
 drivers/nvme/host/core.c      |  9 +--------
 drivers/nvme/target/Kconfig   |  2 --
 include/linux/nvme-keyring.h  | 10 +---------
 8 files changed, 16 insertions(+), 34 deletions(-)

--=20
2.34.1


