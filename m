Return-Path: <SRS0=Gd08=O5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BD9C433F5
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Oct 2021 03:48:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8325260FD7
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Oct 2021 03:48:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8325260FD7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UOc1fImJwUHs+qtYI5w62WF8DJkF6FY8xGlvPOA1DYA=; b=iOB/bMlF1Qwgng
	dRPmmAAZnONFq9l4omISZjszMU783LSvR5p0gK1iaxStnIG1CJb8rOTTlX3+wcfuLyReMWedhypb9
	HHbHUZuMS3kjCU5/i13FPQCxvCOT3pZQpQpYA23ho05rsGh4KMB8ajC49Y4EGz/rnDw21QGvFBEwj
	iKfeGGG7C7wtaeFQKOIOjIoS8USHfurBt9DsNd7HqInX+cpsB6gStXj64R4JIngcFLRpRIV14T1gM
	Zi5AFxlfF3TfUBCI1gKiR/pFIEGt5ZA9BlZo3yct5Spi8fIIWsJSMiCpFojQ9RN/a8EPWLTz5v5Hh
	PvvqfA2/muRd4JdVhgJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mZ3Lq-0052He-Md; Sat, 09 Oct 2021 03:48:46 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mZ3Lc-0052B6-1e
 for linux-nvme@lists.infradead.org; Sat, 09 Oct 2021 03:48:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633751311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l2LFQq71dqWB0MJ8/20HA9VFLVcxA/IdZ6Nqm+rYqvg=;
 b=UsSkYDosMAK8OMn5vN8+W7JvPJeS7EnrjZn9vOad1HBmMgmyauaprtFWA9hm95jzsrGMjR
 wmxgaUS0/hw3vHl/LcT1LBTch7UXrP/ceD67FxJyeMzAvZldJlUS/wcwC3KcFftfjTGZWk
 NyM0HaPeA/YgiEOQf5IHyIL0GMzf9XE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-7NVxqno7OwOLoUegGtotBA-1; Fri, 08 Oct 2021 23:48:21 -0400
X-MC-Unique: 7NVxqno7OwOLoUegGtotBA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80183824FA6;
 Sat,  9 Oct 2021 03:48:19 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3F2DD5FC22;
 Sat,  9 Oct 2021 03:48:15 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 5/6] nvme: loop: clear NVME_CTRL_ADMIN_Q_STOPPED after
 admin queue is reallocated
Date: Sat,  9 Oct 2021 11:47:12 +0800
Message-Id: <20211009034713.1489183-6-ming.lei@redhat.com>
In-Reply-To: <20211009034713.1489183-1-ming.lei@redhat.com>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211008_204832_201415_FB02ED98 
X-CRM114-Status: GOOD (  14.78  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The nvme-loop's admin queue may be freed and reallocated, and we have to
reset the flag of NVME_CTRL_ADMIN_Q_STOPPED so that the flag can match
with the quiesce state of the admin queue.

nvme-loop is the only driver to reallocate request queue, and not see
such usage in other nvme drivers.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/target/loop.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 440e1544033b..eb1094254c82 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -384,6 +384,8 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 		error = PTR_ERR(ctrl->ctrl.admin_q);
 		goto out_cleanup_fabrics_q;
 	}
+	/* reset stopped state for the fresh admin queue */
+	clear_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->ctrl.flags);
 
 	error = nvmf_connect_admin_queue(&ctrl->ctrl);
 	if (error)
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
