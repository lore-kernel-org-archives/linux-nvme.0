Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81518D111BF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 08:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cd7w1aJWj9RaW8qRI2u0FHF8/JEncSVlg+8XB/AbH78=; b=hDU1oMJIjp6/5R+6o67qhbudLC
	FnvSjv+woj/0fPBSZBBXIVbO+uMSZh/EuWiy72d5qo90y4zMulxw1BdzROFUNmOgJi2pykHjcu04x
	w1UZ4U1Z5paA+Ze/nVKFmkB/5+UR/iN6zLO4gP/ErPKvtNEj/hzcIYSlR7lPYjdQR6ietZYGqNNZq
	kQzPLvNMw/Vq4UzzZKRxdkx4A6E8VZStytPi5qSUHVkbopEv/oVqY2qtjgJEVgTDgrgsasaHY+FGg
	CdGxPvXISS/PPbmmZ0HHxoR0BkjXu49JGHFcSEYkR0mkKpO4Zb1/YZn/hmYIWx6AsWaVNxfFgAo/J
	rnY/S5ww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7svc-0000000D46Q-3aZj;
	Mon, 04 Nov 2024 08:59:16 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7stC-0000000D2ym-32uK
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 08:56:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 13FD4227AB3; Mon,  4 Nov 2024 09:56:43 +0100 (CET)
Date: Mon, 4 Nov 2024 09:56:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH 2/7] block: don't merge different kinds of P2P
 transfers in a single bio
Message-ID: <20241104085642.GC24211@lst.de>
References: <cover.1730037261.git.leon@kernel.org> <34d44537a65aba6ede215a8ad882aeee028b423a.1730037261.git.leon@kernel.org> <f80e7b54-b897-4df2-a49d-bc6012640a8a@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f80e7b54-b897-4df2-a49d-bc6012640a8a@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_005647_219155_CD253DAE 
X-CRM114-Status: GOOD (  10.88  )
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

On Sat, Nov 02, 2024 at 08:39:35AM +0100, Zhu Yanjun wrote

<full quote delete>

If you have something useful to say, please quote the mail you are
replying to to the context required to make sense.

Ignored for now.

