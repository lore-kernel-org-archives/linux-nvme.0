Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E54C982FA
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 13:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=guohS5YV9dRdJleOQU/qgo9Y8mhsnVIEuBXBuHTgTwM=; b=ABnbTrTM2Bfz92k9SL0Z1sao86
	GwmkCp3ObXpvPDVVDWpLmqV0gJfeOXJAV7WdLmimO4jOQz4RSPOg/mX/D7bW3v/cb6qe5TMkg4lus
	lacxp/TpsZT2IwSEtZKaPwRnZJTI6wcTE+0Slb26DBKDi77ZR+ZLYneh5ibaasQ1VupLnnFp/CECu
	v7sa9qPlBKKLWTm0PSusMnQ4mzl4lFSwsli2+N4ZkMzXuKw+smp9LlYD/rJ7GcBVCVX584LWvg9nl
	doiPEFZNmh0fSN15qaJhtNHpRmZKcleslbmjqGIUWEEocpa/CXucLhRQt70+VO0VG63A+mjyh5ooi
	d3O7mAFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90Sv-00000005VTY-2t4m;
	Tue, 22 Sep 2026 13:23:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x90Q3-00000005Ut1-2JOF
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 13:20:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8030168C7B; Tue, 22 Sep 2026 15:20:17 +0200 (CEST)
Date: Tue, 22 Sep 2026 15:20:16 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	Sumit Semwal <sumit.semwal@linaro.org>,
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
Message-ID: <20260922132016.GA30684@lst.de>
References: <cover.1789997898.git.asml.silence@gmail.com> <e80c3b1e0de004eaca6c51a2a86115ac9ed36381.1789997898.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e80c3b1e0de004eaca6c51a2a86115ac9ed36381.1789997898.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_062023_751112_C38261EA 
X-CRM114-Status: GOOD (  13.15  )
X-Mailman-Approved-At: Tue, 22 Sep 2026 06:23:21 -0700
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

On Mon, Sep 21, 2026 at 02:38:50PM +0100, Pavel Begunkov wrote:
> Enable BIO_DMABUF_MAP backed requests. On registration we map the

This is now REQ_DMABUF.

Sashiko had a few comments, which I think are correct - if we use
dma_map_sg to map the data, we need to use the sync_sg APIs to
transfer ownership.  That only matters on non-coherent architectures
with MMU, but we need to get it right.

And the reset deadlock also looks plausible.


