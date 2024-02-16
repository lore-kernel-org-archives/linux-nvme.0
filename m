Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBD3C48BEB
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Feb 2024 08:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yTXpAiEpJ8wDgeOJl+hhqk7EFIqi9rB5Yokta6R/OiA=; b=ec1/gvSNFivkDWjHy0GUIjpr7o
	6/CTJ4ert+LxqHnAdbIbfmQKa+82s8TeIpG6silewfNhrfFkWYuntRfK0cGSp06R/vXVfg6n8erk0
	pQcIrWynEvJQMxFBkhNv4z9m4VoFtDnhCclE2QM8kjEV3UbzAOYBITUsVzlv0Vn6ZLbfWtMUTWVYF
	IGYhNsNeNrG10dIqlmEi7RiIMKMg6mnfMrBKHewJOjoJQNGX3DB8XkJux0iVz8IH+RsTeN5tok3Fr
	MEW0qcbrrNAcRJEK6fWv8b1EGoJkEppi/EENEX5JI2NfvGRrSiMYt0pfxkchk57TwTU+tJ3S0ef1v
	7JRLcFZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ratr5-00000001ZX0-32D5;
	Fri, 16 Feb 2024 08:45:59 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ratqq-00000001ZOF-1ewC
	for linux-nvme@lists.infradead.org;
	Fri, 16 Feb 2024 08:45:55 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7314F22053;
	Fri, 16 Feb 2024 08:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708073139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTXpAiEpJ8wDgeOJl+hhqk7EFIqi9rB5Yokta6R/OiA=;
	b=zoqV4ddpP9CWbGZYDQSBiCaO8S7n4uNm61O9cmscp48+rcZzQYPMcTcHEAAmHnb4Lja/6K
	F9820rQfcOv9C81+ZPoZaf2BXn4NvFIha+Vglbd97I++3pUP/nzmcs8XktPdxJGWZmKPSN
	k3J1Uku8+213u2qgdFy92r1N5knKysI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708073139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTXpAiEpJ8wDgeOJl+hhqk7EFIqi9rB5Yokta6R/OiA=;
	b=6j7XmLkwCvYgb8hH3ErKDUKpdntt4lhCjycCJGEP5N9m6XzjvysF/b8G7dFSHqGbH8AvUR
	tyZJhWALpfJ37PBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708073139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTXpAiEpJ8wDgeOJl+hhqk7EFIqi9rB5Yokta6R/OiA=;
	b=zoqV4ddpP9CWbGZYDQSBiCaO8S7n4uNm61O9cmscp48+rcZzQYPMcTcHEAAmHnb4Lja/6K
	F9820rQfcOv9C81+ZPoZaf2BXn4NvFIha+Vglbd97I++3pUP/nzmcs8XktPdxJGWZmKPSN
	k3J1Uku8+213u2qgdFy92r1N5knKysI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708073139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yTXpAiEpJ8wDgeOJl+hhqk7EFIqi9rB5Yokta6R/OiA=;
	b=6j7XmLkwCvYgb8hH3ErKDUKpdntt4lhCjycCJGEP5N9m6XzjvysF/b8G7dFSHqGbH8AvUR
	tyZJhWALpfJ37PBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F0CE13343;
	Fri, 16 Feb 2024 08:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id +TnBFbMgz2WYcwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 16 Feb 2024 08:45:39 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v0 1/6] nvme-fabrics: introduce connect_sync option
Date: Fri, 16 Feb 2024 09:45:21 +0100
Message-ID: <20240216084526.14133-2-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216084526.14133-1-dwagner@suse.de>
References: <20240216084526.14133-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zoqV4ddp;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=6j7XmLkw
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 7314F22053
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_004544_676845_92CAEAFA 
X-CRM114-Status: GOOD (  15.17  )
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

The TCP and RDMA transport are doing a synchronous connect, meaning the
syscal returns with the final result, that is. it either failed or
succeeded.

This isn't the case for FC. This transport just setups and triggers
the connect and returns without waiting on the result. Introduce a flag
to allow user space to control the behavior, wait or don't wait.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fabrics.c | 6 +++++-
 drivers/nvme/host/fabrics.h | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3499acbf6a82..7d33f0f5824f 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -678,6 +678,7 @@ static const match_table_t opt_tokens = {
 #ifdef CONFIG_NVME_TCP_TLS
 	{ NVMF_OPT_TLS,			"tls"			},
 #endif
+	{ NVMF_OPT_CONNECT_SYNC,	"connect_sync"		},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -1024,6 +1025,9 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->tls = true;
 			break;
+		case NVMF_OPT_CONNECT_SYNC:
+			opts->connect_sync = true;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -1245,7 +1249,7 @@ EXPORT_SYMBOL_GPL(nvmf_free_options);
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
 				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
 				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_DHCHAP_SECRET |\
-				 NVMF_OPT_DHCHAP_CTRL_SECRET)
+				 NVMF_OPT_DHCHAP_CTRL_SECRET | NVMF_OPT_CONNECT_SYNC)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 06cc54851b1b..01d3ef545f14 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -73,6 +73,7 @@ enum {
 	NVMF_OPT_TLS		= 1 << 25,
 	NVMF_OPT_KEYRING	= 1 << 26,
 	NVMF_OPT_TLS_KEY	= 1 << 27,
+	NVMF_OPT_CONNECT_SYNC	= 1 << 28,
 };
 
 /**
@@ -115,6 +116,7 @@ enum {
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
  * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
+ * @connect_sync: wait for connect attempt(s) to succeed or fail
  */
 struct nvmf_ctrl_options {
 	unsigned		mask;
@@ -144,6 +146,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_poll_queues;
 	int			tos;
 	int			fast_io_fail_tmo;
+	bool			connect_sync;
 };
 
 /*
-- 
2.43.0


