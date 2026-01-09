Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C198BD232E5
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Jan 2026 05:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X9hkYVDwdxjKLldK/bMIYELRwJHdwlWgGzt4GoFBWnk=; b=1uL4qf3HKPb5Fy698VTpDmSnR9
	WppgXnKauCaHl1L56DW6CMh9yT3FHOLXpXRi7wLmZ7TovFcUJ6vWwlQmXUcRKug6q4hfv0+L0gxO0
	+rwTX2ixbKxdIS675ZZ3Jfmpzqrzfo7DGTPSGG5TM6Fe9P+bKWkJ2+dEIeCzBXQOSkMbbL//sn/4E
	9yMFVcZYSMEY8K+JCAwgN+8BIouOOV2mKm8genuwPUhL4jHtAoyzrPSWsB6F5elc47gYxqrOIJQbK
	YjM8ogyvQ+fTEiGPXvdjS8wFIYz9YYfY8xhqu9KICONAd83N3q3XHVhd52h6dYCmIaNdq1253KmdB
	Mcf7SqOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve5WY-00000001UtT-3CW0;
	Fri, 09 Jan 2026 05:59:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ve5WU-00000001UsO-2TKe
	for linux-nvme@lists.infradead.org;
	Fri, 09 Jan 2026 05:59:00 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id ADFF367373; Fri,  9 Jan 2026 06:58:52 +0100 (CET)
Date: Fri, 9 Jan 2026 06:58:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
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
Message-ID: <20260109055852.GA5063@lst.de>
References: <7b2017f4-02a3-482a-a173-bb16b895c0cb@amd.com> <20251204110709.GA22971@lst.de> <0571ca61-7b17-4167-83eb-4269bd0459fe@amd.com> <20251204131025.GA26860@lst.de> <aVnFnzRYWC_Y5zHg@fedora> <754b4cc9-20ab-4d87-85bf-eb56be058856@amd.com> <20260107160151.GA21887@lst.de> <aV8UJvkt7VGzHjxS@fedora> <20260108101703.GA24709@lst.de> <aWBjsa2RZ_uaO9Ns@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWBjsa2RZ_uaO9Ns@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260108_215858_961213_95F3323B 
X-CRM114-Status: GOOD (  26.89  )
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

On Fri, Jan 09, 2026 at 10:10:57AM +0800, Ming Lei wrote:
> On Thu, Jan 08, 2026 at 11:17:03AM +0100, Christoph Hellwig wrote:
> > On Thu, Jan 08, 2026 at 10:19:18AM +0800, Ming Lei wrote:
> > > > The feature is in no way nvme specific.  nvme is just the initial
> > > > underlying driver.  It makes total sense to support this for any high
> > > > performance block device, and to pass it through file systems.
> > > 
> > > But why does FS care the dma buffer attachment? Since high performance
> > > host controller is exactly the dma buffer attachment point.
> > 
> > I can't parse what you're trying to say here.
> 
> dma buffer attachment is simply none of FS's business.

The file systems should indeed never do a dma buffer attachment itself,
but that's not the point.

> > But even when not stacking, the registration still needs to go
> > through the file system even for a single device, never mind multiple
> > controlled by the file system.
> 
> dma_buf can have multiple importers, so why does it have to go through FS for
> single device only?
>
> If the registered buffer is attached to single device before going
> through FS, it can not support stacking block device, and it can't or not
> easily to use for multiple block device, no matter if they are behind same
> host controller or multiple.

Because the file system, or the file_operations instance to be more
specific, is the only entity that known what block device(s) or other DMA
capable device(s) like (R)NIC a file maps to.

