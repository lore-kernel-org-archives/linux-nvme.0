Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 806F6E7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 20:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nCipa5zmvbGBHIIXkJ7ajEbz6xEp9KqI+JG71Fq/eoA=; b=o+Ebt+jiOQWk84DAWxHbu2OA5H
	o7h43T29oMls4hNBvin+9+3EIAZ0BTPzVMRM2d7O1GR/z1xOXjpsroLDcsoTzc8F6c2r5I1OCeZjE
	JDGNvmghduf6c6Tgq5IIit7XYyMVHercjjhSeuDU0r5elgl3sCELXS/6tpZ5O7kuZY5Fcl9rp9vSY
	rhumBWRmlfkpamLnT0+kmDJ6fQTN9rJ/2xEhWGoohZLpuXSL0F0XU1lP8cZb3MkUNICrFpz458C2e
	9eA5BTYSRWjhY8t15GMmnxHQFkdmtxkOdmHdQrFXzE6AWfBuX1LSbtI8BqKmTeKS+C/CUnUTITcmN
	8HIcmaeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNeHT-0000000ElBX-1Lec;
	Tue, 17 Dec 2024 20:34:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNeHQ-0000000ElBC-2gQF
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 20:34:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B964B5C5AF7;
	Tue, 17 Dec 2024 20:34:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B71EC4CED3;
	Tue, 17 Dec 2024 20:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734467695;
	bh=nvnPPN7j/2p/JFEejejW+Qg34E36N01t9rBWoj3OZgM=;
	h=From:To:Cc:Subject:Date:From;
	b=LsVQxRIVnTWmK+4yYhndt3mInuvU6Ulb1pJ+dF2ABRL/mwqpll9QvwFYN/kVaDAVj
	 nmml2P7yeZ4cs7yKcMTNpo1oHhZVy/v6otDSGOSxYUbO8OVOBwn5SwOcGEwLH+/rZh
	 COAP0iABpRqOHQIa4GC52DMLTOU/IguAK8DCrbCxPO13jyWqF5phrMQebu/wkemc5F
	 5Em6BzMo73YoxS1/y0Q0qTJ49zUi7Y8THuemgc7BkfYNCWBFd61SGJbbZ0UGlW8ZGJ
	 xzKDOoLJBFpx5Tqhk+5eJdPW57RilOoZJxAUQ9iAla6gKIcEEtOaJ76s/xVlM0sSbh
	 PHl8XF22RXb4w==
