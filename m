Return-Path: <SRS0=sv4i=OC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49F96C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 18:56:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BF6A6058D
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 18:56:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0BF6A6058D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pk9SYIcWmnkSwsmEt953UGJL8BtEmfYG4x4W+PmqLms=; b=1iKfNF9ZIp3ABv
	6sm6EWBzoH0nAdUTxCckMeLFyIL+XlMHF4quf9sI7pNsCXpuwz60Gd/EbC5f/R1OzgbLqPnKE4m4i
	STbViIcE7XNHmaO9Weja33DBqgJcdk18m7guUBGuUYxrD105m96HLkcb1udXHSjKpOMM0nSNlIaxd
	LJnRsqD9k2aViyblLcejCbYszj0wwdME6zFvWvM6g1MajCf8gO8QxuuhGLWhiBItzigC4ciXfGWp6
	LJK+pnwA8gOPCe3ZAXfLBUEEBw7xWu2NfmpaCvbv9RAGcZMcLThWY5LhKyuE4G/AMjXohlV0snb0M
	KWynpv2ziY+XRUXtdZgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPUe4-00Gy2Q-2i; Sun, 12 Sep 2021 18:56:04 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPUdR-00GxrU-I3
 for linux-nvme@lists.infradead.org; Sun, 12 Sep 2021 18:55:27 +0000
Received: by mail-wm1-x329.google.com with SMTP id s24so5040195wmh.4
 for <linux-nvme@lists.infradead.org>; Sun, 12 Sep 2021 11:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=k/A7huC9EPdQyaBAXOONIGj5mrpMsYyH9ME7mDw0yMc=;
 b=CxoU7v6kK+tXU54ms9O51FNd+D1kv86r+GFIj4oUKcQGdBUEQmi0N2KcdlCvceF27E
 HzY7v7FRh/9Wrtge/RAFtpJTzpJuMqUIbCgBdRR6+5sMHJR0MqnM2VTDHG8PdzfhwsZf
 vhN7+nyn6Tx3ozULvhESkf+jlDVVNfH445wLbsIILVpWVFyXRKpKKBbmo8vzf7KWbeiw
 fsIXL7iNMgdCzpODdU0bjCCv8wzngxw742t25mA93E1MAAtdB+gy3xMz5NEr6fh/dWGJ
 VyfG9+xzrPbQbJWzwxDe5shjHYQN2u3Q5Y/BbLFuPeAafdtIFiVe8d2XqQcyy6Am1PZq
 tcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=k/A7huC9EPdQyaBAXOONIGj5mrpMsYyH9ME7mDw0yMc=;
 b=mGL+X/VQM3JjqIZPa/kaA5a7r7K6QjmvipeMOcGbVR3Pqmu6Le0eIdifxbn5lLsAMp
 xYGlN4OCR139OPcVyS0HqfGGVrq3AUJhuky9KXuaxdpsaF6azWi1MfqRXBTgC/Ft4yT8
 NkBAAQA7nWhYlnfGQq40fS+uM7YsUGyNToWe/NAv687YHf1hls7zYni3alTYHRPMuqSX
 Q3tpjJ3mgGFoaYQZ3FW02wAZbPVDPh8h/J6sEKaAzONofi9HKq8TwMa9o1IcCDVgswoa
 F3dqMJCX2ewporRxTfi85fIhZPUNLJ8vg0GIzO6x+JOC8GtmnQjk+/Ip2PrmOZ7xmipM
 PnVg==
X-Gm-Message-State: AOAM532ryF8aaihEUhZHSj1EWHmOe1GnB3wnX9CL6A3h9E/RrC7aNOAP
 yO1sg9D6TdNBrREoJXdPrMTW3ReS+Puq8g==
X-Google-Smtp-Source: ABdhPJxfu2qsR8et/PmyG5WDoqJpDkEbQtk2brbxyTMBo136/O/hCIVwkxNE6qG8Ae7WR6JbWZMOvw==
X-Received: by 2002:a1c:1d42:: with SMTP id d63mr7961495wmd.55.1631472923823; 
 Sun, 12 Sep 2021 11:55:23 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id s15sm5196974wrb.22.2021.09.12.11.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Sep 2021 11:55:23 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH 3/3] nvme/multipath: fix stale ana state for namespaces just
 added by scan work
Date: Sun, 12 Sep 2021 12:54:59 -0600
Message-Id: <20210912185459.13496-4-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210912185459.13496-1-anton@lightbitslabs.com>
References: <20210912185459.13496-1-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210912_115525_650862_7655EF7E 
X-CRM114-Status: GOOD (  14.50  )
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
index a51561d67b93..1ad8dc8adb86 100644
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
+			/* Detected unsorted ctrl->namespaces: re-scan desc->nsids */
+			last_ns_nsid = ns_nsid;
+			n = 0;
+		}
 again:
 		nsid = le32_to_cpu(desc->nsids[n]);
 		if (ns_nsid < nsid)
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
