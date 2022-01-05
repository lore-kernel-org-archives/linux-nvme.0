Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD4CAC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jan 2022 18:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LcFXbyt6bTHf3V/B6iUAqTQM3efl+xASmKzyCcjeDdc=; b=IaXFxWJ1FRRROYxlntH+P0wQct
	Vx2Oi1qXXUaGoGWWHne9dSQAxbL/xnvA4utPgh8u+rcufTYBraICq7KUfCxXjaAdSzIp5JL9qC+qd
	2LKuJK/wj48DSqJuMojRPyqIRnVvi/NXmSYT9Ko/9DgAyurC8SoG3mR/L98XfBXy7TpsgO8n7BJcM
	ll8kND3YQCRjrqAT+/d78/IzBJ/l5gejYC1tjD6Bm9GcHsKpUKawmNrsXmTnuoREXvTBtdWugomFw
	YciSr8mBpWLIY51HogCQc9heLVV78LipHMnSaK72DAyG/xmVE/Qeg7Q12E080nmvktzW0YXntTCIE
	+GK5fu7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n5B6W-00FcB0-Cf; Wed, 05 Jan 2022 18:33:44 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n5B6T-00Fc9w-L7
 for linux-nvme@lists.infradead.org; Wed, 05 Jan 2022 18:33:43 +0000
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 205IHL4t032294; 
 Wed, 5 Jan 2022 18:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=LcFXbyt6bTHf3V/B6iUAqTQM3efl+xASmKzyCcjeDdc=;
 b=nj65/5gG02pADbFMeZgxZLQXG9qOVhmaaqQpNG8loOXYZoOwOC2X8cOEL0Hw0FsGaUPL
 13MqcDHCt+xcOd8fukozGjo0Ga2ioEjyxlOdKFMNBbLHh2p3jHssE73IV8GZJLduDb4B
 lj5SpLj+NGm01w4n7MhA0CZuegEcpjnKg5VxFWORQ/SebbNqpgUFVz7/Dr0PD0lIqp/Q
 /CaaxYTKuiC++LjKpK6p/mTh/DCrHEIjLFVXTU1eB6qxmOXckHIJ1WhOXkoQJmpz0h3t
 peMxN1+D99wgFq5qdoCAVx6D/NeZhJKBYn+8TferDji06e6/ULsiqPt6ESxEMgAepMQn vQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3dc43gdjmh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Jan 2022 18:33:21 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 205IG7Ob089982;
 Wed, 5 Jan 2022 18:33:21 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3030.oracle.com with ESMTP id 3dad0fcsw8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Jan 2022 18:33:21 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 205ISlCD136133;
 Wed, 5 Jan 2022 18:33:20 GMT
Received: from dhcp-10-159-138-93.vpn.oracle.com
 (dhcp-10-159-138-93.vpn.oracle.com [10.159.138.93])
 by aserp3030.oracle.com with ESMTP id 3dad0fcsv0-1;
 Wed, 05 Jan 2022 18:33:20 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [PATCH V3 0/1] nvme: Add verbose error logging
Date: Wed,  5 Jan 2022 10:32:48 -0800
Message-Id: <20220105183249.22088-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 8RYSgU_1PCYBpCCJJcRcFG_jDV9lVU8b
X-Proofpoint-ORIG-GUID: 8RYSgU_1PCYBpCCJJcRcFG_jDV9lVU8b
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220105_103341_858731_D8B38D24 
X-CRM114-Status: GOOD (  18.29  )
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

V3:
- Don't populate nvme_errors[] array with NULL strings. 

V2:
- Change nvme_errors[] to a sparse array where the status is used as an index into the array.

- Change pr_err() to pr_err_ratelimited().

- By enabling CONFIG_NVME_VERBOSE_ERRORS, the verbose status error is displayed.  If it is not
enabled, then a message will still be displayed, but without the verbose status.

- Remove call to nvme_error_status() when determining whether to call nvme_error_log().  Speeds
up the fast path just a bit.


This patch improves logging for NVMe errors.  Currently, we only get a
a vague idea as to why commands fail since only the block layer status
is captured on error. This patch allows us to see why a command was failed
by the controller. This is very useful when debugging problems in the field.

An example of an improved logged error:

[ 4652.812867] nvme0n1: Read @ LBA 1536, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR 


Alan Adamson (1):
  nvme: Add verbose error logging

 drivers/nvme/host/Kconfig  |   8 ++
 drivers/nvme/host/Makefile |   2 +-
 drivers/nvme/host/core.c   |   3 +
 drivers/nvme/host/errors.c | 181 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h   |   2 +
 include/linux/nvme.h       |   1 +
 6 files changed, 196 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/host/errors.c

-- 
2.27.0


