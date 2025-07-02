Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98258C83038
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Jul 2025 17:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=poxl9p280fhamf0Br3kWf2r7/MNKrthNQn0MkE1FzKw=; b=bjw0kj7OPQemOzt8lhAZYOYqbA
	pZa8RWNHZgWz/Cw4raF+Utv2FE6GwEkgO0rCmwQ6p8icQWnoKVh+JzOVJ329bMTLuLqnSRRgBQ72/
	W7hU57piZCGbqfgEKcV64mBQP0hUBrY2E8jEhl3N6rKJ7XNvVW3UyELwYNHaSQdxj5gbHg0MyJhdB
	SaKkrEHynAx96EgLzcOEMv0WH5ltX9JJw/C3Xp3KIWkIJJp9XxSSWdlddrqJWXH6kUSP6Vp58uNiX
	vXmTCSHnZPXqlEixqpQ0mgfzimwNlo7Vt/QUapejlDHUWQ7aje5/+yrHZK9eCI5kiUM8+H5Wh1d9T
	P/4pwxLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uX1ZB-00000009ADS-1N3n;
	Wed, 02 Jul 2025 17:48:17 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uWy8B-00000008a4S-3NQm
	for linux-nvme@lists.infradead.org;
	Wed, 02 Jul 2025 14:08:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751465289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=poxl9p280fhamf0Br3kWf2r7/MNKrthNQn0MkE1FzKw=;
	b=TBaIw+temMp36T8U+BtMhNi7x2G7CPPiOnsMrAHUxmje0Yxq5N4jHihDcMPr1mjEvQSfot
	hceQ1zGkQg88TIVEdkQAUJm87r0jTY7tb2sYG2mFPvmJ3/Q9nP4zR4z+EsfS9/8AFKdbp5
	lNkkv+hYBdKK/68aSzHBMT7QTMX600c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-0UaBY3fUMBOJHztSbzwMYg-1; Wed,
 02 Jul 2025 10:06:37 -0400
X-MC-Unique: 0UaBY3fUMBOJHztSbzwMYg-1
X-Mimecast-MFC-AGG-ID: 0UaBY3fUMBOJHztSbzwMYg_1751465196
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 69AD118DA387;
	Wed,  2 Jul 2025 14:06:35 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.33])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4D032195608F;
	Wed,  2 Jul 2025 14:06:31 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hare@suse.de,
	mlombard@bsdbackstore.eu
Subject: [PATCH V2] nvme-tcp: log TLS handshake failures at error level
Date: Wed,  2 Jul 2025 16:06:29 +0200
Message-ID: <20250702140629.70378-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HaZVDPnL9V3Qel7lhwKsEkBcqqw6Kx07eVmOzvEDMWw_1751465196
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250702_070811_910578_AD919F3C 
X-CRM114-Status: GOOD (  11.12  )
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

Update the nvme_tcp_start_tls() function to use dev_err()
instead of dev_dbg() when a TLS error is detected.
This ensures that handshake failures are visible by default,
aiding in debugging.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---

 v2: Hans suggests to print a dev_dbg() message
     if handshake is succesfull

 drivers/nvme/host/tcp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d924008c3949..9233f088fac8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1745,9 +1745,14 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 			qid, ret);
 		tls_handshake_cancel(queue->sock->sk);
 	} else {
-		dev_dbg(nctrl->device,
-			"queue %d: TLS handshake complete, error %d\n",
-			qid, queue->tls_err);
+		if (queue->tls_err) {
+			dev_err(nctrl->device,
+				"queue %d: TLS handshake complete, error %d\n",
+				qid, queue->tls_err);
+		} else {
+			dev_dbg(nctrl->device,
+				"queue %d: TLS handshake complete\n", qid);
+		}
 		ret = queue->tls_err;
 	}
 	return ret;
-- 
2.47.1


