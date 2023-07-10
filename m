Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 969EBEB64D9
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Jul 2023 15:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4RgppggoNg0OVt1d9YvaBwKvuJ/gFRg4h3dh1c70UhU=; b=gobrsNt/s1/qfC3NM7Z8g5trsc
	wv+flz449ywlWRZSxHJk9ZcsseOWI8pgjWU78nphVIuj0AfkPmGRRFGqs5nRwRgKCe+xXWb06K4zd
	q5juB4elvBJdls76lUjHR5Yqhul5OTvBfJuYWUN812GP5DtN8s85gX4D6fin3OSZLXQeUndw5fraI
	dRnIGutMj5b9+v3+7JFVsOadD2xyf8vFndP0Q0cEECyb/9sndHws2rhK2hsc27P0saSSH1Gdtn5f8
	pHMtwIGAasMCaV0/nLG1QRMETJdUzgzoeQ/HSxvKz2EgIHqMZ3jiGst4fKBfMo0Jbv6gQ5SSAQJrt
	ls4olQcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qIswA-00C0qN-2Q;
	Mon, 10 Jul 2023 15:36:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qIsw7-00C0oR-1m
	for linux-nvme@lists.infradead.org;
	Mon, 10 Jul 2023 15:36:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689003386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4RgppggoNg0OVt1d9YvaBwKvuJ/gFRg4h3dh1c70UhU=;
	b=BkjO6awZEhIqxRJ+6SPkWhUo8bgDKnJtl53MjdjKBfWi0Ugx7IvS5kIpFhaLrO3ECwzQHS
	aE+DkhpCLMeNRamkRFONi+aYwJ+IysA1VMONlBujiMRkeNJxqCLQxVt4C50TpKtu+bryR4
	4qB3gFVrnsE2UBOt8vo7h77D+uBoqKQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-356-O4nRrwzgPjqkng-TePSfIg-1; Mon, 10 Jul 2023 11:36:22 -0400
X-MC-Unique: O4nRrwzgPjqkng-TePSfIg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2333988D543;
	Mon, 10 Jul 2023 15:36:22 +0000 (UTC)
Received: from localhost (ovpn-8-19.pek2.redhat.com [10.72.8.19])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 42B094087C73;
	Mon, 10 Jul 2023 15:36:18 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>,
	Chunguang Xu <brookxu.cn@gmail.com>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/6] nvme: tcp: unquiesce queues after ctrl state is changed
Date: Mon, 10 Jul 2023 23:35:52 +0800
Message-Id: <20230710153555.1766438-4-ming.lei@redhat.com>
In-Reply-To: <20230710153555.1766438-1-ming.lei@redhat.com>
References: <20230710153555.1766438-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230710_083627_663873_26A08A07 
X-CRM114-Status: GOOD (  13.58  )
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

Unquiesce queues until controller state is changed successfully.

Prepare for moving start freeze into reconnect work for preventing new
request from entering queue in LIVE state.

Before removing namespace, unquiescing queues is done unconditionally, so
it is safe to do this way in case of state change failure.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/tcp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e414cfb3433f..e68bf21af348 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2109,10 +2109,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	nvme_tcp_teardown_io_queues(ctrl);
-	/* unquiesce to fail fast pending requests */
-	nvme_unquiesce_io_queues(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl);
-	nvme_unquiesce_admin_queue(ctrl);
 	nvme_auth_stop(ctrl);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
@@ -2122,6 +2119,10 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
+	/* unquiesce to fail fast pending requests */
+	nvme_unquiesce_io_queues(ctrl);
+	nvme_unquiesce_admin_queue(ctrl);
+
 	nvme_tcp_reconnect_or_remove(ctrl);
 }
 
-- 
2.40.1


