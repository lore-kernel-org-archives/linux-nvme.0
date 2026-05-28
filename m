Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C21CD5BC9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 May 2026 03:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RbKJjq4aWwXODLoBQ2EcVIURob7IqQdQHIVigwRe+nk=; b=i4p6k7Ys3Y7ON0VCT/pTXvgCd9
	t1IqsbNWVGodDORCP9qpWIDZNib2zgUJIogZjAW7mECLXSG8VUV4SvgbLq6PWFpXv1Z6sa5x02rx1
	8c85086EmGDg5gwhwp4sndOh00qb+sRRM0ge5ld3z8STx8BWB1n6gTyKr9FPwNClHSPVQhbkNjqy5
	w0gHAcCZfqyRgPlgkEKU1Dc75cDMdzXJ8SHw5BvT0gJtiae29eLoF6Nqtbi0yT0Ijp9Np0H2dHFce
	QSWodLX1FBKbifI+80tUEk/9zStV8zraIFtZAm7D8Zely+29N1Uh+JEZuVppB/nSx6o6/1BgGterz
	RMyhr1dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSRAf-000000052dj-3Xqv;
	Thu, 28 May 2026 03:12:33 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSRAd-000000052c3-2nFX
	for linux-nvme@lists.infradead.org;
	Thu, 28 May 2026 03:12:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4131B41953;
	Thu, 28 May 2026 03:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D901F000E9;
	Thu, 28 May 2026 03:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779937951;
	bh=RbKJjq4aWwXODLoBQ2EcVIURob7IqQdQHIVigwRe+nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QP8YeAS4fIwzo80dRBc7g3PJYRxnS5eKJbwINn6CQSXFAZl/5RqdfdPOTYwXctYwj
	 va1dX+U58+6w3T7n0Cl3gTZ2y4xGTkW7bBymsckqqVEI/6L/0T6t5h7YfgJM93eoXq
	 KsPAl4wEQqfG7DbsMz+OBAxap59fSJ1mV6XrL4RPWCV9b7kO/lA4geMqCyUsQIQGiF
	 xSwqBo4cxIG5jox+AXaj9QD5js0iphUQ6KQYoO3D15Go+Tyl/ZefWsWmEx7uFCl0XG
	 j5kq/Cex8AuIGfL810sEkZ6SbAfAIvdLB1Vy1nrCKNI5Co/aSl4RZ2Z7DbQq2uGAqG
	 GOV1KW8gGB/Fg==
From: Geliang Tang <geliang@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Geliang Tang <tanggeliang@kylinos.cn>,
	linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	zhenwei pi <zhenwei.pi@linux.dev>,
	Hui Zhu <zhuhui@kylinos.cn>,
	Gang Yan <yangang@kylinos.cn>
Subject: [PATCH 09/11] nvme-tcp: implement host mptcp proto
Date: Thu, 28 May 2026 11:10:43 +0800
Message-ID: <a3ceb2b974d74b78d205731353f5e3bbeff2acf4.1779934709.git.tanggeliang@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1779934709.git.tanggeliang@kylinos.cn>
References: <cover.1779934709.git.tanggeliang@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260527_201231_745692_130A138E 
X-CRM114-Status: GOOD (  18.42  )
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

An MPTCP-specific version of struct nvme_tcp_proto is implemented,
and it is assigned to ctrl->proto when the transport string is "mptcp".

The socket option setting logic is similar to the target side, except that
mptcp_sock_set_syncnt is newly defined for the host side.

These helpers set the values on all existing subflows of an MPTCP
connection, except for set_reuseaddr which only applies to the first
subflow. The values are then synchronized to other newly created
subflows in sync_socket_options().

A separate nvme_mptcp_ctrl_ops structure with .name = "mptcp" is defined
and used for MPTCP controllers.

"mptcp" is planned to be introduced as a new NVMe transport type into the
NVMe Base Specification in the future.

