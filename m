Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC53C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 16:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bBaw6eu5T5OlkE+MSZxds1OmLyjIDBnTmB7wz3+ZeBA=; b=MAG4Kc3b+IMKXh3s4Yyh4K2E9r
	WmgBrgnEZQ0IpS6S4qTAdHKCvP9li9eNBnZE/m7lqcS07WquVFobe4jV6DQZg4LIfYTlUydfBcpxb
	Kohl7HnC2RMZxFYX838HhcE7HPDKAixU2D2XD54trJ5BfgwE521lqIe8F2mbM10GRQzY0hanh1WZP
	UpxtplDmJF0sO2d2tUeGFtYB84ucEaPtUbozwHvhKoKRVtlCzQxXinQV3p4HEBc074bij6MD83eZ1
	jBHwPl8XGi0PLKzb6vOLsHgJUjmpz4b2uWPGryXOcWB9GON2vX3jLwT4GKlS07A13A4adN/qamiF/
	SsS/sJXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngUd0-0009MF-VF; Mon, 18 Apr 2022 16:53:31 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngUbK-0008Qg-Ep
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 16:51:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 14835B81056;
 Mon, 18 Apr 2022 16:51:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCAFC385AB;
 Mon, 18 Apr 2022 16:51:42 +0000 (UTC)
Subject: [PATCH RFC 05/15] SUNRPC: Widen rpc_task::tk_flags
From: Chuck Lever <chuck.lever@oracle.com>
To: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
Date: Mon, 18 Apr 2022 12:51:41 -0400
Message-ID: <165030070110.5246.445378754862166608.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
References: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_095146_857853_FD06ECA8 
X-CRM114-Status: GOOD (  15.30  )
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

There is just one unused bit left in rpc_task::tk_flags, and I will
need two in subsequent patches. Double the width of the field to
accommodate more flag bits.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/clnt.h  |    6 ++++--
 include/linux/sunrpc/sched.h |   32 ++++++++++++++++----------------
 net/sunrpc/clnt.c            |   11 ++++++-----
 net/sunrpc/debugfs.c         |    2 +-
 4 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 267b7aeaf1a6..ec0d241730cb 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -192,11 +192,13 @@ void rpc_prepare_reply_pages(struct rpc_rqst *req, struct page **pages,
 			     unsigned int hdrsize);
 void		rpc_call_start(struct rpc_task *);
 int		rpc_call_async(struct rpc_clnt *clnt,
-			       const struct rpc_message *msg, int flags,
+			       const struct rpc_message *msg,
+			       unsigned int flags,
 			       const struct rpc_call_ops *tk_ops,
 			       void *calldata);
 int		rpc_call_sync(struct rpc_clnt *clnt,
-			      const struct rpc_message *msg, int flags);
+			      const struct rpc_message *msg,
+			      unsigned int flags);
 struct rpc_task *rpc_call_null(struct rpc_clnt *clnt, struct rpc_cred *cred,
 			       int flags);
 int		rpc_restart_call_prepare(struct rpc_task *);
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index 1d7a3e51b795..d4b7ebd0a99c 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -82,7 +82,7 @@ struct rpc_task {
 	ktime_t			tk_start;	/* RPC task init timestamp */
 
 	pid_t			tk_owner;	/* Process id for batching tasks */
-	unsigned short		tk_flags;	/* misc flags */
+	unsigned int		tk_flags;	/* misc flags */
 	unsigned short		tk_timeouts;	/* maj timeouts */
 
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG) || IS_ENABLED(CONFIG_TRACEPOINTS)
@@ -112,27 +112,27 @@ struct rpc_task_setup {
 	const struct rpc_call_ops *callback_ops;
 	void *callback_data;
 	struct workqueue_struct *workqueue;
-	unsigned short flags;
+	unsigned int flags;
 	signed char priority;
 };
 
 /*
  * RPC task flags
  */
