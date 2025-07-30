Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728E8C87FCB
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Jul 2025 15:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YHwRGw9VArptgZCZtwDUeHT5B+hDEZrQOcCOKNLgqf8=; b=nQdYB8PS7Rm+WZgjKSyuVaUPLD
	8jNfd7a6dBoXs/JrMAyp8mA25vrImaLlcMCSVgQjjLxYYrn7JXQUTIKu8TaDsfXbhVG+WAZgMm0qO
	la+3lhIM0iDXoMPO3/ktRgG13K2wK4mijXUEr7c1A5r7iaiBM0NzmfGNGQPYBHFEqrD8GUMQ+bHgU
	fiTnmQZO9iLVMrRE9FX2nAsQQmg77cifQy1Jz1YCIhUF0vCjWWom8Lr2l/xJlsxi3ag/9187nDngl
	PiQ94wptem2CEEcCLOHw2xXaf5RFHn2jD4xRIoplmIdvGNbHftbWL1VaeoFQkFg+j8uWImnHfknNn
	yS0mMzsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh8ZV-00000001pbi-1xlh;
	Wed, 30 Jul 2025 15:18:25 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uh8ZT-00000001paf-2prH
	for linux-nvme@lists.infradead.org;
	Wed, 30 Jul 2025 15:18:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1288045444;
	Wed, 30 Jul 2025 15:18:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60639C4CEE3;
	Wed, 30 Jul 2025 15:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753888702;
	bh=l2wqk+JqKB6dJ/mOYQb4Q66E1oBu3VoufoALfGPdEXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uf2dVkaQ0z378V9516yzKPY5lW1aYWiiWWDLBtj20oz9MCF5yj6vEc7bLVuKaV4Nr
	 mBUzMkWUOVZSWkK8JN5UyAXWVvFJPDW3kOOGV02Z88u1dl6mFv66BhMqOOM0+V2cbl
	 A25bhCfgCM9AbCn74upfhHSmApnmwTDRG9lt6vjW8K35+23IOLm4k13xREnGbDJU6O
	 piPlBy2laCbY9u2VJGcorzf1/Zvrk4nXkh1Yb522NeWuseYYWUjAXRyANXrLtpuzbF
	 7Xy3AanJxmVygaJDwCs2zf6kmNdQ0xWHj+qxIWPG2p0Lh5u7FaVz0H9uo8OmjEBV4W
	 CvhRhAQ7/N7gQ==
Date: Wed, 30 Jul 2025 09:18:20 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
	leonro@nvidia.com
Subject: Re: [PATCHv3 1/7] blk-mq: introduce blk_map_iter
Message-ID: <aIo3vLnxQFWCD_pv@kbusch-mbp>
References: <20250729143442.2586575-1-kbusch@meta.com>
 <CGME20250729143610epcas5p114f07bbd8e9c27280e6ebd67b1afd47f@epcas5p1.samsung.com>
 <20250729143442.2586575-2-kbusch@meta.com>
 <09c06697-dd77-47bb-85c5-fd64e75c7968@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09c06697-dd77-47bb-85c5-fd64e75c7968@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250730_081823_741142_B75A2852 
X-CRM114-Status: GOOD (  14.41  )
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

On Wed, Jul 30, 2025 at 01:48:42PM +0530, Kanchan Joshi wrote:
> On 7/29/2025 8:04 PM, Keith Busch wrote:
> > @@ -39,12 +33,11 @@ static bool blk_map_iter_next(struct request *req, struct req_iterator *iter,
> >   	 * one could be merged into it.  This typically happens when moving to
> >   	 * the next bio, but some callers also don't pack bvecs tight.
> >   	 */
> > -	while (!iter->iter.bi_size || !iter->iter.bi_bvec_done) {
> > +	while (!iter->iter.bi_size ||
> > +	       (!iter->iter.bi_bvec_done && iter->bio->bi_next)) {
> >   		struct bio_vec next;
> >   
> >   		if (!iter->iter.bi_size) {
> > -			if (!iter->bio->bi_next)
> > -				break;
> >   			iter->bio = iter->bio->bi_next;
> >   			iter->iter = iter->bio->bi_iter;
> 
> This can crash here if we come inside the loop because 
> iter->iter.bi_size is 0
> and if this is the last bio i.e., iter->bio->bi_next is NULL?

Nah, I changed the while loop condition to ensure bio->bi_next isn't
NULL if the current bi_size is 0. But I don't recall why I moved the
condition check to there in the first place either.

