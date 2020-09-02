Return-Path: <SRS0=9ikG=CL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 036B3C2BBDB
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 22:43:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C247120773
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Sep 2020 22:43:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S4He+xZG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CLJ7xG7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C247120773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=otOZQHBmvIdzJWV7p9ZkovIjQyaredh1zAZzZ0D/P3w=; b=S4He+xZGH3THhD73fkNrGgCyg2
	dK89Jg7uUUryXkWQsjH9EN/YytttQ1Ulsw6ElS7wCdUQnuJmIXlUBZ+U90BqSrvMixObyT1fQbRxy
	r2jSdJjWrTXtv5dLU4ZQAjdIR7zBzpiXq6xgBFcescbuixjtVu/1UIT2vhUTXlYBsaaXbrWt58+7i
	+O52C+R1IE+dPKB6OP/3PiG6s3ZwsBNSZu8tS+OKJUbrkU0p01ae4NQJu89SeJFJtTqJl8sYw3pp0
	1BaAFg3g8pKpyq9GF1+HlLzulWo2kaBLWB85xQK9LiB5R9Yuy/mqfDhtxZVzdbQYQ0OeNeD1nlO0C
	cuUJH/WA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDbT8-0006lC-D1; Wed, 02 Sep 2020 22:43:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDbT4-0006jN-72
 for linux-nvme@lists.infradead.org; Wed, 02 Sep 2020 22:43:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599086580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=46sZ0+D1euvuWRLAJMl3IOQh954HKoUsyRq04EWSoJ8=;
 b=CLJ7xG7ul++znRsO9cG/yuAPcTb+tCSyF4sP94t9oYphN1c4ewby6RZiJEEQQwy4lBLf3T
 OaESdDgxVZr5EqTPnQtIDKNbAQIyIRc1LDGP1I9wSaj5Pvt7SKigJxRkYGJAFAWEohuFho
 fDjB1FapGh5qZDB9gGkZFNCivz2g0cM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-qoDQv6fOPuyhYrIo8scbgQ-1; Wed, 02 Sep 2020 18:42:58 -0400
X-MC-Unique: qoDQv6fOPuyhYrIo8scbgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4C9A41DE02;
 Wed,  2 Sep 2020 22:42:57 +0000 (UTC)
Received: from hpz440.redhat.com (ovpn-113-131.rdu2.redhat.com [10.10.113.131])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BDC9D59;
 Wed,  2 Sep 2020 22:42:56 +0000 (UTC)
From: David Milburn <dmilburn@redhat.com>
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, hch@lst.de,
 james.smart@broadcom.com
Subject: [PATCH v3 2/3] nvme-tcp: cancel async events before freeing event
 struct
Date: Wed,  2 Sep 2020 17:42:53 -0500
Message-Id: <1599086574-85969-3-git-send-email-dmilburn@redhat.com>
In-Reply-To: <1599086574-85969-1-git-send-email-dmilburn@redhat.com>
References: <1599086574-85969-1-git-send-email-dmilburn@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dmilburn@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200902_184302_311820_081E6792 
X-CRM114-Status: GOOD (  12.99  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Cancel async event work in case async event has been queued
up, and nvme_tcp_submit_async_event() runs after event has
been freed.

Signed-off-by: David Milburn <dmilburn@redhat.com>
---
 drivers/nvme/host/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 16851ae3bddf..8f4f29f18b8c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1596,6 +1596,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 static void nvme_tcp_free_admin_queue(struct nvme_ctrl *ctrl)
 {
 	if (to_tcp_ctrl(ctrl)->async_req.pdu) {
+		cancel_work_sync(&ctrl->async_event_work);
 		nvme_tcp_free_async_req(to_tcp_ctrl(ctrl));
 		to_tcp_ctrl(ctrl)->async_req.pdu = NULL;
 	}
-- 
2.18.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
