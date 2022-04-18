Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5C8C4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 16:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r2c1U7+aw2MPsrvMDANTwcPXG79IESzj4U69oAwgaos=; b=TNB8yZpIA7l7zGsjCp+T+I5vbW
	nARgVgj8v6GoGDMKil0mOXk4nlV8IrH4KOw5GlUFaKKX+EfWp60h8hoE0eSFLt51i9HUoRd5GXPif
	uRLLY1X++XYv37xvOUG77KEEXGFkwvRF7MsMaJT0iuGQ/X+eOybjTYSiANnXs76jzx7VnHiYYS3Ab
	Er/ad8O0DhWUQU9+5YiAGhFLxcg1S7SiYXUKheSM0skqwMIicxQ7i3WMW19YRnsJ7kEL2X6J554r2
	Sq6cH0S6/5kOs2n3a2Gjs3IK796UxHs0xZg0za2nGGR2PY7VjumvaLXYL8aoVDjp4VilZbEcpFoxF
	DhcxE+5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngUe2-000A0C-MC; Mon, 18 Apr 2022 16:54:34 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngUbW-0008W8-5F
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 16:52:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 95D39612EC;
 Mon, 18 Apr 2022 16:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBF07C385B8;
 Mon, 18 Apr 2022 16:51:55 +0000 (UTC)
Subject: [PATCH RFC 07/15] SUNRPC: Refactor rpc_call_null_helper()
From: Chuck Lever <chuck.lever@oracle.com>
To: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
Date: Mon, 18 Apr 2022 12:51:54 -0400
Message-ID: <165030071492.5246.11926309853435664142.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
References: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_095158_312834_4B6580A8 
X-CRM114-Status: GOOD (  10.54  )
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

We need to use RPC_TASK_TLSCRED instead of RPC_TASK_NULLCREDS in one
upcoming case.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 3d3be55205bb..3fb601d8a531 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2734,8 +2734,7 @@ struct rpc_task *rpc_call_null_helper(struct rpc_clnt *clnt,
 		.rpc_op_cred = cred,
 		.callback_ops = ops ?: &rpc_null_ops,
 		.callback_data = data,
-		.flags = flags | RPC_TASK_SOFT | RPC_TASK_SOFTCONN |
-			 RPC_TASK_NULLCREDS,
+		.flags = flags | RPC_TASK_SOFT | RPC_TASK_SOFTCONN,
 	};
 
 	return rpc_run_task(&task_setup_data);
@@ -2743,7 +2742,8 @@ struct rpc_task *rpc_call_null_helper(struct rpc_clnt *clnt,
 
 struct rpc_task *rpc_call_null(struct rpc_clnt *clnt, struct rpc_cred *cred, int flags)
 {
-	return rpc_call_null_helper(clnt, NULL, cred, flags, NULL, NULL);
+	return rpc_call_null_helper(clnt, NULL, cred, flags | RPC_TASK_NULLCREDS,
+				    NULL, NULL);
 }
 EXPORT_SYMBOL_GPL(rpc_call_null);
 
@@ -2821,9 +2821,11 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 		goto success;
 	}
 
-	task = rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_ASYNC,
-			&rpc_cb_add_xprt_call_ops, data);
+	task = rpc_call_null_helper(clnt, xprt, NULL,
+				    RPC_TASK_ASYNC | RPC_TASK_NULLCREDS,
+				    &rpc_cb_add_xprt_call_ops, data);
 	data->xps->xps_nunique_destaddr_xprts++;
+
 	rpc_put_task(task);
 success:
 	return 1;
@@ -2864,7 +2866,8 @@ int rpc_clnt_setup_test_and_add_xprt(struct rpc_clnt *clnt,
 		goto out_err;
 
 	/* Test the connection */
-	task = rpc_call_null_helper(clnt, xprt, NULL, 0, NULL, NULL);
+	task = rpc_call_null_helper(clnt, xprt, NULL, RPC_TASK_NULLCREDS,
+				    NULL, NULL);
 	if (IS_ERR(task)) {
 		status = PTR_ERR(task);
 		goto out_err;



