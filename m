Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 378FCCA5FCE
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2026 09:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kZqoRtJdzpwXeUnPsq5ZIsjoGcUejUbZ/DedjSRjtMU=; b=wBNN2zh5JPIhcykHiUzB3gNaHL
	3ZY32DTATasTjHG4sZKGbdjtpW1ydfE4f3H9h0+r29gqZdBmUbq3e3J2rlNHyPKBUchjNOjPqtihk
	sP49HKqrc6+YEB8r0C3793oXpnExMQDRePLlJR61tGbqhxzYF6e7dMhlZvG6nGOWM0OmoG692AAqv
	6k7OC2oT0yQPO+zfILaRCmIYm5Wq3alLfOyZ7A2nlZOGDF3xjcPv8wVgx18dwyMv2ibaLMZUjjZOA
	hsTxjcoLfXoKAURMkU60eEM2d8Xpx91omWRMSpDozj2iFW0HP8Yw0O8uF6JW824h5H0lc7NtoqrhE
	ih2XuYNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDeoi-0000000Fz78-2A77;
	Mon, 05 Oct 2026 09:17:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xDej5-0000000FyTZ-1cO6
	for linux-nvme@lists.infradead.org;
	Mon, 05 Oct 2026 09:11:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id BD5A468C4E; Mon,  5 Oct 2026 11:11:11 +0200 (CEST)
Date: Mon, 5 Oct 2026 11:11:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
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
Subject: Re: [PATCH v7 05/13] block: add dma-buf support for raw bdev
Message-ID: <20261005091111.GB10727@lst.de>
References: <cover.1790602223.git.asml.silence@gmail.com> <a6b81e65b1f09b6ed1f71f294e5a94896ea1ead7.1790602223.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6b81e65b1f09b6ed1f71f294e5a94896ea1ead7.1790602223.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261005_021115_595049_25DED875 
X-CRM114-Status: GOOD (  12.89  )
X-Mailman-Approved-At: Mon, 05 Oct 2026 02:16:59 -0700
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

On Mon, Sep 28, 2026 at 02:32:21PM +0100, Pavel Begunkov wrote:
> Add a simple proxy implementation of init_dma_buf_io_ctx() forwarding
> the call to a new struct block_device_operations operation. Also reject
> dma-buf backed iterators for buffered IO.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> [pavel: reject dma-buf without O_DIRECT]
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>

The Sashiko report about the errno on fallback here looks real,
and is probably easily fixed by setting a proper errno.


