Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6948AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 16:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mxO4cycwGiIz1uhFrPCqt9P71/M83+0uZxdt+k91RUs=; b=c7cd6q/p2ZYzYf3TZsPV8bZJw/
	4AIPdNARWruoibxQc2uDh3gBnU4HlA/srnb/7E2u3WlmUFjlTIzbKSd+QmIYWikumicLos23zSJci
	b5eunA/a+I6NtxYCq9JwJEa/gQyYiND+5vGJwU30GxKBKhaU6XrLb1KIKv/cLhLyQ+Mrm0lD6c2Ow
	yT0piIYFCBe+D5ndG7DjWTPcOh6Y+gNz4286zrMm+Iz1VW3SVmLK2F58UPbVDmQbSdoBxNLWm7Qwe
	wburn0JaIzfzDTNMOlNHAzqVR4JnY8WsPkeRc78fd7UfEhFQR7+n8qkS692f8KyCJMyKHmEoQYNj6
	UhU2u9fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngUdL-0009a2-4E; Mon, 18 Apr 2022 16:53:51 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngUbO-0008Sh-SI
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 16:51:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5999D612CB;
 Mon, 18 Apr 2022 16:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 099BEC385A1;
 Mon, 18 Apr 2022 16:51:48 +0000 (UTC)
Subject: [PATCH RFC 06/15] SUNRPC: Add RPC client support for the RPC_AUTH_TLS
 authentication flavor
From: Chuck Lever <chuck.lever@oracle.com>
To: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
Date: Mon, 18 Apr 2022 12:51:47 -0400
Message-ID: <165030070790.5246.6940180005241060749.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
References: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_095151_068807_FB9D9083 
X-CRM114-Status: GOOD (  19.77  )
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

The new authentication flavor is used to discover peer support for
RPC-over-TLS.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/auth.h   |    1 
 include/linux/sunrpc/sched.h  |    1 
 include/trace/events/sunrpc.h |    1 
 net/sunrpc/Makefile           |    2 -
 net/sunrpc/auth.c             |    2 +
 net/sunrpc/auth_tls.c         |  117 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 net/sunrpc/auth_tls.c

diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
index 3e6ce288a7fc..1f13d923f439 100644
--- a/include/linux/sunrpc/auth.h
+++ b/include/linux/sunrpc/auth.h
@@ -144,6 +144,7 @@ struct rpc_credops {
 
 extern const struct rpc_authops	authunix_ops;
 extern const struct rpc_authops	authnull_ops;
+extern const struct rpc_authops	authtls_ops;
 
 int __init		rpc_init_authunix(void);
 int __init		rpcauth_init_module(void);
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index d4b7ebd0a99c..599133fb3c63 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -122,6 +122,7 @@ struct rpc_task_setup {
 #define RPC_TASK_ASYNC			0x00000001	/* is an async task */
 #define RPC_TASK_SWAPPER		0x00000002	/* is swapping in/out */
 #define RPC_TASK_MOVEABLE		0x00000004	/* nfs4.1+ rpc tasks */
+#define RPC_TASK_TLSCRED		0x00000008	/* Use AUTH_TLS credential */
 #define RPC_TASK_NULLCREDS		0x00000010	/* Use AUTH_NULL credential */
 #define RPC_CALL_MAJORSEEN		0x00000020	/* major timeout seen */
 #define RPC_TASK_DYNAMIC		0x00000080	/* task was kmalloc'ed */
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 49b748c03610..811187c47ebb 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -309,6 +309,7 @@ TRACE_EVENT(rpc_request,
 		{ RPC_TASK_ASYNC, "ASYNC" },				\
 		{ RPC_TASK_SWAPPER, "SWAPPER" },			\
 		{ RPC_TASK_MOVEABLE, "MOVEABLE" },			\
+		{ RPC_TASK_TLSCRED, "TLSCRED" },			\
 		{ RPC_TASK_NULLCREDS, "NULLCREDS" },			\
 		{ RPC_CALL_MAJORSEEN, "MAJORSEEN" },			\
 		{ RPC_TASK_DYNAMIC, "DYNAMIC" },			\
diff --git a/net/sunrpc/Makefile b/net/sunrpc/Makefile
index 1c8de397d6ad..f89c10fe7e6a 100644
--- a/net/sunrpc/Makefile
+++ b/net/sunrpc/Makefile
@@ -9,7 +9,7 @@ obj-$(CONFIG_SUNRPC_GSS) += auth_gss/
 obj-$(CONFIG_SUNRPC_XPRT_RDMA) += xprtrdma/
 
 sunrpc-y := clnt.o xprt.o socklib.o xprtsock.o sched.o \
-	    auth.o auth_null.o auth_unix.o \
+	    auth.o auth_null.o auth_tls.o auth_unix.o \
 	    svc.o svcsock.o svcauth.o svcauth_unix.o \
 	    addr.o rpcb_clnt.o timer.o xdr.o \
 	    sunrpc_syms.o cache.o rpc_pipe.o sysfs.o \
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 682fcd24bf43..8a9b358f7ed7 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -674,6 +674,8 @@ rpcauth_bindcred(struct rpc_task *task, const struct cred *cred, int flags)
 		new = rpcauth_bind_root_cred(task, lookupflags);
 	else if (flags & RPC_TASK_NULLCREDS)
 		new = authnull_ops.lookup_cred(NULL, NULL, 0);
+	else if (flags & RPC_TASK_TLSCRED)
+		new = authtls_ops.lookup_cred(NULL, NULL, 0);
 	else
 		new = rpcauth_bind_new_cred(task, lookupflags);
 	if (IS_ERR(new))
diff --git a/net/sunrpc/auth_tls.c b/net/sunrpc/auth_tls.c
new file mode 100644
index 000000000000..244f0890d471
--- /dev/null
+++ b/net/sunrpc/auth_tls.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021 Oracle.  All rights reserved.
+ *
+ * The AUTH_TLS credential is used only to probe a remote peer
+ * for RPC-over-TLS support.
+ */
+
+#include <linux/types.h>
+#include <linux/module.h>
+#include <linux/sunrpc/clnt.h>
+
+static struct rpc_auth tls_auth;
+static struct rpc_cred tls_cred;
+
+static struct rpc_auth *tls_create(const struct rpc_auth_create_args *args,
+				   struct rpc_clnt *clnt)
+{
+	refcount_inc(&tls_auth.au_count);
+	return &tls_auth;
+}
+
+static void tls_destroy(struct rpc_auth *auth)
+{
+}
+
+static struct rpc_cred *tls_lookup_cred(struct rpc_auth *auth,
+					struct auth_cred *acred, int flags)
+{
+	return get_rpccred(&tls_cred);
+}
+
+static void tls_destroy_cred(struct rpc_cred *cred)
+{
+}
+
+static int tls_match(struct auth_cred *acred, struct rpc_cred *cred, int taskflags)
+{
+	return 1;
+}
+
+static int tls_marshal(struct rpc_task *task, struct xdr_stream *xdr)
+{
+	__be32 *p;
+
+	p = xdr_reserve_space(xdr, 4 * XDR_UNIT);
+	if (!p)
+		return -EMSGSIZE;
+	/* Credential */
+	*p++ = rpc_auth_tls;
+	*p++ = xdr_zero;
+	/* Verifier */
+	*p++ = rpc_auth_null;
+	*p   = xdr_zero;
+	return 0;
+}
+
+static int tls_refresh(struct rpc_task *task)
+{
+	set_bit(RPCAUTH_CRED_UPTODATE, &task->tk_rqstp->rq_cred->cr_flags);
+	return 0;
+}
+
+static int tls_validate(struct rpc_task *task, struct xdr_stream *xdr)
+{
+	__be32 *p;
+	void *str;
+
+	p = xdr_inline_decode(xdr, XDR_UNIT);
+	if (!p)
+		return -EIO;
+	if (*p != rpc_auth_null)
+		return -EIO;
+	if (xdr_stream_decode_opaque_inline(xdr, &str, 8) != 8)
+		return -EIO;
+	if (memcmp(str, "STARTTLS", 8))
+		return -EIO;
+	return 0;
+}
+
+const struct rpc_authops authtls_ops = {
+	.owner		= THIS_MODULE,
+	.au_flavor	= RPC_AUTH_TLS,
+	.au_name	= "NULL",
+	.create		= tls_create,
+	.destroy	= tls_destroy,
+	.lookup_cred	= tls_lookup_cred,
+};
+
+static struct rpc_auth tls_auth = {
+	.au_cslack	= NUL_CALLSLACK,
+	.au_rslack	= NUL_REPLYSLACK,
+	.au_verfsize	= NUL_REPLYSLACK,
+	.au_ralign	= NUL_REPLYSLACK,
+	.au_ops		= &authtls_ops,
+	.au_flavor	= RPC_AUTH_TLS,
+	.au_count	= REFCOUNT_INIT(1),
+};
+
+static const struct rpc_credops tls_credops = {
+	.cr_name	= "AUTH_TLS",
+	.crdestroy	= tls_destroy_cred,
+	.crmatch	= tls_match,
+	.crmarshal	= tls_marshal,
+	.crwrap_req	= rpcauth_wrap_req_encode,
+	.crrefresh	= tls_refresh,
+	.crvalidate	= tls_validate,
+	.crunwrap_resp	= rpcauth_unwrap_resp_decode,
+};
+
+static struct rpc_cred tls_cred = {
+	.cr_lru		= LIST_HEAD_INIT(tls_cred.cr_lru),
+	.cr_auth	= &tls_auth,
+	.cr_ops		= &tls_credops,
+	.cr_count	= REFCOUNT_INIT(2),
+	.cr_flags	= 1UL << RPCAUTH_CRED_UPTODATE,
+};



