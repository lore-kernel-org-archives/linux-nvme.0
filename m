Return-Path: <SRS0=C+HF=L2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A86C5C11F69
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jul 2021 08:13:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE11E6128E
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Jul 2021 08:13:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE11E6128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=cpcawK24gNmq9EX9lQqLR+WWB8p6UUyzPUc3sGGutEM=; b=nIBYNStNX4RU2U
	1Mi/AHbPfaf7k8SsUHOiH7lZSqBdL/Q4ieiMDhFHSEgD/3WT2s91LYON39OqEGYVEJT9rjlFCmfqq
	J1sY8J3MxdW6KESB+JXkOaVmwVdNyYgsaDl1/StAq3cObZgzMRrZhfRAa4ouaJJNtA6aQum2dcaQL
	yR2l2ptHuD3izFMVrAOgaGj5aDC487voVixgcbHLhjYJxPvOopm20zp3C8SaIRZcqUgIsIioykWWD
	slmyLpUF+5z39NRCZySI3QVlZ0s04yo78Mf7XBP4mGgB27ftsoKlfEIqSyjxrvQu+gxg3+VMh0dLJ
	XW1xvYWjsqizreQm1MIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lzEIP-002RkH-Db; Fri, 02 Jul 2021 08:13:09 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lzEIM-002Rjx-M0
 for linux-nvme@lists.infradead.org; Fri, 02 Jul 2021 08:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1625213584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=AWJZAPYk1ESEQfFmN/ab0uPe1KXYGBrUSoScWVU+tiY=;
 b=SMmQIgsVPvFf90GiepGBgrqceW/SMUuNlMiM6o5KO9Ow8NIxMZ5/XdF+vQ71sEFeJ3+haP
 BupbHCwIZruZzMHPJXWOAHZWHOqLW7qJ6YZptSEl3jldvj2Mj3+R7Jo85WOVgaaXg7cKdo
 UVVAXDQRKgDIR+LHdrwDvryWydmTAdM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-At5RizGeMsO1vmwRdjR-kQ-1; Fri, 02 Jul 2021 04:11:24 -0400
X-MC-Unique: At5RizGeMsO1vmwRdjR-kQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A2E0E80414E;
 Fri,  2 Jul 2021 08:11:23 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.194.193])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75B4519D9B;
 Fri,  2 Jul 2021 08:11:22 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: hch@lst.de
Cc: sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-tcp: can't set sk_user_data without write_lock
Date: Fri,  2 Jul 2021 10:11:21 +0200
Message-Id: <20210702081121.68391-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210702_011306_829694_B78209D3 
X-CRM114-Status: GOOD (  12.62  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The sk_user_data pointer is supposed to be modified only while
holding the write_lock "sk_callback_lock", otherwise
we could race with other threads and crash the kernel.

we can't take the write_lock in nvmet_tcp_state_change()
because it would cause a deadlock, but the release_work queue
will set the pointer to NULL later so we can simply remove
the assignment.

Fixes: b5332a9f3f3d ("nvmet-tcp: fix incorrect locking in state_change sk callback")

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d8aceef83284..07ee347ea3f3 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1497,7 +1497,6 @@ static void nvmet_tcp_state_change(struct sock *sk)
 	case TCP_CLOSE_WAIT:
 	case TCP_CLOSE:
 		/* FALLTHRU */
-		sk->sk_user_data = NULL;
 		nvmet_tcp_schedule_release_queue(queue);
 		break;
 	default:
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
