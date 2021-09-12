Return-Path: <SRS0=sv4i=OC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86778C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 01:09:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4950D61041
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Sep 2021 01:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4950D61041
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightbitslabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xM+yWMNhdBZLq75zoWoShJzOCaQ2X/Inva8m054T7to=; b=M8t7IIgHT2Ql6/
	cgUhW3cBbdgF71jVWtxF/Ea+S7COimz7eeWbw9qmxxEPAHh/pgiSA/2hOSuVbF/yn2PqETzX1FYGZ
	dgVjZK9XKYhbOejBN3JXyBrk6m9k26bpGwlUDzJlzd6MUs/XXDRDZ/YuLhbCPMWy8FnbeK/SI0DMf
	Fp+UDVqHMpWfxR4uGDaT4rmzTOvgr3ecwyORhXONANF0TXD4Tp7m4uQb2YaPSIK/OLrJsrkM9492t
	R8WrPRi+wX35ZWDMML0nKHLr9Nkm0CNmc1Z/Zaftfna2+tqUlh7pyX4VVVF0QKtoRcni922yBSOvt
	0MvKzedJKANXOWlx52Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPDzJ-00Fely-Tz; Sun, 12 Sep 2021 01:08:53 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPDz7-00Fek9-JR
 for linux-nvme@lists.infradead.org; Sun, 12 Sep 2021 01:08:43 +0000
Received: by mail-wr1-x42c.google.com with SMTP id t8so3558596wrq.4
 for <linux-nvme@lists.infradead.org>; Sat, 11 Sep 2021 18:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=lightbitslabs-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version; bh=HdYtVFK1ptSkzbeUM8W9DQmVJzi1r2u8BM+IevioTdw=;
 b=FBRoX/0tFruwl1RGKKun4hY8OT9laR02U1xD/vuqTnvOC3f6lFwl/lvoAx970Dxg3E
 g6g4zCTcnCYlqB8VQ6MyD0ArWRZ0Y3SIJx8jeMW/N7bCHHEst5YiUcfOqd+dS/DfGOA9
 LXdm90apDqy4kLZBNLQ2lYZh2ue6gMfe5zbRNqPnvofeLNtZU4jF9CXiiLUDCIXCuA0P
 IK+eo9Bt1hxpE7fkn9IQAV4l5h863jOX3T+DObTcIDXgzJMmNOsa1sVXLjmK9hlBod6p
 Lp9+19STq7sCHQSWgPjJ2tV8e1D+2WzT1NUSnrYVb7QJ8uMM2dP7Wc+CXw0UhpAVCEuO
 p9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version;
 bh=HdYtVFK1ptSkzbeUM8W9DQmVJzi1r2u8BM+IevioTdw=;
 b=AA848jlJbYHjmPVXRKCW3iJNaFR3PDf3lBGNUNRPX8Lk5b90FW/PtV7RKISj9mBWyB
 QYz4Ue9z7TTXmO+MUjhwaON7gnNgViWCDRhFEiPhbKcfR8dgOhXE3sEaJ4mrHZlUCJOV
 nB0z9sAsZ5yzfHLdBQJ+QAzEm0ZlJx+yhltY06RVBP7z3yxhoFo8bOTB31Z4hTNahGM5
 wsheGwaKC6Rjm9pXc2sDZi7tMpzFL9zsi4610FfKyomyR4kK4knqfiA+SADgbPymqd27
 Q2sXEifGjB5wrCdajQ8gm6Gc/084xS0HEftwmGVg94Taktxje3nr8p9HYGvfmTWIXI4y
 ambw==
X-Gm-Message-State: AOAM533HajxrTvR6N8UPTv04CT0nuIpMhQ+fJXsy5lRduApxvC2t2Usy
 VA8o+P3pZi/blaYj/nJfgaSu97ToG4NPMEpIYtTVL1YOcrNgsJns9hOM4ufn3krmTf7fqbEPQ6P
 bSC6ye7I3nsbcPTl/DVcn3Y5mg2iF
X-Google-Smtp-Source: ABdhPJzZUNCJhlfnzkUiac5jBxV4iKOfv6NOfkCEY4H/GEsvCNLNgP19gwnPimxsf1igExvUcw7MFw==
X-Received: by 2002:a5d:4b50:: with SMTP id w16mr5179390wrs.71.1631408919920; 
 Sat, 11 Sep 2021 18:08:39 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id h18sm3128922wrb.33.2021.09.11.18.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Sep 2021 18:08:39 -0700 (PDT)
From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH 3/3] nvme/multipath: fix stale ana state for namespaces just
 added by scan work
Date: Sat, 11 Sep 2021 19:07:31 -0600
Message-Id: <20210912010731.471859-4-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210912010731.471859-1-anton@lightbitslabs.com>
References: <20210912010731.471859-1-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210911_180841_685831_8F2468DE 
X-CRM114-Status: GOOD (  13.84  )
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


-- 


*Lightbits Labs**
*Lead the cloud-native data center
transformation by 
delivering *scalable *and *efficient *software
defined storage that is 
*easy *to consume.



*This message is sent in confidence for the addressee 
only.  It
may contain legally privileged information. The contents are not 
to be
disclosed to anyone other than the addressee. Unauthorized recipients 
are
requested to preserve this confidentiality, advise the sender 
immediately of
any error in transmission and delete the email from their 
systems.*


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
