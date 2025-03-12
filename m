Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF12C28B28
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Mar 2025 06:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QcXOYRCH0+rzrtF5eKJ9mNGNA8kBZEbH+ucO4R4KXyE=; b=x8nCSf1W3V0WeM93Jmm+ojTPSD
	g4MlSAIuDwHVHuO3GS8EReSLHROtTY8/ygwW/AifpvZkJ6Gfv83kUFh3/rPOakJqhsW/msrFXpMCX
	LEbCziyOOifCjmKB3xCCHrhpIbe7hSGMmEyWSdws2txU9og0FFjUHOUGv17E2QaIsV+BgOoiBS9Qg
	KQ5yxkQP4/p1OGf8IJWHp0X5kvBTIOGhS0MTY3ITI4jE3OLDPArcz84ytjJhtDlFUPo4YKOvSIrzy
	0XUEvsXmEeR8whZYsgnHWRIwtNAmfBC8SoJDI5SiNiGTqLEgxIHPsO5sWVIPbkrKyAWluvWu66ZNR
	Zm0QDoWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tsF8J-00000007YIw-3Pkl;
	Wed, 12 Mar 2025 05:59:59 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tsF8E-00000007YHO-3CIm;
	Wed, 12 Mar 2025 05:59:54 +0000
Date: Tue, 11 Mar 2025 22:59:54 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alan Adamson <alan.adamson@oracle.com>,
	virtualization@lists.linux.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH v2 2/2] block: change blk_mq_add_to_batch() third
 argument type to bool
Message-ID: <Z9Ei2t7z_7QbEWXW@infradead.org>
References: <20250311104359.1767728-1-shinichiro.kawasaki@wdc.com>
 <20250311104359.1767728-3-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311104359.1767728-3-shinichiro.kawasaki@wdc.com>
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

On Tue, Mar 11, 2025 at 07:43:59PM +0900, Shin'ichiro Kawasaki wrote:
>  /*
>   * Batched completions only work when there is no I/O error and no special
>   * ->end_io handler.
> + *
> + * @req: The request to add to batch
> + * @iob: The batch to add the request
> + * @is_error: Specify true if the request failed with an error
> + * @io_comp_batch: The completaion handler for the request
>   */

This needs more work to be a proper kerneldoc comment, i.e. start with
"/*8", mention the function name, etc.

The logic changes themselves look good.

