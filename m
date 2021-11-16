Return-Path: <SRS0=wlVn=QD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265CBC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 15:50:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E45EE61414
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Nov 2021 15:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E45EE61414
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m2vHOP3q8DXpcqM/cDM2l1jceSIxZ6Qsd+oxFwVyocI=; b=WUeJ0ulFfEnjwojexDM2bF9UfA
	ZBlxgrGytPDYIRcLvJKmZVimlTsN56bQceDcIK0Yu/RsU7KD0GlOptFhKUlxkIztywbpsDXQo1FLf
	kQrDpqGcwu7sw5Qbg9P+gn2ZTHfGoIAK7VVazAsgPVmNgnZ8Iiueehl34SZjffKxgE3EG25ogQE11
	gBhjjgfFh5hDne3vjj+FG2GmrKGdvd4keplohw0nraXnTv/OIn/aftOsNVyNC/Jch8ewKrQsaK239
	1cEa3T9l0E3BzdHKXBj7o+uWNWH4KGeeLfWssbctjn9R7F8ynjlHMBsz77QgXQcy3RLSFmOJo0H8N
	4MzpfMcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mn0ib-002CI1-PV; Tue, 16 Nov 2021 15:49:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mn0iG-002C7p-1v
 for linux-nvme@lists.infradead.org; Tue, 16 Nov 2021 15:49:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637077773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m2vHOP3q8DXpcqM/cDM2l1jceSIxZ6Qsd+oxFwVyocI=;
 b=CN+us0l30/AgCQYQ2hXlpUtKWGf9aS2sAihf1WsZ5ySf4NWdxdWD/XKhLi7Pj0N4iKIuf1
 1UE0lKkOH8s3v/sxd9qttBFyIXL6LKLzsEx37koy9rpA2aeIIkVLw5IospZeYMyhApih/j
 inycAEOTQEuQz1VL78K8BGlayT9op5A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-7raH1xkIPLaOG9DJAwv-7Q-1; Tue, 16 Nov 2021 10:49:29 -0500
X-MC-Unique: 7raH1xkIPLaOG9DJAwv-7Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5C8D1923764;
 Tue, 16 Nov 2021 15:49:28 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.192.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 88C4A5D6BA;
 Tue, 16 Nov 2021 15:49:27 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	chaitanya.kulkarni@wdc.com
Subject: [PATCH V3 3/3] nvmet-tcp: fix memory leak when performing a
 controller reset
Date: Tue, 16 Nov 2021 16:49:20 +0100
Message-Id: <20211116154920.87279-4-mlombard@redhat.com>
In-Reply-To: <20211116154920.87279-1-mlombard@redhat.com>
References: <20211116154920.87279-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211116_074936_210984_90EF2354 
X-CRM114-Status: GOOD (  15.12  )
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

If a reset controller is executed while the initiator
is performing some I/O the driver may leak the memory allocated
for the commands' iovec.

Make sure that nvmet_tcp_uninit_data_in_cmds() releases
all the memory.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 786b1440a9af..605aa2a8ca53 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1427,7 +1427,10 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 
 	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
 		if (nvmet_tcp_need_data_in(cmd))
-			nvmet_tcp_finish_cmd(cmd);
+			nvmet_req_uninit(&cmd->req);
+
+		nvmet_tcp_unmap_pdu_iovec(cmd);
+		nvmet_tcp_free_cmd_buffers(cmd);
 	}
 
 	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
-- 
2.27.0


