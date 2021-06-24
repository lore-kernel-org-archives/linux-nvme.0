Return-Path: <SRS0=KdjD=LS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AFFC49EA6
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 13:49:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B303613C1
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Jun 2021 13:49:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B303613C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=r98KW7vKwWrq6Hbc1pgPSeMkrNZdPi8eAYS5OmWk5/M=; b=oRPPapl4q9zeGT
	ljHWoa2j0dcLWWdP3e+DSrCtiSAw0TEW67jIHADUOQvoZ6SlCGADzJAHU6S5D4ODQfj2PeFVifjGW
	bRR/fgDrRiOjOTs9+B2e1al5nNuOYxaqLbHdLL9Q7/78SjX3uRTVREH69KkJx2FJdt+hlzx1jOoSl
	zRx4OfV63++pc0d37qp5bEenggs0ukZwdbtRQs7RG6OLb90iRilBeypgvAPJ/KuhY2bQEMXBDXAR0
	erCoHllfADcj7sHVuHH+CEV6RWmt/b6kohwOSg1P2v+EsfL7hVRTAoNf3HlEcQxB6a4MrUhRe/FAE
	Hwl1TxOehMUs9wcnyP/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lwPit-00Ev6e-B7; Thu, 24 Jun 2021 13:48:51 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwPip-00Ev59-HO
 for linux-nvme@lists.infradead.org; Thu, 24 Jun 2021 13:48:49 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D5EF41FD7F;
 Thu, 24 Jun 2021 13:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1624542525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9wlaLyJmEgYz7vHsMJy0sf0RauU+ay1i+Gwv/+2ud2I=;
 b=2O7Y+4jANqTrTW+2sXDa73SPdB3x2AKPuTJB7RwRtJghgqhjv7dhNCyym46f8fKCLscHMw
 J5yIwgyQZy/d9ocsyvyb1f/R7eo++hf30g1gKxNdiBGDP5aEAAs4vxEpz0d1rWFESLx1aa
 qPCv1aAL5kff5oKqm3L7JbDIxs991pw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1624542525;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9wlaLyJmEgYz7vHsMJy0sf0RauU+ay1i+Gwv/+2ud2I=;
 b=/C0b3u/HcK47s9GDXt8nAqNfmrRsikyldIlX8zYwGzR7Miyqn7upjSLJ7rDJZIxSHufGAB
 hWbVn+w2InWYjFBg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id A3C4BA3BC6;
 Thu, 24 Jun 2021 13:48:45 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 8E236517090C; Thu, 24 Jun 2021 15:48:45 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-fabrics: make cntlid settable
Date: Thu, 24 Jun 2021 15:48:43 +0200
Message-Id: <20210624134843.138389-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210624_064847_768168_9736622A 
X-CRM114-Status: GOOD (  14.78  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

As per spec the controller ID can be set if a subsystem implements the
the static controller model, so add a 'cntlid' option to the connect
string.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fabrics.c | 19 ++++++++++++++++++-
 drivers/nvme/host/fabrics.h |  2 ++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 1e6a7cc056ca..c836625a6745 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -115,6 +115,9 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 	if (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)
 		len += scnprintf(buf + len, size - len, "%shost_iface=%s",
 				(len) ? "," : "", ctrl->opts->host_iface);
+	if (ctrl->opts->mask & NVMF_OPT_CNTLID)
+		len += scnprintf(buf + len, size - len, "%scntlid=%d",
+				(len) ? "," : "", ctrl->opts->cntlid);
 	len += scnprintf(buf + len, size - len, "\n");
 
 	return len;
@@ -385,7 +388,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		return -ENOMEM;
 
 	uuid_copy(&data->hostid, &ctrl->opts->host->id);
-	data->cntlid = cpu_to_le16(0xffff);
+	data->cntlid = cpu_to_le16(ctrl->opts->cntlid);
 	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
 	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
 
@@ -541,6 +544,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_HOST_TRADDR,		"host_traddr=%s"	},
 	{ NVMF_OPT_HOST_IFACE,		"host_iface=%s"		},
 	{ NVMF_OPT_HOST_ID,		"hostid=%s"		},
+	{ NVMF_OPT_CNTLID,		"cntlid=%d"		},
 	{ NVMF_OPT_DUP_CONNECT,		"duplicate_connect"	},
 	{ NVMF_OPT_DISABLE_SQFLOW,	"disable_sqflow"	},
 	{ NVMF_OPT_HDR_DIGEST,		"hdr_digest"		},
@@ -572,6 +576,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->hdr_digest = false;
 	opts->data_digest = false;
 	opts->tos = -1; /* < 0 == use transport default */
+	opts->cntlid = 0xffff;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -773,6 +778,18 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			kfree(p);
 			break;
+		case NVMF_OPT_CNTLID:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			if (token < 0 || token > 0xffff) {
+				pr_err("Invalid controller id %d\n", token);
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->cntlid = token;
+			break;
 		case NVMF_OPT_DUP_CONNECT:
 			opts->duplicate_connect = true;
 			break;
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index c31dad69a773..8e32a64cefff 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -67,6 +67,7 @@ enum {
 	NVMF_OPT_TOS		= 1 << 19,
 	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
 	NVMF_OPT_HOST_IFACE	= 1 << 21,
+	NVMF_OPT_CNTLID		= 1 << 22,
 };
 
 /**
@@ -112,6 +113,7 @@ struct nvmf_ctrl_options {
 	char			*trsvcid;
 	char			*host_traddr;
 	char			*host_iface;
+	unsigned int		cntlid;
 	size_t			queue_size;
 	unsigned int		nr_io_queues;
 	unsigned int		reconnect_delay;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
