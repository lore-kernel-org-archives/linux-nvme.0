Return-Path: <SRS0=tf27=LM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 970F6C48BDF
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 13:40:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FF0613B4
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Jun 2021 13:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FF0613B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=lyY8pgKZN7gr9DAyRg5CP+oVVD1IYEgKtcxo6xukAG4=; b=E663vVA1PxWMfj
	zBDJkiGkwEE08Q0lJwQlnyaARiIvCJcjz10adsATDFlT4Jc8WgFsInuNqGRyUAgY9TozImLQxwAYE
	atbkEHFkSS+5R3rf4HBquUSrdrjTNug/v8TGvvCdLyRPKln1lXyzYxgEdBZzgLWmmIURaA6dyGFjg
	IehEF+EAjaN+B/utGnJVNG97gyJqSeVqqbLYON8aV/0qgWMf9d/XJ/MNfiDb8hTxZdeyAxiepMUkQ
	jmHppW1OcYZBRDJ53XK5mFvLGtXAc0rEjERivcRFyryXTiNpODjP19Q6kflD2y8A7Ytqj4oQlJw89
	I4een2q/GA7QqUanIbpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1luEjV-00EKOv-Qk; Fri, 18 Jun 2021 13:40:29 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luEjU-00EKOU-Fq
 for linux-nvme@bombadil.infradead.org; Fri, 18 Jun 2021 13:40:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
 Date:Subject:CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=j+PhKepHP4SP1FQwiyIre2/W0WisiM6py1GVXX7azhs=; b=N3GaBPSjUjKPN12VDPv43vzlN0
 4lCpvzzSeFaKOy0TzMKbqe4B5qK5DKrIYiMTQ3QIy0Qn++fGB34ydJPIrOcB9xbD6yTJh0IRhVnwA
 EmqLXMmfRTcCYT1oPFeuiUmcGkXJTik3G7Vx2tk82gFwmWTXk5U16sghnE0bxovCriixmRJld9lYs
 1x2+15fVrVLtIkbZTbA9pOtTfXkgllmwoNwyxqZt7QQK/0oPmDiEXlKZxmitTreLWmZDQoRCg/cPU
 uUdold/6lcoAtWOUIJi8PsFUrsWLNoWGnTQ73b8it3nk3ABwpWzCeUNFLlw7nvPpmrYgdmsmrrYup
 J3yPbPmQ==;
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1luEjJ-009Ch4-Re
 for linux-nvme@lists.infradead.org; Fri, 18 Jun 2021 13:40:26 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15IDVMte011401; Fri, 18 Jun 2021 06:40:04 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0a-0016f401.pphosted.com with ESMTP id 398r7510dh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Fri, 18 Jun 2021 06:40:04 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Fri, 18 Jun 2021 06:40:03 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Fri, 18 Jun 2021 06:40:00 -0700
From: Prabhakar Kushwaha <pkushwaha@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
 <kbusch@kernel.org>, <axboe@fb.com>, <martin.belanger@dell.com>
CC: <aelior@marvell.com>, <okulkarni@marvell.com>, <pkushwaha@marvell.com>,
 <smalin@marvell.com>, <prabhakar.pkin@gmail.com>, <malin1024@gmail.com>
Subject: [PATCH] nvme-tcp: Use __dev_get_by_name instead dev_get_by_name for
 OPT_HOST_IFACE
Date: Fri, 18 Jun 2021 16:39:56 +0300
Message-ID: <20210618133956.10637-1-pkushwaha@marvell.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: cxNXVxglKskzl1H1NFWTO1kMfhL62krn
X-Proofpoint-GUID: cxNXVxglKskzl1H1NFWTO1kMfhL62krn
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-06-18_07:2021-06-18,
 2021-06-18 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210618_144025_057200_96E8C504 
X-CRM114-Status: GOOD (  10.68  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

dev_get_by_name() finds network device by name but it also increases
reference count.
Increasing the ref count,
If nvme-tcp queue is present and the network device driver is removed
before nvme_tcp, we will face the following continuous log:
  "kernel:unregister_netdevice: waiting for <eth> to become
  free. Usage count = 2"
And rmmod further halts. Similar case arises during reboot/shutdown
with nvme-tcp queue present and both never completes.

As a fix we will use __dev_get_by_name() which find network device by
name without increasing any reference counter.

Signed-off-by: Omkar Kulkarni <okulkarni@marvell.com>
Signed-off-by: Shai Malin <smalin@marvell.com>
Signed-off-by: Prabhakar Kushwaha <pkushwaha@marvell.com>
---
 drivers/nvme/host/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index c7bd37103cf4..f9b527e71c13 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2533,7 +2533,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 	}
 
 	if (opts->mask & NVMF_OPT_HOST_IFACE) {
-		ctrl->ndev = dev_get_by_name(&init_net, opts->host_iface);
+		ctrl->ndev = __dev_get_by_name(&init_net, opts->host_iface);
 		if (!ctrl->ndev) {
 			pr_err("invalid interface passed: %s\n",
 			       opts->host_iface);
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
