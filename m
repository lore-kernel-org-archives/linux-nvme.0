Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF48C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 10:15:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 675E764DDD
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 10:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 675E764DDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3d6oogE17CmjiRhqI0BNWHxIz7jLCXmapJVJGM4SNJY=; b=JiLmVL0Ab5sjtQJ9YPpvVLx5t
	+sZuiPzQZ49aQnWMA97pJLG4BPlUnZQ70h0B+nl2+T/GJ4mi18At2LtuC6Opa9bX4UcPNHOLR8Fv7
	AcUeye+nlXSvZrZzXderd6JnMJqwXgOpHc+3K+EurmhduXRi5QFs9ixO+Ph+I3t67RgBH+vMmf4S2
	bsiV7dAy6ZaFMYuWPPiU2b8E7tGYx/XIeFuNY+FuxjK7NnMKvjfQ/vYMeMD9NW5Qc9C/QS9UvjogX
	Pu17hHgUm+CPeCpe5GTRWa58qqq7XSEh5z3O/JNcbjTlMXducf9jcLklBCoRz/7tRf8rgfmrn7Mja
	zTPb3OvkQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6WEt-0008KQ-Gx; Mon, 01 Feb 2021 10:15:23 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6W59-000443-K5
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 10:05:30 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 borisp@mellanox.com) with SMTP; 1 Feb 2021 12:05:14 +0200
Received: from gen-l-vrt-133.mtl.labs.mlnx. (gen-l-vrt-133.mtl.labs.mlnx
 [10.237.11.160])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 111A5C0E029353;
 Mon, 1 Feb 2021 12:05:14 +0200
From: Boris Pismenny <borisp@mellanox.com>
To: dsahern@gmail.com, kuba@kernel.org, davem@davemloft.net, saeedm@nvidia.com,
 hch@lst.de, sagi@grimberg.me, axboe@fb.com, kbusch@kernel.org,
 viro@zeniv.linux.org.uk, edumazet@google.com, smalin@marvell.com
Subject: [PATCH v3 net-next 21/21] Documentation: add TCP DDP offload
 documentation
