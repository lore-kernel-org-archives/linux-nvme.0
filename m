Return-Path: <SRS0=2jH7=HJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E36AAC433DB
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 18:14:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70E5C64D9A
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Feb 2021 18:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70E5C64D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qBKTFzZ4jvTbkiM65F/9jv/Gs1dEp4jsI5fZ1yYwucU=; b=G0l1rxlq8vix3U5cqb7DU6X8JL
	v0m4Qo3MIpEEF72GEmtFKUU7yGoHlcoo/i5g1e7LbNSAgPe3bdxl5DFejGiHTCILLuW5zGHXsw3fW
	v4OYYZAXbs9rsbcudHLevvPuY4VN3Fh2ShvIU+fzbmhLJ0NbmvdCgd+IleZZdPTND6NkWpDng0o1p
	k+c5eIJvo+ZezspeI/p+W4QVtOBW+3C8A18ntxb3SAR3G3HMYeoH4C7R8A8J/Kll2iZ79vHZVGYvU
	itC17yjUlFxGdQrxfPGLiqHIeqEt0AqVYK9p3F4g6sbpLl3e5BCnWV8GDi7lEiL7sVfeS/J1w8iSs
	05cqjrhA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l8oZJ-0004vH-Fg; Sun, 07 Feb 2021 18:13:57 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l8oZC-0004tC-VR
 for linux-nvme@lists.infradead.org; Sun, 07 Feb 2021 18:13:53 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 117I5Rew029232; Sun, 7 Feb 2021 10:13:32 -0800
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 36hsbrakky-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Sun, 07 Feb 2021 10:13:32 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 7 Feb 2021 10:13:31 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Sun, 7 Feb 2021 10:13:30 -0800
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Sun, 7 Feb 2021 10:13:27 -0800
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <sagi@grimberg.me>
Subject: [RFC PATCH v3 00/11] NVMeTCP Offload ULP and QEDN Device Driver
Date: Sun, 7 Feb 2021 20:13:13 +0200
Message-ID: <20210207181324.11429-1-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.737
 definitions=2021-02-07_08:2021-02-05,
 2021-02-07 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210207_131351_190702_A0AE8642 
X-CRM114-Status: GOOD (  18.49  )
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
Cc: smalin@marvell.com, aelior@marvell.com, mkalderon@marvell.com,
 nassa@marvell.com, malin1024@gmail.com, Douglas.Farley@dell.com,
 Erik.Smith@dell.com, kuba@kernel.org, pkushwaha@marvell.com,
 davem@davemloft.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


With the goal of enabling a generic infrastructure that allows NVMe/TCP 
offload devices like NICs to seamlessly plug into the NVMe-oF stack, this 
patch series introduces the nvme-tcp-offload ULP host layer, which will 
be a new transport type called "tcp-offload" and will serve as an 
abstraction layer to work with vendor specific nvme-tcp offload drivers.

NVMeTCP offload is a full offload of the NVMeTCP protocol, this includes 
both the TCP level and the NVMeTCP level.

The nvme-tcp-offload transport can co-exist with the existing tcp and 
other transports. The tcp offload was designed so that stack changes are 
kept to a bare minimum: only registering new transports. 
All other APIs, ops etc. are identical to the regular tcp transport.
Representing the TCP offload as a new transport allows clear and manageable
differentiation between the connections which should use the offload path
and those that are not offloaded (even on the same device).


Queue Initialization:
=====================
The nvme-tcp-offload ULP module shall register with the existing 
nvmf_transport_ops (.name = "tcp_offload"), nvme_ctrl_ops and blk_mq_ops.
The nvme-tcp-offload vendor driver shall register to nvme-tcp-offload ULP
with the following ops:
 - claim_dev() - in order to resolve the route to the target according to
                 the net_dev.
 - create_queue() - in order to create offloaded nvme-tcp queue.

