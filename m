Return-Path: <SRS0=xDof=EZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816BAC6369E
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 14:22:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D744622226
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Nov 2020 14:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="g0Htsio2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="GVn6nKcy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D744622226
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BwYTUMO/oxNe9BQV0lxOE46xgbCNIfEv7tyfMwyt9+o=; b=g0Htsio2sBNiCHAK4Ns7H5hqag
	KcpxumSgtT2PXUV8XKzySsJNfSLtWrFycXeGBh0/hw+pdu0fYUdL/DIM7lQcnJtsuLGA170VjfJdI
	c1dijHyBXH0PbuQZyM1UIgTTBtjvmcZRVacNZy4r2REgM1i8Vf+vDqD3XYv0P1NWMZJ0FpP5vSCVj
	8GwlZiUxoexGtUy5xb3YCRwJVDkZEmCkg+6gt+dIIx4JK+0SayI8eeGv/gjRFqVCjlbQfYGZtiOnj
	h35pwmwNVoUFQ64r46YDLWCKbBjGSSjvgtnbuHasYAckjUNRjiAO8mINznXomSovaWNa9931SOVzK
	tDPrYKVg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kfkos-0004Eb-U1; Thu, 19 Nov 2020 14:21:55 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfkoo-0004CX-O0
 for linux-nvme@lists.infradead.org; Thu, 19 Nov 2020 14:21:52 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AJEJvhp007874; Thu, 19 Nov 2020 06:21:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=pfpt0220;
 bh=ZYb/Hgbz05dXTHdov1PDLvAXguOSLvB7ZvkH3QSoiHo=;
 b=GVn6nKcyUVbklYXKt2iYLf3L4zOsz4P0wx9i7YZnaAKjNkiMwmde8vRtkFLn6Kl1hy3i
 GVs3OVvBKBh1qq1SjEb5+PNO3BMpzsBH2ux6dyrNXBZptYHbcLOv+hGUMhgI0k93Z4hq
 dl34WtzykirfXF4XwcEqhHC9WbQdB4t3F5uaf0quChp7/yG9vBo2wTh8937z3kfIP9IV
 TPWpcrehBAsGHD7kV3heopGdy1okd4J2allDvBxH61w7Nn236Y2Pb1287ge0/LMgK3dz
 XG2usKkuYng4BkyC/MrKECk8YTMxwHWkI0eJZHFVzBrA/RKb13gxeitdT34N39c+LVZo fg== 
Received: from sc-exch02.marvell.com ([199.233.58.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 34w7ncurfb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2020 06:21:35 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH02.marvell.com
 (10.93.176.82) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 19 Nov 2020 06:21:33 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 19 Nov 2020 06:21:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 19 Nov 2020 06:21:32 -0800
Received: from lbtlvb-pcie154.il.qlogic.org (unknown [10.5.220.141])
 by maili.marvell.com (Postfix) with ESMTP id 7703F3F7045;
 Thu, 19 Nov 2020 06:21:29 -0800 (PST)
From: Shai Malin <smalin@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>,
 <Erik.Smith@dell.com>, <Douglas.Farley@dell.com>, <liuw@vmware.com>
Subject: [PATCH 0/7] RFC patch series - NVMeTCP Offload ULP
Date: Thu, 19 Nov 2020 16:21:00 +0200
Message-ID: <20201119142107.17429-1-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312, 18.0.737
 definitions=2020-11-19_09:2020-11-19,
 2020-11-19 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201119_092150_982098_13F760A3 
X-CRM114-Status: GOOD (  20.21  )
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

This patch series introduces the nvme-tcp-offload ULP host layer, which will be a new transport type called "tcp-offload" and will serve as an abstraction layer to work with vendor specific nvme-tcp offload drivers.

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

Once the IO completes, the nvme-tcp-offload vendor driver shall call command.done() that will invoke the nvme-tcp-offload ULP layer to complete the request.


TCP events:
===========
The Marvell HW engine handle all the TCP re-transmissions and OOO events.


Teardown and errors:
====================
In case of NVMeTCP queue error the nvme-tcp-offload vendor driver shall call the nvme_tcp_ofld_report_queue_err.
The nvme-tcp-offload vendor driver shall register to nvme-tcp-offload ULP with the following teardown ops:
 - drain_queue()
 - destroy_queue()
 

 The Marvell HW engine:
======================
The Marvell HW engine is capable of offloading the entire TCP/IP layer and managing up to 64K connections as already done 
with iWARP (by the Marvell qedr driver) and iSCSI (by the Marvell qedi driver).
In addition, the Marvell HW engine offloads the NVMeTCP queue layer and is able to manage the IO level also in case of TCP re-transmittions and OOO events.
The HW engine enables direct data placement (including the data digest CRC calculation and validation) and direct data transmission (including data digest CRC calculation).

 
The series patches:
===================
Patch 1-2       Add the nvme-tcp-offload ULP module, including the upper and lower API.
Patches 3-5     nvme-tcp-offload ULP controller level functionalities.
Patch 6         nvme-tcp-offload ULP queue level functionalities.
Patch 7         nvme-tcp-offload ULP IO level functionalities.


Performance:
============
With this implementation on top of the Marvell qedn driver (using the Marvell fastlinq NIC), we were able to demonstrate x3 CPU utilization improvement for 4K queued read/write IOs and up to x20 in case of 512K read/write IOs.
In addition, we were able to demonstrate latency improvement, and specifically 99.99% tail latency improvement of up to x2-5 (depends on the queue-depth).


Future work:
============
 - The Marvell nvme-tcp-offload "qedn" host driver. This driver will interact with the qed core module, in a similar fashion to the existing ethernet (qede), rdma (qedr), iscsi (qedi) and fcoe
(qedf) drivers of the same product-line.
 - The nvme-tcp-offload ULP target abstraction layer.
 - The Marvell nvme-tcp-offload "qednt" target driver.
 
 
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
 drivers/nvme/host/fabrics.c     |    6 -
 drivers/nvme/host/fabrics.h     |    6 +
 drivers/nvme/host/tcp-offload.c | 1086 +++++++++++++++++++++++++++++++
 drivers/nvme/host/tcp-offload.h |  184 ++++++
 include/linux/nvme.h            |    1 +
 7 files changed, 1296 insertions(+), 6 deletions(-)
 create mode 100644 drivers/nvme/host/tcp-offload.c
 create mode 100644 drivers/nvme/host/tcp-offload.h

-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
