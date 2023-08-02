Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13949C001DF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Aug 2023 06:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IK3aEBELlq1x3phTcf/ZsaDVc7hT1k6rf0vBkIgEPXc=; b=BNvG35nsI0Rp5IMUZZ1FFKR+3U
	QUI6pTuL/nS8q9sXaVxT6RO2ldU4YfCfdqWyp63Ue9XEzsojmF2T5H1979cc7bG7wypCmDFaO3klA
	bPMJKw7+9uduF1ojVOBIbSHC+UwcqvFhJ0oIsmWwx103Oa/rETcCiXo4pJtJA8LhVPi+ZJCD7FFp5
	AZWLz1UnoJBhCLu6Sf0C5hRUZc+lwAGJTyaHE49no1Q37V/5Q86dXaANFRXOvmoxmm4q7A/oFOHuc
	RiJwCgH9n1KpKGQx2WLKF+jWYIqapKUmvX9ij5zZs4swmCe9C0zQZmZT4YuHrq159Kf4FxK1E5q6R
	xmPNcuUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qR5OW-0048pB-1t;
	Wed, 02 Aug 2023 06:31:40 +0000
Received: from out-111.mta0.migadu.com ([91.218.175.111])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qR5OT-0048oK-2J
	for linux-nvme@lists.infradead.org;
	Wed, 02 Aug 2023 06:31:39 +0000
Date: Wed, 2 Aug 2023 02:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1690957893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IK3aEBELlq1x3phTcf/ZsaDVc7hT1k6rf0vBkIgEPXc=;
	b=Pr473z+oXbzMZnI8H/I7LVvXQV9wG8U4dZbKBe3GO0clA6n4ufvTxLMl7tbSVxVExQcRo8
	E2SQPidb8c3SQ9nSKJk5xAX3p5AwQD8J2yu+jrf6U177qpC8Zvi0ZKsaUnioprO3HsnSoR
	XqACV00ARwzJ1G94/gTOP41ZZ9rVOVI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, willy@infradead.org, hare@suse.de,
	djwong@kernel.org, bvanassche@acm.org, ming.lei@redhat.com,
	dlemoal@kernel.org, nitheshshetty@gmail.com, gost.dev@samsung.com,
	Vincent Fu <vincent.fu@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 3/9] block: add emulation for copy
Message-ID: <20230802063124.4652m3gfbhdmghlt@moria.home.lan>
References: <20230627183629.26571-1-nj.shetty@samsung.com>
 <CGME20230627184020epcas5p13fdcea52edead5ffa3fae444f923439e@epcas5p1.samsung.com>
 <20230627183629.26571-4-nj.shetty@samsung.com>
 <20230720075050.GB5042@lst.de>
 <20230801130702.2taecrgn4v66ehtx@green245>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801130702.2taecrgn4v66ehtx@green245>
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230801_233138_165605_482AD83E 
X-CRM114-Status: GOOD (  16.29  )
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

On Tue, Aug 01, 2023 at 06:37:02PM +0530, Nitesh Shetty wrote:
> On 23/07/20 09:50AM, Christoph Hellwig wrote:
> > > +static void *blkdev_copy_alloc_buf(sector_t req_size, sector_t *alloc_size,
> > > +		gfp_t gfp_mask)
> > > +{
> > > +	int min_size = PAGE_SIZE;
> > > +	void *buf;
> > > +
> > > +	while (req_size >= min_size) {
> > > +		buf = kvmalloc(req_size, gfp_mask);
> > > +		if (buf) {
> > > +			*alloc_size = req_size;
> > > +			return buf;
> > > +		}
> > > +		/* retry half the requested size */
> > > +		req_size >>= 1;
> > > +	}
> > > +
> > > +	return NULL;
> > 
> > Is there any good reason for using vmalloc instead of a bunch
> > of distcontiguous pages?
> > 
> 
> kvmalloc seemed convenient for the purpose. We will need to call alloc_page
> in a loop to guarantee discontigous pages. Do you prefer that over kvmalloc?

No, kvmalloc should be the preferred approach here now: with large
folios, we're now getting better about doing more large memory
allocations and avoiding fragmentation, so in practice this won't be a
vmalloc allocation except in exceptional circumstances, and performance
will be better and the code will be simpler doing a single large
allocation.

