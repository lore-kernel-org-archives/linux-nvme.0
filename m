Return-Path: <SRS0=y/hj=KX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC8FC4707F
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 00:02:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED62561184
	for <linux-nvme@archiver.kernel.org>; Fri, 28 May 2021 00:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED62561184
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=E0ZFkYE+sL9Tf1ZT0E84EFkn7rNncdQV49uMWT1QH4I=; b=Qjau4iD4SP8uct
	yQxIbCbQm8TSAiMyni9RY+JeDBW/LJA0TJau0rXFr3nKQfywlouvCBVmfxMN7KcetpTwr66nZZA+/
	yFEgPjhbrmTr3opEwVoeYQzj1keSrowAS+Y10KaVKCH34EqTiASzXNfhuNmlQ5eOFJ3QVdDbGkV4T
	1w58bm6NZwyt5a23CjRV1LaBNQ/tjkT4MGQjRg0bOWwjNzW955aHDFGDTzZcvuuldLkdoAAVRlNmV
	DR40WWCATFW2Mf8oyfLJvsQwzbn9Fbh0A/85IXtPcDXsXSPR1CsQ7XUqAYJjAJcZdDzdVKihqqncy
	svYMxLENsxKRxa9FfUBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmPwa-00AQJ0-JV; Fri, 28 May 2021 00:01:40 +0000
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmPvU-00APeH-5N
 for linux-nvme@lists.infradead.org; Fri, 28 May 2021 00:00:35 +0000
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14RNp1JO024312; Thu, 27 May 2021 17:00:13 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0b-0016f401.pphosted.com with ESMTP id 38sxpmcyur-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Thu, 27 May 2021 17:00:13 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Thu, 27 May 2021 17:00:11 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH02.marvell.com (10.69.176.39) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Thu, 27 May 2021 17:00:07 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <davem@davemloft.net>, <kuba@kernel.org>, <sagi@grimberg.me>,
 <hch@lst.de>, <axboe@fb.com>, <kbusch@kernel.org>
CC: <aelior@marvell.com>, <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <malin1024@gmail.com>, <smalin@marvell.com>
Subject: [RFC PATCH v6 00/27] NVMeTCP Offload ULP and QEDN Device Driver
Date: Fri, 28 May 2021 02:58:35 +0300
Message-ID: <20210527235902.2185-1-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: zfwCD2IdgT8vwNYRQkj1XQFzl_B83JWI
X-Proofpoint-GUID: zfwCD2IdgT8vwNYRQkj1XQFzl_B83JWI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-27_13:2021-05-27,
 2021-05-27 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_170032_427576_962C8D00 
X-CRM114-Status: GOOD (  25.28  )
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

The nvme-tcp-offload layers and API compared to nvme-tcp and nvme-rdma:

* NVMe layer: *

       [ nvme/nvme-fabrics/blk-mq ]
             |
        (nvme API and blk-mq API)
             |
             |			 
* Vendor agnostic transport layer: *

      [ nvme-rdma ] [ nvme-tcp ] [ nvme-tcp-offload ]
             |        |             |
           (Verbs) 
             |        |             |
             |     (Socket)
             |        |             |
             |        |        (nvme-tcp-offload API)
             |        |             |
             |        |             |
* Vendor Specific Driver: *

             |        |             |
           [ qedr ]       
                      |             |
                   [ qede ]
                                    |
                                  [ qedn ]


Performance:
============
With this implementation on top of the Marvell qedn driver (using the
Marvell FastLinQ NIC), we were able to demonstrate the following CPU
utilization improvement:

On AMD EPYC 7402, 2.80GHz, 28 cores:
- For 16K queued read IOs, 16jobs, 4qd (50Gbps line rate): 
  Improved the CPU utilization from 15.1% with NVMeTCP SW to 4.7% with 
  NVMeTCP offload.

On Intel(R) Xeon(R) Gold 5122 CPU, 3.60GHz, 16 cores: 
- For 512K queued read IOs, 16jobs, 4qd (25Gbps line rate): 
  Improved the CPU utilization from 16.3% with NVMeTCP SW to 1.1% with 
  NVMeTCP offload.

In addition, we were able to demonstrate the following latency improvement:
- For 200K read IOPS (16 jobs, 16 qd, with fio rate limiter):
  Improved the average latency from 105 usec with NVMeTCP SW to 39 usec 
  with NVMeTCP offload.
  
  Improved the 99.99 tail latency from 570 usec with NVMeTCP SW to 91 usec 
  with NVMeTCP offload.

The end-to-end offload latency was measured from fio while running against 
back end of null device.


Upstream plan:
==============
Following this RFC, the series will be sent in a modular way so that 
part 1 (nvme-tcp-offload) and part 2 (qed) are independent and part 3 (qedn) 
depends on both parts 1+2.

