Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C77FC76195
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 12:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VGLxyqKoY1MTbUqbZTc+9465Y6oxU6+lu9J9eKjRWEc=; b=v8w2C0qH5Ppd/fAT3uLY4IFidQ
	pgDUmcJaGGRztQW6sOTpDAX5BiEaDaNLCNeTP4S/8C4fM+nOWu8e4YobeFnQpjiPESfq5sCKi4qKs
	uxDZRv39lCKDB/mty7hea/6Ad2KnrY5aUR5Y1qGXeO803iqhrdXE42rjAH+o96v57tVuKDEJzkX92
	kM2talRJ5XQprRq4P6AzSaXj0pwH94l8fWZizAHT9MgxrkeRpNyO6I/O0+Fpq6yzWFGh83yyZ+kjN
	za92slJpfnUdp0+9z8YpwCsGr2nK/gc7qUfFnrnHPerZ0fWyJMLxztjj+hy5Wf+6vr1U2RlIdYUUC
	ohUw0omA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pebLh-00CNdE-0f;
	Tue, 21 Mar 2023 12:44:21 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pebLS-00CNS7-0X
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 12:44:08 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 012E420002;
	Tue, 21 Mar 2023 12:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1679402638; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGLxyqKoY1MTbUqbZTc+9465Y6oxU6+lu9J9eKjRWEc=;
	b=WjzsPP7L+VVHe54D4zSvR0UlGnGrQ+6VY/ajF70NqBSMKfDYOeoLghzENa6eeTzdJQ17I8
	rO5cLZfK5xbqNOKSOANfmCptLvoR2I2li2H/TS9nf4GQMXu5PcWPJ2eKBvj20lHaYTw3wT
	vNDoxk83etTC5pnJbHeEyjYtHBdKqUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1679402638;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VGLxyqKoY1MTbUqbZTc+9465Y6oxU6+lu9J9eKjRWEc=;
	b=mbc/IklgqvZzqiP/Lb17CjSv9dVUv0K1n7U/8U0RrS9FXfl/V3ZrNyEr7wRpX7XKMmvJ+P
	Iv+XwLn1Fq5aHYBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id DF6EA2C153;
	Tue, 21 Mar 2023 12:43:57 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id D865251BEEA6; Tue, 21 Mar 2023 13:43:57 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <cel@kernel.org>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 09/18] nvme-tcp: add connect option 'tls'
Date: Tue, 21 Mar 2023 13:43:16 +0100
Message-Id: <20230321124325.77385-10-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230321124325.77385-1-hare@suse.de>
References: <20230321124325.77385-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_054406_359466_A35FE948 
X-CRM114-Status: GOOD (  15.68  )
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

Add a connect option 'tls' to request TLS1.3 in-band encryption, and
abort the connection attempt if TLS could not be established.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fabrics.c | 5 +++++
 drivers/nvme/host/fabrics.h | 2 ++
 drivers/nvme/host/tcp.c     | 7 ++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index bbaa04a0c502..fdff7cdff029 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -609,6 +609,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_DISCOVERY,		"discovery"		},
 	{ NVMF_OPT_DHCHAP_SECRET,	"dhchap_secret=%s"	},
 	{ NVMF_OPT_DHCHAP_CTRL_SECRET,	"dhchap_ctrl_secret=%s"	},
+	{ NVMF_OPT_TLS,			"tls"			},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -632,6 +633,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->hdr_digest = false;
 	opts->data_digest = false;
 	opts->tos = -1; /* < 0 == use transport default */
+	opts->tls = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -918,6 +920,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			kfree(opts->dhchap_ctrl_secret);
 			opts->dhchap_ctrl_secret = p;
 			break;
+		case NVMF_OPT_TLS:
+			opts->tls = true;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index dcac3df8a5f7..c4538a9d437c 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -70,6 +70,7 @@ enum {
 	NVMF_OPT_DISCOVERY	= 1 << 22,
 	NVMF_OPT_DHCHAP_SECRET	= 1 << 23,
 	NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
+	NVMF_OPT_TLS		= 1 << 25,
 };
 
 /**
@@ -128,6 +129,7 @@ struct nvmf_ctrl_options {
 	int			max_reconnects;
 	char			*dhchap_secret;
 	char			*dhchap_ctrl_secret;
+	bool			tls;
 	bool			disable_sqflow;
 	bool			hdr_digest;
 	bool			data_digest;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bcf24e9a08e1..bbff1f52a167 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1902,6 +1902,9 @@ static int nvme_tcp_alloc_admin_queue(struct nvme_ctrl *ctrl)
 			break;
 	}
 	if (ret) {
+		/* Abort if TLS is requested */
+		if (num_keys && ctrl->opts->tls)
+			goto out_free_queue;
 		/* Try without TLS */
 		ret = nvme_tcp_alloc_queue(ctrl, 0, 0);
 		if (ret)
@@ -1934,6 +1937,8 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 				break;
 		}
 		if (ret) {
+			if (num_keys && ctrl->opts->tls)
+				goto out_free_queues;
 			ret = nvme_tcp_alloc_queue(ctrl, i, 0);
 			if (ret)
 				goto out_free_queues;
@@ -2844,7 +2849,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
+			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
-- 
2.35.3


