Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DDCDC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 14:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=371nkfw0vtxktONVwxUnfFLqsIqhFhY9j5e+NsOqJvM=; b=kBkryLjZvGoBthZQSY+S1j7CLW
	NV6JNs00i196rK+ure46kNx2Y558+ZZoXYsnHS6G7EahIG889Hye02i/opU9A0+G1116IiSlnb5ps
	1o60Es1aptwKUFOIsCmaXOXVr04kgQswhXmenxg245xjCy6X3oICSjQjhwD+bE+L3U4uirBJoXh62
	sI8L8CBugU88aPR6JJzCxETyV0OoSJ7mZjw4+U6AuzDY0shfPEdxtAE4CS/lLaMUvgk7Uoe/EANIg
	H9/aIu8QipFMol613FxFSw1RFb1NFU80YzKMHXmmwFT/AwX3Oo8st7NWc9gqp1+u1MN6d8VNSrzyw
	SDhQXPiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4jl3-00HROI-Nz; Mon, 12 Dec 2022 14:26:17 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4jl0-00HR3l-Ih
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 14:26:15 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCBaSfk018201
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 09:26:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id; s=smtpout1;
 bh=371nkfw0vtxktONVwxUnfFLqsIqhFhY9j5e+NsOqJvM=;
 b=xDJ3512jq2u+kB0J5yJEbel1ylx+mQfPCh3X/qmeAJhfhi2Rdb5mUbgIlalaggGxYSIh
 Aj7kKcV4V1uUkRFDIPI35w4VT/XWejtdBk+M+ogCGchLjLVqsfiZ/M7L0SBHhs2CoU1o
 1fFjhgYLsxePuyhlYT5WXkLoSACUdTOdWLC2GVFw0NIHMYPG3jfTNJI3tn5LM1nuCGyg
 QyBlIwy85nSm970MWySwts38XC02UB0pZ2+XnLcTcJYXUg7Z2proERm25kG+5ponK4O0
 Tjc/y2CX+JtS2pljCqll2uimf/qaEtQO8GXAKFVmF5yiavPCaToKVsi7qHTL/t95YuDP zQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3mcq0r9hqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 09:26:11 -0500
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCE8IMA006702
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 09:26:11 -0500
Received: from esaploutdur05.us.dell.com ([128.221.233.10])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3me0eg6a31-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 09:26:11 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.227.144
X-IronPort-AV: E=McAfee;i="6000,8403,5688"; a="268537145"
Received: from vd-engela.xiolab.lab.emc.com ([10.55.227.144])
  by esaploutdur05.us.dell.com with ESMTP; 12 Dec 2022 08:25:45 -0600
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: amit.engel@dell.com, Amit Engel <Amit.Engel@dell.com>
Subject: [PATCH 0/2] improve nvme error logging
Date: Mon, 12 Dec 2022 16:25:57 +0200
Message-Id: <1670855159-3182917-1-git-send-email-amit.engel@dell.com>
X-Mailer: git-send-email 2.31.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=684 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120132
X-Proofpoint-ORIG-GUID: M7BSzrqCgv-6TbKi0GXFI2XmiLw6vrZD
X-Proofpoint-GUID: M7BSzrqCgv-6TbKi0GXFI2XmiLw6vrZD
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=768
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120132
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_062614_750799_D8FFC371 
X-CRM114-Status: GOOD (  11.54  )
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