-#define RPC_TASK_ASYNC		0x0001		/* is an async task */
-#define RPC_TASK_SWAPPER	0x0002		/* is swapping in/out */
-#define RPC_TASK_MOVEABLE	0x0004		/* nfs4.1+ rpc tasks */
-#define RPC_TASK_NULLCREDS	0x0010		/* Use AUTH_NULL credential */
-#define RPC_CALL_MAJORSEEN	0x0020		/* major timeout seen */
-#define RPC_TASK_DYNAMIC	0x0080		/* task was kmalloc'ed */
-#define	RPC_TASK_NO_ROUND_ROBIN	0x0100		/* send requests on "main" xprt */
-#define RPC_TASK_SOFT		0x0200		/* Use soft timeouts */
-#define RPC_TASK_SOFTCONN	0x0400		/* Fail if can't connect */
-#define RPC_TASK_SENT		0x0800		/* message was sent */
-#define RPC_TASK_TIMEOUT	0x1000		/* fail with ETIMEDOUT on timeout */
-#define RPC_TASK_NOCONNECT	0x2000		/* return ENOTCONN if not connected */
-#define RPC_TASK_NO_RETRANS_TIMEOUT	0x4000		/* wait forever for a reply */
-#define RPC_TASK_CRED_NOREF	0x8000		/* No refcount on the credential */
+#define RPC_TASK_ASYNC			0x00000001	/* is an async task */
+#define RPC_TASK_SWAPPER		0x00000002	/* is swapping in/out */
+#define RPC_TASK_MOVEABLE		0x00000004	/* nfs4.1+ rpc tasks */
+#define RPC_TASK_NULLCREDS		0x00000010	/* Use AUTH_NULL credential */
+#define RPC_CALL_MAJORSEEN		0x00000020	/* major timeout seen */
+#define RPC_TASK_DYNAMIC		0x00000080	/* task was kmalloc'ed */
+#define	RPC_TASK_NO_ROUND_ROBIN		0x00000100	/* send requests on "main" xprt */
+#define RPC_TASK_SOFT			0x00000200	/* Use soft timeouts */
+#define RPC_TASK_SOFTCONN		0x00000400	/* Fail if can't connect */
+#define RPC_TASK_SENT			0x00000800	/* message was sent */
+#define RPC_TASK_TIMEOUT		0x00001000	/* fail with ETIMEDOUT on timeout */
+#define RPC_TASK_NOCONNECT		0x00002000	/* return ENOTCONN if not connected */
+#define RPC_TASK_NO_RETRANS_TIMEOUT	0x00004000	/* wait forever for a reply */
+#define RPC_TASK_CRED_NOREF		0x00008000	/* No refcount on the credential */
 
 #define RPC_IS_ASYNC(t)		((t)->tk_flags & RPC_TASK_ASYNC)
 #define RPC_IS_SWAPPER(t)	((t)->tk_flags & RPC_TASK_SWAPPER)
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index ef3d7e4a26e7..3d3be55205bb 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1151,7 +1151,8 @@ EXPORT_SYMBOL_GPL(rpc_run_task);
  * @msg: RPC call parameters
  * @flags: RPC call flags
  */
-int rpc_call_sync(struct rpc_clnt *clnt, const struct rpc_message *msg, int flags)
+int rpc_call_sync(struct rpc_clnt *clnt, const struct rpc_message *msg,
+		  unsigned int flags)
 {
 	struct rpc_task	*task;
 	struct rpc_task_setup task_setup_data = {
@@ -1186,9 +1187,9 @@ EXPORT_SYMBOL_GPL(rpc_call_sync);
  * @tk_ops: RPC call ops
  * @data: user call data
  */
-int
-rpc_call_async(struct rpc_clnt *clnt, const struct rpc_message *msg, int flags,
-	       const struct rpc_call_ops *tk_ops, void *data)
+int rpc_call_async(struct rpc_clnt *clnt, const struct rpc_message *msg,
+		   unsigned int flags, const struct rpc_call_ops *tk_ops,
+		   void *data)
 {
 	struct rpc_task	*task;
 	struct rpc_task_setup task_setup_data = {
@@ -3043,7 +3044,7 @@ static void rpc_show_task(const struct rpc_clnt *clnt,
 	if (RPC_IS_QUEUED(task))
 		rpc_waitq = rpc_qname(task->tk_waitqueue);
 
-	printk(KERN_INFO "%5u %04x %6d %8p %8p %8ld %8p %sv%u %s a:%ps q:%s\n",
+	printk(KERN_INFO "%5u %08x %6d %8p %8p %8ld %8p %sv%u %s a:%ps q:%s\n",
 		task->tk_pid, task->tk_flags, task->tk_status,
 		clnt, task->tk_rqstp, rpc_task_timeout(task), task->tk_ops,
 		clnt->cl_program->name, clnt->cl_vers, rpc_proc_name(task),
diff --git a/net/sunrpc/debugfs.c b/net/sunrpc/debugfs.c
index 7dc9cc929bfd..8b66235a3a49 100644
--- a/net/sunrpc/debugfs.c
+++ b/net/sunrpc/debugfs.c
@@ -30,7 +30,7 @@ tasks_show(struct seq_file *f, void *v)
 	if (task->tk_rqstp)
 		xid = be32_to_cpu(task->tk_rqstp->rq_xid);
 
-	seq_printf(f, "%5u %04x %6d 0x%x 0x%x %8ld %ps %sv%u %s a:%ps q:%s\n",
+	seq_printf(f, "%5u %08x %6d 0x%x 0x%x %8ld %ps %sv%u %s a:%ps q:%s\n",
 		task->tk_pid, task->tk_flags, task->tk_status,
 		clnt->cl_clid, xid, rpc_task_timeout(task), task->tk_ops,
 		clnt->cl_program->name, clnt->cl_vers, rpc_proc_name(task),



