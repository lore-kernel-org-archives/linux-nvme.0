Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D213C4361B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 21:07:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E0192388C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 21:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E0192388C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wKQO68rIS4ch3b81e84qtuYIBsZC5oRcqBMCnK/tWnE=; b=lCn0x88mLg8Ic4Frjf5mVXg6Jr
	xUyZxbzZDsxPoX5x3w8Azb6Lvq4yQQ8fvYhOEBcntZkj03Uq2/ou208Fo6Y0lOsoTX4D3uGbovx6m
	7DAuu+0HxxaNmyqWUdhY8TrJik6qVpv6R99D4ECIOQwpL6HbO9p0IDgu1YP/BFyMo0D2lQaojRult
	2gT3/oAyc6rAu91/lvbtzBu3qOctcklhTIkR8MPTP1DAvl1YzMa4cXa4HxEuY3CtTMBsh4/kWNtp9
	9Iahq4v+e7PEZefaY/3AZqypIUNYHf0BiVFfXzbwgI8ahiWbeyiHi73dnWbtLueb5OHCuQOwK9KM+
	UMH67BlQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmNio-0000yR-ST; Mon, 07 Dec 2020 21:07:02 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmNij-0000u6-5g
 for linux-nvme@lists.infradead.org; Mon, 07 Dec 2020 21:06:59 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 borisp@mellanox.com) with SMTP; 7 Dec 2020 23:06:52 +0200
Received: from gen-l-vrt-133.mtl.labs.mlnx. (gen-l-vrt-133.mtl.labs.mlnx
 [10.237.11.160])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 0B7L6qI8029788;
 Mon, 7 Dec 2020 23:06:52 +0200
From: Boris Pismenny <borisp@mellanox.com>
To: kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com, hch@lst.de,
 sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com
Subject: [PATCH v1 net-next 00/15] nvme-tcp receive offloads
Date: Mon,  7 Dec 2020 23:06:34 +0200
Message-Id: <20201207210649.19194-1-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201207_160657_563183_BBB02A5E 
X-CRM114-Status: GOOD (  23.99  )
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
Cc: yorayz@nvidia.com, boris.pismenny@gmail.com, benishay@nvidia.com,
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

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

As the last change is to a sensative function, we are careful to place it under
static_key which is only enabled when this functionality is actually used for
nvme-tcp copy offload.

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
Patch 1         the iov_iter change to skip copy if (src == dst)
Patches 2-3     the infrastructure for all TCP DDP
                and TCP DDP CRC offloads, respectively.
Patch 4         exposes the get_netdev_for_sock function from TLS
Patch 5         NVMe-TCP changes to call NIC driver on queue init/teardown
Patches 6       NVMe-TCP changes to call NIC driver on IO operation
                setup/teardown, and support async completions.
Patches 7       NVMe-TCP changes to support CRC offload on receive.
                Also, this patch moves CRC calculation to the end of PDU
                in case offload requires software fallback.
Patches 8       NVMe-TCP handling of netdev events: stop the offload if
                netdev is going down
Patches 9-15    implement support for NVMe-TCP copy and CRC offload in
                the mlx5 NIC driver as the first user

Testing:
=========================================
This series was tested using fio with various configurations of IO sizes,
depths, MTUs, and with both the SPDK and kernel NVMe-TCP targets.

Future work:
=========================================
A follow-up series will introduce support for transmit side CRC. Then,
we will work on adding support for TLS in NVMe-TCP and combining the
two offloads.

Changes since RFC v1:
=========================================
* Split mlx5 driver patches to several commits
* Fix nvme-tcp handling of recovery flows. In particular, move queue offlaod
  init/teardown to the start/stop functions.

Ben Ben-ishay (5):
  net/mlx5: Header file changes for nvme-tcp offload
  net/mlx5: Add 128B CQE for NVMEoTCP offload
  net/mlx5e: NVMEoTCP DDP offload control path
  net/mlx5e: NVMEoTCP, data-path for DDP offload
  net/mlx5e: NVMEoTCP statistics

Boris Pismenny (7):
  iov_iter: Skip copy in memcpy_to_page if src==dst
  net: Introduce direct data placement tcp offload
  net: Introduce crc offload for tcp ddp ulp
  net/tls: expose get_netdev_for_sock
  nvme-tcp: Add DDP offload control path
  nvme-tcp: Add DDP data-path
  net/mlx5e: TCP flow steering for nvme-tcp

Or Gerlitz (1):
  nvme-tcp: Deal with netdevice DOWN events

Yoray Zack (2):
  nvme-tcp : Recalculate crc in the end of the capsule
  net/mlx5e: NVMEoTCP workaround CRC after resync

 .../net/ethernet/mellanox/mlx5/core/Kconfig   |   11 +
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
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 1002 +++++++++++++++++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  119 ++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        |  270 +++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.h        |   26 +
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |   80 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   39 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   72 +-
 .../ethernet/mellanox/mlx5/core/en_stats.c    |   37 +
 .../ethernet/mellanox/mlx5/core/en_stats.h    |   24 +
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |   16 +
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |    6 +
 drivers/nvme/host/tcp.c                       |  443 +++++++-
 include/linux/mlx5/device.h                   |   43 +-
 include/linux/mlx5/mlx5_ifc.h                 |  104 +-
 include/linux/mlx5/qp.h                       |    1 +
 include/linux/netdev_features.h               |    4 +
 include/linux/netdevice.h                     |    5 +
 include/linux/skbuff.h                        |    5 +
 include/linux/uio.h                           |    2 +
 include/net/inet_connection_sock.h            |    4 +
 include/net/sock.h                            |   17 +
 include/net/tcp_ddp.h                         |  129 +++
 lib/iov_iter.c                                |   11 +-
 net/Kconfig                                   |   17 +
 net/core/skbuff.c                             |    9 +-
 net/ethtool/common.c                          |    2 +
 net/ipv4/tcp_input.c                          |    7 +
 net/ipv4/tcp_ipv4.c                           |    3 +
 net/ipv4/tcp_offload.c                        |    3 +
 net/tls/tls_device.c                          |   20 +-
 41 files changed, 2551 insertions(+), 54 deletions(-)
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
