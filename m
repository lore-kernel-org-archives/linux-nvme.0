Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD7AC27C50
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Jun 2024 23:05:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yYx0VbClbikh0RrygVyb8XnaF3X2ip2nGiDqC8YAOwk=; b=fdBTwFfHiz4soV4ubLIgGW55m7
	4Mbqk32kWsw2V2916+BxMaEeGd7XDOnoOUhezItx5NMRqGgiZQ3dvDc9/bbyJLrm/eW8bWDVY1utf
	LUPvZxp5zHVmLP+4DY+zi0kDh3XPlzcSA/A2qBzxlfLIn+mfgIJLE2QY8CbOBAKnyEsyIpwS/7JW1
	R0trJErOpAujqSK5h2VfFE+0rgtC2uXdZLnqwJ0ZkEgpkxQUFwFxlYpemX4l/2gwhQ22+M4u5Bcy1
	K3AmM563ELmOrM0Yhor9l2CWygzNDXF8ZeCoevwfKtzeAsB7SxytbWvooy7TkdeCwP6x0x579H7TW
	A2uYc1sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEGkO-00000000a6d-3IpS;
	Mon, 03 Jun 2024 23:05:48 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEGkL-00000000a5V-1Ose
	for linux-nvme@lists.infradead.org;
	Mon, 03 Jun 2024 23:05:46 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453N1ktA027143
	for <linux-nvme@lists.infradead.org>; Mon, 3 Jun 2024 16:05:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=s2048-2021-q4;
 bh=yYx0VbClbikh0RrygVyb8XnaF3X2ip2nGiDqC8YAOwk=;
 b=Pw6Nnarb4ubRsaSjRbM6BWW6f8ILd+oq8i8yeEvqaDstqCd3hGefNy9Ss6VHCFcbT/rQ
 ipEbxEnsPeE9ZSflIBiAaW0twEokUiLRMxu1wF7fLmQeiMy4uIjfe0OtC6D/pKfg2SMd
 TmNQSbhbdwcOs19FdZ4lpejemeRFmyF//zijlsyfouhtf6/mkg4lWsKd5vG4I9juPBgx
 dsEQ1g+keDiOMdF0bgcL4l43kGLcUMzmtzly00wWR8lppnPkTVfEPZuWRYQ7S7d4Br78
 TjVwDPGjADVPtBSvZ9EEjQFqSs5sBcta1OeHIyPa3AQDLsDPrdnK8UH+5tEgfqa0Vp2t SQ== 
Received: from mail.thefacebook.com ([163.114.134.6])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yhq5180qe-9
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 03 Jun 2024 16:05:44 -0700
Received: from twshared10578.05.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Mon, 3 Jun 2024 23:05:29 +0000
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id D00E73481EB5; Mon,  3 Jun 2024 16:05:25 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <mlombard@redhat.com>, <hare@suse.de>,
        <shinichiro.kawasaki@wdc.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH-RFC 0/5] nvme: fix initialization memleak 
Date: Mon, 3 Jun 2024 16:05:18 -0700
Message-ID: <20240603230524.3854115-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: -7N-AdozLVKOnKgyk1as2ph-1KHYuydd
X-Proofpoint-ORIG-GUID: -7N-AdozLVKOnKgyk1as2ph-1KHYuydd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_17,2024-05-30_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240603_160545_517837_AFC4A24F 
X-CRM114-Status: GOOD (  10.57  )
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

The pci driver is the only one runtime tested. Everything else is
compile tested, except for apple.


Keith Busch (5):
  nvme: apple: fix device reference counting
  nvme: tcp: split controller bringup handling
  nvme: rdma: split controller bringup handling
  nvme: fc: split controller bringup handling
  nvme: split device add from initialzation

 drivers/nvme/host/apple.c  | 31 ++++++++++++++++----
 drivers/nvme/host/core.c   | 58 +++++++++++++++++++++++---------------
 drivers/nvme/host/fc.c     | 48 ++++++++++++++++++++-----------
 drivers/nvme/host/nvme.h   |  1 +
 drivers/nvme/host/pci.c    |  5 ++++
 drivers/nvme/host/rdma.c   | 33 +++++++++++++++++-----
 drivers/nvme/host/tcp.c    | 30 ++++++++++++++++----
 drivers/nvme/target/loop.c |  5 ++++
 8 files changed, 154 insertions(+), 57 deletions(-)

--=20
2.43.0


