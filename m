Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994E8C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 16:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ZFQF8Xo+dCgRvuGEP56EojKqNwhVpxHSn1+PBZtTXE=; b=v3J1kzfjfh8kXLnAcZbKonKIoA
	FjGCt65Wj6U0sHm2ZphtBiqj+zGpgeGpUcUYkZfqlaR2zYlf/5S9QOr7siWrrVrq2hSo/6MtboW0U
	GHgjIj/bpBi/iDuPlpluAw2uazJIW15ZRxPUveuXu7Si9CZHwfoY2gbqyGFr4oN/X7v5V73t48EQa
	I0I/qWRt0IwSsfpvqkq2bLwhzbHcHgcy89//NzXGB/3nq45E+mm+XhMrHEIHblGvMfariKCdF2Gko
	KGPQH3Fzxd44/qSIk3TIftLlzPkNRvz4pqRlapXk6qy4KkEI90BXkteaYI8mO8s2194eBM8pZII2W
	yIs7ba6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngUb7-0008LJ-V1; Mon, 18 Apr 2022 16:51:33 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngUaq-0008AU-4R
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 16:51:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id A3CF4612FE;
 Mon, 18 Apr 2022 16:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A24C385A7;
 Mon, 18 Apr 2022 16:51:14 +0000 (UTC)
Subject: [PATCH RFC 01/15] SUNRPC: Replace dprintk() call site in xs_data_ready
From: Chuck Lever <chuck.lever@oracle.com>
To: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
Date: Mon, 18 Apr 2022 12:51:13 -0400
Message-ID: <165030067347.5246.13241827912831647777.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
References: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_095116_410225_D5669FCF 
X-CRM114-Status: GOOD (  11.75  )
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/sunrpc.h |   20 ++++++++++++++++++++
 net/sunrpc/xprtsock.c         |    6 ++++--
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 3995c58a1c51..a66aa1f59ed8 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -1266,6 +1266,26 @@ TRACE_EVENT(xprt_reserve,
 	)
 );
 
+TRACE_EVENT(xs_data_ready,
+	TP_PROTO(
+		const struct rpc_xprt *xprt
+	),
+
+	TP_ARGS(xprt),
+
+	TP_STRUCT__entry(
+		__string(addr, xprt->address_strings[RPC_DISPLAY_ADDR])
+		__string(port, xprt->address_strings[RPC_DISPLAY_PORT])
+	),
+
+	TP_fast_assign(
+		__assign_str(addr, xprt->address_strings[RPC_DISPLAY_ADDR]);
+		__assign_str(port, xprt->address_strings[RPC_DISPLAY_PORT]);
+	),
+
+	TP_printk("peer=[%s]:%s", __get_str(addr), __get_str(port))
+);
+
 TRACE_EVENT(xs_stream_read_data,
 	TP_PROTO(struct rpc_xprt *xprt, ssize_t err, size_t total),
 
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index 8ab64ea46870..e62d339ba589 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -1378,7 +1378,7 @@ static void xs_udp_data_receive_workfn(struct work_struct *work)
 }
 
 /**
- * xs_data_ready - "data ready" callback for UDP sockets
+ * xs_data_ready - "data ready" callback for sockets
  * @sk: socket with data to read
  *
  */
@@ -1386,11 +1386,13 @@ static void xs_data_ready(struct sock *sk)
 {
 	struct rpc_xprt *xprt;
 
-	dprintk("RPC:       xs_data_ready...\n");
 	xprt = xprt_from_sock(sk);
 	if (xprt != NULL) {
 		struct sock_xprt *transport = container_of(xprt,
 				struct sock_xprt, xprt);
+
+		trace_xs_data_ready(xprt);
+
 		transport->old_data_ready(sk);
 		/* Any data means we had a useful conversation, so
 		 * then we don't need to delay the next reconnect



