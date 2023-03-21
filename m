Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21729C74A5B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Mar 2023 16:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kk+h2YK5oXsYlyKQObTxlxn6L/CYL6rLHLOwX9C4EDc=; b=T2TUH1CQESFkp7Ow4k5LfaKOeu
	OPf+2Sh3QDox6OHBmu8Vx4DPCNQEXft1oFVSw1/wv/wZqjix8KXVo8/fxH7tUTsScfXR8t2ktHsyK
	Cmj7BS+9PfIR6hYuSoXEXlatulXXR/fSgT9xs9G4qRwEbTh+d1bnZTfUCK293D74hiq5yRghDmRZ0
	qr8jpbFbF/LWbeKSfCokHSWpm4mWPN5fgnDxWfWCt/sy2ewmSJ89BBsDljhI9VfpJXgVtqaA7bqGE
	Bo9KvTd9SCzjwlY6uH3qhGGri+xPMqoyYlGnJmJLwvmmZy6wCqtD+terK0VIYYC2xqsgGEn/NUWzI
	13PLdaRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1peeob-00D4aW-24;
	Tue, 21 Mar 2023 16:26:25 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1peeoV-00D4Zm-0W
	for linux-nvme@lists.infradead.org;
	Tue, 21 Mar 2023 16:26:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 47CF561CB7;
	Tue, 21 Mar 2023 16:26:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 540C8C433EF;
	Tue, 21 Mar 2023 16:26:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679415976;
	bh=SeKwLJyjREaFZccwaE5MnvxV2yTZJqFfTrtl5/xu+Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P7PocTryQK9yCAIV57FYRy+ZVJr1lXq+20aoPLZDHWZoBOKRNUQHWNu/r8jY7LlA/
	 WIXCB0Nq4di+3sRFsxrSrofO8F3bGUzrHbUpGknQYnFXNvt3Z5qDhAEwJB1mBISoxX
	 LZgr7A2Gd5wD5oN1XMyX/Sz8As/SPe6JqBVGKX2U4WwX1Xub4YEpSjGwyJdkEHzpuA
	 yO8rPDkijfqMtI7VOMSstuRexMJE4WxT/eZl/iZhOgk5toBMrEDc1IdiVahDGTmBQA
	 efJ6/EckQTruPC45/Kml8UUdB8DFLCr2d4T9Qy8Jc8kITHv52Nxctiaz4WfYzuj3Xw
	 7+kgium0f59tQ==
Date: Tue, 21 Mar 2023 10:26:13 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Daniel Wagner <dwagner@suse.de>,
	"Belanger, Martin" <Martin.Belanger@dell.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-tcp: kernel NULL pointer dereference, address:
 0000000000000034
Message-ID: <ZBnape+BlqgWZLFo@kbusch-mbp.dhcp.thefacebook.com>
References: <ZBNPs3ukEpbm/NSn@kbusch-mbp.dhcp.thefacebook.com>
 <bd0c1ec4-edd2-4225-c4d7-b091bde26494@grimberg.me>
 <20230321082308.n6ed7ieu5jdb2gj4@carbon>
 <20230321084917.s5xqklrttauxilnx@carbon>
 <a3d023ca-ca00-8207-2f89-fad23eddd58a@grimberg.me>
 <20230321090913.gwuvyuw76ha62hgb@carbon>
 <4c4b93b7-891d-cd5f-e4f2-50c242c799ce@grimberg.me>
 <20230321092556.7m3etb25jnd4sfj6@carbon>
 <316be6c1-0d90-0ea8-f9cf-1ec0086877a3@grimberg.me>
 <038ea0b7-9cf4-4b19-0fd3-bf3cd69342ca@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <038ea0b7-9cf4-4b19-0fd3-bf3cd69342ca@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230321_092620_218757_61E7A77A 
X-CRM114-Status: GOOD (  21.35  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Mar 21, 2023 at 12:15:47PM +0200, Sagi Grimberg wrote:
> 
> > > > The admin tagset does not have a polled hctxs map to begin with,
> > > > so I'm unclear how any fabrics or admin requests end up polled...
> > > 
> > > Hmm, if no map_queues() callback is provided for the admin tag set,
> > > isn't the
> > > default mapping function used and this would add the poll hctxs map?
> > > Let me add
> > > a map_queues() callback and see what happens :)
> > 
> > admin_tagset.nr_maps = 1 (only the default map, no read, no poll)
> 
> Oddly, I don't see admin/fabrics requests being polled...
> 
> I just attempted with the below patch and it seems to work.
> The only change I did was to pass to blk_poll the cookie as well,
> from bio_poll that is bi_cookie, and from blk_rq_poll it is computed
> from the hctx directly.

I think we can can really simplify this path a lot knowing that we are dealing
with a live request from a polling queue. Then we can poll for requests without
bios too.

---
diff --git a/block/blk-mq.c b/block/blk-mq.c
index d60ef2f0fa50b..b64c7d491306b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1323,8 +1323,6 @@ bool blk_rq_is_poll(struct request *rq)
 		return false;
 	if (rq->mq_hctx->type != HCTX_TYPE_POLL)
 		return false;
-	if (WARN_ON_ONCE(!rq->bio))
-		return false;
 	return true;
 }
 EXPORT_SYMBOL_GPL(blk_rq_is_poll);
@@ -1332,7 +1330,7 @@ EXPORT_SYMBOL_GPL(blk_rq_is_poll);
 static void blk_rq_poll_completion(struct request *rq, struct completion *wait)
 {
 	do {
-		bio_poll(rq->bio, NULL, 0);
+		blk_mq_poll(rq->q, blk_rq_to_qc(rq), NULL, 0);
 		cond_resched();
 	} while (!completion_done(wait));
 }
--

