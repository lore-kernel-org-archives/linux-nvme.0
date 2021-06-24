Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532CEC49EA6
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 17:24:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EB10613F2
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 17:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EB10613F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=ZxDvUCGB/BFtc1+FfOP5Li8qFBVPHRBF2pSPdm5HMB0=; b=e09RYO6YBRJp9L
	BLryNRWh70ZKt1QxG4qZrwNmlRRpNpEcjERUFUOV3+rbW7sCrwNh5R76IYNsXm7BxojicrvD7eO7B
	MIP9IUCkISG9PSUozlIh0w0vn6LYraUfFcGY1VGG9iqXSKGgUQ5UmUmjrclS6zZLTXRGkJTj1LJwS
	uuyLCqZ1o8GxeHXzYRXVq5wnU/3VB6F9MDaH5odT1JxZonU+q5q2BQEu6Uk1/aoA3eXFKyFDtEDQT
	jSRjf53bHgSk2zdaBVQ+HfS0h9Da/q0ZHJyY7x2nwAbq5DkHGxk/c+/AsVqECMVUMvWPmbStlIH+s
	FUKIEbOoJ0xIZCPU7k2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwT5r-00Fd0d-Pu; Thu, 24 Jun 2021 17:24:47 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwT5n-00Fcyd-4w
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 17:24:46 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15OHA2XO017647; Thu, 24 Jun 2021 10:24:29 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 39cgc8bm42-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 24 Jun 2021 10:24:28 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Thu, 24 Jun 2021 10:24:27 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.18 via Frontend Transport; Thu, 24 Jun 2021 10:24:24 -0700
From: Shai Malin <smalin@marvell.com>
To: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
 <axboe@fb.com>, <kbusch@kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <aelior@marvell.com>,
 <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <prabhakar.pkin@gmail.com>,
 <malin1024@gmail.com>, <smalin@marvell.com>
Subject: [PATCH v3 00/20] NVMeTCP Offload ULP
Date: Thu, 24 Jun 2021 20:23:50 +0300
Message-ID: <20210624172410.14225-1-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: XoGMFN1SaFt7mYQSN7O4vG4qbb3z6SyL
X-Proofpoint-GUID: XoGMFN1SaFt7mYQSN7O4vG4qbb3z6SyL
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-06-24_12:2021-06-24,
 2021-06-24 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_102443_300715_155A964D 
