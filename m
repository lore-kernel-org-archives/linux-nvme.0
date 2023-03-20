Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38235C6FD1C
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Mar 2023 22:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fqeEVi+jHLnk0TzvAeLNOtfeI6Q3pPYXDYUJcCAQCFg=; b=hKz3YLmuyFRtwakvz+QDQ8BC01
	zwynpP9eyTEomg05YrGbFR0DkS5Mfxftk6MCisXN0cjLCxn5EiI1IKoPbur6rvpxDdz45PEsQj8WU
	u15BKfPpayfSj7pugKMcTIq0jrhZSZUy2Dblo405X1IRZFZqiXRrIyPDJD3bo9cHU6kjQifNWrmOe
	jB38p7xQIfSPIIWDyfTAZF8VRi5XjQooFL350nEi21sb1LiX7taahtnncGZ24Q5448Mh0wkQgLTIO
	l6dCdP32v7G6N+c04uijiKmnxQT0Wnn8Z1CkpqS5MQa7QTo+jUB363wscFH2ASjQp+tWQaGBZWyQr
	pKLP6Oew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peNji-00AbSy-1P;
	Mon, 20 Mar 2023 22:12:14 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peNjd-00AbRq-0d
	for linux-nvme@lists.infradead.org;
	Mon, 20 Mar 2023 22:12:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1679350326;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fqeEVi+jHLnk0TzvAeLNOtfeI6Q3pPYXDYUJcCAQCFg=;
	b=OhiBy+HHDnwTS1Smu+ctC0Y24qesUENpU18J2BVvuVRAwPMJ27IOi5tjSln2GZqoaYagwn
	RCXxZY3EFlfzjLkT7DgZHnit04+U8+Ws0F/8B8bO19Rw5plR7veGjRuO+rmRj1UKqIp1Z9
	VofZXFVt6qghdpWsYvQz/UpnbugCacA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-466-wg6aHwQDNEyAFvFlhvM5AA-1; Mon, 20 Mar 2023 18:10:23 -0400
X-MC-Unique: wg6aHwQDNEyAFvFlhvM5AA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 377293C0253E;
	Mon, 20 Mar 2023 22:10:23 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.2.17.204])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C41472166B29;
	Mon, 20 Mar 2023 22:10:22 +0000 (UTC)
From: Chris Leech <cleech@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Cc: John Meneghini <jmeneghi@redhat.com>
Subject: [PATCH 0/1] nvme-tcp: fence TCP socket on transport error
Date: Mon, 20 Mar 2023 15:09:46 -0700
Message-Id: <20230320220947.3244247-1-cleech@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230320_151209_309190_6A3F581B 
X-CRM114-Status: GOOD (  12.07  )
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

Even after "160f3549a907 nvme-tcp: fix UAF when detecting digest errors", I
don't think the queue->rd_enabled flag is fencing the TCP socket from further
receive processing.

io_work can be re-queued while running, and if it's pending when a receive
error occurs it will bypass the queue->rd_enabled checks that should prevent
queueing in nvme_tcp_data_ready.  Actually, it looks like nvme_tcp_write_space
and nvme_tcp_queue_request would schedule io_work anyway, which will always
call nvme_tcp_try_recv once regardless of rd_enabled.  And nvme_tcp_poll has no
checks against rd_enabled.

After receiving an unsupported PDU, the header has been read but the payload
remains in the socket queue.  And the nvme_tcp queue state looks like it's
ready to receive the payload of a C2H data PDU.  Any additional calls to
nvme_tcp_try_recv can incorerectly interpret the next bits as a command ID,
lookup a request from the tagset using this bogus ID, and start copying the
payload data from the unsupported PDU to an invalid destination address.

This has been seen with a buggy target that sent extranious bytes in the TCP
stream, but also I believe with a properly functioning target that sent a
Controller to Host Terminate Connection (C2HTermReq).  The Fatal Error Status
field was used as a Command ID and brought the host system down.

An additonal check against queue->rd_enabled at the start of nvme_tcp_recv_skb
should protect against both additonal io_work scheduling and nvme_tcp_poll use
after a receive transport error.

- Chris

Chris Leech (1):
  nvme-tcp: fence TCP socket on receive error

 drivers/nvme/host/tcp.c | 7 +++++++
 1 file changed, 7 insertions(+)

-- 
2.39.2


