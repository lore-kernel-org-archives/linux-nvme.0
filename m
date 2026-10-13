Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF25CCC6B12
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 15:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b0oNPG2rhcf9mZxkt6X2VxPmRCkU8KQ8K0d4hglUL+Y=; b=El4CU3wZMd7MgsM71zuJkWEJxs
	vIA0OcO6o/lRzjSD+TOtz7M2lCziVPluEpnHMPjL8LVcsFshBTGr8YsMdLjWZ62gaZPT6J92R/PFF
	Wu7s+PTIWQ22eFXSVEHTcgMYHF/SsAfWZgm3tjz5mSzaTfqQkRcs4SYOOPsf115YdMDAa+6ZBkhET
	5G66F0iVtOi2Zox2Fh0G+ZwC1ZQXFuRss5+BpqlKJ1nLJt1aRStmafRWarxPNkAf5uCyif8V87crP
	IW1fbY7vwjXHRx6Qs2xe8gH4dunwLPaOx3mBmFx6jXuldfI0QVTCr0byxVPTbLFRPhZmtZsQiO/kO
	55d/U1DA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGegp-0000000DP9L-2c9t;
	Tue, 13 Oct 2026 15:45:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGego-0000000DP8t-1QcU
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 15:45:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 1CD994156F;
	Tue, 13 Oct 2026 15:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902911F00893;
	Tue, 13 Oct 2026 15:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791906318;
	bh=b0oNPG2rhcf9mZxkt6X2VxPmRCkU8KQ8K0d4hglUL+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Up6nr3HwjKWoAv+rLOOUmunrYynGUmwYnwci5vIN9nkLKlLBt8KRdin8I5h91QzfT
	 uIBV7+J66aQcSRLRi+vLxHestQg/hKo4rGfzZ5cLMCbPq0Gv0LxVii0eMBc9QtGplh
	 BCYFJkoGNC42gnBl45sZ1b7rcr/+xr6Odnk16WIsJLJLld6qpPJ9e0ewqsBHugtVif
	 JnnZ2PNq8rC892zhksP1tebRuruQBiB5gGBuxkLaaPJDs5GJ66P+fV6YC2bwE4fHYZ
	 /7ngKJBUEXQ/b7JF68nq7Hl7sIWRhawgR9lfkvnLW9t6qgZUrqcJAqMcke7JmCQqYZ
	 UsOLu0hwh8gnA==
Date: Tue, 13 Oct 2026 09:45:16 -0600
From: Keith Busch <kbusch@kernel.org>
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Hannes Reinecke <hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>,
	gliuxen@gmail.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] nvme: bound FDP config log reads to the received
 buffer
Message-ID: <as5SDPfZx8Kgqjb7@kbusch-mbp>
References: <20261013102812.3020500-1-yhlee@isslab.korea.ac.kr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013102812.3020500-1-yhlee@isslab.korea.ac.kr>
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

On Tue, Oct 13, 2026 at 07:28:12PM +0900, Yehyeong Lee wrote:
> nvme_query_fdp_granularity() parses the FDP Configurations log using
> sizes the controller returns, without checking that they fit the buffer
> it was given.  The log size is only bounded from above before
> kvmalloc(), so a size below the log header makes
> le16_to_cpu(h->numfdpc) read past the allocation, and a size of zero
> yields ZERO_SIZE_PTR and faults.  Each configuration descriptor is then
> dereferenced (dsze while walking, and nrg and runs on the selected one)
> without checking that the whole descriptor lies within the buffer, so a
> descriptor at or past the end is read out of bounds.  The out-of-bounds
> runs value is then exposed to userspace through
> /sys/block/nvmeXnY/queue/write_stream_granularity.
> 
> A device-supplied dsze that is not a multiple of eight also leaves the
> following descriptors unaligned, and the structure is not packed, so
> reading nrg and runs from one can fault on architectures without
> efficient unaligned access.

Thanks, applied to nvme-7.4.

