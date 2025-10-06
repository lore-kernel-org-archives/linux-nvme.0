Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7228CAC5B8
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Oct 2025 17:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=l8rBuz0ok8vDMLxl0XlgvYbk6Y4dijR6j6S456wU82s=; b=UOMgxSg7Z3nT/USxdRPwvu4onO
	jflJj6klDoQ45WFvpz6EOe4K8d5K7EttuTLckZMEYzofjWpu0wmrjOdqe2vWdHyjqYb4PyidBja3F
	I4cHDFLhxe2JTfYTXsNh9xu9pMwtjHQdufScfmz3C8zp57s/4k6sCdDcKEauKSL972aYK0Q4cE3fG
	FwjxAOQJttGlSNfsXGnaxkaEBLMiDYPpQBDqj/FJIOcxU5NgWNVT6ganTiJ641izETNJ4SInvfrzY
	a1im7aI9O9qSk8parjBBU0wwGj/rpTwfAwj46Yq4Y/aHUNMwN+5PIdy8ato8xBo6CNhgifPb2OyZ2
	ZoymWPVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5pUb-00000000Y3d-1PuC;
	Mon, 06 Oct 2025 17:59:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v5pUV-00000000Y2G-4C30
	for linux-nvme@lists.infradead.org;
	Mon, 06 Oct 2025 17:59:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759773558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=l8rBuz0ok8vDMLxl0XlgvYbk6Y4dijR6j6S456wU82s=;
	b=eSFbVpW2d7uZGzlpLW3+/Cles5AYOhSR8ijRpCnIDOmYdqiE0SN8Fmh3/BuBVwBiF8WP/I
	lX/0ngDrLRqEf40Il71O8JPQEaQAjrMpX9qsDhfiOh0W3/ebVz/9aE05N3Whze8RjiWv4Z
	cbwZ8ALS/6rZR1Bs9Puqbn6Z7JrKLSI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-228-aYxwWVKOM2uOzEZD_tGcIg-1; Mon,
 06 Oct 2025 13:59:14 -0400
X-MC-Unique: aYxwWVKOM2uOzEZD_tGcIg-1
X-Mimecast-MFC-AGG-ID: aYxwWVKOM2uOzEZD_tGcIg_1759773553
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8EC3B1800293;
	Mon,  6 Oct 2025 17:59:13 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.44.32.154])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BBA31800576;
	Mon,  6 Oct 2025 17:59:11 +0000 (UTC)
From: Tomas Henzl <thenzl@redhat.com>
To: linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Cc: kbusch@kernel.org
Subject: [PATCH] nvmet-tcp: remove a redundant line in nvmet_tcp_release_queue_work
Date: Mon,  6 Oct 2025 19:59:10 +0200
Message-ID: <20251006175910.62721-1-thenzl@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FZK5OzHKYAvisb6mj8ZVDGYjoeWhUvogju66dsCMGik_1759773553
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251006_105920_105032_8DF9FE20 
X-CRM114-Status: UNSURE (   8.74  )
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

cancel_work_sync(&queue->io_work) is called twice, remove the
second instance.

Signed-off-by: Tomas Henzl <thenzl@redhat.com>
---
 drivers/nvme/target/tcp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 470bf37e5a63..a1d0f6b18b2c 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1577,7 +1577,6 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
 	nvmet_cq_put(&queue->nvme_cq);
-	cancel_work_sync(&queue->io_work);
 	nvmet_tcp_free_cmd_data_in_buffers(queue);
 	/* ->sock will be released by fput() */
 	fput(queue->sock->file);
-- 
2.51.0


