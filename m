Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E496CC433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 15:45:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82DE865090
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 15:45:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DE865090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=O1ST2ieaQHL8mCsLEApz3NXElj3DskaP2mAxk5vuBWo=; b=MSqBANzv6xHZYRuVtEJBveypoL
	EtJ/8UOFPwJgyhad2QJeVhqrZPApPbam6DzvcPLI0Ht4rNftD6kdN+Mwu8wEAruJZSTFVuC3Rju5L
	27TdPLenZnRdGt7/maDGf+Ed4BeSfVpm48O3ZYs3/GU6saH2W3bCxNke5YqjS2E+79O+Ykil+S2V9
	nWZlQy+eiEs9AO06uWZghtSn1oO5ANA++M2EV+l0ZzcOBwf7GyXgwj0oQL1CTthjP/mNNBvCQ8pyw
	5ffL7/m3FNd6ikfTm9k1p18GQRad6OeHVKQOLJwLrhEJbQ6/p0AnaDv7ZTCcqebaVPGF25Q7kOE1k
	PEB7cK2Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMBsH-0017A0-5n; Tue, 16 Mar 2021 15:44:49 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMBs9-00177v-TN
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 15:44:46 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12GFgNWn013293
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 11:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=cdtbwxtgWoL9KJ11aMYsOnbTZ2qr6J+sL9iZn0E1qI4=;
 b=JzzB0mL/7VgZ9x1c87IyTy4FnZKjZAhQ6YlL06h1WRQexu+PJx8BWd6jA7JTFpmJjkh9
 PXO5mtdtBdYcygaFQncLEcU2gWppQ9lcLgzR/TFimSP8mN8KHxciD/iDu5WA6oVUnlLG
 6FfV76NWZ0FklwXTrrhK70sTFC6a4pupCL22E6k8YwyVsnzOB7oOhf+1/FaI7pstqADP
 mfzHnC4MKh7Ku9Bouau1b2SZMCzx+fngG3fmZFLMQ69L2G7aOLNY3Wg21dN4DXNB5sDD
 QXgHrDH7YBvzySxft57T75/F0V6UE8X/xa+tL29Aqwhuy/dmLbUcsgxYA1EFf09Mmg6x 7Q== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 37aurf913g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 11:44:34 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12GFdtu0032089
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 11:44:34 -0400
Received: from esaploutdur05.us.dell.com ([128.221.233.10])
 by mx0a-00154901.pphosted.com with ESMTP id 379bw3jt03-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Tue, 16 Mar 2021 11:44:34 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.224.98
Received: from vd-idand.xiolab.lab.emc.com (HELO vd-grupie.xiolab.lab.emc.com)
 ([10.55.224.98])
 by esaploutdur05.us.dell.com with ESMTP; 16 Mar 2021 10:44:32 -0500
From: elad.grupi@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: Elad Grupi <elad.grupi@dell.com>
Subject: [PATCH] nvmet-tcp: fix kmap leak when data digest in use
Date: Tue, 16 Mar 2021 17:44:25 +0200
Message-Id: <20210316154425.16434-1-elad.grupi@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-16_05:2021-03-16,
 2021-03-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxlogscore=939 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103160105
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 spamscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103160105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_154442_622114_D0C1D2AD 
X-CRM114-Status: GOOD (  17.22  )
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

From: Elad Grupi <elad.grupi@dell.com>

When data digest is enabled we should unmap pdu iovec before handling
the data digest pdu.

Signed-off-by: Elad Grupi <elad.grupi@dell.com>
---
 drivers/nvme/target/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 8b0485ada315..d658c6e8263a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1098,11 +1098,11 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		cmd->rbytes_done += ret;
 	}
 
+	nvmet_tcp_unmap_pdu_iovec(cmd);
 	if (queue->data_digest) {
 		nvmet_tcp_prep_recv_ddgst(cmd);
 		return 0;
 	}
-	nvmet_tcp_unmap_pdu_iovec(cmd);
 
 	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
 	    cmd->rbytes_done == cmd->req.transfer_len) {
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
