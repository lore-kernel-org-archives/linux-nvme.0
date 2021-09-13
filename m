Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E7AC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 15:31:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FE0460E97
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 15:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5FE0460E97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pjWm+fxkgSdwJt+riuiH9W6zgiHQ86vmTyZnmTq1zZ8=; b=1glORw5P9e3LS+
	+KlhrM5a2VYpyC2fIJbPvBQZwKv97k+tT1r1NmZFXi3JUSq9YToB5L4mGAI/TG395kQH2tEIpp0sz
	nbF1u35evha5w4P7qI08H6GQzRHOeyOoIKn1ieuRI2YNwU5xyQc0gYBkXIIpE+LWMVtE5oToGO51L
	QdpCrSERqNfnUhvxue/AGk3M/bFpYSMwiN/RohT/x1+F8Y6gRAXfoTmdF5LSTiI5RE/czBUpDCijc
	jv5DnC4Qtq4unuO/xucAfoNf6CdHyJiku/PeEnV96P9tpVlNBdln9gEcOotyJ1MYhO2wCL9Op13kC
	xWFh0bQtfQF3B3Ff3NBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPnvh-002B1Q-Hm; Mon, 13 Sep 2021 15:31:33 +0000
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPnvJ-002AwY-2P
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 15:31:10 +0000
Received: by mail-wr1-x42d.google.com with SMTP id i23so15367920wrb.2
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 08:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eC6MDNaB+TgrIQUmQbMFlP+hIVhngD4zP9Dgm0A8t3k=;
 b=f6zsrxwNVKiye5gvjLLsJW66Xx/M4cEd/g0OdCvAZWPirLSfkc5zwUY1z5B5bCXXzt
 ETV8EuZGQiZB2itRARXo2hIZaZH1+cXSHEmuVN2qwUKaNzvARJ0YdmdfyE4Kv+YtM9fp
 RIpdvmSn6xBVi3OmGr1WTTymemWG+ZWTfKA/8u+4Vgy5vxkUgwSf7uZeTsSXL2QO4Fbw
 Xe65QqpnnlgFttyF/Md+bJqqm/j5/Kgqnft0sRsxXBqbV7bTCcr7pqlNHBtTjoplFaQO
 JTMiKq+MlnMN/oWymiNF604TNDBJ5y6nfdRKvspPYDduvlZCD5OuVnrysh6oyxR/T5iM
 M6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eC6MDNaB+TgrIQUmQbMFlP+hIVhngD4zP9Dgm0A8t3k=;
 b=yQ3EGUui8ZZfmyCGKA7cVZfSCoMCE/yU7ZcrTDMuJRFhLjyZlDk64ca8HSGNcroids
 wBPdDW7DCwk4fKbngymPP6veL1US/qM7t3F4o1lrlygzJyGlHhFJ6VtTk3YsZkEF/QRM
 m3PHDsGiUlxc3re5llfphlUT6QlrBhv53aqDY5n3SjfaB3cdtkyqpEArsP2u3Pe47A4i
 Qds79OmiZtfi3WPTkJB1MYLQwNZXgB9zHBlX53x0LnsJVauZ7SsSQuKhS2mH4sfeG7gZ
 0N8KApBZSEiFwxcDcFdX7YUi3AtG9uPbU12wT0tH3/iZWl7ZcHWknar3nP/NyUjcAhCn
 AXqg==
X-Gm-Message-State: AOAM532Bzg3BAIVXmhtQGrwqPQn8tH/62V6t29NM+AKis/Zs5Z8hVVZd
 TAOncLvibZGcEq2yYsPjYQKi3ZWqBdG9Zw==
X-Google-Smtp-Source: ABdhPJz+IARtZQXBTvO9hzT1Z0rPWPvV4Q78m/NoNLUvpGk1hdQqRBWcsZt5RlIzwoWzgMxdj5LR9g==
X-Received: by 2002:adf:8144:: with SMTP id 62mr13459840wrm.144.1631547067442; 
 Mon, 13 Sep 2021 08:31:07 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id h8sm7054087wmb.35.2021.09.13.08.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 08:31:06 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v2 3/3] nvme/multipath: fix stale ana state for namespaces
 just added by scan work
Date: Mon, 13 Sep 2021 09:30:23 -0600
Message-Id: <20210913153023.70879-4-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913153023.70879-1-anton@lightbitslabs.com>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_083109_153014_026B16A9 
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Scan work initially adds new namespaces to ctrl->namespaces TAIL.
They make the list unordered temporarily until nvme_scan_work()
finally sorts the list.

In case nvme_update_ana_state() runs while the list is unsorted,
the recently added namespaces are missed and their ana state
may remain not updated forever if timing between scan work and ana work
is unfortunate, e.g.
Initial state: namespaces = {2, 3}
scan_work: adds nsid=1: namespaces = {2, 3, 1}
scan_work: finds nsid=1 is still Inaccessible
ana_work: log page has nsids = {1, 2, 3, 4}, all Optimized.
ana_work: updates nsids {2, 3} but fails to find nsid=1 in namespaces.
scan_work: adds nsid=4: namespaces = {2, 3, 1, 4}
scan_work: finds nsid=4 is Optimized: sets it live.
scan_work: completes an sorts namespaces = {1, 2, 3, 4}
Result: nsid=1 will remain in Inaccessible state.

Solution:
In order to preserve the way ctrl->namespaces is updated and sorted,
make nvme_update_ana_state() deal with the case where ctrl->namespaces
is not fully sorted and has new namespaces appended with potentially
lower nsids.
nvme_update_ana_state() keeps track of the nsid seen in the list,
detects the unsorted case (rare), and restarts scanning of desc->nsids.

Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/multipath.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a51561d67b93..0a50439a8c41 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -587,6 +587,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	u32 nr_nsids = le32_to_cpu(desc->nnsids), n = 0;
 	unsigned *nr_change_groups = data;
 	struct nvme_ns *ns;
+	unsigned int last_ns_nsid = 0;
 
 	dev_dbg(ctrl->device, "ANA group %d: %s.\n",
 			le32_to_cpu(desc->grpid),
@@ -603,6 +604,11 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 		unsigned int nsid;
 		unsigned int ns_nsid = ns->head->ns_id;
 
+		if (ns_nsid < last_ns_nsid) {
+			/* Unsorted ctrl->namespaces: re-scan desc->nsids */
+			n = 0;
+		}
+		last_ns_nsid = ns_nsid;
 again:
 		nsid = le32_to_cpu(desc->nsids[n]);
 		if (ns_nsid < nsid)
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