From: Kees Cook <kees@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Kees Cook <kees@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mike Christie <michael.christie@oracle.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Mingzhe Zou <mingzhe.zou@easystack.cn>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] net: core: Convert inet_addr_is_any() to sockaddr_storage
Date: Tue, 17 Dec 2024 12:34:51 -0800
Message-Id: <20241217203447.it.588-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4896; i=kees@kernel.org; h=from:subject:message-id; bh=nvnPPN7j/2p/JFEejejW+Qg34E36N01t9rBWoj3OZgM=; b=owGbwMvMwCVmps19z/KJym7G02pJDOmJD7IXGD1bHnYlpCN4y6Tg3H9XYj89Nfrz4+kPLX+O4 85567JEOkpZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACZS6sHwP3hN4eMGY3eGE5Jq dVe+buJK2Zey8KEWkxbn7C/6h39eM2RkmLRCIm6RyO4Hq9Z7xwQ8alw1TW5+5nTH7UclY4/eXLZ 3CycA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_123456_765203_8F26E6DA 
X-CRM114-Status: GOOD (  15.74  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

All the callers of inet_addr_is_any() have a sockaddr_storage-backed
sockaddr. Avoid casts and switch prototype to the actual object being
used.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Kees Cook <kees@kernel.org>
---
 v2: drop "extern" in header (hch)
 v1: https://lore.kernel.org/all/20241217012618.work.323-kees@kernel.org/
---
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: Maurizio Lombardi <mlombard@redhat.com>
Cc: Dmitry Bogdanov <d.bogdanov@yadro.com>
Cc: Mingzhe Zou <mingzhe.zou@easystack.cn>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Simon Horman <horms@kernel.org>
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: linux-nvme@lists.infradead.org
Cc: linux-scsi@vger.kernel.org
Cc: target-devel@vger.kernel.org
Cc: netdev@vger.kernel.org
---
 drivers/nvme/target/rdma.c          | 2 +-
 drivers/nvme/target/tcp.c           | 2 +-
 drivers/target/iscsi/iscsi_target.c | 2 +-
 include/linux/inet.h                | 2 +-
 net/core/utils.c                    | 8 ++++----
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1afd93026f9b..18ea11342af1 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1986,7 +1986,7 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 	struct nvmet_rdma_port *port = nport->priv;
 	struct rdma_cm_id *cm_id = port->cm_id;
 
-	if (inet_addr_is_any((struct sockaddr *)&cm_id->route.addr.src_addr)) {
+	if (inet_addr_is_any(&cm_id->route.addr.src_addr)) {
 		struct nvmet_rdma_rsp *rsp =
 			container_of(req, struct nvmet_rdma_rsp, req);
 		struct rdma_cm_id *req_cm_id = rsp->queue->cm_id;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 7c51c2a8c109..df24244fb820 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2158,7 +2158,7 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_req *req,
 {
 	struct nvmet_tcp_port *port = nport->priv;
 
-	if (inet_addr_is_any((struct sockaddr *)&port->addr)) {
+	if (inet_addr_is_any(&port->addr)) {
 		struct nvmet_tcp_cmd *cmd =
 			container_of(req, struct nvmet_tcp_cmd, req);
 		struct nvmet_tcp_queue *queue = cmd->queue;
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 6002283cbeba..1ce68eda0090 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -3471,7 +3471,7 @@ iscsit_build_sendtargets_response(struct iscsit_cmd *cmd,
 					}
 				}
 
-				if (inet_addr_is_any((struct sockaddr *)&np->np_sockaddr))
+				if (inet_addr_is_any(&np->np_sockaddr))
 					sockaddr = &conn->local_sockaddr;
 				else
 					sockaddr = &np->np_sockaddr;
diff --git a/include/linux/inet.h b/include/linux/inet.h
index bd8276e96e60..9158772f3559 100644
--- a/include/linux/inet.h
+++ b/include/linux/inet.h
@@ -55,6 +55,6 @@ extern int in6_pton(const char *src, int srclen, u8 *dst, int delim, const char
 
 extern int inet_pton_with_scope(struct net *net, unsigned short af,
 		const char *src, const char *port, struct sockaddr_storage *addr);
-extern bool inet_addr_is_any(struct sockaddr *addr);
+bool inet_addr_is_any(struct sockaddr_storage *addr);
 
 #endif	/* _LINUX_INET_H */
diff --git a/net/core/utils.c b/net/core/utils.c
index 27f4cffaae05..e47feeaa5a49 100644
--- a/net/core/utils.c
+++ b/net/core/utils.c
@@ -399,9 +399,9 @@ int inet_pton_with_scope(struct net *net, __kernel_sa_family_t af,
 }
 EXPORT_SYMBOL(inet_pton_with_scope);
 
-bool inet_addr_is_any(struct sockaddr *addr)
+bool inet_addr_is_any(struct sockaddr_storage *addr)
 {
-	if (addr->sa_family == AF_INET6) {
+	if (addr->ss_family == AF_INET6) {
 		struct sockaddr_in6 *in6 = (struct sockaddr_in6 *)addr;
 		const struct sockaddr_in6 in6_any =
 			{ .sin6_addr = IN6ADDR_ANY_INIT };
@@ -409,13 +409,13 @@ bool inet_addr_is_any(struct sockaddr *addr)
 		if (!memcmp(in6->sin6_addr.s6_addr,
 			    in6_any.sin6_addr.s6_addr, 16))
 			return true;
-	} else if (addr->sa_family == AF_INET) {
+	} else if (addr->ss_family == AF_INET) {
 		struct sockaddr_in *in = (struct sockaddr_in *)addr;
 
 		if (in->sin_addr.s_addr == htonl(INADDR_ANY))
 			return true;
 	} else {
-		pr_warn("unexpected address family %u\n", addr->sa_family);
+		pr_warn("unexpected address family %u\n", addr->ss_family);
 	}
 
 	return false;
-- 
2.34.1


