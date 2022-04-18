Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB011C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 16:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WMQWPLQDcDtDmoRHPWndnEKZG0xFcBcreA3MTI24z5s=; b=DbRpeTPPE9GN0pQ8y/mvovHtdI
	Nj9qZ/NNM8QOqRdhPpqtC4JEiJ84D+A44XcS6PfCMa/1qQ9mbhM93OgSI75LQam+iARzDDR5EMZfg
	iQtYeZmYkmRS+AoEIfvI5k8p5eRRj3pOK2KCB61NN2gfO/1cIRH27+7UnSnt7w2ZDSWRpA058NdIo
	8tR48pFJ1qGQbm/YXQb4Ho7hzVPCxVJe3BTWwb5VcFCD8WtMY+eTiPR7/hGPnitN8lTAC+kkPQtsI
	nQAb5vfG45FvU9ZhawZ6QeC7OlKpTXLAhf0Jnb95bINb2mQPRje1mXiEBsqeuh4zcB4EN8UBAWNBQ
	k35QeAQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngUZL-0007It-0z; Mon, 18 Apr 2022 16:49:43 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngUZH-0007GU-37
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 16:49:40 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5488F612DC;
 Mon, 18 Apr 2022 16:49:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9833DC385AA;
 Mon, 18 Apr 2022 16:49:37 +0000 (UTC)
Subject: [PATCH RFC 2/5] tls: build proto after context has been initialized
From: Chuck Lever <chuck.lever@oracle.com>
To: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
Date: Mon, 18 Apr 2022 12:49:36 -0400
Message-ID: <165030057652.5073.10364318727607743572.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
References: <165030051838.5073.8699008789153780301.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_094939_249510_2AE745BE 
X-CRM114-Status: GOOD (  10.57  )
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

From: Hannes Reinecke <hare@suse.de>

We have to build the proto ops only after the context has been
initialized, as otherwise we might crash when I/O is ongoing
during initialisation.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index 7b2b0e7ffee4..7eca4d9a83c4 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -836,8 +836,6 @@ static int tls_init(struct sock *sk)
 	struct tls_context *ctx;
 	int rc = 0;
 
-	tls_build_proto(sk);
-
 #ifdef CONFIG_TLS_TOE
 	if (tls_toe_bypass(sk))
 		return 0;
@@ -862,6 +860,7 @@ static int tls_init(struct sock *sk)
 
 	ctx->tx_conf = TLS_BASE;
 	ctx->rx_conf = TLS_BASE;
+	tls_build_proto(sk);
 	update_sk_prot(sk, ctx);
 out:
 	write_unlock_bh(&sk->sk_callback_lock);



