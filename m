Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF6CC433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 09:54:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0DED61056
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 09:54:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0DED61056
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ShoCShIoD7LxcSkZju3C/2kFus++KNLFTT4/tppSG2s=; b=l3s6n40yfgdsThm8jmoWGZMXW
	7QPOFno4T3VMc9SM1GGV/21St5IeSEQBRJ42lboqub1NW+5BT+uK/8YTvXy4nzshHvUqAvjs6St72
	m6MNUIPDpCS+lwNNws1yOQb6ciP+9UODIlaUAFeN3a1Z7Uo48AS4KASS+Kkc4zmMBWxMHt/sosweA
	kMQOR2RUqGH+xInDPqL+pT29xGODl21mNTPc0fBGnol1/hRBDNgJSAsTlpDtqT4abxJJNXtp0zKSJ
	lnrfbASJuy67a3c78Q9yQEhAcro6MmC79QKWNDT5LvHh3pUfS9Gsum5TciIB0mwoh6x0wBvkU5OUc
	gQ/hK90gQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRu24-0098Yy-SW; Thu, 01 Apr 2021 09:54:32 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRu1t-0098Wj-Bc
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 09:54:23 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9F99AAF26;
 Thu,  1 Apr 2021 09:54:20 +0000 (UTC)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 2/3] nvme: Remove superflues else in
 nvme_ctrl_loss_tmo_store
Date: Thu,  1 Apr 2021 11:54:11 +0200
Message-Id: <20210401095412.84254-3-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210401095412.84254-1-dwagner@suse.de>
References: <20210401095412.84254-1-dwagner@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_105421_565694_4EDAD06A 
X-CRM114-Status: GOOD (  13.19  )
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

If there is an error we will leave the function early. So there
is no need for an else. Remove it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b94a30e7298d..d2b4c5567209 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3659,7 +3659,7 @@ static ssize_t nvme_ctrl_loss_tmo_store(struct device *dev,
 	if (err)
 		return -EINVAL;
 
-	else if (ctrl_loss_tmo < 0)
+	if (ctrl_loss_tmo < 0)
 		opts->max_reconnects = -1;
 	else
 		opts->max_reconnects = DIV_ROUND_UP(ctrl_loss_tmo,
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
