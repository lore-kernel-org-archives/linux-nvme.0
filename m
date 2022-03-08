Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66986C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 15:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ki2JRLq6Y0BblayzaqRKT+xGxHnj2bWwWKlnB/n2CFk=; b=Y+k3dFUh+GDCm4mY6zB6svISfD
	rho+AIFnV96z9xvLwCy3zBEb/C1zhqlGhA7hZ8GshHTLOHCBeOUq+wW9AOtki2tgr3+zAyLaq1PoF
	RBpFe97AXx/pa6c2/ncygdVI5JOiyQVx3Xk1oxEUt5774wsjwC9v/LLIpMCSltTvQbj16DxcP/a3u
	FUQgJhEWXfUN80hEc+a3dtGqleWmeYVOQa3c35H99nAAXmyU60UjE0zLW1fA61swaHeQro1sGvOfR
	Rx21hssWFgSRxhRgeoMI64P/FHXt42Yi0UIlO341CBYS+FqNohf9UFKh3lANP4+Ziq5fC6VdNfxQZ
	R+ZVngCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRbZb-004vDn-VK; Tue, 08 Mar 2022 15:16:28 +0000
Received: from smtprz14.163.net ([106.3.154.247] helo=smtp.tom.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRbZX-004vCY-Ht
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 15:16:26 +0000
Received: from my-app01.tom.com (my-app01.tom.com [127.0.0.1])
 by freemail01.tom.com (Postfix) with ESMTP id E4AB91E8C3DB
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 23:16:19 +0800 (CST)
Received: from my-app01.tom.com (HELO smtp.tom.com) ([127.0.0.1])
 by my-app01 (TOM SMTP Server) with SMTP ID 1533693902
 for <linux-nvme@lists.infradead.org>;
 Tue, 08 Mar 2022 23:16:19 +0800 (CST)
Received: from antispam3.tom.com (unknown [172.25.16.54])
 by freemail01.tom.com (Postfix) with ESMTP id D999C1E8C3CB
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 23:16:19 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tom.com; s=201807;
 t=1646752579; bh=FTUyeqP9ND6tbc1AQbw9ynrNsmhXbcmZue+wn4NbGCw=;
 h=From:To:Cc:Subject:Date:From;
 b=s6w3JHQjfwKLx1+zAQ2RHdEXToeKDrLYoz1tbP3TPJpYJxdtxy4WPQSKItr0xYyKS
 9iA6JGEVaMbm4DpKPE1LVUPzSQNjBP+kcawQdBQP8ODZx0AysmrW10wQ50FUNHFa0N
 qqFmMOsTIJC0bC5pSUx8+izCIMbEIEFLfCIGWJYk=
Received: from antispam3.tom.com (antispam3.tom.com [127.0.0.1])
 by antispam3.tom.com (Postfix) with ESMTP id B7CEC9C1C2E
 for <linux-nvme@lists.infradead.org>; Tue,  8 Mar 2022 23:16:16 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at antispam3.tom.com
Received: from antispam3.tom.com ([127.0.0.1])
 by antispam3.tom.com (antispam3.tom.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2VZx81FkYekc for <linux-nvme@lists.infradead.org>;
 Tue,  8 Mar 2022 23:16:15 +0800 (CST)
Received: from localhost.localdomain (unknown [101.93.196.13])
 by antispam3.tom.com (Postfix) with ESMTPA id 6B3BC9C1BBF;
 Tue,  8 Mar 2022 23:16:12 +0800 (CST)
From: Mingbao Sun <sunmingbao@tom.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: sunmingbao@tom.com, tyler.sun@dell.com, ping.gan@dell.com,
 yanxiu.cai@dell.com, libin.zhang@dell.com, ao.sun@dell.com
Subject: [PATCH v2 2/2] nvme-tcp: support specifying the congestion-control
Date: Tue,  8 Mar 2022 23:16:06 +0800
Message-Id: <20220308151606.2563-1-sunmingbao@tom.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_071624_311284_95716DCE 
X-CRM114-Status: GOOD (  19.63  )
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

From: Mingbao Sun <tyler.sun@dell.com>

congestion-control could have a noticeable impaction on the
performance of TCP-based communications. This is of course true
to NVMe_over_TCP.

Different congestion-controls (e.g., cubic, dctcp) are suitable for
different scenarios. Proper adoption of congestion control would benefit
the performance. On the contrary, the performance could be destroyed.

Though we can specify the congestion-control of NVMe_over_TCP via
writing '/proc/sys/net/ipv4/tcp_congestion_control', but this also
changes the congestion-control of all the future TCP sockets that
have not been explicitly assigned the congestion-control, thus bringing
potential impaction on their performance.

So it makes sense to make NVMe_over_TCP support specifying the
congestion-control. And this commit addresses the host side.

Implementation approach:
a new option called 'tcp_congestion' was created in fabrics opt_tokens
for 'nvme connect' command to passed in the congestion-control
specified by the user.
Then later in nvme_tcp_alloc_queue, the specified congestion-control
would be applied to the relevant sockets of the host side.

Signed-off-by: Mingbao Sun <tyler.sun@dell.com>
---
 drivers/nvme/host/fabrics.c | 12 ++++++++++++
 drivers/nvme/host/fabrics.h |  2 ++
 drivers/nvme/host/tcp.c     | 20 +++++++++++++++++++-
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index ee79a6d639b4..79d5f0dbafd3 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -548,6 +548,7 @@ static const match_table_t opt_tokens = {
 	{ NVMF_OPT_TOS,			"tos=%d"		},
 	{ NVMF_OPT_FAIL_FAST_TMO,	"fast_io_fail_tmo=%d"	},
 	{ NVMF_OPT_DISCOVERY,		"discovery"		},
+	{ NVMF_OPT_TCP_CONGESTION,	"tcp_congestion=%s"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -829,6 +830,16 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		case NVMF_OPT_DISCOVERY:
 			opts->discovery_nqn = true;
 			break;
+		case NVMF_OPT_TCP_CONGESTION:
+			p = match_strdup(args);
+			if (!p) {
+				ret = -ENOMEM;
+				goto out;
+			}
+
+			kfree(opts->tcp_congestion);
+			opts->tcp_congestion = p;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -947,6 +958,7 @@ void nvmf_free_options(struct nvmf_ctrl_options *opts)
 	kfree(opts->subsysnqn);
 	kfree(opts->host_traddr);
 	kfree(opts->host_iface);
+	kfree(opts->tcp_congestion);
 	kfree(opts);
 }
 EXPORT_SYMBOL_GPL(nvmf_free_options);
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index c3203ff1c654..25fdc169949d 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -68,6 +68,7 @@ enum {
 	NVMF_OPT_FAIL_FAST_TMO	= 1 << 20,
 	NVMF_OPT_HOST_IFACE	= 1 << 21,
 	NVMF_OPT_DISCOVERY	= 1 << 22,
+	NVMF_OPT_TCP_CONGESTION	= 1 << 23,
 };
 
 /**
@@ -117,6 +118,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_io_queues;
 	unsigned int		reconnect_delay;
 	bool			discovery_nqn;
+	const char		*tcp_congestion;
 	bool			duplicate_connect;
 	unsigned int		kato;
 	struct nvmf_host	*host;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index babbc14a4b76..3415e178a78b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1403,6 +1403,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
+	char ca_name[TCP_CA_NAME_MAX];
+	sockptr_t optval;
 	int ret, rcv_pdu_size;
 
 	mutex_init(&queue->queue_lock);
@@ -1447,6 +1449,21 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	if (nctrl->opts->tos >= 0)
 		ip_sock_set_tos(queue->sock->sk, nctrl->opts->tos);
 
+	if (nctrl->opts->mask & NVMF_OPT_TCP_CONGESTION) {
+		strncpy(ca_name, nctrl->opts->tcp_congestion,
+			TCP_CA_NAME_MAX-1);
+		optval = KERNEL_SOCKPTR(ca_name);
+		ret = sock_common_setsockopt(queue->sock, IPPROTO_TCP,
+					     TCP_CONGESTION, optval,
+					     strlen(ca_name));
+		if (ret) {
+			dev_err(nctrl->device,
+				"failed to set TCP congestion to %s: %d\n",
+				ca_name, ret);
+			goto err_sock;
+		}
+	}
+
 	/* Set 10 seconds timeout for icresp recvmsg */
 	queue->sock->sk->sk_rcvtimeo = 10 * HZ;
 
@@ -2610,7 +2627,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
 			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
-			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
+			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE |
+			  NVMF_OPT_TCP_CONGESTION,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
-- 
2.26.2


