Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52306CFB422
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Nov 2024 08:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XJMROuE4JjYsw4wo8HK5SvAvW9x90cNUd3R+iiehUbQ=; b=MA2LVrzYhCzMqmEtfdlZM2qwLB
	+pJSCRLQKVAMMzw9ZSBn3/HJ9UgcznIbpkvARfUWnJ20xYGMDuXgxbaueG3VnJxdybRXKJlQlrEH+
	50xj6igvQb+nHzhLVJIPiQ8HfcI2oBMTJwF+ybw+DmWj2e++oQPxhylKtWk8TGiWt3vkB21cOLHgR
	Wsl6d2z+K37mWz2s0BGKMQNFsYf1XGTNKV7UYCzby/KDzgbnHdbgJY6RP66DocQvWAVoOSTL4pHJE
	TtX/Gtk+uWP+d2ppUeOxzzeGBGo0yCvmz9UyUK7Tnf5SqZFRS1AyrQhMo6WGFr9/T/33WqX7o+dFg
	3BiN1N2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7ssn-0000000D2ge-3aMf;
	Mon, 04 Nov 2024 08:56:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7ss1-0000000D2OJ-241h
	for linux-nvme@lists.infradead.org;
	Mon, 04 Nov 2024 08:55:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 95EF3227AAD; Mon,  4 Nov 2024 09:55:21 +0100 (CET)
Date: Mon, 4 Nov 2024 09:55:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bart Van Assche <bvanassche@acm.org>
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
Subject: Re: [RFC PATCH 1/7] block: share more code for bio addition helpers
Message-ID: <20241104085521.GA24211@lst.de>
References: <cover.1730037261.git.leon@kernel.org> <e6be9d87a3ca1a2f9c27bce73fbab559c21c765f.1730037261.git.leon@kernel.org> <4c7e679a-d3e6-4426-a679-ee581b5c728c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c7e679a-d3e6-4426-a679-ee581b5c728c@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241104_005533_684168_CA2D24FB 
X-CRM114-Status: GOOD (  13.98  )
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

On Thu, Oct 31, 2024 at 01:55:11PM -0700, Bart Van Assche wrote:
> Does "_int" stand for "_internal"? If so, please consider changing it
> into "_impl". I think that will prevent that anyone confuses this suffix
> with the "int" data type.

_impl is even more unusual than _int, so no.


