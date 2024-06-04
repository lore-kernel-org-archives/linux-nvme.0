Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ACC7C41513
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 18:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=x37bdmFYTwI58S4flYaPguFmDJcUfvsGq/WYCRhcxZU=; b=18648eGRDgicxVqMQPk9Hc8ZFi
	UEtWBifixjp+DJ9XGy37lDeKJzE8Z6e+/P/cyCoZAiNFq+mSUzlxT6CZm8uaffbY/d3WpSrvwfN5t
	/l+bNlK9IGSY9bSfzIBbMoPylL142XDoSNUV7TbSUFHlAZuAFGReGgcsK94puSEq/uF71Ry3djy/D
	jwF0GNoBx3Vm6Ap/ArFBHgkvhw41IYD4238lHtpCWpJZjFVMCGXuF84vS+ligPpPzP7EI/0D2BDQx
	O3xQBeZzj/43jVGUIYZQXBTtFNQckbQKcEmjILlF5AIrmzbKLfCxnZOc62JJZHApwcdqmf6YpoP6T
	Tt7h3Wuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEZNi-00000003W0G-0BGW;
	Tue, 04 Jun 2024 18:59:38 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEZNf-00000003Vya-1OPb
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 18:59:36 +0000
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454Hmiu8020979
	for <linux-nvme@lists.infradead.org>; Tue, 4 Jun 2024 11:59:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=s2048-2021-q4;
 bh=x37bdmFYTwI58S4flYaPguFmDJcUfvsGq/WYCRhcxZU=;
 b=P7ZEDnOuCzfDXeOHbZb7tgXR9rIJXC1FKtm8OVDNO9lcnTK7uiGhN769+J0x0RfQdH5C
 uNv+V/ZhQZgutKBGWbhy2iat54hJ9Z5dUfV7mjCesmPFZwcjV67gmELOS42RkpHf62fI
 kdfJfOvhsRUyUWx9NePh9qRlsR//jLlonTu3svb+2DD8YFxk/YBpF9K9ijVTzcMK5D8e
 aOlHk09GlTPpS2YZH8qMxeLSfO87Kj82dGpTlc91TcrtZMHkK9IQQski23Ux+QfDvQPq
 L8MkL7KkBA0dPQ41mY1Al/AvtJwXjIMbBZRhWXdtlq8EMVpRGGySaMozM8xbGxx/ffa/ ww== 
Received: from mail.thefacebook.com ([163.114.134.2])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3yhq0xxbr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 04 Jun 2024 11:59:31 -0700
Received: from twshared24816.07.ash9.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 4 Jun 2024 18:59:30 +0000
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id 0944D35076C9; Tue,  4 Jun 2024 11:59:26 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <mlombard@redhat.com>, <hare@suse.de>,
        <shinichiro.kawasaki@wdc.com>, <james.smart@broadcom.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 0/5] nvme: fix initialization memleak 
Date: Tue, 4 Jun 2024 11:59:03 -0700
Message-ID: <20240604185908.3703052-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: qn277RqFghULBkjeQ2MVgN_7aCFOAKaT
X-Proofpoint-ORIG-GUID: qn277RqFghULBkjeQ2MVgN_7aCFOAKaT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_02,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_115935_475643_975F367D 
X-CRM114-Status: GOOD (  10.63  )
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

I ran more of the blktests on loop in addtion to pci, also did more
error injection at various points around the early initialization to
make sure the kmemleak really is gone.

Changes since v1:

  Use ERR_CAST() as appropriate (Christoph, Hannes)

  Fix apple cleanup error (me)

Keith Busch (5):
  nvme: apple: fix device reference counting
  nvme: tcp: split controller bringup handling
  nvme: rdma: split controller bringup handling
  nvme: fc: split controller bringup handling
  nvme: split device add from initialzation

 drivers/nvme/host/apple.c  | 32 +++++++++++++++++----
 drivers/nvme/host/core.c   | 58 +++++++++++++++++++++++---------------
 drivers/nvme/host/fc.c     | 48 ++++++++++++++++++++-----------
 drivers/nvme/host/nvme.h   |  1 +
 drivers/nvme/host/pci.c    |  5 ++++
 drivers/nvme/host/rdma.c   | 33 +++++++++++++++++-----
 drivers/nvme/host/tcp.c    | 30 ++++++++++++++++----
 drivers/nvme/target/loop.c |  5 ++++
 8 files changed, 155 insertions(+), 57 deletions(-)

--=20
2.43.0


