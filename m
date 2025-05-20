Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95527C3DA6D
	for <linux-nvme@archiver.kernel.org>; Tue, 20 May 2025 17:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ips3PVy3KH33zrXl9J/syG0BmgRaKBHnMAYDDB2OUZo=; b=vRN7prEd0vX5Z0auk+dQQ3m0vv
	4GmgBIquYcwp/dxWJtexBuFX3I0ZaeVbD8yqS7gqUbMyyqchq7rb6EW5B54xwbrneYq7tpsST/aNr
	tSBx6XeAARpQ5mnPc9Dwo0VgfIoVSSbsZJZL2OOiDG0kwli4PbMonupmB0KXPr1XsANgdwv+ZmYbu
	5R0Zs7oW7ByUoCOGiQTaGmN2xgWCO/oGYZ3E7/Oe2Mmt+4U6viK7WLyuF8rXtLA0Jgob4pvP/Dddv
	PPaypcdpBUBE1Vubq84T89F8IK9koVGdfV54YjBqWIsDH4S9RS8Z0xbs75YTHS6pADg7NCX0Kxekr
	oOJ57alQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHQrV-0000000Dgk0-13sQ;
	Tue, 20 May 2025 17:34:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uHQrS-0000000DgjR-35ld
	for linux-nvme@lists.infradead.org;
	Tue, 20 May 2025 17:34:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6F2AB49D9C;
	Tue, 20 May 2025 17:34:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EA6C4CEE9;
	Tue, 20 May 2025 17:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747762482;
	bh=4Oa/oAs7QoUno9lRk6Vmd+pQV2yim2hp+jaTVoota5M=;
	h=From:To:Cc:Subject:Date:From;
	b=jfZwfM+EtFOzz6o1W4wA7JkhydcX5QsZE1LXPTdGom5UBgQnzBSdDzZTcCARDp8f5
	 Vq26/sS3c4HPDrJW6+6kkbZDzFZhuOmlInC6lqq8/bYBQcWViH5yWm4poeTKpbDicy
	 rUvfEea0TRcffAQe6CJoYFMPCAv0/lCPTcNjzKGciGGowwesF9XUYAYgglPMhbzx60
	 J2HO8WoHVeHV0WKwMzXrEJBc02I6yOcuVyWuVQoOC0L7LDXP7MQTSSi4JTUDReJdXH
	 QH9WVJlsX/2KBGUX20C5U/3opbDlh1VbVFfLsN07z9XjnJ5BcU3nti2XyrTONnvi39
	 Lvpjl7IOfAQfA==
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Simon Horman <horms@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Dmitry Bogdanov <d.bogdanov@yadro.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Eric Biggers <ebiggers@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next v3] net: core: Convert inet_addr_is_any() to sockaddr_storage
Date: Tue, 20 May 2025 10:34:38 -0700
Message-Id: <20250520173437.make.907-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3953; i=kees@kernel.org; h=from:subject:message-id; bh=4Oa/oAs7QoUno9lRk6Vmd+pQV2yim2hp+jaTVoota5M=; b=owGbwMvMwCVmps19z/KJym7G02pJDBk6e/UWxP4+wt+4oHy5kvm27bypzpd7FIJW7GG36yz5E vBVNOFTRykLgxgXg6yYIkuQnXuci8fb9nD3uYowc1iZQIYwcHEKwER4PzH8d/R79zXsVMzHwoNr 3S37XUPk1lmqbEzrdW2ICU1iWZ62g+GviKK1l+2mkz+NPMzufv0UoFPKn/pPtmjqu1vVTzf83nq QBQA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250520_103442_818407_8ED2A43F 
X-CRM114-Status: GOOD (  14.49  )
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
 include/linux/inet.h                | 2 +-
 drivers/nvme/target/rdma.c          | 2 +-
 drivers/nvme/target/tcp.c           | 2 +-
 drivers/target/iscsi/iscsi_target.c | 2 +-
 net/core/utils.c                    | 8 ++++----
 5 files changed, 8 insertions(+), 8 deletions(-)

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
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 2a4536ef6184..79a5aad2e9d0 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1999,7 +1999,7 @@ static void nvmet_rdma_disc_port_addr(struct nvmet_req *req,
 	struct nvmet_rdma_port *port = nport->priv;
 	struct rdma_cm_id *cm_id = port->cm_id;
 
-	if (inet_addr_is_any((struct sockaddr *)&cm_id->route.addr.src_addr)) {
+	if (inet_addr_is_any(&cm_id->route.addr.src_addr)) {
 		struct nvmet_rdma_rsp *rsp =
 			container_of(req, struct nvmet_rdma_rsp, req);
 		struct rdma_cm_id *req_cm_id = rsp->queue->cm_id;
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 12a5cb8641ca..5cd1cf74f8ff 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2194,7 +2194,7 @@ static void nvmet_tcp_disc_port_addr(struct nvmet_req *req,
 {
 	struct nvmet_tcp_port *port = nport->priv;
 
-	if (inet_addr_is_any((struct sockaddr *)&port->addr)) {
+	if (inet_addr_is_any(&port->addr)) {
 		struct nvmet_tcp_cmd *cmd =
 			container_of(req, struct nvmet_tcp_cmd, req);
 		struct nvmet_tcp_queue *queue = cmd->queue;
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 620ba6e0ab07..a2dde08c8a62 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -3419,7 +3419,7 @@ iscsit_build_sendtargets_response(struct iscsit_cmd *cmd,
 					}
 				}
 
-				if (inet_addr_is_any((struct sockaddr *)&np->np_sockaddr))
+				if (inet_addr_is_any(&np->np_sockaddr))
 					sockaddr = &conn->local_sockaddr;
 				else
 					sockaddr = &np->np_sockaddr;
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


