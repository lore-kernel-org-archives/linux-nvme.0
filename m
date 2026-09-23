Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 975CCC982EA
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 04:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aV3PKbje2nVati/mx42bJIf7hfgh/z0fbj4RNm+98Pk=; b=w1u7r89nb4JMQUH6zCCHq+klRg
	7cXBC0tdK+bmLWt0VsctIttEVh1uKNGTg3FdPKn2mWfaRuP4wmMjsDfAz0+RKOZ/KMyRmYXzOeqN3
	amS3HkLnLfmzgmBvI9X6HKiKe4TbMEsjvyxguCFF/pdIwhTQQa9xazIWmcUSlTJLThN6/2yU9CPuH
	+6xexVsbAT/Qo2q0eWaSN8d5c7wX5WpdnLqAd7z4R9a/SK36APpbBsclYmDu76qgp0mln/KNOi5+q
	Rv6FQmwg+rIKgA8TxaBWn33pCNuBSm5AbNEvxSaItGELw/hH32tDcgw0BWWkNF/Q12qxz1wZTG8DR
	wPG0ANYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9F1v-000000078SX-1A6S;
	Wed, 23 Sep 2026 04:56:27 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9F0p-000000078Pa-3Dum
	for linux-nvme@bombadil.infradead.org;
	Wed, 23 Sep 2026 04:55:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aV3PKbje2nVati/mx42bJIf7hfgh/z0fbj4RNm+98Pk=; b=T6gMtdqAAWnJB/fWMCTJS//Um+
	ZvK49F9acKmMevQaiYjMWG3acFJlGHo8BuQKKEi41DeN4FpFvwh6ApjqZpIE3teyB79i/le30X3hG
	hq00ELDlJF9GhZh/FTYMjRD4sNrtyh2m5x4jFget84WaqlBuIIQj6j9/LxPsFXgYN9JsfBqFRMbYW
	CuHNBDi0chEplJPVGfeSQftAO8hjKVbzymc45R/dsGt9T2wu2ojZTqh8ZCvinU9A9VdjASySFJQxf
	qU6JynVOFblQVtwOYZthWD44EKnuWt2h+GINDIT5jz0viHHjv4aRT2LpuvlX3STqrR0j36rqRXLm3
	MKhF+Hqg==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x9F0f-0000000ELr8-3bGM
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 04:55:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B955768BFE; Wed, 23 Sep 2026 06:55:05 +0200 (CEST)
Date: Wed, 23 Sep 2026 06:55:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>, Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Subject: Re: [PATCH v6 06/13] nvme-pci: implement dma-buf backed requests
Message-ID: <20260923045505.GB26231@lst.de>
References: <cover.1789997898.git.asml.silence@gmail.com> <e80c3b1e0de004eaca6c51a2a86115ac9ed36381.1789997898.git.asml.silence@gmail.com> <20260922132016.GA30684@lst.de> <d39a6dd7-cb5a-43d6-8dcb-16eb9fc95b4d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d39a6dd7-cb5a-43d6-8dcb-16eb9fc95b4d@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260923_055516_713102_813E0B4E 
X-CRM114-Status: GOOD (  18.42  )
X-Mailman-Approved-At: Tue, 22 Sep 2026 21:56:25 -0700
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

On Tue, Sep 22, 2026 at 02:37:08PM +0100, Pavel Begunkov wrote:
>> Sashiko had a few comments, which I think are correct - if we use
>> dma_map_sg to map the data, we need to use the sync_sg APIs to
>> transfer ownership.  That only matters on non-coherent architectures
>> with MMU, but we need to get it right.
>
> I've seen that and fixed everything locally that should be fixed,
> apart from the sync. I wonder what we can do about that? I can
> somehow replace it with the sg variant for now, but sync'ing the
> entire possibly multi-GB mapping for, let's say, a 512B I/O, sounds
> not wise.

If we'd want to fix this for real we'd need to add an offset to the
sync by sg methods.  Or move away from scatterlists in dma-buf, given
that they are a horrible API.  All of these are bigger projects,
though.  So for now I think you'd want to do the sync all, and have
the people who run high-performance io_uring code on non-coherent
platforms suffer.

> And I can think of another place that does mix sync_single
> with sgs.

Which one?