- Part 1 (Patch 1-8): 
  The nvme-tcp-offload patches, will be sent to 
  'linux-nvme@lists.infradead.org'.
  
- Part 2 (Patches 9-15):
  The qed infrastructure, will be sent to 'netdev@vger.kernel.org'.

- Part 3 (Packet 16-27):
  The qedn patches, will be sent to 'linux-nvme@lists.infradead.org'.
 
Marvell is fully committed to maintain, test, and address issues with 
the new nvme-tcp-offload layer.
 

Usage:
======
With the Marvell NVMeTCP offload design, the network-device (qede) and the 
offload-device (qedn) are paired on each port - Logically similar to the 
RDMA model.
The user will interact with the network-device in order to configure 
the ip/vlan. The NVMeTCP configuration is populated as part of the 
nvme connect command.

Example:
Assign IP to the net-device (from any existing Linux tool):

    ip addr add 100.100.0.101/24 dev p1p1

This IP will be used by both net-device (qede) and offload-device (qedn).

In order to connect from "sw" nvme-tcp through the net-device (qede):

    nvme connect -t tcp -s 4420 -a 100.100.0.100 -n testnqn

In order to connect from "offload" nvme-tcp through the offload-device (qedn):

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
The nvme-tcp-offload vendor driver shall register to nvme-tcp-offload ULP
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
ULP module shall pass the request (the IO) to the nvme-tcp-offload vendor
driver and later, the nvme-tcp-offload vendor driver returns the request
completion (the IO completion).
No additional handling is needed in between; this design will reduce the
CPU utilization as we will describe below.

The nvme-tcp-offload vendor driver shall register to nvme-tcp-offload ULP
with the following IO-path ops:
- send_req() - in order to pass the request to the handling of the
               offload driver that shall pass it to the vendor specific device.
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


nvme-tcp-offload Future work:
=================
- NVMF_OPT_HOST_IFACE Support.

QEDN Future work:
=================
- FW changes in order to remove swapping requirements from qedn driver.
- Support extended HW resources.
- Digest support.
- Devlink support for device configuration and TCP offload configurations.
- Statistics

 
Long term future work:
======================
- The nvme-tcp-offload ULP target abstraction layer.
- The Marvell nvme-tcp-offload "qednt" target driver.


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
- qedn: Add the Marvell's NVMeTCP HW offload vendor driver init and probe
  (patches 8-11).
  
Changes since RFC v3:
=====================
- nvme-tcp-offload: Add the full implementation of the nvme-tcp-offload layer 
  including the new ops: setup_ctrl(), release_ctrl(), commit_rqs() and new 
  flows (ASYNC and timeout).
- nvme-tcp-offload: Add device maximums: max_hw_sectors, max_segments.
- nvme-tcp-offload: layer design and optimization changes.
- qedn: Add full implementation for the conn level, IO path and error handling.
- qed: Add support for the new AHP HW. 

Changes since RFC v4:
=====================
(Many thanks to Hannes Reinecke for his feedback)
- nvme_tcp_offload: Add num_hw_vectors in order to limit the number of queues.
- nvme_tcp_offload: Add per device private_data.
- nvme_tcp_offload: Fix header digest, data digest and tos initialization.
- qed: Add TCP_ULP FW resource layout.
- qed: Fix ipv4/ipv6 address initialization.
- qed, qedn: Replace structures with nvme-tcp.h structures.
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
- nvme_tcp_offload: Minor fixes in nvme_tcp_ofld_create_ctrl() and 
  nvme_tcp_ofld_free_queue().
- nvme_tcp_offload: Patch 8 (timeout and async) was squeashed into 
  patch 7 (io level).
- qedn: Fix the free_queue flow and the destroy_queue flow.
- qedn: Remove version number.


Arie Gershberg (3):
  nvme-fabrics: Move NVMF_ALLOWED_OPTS and NVMF_REQUIRED_OPTS
    definitions
  nvme-tcp-offload: Add controller level implementation
  nvme-tcp-offload: Add controller level error recovery implementation

Dean Balandin (3):
  nvme-tcp-offload: Add device scan implementation
  nvme-tcp-offload: Add queue level implementation
  nvme-tcp-offload: Add IO level implementation

Nikolay Assa (2):
  qed: Add IP services APIs support
  qedn: Add qedn_claim_dev API support

Omkar Kulkarni (1):
  qed: Add TCP_ULP FW resource layout

Prabhakar Kushwaha (7):
  nvme-fabrics: Expose nvmf_check_required_opts() globally
  qed: Add support of HW filter block
  qedn: Add connection-level slowpath functionality
  qedn: Add support of configuring HW filter block
  qedn: Add support of Task and SGL
  qedn: Add support of NVME ICReq & ICResp
  qedn: Add support of ASYNC

