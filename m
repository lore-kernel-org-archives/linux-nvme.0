Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5756EC28B2F
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Mar 2025 08:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1kZVljBVvsXxXbMsud/oOo6ecmq2RS1CrhGptHL+sfk=; b=WF4pvjnDiz09WGCMcapMWC13hc
	C7ieT33YWmWgpbTzcBSIosCeNndYSzKDMgqSyW2pHjKjToG2lR8LYExoxQpfR3Wdol6RwGM/LoW62
	d9DshmIHHR7FU4V4IlryfeE88UYNul453fg8qUy1iCzG+Uc93kSwfcIc0nPxxEJ2kYY1E/4gfUDcZ
	ZuDKH/vN/oRHe31FJsYtbNvIBU1HdXvyg/NBUTnf8FTyVlC/gQ/PEzo1c482/9bIATNrDDZA4ioPl
	qyJZrA+a+i3B7AsTCIfjjTO6VmjVdqp+LVA02Y+FB7JRdzixzEDpR9hoBe8ir5uR8FxMzpkztyyk1
	tm4Xx7oQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trulq-00000004ybi-3NPG;
	Tue, 11 Mar 2025 08:15:26 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1trujV-00000004y8R-2zab;
	Tue, 11 Mar 2025 08:13:01 +0000
Date: Tue, 11 Mar 2025 01:13:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alan Adamson <alan.adamson@oracle.com>,
	virtualization@lists.linux.dev, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Sven Peter <sven@svenpeter.dev>, Janne Grunau <j@jannau.net>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: Re: [PATCH 2/2] block: change blk_mq_add_to_batch() third argument
 type to blk_status_t
Message-ID: <Z8_wjZUNvM7JAWAQ@infradead.org>
References: <20250311024144.1762333-1-shinichiro.kawasaki@wdc.com>
 <20250311024144.1762333-3-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311024144.1762333-3-shinichiro.kawasaki@wdc.com>
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

On Tue, Mar 11, 2025 at 11:41:44AM +0900, Shin'ichiro Kawasaki wrote:
> However, blk_mq_add_to_batch() callers do not pass negative error
> values. Instead, they pass status codes defined in various ways:
> 
> - NVMe PCI and Apple drivers pass NVMe status code
> - virtio_blk driver passes the virtblk request header status byte
> - null_blk driver passes blk_status_t

The __force cast in null_blk should have been a big fat warning..

> To correct the ioerror check within blk_mq_add_to_batch(), make all
> callers to uniformly pass the argument as blk_status_t. Modify the
> callers to translate their specific status codes into blk_status_t. For
> this translation, export the helper function nvme_error_status(). Adjust
> blk_mq_add_to_batch() to translate blk_status_t back into the error
> number for the appropriate check.

This still looks a bit ugly because of all the conversions to a
blk_status_t just to convert it back to a errno just to check for
a non-zero value (blk_status_to_errno can't return a positive value).

I suspect simply passing a "bool is_error" might actually be cleaner
than that, combined with a proper kerneldoc comment for
blk_mq_add_to_batch explaining how to set it?


