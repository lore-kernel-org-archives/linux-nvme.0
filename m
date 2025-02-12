Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F2BCC02198
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2025 11:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=so+pb8BV3WMI5FpAhsPXMR4HFaWb1jDyFTOmxks/qhM=; b=p9WPuOxeUJ1GV42KTspj+4JHjL
	7BInCuCfdNjLVFs2C6L3FDjEXs/KMo2yz+0kkLQE1H9TqsYPg9NY6x68+l4RQTDh7TbdmO8qGF5dn
	Fbx7yJCMQJMXOb1zj5fIz+s+toPGljK5Mzs5+LeA6ihZLFOMxVXkxkgfGOjDhapT5qCBgPZtwjGYt
	kP2dh0d7hkBMnBogtlRgNYqVAuNafEeIZ6Oy9wD5+F9B52OD5guLSMxKquAsg1QdP/NDnLen3KE+h
	5GtfUi9cCIcyR0qB5GZPCswOFEk7MqY2kuVclQ8GPCwmJOEZ8G+nQw57vCz4lmJsmKkysiVLEqhBO
	QaCXS/xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tiAhK-000000078GU-2aRX;
	Wed, 12 Feb 2025 11:14:30 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=bsdbackstore.eu)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tiAhG-000000078EJ-2nDK
	for linux-nvme@lists.infradead.org;
	Wed, 12 Feb 2025 11:14:29 +0000
Received: from localhost (25.205.forpsi.net [80.211.205.25])
	by bsdbackstore.eu (OpenSMTPD) with ESMTPSA id cabaeebe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Feb 2025 12:14:22 +0100 (CET)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 12 Feb 2025 12:14:20 +0100
Message-Id: <D7QF99BR5YYA.2CXBBA5RYACTY@bsdbackstore.eu>
Cc: "mgurtovoy" <mgurtovoy@nvidia.com>, "sagi" <sagi@grimberg.me>, "kbusch"
 <kbusch@kernel.org>, "sashal" <sashal@kernel.org>, "linux-kernel"
 <linux-kernel@vger.kernel.org>, "linux-nvme"
 <linux-nvme@lists.infradead.org>, "linux-block"
 <linux-block@vger.kernel.org>
Subject: Re: nvme-tcp: fix a possible UAF when failing to send request
From: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>
To: "Maurizio Lombardi" <mlombard@bsdbackstore.eu>,
 "zhang.guanghui@cestc.cn" <zhang.guanghui@cestc.cn>, "chunguang.xu"
 <chunguang.xu@shopee.com>
X-Mailer: aerc
References: <2025021015413817916143@cestc.cn>
 <D7OOGIOAJRUH.9LOJ3X4IUKQV@bsdbackstore.eu>
 <3f1f7ec3-cb49-4d66-b2b0-57276a6c62f0@nvidia.com>
 <D7OWXONOUZ1Y.19KIRCQDVRTKN@bsdbackstore.eu>
 <CAAO4dAWdsMjYMp9jdWXd_48aG0mTtVpRONqjJJ1scnc773tHzg@mail.gmail.com>
 <202502111604342976121@cestc.cn>
 <D7QBDBZMZTCI.1W40WVL5JJ3O7@bsdbackstore.eu>
 <D7QC8AQ7J89A.32TNPSFWV1VNX@bsdbackstore.eu>
 <202502121747455267343@cestc.cn>
 <D7QEA7XPBML4.1R0M64OD4BH43@bsdbackstore.eu>
In-Reply-To: <D7QEA7XPBML4.1R0M64OD4BH43@bsdbackstore.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250212_031427_040151_6C9193E4 
X-CRM114-Status: GOOD (  12.73  )
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

On Wed Feb 12, 2025 at 11:28 AM CET, Maurizio Lombardi wrote:
> On Wed Feb 12, 2025 at 10:47 AM CET, zhang.guanghui@cestc.cn wrote:
>> =C2=A0=C2=A0=C2=A0=C2=A0Hi, Thanks.
>> =C2=A0=C2=A0=C2=A0=C2=A0I will test this patch, but I am worried whether=
 it will affect the performance.
>> Should we also consider null pointer protection?
>
> Yes, it will likely affect the performance, just check if it works.
>
> Probably it could be optimized by just protecting
> nvme_tcp_fail_request(), which AFAICT is the only function in the
> nvme_tcp_try_send() code that calls nvme_complete_rq().

Something like that, maybe, not tested:

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 841238f38fdd..488edec35a65 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -146,6 +146,7 @@ struct nvme_tcp_queue {
=20
 	struct mutex		queue_lock;
 	struct mutex		send_mutex;
+	struct mutex		poll_mutex;
 	struct llist_head	req_list;
 	struct list_head	send_list;
=20
@@ -1259,7 +1260,9 @@ static int nvme_tcp_try_send(struct nvme_tcp_queue *q=
ueue)
 	} else if (ret < 0) {
 		dev_err(queue->ctrl->ctrl.device,
 			"failed to send request %d\n", ret);
+		mutex_lock(&queue->poll_mutex);
 		nvme_tcp_fail_request(queue->request);
+		mutex_unlock(&queue->poll_mutex);
 		nvme_tcp_done_send_req(queue);
 	}
 out:
@@ -1397,6 +1400,7 @@ static void nvme_tcp_free_queue(struct nvme_ctrl *nct=
rl, int qid)
 	kfree(queue->pdu);
 	mutex_destroy(&queue->send_mutex);
 	mutex_destroy(&queue->queue_lock);
+	mutex_destroy(&queue->poll_mutex);
 }
=20
 static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
@@ -1710,6 +1714,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nct=
rl, int qid,
 	init_llist_head(&queue->req_list);
 	INIT_LIST_HEAD(&queue->send_list);
 	mutex_init(&queue->send_mutex);
+	mutex_init(&queue->poll_mutex);
 	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
=20
 	if (qid > 0)
@@ -2660,7 +2665,9 @@ static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, =
struct io_comp_batch *iob)
 	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queu=
e))
 		sk_busy_loop(sk, true);
+	mutex_lock(&queue->poll_mutex);
 	nvme_tcp_try_recv(queue);
+	mutex_unlock(&queue->poll_mutex);
 	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
 	return queue->nr_cqe;
 }

