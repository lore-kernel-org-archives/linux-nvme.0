Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E6E6C6FD18
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 14:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=co2BIO/ubiv9x8B5uM8C1F6vLB1+D1S/cSvKvVl0zAc=; b=C20TYTSY4Z7zyaGwWWpMw2cqYv
	hYErhDQly02xKZMHv0HWbmFJCNnLVCnRjHxaSUPseHQSClj9b9goiNDEKEFZ6Sz+XxXDBrUUUX/1L
	ytx79D4Uhzmgvx36V3k2Dq2DWsUqw4WYcqhSa1rtsubQf+6JA9GbrT+jvFUaRV244xCtn1l85bo6m
	1HI5SW6rhf+eqeCnzvfFtULrn7dU+fyfM7yEQY/2OquEqURZrTOyb9FK4iwlRnllTt4scXrzAPIs3
	azWTFGmApjzbIaFfweGlBjrxPeeTrwhgATM3U8TwwmDsTLlHfQykZqdiknB8LTj5y+CNODs0uk4+m
	kVq+fggw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLc-000V4n-2Z;
	Wed, 29 Mar 2023 14:00:20 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phWLI-000UlV-0c
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 14:00:04 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 0AD981FE00;
	Wed, 29 Mar 2023 13:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1680098390; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=co2BIO/ubiv9x8B5uM8C1F6vLB1+D1S/cSvKvVl0zAc=;
	b=DAEkrBHlceLjE7/kDwozsQpojRDjH7WCG9wOzEObCqgJmGRQ0v8/Dase6XGAFr6/GmiBVm
	OE8o0mBCozIU7+MD+zW3W3G3kEmPgDiAWmGZrNfNj5L8xfVyh9p1uIfHa8JbRAGW5KRzLr
	QHyPhUnCK4KIjvDEz9DjKE6wbx0XXDU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1680098390;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=co2BIO/ubiv9x8B5uM8C1F6vLB1+D1S/cSvKvVl0zAc=;
	b=rcvB+BLx2aQDChAX/vsPBLeQjNx0WMDWNusN2Ldrl/V6eGfGW+Q0E0UJV79r8DKbX4ISDl
	la5gb2/vVP6teZDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id EDB9C2C188;
	Wed, 29 Mar 2023 13:59:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id EB96C51BF392; Wed, 29 Mar 2023 15:59:49 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 16/18] nvmet-tcp: rework sendpage for kTLS
Date: Wed, 29 Mar 2023 15:59:36 +0200
Message-Id: <20230329135938.46905-17-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230329135938.46905-1-hare@suse.de>
References: <20230329135938.46905-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_070000_411356_D3BC2339 
X-CRM114-Status: GOOD (  10.41  )
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

kTLS ->sendpage() doesn't support the MSG_EOR flag, so blank
it out if kTLS is enabled.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/tcp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index ebec882120fd..5daf16138471 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -650,7 +650,7 @@ static int nvmet_try_send_response(struct nvmet_tcp_cmd *cmd,
 
 	if (!last_in_batch && cmd->queue->send_list_len)
 		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
-	else
+	else if (!cmd->queue->tls_psk)
 		flags |= MSG_EOR;
 
 	ret = kernel_sendpage(cmd->queue->sock, virt_to_page(cmd->rsp_pdu),
@@ -678,7 +678,7 @@ static int nvmet_try_send_r2t(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 
 	if (!last_in_batch && cmd->queue->send_list_len)
 		flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
-	else
+	else if (!cmd->queue->tls_psk)
 		flags |= MSG_EOR;
 
 	ret = kernel_sendpage(cmd->queue->sock, virt_to_page(cmd->r2t_pdu),
@@ -708,7 +708,7 @@ static int nvmet_try_send_ddgst(struct nvmet_tcp_cmd *cmd, bool last_in_batch)
 
 	if (!last_in_batch && cmd->queue->send_list_len)
 		msg.msg_flags |= MSG_MORE;
-	else
+	else if (!cmd->queue->tls_psk)
 		msg.msg_flags |= MSG_EOR;
 
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
-- 
2.35.3


