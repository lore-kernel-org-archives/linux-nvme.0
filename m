Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE50C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 12:33:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE66E6144E
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 12:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE66E6144E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DFM1S3jhOEoE0Ug1j43mPw1ou2UUdJIpxeYkqb6nbSk=; b=WNTq8uDVlhAVTojwcYz1WnMM1m
	ZgvIXvUPNw3ciXYsxM8w9/+lrLepDtTCTR7YUodSfgDvLbHFKv4eK7t6cnhSQCnww9WauyncmQX6V
	srNADUy4ISABK2SvnWu9uF7IZlIyqLuiN6UMpeAkBD3I+EllCebNSJRKSEMqbhOI8ZApEA7Tk5IHF
	i6UMpnZqwk3hBSYfJuwvMq7RMK+ad+85Mi4V8gb4tvSashXyWbnnsLDP0vvntNxLvKRyKV6u1eGdg
	GapJPOnoUjNlU+3Xaa7cN1NiyEsJ134nABwhhexmMwDst7FSthegjK2JYLnv8zWNfa+//bI4UaoTt
	dx3dugAw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZYWS-00GiEW-32; Thu, 22 Apr 2021 12:33:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZYWQ-00GiEM-5Z
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 12:33:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=NC3QNkem89pc4lh0k8gjdVoM4FeLve01p722F2NKTEI=; b=iRY/bs0xIIrHGWoc0q2+tVc10x
 1BvqrOS0jePAw71iCkL1qcryBqgA6EdFA/AQL3bs+tAI/hoeip9+M8ryKrAdzVZ+CvnpgqriMffPg
 uD9zqYnMqvmhrsMpELAEqIFTKnYu0HvZ3xTHama+q80vaEBUfl9k7zmzgghwTU7CQuVfd8GH015wU
 A6BJvzyAtnTN61H7+8UDV5TPppDs02xX71dP4bEjKScEt6zIft2tqcxoJxDczfO/EWtHqG5tEJrdd
 5LrsTHePrf/+nHI1yGQZWE45jo85QR0jQeJdnDtOxdlzyh5Lb/DD7uEr4ilNjtBpjNpdBFjlvOsLv
 JCyRL5Ug==;
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZYWM-00DgCm-Pl
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 12:33:28 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13MCRxsS004490
 for <linux-nvme@lists.infradead.org>; Thu, 22 Apr 2021 08:33:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=NC3QNkem89pc4lh0k8gjdVoM4FeLve01p722F2NKTEI=;
 b=H+KRYKo+1B6ffhczhsUn2SEY65jVzPOs2Dhm2hPwof90n1A5LgdCnekOUCf26+UelgSf
 srdeBYWdZy6oVzRgv0AqnhoFLK/oB0r72rVMRb98olTgTmfF0a2WENmVJWmtp1W/FdoB
 BsKKdJqQ2bul8zWGscXJVAVP7w8TfV9jL+bSLy9VMoFJhj6ZICfambty909fbcMzWBxu
 GswdU59Fw11TVWPqr3qXtlSM4gwIa/HqRBzuwV410Yjh9O1/CIvCQ4oYE5pKzxAe6UI/
 T+YRAkKcM4VA4A9hWJ5QOuSIXbTjxuP7JzUTgwG1+9DkscyNtGjoNscAQzhh+UYNslIG eg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 38369c0k70-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 22 Apr 2021 08:33:23 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 13MCPD1o079221
 for <linux-nvme@lists.infradead.org>; Thu, 22 Apr 2021 08:33:22 -0400
Received: from esaploutdur02.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 382w1t93aq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Thu, 22 Apr 2021 08:33:22 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.225.216
Received: from unknown (HELO vd-amite.xiolab.lab.emc.com) ([10.55.225.216])
 by esaploutdur02.us.dell.com with ESMTP; 22 Apr 2021 07:33:20 -0500
From: amit.engel@dell.com
To: linux-nvme@lists.infradead.org, houpu.main@gmail.com
Cc: amit.engel@dell.com
Subject: [PATCH] nvmet: move ka_work initialization to nvmet_alloc_ctrl
Date: Thu, 22 Apr 2021 15:33:16 +0300
Message-Id: <20210422123316.18362-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-04-22_04:2021-04-21,
 2021-04-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 mlxscore=0
 clxscore=1015 priorityscore=1501 mlxlogscore=999 impostorscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104220104
X-Proofpoint-GUID: jqq0N34RnLARQHkXnvgCB3ZnjQLgzfNd
X-Proofpoint-ORIG-GUID: jqq0N34RnLARQHkXnvgCB3ZnjQLgzfNd
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104220104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_053327_040906_42468814 
X-CRM114-Status: GOOD (  15.38  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Amit Engel <amit.engel@dell.com>

Initialize keep-alive work only once, as part of alloc_ctrl
and not each time that nvmet_start_keep_alive_timer is being called

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index adbede9ab7f3..36f9c1caa3f8 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -412,7 +412,6 @@ void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
 	pr_debug("ctrl %d start keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
 
-	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
 	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
 }
 
@@ -1341,6 +1340,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	INIT_LIST_HEAD(&ctrl->async_events);
 	INIT_RADIX_TREE(&ctrl->p2p_ns_map, GFP_KERNEL);
 	INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
+	INIT_DELAYED_WORK(&ctrl->ka_work, nvmet_keep_alive_timer);
 
 	memcpy(ctrl->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
 	memcpy(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE);
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