Currently, the Discovery Log does not yet recognize trtype=4 (MPTCP), and
will show "trtype: unrecognized" for such entries:

 =====Discovery Log Entry 0======
 trtype:  unrecognized
 adrfam:  ipv4
 subtype: current discovery subsystem
 treq:    not specified, sq flow control disable supported
 portid:  23106
 trsvcid: 23601
 subnqn:  nqn.2014-08.org.nvmexpress.discovery
 traddr:  10.1.1.1
 eflags:  none

Cc: Hannes Reinecke <hare@suse.de>
Cc: John Meneghini <jmeneghi@redhat.com>
Cc: Randy Jennings <randyj@purestorage.com>
Cc: Nilay Shroff <nilay@linux.ibm.com>
Co-developed-by: zhenwei pi <zhenwei.pi@linux.dev>
Signed-off-by: zhenwei pi <zhenwei.pi@linux.dev>
Co-developed-by: Hui Zhu <zhuhui@kylinos.cn>
Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
Co-developed-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Gang Yan <yangang@kylinos.cn>
Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
---
 drivers/nvme/host/tcp.c | 34 ++++++++++++++++++++++++++++++++++
 include/net/mptcp.h     | 11 +++++++++++
 net/mptcp/sockopt.c     | 30 +++++++++++++++++++++++++++++-
 3 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 305624d59c50..2388a8c443cc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2895,6 +2895,24 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.get_virt_boundary	= nvmf_get_virt_boundary,
 };
 
+#ifdef CONFIG_MPTCP
+static const struct nvme_ctrl_ops nvme_mptcp_ctrl_ops = {
+	.name			= "mptcp",
+	.module			= THIS_MODULE,
+	.flags			= NVME_F_FABRICS | NVME_F_BLOCKING,
+	.reg_read32		= nvmf_reg_read32,
+	.reg_read64		= nvmf_reg_read64,
+	.reg_write32		= nvmf_reg_write32,
+	.subsystem_reset	= nvmf_subsystem_reset,
+	.free_ctrl		= nvme_tcp_free_ctrl,
+	.submit_async_event	= nvme_tcp_submit_async_event,
+	.delete_ctrl		= nvme_tcp_delete_ctrl,
+	.get_address		= nvme_tcp_get_address,
+	.stop_ctrl		= nvme_tcp_stop_ctrl,
+	.get_virt_boundary	= nvmf_get_virt_boundary,
+};
+#endif
+
 static bool
 nvme_tcp_existing_controller(struct nvmf_ctrl_options *opts)
 {
@@ -2923,6 +2941,18 @@ static const struct nvme_tcp_proto nvme_tcp_proto = {
 
 };
 
+#ifdef CONFIG_MPTCP
+static const struct nvme_tcp_proto nvme_mptcp_proto = {
+	.protocol	= IPPROTO_MPTCP,
+	.set_syncnt	= mptcp_sock_set_syncnt,
+	.set_nodelay	= mptcp_sock_set_nodelay,
+	.no_linger	= mptcp_sock_no_linger,
+	.set_priority	= mptcp_sock_set_priority,
+	.set_tos	= __mptcp_sock_set_tos,
+	.ops		= &nvme_mptcp_ctrl_ops,
+};
+#endif
+
 static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -2989,6 +3019,10 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 
 	if (!strcmp(ctrl->ctrl.opts->transport, "tcp")) {
 		ctrl->proto = &nvme_tcp_proto;
+#ifdef CONFIG_MPTCP
+	} else if (!strcmp(ctrl->ctrl.opts->transport, "mptcp")) {
+		ctrl->proto = &nvme_mptcp_proto;
+#endif
 	} else {
 		ret = -EINVAL;
 		goto out_free_ctrl;
diff --git a/include/net/mptcp.h b/include/net/mptcp.h
index b8ab214a7890..160267e35b13 100644
--- a/include/net/mptcp.h
+++ b/include/net/mptcp.h
@@ -238,11 +238,15 @@ void mptcp_sock_no_linger(struct sock *sk);
 
 void mptcp_sock_set_priority(struct sock *sk, u32 priority);
 
+void __mptcp_sock_set_tos(struct sock *sk, int val);
+
 void mptcp_sock_set_tos(struct sock *sk);
 
 void mptcp_sock_set_reuseaddr(struct sock *sk);
 
 void mptcp_sock_set_nodelay(struct sock *sk);
+
+int mptcp_sock_set_syncnt(struct sock *sk, int val);
 #else
 
 static inline void mptcp_init(void)
@@ -334,11 +338,18 @@ static inline void mptcp_sock_no_linger(struct sock *sk) { }
 
 static inline void mptcp_sock_set_priority(struct sock *sk, u32 priority) { }
 
+static inline void __mptcp_sock_set_tos(struct sock *sk, int val) { }
+
 static inline void mptcp_sock_set_tos(struct sock *sk) { }
 
 static inline void mptcp_sock_set_reuseaddr(struct sock *sk) { }
 
 static inline void mptcp_sock_set_nodelay(struct sock *sk) { }
+
+static inline int mptcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	return 0;
+}
 #endif /* CONFIG_MPTCP */
 
 #if IS_ENABLED(CONFIG_MPTCP_IPV6)
diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
index 0adbbe568f6e..7857dac62afc 100644
--- a/net/mptcp/sockopt.c
+++ b/net/mptcp/sockopt.c
@@ -1598,6 +1598,8 @@ static void sync_socket_options(struct mptcp_sock *msk, struct sock *ssk)
 	WRITE_ONCE(inet_sk(ssk)->local_port_range, READ_ONCE(inet_sk(sk)->local_port_range));
 
 	ssk->sk_reuse = sk->sk_reuse;
+	if (inet_csk(sk)->icsk_syn_retries > 0)
+		tcp_sock_set_syncnt(ssk, inet_csk(sk)->icsk_syn_retries);
 }
 
 void mptcp_sockopt_sync_locked(struct mptcp_sock *msk, struct sock *ssk)
