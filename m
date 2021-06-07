Return-Path: <SRS0=yMBa=LB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81DCC4743C
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 09:17:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CF6561002
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Jun 2021 09:17:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CF6561002
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tKeh8rvm8AwOYgVRVH/qgHgBVxOphFZaaL+0OlPREz4=; b=wxKoQQt4tploUN
	IUXE/0NYaQIXnoxODZxW0FIEUJGvLcEHPqIiwmSukbGju2UiISFhWSHXg4hiFmpEj6wOTdcrmUUQS
	+UpuZxJFzRU6ntCVU1yiTIVglVq9eYgCiAbLpPP4mC8q6hhbC0XGpsgVf9KHRzICoqBAMiHLC/tOX
	KeYOUhq8KcEykICEcrksGpofIjBONo7GJs7pghdUPsePAoGse3tgWzRCNzhK/CAFn/CXJJx0TjoXX
	E6SRx1ud6jk500Z6eSYID7UKDLRBYaFfS4mWf0nguSvYiOqxlzQh6xpJVqmVSvbZqIHpnDXQ6etNy
	lQB86IUYwv8S6orweVxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqBNV-002Wqs-Ks; Mon, 07 Jun 2021 09:17:01 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqAuc-002Op8-AF
 for linux-nvme@lists.infradead.org; Mon, 07 Jun 2021 08:47:14 +0000
Received: from relay2.suse.de (unknown [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id DD2D31FDCA;
 Mon,  7 Jun 2021 08:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1623055626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bY05Mseh+Z7yupujGt16kI/m6VhGcN21TuE/soNSij0=;
 b=Xtd5QDsZ6Xo0ZNyuaWmUA6vNGTR9EHvEN3QvKa3D+8LJGOrHxn+iKm55b8vjJ5jPaAC25O
 FRhRQC2Ox+ijbB9uOLmTWMim4ZuLFohkhLQP+Bn6CROkNN6Zxb0bqhYuBiyPhU68GqCAY1
 NIePpYONax2W5/UEWg0chkaZxH96Cdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1623055626;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bY05Mseh+Z7yupujGt16kI/m6VhGcN21TuE/soNSij0=;
 b=cD1VWJJ7An9KsTkSW3/LLpn2ABFQMMaYVUQlKUTyJMfuxKX/fk1iCh2HOt5cmoq0wsb8Fb
 snwaLOOwGcdku5AQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id 1BD1FA3B8D;
 Mon,  7 Jun 2021 08:47:06 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 17828)
 id 0C3A9516FDEB; Mon,  7 Jun 2021 10:47:06 +0200 (CEST)
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3] nvme: remove superfluous bio_set_dev in nvme_requeue_work
Date: Mon,  7 Jun 2021 10:46:51 +0200
Message-Id: <20210607084651.99122-1-dwagner@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210607_014710_536409_58A54FF3 
X-CRM114-Status: GOOD (  12.46  )
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

Commit ce86dad222e9 ("nvme-multipath: reset bdev to ns head when
failover") moved the reset code where the bio is added to the
requeue_list for the failover path. But it left the original
bio_set_dev in nvme_requeue_work.

There is a second path to nvme_requee_work. It is via
nvme_ns_head_submit_bio. Though we don't have to set bio->bi_bdev for
this path either, as it points to the correct bdev already.

Let's remove the bio_set_dev. It's updating the bio->bi_bdev with the
same pointer and thus it's unnecessary.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

v3: - dropped bio_set_dev from nvme_ns_head_submit_bio
    - renamed patch
v2: https://lore.kernel.org/linux-nvme/20210603072537.GA4718@lst.de/

 drivers/nvme/host/multipath.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 127a17b4c13d..a501917d4c6e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -435,11 +435,6 @@ static void nvme_requeue_work(struct work_struct *work)
 		next = bio->bi_next;
 		bio->bi_next = NULL;
 
-		/*
-		 * Reset disk to the mpath node and resubmit to select a new
-		 * path.
-		 */
-		bio_set_dev(bio, head->disk->part0);
 		submit_bio_noacct(bio);
 	}
 }
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