The nvme-tcp-offload ULP module shall manage all the controller level
functionalities, call claim_dev and based on the return values shall call
the relevant module create_queue in order to create the admin queue and
the IO queues.


IO-path:
========
The nvme-tcp-offload shall work at the IO-level - the nvme-tcp-offload 
ULP module shall pass the request (the IO) to the nvme-tcp-offload vendor
driver and later, the nvme-tcp-offload vendor driver returns the request
completion (the IO completion).
No additional handling is needed in between; this design will reduce the
CPU utilization as we will describe below.

The nvme-tcp-offload vendor driver shall register to nvme-tcp-offload ULP
with the following IO-path ops:
 - init_req()
 - map_sg() - in order to map the request sg (similar to 
              nvme_rdma_map_data() ).
 - send_req() - in order to pass the request to the handling of the
                offload driver that shall pass it to the vendor specific
				device.
 - poll_queue()

Once the IO completes, the nvme-tcp-offload vendor driver shall call 
command.done() that will invoke the nvme-tcp-offload ULP layer to
complete the request.


TCP events:
===========
The Marvell FastLinQ NIC HW engine handle all the TCP re-transmissions
and OOO events.


Teardown and errors:
====================
In case of NVMeTCP queue error the nvme-tcp-offload vendor driver shall
call the nvme_tcp_ofld_report_queue_err.
The nvme-tcp-offload vendor driver shall register to nvme-tcp-offload ULP
with the following teardown ops:
 - drain_queue()
 - destroy_queue()
 

 The Marvell FastLinQ NIC HW engine:
====================================
The Marvell NIC HW engine is capable of offloading the entire TCP/IP
stack and managing up to 64K connections per PF, already implemented and 
upstream use cases for this include iWARP (by the Marvell qedr driver) 
and iSCSI (by the Marvell qedi driver).
In addition, the Marvell NIC HW engine offloads the NVMeTCP queue layer
and is able to manage the IO level also in case of TCP re-transmissions
and OOO events.
The HW engine enables direct data placement (including the data digest CRC
calculation and validation) and direct data transmission (including data
digest CRC calculation).


The Marvell qedn driver:
========================
The new driver will be added under "drivers/nvme/hw" and will be enabled
by the Kconfig "Marvell NVM Express over Fabrics TCP offload".
As part of the qedn init, the driver will register as a pci device driver 
and will work with the Marvell fastlinQ NIC.
As part of the probe, the driver will register to the nvme_tcp_offload
(ULP) and to the qed module (qed_nvmetcp_ops) - similar to other
"qed_*_ops" which are used by the qede, qedr, qedf and qedi device
drivers.
  
 
The series' patches:
===================
Patch 1-2       Add the nvme-tcp-offload ULP module, including the APIs.
Patches 3-5     nvme-tcp-offload ULP controller level functionalities.
Patch 6         nvme-tcp-offload ULP queue level functionalities.
Patch 7         nvme-tcp-offload ULP IO level functionalities.
Patch 8			nvme-qedn Marvell's NVMeTCP HW offload vendor driver.
Patch 9			net-qed NVMeTCP Offload PF level FW and HW HSI.
Patch 10-11		nvme-qedn probe level functionalities.


Performance:
============
With this implementation on top of the Marvell qedn driver (using the
Marvell FastLinQ NIC), we were able to demonstrate x3 CPU utilization
improvement for 4K queued read/write IOs and up to x20 in case of 512K
read/write IOs.
In addition, we were able to demonstrate latency improvement, and 
specifically 99.99% tail latency improvement of up to x2-5 (depends on
the queue-depth).


Future work:
============
For simplicity, the RFC series does not include the following 
functionalities which will be added based on the comments on patches 1-11.
 - nvme-tcp-offload teardown, IO timeout and async flows.
 - qedn device/queue/IO level.
 
 
Long term future work:
============
 - The nvme-tcp-offload ULP target abstraction layer.
 - The Marvell nvme-tcp-offload "qednt" target driver.


