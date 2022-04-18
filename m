Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A1DC43217
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 16:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aMKg/h9tc6bm6+Uw00NvBU5GlTugMhGLLvlnXEVsoDA=; b=ismFa2BNDjEeOEuv8HcE98lDM6
	UEWxTrwLtLqTnjOXb3QQ0ErJ8VUn1GtR/U8Xoz6woL4I+e8SMXg6to43mWdmHzjH+33NYdptDZrdq
	RvrP0ixIrYe5tL2UfUAHIC+9PAgq2fWkVSkjePQ0rH23ZjooA4HIfTXi5TxqdJEnbPS7HyyBUI854
	LkIrTIUNPK2zmlmxAkQhKDEYZQwI9d/Jd0KmiF804XVWsLNUVgOrwcM/0Rtw455u2kUvD059s3Qb3
	OY3sq1xCWQ8WAbukN3uQaTrRiOL1lNDsllFQfRuUi60PG7wDQJuCOuGsf3q67xVPcWl/kaXq+3SM/
	MfuMzTQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngUcY-000954-Lc; Mon, 18 Apr 2022 16:53:02 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngUbD-0008Mp-16
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 16:51:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 2C7B0B81049;
 Mon, 18 Apr 2022 16:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DC0C385A7;
 Mon, 18 Apr 2022 16:51:35 +0000 (UTC)
Subject: [PATCH RFC 04/15] SUNRPC: Fail faster on bad verifier
From: Chuck Lever <chuck.lever@oracle.com>
To: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
Date: Mon, 18 Apr 2022 12:51:34 -0400
Message-ID: <165030069404.5246.6833136485402480106.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
References: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_095139_293232_E8F09CC5 
X-CRM114-Status: GOOD (  10.97  )
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

A bad verifier is not a garbage argument, it's an authentication
failure. Retrying it doesn't make the problem go away, and delays
upper layer recovery steps.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/clnt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index af0174d7ce5a..ef3d7e4a26e7 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2639,7 +2639,7 @@ rpc_decode_header(struct rpc_task *task, struct xdr_stream *xdr)
 
 out_verifier:
 	trace_rpc_bad_verifier(task);
-	goto out_garbage;
+	goto out_err;
 
 out_msg_denied:
 	error = -EACCES;



