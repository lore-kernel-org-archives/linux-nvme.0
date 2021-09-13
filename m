Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B7AAC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 16:08:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33A4360698
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 16:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 33A4360698
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RAV5FI/OUz6Yu1F7sE0e3vw6V5UGwHb4BEmZrwUtKd0=; b=ZZA3lkliCZp4Xv
	f2tIcllLJdtOjgJ2IpyWbZ1tQ01WitlBTV5p66+N1h/96w8LDAMxu5ppAFT6CEmEip9zisjlSyKPF
	3IvAbS3gYrnkbLr3bAp7JodU8fpCCTZZLU+qdzEnGWq5s+IuJwTIUM4YwrciEG+wmjGalyUZyOtMY
	7pIsyv9uO9QQ3KJrXUZz4PFa3jV6mVTXGLo0gS/S6PbPNSgKxqghOCuv4keqnmml6QEj23vHBaFt/
	Mce1cc/DXk9/MUsYFzV9ZGY2fo4oju1fl5l5kKQdN53Hh9eyGry7azgwehNKzupJjxz90ElBN+m/f
	ZQs7onoZsePnFZnXf2sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPoV0-002IO8-OE; Mon, 13 Sep 2021 16:08:02 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPoUx-002IN2-Nc
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 16:08:01 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 99F1C60698;
 Mon, 13 Sep 2021 16:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631549279;
 bh=Zj8kWyT5LA/5eUEEYeKgJX6H2julvbJnx1p5ZWqQAdc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ERLkyeYWRCkWT+EvinG5yEatP0E2SDBrmBrFt6BfUTP5OGlQfJ8dGWzb5uADksW5V
 nFHAeOu/8C2QF8YByYlCVONeJz2KNYcHhEXeZzeZrdPo9msSRbW1EQx8MBnyYaE3dO
 gnhR1JdrFeKLnv9hRs89yd19MWhY7A/mcCV57L0Kd2/0eKpj27Vejk1lVNzk/s0M3s
 cXU+noOfh8FaH1SGJaFUQc3UhqNKumIJBN6uKJB6/+A4+RtkdSaXyyMp5vRSHvdjO8
 m/iJIEq6wBeUGmqeH+TSrbL2jp4Y8kzDIMLkESyhdBghfQ74QjKaFi8p9la8VoYGqd
 DmqDtYC9V3p3g==
Date: Mon, 13 Sep 2021 09:07:56 -0700
From: Keith Busch <kbusch@kernel.org>
To: Anton Eidelman <anton.eidelman@gmail.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
 axboe@fb.com, Anton Eidelman <anton@lightbitslabs.com>
Subject: Re: [PATCH v2 3/3] nvme/multipath: fix stale ana state for
 namespaces just added by scan work
Message-ID: <20210913160756.GB3283786@dhcp-10-100-145-180.wdc.com>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
 <20210913153023.70879-4-anton@lightbitslabs.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210913153023.70879-4-anton@lightbitslabs.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_090759_842765_86F0F8FF 
X-CRM114-Status: GOOD (  19.02  )
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

On Mon, Sep 13, 2021 at 09:30:23AM -0600, Anton Eidelman wrote:
> Scan work initially adds new namespaces to ctrl->namespaces TAIL.
> They make the list unordered temporarily until nvme_scan_work()
> finally sorts the list.
> 
> In case nvme_update_ana_state() runs while the list is unsorted,
> the recently added namespaces are missed and their ana state
> may remain not updated forever if timing between scan work and ana work
> is unfortunate, e.g.
> Initial state: namespaces = {2, 3}
> scan_work: adds nsid=1: namespaces = {2, 3, 1}
> scan_work: finds nsid=1 is still Inaccessible
> ana_work: log page has nsids = {1, 2, 3, 4}, all Optimized.
> ana_work: updates nsids {2, 3} but fails to find nsid=1 in namespaces.
> scan_work: adds nsid=4: namespaces = {2, 3, 1, 4}
> scan_work: finds nsid=4 is Optimized: sets it live.
> scan_work: completes an sorts namespaces = {1, 2, 3, 4}
> Result: nsid=1 will remain in Inaccessible state.
> 
> Solution:
> In order to preserve the way ctrl->namespaces is updated and sorted,
> make nvme_update_ana_state() deal with the case where ctrl->namespaces
> is not fully sorted and has new namespaces appended with potentially
> lower nsids.
> nvme_update_ana_state() keeps track of the nsid seen in the list,
> detects the unsorted case (rare), and restarts scanning of desc->nsids.
> 
> Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>

I guess this works for the structures we have in place, but I think we
should replace the sorted list and with xarray. Then you can get
something simpler to follow like:

---
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5d7bc58a27bd..2b4bd624bded 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -595,21 +595,15 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	if (desc->state == NVME_ANA_CHANGE)
 		(*nr_change_groups)++;
 
-	if (!nr_nsids)
-		return 0;
-
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		unsigned nsid = le32_to_cpu(desc->nsids[n]);
+	while (n < nr_nsids) {
+		unsigned nsid = le32_to_cpu(desc->nsids[n++]);
 
-		if (ns->head->ns_id < nsid)
-			continue;
-		if (ns->head->ns_id == nsid)
+		ns = nvme_find_get_ns(ctrl, nsid);
+		if (ns) {
 			nvme_update_ns_ana_state(desc, ns);
-		if (++n == nr_nsids)
-			break;
+			nvme_put_ns(ns);
+		}
 	}
-	up_read(&ctrl->namespaces_rwsem);
 	return 0;
 }
 
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
