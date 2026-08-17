Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09769C5B572
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 16:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T+q5TB4tDNkFjf/LcS6YHnZ52RrH5YFtDiWHGm00d14=; b=eet+wIq+s8WqAfwJN31qfffOYT
	kYpzW/4WG19iE3gi9Rb0CAn/Hmx0ZX41qC8XX4Wm71ARxc8RdG/E3PmVIyjoX3tOd2KtObjPauDm+
	cxRUksTJwXN1QUlRvqBfDybOuNAw1t17TkekQB2+mq89dVKpu7SRxQz35tzEtxZ3ixV1fwxgiNMH/
	+mPRahvaVuAlgUX2WmseW/4H8MzDpnCFHlceccbwWPTEtLhyvnbi6W3a7DxPZCvhvLEoObbOz3A3D
	tBNT6G4yXG5Skf8ea+KI8iOjU+l/F5LSlQ04TZP6Em7muGKQxC9IMs4BUelGaq6XzJaixBO7+oTc0
	MaG8uC7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvzph-00000006TuE-1bTe;
	Mon, 17 Aug 2026 16:05:05 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvzpf-00000006Ttt-17C4
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 16:05:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id B1FB1601DE;
	Mon, 17 Aug 2026 16:05:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 205DB1F000E9;
	Mon, 17 Aug 2026 16:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786982702;
	bh=T+q5TB4tDNkFjf/LcS6YHnZ52RrH5YFtDiWHGm00d14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fO4irgHhKgHFCBCh6x65nsczOsr6laBg9lud+1B+zLZkjow0OmudZHwCrE9OaOb0l
	 05Qh9R1xIKSIJdG3xEGJclt1WyohuVKR0VzRE+b8HXa6/+KBbGmRs81ntRkgT9kkEl
	 sF5CDMHKP5RsXbE4uGhrehK4haXpJvAcdzxnIGDX/CFdyL/QgTcF0QlzUTdYoTy3ZG
	 wbX7CSzUU0p+RKuIpSeyA+ECDtHoroN3EYu25jYzzqJLoWn4hOF57d93kvwhexxKk6
	 6g7ozAGEpDjC+uT/B8mBD2dyExANGQH+OpQ0kdRo/x0Kliibc90YHMearU5M3x//w/
	 Ib6HOI02Vqcsg==
Date: Mon, 17 Aug 2026 10:05:00 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Auger <eauger@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	axboe@kernel.dk, Jeff Moyer <jmoyer@redhat.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <aoMxLBmKfFo_-i1u@kbusch-mbp>
References: <20251014150456.2219261-1-kbusch@meta.com>
 <20251014150456.2219261-2-kbusch@meta.com>
 <1805eed3-90ec-4f62-9d71-e3f898a464ad@redhat.com>
 <aoMi6y2qsnRVembg@kbusch-mbp>
 <0023a895-7b04-44cd-a90f-c9d587a49519@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0023a895-7b04-44cd-a90f-c9d587a49519@redhat.com>
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

On Mon, Aug 17, 2026 at 05:12:39PM +0200, Eric Auger wrote:
> Please let me know if you want me to trace some stuff specifically.

Can you test the same setup with this included?

---
diff --git a/block/bio.c b/block/bio.c
index 4074a0496b93f..c343788e1f96e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -859,6 +859,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_write_stream = bio_src->bi_write_stream;
+	bio->bi_bvec_gap_bit = bio_src->bi_bvec_gap_bit;
 	bio->bi_iter = bio_src->bi_iter;
 
 	if (bio->bi_bdev) {
@@ -1969,6 +1970,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 		bio_integrity_trim(split);
 
 	bio_advance(bio, split->bi_iter.bi_size);
+	bio->bi_bvec_gap_bit = 0;
 
 	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
 		bio_set_flag(split, BIO_TRACE_COMPLETION);
--

