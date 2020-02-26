Return-Path: <SRS0=MxcY=4O=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDB76C4BA24
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 21:49:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB9B024670
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Feb 2020 21:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PnLyXtnK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HsMHKB2j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB9B024670
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=raxI1ed6ma2LmKGbHAIZoyJ8APj9hG41Y231oWcEU94=; b=PnLyXtnKvEYAeT
	20NEcJNMx4xeb6JUDbXqH0xppO69P4O4KKaHxfn9DuAnOBQuo2cBPkJBdAVLW+7VvDQsIoAUk4/L/
	UHv0h/IStTN2BtvI3CPkBaAzGZMciJAila4G2q9binlBZTb3/T19eXnhwRKMJYlybjeUuFTo8C+JF
	S+cYoMad7QVT3uvZxuebOjkytNECmwOJDbyODXS+rkrsoVGSiiMAroc6ZFQujJyYyhVf2G3ib3Xul
	s3r7xs8fnH07Di7RmJCQFpWOww1rp4cFSViUFkW/GV7TfWBv2h1w74EjPwX0n4+I5nX+n5cfp24D2
	bOYahvBtWan78hIjQcyg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j74Yk-0007AJ-VB; Wed, 26 Feb 2020 21:49:38 +0000
Received: from userp2130.oracle.com ([156.151.31.86])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j74Yj-00079y-9Z
 for linux-nvme@lists.infradead.org; Wed, 26 Feb 2020 21:49:38 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QLhWOs059301
 for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2020 21:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : subject : date : message-id; s=corp-2020-01-29;
 bh=TFBh6oL6EQ6PSdi6PBIr3cunZdFK5hmPVaaEHcNJCfo=;
 b=HsMHKB2jcoVZPP2DHcXchXEhr8tkoof7SKcNpig75iKzO8JA5q8Q8LEeGi+/55J/ABhA
 x5TckYMm0H67kG2NqNKyZQDQDQSAAiDC0Q65Ss8teVqmaZucHWTrAjJc/XRAKNDurw5Y
 CXD3xVc5ZkKv7BQg/EA2AZWoockLWPUJkdhqx7Vkvi/YkWe2rBY34tKzB+QRPR6lDIoW
 hz7WEHGAIm3r5qsvrFHrt/xp8SHj9K3IDcc7Qyr07wqK9RDV7WtFniGJGqtRSfSE3cZR
 ugFLopTgc4SmenIpqvCLjjlqX/5vfsy/25gCZv2c7bOG3fvv7I4PtorW2LHFyVNsyDmD bA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2ydcsnek5p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2020 21:49:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01QLiBt3013045
 for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2020 21:49:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 2ydj4jk8cy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2020 21:49:36 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 01QLnZS5025349
 for <linux-nvme@lists.infradead.org>; Wed, 26 Feb 2020 21:49:35 GMT
Received: from ca-ldom147.us.oracle.com (/10.129.68.131)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 26 Feb 2020 13:49:35 -0800
From: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 1/1] nvme-pci: Hold cq_poll_lock while completing CQEs
Date: Wed, 26 Feb 2020 13:49:22 -0800
Message-Id: <1582753762-47774-1-git-send-email-bijan.mottahedeh@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 suspectscore=3
 spamscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260127
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9543
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 malwarescore=0 bulkscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0
 suspectscore=3 impostorscore=0 clxscore=1015 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002260127
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200226_134937_371140_10929D27 
X-CRM114-Status: GOOD (  15.94  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
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
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Avoid scheduling a polling thread if it has cqe's to complete, otherwise
another thread may free enough tags out of order, allowing a queue wrap.

This is an interim solution. Longer term, the two-pass completion should
be fixed.  It was done that way when submit and complete processing were
using the same spinlock, so reducing the critical section was helpful,
but that's not needed anymore.

Signed-off-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ace4dd9..d3f23d6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1078,9 +1078,9 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx)
 
 	spin_lock(&nvmeq->cq_poll_lock);
 	found = nvme_process_cq(nvmeq, &start, &end, -1);
+	nvme_complete_cqes(nvmeq, start, end);
 	spin_unlock(&nvmeq->cq_poll_lock);
 
-	nvme_complete_cqes(nvmeq, start, end);
 	return found;
 }
 
-- 
1.8.3.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
