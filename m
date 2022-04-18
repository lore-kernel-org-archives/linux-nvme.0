Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C0CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 16:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=46KNDFbf6hFBa1HfJ5NxfwAkOkBAFTxanr3YeWy4+T4=; b=QxZfwLQMOPQxJ+OIrPZFQ5uJUX
	Ib/HFXvRtxxycdKTxm5d1VZvPdLIpZ/fN0CJGlhV3C/l5KYQQdp+D5HtDaR7vJNjOv+/UDWtlzqey
	BhgdM9LwxiL72+vCImUZ72wbVuysDY4Hk0DLmzk1B/z611tYsLaiaAkJoQVote0/cwMKGVOdKO7cN
	4TynQ8F2TCYSDR+IKmNpnfz844tRCFwJY8R6EHB7wwnpszMO1RPkf5X542AHwYBLjwKQYGVEDonF4
	Mi4/tjyRTkmKBmqjAIemYKrOCTRUCMJXKwXAzWe362Mz6BuMtOvVHM6ezqmdMXT2YsbSNhpOzu5RC
	uW5/PTnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngUf3-000Acw-Dh; Mon, 18 Apr 2022 16:55:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngUbi-0008bo-Tc
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 16:52:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 58E78612EC;
 Mon, 18 Apr 2022 16:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F82C385A1;
 Mon, 18 Apr 2022 16:52:09 +0000 (UTC)
Subject: [PATCH RFC 09/15] SUNRPC: Add a cl_xprtsec_policy field
From: Chuck Lever <chuck.lever@oracle.com>
To: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
Date: Mon, 18 Apr 2022 12:52:08 -0400
Message-ID: <165030072859.5246.6224499778231227131.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
References: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_095211_160171_B1B5C39D 
X-CRM114-Status: GOOD (  14.75  )
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

The Linux RPC client will support one  transport security policy for
each struct rpc_clnt:

Three basic ones are added initially:

 = None: No transport security for this rpc_clnt.

 = TLS: The RPC client will establish a TLS session with encryption
   for this rpc_clnt.

 = mTLS: The RPC client will perform mutual peer authentication and
   establish a TLS session with encryption for this rpc_clnt.

Add tracepoints that are used to create an audit trail of TLS usage,
as REQUIRED by Section 7.1 of draft-ietf-nfsv4-rpc-tls-11 .

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/clnt.h   |    7 +++++
 include/trace/events/sunrpc.h |   54 +++++++++++++++++++++++++++++++++++++++++
 net/sunrpc/clnt.c             |    2 ++
 3 files changed, 63 insertions(+)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index ec0d241730cb..14f169aec5c8 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -32,6 +32,12 @@
 struct rpc_inode;
 struct rpc_sysfs_client;
 
+enum rpc_xprtsec {
+	RPC_XPRTSEC_NONE,	/* No transport security is used */
+	RPC_XPRTSEC_TLS,	/* RPC-with-TLS, encryption only */
+	RPC_XPRTSEC_MTLS,	/* RPC-with-TLS, peer auth plus encryption */
+};
+
 /*
  * The high-level client handle
  */
@@ -58,6 +64,7 @@ struct rpc_clnt {
 				cl_noretranstimeo: 1,/* No retransmit timeouts */
 				cl_autobind : 1,/* use getport() */
 				cl_chatty   : 1;/* be verbose */
+	enum rpc_xprtsec	cl_xprtsec_policy;	/* transport security policy */
 
 	struct rpc_rtt *	cl_rtt;		/* RTO estimator data */
 	const struct rpc_timeout *cl_timeout;	/* Timeout strategy */
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index e8d6adff1a50..8ffc9c07bc69 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -139,6 +139,16 @@ DEFINE_RPC_CLNT_EVENT(release);
 DEFINE_RPC_CLNT_EVENT(replace_xprt);
 DEFINE_RPC_CLNT_EVENT(replace_xprt_err);
 
+TRACE_DEFINE_ENUM(RPC_XPRTSEC_NONE);
+TRACE_DEFINE_ENUM(RPC_XPRTSEC_TLS);
+TRACE_DEFINE_ENUM(RPC_XPRTSEC_MTLS);
+
+#define rpc_show_xprtsec_policy(policy)					\
+	__print_symbolic(policy,					\
+		{ RPC_XPRTSEC_NONE,		"none" },		\
+		{ RPC_XPRTSEC_TLS,		"tls" },		\
+		{ RPC_XPRTSEC_MTLS,		"mtls" })
+
 TRACE_EVENT(rpc_clnt_new,
 	TP_PROTO(
 		const struct rpc_clnt *clnt,
@@ -1535,6 +1545,50 @@ TRACE_EVENT(rpcb_unregister,
 	)
 );
 
+/**
+ ** RPC-over-TLS tracepoints
+ **/
+
+DECLARE_EVENT_CLASS(rpc_tls_class,
+	TP_PROTO(
+		const struct rpc_clnt *clnt,
+		const struct rpc_xprt *xprt
+	),
+
+	TP_ARGS(clnt, xprt),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, requested_policy)
+		__field(u32, version)
+		__string(servername, xprt->servername)
+		__string(progname, clnt->cl_program->name)
+	),
+
+	TP_fast_assign(
+		__entry->requested_policy = clnt->cl_xprtsec_policy;
+		__entry->version = clnt->cl_vers;
+		__assign_str(servername, xprt->servername);
+		__assign_str(progname, clnt->cl_program->name)
+	),
+
+	TP_printk("server=%s %sv%u requested_policy=%s",
+		__get_str(servername), __get_str(progname), __entry->version,
+		rpc_show_xprtsec_policy(__entry->requested_policy)
+	)
+);
+
+#define DEFINE_RPC_TLS_EVENT(name) \
+	DEFINE_EVENT(rpc_tls_class, rpc_tls_##name, \
+			TP_PROTO( \
+				const struct rpc_clnt *clnt, \
+				const struct rpc_xprt *xprt \
+			), \
+			TP_ARGS(clnt, xprt))
+
+DEFINE_RPC_TLS_EVENT(unavailable);
+DEFINE_RPC_TLS_EVENT(not_started);
+
+
 /* Record an xdr_buf containing a fully-formed RPC message */
 DECLARE_EVENT_CLASS(svc_xdr_msg_class,
 	TP_PROTO(
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 3fb601d8a531..856581018f10 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -477,6 +477,7 @@ static struct rpc_clnt *rpc_create_xprt(struct rpc_create_args *args,
 	if (IS_ERR(clnt))
 		return clnt;
 
+	clnt->cl_xprtsec_policy = RPC_XPRTSEC_NONE;
 	if (!(args->flags & RPC_CLNT_CREATE_NOPING)) {
 		int err = rpc_ping(clnt);
 		if (err != 0) {
@@ -643,6 +644,7 @@ static struct rpc_clnt *__rpc_clone_client(struct rpc_create_args *args,
 	new->cl_noretranstimeo = clnt->cl_noretranstimeo;
 	new->cl_discrtry = clnt->cl_discrtry;
 	new->cl_chatty = clnt->cl_chatty;
+	new->cl_xprtsec_policy = clnt->cl_xprtsec_policy;
 	new->cl_principal = clnt->cl_principal;
 	return new;
 



