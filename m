Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CD2CC6B1A
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Oct 2026 06:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JTJK3K2HtRoklixNqbatLqReJpESRo1O6orCv2sRVKY=; b=iypgGcii14tgYij4zN5md85xN5
	VUBuMDcoWp3j3s48yMNC5r9cALQH0oxomVQcAC10DgUbOj4K9XChA7LGVt/eF9oBkypKIHUISGVFQ
	3uweHKK9I4FKjCPYMYLEaIlW6gFgiQg0FtccbdYAZrC95387IlloCOIUWXsnme9BlFe+yqSJ716Si
	x28gtkxswn5p+Azd4U/sg0WJ3TvK9HCLPnbl6X7BNUMSlmGJB5N4Jvu09Bjzj6oMh2nOFAS4EWMcr
	I+EbJGHwBHoeAqKwzK9EoXR+pht0MRxHHtIX/xVmMflTP8k/ZSry0eL1sYcaFnHtkBAO3xY+m8X1N
	jN1G6Beg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGskm-0000000EeLw-21bi;
	Wed, 14 Oct 2026 06:46:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGskk-0000000EeLU-1uTJ
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 Oct 2026 06:46:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=content-type:Content-Transfer-Encoding
	:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=JTJK3K2HtRoklixNqbatLqReJpESRo1O6orCv2sRVKY=; b=SCU7sFTDRnXJYcilX6BkVhgFFD
	FebYPV7OymB13Rb7J3nGlfCfvYQbWCw+OImwTe2idtnvq1z6sTXyzFnS3qfjWC1FEWSKTCBcIvQX3
	7UsnWO6PlmLdBn9nmX+xqQ09KZ7n1a9xfNpEb9lOUJOGVyzlK1om3Af1pp9nr6PC4KhtOe7A8LHtj
	26cPs0+oVMvuFKnFQRIO0tl7oFs2stW1ufuUlPF18FRJCkQZ8x1Kwby854HgVlx5tJzdShh8BNY6H
	/TZo9N1iytSeDnZBMi2HwzXSVfXY6RmvS1EMCwrZJ4ukRzhlA6X2RiQbkVoP7JGChrf3OVHVN3AiD
	F0IlBc7Q==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGskg-0000000GPf1-2Wcd
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 06:46:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791960366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JTJK3K2HtRoklixNqbatLqReJpESRo1O6orCv2sRVKY=;
	b=E6zRys/rUMJc9kuPfnc5SO6qpTDaozerAZUFquvvkOWM7GwEfPTaQlXHFH+a5VzV1n87sb
	eBIRcZAaBJ1fN9Ppf0avaVw0go6gnQPxPiQLRRK/8bmz+7PyhGLH6K3VMQdpnZK3pQazkS
	ycm9s4VMpkwhxjziZtTDYS1rYBQkfrI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791960371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JTJK3K2HtRoklixNqbatLqReJpESRo1O6orCv2sRVKY=;
	b=Kp4U5LQFK8/H8GZAETxlFKmxu0Jmv1QgHy0Lu9LnBQ3T58PivYwc0nsMCdCsRNTSqQ5+IN
	YlY5VlPo7paNQzLKHtL7l0mSYOOvyFbAMXEpCEcplF0r+APFn/Gh+s4DAzoPQnj9RIcbAK
	qsxsT1iKFnj8oXtmftCdSq9x9BPPq0E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791960366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JTJK3K2HtRoklixNqbatLqReJpESRo1O6orCv2sRVKY=;
	b=E6zRys/rUMJc9kuPfnc5SO6qpTDaozerAZUFquvvkOWM7GwEfPTaQlXHFH+a5VzV1n87sb
	eBIRcZAaBJ1fN9Ppf0avaVw0go6gnQPxPiQLRRK/8bmz+7PyhGLH6K3VMQdpnZK3pQazkS
	ycm9s4VMpkwhxjziZtTDYS1rYBQkfrI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-MxfC6BBbP0ycHaM8okxLuA-1; Wed,
 14 Oct 2026 06:45:58 +0000
X-MC-Unique: MxfC6BBbP0ycHaM8okxLuA-1
X-Mimecast-MFC-AGG-ID: MxfC6BBbP0ycHaM8okxLuA_1791960356
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 07728180034E;
	Wed, 14 Oct 2026 06:45:55 +0000 (UTC)
Received: from snishika-thinkpadp16vgen1.tokyo.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DC69C1800345;
	Wed, 14 Oct 2026 06:45:50 +0000 (UTC)