Date: Mon,  1 Feb 2021 12:05:09 +0200
Message-Id: <20210201100509.27351-22-borisp@mellanox.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20210201100509.27351-1-borisp@mellanox.com>
References: <20210201100509.27351-1-borisp@mellanox.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_050520_321660_B5069B84 
X-CRM114-Status: GOOD (  25.06  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, yorayz@nvidia.com,
 boris.pismenny@gmail.com, Ben Ben-Ishay <benishay@mellanox.com>,
 benishay@nvidia.com, linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
 Or Gerlitz <ogerlitz@mellanox.com>, ogerlitz@nvidia.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Signed-off-by: Boris Pismenny <borisp@mellanox.com>
Signed-off-by: Ben Ben-Ishay <benishay@mellanox.com>
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Yoray Zack <yorayz@mellanox.com>
---
 Documentation/networking/index.rst           |   1 +
 Documentation/networking/tcp-ddp-offload.rst | 296 +++++++++++++++++++
 2 files changed, 297 insertions(+)
 create mode 100644 Documentation/networking/tcp-ddp-offload.rst

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index b8a29997d433..99644159a0cc 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -99,6 +99,7 @@ Contents:
    sysfs-tagging
    tc-actions-env-rules
    tcp-thin
+   tcp-ddp-offload
    team
    timestamping
    tipc
diff --git a/Documentation/networking/tcp-ddp-offload.rst b/Documentation/networking/tcp-ddp-offload.rst
new file mode 100644
index 000000000000..1607e8210968
--- /dev/null
+++ b/Documentation/networking/tcp-ddp-offload.rst
@@ -0,0 +1,296 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+=================================
+TCP direct data placement offload
+=================================
+
+Overview
+========
+
+The Linux kernel TCP direct data placement (DDP) offload infrastructure
+provides tagged request-response protocols, such as NVMe-TCP, the ability to
+place response data directly in pre-registered buffers according to header
+tags. DDP is particularly useful for data-intensive pipelined protocols whose
+responses may be reordered.
+
+For example, in NVMe-TCP numerous read requests are sent together and each
+request is tagged using the PDU header CID field. Receiving servers process
+requests as fast as possible and sometimes responses for smaller requests
+bypasses responses to larger requests, i.e., read 4KB bypasses read 1GB.
+Thereafter, clients corrleate responses to requests using PDU header CID tags.
+The processing of each response requires copying data from SKBs to read
+request destination buffers; The offload avoids this copy. The offload is
+oblivious to destination buffers which can reside either in userspace
+(O_DIRECT) or in kernel pagecache.
+
+Request TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+-------+---------------+-------+---------------+-------+
+ | PDU hdr CID=1 | Req 1 | PDU hdr CID=2 | Req 2 | PDU hdr CID=3 | Req 3 |
+ +---------------+-------+---------------+-------+---------------+-------+
+
+Response TCP byte-stream:
+
+.. parsed-literal::
+
+ +---------------+--------+---------------+--------+---------------+--------+
+ | PDU hdr CID=2 | Resp 2 | PDU hdr CID=3 | Resp 3 | PDU hdr CID=1 | Resp 1 |
+ +---------------+--------+---------------+--------+---------------+--------+
+
+Offloading requires no new SKB bits. Instead, the driver builds SKB page
+fragments that point destination buffers. Consequently, SKBs represent the
+original data on the wire, which enables *transparent* inter-operation with the
+network stack.  To avoid copies between SKBs and destination buffers, the
+layer-5 protocol (L5P) will check ``if (src == dst)`` for SKB page fragments,
+success indicates that data is already placed there by NIC hardware and copy
+should be skipped.
+
+Offloading does require NIC hardware to track L5P procotol framing, similarly
+to RX TLS offload (see documentation at
+:ref:`Documentation/networking/tls-offload.rst <tls_offload>`).  NIC hardware
+will parse PDU headers extract fields such as operation type, length, ,tag
+identifier, etc. and offload only segments that correspond to tags registered
+with the NIC, see the :ref:`buf_reg` section.
+
+Device configuration
+====================
+
+During driver initialization the device sets the ``NETIF_F_HW_TCP_DDP`` and
+feature and installs its
+:c:type:`struct tcp_ddp_ops <tcp_ddp_ops>`
+pointer in the :c:member:`tcp_ddp_ops` member of the
+:c:type:`struct net_device <net_device>`.
+
+Later, after the L5P completes its handshake offload is installed on the socket.
+If offload installation fails, then the connection is handled by software as if
+offload was not attempted. Offload installation should configure 
+
+To request offload for a socket `sk`, the L5P calls :c:member:`tcp_ddp_sk_add`:
+
+.. code-block:: c
+
+ int (*tcp_ddp_sk_add)(struct net_device *netdev,
+ 		      struct sock *sk,
+ 		      struct tcp_ddp_config *config);
+
+The function return 0 for success. In case of failure, L5P software should
+fallback to normal non-offloaded operation.  The `config` parameter indicates
+the L5P type and any metadata relevant for that protocol. For example, in
+NVMe-TCP the following config is used:
+
+.. code-block:: c
+
+ /**
+  * struct nvme_tcp_ddp_config - nvme tcp ddp configuration for an IO queue
+  *
+  * @pfv:        pdu version (e.g., NVME_TCP_PFV_1_0)
+  * @cpda:       controller pdu data alignmend (dwords, 0's based)
+  * @dgst:       digest types enabled.
+  *              The netdev will offload crc if ddp_crc is supported.
+  * @queue_size: number of nvme-tcp IO queue elements
+  * @queue_id:   queue identifier
+  * @cpu_io:     cpu core running the IO thread for this queue
+  */
+ struct nvme_tcp_ddp_config {
+ 	struct tcp_ddp_config   cfg;
+ 
+ 	u16			pfv;
+ 	u8			cpda;
+ 	u8			dgst;
+ 	int			queue_size;
+ 	int			queue_id;
+ 	int			io_cpu;
+ };
+
+When offload is not needed anymore, e.g., the socket is being released, the L5P
+calls :c:member:`tcp_ddp_sk_del` to release device contexts:
+
+.. code-block:: c
+
+ void (*tcp_ddp_sk_del)(struct net_device *netdev,
+  		        struct sock *sk);
+
+Normal operation
+================
+
+At the very least, the device maintains the following state for each connection:
+
+ * 5-tuple
+ * expected TCP sequence number
+ * mapping between tags and corresponding buffers
+ * current offset within PDU, PDU length, current PDU tag
+
+NICs should not assume any correleation between PDUs and TCP packets.  Assuming
+that TCP packets arrive in-order, offload will place PDU payload directly
+inside corresponding registered buffers. No packets are to be delayed by NIC
+offload. If offload is not possible, than the packet is to be passed as-is to
+software. To perform offload on incoming packets without buffering packets in
+the NIC, the NIC stores some inter-packet state, such as partial PDU headers.
+
+RX data-path
+------------
+
+After the device validates TCP checksums, it can perform DDP offload.  The
+packet is steered to the DDP offload context according to the 5-tuple.
+Thereafter, the expected TCP sequence number is checked against the packet's
+TCP sequence number. If there's a match, then offload is performed: PDU payload
+is DMA written to corresponding destination buffer according to the PDU header
+tag.  The data should be DMAed only once, and the NIC receive ring will only
+store the remaining TCP and PDU headers.
+
+We remark that a single TCP packet may have numerous PDUs embedded inside. NICs
+can choose to offload one or more of these PDUs according to various
+trade-offs. Possibly, offloading such small PDUs is of little value, and it is
+better to leave it to software.
+
+Upon receiving a DDP offloaded packet, the driver reconstructs the original SKB
+using page frags, while pointing to the destination buffers whenever possible.
+This method enables seemless integration with the network stack, which can
+inspect and modify packet fields transperently to the offload.
+
+.. _buf_reg:
+
+Destination buffer registration
+-------------------------------
+
+To register the mapping betwteen tags and destination buffers for a socket
+`sk`, the L5P calls :c:member:`tcp_ddp_setup` of :c:type:`struct tcp_ddp_ops
+<tcp_ddp_ops>`:
+
+.. code-block:: c
+  
+ int (*tcp_ddp_setup)(struct net_device *netdev,
+ 		     struct sock *sk,
+ 		     struct tcp_ddp_io *io);
+
+
+The `io` provides the buffer via scatter-gather list (`sg_table`) and
+corresponding tag (`command_id`):
+
+.. code-block:: c
+ /**
+  * struct tcp_ddp_io - tcp ddp configuration for an IO request.
+  *
+  * @command_id:  identifier on the wire associated with these buffers
+  * @nents:       number of entries in the sg_table
+  * @sg_table:    describing the buffers for this IO request
+  * @first_sgl:   first SGL in sg_table
+  */
+ struct tcp_ddp_io {
+ 	u32			command_id;
+ 	int			nents;
+ 	struct sg_table		sg_table;
+ 	struct scatterlist	first_sgl[SG_CHUNK_SIZE];
+ };
+
+After the buffers have been consumed by the L5P, to release the NIC mapping of
+buffers the L5P calls :c:member:`tcp_ddp_teardown` of :c:type:`struct
+tcp_ddp_ops <tcp_ddp_ops>`: 
+
+.. code-block:: c
+  
+ int (*tcp_ddp_teardown)(struct net_device *netdev,
+ 			struct sock *sk,
+ 			struct tcp_ddp_io *io,
+ 			void *ddp_ctx);
+
+`tcp_ddp_teardown` receives the same `io` context and an additional opaque
+`ddp_ctx` that is used for asynchronous teardown, see the :ref:`async_release`
+section.
+
+.. _async_release:
+
+Asynchronous teardown
+---------------------
+
+To teardown the association between tags and buffers and allow tag reuse NIC HW
+is called by the NIC driver during `tcp_ddp_teardown`. This operation may be
+performed either synchronously or asynchronously. In asynchronous teardown,
+`tcp_ddp_teardown` returns immediately without unmapping NIC HW buffers. Later,
+when the unmapping completes by NIC HW, the NIC driver will call up to L5P
+using :c:member:`ddp_teardown_done` of :c:type:`struct tcp_ddp_ulp_ops`:
+
+.. code-block:: c
+
+ void (*ddp_teardown_done)(void *ddp_ctx);
+
+The `ddp_ctx` parameter passed in `ddp_teardown_done` is the same on provided
+in `tcp_ddp_teardown` and it is used to carry some context about the buffers
+and tags that are released.
+
+Resync handling
+===============
+
+In presence of packet drops or network packet reordering, the device may lose
+synchronization between the TCP stream and the L5P framing, and require a
+resync with the kernel's TCP stack. When the device is out of sync, no offload
+takes place, and packets are passed as-is to software. (resync is very similar
+to TLS offload (see documentation at
+:ref:`Documentation/networking/tls-offload.rst <tls_offload>`)
+
+If only packets with L5P data are lost or reordered, then resynchronization may
+be avoided by NIC HW that keeps tracking PDU headers. If, however, PDU headers
+are reordered, then resynchronization is necessary.
+
+To resynchronize hardware during traffic, we use a handshake between hardware
+and software. The NIC HW searches for a sequence of bytes that identifies L5P
+headers (i.e., magic pattern).  For example, in NVMe-TCP, the PDU operation
+type can be used for this purpose.  Using the PDU header length field, the NIC
+HW will continue to find and match magic patterns in subsequent PDU headers. If
+the pattern is missing in an expected position, then searching for the pattern
+starts anew.
+
+The NIC will not resume offload when the magic pattern is first identified.
+Instead, it will request L5P software to confirm that indeed this is a PDU
+header. To request confirmation the NIC driver calls up to L5P using
+:c:member:`*resync_request` of :c:type:`struct tcp_ddp_ulp_ops`:
+
+.. code-block:: c
+
+  bool (*resync_request)(struct sock *sk, u32 seq, u32 flags);
+
+The `seq` field contains the TCP sequence of the last byte in the PDU header.
+L5P software will respond to this request after observing the packet containing
+TCP sequence `seq` in-order. If the PDU header is indeed there, then L5P
+software calls the NIC driver using the :c:member:`tcp_ddp_resync` function of
+the :c:type:`struct tcp_ddp_ops <tcp_ddp_ops>` inside the :c:type:`struct
+net_device <net_device>` while passing the same `seq` to confirm it is a PDU
+header.
+
+.. code-block:: c
+
+ void (*tcp_ddp_resync)(struct net_device *netdev,
+ 		       struct sock *sk, u32 seq);
+
+Statistics
+==========
+
+Per L5P protocol, the following NIC driver must report statistics for the above
+netdevice operations and packets processed by offload. For example, NVMe-TCP
+offload reports:
+
+ * ``rx_nvmeotcp_queue_init`` - number of NVMe-TCP offload contexts created.
+ * ``rx_nvmeotcp_queue_teardown`` - number of NVMe-TCP offload contexts
+   destroyed.
+ * ``rx_nvmeotcp_ddp_setup`` - number of DDP buffers mapped.
+ * ``rx_nvmeotcp_ddp_setup_fail`` - number of DDP buffers mapping that failed.
+ * ``rx_nvmeotcp_ddp_teardown`` - number of DDP buffers unmapped.
+ * ``rx_nvmeotcp_drop`` - number of packets dropped in the driver due to fatal
+   errors.
+ * ``rx_nvmeotcp_resync`` - number of packets with resync requests.
+ * ``rx_nvmeotcp_offload_packets`` - number of packets that used offload.
+ * ``rx_nvmeotcp_offload_bytes`` - number of bytes placed in DDP buffers.
+
+NIC requirements
+================
+
+NIC hardware should meet the following requirements to provide this offload:
+
+ * Offload must never buffer TCP packets.
+ * Offload must never modify TCP packet headers.
+ * Offload must never reorder TCP packets within a flow.
+ * Offload must never drop TCP packets.
+ * Offload must not depend on any TCP fields beyond the
+   5-tuple and TCP sequence number.
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
