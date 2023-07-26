Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7BEDC0015E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jul 2023 09:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XUAbwUholcdP/E78pjIWjWfXWvuCT6ODN3CqmEOBnlY=; b=jwc8cZxtvwMC1kvNwuzKxGV7o4
	3H21n4R5QVoy69uh1nd6ZcSDUumTShwpihAlqQkoqmwJg4rBV8AL7t+Y4DV9SGk1FeUQmTIvgJgE1
	cIvWFvorKWIx+RU5um+cYtBIm+QKD5u9S1c0KDocT7WIwFEJnIFgv2MV2KqbcP/JQbygFBG57ktge
	4uy1GFlavbn0GBOorckramrUJ2iBro1vLq+Fey59vWmNfAMVfLDNP+9yOidW+HWsI3qTUMWYTkSCC
	R2dmpUOMwFdTdq034EhuiuNjsQoDq4bTGxm9srNzwaKyXxSteiEYeMCJqyKGXAwt2/KBS6Gqf1Ht1
	go/1bZlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOb0r-009ljJ-0m;
	Wed, 26 Jul 2023 09:40:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOb0n-009lhK-37
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jul 2023 09:40:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690364453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XUAbwUholcdP/E78pjIWjWfXWvuCT6ODN3CqmEOBnlY=;
	b=VNww+fC8VbMqWR+kFe9muO7UWK1bGGW4iUXzUeHWcAI5cJm0r70FFXwgBHygzjxG7++OV+
	SE51vEUPSAmumBWRtzwKB0IOGczEHoa/FCQMN6d7Lzo9IARbB77opwvpCJG1YKoiLjmOuX
	I6cMq0n1l3JXHHL6klzYHNoHs4xC+YA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-oQFhGE4cMQWWMo61YsirzA-1; Wed, 26 Jul 2023 05:40:46 -0400
X-MC-Unique: oQFhGE4cMQWWMo61YsirzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EB1888D583;
	Wed, 26 Jul 2023 09:40:46 +0000 (UTC)
Received: from localhost (unknown [10.72.120.4])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7CF031401C2E;
	Wed, 26 Jul 2023 09:40:45 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	linux-nvme@lists.infradead.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Wen Xiong <wenxiong@linux.ibm.com>,
	Keith Busch <kbusch@kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 3/9] scsi: core: add helper of scsi_max_nr_hw_queues()
Date: Wed, 26 Jul 2023 17:40:21 +0800
Message-Id: <20230726094027.535126-4-ming.lei@redhat.com>
In-Reply-To: <20230726094027.535126-1-ming.lei@redhat.com>
References: <20230726094027.535126-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230726_024054_075081_1DA17B9A 
X-CRM114-Status: GOOD (  13.76  )
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

blk_mq_alloc_tag_set() may change nr_hw_queues for kdump kernel, so
driver has to take blk-mq max supported nr_hw_queues into account
when figuring out nr_hw_queues from hardware info, for avoiding
inconsistency between scsi driver and blk-mq.

Add helper of scsi_max_nr_hw_queues() for avoiding nr_hw_queues
inconsistency between scsi driver and blk-mq.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/scsi/scsi_host.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 70b7475dcf56..2273f855940f 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -803,6 +803,11 @@ extern int scsi_host_unblock(struct Scsi_Host *shost, int new_state);
 void scsi_host_busy_iter(struct Scsi_Host *,
 			 bool (*fn)(struct scsi_cmnd *, void *), void *priv);
 
+static inline unsigned int scsi_max_nr_hw_queues(void)
+{
+	return blk_mq_max_nr_hw_queues();
+}
+
 struct class_container;
 
 /*
-- 
2.40.1


