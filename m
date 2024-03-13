Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4902C54E58
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 08:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4FQ4qNojKHxYbM+mjcMGc+v03sD6jBJ9rR92BjQFE/k=; b=WCZUDEkdXaByhHq4LPJ8Yj4/5t
	3a/Ur8FR+on0NZBsTKZdc5vj4HfEKxnis8Dq6xMfE0Va9xyTirNGT9Cbjb8edWYlHo+xnL44mrR8T
	Jg56HTCUwR3XNtoznMyumleA23ivZqlyKUMRSzH7Koi3FDEEIkGEJr/3UPzJKU1D5EykhX8/vcA7O
	EEdy46FKbOJeDWZWL8lAMN6cnb531U3f6/OtTcmYukhJXZmmFBuUQ3WH25TfBrwouahfsDkfmPP7a
	79JWtSf/eXMPRxeUS18c13UgNNmdN+pliMO7e0yIYHs5js0SUO6OREEyWH+W4o7lkxwFXkN21UcCN
	1oQzIDSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnDOj-00000002EY0-1S9i;
	Thu, 21 Mar 2024 08:03:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rkWOd-0000000ByVc-3dIs
	for linux-nvme@lists.infradead.org;
	Wed, 13 Mar 2024 21:44:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8161568BFE; Wed, 13 Mar 2024 22:44:18 +0100 (CET)
Date: Wed, 13 Mar 2024 22:44:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two
 steps
Message-ID: <20240313214418.GA9129@lst.de>
References: <20240306221400.GA8663@lst.de> <20240307000036.GP9225@ziepe.ca> <20240307150505.GA28978@lst.de> <20240307210116.GQ9225@ziepe.ca> <20240308164920.GA17991@lst.de> <20240308202342.GZ9225@ziepe.ca> <20240309161418.GA27113@lst.de> <20240310093513.GB12921@unreal> <20240312212844.GA3018@lst.de> <20240313074636.GV12921@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313074636.GV12921@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240313_144424_197473_BE40E6F1 
X-CRM114-Status: GOOD (  18.52  )
X-Mailman-Approved-At: Thu, 21 Mar 2024 01:03:35 -0700
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

On Wed, Mar 13, 2024 at 09:46:36AM +0200, Leon Romanovsky wrote:
> On Tue, Mar 12, 2024 at 10:28:44PM +0100, Christoph Hellwig wrote:
> > On Sun, Mar 10, 2024 at 11:35:13AM +0200, Leon Romanovsky wrote:
> > > And you will need to have a way to instruct that pin_user_pages() variant
> > > to continue anyway, because you asked for FOLL_PCI_P2PDMA. Without that
> > > force, you will have !FOLL_PCI_P2PDMA behaviour.
> > 
> > I don't understand what you mean.
> 
> Jason talked about the need to call to pin_user_pages(..., gup_flags | FOLL_PCI_P2PDMA, ...),
> but in your proposal this call won't be possible anymore.

Why?


