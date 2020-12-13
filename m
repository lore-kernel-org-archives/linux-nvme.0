Return-Path: <SRS0=ZzGD=FR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070DBC4361B
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 19:14:37 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911F92395C
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 19:14:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911F92395C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wz+7gFZHk1zerALs47IPm0yfdnYqowHwBGAWMs1WksY=; b=C4lUi2pcjyQ9ImLpusJOvvjjVR
	M/sYrxNLrrPJmYaxwDm/QHrkTgkjChs7NmBoJYJgdfzrP8HqAd4+x1fSUMuN8+90Rayr/ECW/dLKw
	FGgwQ+x+M4B6mAdWySpYWGGgI3XPI+kpw1RTDfIBgZMPN3yPyXOeIql6lwXj9bPuiEFj4cQubWCXC
	oyMVhvHsAc3KsStE/zCg53aP3Ulic/E6DKBCm/s3F6X3YH9YBGmzPrkHFg1WO79USJ5kklnx03fzA
	A9eU1h/31Any+L6mq8Ruf1y+83QDXyA5u5AX6BA1SoyjcQIEqnEHw5bD4dCuaQMO3zqu3pWMFqaBH
	FH29fncg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koWpB-0004lv-U5; Sun, 13 Dec 2020 19:14:29 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koWp7-0004kU-MB
 for linux-nvme@lists.infradead.org; Sun, 13 Dec 2020 19:14:27 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 0BDJB8Yp010897; Sun, 13 Dec 2020 11:14:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=Jsg1JWEpIjgLkpw4w6D2bqvGMxU9u8SCpf/XJ2xk8bg=;
 b=XW93QNMGDKo5+A/CkrFfLgaIRR/LuC4eFmvq5SYiqAcMLKCN4LNnnssRhIbnPr+9GHq7
 ee5fLntMNam5BPw9tHGAmaHYoatTcAoMzDJ8JJw/vYFbwxiHHoV/20mT77kdkpyKWe3g
 AGMEr6RpKCP6/AA2bsTrajjNvxLvw1vhclH5W7+9Frg8+aIfcRLP0xYwkRVUIp4zmu9l
 ci9raubZLVd1vmDslnsJa9362dn0PcBQcBqTkempXftdBFXGfujzkbD0HY4jL5Ue71E6
 ECd0w8rnacbmalyPhke4KMh/ZGHlGczdNMhdM3vKeHIweQOUr11Rd3nfTvjFMQ5jvbsl LQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
 by mx0a-0016f401.pphosted.com with ESMTP id 35cv3stjjv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Sun, 13 Dec 2020 11:14:08 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 13 Dec 2020 11:14:07 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 13 Dec 2020 11:14:07 -0800
Received: from lbtlvb-pcie154.il.qlogic.org (unknown [10.5.220.141])
 by maili.marvell.com (Postfix) with ESMTP id 0542C3F703F;
 Sun, 13 Dec 2020 11:14:04 -0800 (PST)
From: Shai Malin <smalin@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <Erik.Smith@dell.com>, <Douglas.Farley@dell.com>, <liuw@vmware.com>
Subject: [RFC PATCH v2 0/7] NVMeTCP Offload ULP
Date: Sun, 13 Dec 2020 21:13:54 +0200
Message-ID: <20201213191401.22734-1-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2020-12-13_06:2020-12-11,
 2020-12-13 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201213_141425_864776_E94059F8 
X-CRM114-Status: GOOD (  19.62  )
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
Cc: smalin@marvell.com, aelior@marvell.com, agershberg@marvell.com,
 mkalderon@marvell.com, nassa@marvell.com, dbalandin@marvell.com,
 malin1024@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

With the goal of enabling a generic infrastructure that allows NVMe/TCP offload devices like NICs to seamlessly plug into the NVMe-oF stack, this patch series introduces the nvme-tcp-offload ULP host layer, which will be a new transport type called "tcp-offload" and will serve as an abstraction layer to work with vendor specific nvme-tcp offload drivers.

The nvme-tcp-offload transport can co-exist with the existing tcp and other transports. The tcp offload was designed so that stack changes are kept to a bare minimum: only registering new transports. All other APIs, ops etc. are identical to the regular tcp transport.
Representing the TCP offload as a new transport allows clear and manageable differentiation between the connections which should use the offload path and those that are not offloaded (even on the same device).


Queue Initialization:
=====================
The nvme-tcp-offload ULP module shall register with the existing nvmf_transport_ops (.name = "tcp_offload"), nvme_ctrl_ops and blk_mq_ops.
The nvme-tcp-offload vendor driver shall register to nvme-tcp-offload ULP with the following ops:
 - claim_dev() - in order to resolve the route to the target according to the net_dev.
 - create_queue() - in order to create offloaded nvme-tcp queue.

