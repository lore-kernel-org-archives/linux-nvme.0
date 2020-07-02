Return-Path: <SRS0=dOZ+=AN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7289EC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 15:15:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406F6206B7
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Jul 2020 15:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HbOKzFNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406F6206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=784xVQVv2AeTW91bvg9a77diD0j+5KGvECCg7+kDvpk=; b=HbOKzFNV4oKR39ySwiiOnM/as
	kAJi7EpfoBS0d3ovl1VbghBlnhsYyYjyFDf8Os5BL6aNcKY4bPm7uZoxTTpI9/ZC2i1lyMqOnjfgk
	7tt6+rsEcyA/Fip2eC8AbFmwlindup5Q+Ze9e+aibv+kJYk1egPTdCercEhbLsQ63gklRqsicdo/W
	+CFNUnNKDWDJOGoVsixi18OjeafOpsuImrhhz2Q50f39egDGRweiLM39/4IaCW/LiYMTFoj+VUyuV
	oltTWbpmfgBUPz2Xe6k2iEKwm9etG9KdfXGkLmuvZAytYL1//jamPBu2cLZrs0mhB5ZJ88xvsL5Km
	qcQ+Ezcdw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jr0vT-0003Mm-V2; Thu, 02 Jul 2020 15:14:59 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jr0vR-0003MK-Ri
 for linux-nvme@lists.infradead.org; Thu, 02 Jul 2020 15:14:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9DA8768B05; Thu,  2 Jul 2020 17:14:53 +0200 (CEST)
Date: Thu, 2 Jul 2020 17:14:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Qian Cai <cai@lca.pw>
Subject: Re: [PATCH 18/20] block: refator submit_bio_noacct
Message-ID: <20200702151453.GA1799@lst.de>
References: <20200629193947.2705954-1-hch@lst.de>
 <20200629193947.2705954-19-hch@lst.de> <20200702141001.GA3834@lca.pw>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200702141001.GA3834@lca.pw>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200702_111458_037883_9231D2A7 
X-CRM114-Status: GOOD (  13.09  )
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-xtensa@linux-xtensa.org,
 linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, dm-devel@redhat.com,
 Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com,
 Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-bcache@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>,
 Dmitry Vyukov <dvyukov@google.com>, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Jul 02, 2020 at 10:10:10AM -0400, Qian Cai wrote:
> On Mon, Jun 29, 2020 at 09:39:45PM +0200, Christoph Hellwig wrote:
> > Split out a __submit_bio_noacct helper for the actual de-recursion
> > algorithm, and simplify the loop by using a continue when we can't
> > enter the queue for a bio.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Reverting this commit and its dependencies,
> 
> 5a6c35f9af41 block: remove direct_make_request
> ff93ea0ce763 block: shortcut __submit_bio_noacct for blk-mq drivers
> 
> fixed the stack-out-of-bounds during boot,
> 
> https://lore.kernel.org/linux-block/000000000000bcdeaa05a97280e4@google.com/

Yikes.  bio_alloc_bioset pokes into bio_list[1] in a totally
undocumented way.  But even with that the problem should only show
up with "block: shortcut __submit_bio_noacct for blk-mq drivers".

Can you try this patch?

diff --git a/block/blk-core.c b/block/blk-core.c
index bf882b8d84450c..9f1bf8658b611a 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1155,11 +1155,10 @@ static blk_qc_t __submit_bio_noacct(struct bio *bio)
 static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
 {
 	struct gendisk *disk = bio->bi_disk;
-	struct bio_list bio_list;
+	struct bio_list bio_list[2] = { };
 	blk_qc_t ret = BLK_QC_T_NONE;
 
-	bio_list_init(&bio_list);
-	current->bio_list = &bio_list;
+	current->bio_list = bio_list;
 
 	do {
 		WARN_ON_ONCE(bio->bi_disk != disk);
@@ -1174,7 +1173,7 @@ static blk_qc_t __submit_bio_noacct_mq(struct bio *bio)
 		}
 
 		ret = blk_mq_submit_bio(bio);
-	} while ((bio = bio_list_pop(&bio_list)));
+	} while ((bio = bio_list_pop(&bio_list[0])));
 
 	current->bio_list = NULL;
 	return ret;

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
