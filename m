Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03620C3600B
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Mar 2025 16:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X3cri+uFx8csCiU2FNc5RD9l4QtMsVzhMQKMQXhx5n4=; b=wMlQiXUeUjl+8J/lw80gZITW2o
	PJ1KhHePikSqVxBjq42LBZtiQsauwdnLhhfH1539EFNiKNX/xMZisydCv7rYtYhlG238tRjpIQ5WD
	7R3CSRvwIN4MjR4Px4vahwKJZXmqnQh4qNOhLGVNXJzX2IGqRHo1pXA+7r7bAO9Id9Y4A59CCWZp1
	YZ2bo0dseh9o4YrkdlvNBe03s1LCth6dAzyrC73Je42Cfaps4K318yEWHftKY97/Y9VmMFjeIaFrZ
	BXNuE6iNxyuNNYhPKdXQ50FyyYIPFjwDikrcE5796ofPceHJBd6OMixV0G8CU7siFctUdHK6jl6KL
	swCcsB+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzI1z-00000000ysa-0Fs7;
	Mon, 31 Mar 2025 16:30:35 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tzI0g-00000000yiw-2Pde
	for linux-nvme@lists.infradead.org;
	Mon, 31 Mar 2025 16:29:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743438553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3cri+uFx8csCiU2FNc5RD9l4QtMsVzhMQKMQXhx5n4=;
	b=VkmWwb+UpExnqC/SFtBaMOVGxlUkR/q6vDVEGXgWuETIkpyO6hG/P74bN+C4sruLA8Jw+x
	EAtu/9ExrhceGcib1uqXh74wGBmEgb1HRsByNy4YvkWKDXK+51glWc3ijcgUUG1Q2r/+hp
	Bb7k15j1oTJPQg6fExxj5K8QljIOAg4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-ZGjFrO1ZPFKpqCot3_QtRg-1; Mon,
 31 Mar 2025 12:29:10 -0400
X-MC-Unique: ZGjFrO1ZPFKpqCot3_QtRg-1
X-Mimecast-MFC-AGG-ID: ZGjFrO1ZPFKpqCot3_QtRg_1743438549
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 295F6195608F;
	Mon, 31 Mar 2025 16:29:09 +0000 (UTC)
Received: from rocky.redhat.com (unknown [10.47.238.77])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A9E3A19541A6;
	Mon, 31 Mar 2025 16:29:05 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: axboe@kernel.dk,
	mikhail.v.gavrilov@gmail.com,
	hch@lst.de,
	linux-nvme@lists.infradead.org,
	mlombard@bsdbackstore.eu
Subject: [PATCH 1/1] nvme-pci: do not call nvme_write_sq_db() if the commands list is empty
Date: Mon, 31 Mar 2025 18:28:59 +0200
Message-ID: <20250331162859.1407725-2-mlombard@redhat.com>
In-Reply-To: <20250331162859.1407725-1-mlombard@redhat.com>
References: <20250331162859.1407725-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: tiR9Riq_dqQRwrAwPG1Z1yYUU0GwqJPlvgW86Ecq5ZU_1743438549
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250331_092914_682164_A5E9F950 
X-CRM114-Status: GOOD (  10.63  )
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

nvme_submit_cmds() should check the rqlist
before calling nvme_write_sq_db();
if the list is empty, it must return immediately.

Fixes: beadf0088501 ("nvme-pci: reverse request order in nvme_queue_rqs")
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2883d17ee1eb..b178d52eac1b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -986,6 +986,9 @@ static void nvme_submit_cmds(struct nvme_queue *nvmeq, struct rq_list *rqlist)
 {
 	struct request *req;
 
+	if (rq_list_empty(rqlist))
+		return;
+
 	spin_lock(&nvmeq->sq_lock);
 	while ((req = rq_list_pop(rqlist))) {
 		struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-- 
2.43.5


