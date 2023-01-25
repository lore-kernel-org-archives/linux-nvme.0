Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96A9C27C76
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jan 2023 18:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lrh//RPvydsX1bRBxRNoeW4zoqAsrYy92Dn11o6euLA=; b=CvTJnvnlPseFpfjcJkHbr5VF7p
	OBpj8bVz6B7xOJvoRdSMReuHpXdxlkTLbonWH0CbIgd073yQhF0zYTRummJOTHnnNuzE2/bH7DeJb
	Mj/KbmGTnxGCg1B1rtvrhjgw6j0Hw7kT0OmGu/Y640HU1C7Ossuco4n49G49FVqk1u+FG802x0SFN
	lG82D24dkP/E87fzjMG9OH7ACC6zaUESwZPGQkwY+dv+QuFcMwxtWQgzBqZRJQbyj1kBHpa0MzA46
	8gqe86+zzsymGyE7bM4VIef92XJrDakQ1ji9hBLM/MI8FlJRJvbaKrdNjdCvbIg3NyRM3Y3Bknuew
	+7/DwbaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKkFF-008IaS-H2; Wed, 25 Jan 2023 18:11:37 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pKkFD-008IZV-E1
	for linux-nvme@lists.infradead.org; Wed, 25 Jan 2023 18:11:36 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30PAGjBm012851
	for <linux-nvme@lists.infradead.org>; Wed, 25 Jan 2023 10:11:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=lrh//RPvydsX1bRBxRNoeW4zoqAsrYy92Dn11o6euLA=;
 b=ic7L0R7YaBQbAygEaPmv1cvdOoX4/aZZI4zZQIp0M3+ZgMATY+YyuVrderSblaBff8J0
 VvGpCgoyrJkMemJMSC65ETY8J4ral0a3iP8CQHCB/cMIygEH+Zw5z8mo977M3QYKTgKB
 0zQgws0vK50LTumYS0Zo6/8gah7PeX4KDqjcPkdI9IgV/EzMYTafh5YbeCH/m6zfQweG
 newrY+h0awXB+mTgG4PX6izBzleLhYfwsR2VxfJHSyvzbK9Jark+r+Yh3mGB1P0D6j26
 /9WA3GxnIimg+HuBt914NE1e1lpiEnoRhAHyzIwuuhWGXIDRhS64yVzFs4w/GtJKDpuL qw== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3nahtaywav-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 25 Jan 2023 10:11:32 -0800
Received: from twshared11232.07.ash9.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 25 Jan 2023 10:11:31 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id C5C53FD0E99C; Wed, 25 Jan 2023 10:11:26 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@list.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv3 0/2] nvme effects handling updates
Date: Wed, 25 Jan 2023 10:11:22 -0800
Message-ID: <20230125181124.395668-1-kbusch@meta.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: vRa9T2IqenyEhzRfn10_FgBhgmiXYQSQ
X-Proofpoint-ORIG-GUID: vRa9T2IqenyEhzRfn10_FgBhgmiXYQSQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-25_11,2023-01-25_01,2022-06-22_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230125_101135_550045_F949F422 
X-CRM114-Status: GOOD (  11.88  )
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

Version 3 fixes the memory leak from not including the default log page
in the tracked xarray.

I've included the Send Receive filtering patch in this series now since
it depends on the first patch.

This series also depends on nvme-6.2 branch that includes the recent
commit "nvme: fix passthrough csi check".

Keith Busch (2):
  nvme: always initialize known command effects
  nvme: mask CSE effects for security receive

 drivers/nvme/host/core.c | 101 ++++++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 39 deletions(-)

--=20
2.30.2


