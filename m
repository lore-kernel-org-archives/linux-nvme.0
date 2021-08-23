Return-Path: <SRS0=nO+g=NO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE58CC4338F
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 12:57:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF998613AD
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Aug 2021 12:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BF998613AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=swwb0sEuE616u5cDjtS+Vyvi1mIU4BO0BgosENzI72w=; b=cUIpcIVx6i5ST9
	kpv0tgyhP6YbLyustP2aVt2YJJ/c1FSSxeQp0iow2B8vkINwsa2M3F5vpxe0F5I9VReYzHlc9QNu3
	RLS8X1BE4nkOJ+dxoXvtTkJuI3m6vrEaDCWpfS+jHVHll5yo52+y5Y8HpCa5+FmXWuoD9UG7cK3Ty
	GXIUJqafwNzJoOkPmdQYnEUQF47U8jP1u46Mc3Sq4CsrkE9JS3bQQk+nJImF6rqPdRljESGWn/jE/
	cQUgObmyYGTlxdN5mGGgSmHQeexY11t5/+R5HY2s/S38h9pAMpBVz5dqeYJKLFbx59NSk0mMc7F8d
	vrIb4jo6UmghIfGO6Nhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mI9W2-00GsQA-CJ; Mon, 23 Aug 2021 12:57:26 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mI9Vy-00GsLm-Sy
 for linux-nvme@lists.infradead.org; Mon, 23 Aug 2021 12:57:24 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17NC5FlD009121;
 Mon, 23 Aug 2021 05:57:18 -0700
Received: from dc5-exch01.marvell.com ([199.233.59.181])
 by mx0b-0016f401.pphosted.com with ESMTP id 3am1fk21em-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Mon, 23 Aug 2021 05:57:17 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 23 Aug 2021 05:57:14 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 23 Aug 2021 05:57:14 -0700
Received: from dut1171.mv.qlogic.com (unknown [10.112.88.18])
 by maili.marvell.com (Postfix) with ESMTP id C325E3F7084;
 Mon, 23 Aug 2021 05:57:14 -0700 (PDT)
Received: from dut1171.mv.qlogic.com (localhost [127.0.0.1])
 by dut1171.mv.qlogic.com (8.14.7/8.14.7) with ESMTP id 17NCv9mI016096;
 Mon, 23 Aug 2021 05:57:09 -0700
Received: (from root@localhost)
 by dut1171.mv.qlogic.com (8.14.7/8.14.7/Submit) id 17NCunHD016095;
 Mon, 23 Aug 2021 05:56:49 -0700
From: Nilesh Javali <njavali@marvell.com>
To: <martin.petersen@oracle.com>, <linux-nvme@lists.infradead.org>
CC: <linux-scsi@vger.kernel.org>, <GR-QLogic-Storage-Upstream@marvell.com>
Subject: [PATCH 0/2] qla2xxx - add nvme map_queues support
Date: Mon, 23 Aug 2021 05:56:47 -0700
Message-ID: <20210823125649.16061-1-njavali@marvell.com>
X-Mailer: git-send-email 2.12.0
MIME-Version: 1.0
X-Proofpoint-GUID: BeMBY8lDTsmYgH2bWUqu3Xbjf7zNy4Nv
X-Proofpoint-ORIG-GUID: BeMBY8lDTsmYgH2bWUqu3Xbjf7zNy4Nv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-08-23_02,2021-08-23_01,2020-04-07_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210823_055723_108610_70725480 
X-CRM114-Status: UNSURE (   8.62  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently nvme fc doesn't support map queue functionality. This patch
set adds map_queue functionality to nvme_fc_mq_ops and
nvme_fc_port_template, providing an option to LLDs to map queues
similar to SCSI. For qla2xxx, minimum 10% improvement is noticed
with this change as it helps in reducing cpu thrashing.

Saurav Kashyap (2):
  nvme-fc: Add support for map_queues.
  qla2xxx: Add map_queues support to nvme.

 drivers/nvme/host/fc.c          | 25 +++++++++++++++++++++++++
 drivers/scsi/qla2xxx/qla_nvme.c | 14 ++++++++++++++
 include/linux/nvme-fc-driver.h  |  7 +++++++
 3 files changed, 46 insertions(+)


base-commit: 92cc94adfce4683d0b421cbf59013703368aaeb9
-- 
2.23.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
