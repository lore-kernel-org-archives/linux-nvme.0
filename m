Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90DE1ECE589
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Sep 2024 19:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6yLxZ+P7PNADNn98SjMSW3xnN3rHwZcVidZMyeezQCM=; b=lpi108Ucroix39HrFF+zil+x9+
	R3hTxd940vlYz8AmGSaLERrEEpUpHNjJF0PGICNH3xVzkJAk1RSEDC2VQ3Aqv4XJ5d6ecwQZFocY3
	yYQQnttyt7K0wbntxUlUFIsf+wpqQG0/uZmkEcVTadxknzonVUtsWy+/dIcOMQCUXFgTIYVcuU1bf
	+X1Ukm8VxYmvUEOcSaTX6KBei81eqmMw16P0IOzm0xI4eg6kmnNK6liXqUTjcofe5lsJUoiVZN7zI
	Hk9Zd8W4pe5j18piLmeS+9JhXO6NTwxD2FdeHIwXAwirhDSoRZipokMiaY4bupkg3pohiAKyZBjXm
	Hvu4hw0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snk4a-000000035pZ-1amz;
	Mon, 09 Sep 2024 19:29:16 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1snk4X-000000035oJ-2r8Y
	for linux-nvme@lists.infradead.org;
	Mon, 09 Sep 2024 19:29:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id EAF29A4322F;
	Mon,  9 Sep 2024 19:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C06DC4CEC5;
	Mon,  9 Sep 2024 19:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725910152;
	bh=LDG1xPJGngJmQ2lFzft38sO/TZPsFVOisF2DF2vYvKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWJdOVMtxYNEZGbw9AsVYWGdcKpR2PPDgfn5K9L7TxMP4wfCsJGvT0RN5ehO4CCwt
	 BeAwTuC1TMJNvVmN0kk4YN9TpeEovMkck9eYUF7miFcbvvk5+COjavwPjL1iXjY4qn
	 5oT0s91uw9qQ64x2wYBlFaQFzGdZZ5E/w7SmgSbC5nqtsbvEIlyH0mJrRWqiCpSqhb
	 SXoEDKjph+SNgdDtu5y0agD2VL2s1rtnJgjKWY9ijr0VQxgy87AxPgZD7iOkib3ZEg
	 gPFmuwgtuuL6Sm6hDZO2uDeo00+BQ0gkRkuV1PVjArk6MVY27q0aP474QJHt4ePbZa
	 jYjZN1Z/eaF9Q==
Date: Mon, 9 Sep 2024 13:29:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Robert Beckett <bob.beckett@collabora.com>
Cc: linux-nvme <linux-nvme@lists.infradead.org>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm <linux-mm@kvack.org>
Subject: Re: possible regression fs corruption on 64GB nvme
Message-ID: <Zt9MheFctnqW260Z@kbusch-mbp>
References: <191d810a4e3.fcc6066c765804.973611676137075390@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <191d810a4e3.fcc6066c765804.973611676137075390@collabora.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240909_122913_806756_D7E5542F 
X-CRM114-Status: GOOD (  21.07  )
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

On Mon, Sep 09, 2024 at 07:34:15PM +0100, Robert Beckett wrote:
> After a lot of testing, we managed to get a repro case that would trigger within 2-3 tests using the desync tool [2], reducing the repro time from a day or more to minutes. For repro steps see [3].
> We bisected the issue to 
> 
> da9619a30e73b dmapool: link blocks across pages
> https://lore.kernel.org/all/20230126215125.4069751-12-kbusch@meta.com/T/#u

That's not the patch that was ultimately committed. Still, that's the
one I tested extensively with nvme, so the updated one shouldn't make a
difference for protocol.
 
> Some other thoughts about the issue:
> 
> - we have received reports of occasional filesystem corruptions on btrfs and ext4 filesystems on the same disk, this doesn't appear fs related
> - it only seems to affect these 64GB single queue simple disks. Other devices with more capable disks have not showed this issue.
> - using simple dd or md5sum testing does not sow the issue. desync seems to be very parallel in it's attack patterns.
> - I was investigating a previous potential regression that was deemed not an issue https://lkml.org/lkml/2023/2/21/762 . I assume nvme doesn't need it's addresses to be ordered. I'm not familiar with the spec.

nvme should not care about address ordering. The dma buffers are all
pulled from the same pool for all threads, and could be dispatched in
different orders than what was allocated, so any order should be fine.
 
> I'd appreciate any advice you may have on why this dmapool patch could potentially cause or expose an issue with these nvme devices.
> If any more info would be useful to help diagnose, I'll happily provide it.

Did you try with CONFIG_SLUB_DEBUG_ON enabled?

