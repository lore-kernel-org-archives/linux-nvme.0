Return-Path: <SRS0=cPwJ=HN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C48C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 21:11:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E57DF64DCD
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Feb 2021 21:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E57DF64DCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=E8LFNEdh5Q5F3lTL/Z32eEtU348Ti7Rnq5NiEzRFwQI=; b=U9LWiCHA3849PAPYKDh1MSN9fx
	xESjoOVKMRIDMQRh8/GwO24LMFaCMVYxdQxxuAAiwWE7H4KntzYpJjTC88W37DnRdeSQFsqd1dM/q
	lNrQIMOg6VN84yq4xcZyyz7S8c3JAWiunEmfGwaiKEtIfF2R7/KjftCZyVhNqxrvSd6472emdjDir
	sNaZSYtdCvkjdEyTAmOOnhTqYlGgJ1CuIRLC8IJ8pBcg0EOoo1w0Efz3LjkDc3Lqp66wS+gA3usyD
	JLVMnQaM8gRqoV6TIu1ATS84m5p2ZXHjB/JPpov296UITZZDdaenSTg+9RvhOVhTh10GXLzoywwD6
	GAZTM99w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lAJEy-0003yO-NK; Thu, 11 Feb 2021 21:11:09 +0000
Received: from hqnvemgate26.nvidia.com ([216.228.121.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lAJEs-0003xZ-ED
 for linux-nvme@lists.infradead.org; Thu, 11 Feb 2021 21:11:04 +0000
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by
 hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
 id <B60259d630001>; Thu, 11 Feb 2021 13:10:59 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 11 Feb
 2021 21:10:52 +0000
Received: from vdi.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 11 Feb 2021 21:10:47 +0000
From: Boris Pismenny <borisp@mellanox.com>
To: <dsahern@gmail.com>, <kuba@kernel.org>, <davem@davemloft.net>,
 <saeedm@nvidia.com>, <hch@lst.de>, <sagi@grimberg.me>, <axboe@fb.com>,
 <kbusch@kernel.org>, <viro@zeniv.linux.org.uk>, <edumazet@google.com>,
 <smalin@marvell.com>
Subject: [PATCH v4 net-next  00/21] nvme-tcp receive offloads
Date: Thu, 11 Feb 2021 23:10:23 +0200
Message-ID: <20210211211044.32701-1-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210211_161102_654495_4728CF8E 
X-CRM114-Status: GOOD (  25.51  )
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
Cc: Boris Pismenny <borisp@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, benishay@nvidia.com, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Changes since v3:
=========================================
* Use DDP_TCP ifdefs in iov_iter and skb iterators to minimize impact
when compiled out (Christoph)
* Simplify netdev references and reduce the use of
get_netdev_for_sock (Sagi)
* Avoid "static" in it's own line, move it one line down (Christoph)
* Pass (queue, skb, *offset) and retrieve the pdu_seq in
nvme_tcp_resync_response (Sagi)
* Add missing assignment of offloading_netdev to null in offload_limits
error case (Sagi)
* Set req->offloaded = false once -- the lifetime rules are:
set to false on cmd_setup / set to true when ddp setup succeeds (Sagi)
* Replace pr_info_ratelimited with dev_info_ratelimited (Sagi)
* Add nvme_tcp_complete_request and invoke it from two similar call
sites (Sagi)
* Introduce nvme_tcp_req_map_sg earlier in the series (Sagi)
* Add nvme_tcp_consume_skb and put into it a hunk from
nvme_tcp_recv_data to handle copy with and without offload

Changes since v2:
=========================================
* Use skb->ddp_crc for copy offload to avoid skb_condense
* Default mellanox driver support to no (experimental feature)
* In iov_iter use non-ddp functions for kvec and iovec
* Remove typecasting in nvme-tcp

Changes since v1:
=========================================
* Rework iov_iter copy skip if src==dst to be less intrusive (David Ahern)
* Add tcp-ddp documentation (David Ahern)
* Refactor mellanox driver patches into more patches (Saeed Mahameed)
* Avoid pointer casting (David Ahern)
* Rename nvme-tcp offload flags (Shai Malin)
* Update cover-letter according to the above

Changes since RFC v1:
=========================================
* Split mlx5 driver patches to several commits
* Fix nvme-tcp handling of recovery flows. In particular, move queue offlaod
  init/teardown to the start/stop functions.

Overview
=========================================
This series adds support for nvme-tcp receive offloads
which do not mandate the offload of the network stack to the device.
Instead, these work together with TCP to offload:
1. copy from SKB to the block layer buffers
2. CRC verification for received PDU

The series implements these as a generic offload infrastructure for storage
protocols, which we call TCP Direct Data Placement (TCP_DDP) and TCP DDP CRC,
respectively. We use this infrastructure to implement NVMe-TCP offload for copy
and CRC. Future implementations can reuse the same infrastructure for other
protcols such as iSCSI.

Note:
These offloads are similar in nature to the packet-based NIC TLS offloads,
which are already upstream (see net/tls/tls_device.c).
You can read more about TLS offload here:
https://www.kernel.org/doc/html/latest/networking/tls-offload.html

Initialization and teardown:
=========================================
The offload for IO queues is initialized after the handshake of the
NVMe-TCP protocol is finished by calling `nvme_tcp_offload_socket`
with the tcp socket of the nvme_tcp_queue:
This operation sets all relevant hardware contexts in
hardware. If it fails, then the IO queue proceeds as usually with no offload.
If it succeeds then `nvme_tcp_setup_ddp` and `nvme_tcp_teardown_ddp` may be
called to perform copy offload, and crc offload will be used.
This initialization does not change the normal operation of nvme-tcp in any
way besides adding the option to call the above mentioned NDO operations.

For the admin queue, nvme-tcp does not initialize the offload.
Instead, nvme-tcp calls the driver to configure limits for the controller,
such as max_hw_sectors and max_segments; these must be limited to accomodate
potential HW resource limits, and to improve performance.

If some error occured, and the IO queue must be closed or reconnected, then
offload is teardown and initialized again. Additionally, we handle netdev
down events via the existing error recovery flow.

Copy offload works as follows:
=========================================
The nvme-tcp layer calls the NIC drive to map block layer buffers to ccid using
`nvme_tcp_setup_ddp` before sending the read request. When the repsonse is
received, then the NIC HW will write the PDU payload directly into the
designated buffer, and build an SKB such that it points into the destination
buffer; this SKB represents the entire packet received on the wire, but it
points to the block layer buffers. Once nvme-tcp attempts to copy data from
this SKB to the block layer buffer it can skip the copy by checking in the
copying function (memcpy_to_page):
if (src == dst) -> skip copy
Finally, when the PDU has been processed to completion, the nvme-tcp layer
releases the NIC HW context be calling `nvme_tcp_teardown_ddp` which
asynchronously unmaps the buffers from NIC HW.

As the copy skip change is in a sensative function, we are careful to avoid
changing it. To that end, we create alternative skb copy and hash iterators
that skip copy/hash if (src == dst). Nvme-tcp is the first user for these.

Asynchronous completion:
=========================================
The NIC must release its mapping between command IDs and the target buffers.
This mapping is released when NVMe-TCP calls the NIC
driver (`nvme_tcp_offload_socket`).
As completing IOs is performance criticial, we introduce asynchronous
completions for NVMe-TCP, i.e. NVMe-TCP calls the NIC, which will later
call NVMe-TCP to complete the IO (`nvme_tcp_ddp_teardown_done`).

An alternative approach is to move all the functions related to coping from
SKBs to the block layer buffers inside the nvme-tcp code - about 200 LOC.

CRC offload works as follows:
=========================================
After offload is initialized, we use the SKB's ddp_crc bit to indicate that:
"there was no problem with the verification of all CRC fields in this packet's
payload". The bit is set to zero if there was an error, or if HW skipped
offload for some reason. If *any* SKB in a PDU has (ddp_crc != 1), then software
must compute the CRC, and check it. We perform this check, and
accompanying software fallback at the end of the processing of a received PDU.

SKB changes:
=========================================
The CRC offload requires an additional bit in the SKB, which is useful for
preventing the coalescing of SKB with different crc offload values. This bit
is similar in concept to the "decrypted" bit. 

Performance:
=========================================
The expected performance gain from this offload varies with the block size.
We perform a CPU cycles breakdown of the copy/CRC operations in nvme-tcp
fio random read workloads:
For 4K blocks we see up to 11% improvement for a 100% read fio workload,
while for 128K blocks we see upto 52%. If we run nvme-tcp, and skip these
operations, then we observe a gain of about 1.1x and 2x respectively.

Resynchronization:
=========================================
The resynchronization flow is performed to reset the hardware tracking of
NVMe-TCP PDUs within the TCP stream. The flow consists of a request from
the driver, regarding a possible location of a PDU header. Followed by
a response from the nvme-tcp driver.

This flow is rare, and it should happen only after packet loss or
reordering events that involve nvme-tcp PDU headers.

The patches are organized as follows:
=========================================
Patch 1         the iov_iter change to skip copy if (src == dst).
Patches 2-4     the infrastructure for all TCP DDP.
                and TCP DDP CRC offloads, respectively.
Patch 5         exposes the get_netdev_for_sock function from TLS.
Patch 6         NVMe-TCP changes to call NIC driver on queue init/teardown.
Patches 7       NVMe-TCP changes to call NIC driver on IO operation.
                setup/teardown, and support async completions.
Patches 8       NVMe-TCP changes to support CRC offload on receive.
                Also, this patch moves CRC calculation to the end of PDU
                in case offload requires software fallback.
Patches 9       NVMe-TCP handling of netdev events: stop the offload if
                netdev is going down.
Patches 10-20   implement support for NVMe-TCP copy and CRC offload in
                the mlx5 NIC driver as the first user.
Patches 21      Document TCP DDP offload.

Testing:
=========================================
This series was tested using fio with various configurations of IO sizes,
depths, MTUs, and with both the SPDK and kernel NVMe-TCP targets.
Also, we have used QEMU and gate-level simulation to verify these patches.

Future work:
=========================================
A follow-up series will introduce support for transmit side CRC. Then,
we will work on adding support for TLS in NVMe-TCP and combining the
two offloads.

Ben Ben-Ishay (8):
  net/mlx5e: NVMEoTCP offload initialization
  net/mlx5e: KLM UMR helper macros
  net/mlx5e: NVMEoTCP use KLM UMRs
  net/mlx5e: NVMEoTCP queue init/teardown
  net/mlx5e: NVMEoTCP async ddp invalidation
  net/mlx5e: NVMEoTCP ddp setup and resync
  net/mlx5e: NVMEoTCP, data-path for DDP+CRC offload
  net/mlx5e: NVMEoTCP statistics

Ben Ben-ishay (2):
  net/mlx5: Header file changes for nvme-tcp offload
  net/mlx5: Add 128B CQE for NVMEoTCP offload

Boris Pismenny (9):
  net: Introduce direct data placement tcp offload
  net: Introduce crc offload for tcp ddp ulp
  iov_iter: DDP copy to iter/pages
  net: skb copy(+hash) iterators for DDP offloads
  net/tls: expose get_netdev_for_sock
  nvme-tcp: Add DDP offload control path
  nvme-tcp: Add DDP data-path
  net/mlx5e: TCP flow steering for nvme-tcp
  Documentation: add TCP DDP offload documentation

Or Gerlitz (1):
  nvme-tcp: Deal with netdevice DOWN events

Yoray Zack (1):
  nvme-tcp: RX CRC offload

 Documentation/networking/index.rst            |    1 +
 Documentation/networking/tcp-ddp-offload.rst  |  296 +++++
 .../net/ethernet/mellanox/mlx5/core/Kconfig   |   10 +
 .../net/ethernet/mellanox/mlx5/core/Makefile  |    2 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   31 +-
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |    4 +-
 .../ethernet/mellanox/mlx5/core/en/params.h   |    1 +
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |   13 +
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.c   |    1 +
 .../ethernet/mellanox/mlx5/core/en/xsk/rx.h   |    1 +
 .../mellanox/mlx5/core/en_accel/en_accel.h    |    9 +-
 .../mellanox/mlx5/core/en_accel/fs_tcp.c      |   10 +
 .../mellanox/mlx5/core/en_accel/fs_tcp.h      |    2 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 1015 +++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  120 ++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        |  264 +++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.h        |   43 +
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |   80 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   40 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   66 +-
 .../ethernet/mellanox/mlx5/core/en_stats.c    |   37 +
 .../ethernet/mellanox/mlx5/core/en_stats.h    |   24 +
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |   17 +
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |    6 +
 drivers/nvme/host/tcp.c                       |  448 +++++++-
 include/linux/mlx5/device.h                   |   44 +-
 include/linux/mlx5/mlx5_ifc.h                 |  101 +-
 include/linux/mlx5/qp.h                       |    1 +
 include/linux/netdev_features.h               |    4 +
 include/linux/netdevice.h                     |    5 +
 include/linux/skbuff.h                        |   13 +
 include/linux/uio.h                           |   17 +
 include/net/inet_connection_sock.h            |    4 +
 include/net/sock.h                            |   17 +
 include/net/tcp_ddp.h                         |  136 +++
 lib/iov_iter.c                                |   53 +
 net/Kconfig                                   |   17 +
 net/core/datagram.c                           |   48 +
 net/core/skbuff.c                             |    8 +-
 net/ethtool/common.c                          |    2 +
 net/ipv4/tcp_input.c                          |    8 +
 net/ipv4/tcp_ipv4.c                           |    3 +
 net/ipv4/tcp_offload.c                        |    3 +
 net/tls/tls_device.c                          |   20 +-
 44 files changed, 2985 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/networking/tcp-ddp-offload.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
 create mode 100644 include/net/tcp_ddp.h

-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
