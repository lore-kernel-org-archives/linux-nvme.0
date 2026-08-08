Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 495B8C55174
	for <linux-nvme@archiver.kernel.org>; Sat,  8 Aug 2026 06:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yul4QY+Tdr6oGd1fEwZXgGg1iq9NHlfdi5APnyMx7cc=; b=HE2CRyaUGvn3iTWtVTB6fkhM2U
	MTdVISAOtezagIxmcj6HDTAWzKahHdtFAJSYPhOcjBk4BegggJVAQoTsYvxUCCLzMEYN3eLUCJQke
	A4u9wkVOCuLMU3ejfy4QccGeFzcuBJ05KCK68efSxs22AfaAGwob5vffcMlk/J+06Ivus8zHcMi1R
	7YYM8pU8bjrckAXe1Ui/WOOS5HK3z2fLYNBa5V3laM7fngV/iHhC6wcP7W1PGhZmgffrtNvILUeAh
	a5PgTZ8VB3aNQqEUB1uM2nBye115AuB8jB5Lio1LDIGo2qB6u3HN3iom2SEz4Ql8WK3FPSLOTIVB+
	B8F0hUTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsayf-00000009707-3W16;
	Sat, 08 Aug 2026 06:56:17 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wsayd-000000096zj-2yxo
	for linux-nvme@lists.infradead.org;
	Sat, 08 Aug 2026 06:56:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id BAB7C61878;
	Sat,  8 Aug 2026 06:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A2571F000E9;
	Sat,  8 Aug 2026 06:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786172173;
	bh=Yul4QY+Tdr6oGd1fEwZXgGg1iq9NHlfdi5APnyMx7cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hdzpqnUIA/C/M8bsYHrsDeHIsH/rh7hNEomSXsr1M38DcuONF4A2LErtIDNEim9pj
	 rYkahJjlw8wxxplm+Pyy/W10LQ5a4QvbHx98YNlgOS1dOWsXcBSBY6PgfSbbasrBn1
	 UVYpNVmNT26KXEEBBMBTtDoT2AjCa5CuyLHTo/uh9ooq70LYeeLk7px7lrbgPBcPzB
	 FHcxvt2AjvLpahVtdtcvX/hVLNLHNlw8FRjOojrVIxhkfkqvjOedV2fqafqSEBdISK
	 vdmXwCj54/R3Fk3MzvbetM0j0DOpF8RkOzbPClbdOmuGsXYx3qv0p9mbhnPQO7f2M0
	 +RCI0VXF2K8wQ==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev
Subject: [PATCH v2 2/3] nvme-tcp: support IPv6 traffic class
Date: Sat,  8 Aug 2026 14:55:00 +0800
Message-ID: <3f5e4c84d3fe41601b29468fa4128d4639d56685.1786171863.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1786171863.git.tanggeliang@kylinos.cn>
References: <cover.1786171863.git.tanggeliang@kylinos.cn>
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

The NVMe/TCP transport needs to configure the IPv6 traffic class on its
queue sockets, but the fabrics option parser currently has no corresponding
option.

Add the tclass option to the fabrics parser and store the validated value
in struct nvmf_ctrl_options. Negative values are rejected, while values
greater than 255 are clamped to 255, matching the valid range of the IPv6
traffic class field.

Keep -1 as the default value to let the transport use its default traffic
class.

The fabrics layer now supports parsing the tclass option, but the NVMe/TCP
transport does not currently advertise or apply it.

Allow NVMe/TCP to use NVMF_OPT_TCLASS and set IPV6_TCLASS on each queue
socket via ip6_sock_set_tclass() when a traffic class is specified, keeping
the existing IPv4 TOS handling unchanged.

Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/fabrics.c | 18 ++++++++++++++++++
 drivers/nvme/host/fabrics.h |  3 +++
 drivers/nvme/host/tcp.c     |  8 +++++++-
 3 files changed, 28 insertions(+), 1 deletion(-)

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
 
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..cabbf67d24f8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1837,6 +1837,11 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	/* Set socket type of service */
 	if (nctrl->opts->tos >= 0)
 		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
+#if IS_ENABLED(CONFIG_IPV6)
+	if (nctrl->opts->tclass >= 0 &&
+	    queue->sock->sk->sk_family == AF_INET6)
+		ip6_sock_set_tclass(queue->sock->sk, nctrl->opts->tclass);
+#endif
 
 	/* Set 10 seconds timeout for icresp recvmsg */
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
@@ -3041,7 +3046,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
+			  NVMF_OPT_TOS | NVMF_OPT_TCLASS |
+			  NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
 			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
-- 
2.53.0


