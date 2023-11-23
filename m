Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4849C61DF7
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Nov 2023 14:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5xY844QwWxCW4Za/rW0Y7BsRrTKzMu+7Ex975e/nRQg=; b=r+nZNhorY2rHlbBNtGZN1oPFps
	4jT3k/t0EPEPQvGPrqy7mGHCI8yl6OzdtuXNi86hktUUDAwXYO0x0vKgt6XFWh5wEKZ2vYKWGtJOa
	y+HDgj3lH+L6Afyn0zWXGmoxcHJ2VCZ9Pjs8Dztk1ExZDHziH9oeJHftMN4P+L7MVO3crQc6f2eLe
	GRYkFeJBz9ao6VzoOH/XYRo2/fwvYyyGGd3erz7wDgDRIn1zKeRvSqr63sHw+K0apPK5AnuZiM2vT
	iM4O7CX8ITnQZhYSmhrCrQL5fz7xWCCnc77uuW6ekkzWAZVeT15gZ69AxqPgmnBJql6+VLSBZ+3yH
	oNG8zG+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r6AN1-004yhF-0T;
	Thu, 23 Nov 2023 14:07:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r6AMy-004yg7-0R
	for linux-nvme@lists.infradead.org;
	Thu, 23 Nov 2023 14:07:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700748468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5xY844QwWxCW4Za/rW0Y7BsRrTKzMu+7Ex975e/nRQg=;
	b=eVU+yUh3aMgW21QabCeD+6QaGatWbeV61xiXSQkdrh5QKU1UuO7Suq6xo9DxskpXhwTxkq
	uP59kShzoqCTleLi0QFUBsBPe2zMG/rfYMmMxtVQjHIEsv18gg+BIeKQcDjyj0tRnwtqVN
	myrvVYyURsQUwQ9tHQ3CPvM+2MBSYzA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-tmDmRQr9OKaw_Iiw-ikQvw-1; Thu,
 23 Nov 2023 09:07:44 -0500
X-MC-Unique: tmDmRQr9OKaw_Iiw-ikQvw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6CC991C05135;
	Thu, 23 Nov 2023 14:07:44 +0000 (UTC)
Received: from kalibr.redhat.com (unknown [10.47.238.37])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3880A492BFA;
	Thu, 23 Nov 2023 14:07:42 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org,
	emilne@redhat.com
Subject: [PATCH] nvme-core: fix a memory leak in nvme_ns_info_from_identify()
Date: Thu, 23 Nov 2023 15:07:41 +0100
Message-Id: <20231123140741.411735-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231123_060752_244266_17C8A62A 
X-CRM114-Status: GOOD (  10.97  )
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

In case of error, free the nvme_id_ns structure that was allocated
by nvme_identify_ns().

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88b54cdcbd68..d7f90a4475d5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1480,7 +1480,8 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 	if (id->ncap == 0) {
 		/* namespace not allocated or attached */
 		info->is_removed = true;
-		return -ENODEV;
+		ret = -ENODEV;
+		goto error;
 	}
 
 	info->anagrpid = id->anagrpid;
@@ -1498,8 +1499,10 @@ static int nvme_ns_info_from_identify(struct nvme_ctrl *ctrl,
 		    !memchr_inv(ids->nguid, 0, sizeof(ids->nguid)))
 			memcpy(ids->nguid, id->nguid, sizeof(ids->nguid));
 	}
+
+error:
 	kfree(id);
-	return 0;
+	return ret;
 }
 
 static int nvme_ns_info_from_id_cs_indep(struct nvme_ctrl *ctrl,
-- 
2.39.3


