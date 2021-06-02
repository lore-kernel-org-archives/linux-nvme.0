Return-Path: <SRS0=uBfD=K4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A17C4708F
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 17:18:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB22C61CB1
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jun 2021 17:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB22C61CB1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=/tLeX4vTHyR40mE6hOU8lTk1XCH7G9/Dw//M1moDB48=; b=z0p
	/8DTYdx821nFZqqXvVexxNSOCAQIh3ljyL49mBmSQFONVkObIGWYRu2ihdZP07DwCV1GvXsw/6Dbx
	SeQdgpuv6G1rbWaajwZEP3EcxWDb6uUDRalyzwy2PJw+a+Ez3xlIRFylFTJ9FctFuUy9fVlvr7Hh3
	QdGl//hr0/NK0BZKyZJEV69YXUmQyycZ/PRkQu8tB6gLC5vFKw18V309cykVy54aApBrx2iBLm3OH
	vyJhXKssDw0r8qnFXebEEZfKONuzkOdjZKpoYS9Am2Gx90XO+t7po0gnKaAR9VFGZaJ9zxQGg6Dei
	OhNiA9+E80I6Tp4hbXr3lrxaUJ62TWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1loUVk-005TOE-6e; Wed, 02 Jun 2021 17:18:32 +0000
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]
 helo=mx0b-0016f401.pphosted.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1loUUu-005T0P-Iu
 for linux-nvme@lists.infradead.org; Wed, 02 Jun 2021 17:17:42 +0000
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 152HFhot018964; Wed, 2 Jun 2021 10:17:26 -0700
Received: from dc5-exch02.marvell.com ([199.233.59.182])
 by mx0a-0016f401.pphosted.com with ESMTP id 38xe7xr09e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
 Wed, 02 Jun 2021 10:17:26 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
 Wed, 2 Jun 2021 10:17:25 -0700
Received: from lbtlvb-pcie154.il.qlogic.org (10.69.176.80) by
 DC5-EXCH01.marvell.com (10.69.176.38) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 2 Jun 2021 10:17:21 -0700
From: Shai Malin <smalin@marvell.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>
CC: <linux-nvme@lists.infradead.org>, <sagi@grimberg.me>, <hch@lst.de>,
 <axboe@fb.com>, <kbusch@kernel.org>, <aelior@marvell.com>,
 <mkalderon@marvell.com>, <okulkarni@marvell.com>,
 <pkushwaha@marvell.com>, <prabhakar.pkin@gmail.com>,
 <malin1024@gmail.com>, <smalin@marvell.com>
Subject: [PATCH 0/7] QED NVMeTCP Offload
Date: Wed, 2 Jun 2021 20:16:48 +0300
Message-ID: <20210602171655.23581-1-smalin@marvell.com>
X-Mailer: git-send-email 2.16.6
MIME-Version: 1.0
X-Proofpoint-ORIG-GUID: xdW0Xul88ga1vDTMpkdjKGmce_1QEYws
X-Proofpoint-GUID: xdW0Xul88ga1vDTMpkdjKGmce_1QEYws
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-06-02_09:2021-06-02,
 2021-06-02 signatures=0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210602_101740_692151_F7E5A847 
X-CRM114-Status: GOOD (  21.47  )
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
Content-Type: multipart/mixed; boundary="===============5438246328833170557=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============5438246328833170557==
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit

Hi Dave,

Intro:
======
This is the qed part of Marvell’s NVMeTCP offload series, shared as 
RFC series "NVMeTCP Offload ULP and QEDN Device Drive".
This part is a standalone series, and is not dependent on other parts 
of the RFC.
The overall goal is to add qedn as the offload driver for NVMeTCP, 
alongside the existing offload drivers (qedr, qedi and qedf for rdma, 
iscsi and fcoe respectively).

In this series we are making the necessary changes to qed to enable this 
by exposing APIs for FW/HW initializations.

The qedn series (and required changes to NVMe stack) will be sent to the 
linux-nvme mailing list.
I have included more details on the upstream plan under section with the 
same name below.


The Series Patches:
===================
1. qed: Add TCP_ULP FW resource layout – replacing iSCSI when common 
   with NVMeTCP.
2. qed: Add NVMeTCP Offload PF Level FW and HW HSI.
3. qed: Add NVMeTCP Offload Connection Level FW and HW HSI.
4. qed: Add support of HW filter block – enables redirecting NVMeTCP 
   traffic to the dedicated PF.
5. qed: Add NVMeTCP Offload IO Level FW and HW HSI.
6. qed: Add NVMeTCP Offload IO Level FW Initializations.
7. qed: Add IP services APIs support –VLAN, IP routing and reserving 
   TCP ports for the offload device.


The NVMeTCP Offload:
====================
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