@@ -1709,7 +1711,7 @@ void mptcp_sock_set_priority(struct sock *sk, u32 priority)
 }
 EXPORT_SYMBOL(mptcp_sock_set_priority);
 
-static void __mptcp_sock_set_tos(struct sock *sk, int val)
+void __mptcp_sock_set_tos(struct sock *sk, int val)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 	struct mptcp_subflow_context *subflow;
@@ -1728,6 +1730,7 @@ static void __mptcp_sock_set_tos(struct sock *sk, int val)
 	}
 	release_sock(sk);
 }
+EXPORT_SYMBOL(__mptcp_sock_set_tos);
 
 void mptcp_sock_set_tos(struct sock *sk)
 {
@@ -1783,3 +1786,28 @@ void mptcp_sock_set_nodelay(struct sock *sk)
 	release_sock(sk);
 }
 EXPORT_SYMBOL(mptcp_sock_set_nodelay);
+
+int mptcp_sock_set_syncnt(struct sock *sk, int val)
+{
+	struct mptcp_sock *msk = mptcp_sk(sk);
+	struct mptcp_subflow_context *subflow;
+	struct sock *ssk;
+
+	if (val < 1 || val > MAX_TCP_SYNCNT)
+		return -EINVAL;
+
+	lock_sock(sk);
+	sockopt_seq_inc(msk);
+	inet_csk(sk)->icsk_syn_retries = val;
+	mptcp_for_each_subflow(msk, subflow) {
+		ssk = mptcp_subflow_tcp_sock(subflow);
+		if (ssk) {
+			lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+			tcp_sock_set_syncnt(ssk, val);
+			release_sock(ssk);
+		}
+	}
+	release_sock(sk);
+	return 0;
+}
+EXPORT_SYMBOL(mptcp_sock_set_syncnt);
-- 
2.53.0


