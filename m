Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAF24C4345F
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Apr 2024 10:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AOd8hxI30ICj9O/9WAy11DpLi9rytlI+U1CRtqcOszk=; b=SEW2a7iJ/UZevaVtt0ioCkN1oS
	rq1onIevveWz4O0HDqz+Dg12ui7OVWp+zQZiDAm5TL9y4mDeYQBIp/LjDpvuNNcZeZrICbsbowo1Q
	bS23jEzWhM4q9OGBUU3s4GFh4lYXtCoTMATmyJfekTkUqQ8U+8oNEnxke4zK07T/N6ALJhWp8bDr5
	WKDemn7u1KU8mt5YkyPwetHU3tCz6rjbL/L7/GPYJUEOn8DzIFlr8pHnbHuXC2o2WyDJOrC2Urs0E
	D3pJm5XhQdkUnWtsD0rhs7z3m5Qbcgy4TwFgYbHPlhwNaWR+o2czkjB/4P07KKzCaPwysegM/xhYK
	FZy/rqLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzZnv-00000003gJu-0H6c;
	Wed, 24 Apr 2024 10:24:43 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzZnr-00000003gG7-3Lzm
	for linux-nvme@lists.infradead.org;
	Wed, 24 Apr 2024 10:24:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713954273;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AOd8hxI30ICj9O/9WAy11DpLi9rytlI+U1CRtqcOszk=;
	b=cB+7C8Eq38KnP/crGzlzIALnJVgNuAeZdwwjdBNA1m3bhxKvhYPjPd9ROfvVBxfKVi1+Fw
	+Pup3qHx2n0UqUTFJCAw0V3EnhuT9rGd2ZaxqGcbJtlgT1Jylq99aq8XnaBKlBNCgG6K+F
	BQpUSIe3GkRX8cBVbrGiN/SzZerwZq8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-L1NxjKpeM7yraJSYUqVJ7g-1; Wed, 24 Apr 2024 06:24:31 -0400
X-MC-Unique: L1NxjKpeM7yraJSYUqVJ7g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7FAA18F22E2;
	Wed, 24 Apr 2024 10:24:31 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.99])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D32121C0CB01;
	Wed, 24 Apr 2024 10:24:29 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: sagi@grimberg.me,
	hare@suse.de,
	dwagner@suse.de,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet-auth: print an error message if the auth timeout expires
Date: Wed, 24 Apr 2024 12:24:28 +0200
Message-Id: <20240424102428.1298052-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240424_032439_986845_923F2FBB 
X-CRM114-Status: GOOD (  12.02  )
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

When the auth_expired_work fires, an error message should be printed
to inform the user that the authentication is failing because of
a timeout, so he doesn't get misleaded into thinking there is a bug
in the auth code when seeing messages like the following:

nvmet: nvmet_execute_auth_send: ctrl 1 qid 2 step mismatch (2 != 0)
nvmet: nvmet_execute_auth_send: failure incorrect message.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/fabrics-cmd-auth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index eb7785be0ca7..7436ebda9f70 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -17,8 +17,8 @@ static void nvmet_auth_expired_work(struct work_struct *work)
 	struct nvmet_sq *sq = container_of(to_delayed_work(work),
 			struct nvmet_sq, auth_expired_work);
 
-	pr_debug("%s: ctrl %d qid %d transaction %u expired, resetting\n",
-		 __func__, sq->ctrl->cntlid, sq->qid, sq->dhchap_tid);
+	pr_err("%s: ctrl %d qid %d transaction %u expired, resetting\n",
+		__func__, sq->ctrl->cntlid, sq->qid, sq->dhchap_tid);
 	sq->dhchap_step = NVME_AUTH_DHCHAP_MESSAGE_NEGOTIATE;
 	sq->dhchap_tid = -1;
 }
-- 
2.39.3