Changes since RFC v1:
=====================
- Fix nvme_tcp_ofld_ops return values.
- Remove NVMF_TRTYPE_TCP_OFFLOAD.
- Add nvme_tcp_ofld_poll() implementation.
- Fix nvme_tcp_ofld_queue_rq() to check map_sg() and send_req() return
  values.


Changes since RFC v2:
=====================
- Add qedn - Marvell's NVMeTCP HW offload vendor driver init and probe
  (patches 8-11).
- Fixes in controller and queue level (patches 3-6).
  

Arie Gershberg (3):
  nvme-fabrics: Move NVMF_ALLOWED_OPTS and NVMF_REQUIRED_OPTS
    definitions
  nvme-tcp-offload: Add controller level implementation
  nvme-tcp-offload: Add controller level error recovery implementation

Dean Balandin (3):
  nvme-tcp-offload: Add device scan implementation
  nvme-tcp-offload: Add queue level implementation
  nvme-tcp-offload: Add IO level implementation

Shai Malin (5):
  nvme-tcp-offload: Add nvme-tcp-offload - NVMeTCP HW offload ULP
  nvme-qedn: Add qedn - Marvell's NVMeTCP HW offload vendor driver
  net-qed: Add NVMeTCP Offload PF Level FW and HW HSI
  nvme-qedn: Add qedn probe
  nvme-qedn: Add IRQ and fast-path resources initializations

 MAINTAINERS                                   |   10 +
 drivers/net/ethernet/qlogic/Kconfig           |    3 +
 drivers/net/ethernet/qlogic/qed/Makefile      |    1 +
 drivers/net/ethernet/qlogic/qed/qed.h         |    3 +
 drivers/net/ethernet/qlogic/qed/qed_hsi.h     |    1 +
 drivers/net/ethernet/qlogic/qed/qed_nvmetcp.c |  269 ++++
 drivers/net/ethernet/qlogic/qed/qed_nvmetcp.h |   48 +
 drivers/net/ethernet/qlogic/qed/qed_sp.h      |    2 +
 drivers/nvme/Kconfig                          |    1 +
 drivers/nvme/Makefile                         |    1 +
 drivers/nvme/host/Kconfig                     |   16 +
 drivers/nvme/host/Makefile                    |    3 +
 drivers/nvme/host/fabrics.c                   |    7 -
 drivers/nvme/host/fabrics.h                   |    7 +
 drivers/nvme/host/tcp-offload.c               | 1123 +++++++++++++++++
 drivers/nvme/host/tcp-offload.h               |  185 +++
 drivers/nvme/hw/Kconfig                       |    9 +
 drivers/nvme/hw/Makefile                      |    3 +
 drivers/nvme/hw/qedn/Makefile                 |    3 +
 drivers/nvme/hw/qedn/qedn.c                   |  652 ++++++++++
 drivers/nvme/hw/qedn/qedn.h                   |   90 ++
 include/linux/qed/common_hsi.h                |    1 +
 include/linux/qed/nvmetcp_common.h            |   47 +
 include/linux/qed/qed_if.h                    |   22 +
 include/linux/qed/qed_nvmetcp_if.h            |   71 ++
 25 files changed, 2571 insertions(+), 7 deletions(-)
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_nvmetcp.c
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_nvmetcp.h
 create mode 100644 drivers/nvme/host/tcp-offload.c
 create mode 100644 drivers/nvme/host/tcp-offload.h
 create mode 100644 drivers/nvme/hw/Kconfig
 create mode 100644 drivers/nvme/hw/Makefile
 create mode 100644 drivers/nvme/hw/qedn/Makefile
 create mode 100644 drivers/nvme/hw/qedn/qedn.c
 create mode 100644 drivers/nvme/hw/qedn/qedn.h
 create mode 100644 include/linux/qed/nvmetcp_common.h
 create mode 100644 include/linux/qed/qed_nvmetcp_if.h

-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
