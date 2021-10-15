Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31C6C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 08:51:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EFE761090
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 08:51:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9EFE761090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fBDNW0hb1+M3BPtdOfPK6L4dfflKNVv2CXHr8vZ+Uvg=; b=TRArPKiLFBujrVRJoo1SExjiqQ
	FQGtDX3BKyU/L4U8PHamLZXjOvoxGZHJ3l+q1u/rNr6nZ1kGlfCsTDVAOg8PSYgq4eup5Dv4mQNrD
	EZm9n5ciYLgB+f/HB+Mg8fnG7iwQupj8Zvk3+9SIjXIAaczszjCtg2MFheqZHXWb/hYdQNq3JKZ+6
	SaA3CRW/65MfDDXrVlGBMkvKIHHCTXzYeb8uuNijstC6d3YmeeO8It9AH63KbN3ZKHVvlLGPDgvjT
	MsLzc2jMdlC5H85RHLA7/SnbNf13eVMdVQuKh1QfspNxFSjz/FUaEJNedcWh0M/sEjEaK58P9l7Lq
	ncEc8THg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbIvb-0065nx-6x; Fri, 15 Oct 2021 08:50:59 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbIYA-005ywq-9q
 for linux-nvme@lists.infradead.org; Fri, 15 Oct 2021 08:26:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634286402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fBDNW0hb1+M3BPtdOfPK6L4dfflKNVv2CXHr8vZ+Uvg=;
 b=MChcYdQcXF3vpAavRLNmsze40u49FcGGykrHMtzCAfYgHQNKz9ZMkhvAbrQuCEctMRvHUG
 YqUMlJ0z+dX5q764Z3QVY0+pC83Mlay3Lr9O4QER7s2e3kiAEgC5z2PMfCo5l/7CpCH1XD
 DYgcM9KRccYNWEK9yJzcyiOtA6bQlnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-B9U-edWXNXS5z8Pg1lK9WA-1; Fri, 15 Oct 2021 04:26:39 -0400
X-MC-Unique: B9U-edWXNXS5z8Pg1lK9WA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F88A801ADB;
 Fri, 15 Oct 2021 08:26:38 +0000 (UTC)
Received: from raketa.redhat.com (unknown [10.40.192.203])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E81F31972D;
 Fri, 15 Oct 2021 08:26:35 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me, hare@suse.de, chaitanya.kulkarni@wdc.com,
 jmeneghi@redhat.com
Subject: [PATCH] nvmet-tcp: fix a memory leak when releasing a queue
Date: Fri, 15 Oct 2021 10:26:34 +0200
Message-Id: <20211015082634.555494-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mlombard@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211015_012646_513615_94A3B8F1 
X-CRM114-Status: GOOD (  11.74  )
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

page_frag_free() won't completely release the memory
allocated for the commands, the cache page must be explicitly
freed by calling __page_frag_cache_drain().

This bug can be easily reproduced by repeatedly
executing the following command on the initiator:

$echo 1 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/reset_controller

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
Reviewed-by: John Meneghini <jmeneghi@redhat.com>
---
 drivers/nvme/target/tcp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 07ee347ea3f3..c33a0464346f 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1428,6 +1428,7 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 
 static void nvmet_tcp_release_queue_work(struct work_struct *w)
 {
+	struct page *page;
 	struct nvmet_tcp_queue *queue =
 		container_of(w, struct nvmet_tcp_queue, release_work);
 
@@ -1447,6 +1448,8 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 		nvmet_tcp_free_crypto(queue);
 	ida_simple_remove(&nvmet_tcp_queue_ida, queue->idx);
 
+	page = virt_to_head_page(queue->pf_cache.va);
+	__page_frag_cache_drain(page, queue->pf_cache.pagecnt_bias);
 	kfree(queue);
 }
 
-- 
2.27.0


