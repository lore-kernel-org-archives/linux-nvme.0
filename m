Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AE27C54F52
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q0oQ5pZMnSUkonWdBq10DqkCmYacFCTXVYmYjdR/bCw=; b=2jDFsa2Dj8DQurlcI2EPXC2rgD
	3rqidgyqrZilbWx06yZs9q9u+N3dlGRzJTgc8uB+cwqVaQtnGm8+nMg2DnAEYBqr75siziMn0/04h
	oh+J2A+BV5/1n/f9v5zrWVTgM7yGsHwpoqR0Xrr/bZg8k0ss0nVD/xC+zLQ+9MTcWVksZTYEJ467z
	Adh9yDQ+ptJ03XOAcjJcxIioKrQUAr3GzFtHe9CzYkY3tRl3VAWPFB22p8IYVIYO3PjMZZS/UnCeL
	zMaocVH0x2fqSQdDU6XnMCUQi5Elk+fVUTCF6gRStdkK7RrQzK/qH5oNAyitcUkUKGxn2yW2chXv/
	fjNZuIMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2Vf-00000007jAX-0PZS;
	Wed, 29 Jul 2026 11:31:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2SN-00000007imR-31Wq
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 11:28:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EB33568AFE; Wed, 29 Jul 2026 13:28:08 +0200 (CEST)
Date: Wed, 29 Jul 2026 13:28:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev, nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: Re: [PATCH v4 01/14] dma-buf: introduce initial file I/O
 infrastructure
Message-ID: <20260729112808.GA30851@lst.de>
References: <cover.1785274111.git.asml.silence@gmail.com> <bc20381e8daf85ac58811c344325d8192cde9d1e.1785274111.git.asml.silence@gmail.com> <20260729065927.GA9534@lst.de> <340dd033-2a45-49e7-afd6-95dbbbf624da@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <340dd033-2a45-49e7-afd6-95dbbbf624da@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_042815_911780_7BCA3850 
X-CRM114-Status: GOOD (  16.49  )
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:31:38 -0700
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

On Wed, Jul 29, 2026 at 11:37:19AM +0100, Pavel Begunkov wrote:
> On 7/29/26 07:59, Christoph Hellwig wrote:
>> The method name feels a bit convoluted, but given all the
>> previous discussions I don't care too strongly.  I'll leave
>> the dma-buf side review to those who understand it.
>
> I assume you mean this:

Yes.

>
> +	int (*init_dma_buf_io_ctx)(struct file *, struct dma_buf_io_ctx *);
>
> I agree, and all dma_buf_io_[ctx,map] look clunky, but I don't
> see what I can drop out of the name. Suggestions? Maybe I at least
> should make the fs op sth like "register_dma_buf".

I just remember scares from the last discussion :)

register_dma_buf sounds fine to be, but unless I misremember there
were objections to that before.

>
> -- 
> Pavel Begunkov
---end quoted text---

