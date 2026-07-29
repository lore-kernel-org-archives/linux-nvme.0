Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 716DAC53200
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 11:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fGbYxKjiwUXWbnfRWSfPvtr30GsGQo0trR5u9z62TnM=; b=CfTEIbAlRBL/2XtTR7lxEKPf5S
	YKO2/6uaptzCH0gHjmhclpx/caTHk/f3MMW/042OfEIVaCbWQ3QMX7QaQDjq7eGI2S+Qf2A54J7zk
	/WfznGxctAnyqInZ4cNs2F1XR4dIXEw7KZGVV6Jq+v5ZaNuMDWL+CqkeiXrfFIKjLxhFnhfKzZCR3
	ZC592u2w9m2oq8GDVu9iiqOGmMz5KzAK9SF/ppaVRugLIvz1enh1pKk2qy94zH08D2jqyjUE7Mrq6
	uj6OKZzx0pHpXMcYCqbVq5zd0fiJgPGGzSBuFYosQLIcBiqNOlX6VaSWCGpMp+rtsWUtEa1Ug3yNo
	TRkqpE8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2tR-00000007nk8-0bSl;
	Wed, 29 Jul 2026 11:56:13 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wp2t0-00000007nfP-2iOK
	for linux-nvme@lists.infradead.org;
	Wed, 29 Jul 2026 11:55:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B73F168AFE; Wed, 29 Jul 2026 13:55:40 +0200 (CEST)
Date: Wed, 29 Jul 2026 13:55:40 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
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
	linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
	cpgs@samsung.com
Subject: Re: [PATCH v4 09/14] nvme-pci: add SGL support for the dmabuf path
Message-ID: <20260729115540.GA32573@lst.de>
References: <cover.1785274111.git.asml.silence@gmail.com> <5c2e9c3bdd3e87c0c9a6e4395ea199002b83fd36.1785274111.git.asml.silence@gmail.com> <CGME20260729072126epcas5p3ad4422a45f1274b71f15dec8bf487fcc@epcas5p3.samsung.com> <20260729072117.GI9534@lst.de> <81412691.21785320403945.JavaMail.epsvc@epcpadp1new> <20260729113108.GA31120@lst.de> <b03bba6f-0a8f-41fc-af59-2a69d271f28b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b03bba6f-0a8f-41fc-af59-2a69d271f28b@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_045547_217915_4024DA14 
X-CRM114-Status: GOOD (  19.00  )
X-Mailman-Approved-At: Wed, 29 Jul 2026 04:56:12 -0700
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

On Wed, Jul 29, 2026 at 12:45:47PM +0100, Pavel Begunkov wrote:
> It was exposed in early version as I was passing a [{dma,len}, ...]
> array, but we moved from that. Maybe I should put the minimum
> segment size in the map structure, and (possibly over) split using
> that for now? Keith had this chunk in his patches:
>
> +		int offset = offset_in_page(bio->bi_iter.bi_bvec_done);
> +
> +		nsegs = ALIGN(bio->bi_iter.bi_size + offset, PAGE_SIZE) >>
> +								PAGE_SHIFT;
> +		if (bio->bi_iter.bi_size > max_bytes) {
> +			bytes = max_bytes;
> +			nsegs = (bytes + offset) >> PAGE_SHIFT;
> +		} else if (nsegs > lim->max_segments) {
> +			nsegs = lim->max_segments;
> +			bytes = PAGE_SIZE * nsegs - offset;
> +		} else {
> +			*segs = nsegs;
> +			return NULL;
> +		}

This seems very pessimistic, especially for the case of the registration
only having a single segment, which I'd expect to be fairly common due
to P2P bar mappings, huge pages or IOMMU coalescing.  So at very least
we'd want to special case that, but in an idea world the caller would
be required to provide a useful nr_segments for the I/O.


