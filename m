Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7D28C53200
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 03:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xwgSsv+t31v8M0nIbsj0ejN/HhnKtVUxm/+T4c2rE4M=; b=4VcYRX3xKRMOGM0AukMVSkKt9C
	o20VD9vD1w4KHp6zJlKbPC646u8dk2kTbTPHo54ONqkN5pt+rWFxhR+oAX1isZWuPQpDdMXmx3pLJ
	gwBRLVWhtSMaL1RDyrljseTqmQrXAd37dYqXGp3PWPeiWZ4xm5iP8H3iA0ZH461keHMJD3h4K6SFy
	o2CYyNWTWuXhtQ7kEtdriR56KIaPvG4JZ6+3ymZDN4TSW3G23gUQAPR6iwbQT8dVNDu81boJJGtZ/
	bm2rikqqfYX3J+U0pSUGJyhl/n2/Q3DrIjbvcAtsYsYdlRSgy1GUS50+d+BVZZP0WgE3z31lY4HLj
	VVvHBmFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woBsO-00000001rY0-1oNu;
	Mon, 27 Jul 2026 03:19:36 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woBsN-00000001rXS-0JnX
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 03:19:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1CFDA601ED;
	Mon, 27 Jul 2026 03:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AB3F1F000E9;
	Mon, 27 Jul 2026 03:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785122373;
	bh=xwgSsv+t31v8M0nIbsj0ejN/HhnKtVUxm/+T4c2rE4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dmstrgG2k7Biq1dzE41HLrYRjlnL1l12mOMekngyLkWYozqncGMQvNN13B0qz0nLN
	 pTghlGUlS1S5Av526trRIPxCzYWhaf+60kAnOzOATdwGjqWDme2iHfBVFW6jt6QN8t
	 pNu1uPafCEKELMb9hmbexBNputbeiDWmbTgvIFPMDt26K2Rz5BlSsj4FFnW1Eyb9TR
	 1xPsWBuNHh1q5na+AIkcbJah1pfbGnbw3hx8Th6Ei/5frZQbx7VWIG2LF4PaLzKBum
	 eBxsYUJnFYpoLUqMCrKR1DL1epj4uJ9+AyXektr/F4wzKMvrtoLRmYEsV5A5ZUxBtD
	 xkTt+l8NM9BSg==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/3] nvme-fabrics: add IPv6 traffic class option
Date: Mon, 27 Jul 2026 11:19:01 +0800
Message-ID: <b7a529f52441ae694ea8b70fbfcede62132ced7e.1785122120.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1785122120.git.tanggeliang@kylinos.cn>
References: <cover.1785122120.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Geliang Tang <tanggeliang@kylinos.cn>

The NVMe/TCP transport needs to configure the IPv6 traffic class on
its queue sockets, but the fabrics option parser currently has no
corresponding option.

Add the tclass option to the fabrics parser and store the validated
value in struct nvmf_ctrl_options. Negative values are rejected, while
values greater than 255 are clamped to 255, matching the valid range
of the IPv6 traffic class field.

Keep -1 as the default value to let the transport use its default
traffic class.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/fabrics.c | 18 ++++++++++++++++++
 drivers/nvme/host/fabrics.h |  3 +++
 2 files changed, 21 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ac3d4f400601..643c03dc7bcb 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -695,6 +695,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
 	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
 	{ NVMF_OPT_TOS,			"tos=%d"		},
+	{ NVMF_OPT_TCLASS,		"tclass=%d"		},
 #ifdef CONFIG_NVME_TCP_TLS
 	{ NVMF_OPT_KEYRING,		"keyring=%d"		},
 	{ NVMF_OPT_TLS_KEY,		"tls_key=%d"		},
@@ -734,6 +735,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->hdr_digest = false;
 	opts->data_digest = false;
 	opts->tos = -1; /* < 0 == use transport default */
+	opts->tclass = -1; /* < 0 == use transport default */
 	opts->tls = false;
 	opts->tls_key = NULL;
 	opts->keyring = NULL;
@@ -991,6 +993,22 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->tos = token;
 			break;
+		case NVMF_OPT_TCLASS:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			if (token < 0) {
+				pr_err("Invalid traffic class %d\n", token);
+				ret = -EINVAL;
+				goto out;
+			}
+			if (token > 255) {
+				pr_warn("Clamping traffic class to 255\n");
+				token = 255;
+			}
+			opts->tclass = token;
+			break;
 		case NVMF_OPT_KEYRING:
 			if (match_int(args, &key_id) || key_id <= 0) {
 				ret = -EINVAL;
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index caf5503d0833..3dfd40bd8960 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -67,6 +67,7 @@ enum {
 	NVMF_OPT_KEYRING	= 1 << 26,
 	NVMF_OPT_TLS_KEY	= 1 << 27,
 	NVMF_OPT_CONCAT		= 1 << 28,
+	NVMF_OPT_TCLASS		= 1 << 29,
 };
 
 /**
@@ -109,6 +110,7 @@ enum {
  * @nr_write_queues: number of queues for write I/O
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
+ * @tclass: IPv6 traffic class
  * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
  */
 struct nvmf_ctrl_options {
@@ -139,6 +141,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_write_queues;
 	unsigned int		nr_poll_queues;
 	int			tos;
+	int			tclass;
 	int			fast_io_fail_tmo;
 };
 
-- 
2.53.0


