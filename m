Return-Path: <SRS0=a356=QC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED9CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 16:31:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B1561AA2
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Nov 2021 16:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 70B1561AA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GaREFHkLOAxDRVNjZ3cvoVbE14Z6LdTJhhzAXNBAGaA=; b=r4NugQCevCbUrDJzTS82G1Qb1r
	YjvFmJm3RwtxahENXeGY5NdPd1h4ImsEz60kE5cRKtzzDXUsTNhTA1pWrXJzi2WqoY7MOQq3mwoRy
	H7jY5hZmCo/+h+XILU4U42iU1AEZf+4TK7BTfXrpUe6ErXgKj52iyxN73l80AwvQf8ZAO/7c0pexN
	mGY3NMZG5ih+NM8TcF62nkHii7KTnldMjZ2d7hx39RabjyITE4CKFnTjFQiE3uCZ0LGJp7Ln7dFnW
	Q9QHRFQs1wHd4pBeL706NP7TYQfL8Dya8tHHuVvNPA/NLZFd6/LgFJGLXOM4Ei5TvjbE+HGxeNaMw
	fZlK49kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mmetZ-00GL1S-FO; Mon, 15 Nov 2021 16:31:49 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mmetC-00GKto-Um
 for linux-nvme@lists.infradead.org; Mon, 15 Nov 2021 16:31:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636993886;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GaREFHkLOAxDRVNjZ3cvoVbE14Z6LdTJhhzAXNBAGaA=;
 b=cQYvjN7hSz0LxQ3kLQTOTr0QatFZSCw1dsl4R36SimIX0pHWEucuOMLiwluOVcGmDL7DLG
 1Gn3idTNBtOk9ruKuscLa8gD90wYG0PlLO2Od9cr8w5iNc+ZYaOln4caQG/hK6i8xBrOjb
 zjzSRAXuNDOeWnawA0OBJ3/tm2RAhE0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-XUC5pOcFMTOJze9L7uG0tw-1; Mon, 15 Nov 2021 11:31:23 -0500
X-MC-Unique: XUC5pOcFMTOJze9L7uG0tw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C556881901A;
 Mon, 15 Nov 2021 16:31:21 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.192.80])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7F83619D9F;
 Mon, 15 Nov 2021 16:31:20 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	sagi@grimberg.me,
	chaitanya.kulkarni@wdc.com
Subject: [PATCH V2 3/3] nvmet-tcp: fix memory leak when performing a
 controller reset
Date: Mon, 15 Nov 2021 17:31:14 +0100
Message-Id: <20211115163114.48716-4-mlombard@redhat.com>
In-Reply-To: <20211115163114.48716-1-mlombard@redhat.com>
References: <20211115163114.48716-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211115_083127_110418_1BFF1CB1 
X-CRM114-Status: GOOD (  14.34  )
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
---
 drivers/nvme/target/tcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 028b47ff0f0f..5a238fa067cd 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1427,7 +1427,10 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 
 	for (i = 0; i < queue->nr_cmds; i++, cmd++) {
 		if (nvmet_tcp_need_data_in(cmd))
-			nvmet_tcp_finish_cmd(cmd);
+			nvmet_req_uninit(&cmd->req);
+
+		nvmet_tcp_unmap_pdu_iovec(cmd);
+		nvmet_tcp_free_iovec(cmd);
 	}
 
 	if (!queue->nr_cmds && nvmet_tcp_need_data_in(&queue->connect)) {
-- 
2.27.0


