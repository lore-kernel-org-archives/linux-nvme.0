Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95FA5C433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 13:13:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61FE820706
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 13:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hd618ZKD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61FE820706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wHMDcpNJ+5Hja8gM9j9nKo+sGji/D0WNEDCCmIORfXs=; b=hd618ZKDYE/jtBbdyNsO96p5/
	87z6Fj01tT38jagfZr62MeCFglrBGJr2XC34hYdeUj0ass1mUp5aOfeSWyieHZeBPfnt6pMetNae7
	uj5pAzpOE07e06B3fdo38ZKSEmxJEM6TyiBsXh1nVasBLrJd6ro+0NXvNPpWSen0dp0z/tDKTBNPE
	0igYwO87B8froQcnIopFcGEkd4elQB2cEHTMNdY/kbg/Kainsi946GMxyGFVhMz4FzuHOdmg/DHjA
	z2QT+9W+P0Dyclfs5RHZ2xSnXDj59gnHzR2WbLRy/rVUKCBKFxWOQHvttLBtNthakDZt/zUL1bikK
	0TCuyFKgw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k81Qo-0005qI-MX; Tue, 18 Aug 2020 13:13:38 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k81Qk-0005nu-SZ
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 13:13:36 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 929A8B17F;
 Tue, 18 Aug 2020 13:13:59 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, open-iscsi@googlegroups.com,
 linux-scsi@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: [PATCH v7 5/6] scsi: libiscsi: use sendpage_ok() in
 iscsi_tcp_segment_map()
Date: Tue, 18 Aug 2020 21:12:26 +0800
Message-Id: <20200818131227.37020-6-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818131227.37020-1-colyli@suse.de>
References: <20200818131227.37020-1-colyli@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_091335_103195_E4BDA54C 
X-CRM114-Status: GOOD (  16.30  )
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
Cc: Mike Christie <michaelc@cs.wisc.edu>, Cong Wang <amwang@redhat.com>,
 linux-kernel@vger.kernel.org, Coly Li <colyli@suse.de>,
 Chris Leech <cleech@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Lee Duncan <lduncan@suse.com>, Vasily Averin <vvs@virtuozzo.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In iscsci driver, iscsi_tcp_segment_map() uses the following code to
check whether the page should or not be handled by sendpage:
    if (!recv && page_count(sg_page(sg)) >= 1 && !PageSlab(sg_page(sg)))

The "page_count(sg_page(sg)) >= 1 && !PageSlab(sg_page(sg)" part is to
make sure the page can be sent to network layer's zero copy path. This
part is exactly what sendpage_ok() does.

This patch uses  use sendpage_ok() in iscsi_tcp_segment_map() to replace
the original open coded checks.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Vasily Averin <vvs@virtuozzo.com>
Cc: Cong Wang <amwang@redhat.com>
Cc: Mike Christie <michaelc@cs.wisc.edu>
Cc: Lee Duncan <lduncan@suse.com>
Cc: Chris Leech <cleech@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
---
 drivers/scsi/libiscsi_tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/libiscsi_tcp.c b/drivers/scsi/libiscsi_tcp.c
index 6ef93c7af954..31cd8487c16e 100644
--- a/drivers/scsi/libiscsi_tcp.c
+++ b/drivers/scsi/libiscsi_tcp.c
@@ -128,7 +128,7 @@ static void iscsi_tcp_segment_map(struct iscsi_segment *segment, int recv)
 	 * coalescing neighboring slab objects into a single frag which
 	 * triggers one of hardened usercopy checks.
 	 */
-	if (!recv && page_count(sg_page(sg)) >= 1 && !PageSlab(sg_page(sg)))
+	if (!recv && sendpage_ok(sg_page(sg)))
 		return;
 
 	if (recv) {
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