The nvme-tcp-offload ULP module shall manage all the controller level functionalities, call claim_dev and based on the return values shall call the relevant module create_queue in order to create the admin queue and the IO queues.


IO-path:
========
The nvme-tcp-offload shall work at the IO-level - the nvme-tcp-offload ULP module shall pass the request (the IO) to the nvme-tcp-offload vendor driver and later, the nvme-tcp-offload vendor driver return the request completion (the IO completion).
No additional handling is needed in between; this design will reduce the CPU utilization as we will describe below.

The nvme-tcp-offload vendor driver shall register to nvme-tcp-offload ULP with the following IO-path ops:
 - init_req()
 - map_sg() - in order to map the request sg (similar to nvme_rdma_map_data() ).
 - send_req() - in order to pass the request to the handling of the offload driver that shall pass it to the vendor specific device.
 - poll_queue()

Once the IO completes, the nvme-tcp-offload vendor driver shall call command.done() that will invoke the nvme-tcp-offload ULP layer to complete the request.


TCP events:
===========
The Marvell FastLinQ NIC HW engine handle all the TCP re-transmissions and OOO events.


Teardown and errors:
====================
In case of NVMeTCP queue error the nvme-tcp-offload vendor driver shall call the nvme_tcp_ofld_report_queue_err.
The nvme-tcp-offload vendor driver shall register to nvme-tcp-offload ULP with the following teardown ops:
 - drain_queue()
 - destroy_queue()
 

 The Marvell FastLinQ NIC HW engine:
====================================
The Marvell NIC HW engine is capable of offloading the entire TCP/IP stack and managing up to 64K connections, already implemented and upstream use cases for this include iWARP (by the Marvell qedr driver) and iSCSI (by the Marvell qedi driver).
In addition, the Marvell NIC HW engine offloads the NVMeTCP queue layer and is able to manage the IO level also in case of TCP re-transmissions and OOO events.
The HW engine enables direct data placement (including the data digest CRC calculation and validation) and direct data transmission (including data digest CRC calculation).

 
The series patches:
===================
Patch 1-2       Add the nvme-tcp-offload ULP module, including the upper and lower API.
Patches 3-5     nvme-tcp-offload ULP controller level functionalities.
Patch 6         nvme-tcp-offload ULP queue level functionalities.
Patch 7         nvme-tcp-offload ULP IO level functionalities.


Performance:
============
With this implementation on top of the Marvell qedn driver (using the Marvell FastLinQ NIC), we were able to demonstrate x3 CPU utilization improvement for 4K queued read/write IOs and up to x20 in case of 512K read/write IOs.
In addition, we were able to demonstrate latency improvement, and specifically 99.99% tail latency improvement of up to x2-5 (depends on the queue-depth).


Future work:
============
 - The Marvell FastLinQ NIC nvme-tcp-offload "qedn" host driver. This driver will interact with the qed core module, in a similar fashion to the existing ethernet (qede), rdma (qedr), iscsi (qedi) and fcoe (qedf) drivers of the same product-line.
 - The nvme-tcp-offload ULP target abstraction layer.
 - The Marvell nvme-tcp-offload "qednt" target driver.


Changes since RFC v1:
=========================================
- Fix nvme_tcp_ofld_ops return values.
- Remove NVMF_TRTYPE_TCP_OFFLOAD.
- Add nvme_tcp_ofld_poll() implementation.
- Fix nvme_tcp_ofld_queue_rq() to check map_sg() and send_req() return values.


Arie Gershberg (3):
  nvme-fabrics: Move NVMF_ALLOWED_OPTS and NVMF_REQUIRED_OPTS
    definitions
  nvme-tcp-offload: Add controller level implementation
  nvme-tcp-offload: Add controller level error recovery implementation

Dean Balandin (3):
  nvme-tcp-offload: Add device scan implementation
  nvme-tcp-offload: Add queue level implementation
  nvme-tcp-offload: Add IO level implementation

Shai Malin (1):
  nvme-tcp-offload: Add nvme-tcp-offload - NVMeTCP HW offload ULP

 drivers/nvme/host/Kconfig       |   16 +
 drivers/nvme/host/Makefile      |    3 +
 drivers/nvme/host/fabrics.c     |    7 -
 drivers/nvme/host/fabrics.h     |    7 +
 drivers/nvme/host/tcp-offload.c | 1106 +++++++++++++++++++++++++++++++
 drivers/nvme/host/tcp-offload.h |  184 +++++
 6 files changed, 1316 insertions(+), 7 deletions(-)
 create mode 100644 drivers/nvme/host/tcp-offload.c
 create mode 100644 drivers/nvme/host/tcp-offload.h

-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
