Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2431FC433E6
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 09:10:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1F6F23888
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 09:10:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1F6F23888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=O0GYcpaWkfhD3/ufp076Ey9FqSz+qzTATjQ+BPBWFqc=; b=ha5XgXF9z/2sTgMYGYx2N2z+2W
	Q12G8bGdpLTvS/2ETxgqHr/fIkyapy83qVVN9jNCoT4YN4Ed38bBpFDJNMg3p139EuSg/mGyCCCfS
	63zG/QQ57Mq06S6iBagd3SDE6QALM28dRRC82pSO8SOFM4x7DI+9q0u9U7PCDMvQBMkPZ8sx19TEu
	7j86YPx7zXhvXOuwE10Cz/nb5PhItvKBFA8i0M8QzYHLz6u90TiULSECV+SVqQ8Qyf6ySOyZqK0/t
	FzqTmSDevdc0/v9tqsrNQT+K66MK/wAibKr4H1cLUdkmjUP4aEXUARNGIZzBYBzmp5J3ao0mRIZwt
	kXbHI/TA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2Vya-0003N6-VO; Thu, 21 Jan 2021 09:10:01 +0000
Received: from hqnvemgate26.nvidia.com ([216.228.121.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2VyW-0003KW-1U
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 09:09:58 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B600944df0001>; Thu, 21 Jan 2021 01:09:51 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 21 Jan
 2021 09:09:51 +0000
Received: from r-nvmx02.mtr.labs.mlnx (172.20.145.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 21 Jan 2021 09:09:49 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <kbusch@kernel.org>, 
 <hch@lst.de>, <chaitanya.kulkarni@wdc.com>
Subject: [PATCH v2 0/2] Resync Linux and NVMe-cli nvme.h header
Date: Thu, 21 Jan 2021 09:09:45 +0000
Message-ID: <20210121090948.8027-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1611220192; bh=BL49uuZjuSNqX9qeEtvypYy3WnibbSw+A+XCMlCVNWY=;
 h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding:Content-Type;
 b=jfMcbldi6Kiz6Kax4T3G8BaJ9ziLmrXyd4a+g9Cxap4AVzwMo1vF0Q8FZ2msGaY2d
 zxBn4eGssFNtHnRXDWdfXSh1TUZvvLI8JLwg74+q8ZwYCTCyurYkvwMPmWNqskEKS7
 C44lTxGAf51a3hThAMQe9Z99sXn+d49I2JZuPuqG2yrzz9A96ZabfNOpBRxNwJ1EYp
 1QBY/QOcRZAERJx0cTzFHlGpeOj37Z9dkIIgyJsJ3DJHwuB/4NCQMw+jS5HYqFyMI+
 qMsVYvyFNxz9lLk67TH/PjavLYCSDIJ0kXBOy8nXPtuOXVYfy4C2ZbF7yqLKjRmjSq
 Qf6tTQ6MSWiRA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_040956_276966_BA4C850D 
X-CRM114-Status: UNSURE (   8.87  )
X-CRM114-Notice: Please train this message.
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
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Christoph/Sagi/Keith/Chaitanya,
This series introduce synchronization between the kernel
include/linux/nvme.h and nvme-cli linux/nvme.h to ease on maintainance
of both.
The changes for nvme-cli are in the structure of the linux/nvme.h header
file that will be divided to 2 parts: nvme-cli specific code and an
identical copy of the content of include/linux/nvme.h from Linux.
In this way, the resync process will be ease and whole the content of
include/linux/nvme.h will be pasted to that area. Individual commits to
this area will be forbidden and must go through kernel part first.

The additional to Linux include/linux/nvme.h is new enumerations from
NVMe 1.4 specification and the missing parts from nvme-cli that are
originated in common area of the code.

The structures and enumeration that were intruduced only to nvme-cli
were moved to part #1 in nvme-cli linux/nvme.h file and we can decide
whether we need them in the kernel as well. This can be done in future
step. Also new nvme-cli specifics that are not a must in the kernel and
are not in the common code structures/enums can go there.

To test this I run some basic commands as:
- nvme list
- nvme list -v
- nvme list-subsys
- nvme connect/disconnect
- nvme id-ctrl
- nvme id-ns

changes from V1:
 - Added Reviewed-by signature for patch 1/2 (from Hannes)
 - Added resync patch 2/2
 - Added resync nvme-cli patch 1/1

Max Gurtovoy (2):
  nvme: update enumerations for status codes
  nvme: resync header file with common nvme-cli tool

 include/linux/nvme.h | 90 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 72 insertions(+), 18 deletions(-)

-- 
2.25.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
