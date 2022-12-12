Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C7F2C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 19:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=371nkfw0vtxktONVwxUnfFLqsIqhFhY9j5e+NsOqJvM=; b=N0fJRhklVeSYp7s3K5aNLWV5Bc
	ovCBq9b08V9vG4B6Bqu3FSiEovno3z9qeI75G9tY6Hg1myNpHYCwVhrTq7/zI1FmlhtdLAjuUZKHM
	fle+VkHWYj/kTF7jTPdA4RMiXAWHwsEbX/VVByiPfxgXLF0DGtfvhaNDnRS6BK2g1kp5b/ULk4UIC
	8/uYkq5e/ZG1IEf9awmzywtxP9IOEOIFGGg/CtVheQ4Ta/wiZa5mfoWs/Z8o1hdzq72md+lnqksNP
	nqFCV/o2efJuQr10JvFEhC9rbKohhfQGGCMhBdJGlOTL83yYmNodH8ASk9VJIfXEru4QYWUllwsXq
	eLVOrTuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4ofP-004dvH-Sh; Mon, 12 Dec 2022 19:40:47 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4ofN-004dmQ-58
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 19:40:46 +0000
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGn6vj030797
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 14:40:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=371nkfw0vtxktONVwxUnfFLqsIqhFhY9j5e+NsOqJvM=;
 b=yXuc7kIsFNRw7GYIWUtbkcqmvntMbhVUHXnpCZfO/NR+TwXH4QMttN0Xv6pMHfFJEeBm
 umtS6tbEEVjjgE9giUsGByao79tcvuWnSMAWXhpr8ipHe3JcSF6QESHrFRlRq8AkBmsk
 H34pnGMYR9MyeGBZr3KQ3YrHBXJS+V6pwof2sVdFL0mg2yutO3FG2606zER1W9TYEnEm
 aU08D14JsMfR1EOd5Q5J+tqNUtBaKmmUBdFDhp4CE4eaNGvtmIjcgFSA/XoNeUUROJ3F
 eE6ZErwlL9u/ov+TQdjPK9RwM6CYMthI2yC/gaSfGgYchhaJt2wr6FX8/ko+x/H+LBMc VA== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3mcpu3u8d8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 14:40:43 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCJTw6U024820
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 14:40:43 -0500
Received: from esaploutpc103.us.dell.com (smtp-outbound-pc1.dell.com [143.166.24.15])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3me7h9tr3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 14:40:43 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.227.144
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="114486698"
Received: from unknown (HELO vd-engela.xiolab.lab.emc.com) ([10.55.227.144])
  by esaploutpc103.us.dell.com with ESMTP; 12 Dec 2022 13:40:42 -0600
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: amit.engel@dell.com, Amit Engel <Amit.Engel@dell.com>
Subject: [PATCH 0/2] improve nvme error logging
Date: Mon, 12 Dec 2022 21:40:34 +0200
Message-Id: <1670874036-3222795-1-git-send-email-amit.engel@dell.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <1670855159-3182917-3-git-send-email-amit.engel@dell.com>
References: <1670855159-3182917-3-git-send-email-amit.engel@dell.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=794 lowpriorityscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120176
X-Proofpoint-GUID: uHGTuuNTzQjS1Y9gotafKzvqAaGRTjWv
X-Proofpoint-ORIG-GUID: uHGTuuNTzQjS1Y9gotafKzvqAaGRTjWv
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=807 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_114045_549874_5AB02614 
X-CRM114-Status: GOOD (  12.89  )
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

From: Amit Engel <Amit.Engel@dell.com>

Add nvme_opcode_str func for all nvme cmd types (io/admin/fabrics)
Add additional debug info for nvme_tcp_timeout log

Amit Engel (2):
  nvme: add nvme_opcode_str function for all nvme cmd types
  nvme-tcp: add additional info for nvme_tcp_timeout log

 drivers/nvme/host/constants.c | 16 ++++++++++++++++
 drivers/nvme/host/nvme.h      | 13 +++++++++++++
 drivers/nvme/host/tcp.c       |  7 +++++--
 3 files changed, 34 insertions(+), 2 deletions(-)

-- 
2.31.1


