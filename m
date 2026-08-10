Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B18D3C5B567
	for <linux-nvme@archiver.kernel.org>; Mon, 10 Aug 2026 19:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=byNcIJByq+RvHLtYKbTJRv9FVBFhPPZAxNuQwd74U7U=; b=zwV4np1O+Z3qaemBbnDYq+xTFz
	tRpPM7uC5K46RNi+P9fSoXdK3C/rVH3ZpvhcjPR/bNhGDPDmdk5bnpTHgZn/zrKZx3Dbe5o13lHSn
	SGpTmNUeKyFJHjh7bcsYsuFIzY2fV5jifNOFOg4iutuzlWfaIh+RhRduZb2FVw3GGmEXND+7q2EZC
	owWV/PQZCyC7MUy2oshfTUBC33kI9z4A/O23zC5jRDD59Nb2CABiHWywUNdtKYf7OrlfwCJ5g0IEM
	SoQkS61s3BmHSGZhjii4PkL4vzFyMRCInzrf0CKVly8S/Ah8sOuZ0+VJV8PHKbcPJz3t8Lr9yLter
	DWbKNptw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtVll-0000000Cl4v-19lx;
	Mon, 10 Aug 2026 19:34:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtVlk-0000000Cl4V-065g
	for linux-nvme@lists.infradead.org;
	Mon, 10 Aug 2026 19:34:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 19EE1600AD;
	Mon, 10 Aug 2026 19:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791A71F000E9;
	Mon, 10 Aug 2026 19:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786390482;
	bh=byNcIJByq+RvHLtYKbTJRv9FVBFhPPZAxNuQwd74U7U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=W77ZwVoj6XH41ra9yhXIjXMj0uwnntRPJ4hdhkq91HxAYzz+CYmuE5yX0kN5idY8v
	 T9WgROlmjXh7DIbs+obJ1wkce4A8Sp7g1wbi/hf+mJF00er8B3dwKdpyFjIcyoUAA2
	 oq5cU5T7P/NWyvRhplouQGQ+05I0itQhMENZBVmDAYRTIUi/aW1ID4n7OtI53ujWd5
	 tljmccrPuXjq6iLYwZm0U2Gv4dk58WgVj51GH+QCand9DmXyC9h981Oo8EPu7uOXh4
	 TvfYHfsiDue1c+Ih1gzU+oktkqxEmVwCpfolwX59maUqNM6YDgeo1InFA4Ayn3VP8o
	 tLRL1rRPKYSaw==
Date: Mon, 10 Aug 2026 13:34:41 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	nilay@linux.ibm.com, Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/5] nvme: a few error-path and validation fixes
Message-ID: <anon0VEOq8AApalr@kbusch-mbp>
References: <20260804021901.3777326-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804021901.3777326-1-kanie@linux.alibaba.com>
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

On Tue, Aug 04, 2026 at 10:18:56AM +0800, Guixin Liu wrote:
> This series collects independent fixes found while auditing error and
> command-processing paths in the NVMe host and target drivers. Each is
> standalone; they only share the same subsystem.
> 
>   1. nvmet: an Identify CNS 07h (active NS list for a command set)
>      dereferences req->ns, which is always NULL on that path -> NULL
>      pointer oops. Also fixes the filter to test the iterated ns->csi.
> 
>   2. nvmet: nvmet_ns_enable() ignores the percpu_ref_init() return value
>      and reports success to userspace when it fails, leaving the ns dead.
> 
>   3. nvme-pci: the per-NUMA-node descriptor DMA pools, created lazily on
>      admin tag set allocation, are only freed in nvme_remove(); a probe
>      failure after that point leaks them.
> 
>   4. nvme: nvme_query_fdp_info() trusts the device-supplied nruhsd count
>      and can read past the fixed-size RUH status buffer (heap OOB read).
> 
>   5. nvme: follow-up to #4, suggested by Kanchan -- the RUH status buffer
>      and the placement handle clamp used the odd S8_MAX - 1 value; raise
>      the cap to the meaningful U8_MAX (bio->bi_write_stream is u8) and
>      warn on overflow.

#4 was handled by a earlier and different patch, so I dropped that one,
and patch 5 had to accomodate. I've applied the result to nvme-7.3.

