Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF75C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 06:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=tS9KlUb9k/dHGNIHKTqWEDdeCcT0XIoxMwHPy+oXA5c=; b=ragGvG+G0ROBoyY8qG8eLtLgUr
	623I1CCPciySbTiLot/q06nuWcNYr1unwArqwLC77rq4kfSWV3MHe4smWSP08jgM2jdEjKzg/lmLr
	F+K+/ElkG4EkDbR7zPoe9nOuBEFfs8OFXZpLcWE6caEt2xc3VjGvH6IORJ8VL1w1/o63WGKUVsWNU
	jfximZbowmCibojPFDXsf27khXD2b46ZST978h60sd/q22sH6k2ltFalDh55GoXqW2wSC7LwCphqs
	IZsM4DEwdKMi28TzT5h2qjpNBSO2fhCCEYyA/N+FcGHo/EoznkWttURQaT1gPpX9Sf9gj8fxuegQO
	Y8ELECSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrZcM-005HEF-0N; Thu, 19 May 2022 06:26:38 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrZc9-005H8j-6Q
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 06:26:28 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 5FA2C21C06;
 Thu, 19 May 2022 06:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652941581; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tS9KlUb9k/dHGNIHKTqWEDdeCcT0XIoxMwHPy+oXA5c=;
 b=C8UXo7JWLSzvHcZjosFwvNUwtxRYdzrtR3XsdS6m2x9AZFsjxPzmB4xVWPvDvsvkI++HJ8
 xkiPhXzAX+d9GHqONh4iucmazAbNnYD4wZgLlZoRHvzKGcimpUbxu/8WKa+mRFVPdk+4QP
 8/57HIIvt/FaYUm0uDXUqam+ueL5S8k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652941581;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=tS9KlUb9k/dHGNIHKTqWEDdeCcT0XIoxMwHPy+oXA5c=;
 b=Zponl1G+UFowW7SENeOX/EGhiKmUMqc0sHKRnKXIWJIjvPZYY6ED1FdZ7c7OV9gYphZPLK
 TE1eniuE4rt8wgAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 532912C141;
 Thu, 19 May 2022 06:26:20 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id 7A9875194535; Thu, 19 May 2022 08:26:20 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 0/3] nvme-tcp: queue stalls under high load
Date: Thu, 19 May 2022 08:26:14 +0200
Message-Id: <20220519062617.39715-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_232625_518284_06419E0E 
X-CRM114-Status: GOOD (  12.20  )
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

Hi all,

one of our partners registered queue stalls and I/O timeouts under
high load. Analysis revealed that we see an extremely 'choppy' I/O
behaviour when running large transfers on systems on low-performance
links (eg 1GigE networks).
We had a system with 30 queues trying to transfer 128M requests; simple
calculation shows that transferring a _single_ request on all queues
will take up to 38 seconds, thereby timing out the last request before
it got sent.
As a solution I first fixed up the timeout handler to reset the timeout
if the request is still queued or in the process of being send. The
second path modifies the send path to only allow for new requests if we
have enough space on the TX queue, and finally break up the send loop to
avoid system stalls when sending large request.

As usual, comments and reviews are welcome.

Hannes Reinecke (3):
  nvme-tcp: spurious I/O timeout under high load
  nvme-tcp: Check for write space before queueing requests
  nvme-tcp: send quota for nvme_tcp_send_all()

 drivers/nvme/host/tcp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

-- 
2.29.2