Upstream Plan:
=============
The RFC series "NVMeTCP Offload ULP and QEDN Device Driver" 
https://lore.kernel.org/netdev/20210531225222.16992-1-smalin@marvell.com/
was designed in a modular way so that part 1 (nvme-tcp-offload) and 
part 2 (qed) are independent and part 3 (qedn) depends on both parts 1+2.

- Part 1 (RFC patch 1-8): NVMeTCP Offload ULP
  The nvme-tcp-offload patches, will be sent to 
  'linux-nvme@lists.infradead.org'.
  
- Part 2 (RFC patches 9-15): QED NVMeTCP Offload
  The qed infrastructure, will be sent to 'netdev@vger.kernel.org'.

Once part 1 and 2 are accepted:

- Part 3 (RFC patches 16-27): QEDN NVMeTCP Offload
  The qedn patches, will be sent to 'linux-nvme@lists.infradead.org'.


Changes since RFC v1,2:
=====================
- No changes in qed (only in nvme-tcp-offload and qedn).

Changes since RFC v3:
=====================
- qed: Add support for the new AHP HW. 

Changes since RFC v4:
=====================
(Many thanks to Hannes Reinecke for his feedback)
- qed: Add TCP_ULP FW resource layout.
- qed: Fix ipv4/ipv6 address initialization.
- qed: Replace structures with nvme-tcp.h structures.

Changes since RFC v5,6:
=====================
- No changes in qed (only in nvme-tcp-offload and qedn).


Nikolay Assa (1):
  qed: Add IP services APIs support

Omkar Kulkarni (1):
  qed: Add TCP_ULP FW resource layout

Prabhakar Kushwaha (1):
  qed: Add support of HW filter block

Shai Malin (4):
  qed: Add NVMeTCP Offload PF Level FW and HW HSI
  qed: Add NVMeTCP Offload Connection Level FW and HW HSI
  qed: Add NVMeTCP Offload IO Level FW and HW HSI
  qed: Add NVMeTCP Offload IO Level FW Initializations

 drivers/net/ethernet/qlogic/Kconfig           |   3 +
 drivers/net/ethernet/qlogic/qed/Makefile      |   5 +
 drivers/net/ethernet/qlogic/qed/qed.h         |  14 +
 drivers/net/ethernet/qlogic/qed/qed_cxt.c     |  45 +-
 drivers/net/ethernet/qlogic/qed/qed_cxt.h     |   2 +-
 drivers/net/ethernet/qlogic/qed/qed_dev.c     | 140 ++-
 drivers/net/ethernet/qlogic/qed/qed_hsi.h     |   6 +-
 drivers/net/ethernet/qlogic/qed/qed_iscsi.c   |  20 +-
 drivers/net/ethernet/qlogic/qed/qed_ll2.c     |  40 +-
 drivers/net/ethernet/qlogic/qed/qed_mcp.c     |   3 +
 drivers/net/ethernet/qlogic/qed/qed_mng_tlv.c |   3 +-
 drivers/net/ethernet/qlogic/qed/qed_nvmetcp.c | 829 ++++++++++++++++++
 drivers/net/ethernet/qlogic/qed/qed_nvmetcp.h | 103 +++
 .../qlogic/qed/qed_nvmetcp_fw_funcs.c         | 376 ++++++++
 .../qlogic/qed/qed_nvmetcp_fw_funcs.h         |  40 +
 .../qlogic/qed/qed_nvmetcp_ip_services.c      | 238 +++++
 drivers/net/ethernet/qlogic/qed/qed_ooo.c     |   5 +-
 drivers/net/ethernet/qlogic/qed/qed_sp.h      |   5 +
 .../net/ethernet/qlogic/qed/qed_sp_commands.c |   3 +-
 include/linux/qed/common_hsi.h                |   2 +-
 include/linux/qed/nvmetcp_common.h            | 531 +++++++++++
 include/linux/qed/qed_if.h                    |  18 +
 include/linux/qed/qed_ll2_if.h                |   2 +-
 include/linux/qed/qed_nvmetcp_if.h            | 240 +++++
 .../linux/qed/qed_nvmetcp_ip_services_if.h    |  29 +
 25 files changed, 2650 insertions(+), 52 deletions(-)
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_nvmetcp.c
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_nvmetcp.h
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_nvmetcp_fw_funcs.c
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_nvmetcp_fw_funcs.h
 create mode 100644 drivers/net/ethernet/qlogic/qed/qed_nvmetcp_ip_services.c
 create mode 100644 include/linux/qed/nvmetcp_common.h
 create mode 100644 include/linux/qed/qed_nvmetcp_if.h
 create mode 100644 include/linux/qed/qed_nvmetcp_ip_services_if.h

-- 
2.22.0



--===============5438246328833170557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============5438246328833170557==--
