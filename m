Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7B8C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 16:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Cc:To:From:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g0mx76lheetjqTRZzHFmtXEJpa0zvCgvCOebiQSOT0k=; b=BLlX0ynlcR0KhTyYZPVoKh0Jss
	niRAMyjG2GUoYQN0HnpjC1QAQRr4VvFCvscEhunuOA6bFjcuuvMn6tPelzb8FhQlf4JNq+5ZuS2OE
	49njhQOHzw81jY3p51pLu7ZB8sJfxiYAtpgTuNFjVsjM5uyTsK9NctTbqKidO2gK/9CvaDBhsC6g4
	Wp6Kz9Q6xGWfwyHpcLQnIn5wW/fcudoPvd+IBUHE+mAFZb68OMu2EN0MyPvz/DyVpFm/l2fR0J3JM
	u1RQ0IBATrmroElibwR5AWWkNrcrQ6TY94+KZh5ZlZM8b73FbuOZV2lmeRwfqfH4XxecgIKNcny3A
	VdEToz1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngUbe-0008a7-Jg; Mon, 18 Apr 2022 16:52:06 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngUbF-0008NL-2T
 for linux-nvme@bombadil.infradead.org; Mon, 18 Apr 2022 16:51:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
 :MIME-Version:References:In-Reply-To:Message-ID:Date:Cc:To:From:Subject:
 Sender:Reply-To:Content-ID:Content-Description;
 bh=g0mx76lheetjqTRZzHFmtXEJpa0zvCgvCOebiQSOT0k=; b=h5VvmJ8+g6RrtX/lgWpO7/xEi4
 XolmOMiP7adDAPkarZI+L8Smkk5faVXMuvJ/3mRJVHtrax7oAMvQokZENd64zt76GYMTP9b4CR3SQ
 /3TRvLzES/c8PvxoRpzm1WImPcHHvuRybBuEMwncYIugNTupBHd2bdNIAQvo5nce2e8uY3i+I1Crc
 v4k9qdE9IZwXKN5WenyGi4GHW1mMQ3fijjBTcQ6+INvBR6rIsCl+/xTL6deaTxXrsKqMFPuS3whLf
 L0srlbCBbU4k737IhjfRC/lvqEJ70GwVrTvOhRAPMvcAfDc6TMpagyVPv8m0rA5lA54/URqKL86rU
 vRPoL64w==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngUb7-006ZIn-WB
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 16:51:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 171CE612D0;
 Mon, 18 Apr 2022 16:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59FEFC385A7;
 Mon, 18 Apr 2022 16:51:21 +0000 (UTC)
Subject: [PATCH RFC 02/15] SUNRPC: Ignore data_ready callbacks during TLS
 handshakes
From: Chuck Lever <chuck.lever@oracle.com>
To: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Cc: ak@tempesta-tech.com, borisp@nvidia.com, simo@redhat.com
Date: Mon, 18 Apr 2022 12:51:20 -0400
Message-ID: <165030068031.5246.6914334811243049065.stgit@oracle-102.nfsv4.dev>
In-Reply-To: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
References: <165030062272.5246.16956092606399079004.stgit@oracle-102.nfsv4.dev>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_175134_783866_E1543296 
X-CRM114-Status: GOOD (  12.48  )
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

The RPC header parser doesn't recognize TLS handshake traffic, so it
will close the connection prematurely. To avoid that, shunt the
transport's data_ready callback when there is a TLS handshake in
progress.

The ignore_dr boolean will be toggled by code added in a subsequent
patch.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xprtsock.h |    1 +
 net/sunrpc/xprtsock.c           |    7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/sunrpc/xprtsock.h b/include/linux/sunrpc/xprtsock.h
index 38284f25eddf..426c3bd516fe 100644
--- a/include/linux/sunrpc/xprtsock.h
+++ b/include/linux/sunrpc/xprtsock.h
@@ -40,6 +40,7 @@ struct sock_xprt {
 				len;
 
 		unsigned long	copied;
+		bool		ignore_dr;
 	} recv;
 
 	/*
diff --git a/net/sunrpc/xprtsock.c b/net/sunrpc/xprtsock.c
index e62d339ba589..b5bc03c52b9b 100644
--- a/net/sunrpc/xprtsock.c
+++ b/net/sunrpc/xprtsock.c
@@ -703,6 +703,8 @@ static void xs_poll_check_readable(struct sock_xprt *transport)
 {
 
 	clear_bit(XPRT_SOCK_DATA_READY, &transport->sock_state);
+	if (transport->recv.ignore_dr)
+		return;
 	if (!xs_poll_socket_readable(transport))
 		return;
 	if (!test_and_set_bit(XPRT_SOCK_DATA_READY, &transport->sock_state))
@@ -1394,6 +1396,10 @@ static void xs_data_ready(struct sock *sk)
 		trace_xs_data_ready(xprt);
 
 		transport->old_data_ready(sk);
+
+		if (transport->recv.ignore_dr)
+			return;
+
 		/* Any data means we had a useful conversation, so
 		 * then we don't need to delay the next reconnect
 		 */
@@ -2779,6 +2785,7 @@ static struct rpc_xprt *xs_setup_xprt(struct xprt_create *args,
 	}
 
 	new = container_of(xprt, struct sock_xprt, xprt);
+	new->recv.ignore_dr = false;
 	mutex_init(&new->recv_mutex);
 	memcpy(&xprt->addr, args->dstaddr, args->addrlen);
 	xprt->addrlen = args->addrlen;



