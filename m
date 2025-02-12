Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81105C02198
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2025 08:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bBfkCANPkyVStLwoDYC8WOlPFhA37zMJE58aoljZ044=; b=mbla/5oe34ebmmrWivgWwFOurL
	hS4IdtOSnJ3E+cV0HL16NuWtl83S4+WmsRQLIgC8K4PV2GNDHc9j0pkLwqc7A9joV31ZVkRvOACO+
	Aso+ZMF0LqqOD4EruA4h9suzucKACIFc9KJuNX1tPfdbedBuPkd+m+JyNpMbQfbyp8I2qsFN2hYZj
	dZc9MFw/EyNIEXrjBlm4OL1qkUDSVJSN6GgX3SevZJxoEYSoy1N6sN4m8XTYkpfGR9HsTnv4i+ORD
	Rxib0fAmIjdTkXe7hK5J9KHx8F1ARgW9LD63emy788QPn+liVdRNzFl+tJGHtkLIY4jv6TYPdfkkX
	sourywSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ti7rM-00000006ZzB-0Ove;
	Wed, 12 Feb 2025 08:12:40 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ti7qQ-00000006ZfT-0P4q
	for linux-nvme@lists.infradead.org;
	Wed, 12 Feb 2025 08:11:43 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id 8dfb9e77 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 09:11:37 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 09:11:34 +0100
Message-Id: <D7QBDBZMZTCI.1W40WVL5JJ3O7@bsdbackstore.eu>
Cc: "mgurtovoy" <mgurtovoy@nvidia.com>, "sagi" <sagi@grimberg.me>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "chunguang.xu"
 <chunguang.xu@shopee.com>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>
 <3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>
 <D7OWXONOUZ1Y.19KIRCQDVRTKN@bsdbackstore.eu>
 <CAAO4dAWdsMjYMp9jdWXd_48aG0mTtVpRONqjJJ1scnc773tHzg@mail.gmail.com>
 <202502111604342976121@cestc.cn>
In-Reply-To: <202502111604342976121@cestc.cn>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_001142_516590_AF102CCD 
X-CRM114-Status: UNSURE (   7.94  )
X-CRM114-Notice: Please train this message.
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

On Tue Feb 11, 2025 at 9:04 AM CET, zhang.guanghui@cestc.cn wrote:
> Hi=C2=A0
>
> =C2=A0 =C2=A0 This is a=C2=A0 race issue,=C2=A0=C2=A0I can't reproduce it=
 stably yet. I have not tested the latest kernel.=C2=A0 but in fact,=C2=A0=
=C2=A0I've synced some nvme-tcp patches from=C2=A0 lastest upstream,

Hello, could you try this patch?

queue_lock should protect against concurrent "error recovery",
while send_mutex should serialize try_recv() and try_send(), emulating
the way io_work works.
Concurrent calls to try_recv() should already be protected by
sock_lock.

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 841238f38fdd..f464de04ff4d 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2653,16 +2653,24 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx=
, struct io_comp_batch *iob)
 {
 	struct nvme_tcp_queue *queue =3D hctx->driver_data;
 	struct sock *sk =3D queue->sock->sk;
+	int r =3D 0;
=20
+	mutex_lock(&queue->queue_lock);
 	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
-		return 0;
+		goto out;
=20
 	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queu=
e))
 		sk_busy_loop(sk, true);
+
+	mutex_lock(&queue->send_mutex);
 	nvme_tcp_try_recv(queue);
+	r =3D queue->nr_cqe;
+	mutex_unlock(&queue->send_mutex);
 	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
-	return queue->nr_cqe;
+out:
+	mutex_unlock(&queue->queue_lock);
+	return r;
 }
=20
 static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int siz=
e)


Thanks,
Maurizio

