Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32436C38142
	for <linux-nvme@archiver.kernel.org>; Mon, 23 Jan 2023 12:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NIsge3EKupZJlBK3c5svY+13/98asVBZCXWLUgTVssA=; b=FzNnP6OAHa98/tjEtvZXjz8vem
	OJUfXnU3u+hfMbWkWxOBOUP0E48yfrv/3c+UFjWSYgyU3TmPcxyAKDZTGfYya2euhdiK6n+mHntPC
	RT7FE+hA5yZ2OWpXDCzGuhxYAMbVxg9mnIHEVcoDwP7QkM8xJHUwati6mz9w/x187ZH6KnWX2iuvR
	VQOc17FuqIGGtiHE3RvqFQYWKc2+0AbHHCZQXJafSEHhf8y/V7AdDLDhKPBzpkUCVHdYMB3V8nKL7
	b3NTKGxjXJnRDgtcso2Lnb1BrjbSXH0g7Gzl17ttLS/hhh34116vfXklQeBdo99iWkOevM5Xo6aT4
	mtHyXhAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJw5g-00H9Rh-Do; Mon, 23 Jan 2023 12:38:24 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pJw52-00H97T-TW
	for linux-nvme@lists.infradead.org; Mon, 23 Jan 2023 12:37:46 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30N3kmKi003335
	for <linux-nvme@lists.infradead.org>; Mon, 23 Jan 2023 07:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id; s=smtpout1;
 bh=NIsge3EKupZJlBK3c5svY+13/98asVBZCXWLUgTVssA=;
 b=HugSH93iOBnXTxyxDyc0ckgXnMdVs00l68slZq3nqbZJSWFSCKCU6Z8M5vcEyHVC+kW8
 QVQPPTbcrjDRSYM9XLEvaE8HXaCAUH5O1ITGCE2Hw7hopOXcA2yrYKPx9qGVj2ub5w/l
 bSlP4aRIlbh6CAthxFjQ2ElVemKBwpkrd4qJGYNGhBa9F9t+L87sLDk1yHLxI+HIrmAY
 tPWWOw7636c/sGtOpcl2j+hsFdI1tQJWhmv8gxAg+JpzE42Nqx4hdfSROTxUG3XcmgLG
 Uz7F0DmzV5CjmU9K9jCH/+7rmEqdRGjd+ichPTzdZeciXBN4CHAEqoZ/2qIsaEbh2O+r TQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3n8cxrx0mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 23 Jan 2023 07:37:36 -0500
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NCQqYC010215
	for <linux-nvme@lists.infradead.org>; Mon, 23 Jan 2023 07:37:35 -0500
Received: from esaploutpc104.us.dell.com (smtp-outbound-pc1.dell.com [143.166.24.15])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3n9f2uy21p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Mon, 23 Jan 2023 07:37:34 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.227.144
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="153481883"
Received: from unknown (HELO vd-engela.xiolab.lab.emc.com) ([10.55.227.144])
  by esaploutpc104.us.dell.com with ESMTP; 23 Jan 2023 06:37:34 -0600
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: amit.engel@dell.com, Amit Engel <Amit.Engel@dell.com>
Subject: [PATCH] fc: add a missing release get taken in nvmet_fc_alloc_target_assoc
Date: Mon, 23 Jan 2023 14:37:28 +0200
Message-Id: <1674477448-2455014-1-git-send-email-amit.engel@dell.com>
X-Mailer: git-send-email 2.31.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_08,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 mlxscore=0 phishscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 spamscore=0 clxscore=1011 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301230116
X-Proofpoint-GUID: ka3jyrCi8yAFbiUchnHTQpKBUeeBAOEB
X-Proofpoint-ORIG-GUID: ka3jyrCi8yAFbiUchnHTQpKBUeeBAOEB
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301230119
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_043745_120997_17AB9AB8 
X-CRM114-Status: GOOD (  17.21  )
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

As part of nvmet_fc_ls_create_association there is a case where
nvmet_fc_alloc_target_queue fails right after a new
association with admin queue is created.
In this case, no one releases the get taken in nvmet_fc_alloc_target_assoc
This fix is adding the missing get release

Signed-off-by: Amit Engel <Amit.Engel@dell.com>
---
 drivers/nvme/target/fc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index ab2627e17bb9..1ab6601fdd5c 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1685,8 +1685,10 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 		else {
 			queue = nvmet_fc_alloc_target_queue(iod->assoc, 0,
 					be16_to_cpu(rqst->assoc_cmd.sqsize));
-			if (!queue)
+			if (!queue) {
 				ret = VERR_QUEUE_ALLOC_FAIL;
+				nvmet_fc_tgt_a_put(iod->assoc);
+			}
 		}
 	}
 
-- 
2.31.1