X-CRM114-Status: GOOD (  24.63  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

With the goal of enabling a generic infrastructure that allows NVMe/TCP
offload devices like NICs to seamlessly plug into the NVMe-oF stack, this
patch series introduces the nvme-tcp-offload ULP host layer, which will
be a new transport type called "tcp-offload" and will serve as an 
abstraction layer to work with device specific nvme-tcp offload drivers.

NVMeTCP offload is a full offload of the NVMeTCP protocol, this includes 
both the TCP level and the NVMeTCP level.

The nvme-tcp-offload transport can co-exist with the existing tcp and 
other transports. The tcp offload was designed so that stack changes are 
kept to a bare minimum: only registering new transports.
All other APIs, ops etc. are identical to the regular tcp transport.
Representing the TCP offload as a new transport allows clear and manageable
differentiation between the connections which should use the offload path 
and those that are not offloaded (even on the same device).

The nvme-tcp-offload layers and API compared to nvme-tcp and nvme-rdma:

* NVMe layer: *

       [ nvme/nvme-fabrics/blk-mq ]
             |
        (nvme API and blk-mq API)
             |
             |			 
* Transport layer: *

      [ nvme-rdma ] [ nvme-tcp ] [ nvme-tcp-offload ]
             |        |             |
           (Verbs) 
             |        |             |
             |     (Socket)
             |        |             |
             |        |        (nvme-tcp-offload API)
             |        |             |
             |        |             |
* Transport Driver: *

             |        |             |
      [ RDMA driver ]       
                      |             |
             [ Network driver ]
                                    |
                       [ NVMeTCP Offload driver ]

Upstream plan:
==============
As discussed in RFCV7, "NVMeTCP Offload ULP and QEDN Device Driver" 
contains 3 parts:
https://lore.kernel.org/linux-nvme/20210531225222.16992-1-smalin@marvell.com/

This series contains part1 and part3, intended for linux-nvme:
- Part 1: The nvme-tcp-offload patches
- Part 3: Marvell's Offload device driver(qedn) patches. 
          It has "compilation dependency" on both Part 1 and Part 2. 

Part 2 is already accepted in net-next.git:
https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=eda1bc65b0dc1b03006e427430ba23746ec44714


Usage:
======
The user will interact with the network-device in order to configure 
the ip/vlan - Logically similar to the RDMA model.
The NVMeTCP configuration is populated as part of the 
nvme connect command.

Example:
Assign IP to the net-device (from any existing Linux tool):

    ip addr add 100.100.0.101/24 dev p1p1

This IP will be used by both net-device and offload-device.

In order to connect from "sw" nvme-tcp through the net-device:

    nvme connect -t tcp -s 4420 -a 100.100.0.100 -n testnqn

In order to connect from "offload" nvme-tcp through the offload-device:

    nvme connect -t tcp_offload -s 4420 -a 100.100.0.100 -n testnqn
	
An alternative approach, and as a future enhancement that will not impact this 
series will be to modify nvme-cli with a new flag that will determine 
if "-t tcp" should be the regular nvme-tcp (which will be the default) 
or nvme-tcp-offload.
Exmaple:
    nvme connect -t tcp -s 4420 -a 100.100.0.100 -n testnqn -[new flag]


Queue Initialization Design:
============================
The nvme-tcp-offload ULP module shall register with the existing 
nvmf_transport_ops (.name = "tcp_offload"), nvme_ctrl_ops and blk_mq_ops.
The nvme-tcp-offload driver shall register to nvme-tcp-offload ULP
with the following ops:
- claim_dev() - in order to resolve the route to the target according to
                the paired net_dev.
- create_queue() - in order to create offloaded nvme-tcp queue.

The nvme-tcp-offload ULP module shall manage all the controller level
functionalities, call claim_dev and based on the return values shall call
the relevant module create_queue in order to create the admin queue and
the IO queues.


IO-path Design:
===============
The nvme-tcp-offload shall work at the IO-level - the nvme-tcp-offload 
ULP module shall pass the request (the IO) to the nvme-tcp-offload 
driver and later, the nvme-tcp-offload driver returns the request
completion (the IO completion).
No additional handling is needed in between; this design will reduce the
CPU utilization as we will describe below.

The nvme-tcp-offload driver shall register to nvme-tcp-offload ULP
with the following IO-path ops:
- send_req() - in order to pass the request to the handling of the
               offload driver that shall pass it to the offload device 
			   specific device.
- poll_queue()

Once the IO completes, the nvme-tcp-offload driver shall call 
command.done() that will invoke the nvme-tcp-offload ULP layer to
complete the request.


Teardown and errors:
====================
In case of NVMeTCP queue error the nvme-tcp-offload driver shall
call the nvme_tcp_ofld_report_queue_err.
The nvme-tcp-offload driver shall register to nvme-tcp-offload ULP
with the following teardown ops:
- drain_queue()
- destroy_queue()


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


Changes since RFC v1:
=====================
- nvme-tcp-offload: Fix nvme_tcp_ofld_ops return values.
- nvme-tcp-offload: Remove NVMF_TRTYPE_TCP_OFFLOAD.
- nvme-tcp-offload: Add nvme_tcp_ofld_poll() implementation.
- nvme-tcp-offload: Fix nvme_tcp_ofld_queue_rq() to check map_sg() and 
  send_req() return values.

Changes since RFC v2:
=====================
- nvme-tcp-offload: Fixes in controller and queue level (patches 3-6).
- qedn: Add the Marvell's NVMeTCP HW offload device driver init and probe
  (patches 8-11).
  
Changes since RFC v3:
=====================
- nvme-tcp-offload: Add the full implementation of the nvme-tcp-offload layer 
  including the new ops: setup_ctrl(), release_ctrl(), commit_rqs() and new 
  flows (ASYNC and timeout).
- nvme-tcp-offload: Add device maximums: max_hw_sectors, max_segments.
- nvme-tcp-offload: layer design and optimization changes.
- qedn: Add full implementation for the conn level, IO path and error handling.

Changes since RFC v4:
=====================
(Many thanks to Hannes Reinecke for his feedback)
- nvme_tcp_offload: Add num_hw_vectors in order to limit the number of queues.
- nvme_tcp_offload: Add per device private_data.
- nvme_tcp_offload: Fix header digest, data digest and tos initialization.
- qedn: Remove the qedn_global list.
- qedn: Remove the workqueue flow from send_req.
- qedn: Add db_recovery support.

Changes since RFC v5:
=====================
(Many thanks to Sagi Grimberg for his feedback)
- nvme-fabrics: Expose nvmf_check_required_opts() globally (as a new patch).
- nvme_tcp_offload: Remove io-queues BLK_MQ_F_BLOCKING.
- nvme_tcp_offload: Fix the nvme_tcp_ofld_stop_queue (drain_queue) flow.
- nvme_tcp_offload: Fix the nvme_tcp_ofld_free_queue (destroy_queue) flow.
- nvme_tcp_offload: Change rwsem to mutex.
- nvme_tcp_offload: remove redundant fields.
- nvme_tcp_offload: Remove the "new" from setup_ctrl().
- nvme_tcp_offload: Remove the init_req() and commit_rqs() ops.
- nvme_tcp_offload: Minor fixes in nvme_tcp_ofld_create_ctrl() ansd 
  nvme_tcp_ofld_free_queue().
- nvme_tcp_offload: Patch 8 (timeout and async) was squeashed into 
  patch 7 (io level).
- qedn: Fix the free_queue flow and the destroy_queue flow.
- qedn: Remove version number.

Changes since RFC v6:
=====================
- No changes in nvme_tcp_offload
- qedn: Remove redundant logic in the io-queues core affinity initialization.
- qedn: Remove qedn_validate_cccid_in_range().

Changes since v1:
=====================
- nvme_tcp_offload: Add support for NVME_OPT_HOST_IFACE.
- nvme_tcp_offload: Kconfig fix (thanks to Petr Mladek).
- nvme_tcp_offload: return code fix (thanks to Dan Carpenter).

Changes since v2:
=====================
- nvme_tcp_offload: Fix overly long lines.
- nvme_tcp_offload: use correct terminology for vendor driver.
- qedn: Added qedn driver as part of series.


Arie Gershberg (2):
  nvme-tcp-offload: Add controller level implementation
  nvme-tcp-offload: Add controller level error recovery implementation

Dean Balandin (3):
  nvme-tcp-offload: Add device scan implementation
  nvme-tcp-offload: Add queue level implementation
  nvme-tcp-offload: Add IO level implementation

Nikolay Assa (1):
  qedn: Add qedn_claim_dev API support

Prabhakar Kushwaha (7):
  nvme-fabrics: Move NVMF_ALLOWED_OPTS and NVMF_REQUIRED_OPTS
    definitions
  nvme-fabrics: Expose nvmf_check_required_opts() globally
  qedn: Add connection-level slowpath functionality
  qedn: Add support of configuring HW filter block
  qedn: Add support of Task and SGL
  qedn: Add support of NVME ICReq & ICResp
  qedn: Add support of ASYNC

Shai Malin (7):
  nvme-tcp-offload: Add nvme-tcp-offload - NVMeTCP HW offload ULP
  qedn: Add qedn - Marvell's NVMeTCP HW offload device driver
  qedn: Add qedn probe
  qedn: Add IRQ and fast-path resources initializations
  qedn: Add IO level qedn_send_req and fw_cq workqueue
  qedn: Add IO level fastpath functionality
  qedn: Add Connection and IO level recovery flows

 MAINTAINERS                      |   18 +
 drivers/nvme/Kconfig             |    1 +
 drivers/nvme/Makefile            |    1 +
 drivers/nvme/host/Kconfig        |   15 +
 drivers/nvme/host/Makefile       |    3 +
 drivers/nvme/host/fabrics.c      |   12 +-
 drivers/nvme/host/fabrics.h      |    9 +
 drivers/nvme/host/tcp-offload.c  | 1345 ++++++++++++++++++++++++++++++
 drivers/nvme/host/tcp-offload.h  |  207 +++++
 drivers/nvme/hw/Kconfig          |    9 +
 drivers/nvme/hw/Makefile         |    3 +
 drivers/nvme/hw/qedn/Makefile    |    4 +
 drivers/nvme/hw/qedn/qedn.h      |  402 +++++++++
 drivers/nvme/hw/qedn/qedn_conn.c | 1076 ++++++++++++++++++++++++
 drivers/nvme/hw/qedn/qedn_main.c | 1109 ++++++++++++++++++++++++
 drivers/nvme/hw/qedn/qedn_task.c |  873 +++++++++++++++++++
 16 files changed, 5078 insertions(+), 9 deletions(-)
 create mode 100644 drivers/nvme/host/tcp-offload.c
 create mode 100644 drivers/nvme/host/tcp-offload.h
 create mode 100644 drivers/nvme/hw/Kconfig
 create mode 100644 drivers/nvme/hw/Makefile
 create mode 100644 drivers/nvme/hw/qedn/Makefile
 create mode 100644 drivers/nvme/hw/qedn/qedn.h
 create mode 100644 drivers/nvme/hw/qedn/qedn_conn.c
 create mode 100644 drivers/nvme/hw/qedn/qedn_main.c
 create mode 100644 drivers/nvme/hw/qedn/qedn_task.c

-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
