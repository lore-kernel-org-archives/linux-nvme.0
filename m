Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D803CCD4851
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2026 08:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6JVgeflBpLb0UlR56W9U3lAnSwztjCuRIktp4MhYVj8=; b=Uhk+jjJdvpDZESCg7BcRO6Je8T
	1kyml7jLDfvnXcrR4Lxt0bWklTCETDgK4QncaOCQ9WzNowLwJT3pM+zwaKCwoMLMz/PU7enMVPH+v
	20JvFkS5t35eKNdThBPs/MC2YmsXnVfvHhQ2zdIMzoKdiNerxkdvc5U7cjVjblbzvzWwbQk8WoFAG
	ri40vt4Tb8qmt0CImLs5xpYATVGXfN1XUVTubLG5iZQOvJaLceV3wZSIOUa02WVeJyY1+zJI5r7yN
	JukW4WHEWq+JA5wQr3vPU0RzjFy0vVVWORiADZZ2Nq6DkFm8JxuPXl8DlTXfEABTEmo9db6rouoaZ
	wD7XoGPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN4uk-00000001jY3-2iee;
	Wed, 13 May 2026 08:25:58 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN4ui-00000001jXQ-1q1l
	for linux-nvme@lists.infradead.org;
	Wed, 13 May 2026 08:25:57 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CD03168BEB; Wed, 13 May 2026 10:25:53 +0200 (CEST)
Date: Wed, 13 May 2026 10:25:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 06/10] block: forward create_dmabuf_token to drivers
Message-ID: <20260513082553.GB6461@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <559756c5e22dcfa183080a979de039910d1b896d.1777475843.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <559756c5e22dcfa183080a979de039910d1b896d.1777475843.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_012556_622393_45E2460D 
X-CRM114-Status: GOOD (  13.32  )
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

On Wed, Apr 29, 2026 at 04:25:52PM +0100, Pavel Begunkov wrote:
> Add a trivial implementation of the create_dmabuf_token call for
> block devices that forwards the call to a new blk-mq callback if it's
> available.

This should go into block_device_operations as there is nothing blk-mq
specific about this.  I.e. even if this patchset doesn't handle stacking
drivers yet, it should be easy enough to add them in the future.