Shai Malin (11):
  nvme-tcp-offload: Add nvme-tcp-offload - NVMeTCP HW offload ULP
  qed: Add NVMeTCP Offload PF Level FW and HW HSI
  qed: Add NVMeTCP Offload Connection Level FW and HW HSI
  qed: Add NVMeTCP Offload IO Level FW and HW HSI
  qed: Add NVMeTCP Offload IO Level FW Initializations
  qedn: Add qedn - Marvell's NVMeTCP HW offload vendor driver
  qedn: Add qedn probe
  qedn: Add IRQ and fast-path resources initializations
  qedn: Add IO level qedn_send_req and fw_cq workqueue
  qedn: Add IO level fastpath functionality
  qedn: Add Connection and IO level recovery flows

 MAINTAINERS                                   |   18 +
 drivers/net/ethernet/qlogic/Kconfig           |    3 +
 drivers/net/ethernet/qlogic/qed/Makefile      |    5 +
 drivers/net/ethernet/qlogic/qed/qed.h         |   16 +
 drivers/net/ethernet/qlogic/qed/qed_cxt.c     |   44 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.h     |    2 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c     |  157 +-
 drivers/net/ethernet/qlogic/qed/qed_hsi.h     |    6 +-
 drivers/net/ethernet/qlogic/qed/qed_iscsi.c   |   20 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c     |   40 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c     |    3 +
 drivers/net/ethernet/qlogic/qed/qed_mng_tlv.c |    3 +-
 drivers/net/ethernet/qlogic/qed/qed_nvmetcp.c |  870 +++++++++++
 drivers/net/ethernet/qlogic/qed/qed_nvmetcp.h |  114 ++
 .../qlogic/qed/qed_nvmetcp_fw_funcs.c         |  379 +++++
 .../qlogic/qed/qed_nvmetcp_fw_funcs.h         |   43 +
 .../qlogic/qed/qed_nvmetcp_ip_services.c      |  239 +++
 drivers/net/ethernet/qlogic/qed/qed_ooo.c     |    5 +-
 drivers/net/ethernet/qlogic/qed/qed_sp.h      |    5 +
 .../net/ethernet/qlogic/qed/qed_sp_commands.c |    3 +-
 drivers/nvme/Kconfig                          |    1 +
 drivers/nvme/Makefile                         |    1 +
 drivers/nvme/host/Kconfig                     |   16 +
 drivers/nvme/host/Makefile                    |    3 +
 drivers/nvme/host/fabrics.c                   |   12 +-
 drivers/nvme/host/fabrics.h                   |    9 +
 drivers/nvme/host/tcp-offload.c               | 1319 +++++++++++++++++
 drivers/nvme/host/tcp-offload.h               |  205 +++
 drivers/nvme/hw/Kconfig                       |    9 +
 drivers/nvme/hw/Makefile                      |    3 +
 drivers/nvme/hw/qedn/Makefile                 |    4 +
 drivers/nvme/hw/qedn/qedn.h                   |  405 +++++
 drivers/nvme/hw/qedn/qedn_conn.c              | 1034 +++++++++++++
 drivers/nvme/hw/qedn/qedn_main.c              | 1111 ++++++++++++++
 drivers/nvme/hw/qedn/qedn_task.c              |  863 +++++++++++
 include/linux/qed/common_hsi.h                |    2 +-
 include/linux/qed/nvmetcp_common.h            |  531 +++++++
 include/linux/qed/qed_if.h                    |   22 +
 include/linux/qed/qed_ll2_if.h                |    2 +-
 include/linux/qed/qed_nvmetcp_if.h            |  241 +++
 .../linux/qed/qed_nvmetcp_ip_services_if.h    |   29 +
 41 files changed, 7738 insertions(+), 59 deletions(-)
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_nvmetcp.c
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_nvmetcp.h
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_nvmetcp_fw_funcs.c
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_nvmetcp_fw_funcs.h
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_nvmetcp_ip_services.c
 create mode 100644 drivers/nvme/host/tcp-offload.c
 create mode 100644 drivers/nvme/host/tcp-offload.h
 create mode 100644 drivers/nvme/hw/Kconfig
 create mode 100644 drivers/nvme/hw/Makefile
 create mode 100644 drivers/nvme/hw/qedn/Makefile
 create mode 100644 drivers/nvme/hw/qedn/qedn.h
 create mode 100644 drivers/nvme/hw/qedn/qedn_conn.c
 create mode 100644 drivers/nvme/hw/qedn/qedn_main.c
 create mode 100644 drivers/nvme/hw/qedn/qedn_task.c
 create mode 100644 include/linux/qed/nvmetcp_common.h
 create mode 100644 include/linux/qed/qed_nvmetcp_if.h
 create mode 100644 include/linux/qed/qed_nvmetcp_ip_services_if.h

-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
