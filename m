Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13128CF6AB9
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Jan 2026 10:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mf5Fl5TyeSzTLU/3MWJhqzju+t39rckia/cTJh/0f8I=; b=x+JSPhQ3buS98xKciD2mBFmc90
	CwHu49Wsy5iToP4kNS6cH1Q3RsIhe28xdN/r6I9RoWV3Ulny9NUb9QpWbt1SN9K1JWK/xlxf5+w+V
	ViCs/nkXP2yQh0rE5aZNlB18IjIXP80EhiEfNjLTqs//ni09RWTW+dbcvl3FA/nwBChVlVTYes2my
	oRakuGE7IQAXE3MgVfO4FR8zbnJs/lBQujK43S+3j8KABgZSTR6iVCGs9+LbRewe9R4epytgR4dZi
	IckZWEjMU6DoJOuBTi9EpWMopYafcKNJyHH9Q96HKoDCeEZmRNbsoDuiTmzvkhOUyLdUfaRkj6GZi
	brCA/IDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdn4y-0000000Gaez-32ut;
	Thu, 08 Jan 2026 10:17:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdn4s-0000000GadS-05bQ
	for linux-nvme@lists.infradead.org;
	Thu, 08 Jan 2026 10:17:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E3BE3227A87; Thu,  8 Jan 2026 11:17:03 +0100 (CET)
Date: Thu, 8 Jan 2026 11:17:03 +0100
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
Message-ID: <20260108101703.GA24709@lst.de>
References: <cover.1763725387.git.asml.silence@gmail.com> <74d689540fa200fe37f1a930165357a92fe9e68c.1763725387.git.asml.silence@gmail.com> <7b2017f4-02a3-482a-a173-bb16b895c0cb@amd.com> <20251204110709.GA22971@lst.de> <0571ca61-7b17-4167-83eb-4269bd0459fe@amd.com> <20251204131025.GA26860@lst.de> <aVnFnzRYWC_Y5zHg@fedora> <754b4cc9-20ab-4d87-85bf-eb56be058856@amd.com> <20260107160151.GA21887@lst.de> <aV8UJvkt7VGzHjxS@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aV8UJvkt7VGzHjxS@fedora>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260108_021714_197028_61F2B639 
X-CRM114-Status: GOOD (  18.88  )
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

On Thu, Jan 08, 2026 at 10:19:18AM +0800, Ming Lei wrote:
> > The feature is in no way nvme specific.  nvme is just the initial
> > underlying driver.  It makes total sense to support this for any high
> > performance block device, and to pass it through file systems.
> 
> But why does FS care the dma buffer attachment? Since high performance
> host controller is exactly the dma buffer attachment point.

I can't parse what you're trying to say here.

> If the callback is added in `struct file_operations` for wiring dma buffer
> and the importer(host contrller), you will see it is hard to let it cross device
> mapper/raid or other stackable block devices.

Why?

But even when not stacking, the registration still needs to go
through the file system even for a single device, never mind multiple
controlled by the file system.