From: Seiji Nishikawa <snishika@redhat.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Hannes Reinecke <hare@kernel.org>,
	Chris Leech <cleech@redhat.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Seiji Nishikawa <snishika@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-tcp: fix io_work priority inversion when send_mutex is held
Date: Wed, 14 Oct 2026 15:45:24 +0900
Message-ID: <20261014064524.4015025-1-snishika@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-MFC-PROC-ID: 7DQmnNWcWzYKey20CizvICxvvoLVtDbMDhQC7Vv7ZO0_1791960356
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_074615_207386_61EBC69A 
X-CRM114-Status: GOOD (  26.46  )
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

Commit f42d4796ee10 ("nvme-tcp: fix I/O stalls on congested sockets")
added a check in nvme_tcp_io_work() that sets pending to true when the
queue has pending requests and the socket is writeable. The check is
placed after the mutex_trylock() block, so it also runs when
mutex_trylock(&queue->send_mutex) failed and io_work did not send
anything.

When .queue_rq sends a request directly from its own context, it holds
send_mutex and can give up the CPU in lock_sock_nested() when another
task needs the CPU, for example the io_work kworker of the same queue,
which runs on the same CPU. Then io_work cannot take send_mutex, but
the requests are still on req_list and the socket is writeable, so
pending is set to true. io_work loops until the deadline and queues
itself again on io_cpu, without sleeping.

This is a priority inversion. io_work runs on the high priority
nvme_tcp_wq and cannot make progress until send_mutex is released, but
it keeps running. The task holding send_mutex runs at normal priority
and needs the CPU to release it. The scheduler keeps giving the CPU to
io_work, so the task holding send_mutex may not run again, and the
requests on the queue are not sent and time out.

This is the same problem that commit 70f437fb4395 ("nvme-tcp: fix
io_work priority inversion") fixed. That commit removed
"pending = !llist_empty(&queue->req_list)" from the path where
mutex_trylock() fails, and let the task holding send_mutex queue
io_work again in nvme_tcp_queue_request() after it releases the mutex.
The new check brings back the same behavior in a different form.

Two things make this easier to hit. nvme_tcp_queue_request() sends
directly only when it runs on io_cpu, so the task that takes send_mutex
is on the same CPU as the io_work kworker of that queue when it takes
the mutex. Also, when the tasks are in a cgroup with the cpu controller
enabled, the whole group competes with the nice -20 kworker as one
entity, so each task in the group gets even less CPU time.

We hit this on a 6 CPU VM running a database on nvme-tcp storage. In
the vmcore, 2 tasks held send_mutex of 2 queues and were runnable in
lock_sock_nested() for 103 seconds, while the kworkers for those queues
kept running io_work on their CPUs. All database tasks were in one
cgroup, which got only about 0.3% of the CPU against the nice -20
kworker. Requests timed out, and blk_mq_timeout_work() waited in
synchronize_srcu() for the tasks still in .queue_rq.

Only do the pending check if io_work could take send_mutex. If it could
not, the task holding send_mutex sends what it can in
nvme_tcp_send_all(), and queues io_work again after it releases the
mutex if requests are still pending, so no request is left behind.

Fixes: f42d4796ee10 ("nvme-tcp: fix I/O stalls on congested sockets")
Cc: stable@vger.kernel.org # v6.16+
Signed-off-by: Seiji Nishikawa <snishika@redhat.com>
---
 drivers/nvme/host/tcp.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7eec983c0ead..4b775e22d3cc 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1433,9 +1433,11 @@ static void nvme_tcp_io_work(struct work_struct *w)
 
 	do {
 		bool pending = false;
+		bool got_send_mutex = false;
 		int result;
 
 		if (mutex_trylock(&queue->send_mutex)) {
+			got_send_mutex = true;
 			result = nvme_tcp_try_send(queue);
 			mutex_unlock(&queue->send_mutex);
 			if (result > 0)
@@ -1450,8 +1452,13 @@ static void nvme_tcp_io_work(struct work_struct *w)
 		else if (unlikely(result < 0))
 			return;
 
-		/* did we get some space after spending time in recv? */
-		if (nvme_tcp_queue_has_pending(queue) &&
+		/*
+		 * did we get some space after spending time in recv?
+		 * Only check this if we could take send_mutex. Otherwise
+		 * the task holding it sends the requests and queues io_work
+		 * again after it releases the mutex.
+		 */
+		if (got_send_mutex && nvme_tcp_queue_has_pending(queue) &&
 		    sk_stream_is_writeable(queue->sock->sk))
 			pending = true;
 

base-commit: 5755f1bd0217ffe3c5cf85467bf6b0680f398265
-- 
2.55.0


