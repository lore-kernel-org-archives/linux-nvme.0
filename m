Return-Path: <SRS0=KW0X=MA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6138DC07E96
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 09:28:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DAE661983
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jul 2021 09:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAE661983
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9adTnvR94mgvXQU3yF5iK26wCxyYWzkAAKeZRa1rXc8=; b=N7i+umBQC/hgiv
	u2asTDBHTfwEf/CHmulqoKI3GF2z8aFqrHhU9s8xGYLPWx+TdryyJTLR4icAe1nmUbu9BtVDvmTNH
	1RtFy/eT1gNbpHa9Uq1YNTlDXSxRz4+KyRq72+W/6fgdsWaLTxa15bZwKuR22B6S2At3vWlzXCGjM
	hdKX1jZO8BYGST1yLRVM6e+By4zxg/i6TZunGjO+QHaWv/md6GjntMAfMLjuTIyUdCX/ZZTIM3BA+
	RHxoqsBdk2tC0AgeiGKzhIcboLG9d3TUVtPlCXQxJGmhJOshjdfIFlMSSzib3WmYCtwEUfqTop29A
	VXwQ5FRtKQMuUE6tsTXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m1QKp-00GR1d-Qy; Thu, 08 Jul 2021 09:28:43 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m1QKJ-00GQp5-Jd
 for linux-nvme@lists.infradead.org; Thu, 08 Jul 2021 09:28:14 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 7603421FAA;
 Thu,  8 Jul 2021 09:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1625736488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l81TcQcEiPKe4gM3TQv02D1ncgjljmX/9B8BQR7UWLI=;
 b=NZaTPneCcMj+dF+qGEacb0tHKXeQkFDmgxh0Le5B5Nxn4pRdgHWYavPW8H4tGwklDAMocn
 oZCQBlVUZBq9icXLbYC1c0nGrta/9kuCV9FVwEhz//Tzfsz1YaPF6xHkq0h6Ie6tCRFl4y
 yR3Cqn+KrrgV3EYKCjhfg7aOVltYAgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1625736488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l81TcQcEiPKe4gM3TQv02D1ncgjljmX/9B8BQR7UWLI=;
 b=g0z/l+1gS+anvJDWnEp4fN0+omGHZuUywQ+axMrmYVOFavfhyJzNtLIukirwsvNShtQX4S
 BbaDqwTSn3zG5+BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 6DD9CA3B88;
 Thu,  8 Jul 2021 09:28:08 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 6705B5171154; Thu,  8 Jul 2021 11:28:08 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Ming Lei <ming.lei@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 5/5] nvme-fc: Freeze queues before destroying them
Date: Thu,  8 Jul 2021 11:27:55 +0200
Message-Id: <20210708092755.15660-6-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210708092755.15660-1-dwagner@suse.de>
References: <20210708092755.15660-1-dwagner@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210708_022811_825866_DBECEE1A 
X-CRM114-Status: GOOD (  10.50  )
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

nvme_wait_freeze_timeout() in nvme_fc_recreate_io_queues() needs to be
paired with a nvme_start_freeze(). Without freezing first we will always
timeout in nvme_wait_freeze_timeout().

Note there is a similiar fix for RDMA 9f98772ba307 ("nvme-rdma: fix
controller reset hang during traffic") which happens to follow the PCI
strategy how to handle resetting the queues.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8e1fc3796735..a38b01485939 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3249,6 +3249,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 		nvme_fc_xmt_ls_rsp(disls);
 
 	if (ctrl->ctrl.tagset) {
+		nvme_start_freeze(&ctrl->ctrl);
 		nvme_fc_delete_hw_io_queues(ctrl);
 		nvme_fc_free_io_queues(ctrl);
 	}
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
