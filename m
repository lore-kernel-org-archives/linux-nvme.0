Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0768CCFA18
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Nov 2025 13:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aPF8TB2ETtDXUA9106+VlrgnVWziD/Di6dGctvtEDs8=; b=f5gccqCtUZYjaWNRuhfdFgSRbP
	582vIhtlR9/9pcSDog27bbETSDr2V2LU8xymqudRyEe9fxxt0sbNdLmjM3/Jwv7oe3oXECrjCs/Q8
	Gi7AJ6O+p9Nz8ISwZ85Pkog2Q3uO6CijinJeASsgoEfs2bSn27Gfe4h6sLQjCxn1FHHkn2nbBYeFq
	cuNhaFC4HtBShmhMONjYwYQI/lnYb54PKAt+nroVPpSxxtsiQYMqmP8TI9QIDMpW2UZ4po/uPpMoB
	aeuinXACl92nEpJbKoj6pKEhi/Ss0zI28cVFErQkcaL3fJGsEWAvyeh8V/f2ihhEvMJZs+G9GkE33
	elOw6mYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIopn-00000007Gi8-1iQV;
	Tue, 11 Nov 2025 13:54:59 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIopm-00000007Gi2-0xnK
	for linux-nvme@lists.infradead.org;
	Tue, 11 Nov 2025 13:54:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2A5846020B;
	Tue, 11 Nov 2025 13:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA66AC2BC86;
	Tue, 11 Nov 2025 13:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762869296;
	bh=nOjcrcHGqxzAQp5BO2Cm52zJa3SqUoYXtMLRHzvTVtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cR/enPMSVXBmha2JWczFTQ+NgUpPrn5hrDvzKs7WeEs4DEGMZyaZ6CpbfniLOhsqZ
	 dS9PfcGrM+TVsFwml4P3Vo1PU6uja8lBezcuM3o6VcS/DlCSld6ayj0S4bbq3jIKlQ
	 bA/NMPpMA929pCe4RvFEUVGGbnEf+slJEO0OzB2IajM5VEkMpdVQctQFYOuryum0a8
	 i8Dw3OfRFCLf0/H527TT7CZFQ8owejxH7gpQK1D5WlX1ouHI8sagItArFPdOGcVlGo
	 6oIqca/3QQG6bIhDTzOoXhhu1OpDevwu6+ra/GOV7XDyeX6qgv1sZOyxZNhMVG7924
	 KMjwh6bhEnjBg==
Date: Tue, 11 Nov 2025 08:54:53 -0500
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Yu Kuai <yukuai@fnnas.com>, Matthew Wilcox <willy@infradead.org>,
	Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, axboe@kernel.dk
Subject: Re: [PATCHv5 1/2] block: accumulate memory segment gaps per bio
Message-ID: <aRNALUnnxzIuyHng@kbusch-mbp>
References: <20251014150456.2219261-1-kbusch@meta.com>
 <20251014150456.2219261-2-kbusch@meta.com>
 <aRK67ahJn15u5OGC@casper.infradead.org>
 <aRLAqyRBY6k4pT2M@kbusch-mbp>
 <20251111071439.GA4240@lst.de>
 <024631dc-3c65-49a8-a97a-f9110fd00e9a@fnnas.com>
 <20251111093903.GB14438@lst.de>
 <c82cd0f1-f56e-445b-8d78-f55a0c3b2b4c@fnnas.com>
 <aRM5UoApKZ9_V7PV@kbusch-mbp>
 <20251111134001.GA708@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111134001.GA708@lst.de>
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

On Tue, Nov 11, 2025 at 02:40:01PM +0100, Christoph Hellwig wrote:
> On Tue, Nov 11, 2025 at 08:25:38AM -0500, Keith Busch wrote:
> > Ah, so we're merging a discard for a device that doesn't support
> > vectored discard. I think we still want to be able to front/back merge
> > such requests, though.
> 
> Yes, but purely based on bi_sector/bi_size, not based on the payload.

This should do it:

---
diff --git a/block/blk-merge.c b/block/blk-merge.c
index 3ca6fbf8b7870..d3115d7469df0 100644
--- a/block/blk-merge.c
+++ b/block/blk-merge.c
@@ -737,6 +737,9 @@ u8 bio_seg_gap(struct request_queue *q, struct bio *prev, struct bio *next,
 {
 	struct bio_vec pb, nb;
 
+	if (!bio_has_data(prev))
+		return 0;
+
 	gaps_bit = min_not_zero(gaps_bit, prev->bi_bvec_gap_bit);
 	gaps_bit = min_not_zero(gaps_bit, next->bi_bvec_gap_bit);
 
--

