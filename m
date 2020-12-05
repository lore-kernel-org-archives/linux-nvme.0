Return-Path: <SRS0=fl3Q=FJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15903C433FE
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Dec 2020 15:30:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A12222B37
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Dec 2020 15:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A12222B37
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZfCxCStQEiIS6vczlDopWtH7eJB1FfRCaYwr+7HXx24=; b=Kb2/lKxPOEnOB5FpqnuoolA96g
	wrN2KmTF/2uDDcXmADgtshbuUBaRag91VMyii76W0C2ncMx+fdRCBDdkjhCyLdFf1sUESBlHfsKng
	apEnMpYZX28O3tLsbUhvAfpdBO5TQUaGGr45cIAg/urRY9Z75gukCnMlxk0QFkaSpinR/bxkWEKaW
	x7alzMP1WaJ3vEkUs7r7IgBY56nbULpr8i1c2nFsRx6C3ux3ZY+RA5XNpnQAK85KeLDtgNdkjeti/
	savmya5GmPscIwr57pEQGi/FspxrdBYnQazxnVvQ177YXFH5USTE3bNa5alB3ErZVoFSkpn1KuhSe
	ckbJP2PQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1klZVO-0005JV-AP; Sat, 05 Dec 2020 15:29:50 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1klZUh-0004nZ-LG
 for linux-nvme@lists.infradead.org; Sat, 05 Dec 2020 15:29:09 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EDF44AD07;
 Sat,  5 Dec 2020 15:29:02 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH] nvme: retrigger ANA log update if group descriptor isn't found
Date: Sat,  5 Dec 2020 16:29:01 +0100
Message-Id: <20201205152901.56665-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201205_102907_856598_74F9E44C 
X-CRM114-Status: GOOD (  13.49  )
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If ANA is enabled but no ANA group descriptor is found when creating
a new namespace the ANA log is most likely out of date, so trigger
a re-read. The namespace will be tagged with the NS_ANA_PENDING flag
to exclude it from path selection until the ANA log has been re-read.

Reported-by: Martin George <marting@netapp.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/multipath.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 74896be40c17..ee4a42dc99a0 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -667,6 +667,10 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 		if (desc.state) {
 			/* found the group desc: update */
 			nvme_update_ns_ana_state(&desc, ns);
+		} else {
+			/* group desc not found: trigger a re-read */
+			set_bit(NVME_NS_ANA_PENDING, &ns->flags);
+			queue_work(nvme_wq, &ns->ctrl->ana_work);
 		}
 	} else {
 		ns->ana_state = NVME_ANA_OPTIMIZED; 
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
