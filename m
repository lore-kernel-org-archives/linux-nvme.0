Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D0A6CF6BF1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 06:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oh63mDfEalXEPQPRp8+Q4ZzWNt5fc+8HeHhaJk9PdeA=; b=LWEBWUhKHFxBmcfLkSevVE551a
	/8IUi3WDIil1JVZyf/tmaZqO3fS4IETtJYe/nUP0jgB7kd925qJxEVMNvaYj363XBPxxTKWgftu0g
	RDR3tZP6Bc0rEqt/vQZ4ak+Syz/+rORPC6WqNbm4cWCIZI9DnuJ8K+VO6VpwfZJHhXHP1IM4YiFk9
	4mT3QTzQx+zGnsuWABxjvFfAOgvnR6SmIk375dKHF1HyDfbFzXaUPVAhzcF6+5dQ0MB5VCUXAB1/F
	NDoru8GEzMoXcSb5yTYaR0rAz/DOpH64ellR2sloiQPk/BS31v2Jmeeg/Yfhu3p4FxEXX60plE0lk
	oPCjLHZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdMsp-0000000ECxm-0Nvu;
	Wed, 07 Jan 2026 06:19:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdMsm-0000000ECxR-1cTW
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 06:19:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B3B6227A87; Wed,  7 Jan 2026 07:18:52 +0100 (CET)
Date: Wed, 7 Jan 2026 07:18:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	Vishal Verma <vishal1.verma@intel.com>, tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC v2 01/11] file: add callback for pre-mapping dmabuf
Message-ID: <20260107061851.GA15324@lst.de>
References: <cover.1763725387.git.asml.silence@gmail.com> <74d689540fa200fe37f1a930165357a92fe9e68c.1763725387.git.asml.silence@gmail.com> <7b2017f4-02a3-482a-a173-bb16b895c0cb@amd.com> <20251204110709.GA22971@lst.de> <0571ca61-7b17-4167-83eb-4269bd0459fe@amd.com> <20251204131025.GA26860@lst.de> <aVnFnzRYWC_Y5zHg@fedora> <a96e327d-3fef-4d08-87e9-c65866223967@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a96e327d-3fef-4d08-87e9-c65866223967@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260106_221900_597562_12EB366B 
X-CRM114-Status: GOOD (  16.46  )
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

On Tue, Jan 06, 2026 at 07:51:12PM +0000, Pavel Begunkov wrote:
>> But I am wondering why not make it as one subsystem interface, such as nvme
>> ioctl, then the whole implementation can be simplified a lot. It is reasonable
>> because subsystem is exactly the side for consuming/importing the dma-buf.
>
> It's not an nvme specific interface, and so a file op was much more
> convenient.

It is the much better abstraction.  Also the nvme subsystems is not
an actor, and registering things to the subsystems does not work.
The nvme controller is the entity that does the dma mapping, and this
interface works very well for that.


