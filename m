Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C69C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Dec 2021 21:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/MF8CKfzjIf5t4JiAiJMjtO7331BCbvY2VeoBUd6qy4=; b=VOhQUq7kun9o1tucr/Eff8rOfr
	SL8yqzd3S+7wzsR3O+b/A00eMqjjnZ7L0JsMC6g/OQSMoF6HcZ55SVWdZPsX0qsqwyyzrJWM/cjJ4
	F2924ST8Azk26sd4gdzPyKwBG5xNU2kvQLtydvyGrmqV7RUTMg8TtiY87wSeN0N8XcmO5LcxOQcDM
	RLuQ7STOC6jxjGYMVj7b5ApEm6ywvyeD+4zE8Sx0oC2I6Bfv2/xArmS7o7FmNfhW+QhjVGkZNmckl
	/mXVgF7WJfh2deb+rtKwrNh7dZPCGeP1mTIfwOadNgyOdilL0eMdc7yI1Xwzowm7IIc6bI2Fe3YQi
	i+YzKfJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n0W6L-00DVbh-SE; Thu, 23 Dec 2021 21:58:17 +0000
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n0W6G-00DVb9-5F
 for linux-nvme@lists.infradead.org; Thu, 23 Dec 2021 21:58:13 +0000
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BNJSmbg023733; 
 Thu, 23 Dec 2021 21:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding;
 s=corp-2021-07-09; bh=/MF8CKfzjIf5t4JiAiJMjtO7331BCbvY2VeoBUd6qy4=;
 b=0ABR/eIxsrM3Z3fM4fOyiLcobn0xqcSsrdE+vQfeUc2ImeOxXgqjNRZSN9dDB9K9LZDe
 NjSnDNYQSePRo5OPde4/yk8h4maqMWAOM841wtpi9NxDVgG8yyXkYeCBH5vdI8CoQVfs
 lP+pA74ATUYMQprBy04/7vOvqQZXlxddpD3P/diwMFoWtj/MJ14pSxKtIx097MjjLNeA
 7JgOOREnxIOUXVu9XO7FUyFqI6As3LQDmYgUGBtl+sbEzYHt87TyY1bVnHxqQRJyyCpO
 5I1IUzO2KLh+GNYMyyOAGei8/zQU5i2Lp/VJ/O2qX8vu7X6NF/WFyhg0vFbLwNByBK0X Jg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by mx0b-00069f02.pphosted.com with ESMTP id 3d46qn44ck-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Dec 2021 21:57:59 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BNLp46C040064;
 Thu, 23 Dec 2021 21:57:58 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by aserp3030.oracle.com with ESMTP id 3d15pghv33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Dec 2021 21:57:58 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
 by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1BNLvwo4052101;
 Thu, 23 Dec 2021 21:57:58 GMT
Received: from dhcp-10-65-149-175.vpn.oracle.com
 (dhcp-10-65-149-175.vpn.oracle.com [10.65.149.175])
 by aserp3030.oracle.com with ESMTP id 3d15pghv23-1;
 Thu, 23 Dec 2021 21:57:57 +0000
From: Alan Adamson <alan.adamson@oracle.com>
To: linux-nvme@lists.infradead.org
Cc: alan.adamson@oracle.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Subject: [PATCH V2 0/1] nvme: Add verbose error logging
Date: Thu, 23 Dec 2021 13:57:25 -0800
Message-Id: <20211223215726.71096-1-alan.adamson@oracle.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: khA2zNbDMXLGyb9z2mAVwLP6ujBtirq7
X-Proofpoint-GUID: khA2zNbDMXLGyb9z2mAVwLP6ujBtirq7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211223_135812_364881_209F3407 
X-CRM114-Status: GOOD (  17.64  )
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
 drivers/nvme/host/errors.c | 202 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h   |   2 +
 include/linux/nvme.h       |   1 +
 6 files changed, 217 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/host/errors.c

-- 
2.27.0


