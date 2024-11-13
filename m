Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAD2D462B2
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 14:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qTbgyEmoiXBmcMLenXefvWWCblqliLRQAAnAbTZlpLw=; b=XD+bU6nZO7cvZikhJYyBVKCdP+
	daSeDssJTfkwZu6xjqqQTlYsxpqNclqxlBMqNQhemI+wmOeZAY1xZsliZJfMFeycyQkCeCJp2UJi/
	IUv7/lSxOa/v2POznkaxRZs3C847K6R4aTtUjDpugUzQxfcRfGE41IdaWJ7MsMDuKmIP37GKbDgxv
	+5+WNfMdjJiElh+rIc6ENGLI4cLHB+IhH1f+ZknBhe44o7JoiL5U4vCzNhco2Z7fqPfCVgMTOjVGX
	yoJhBhDkilu4Al8BKO4Hgkq/8oGaHpn1Gy8WZGbusR9qcoIQUvR/b38Sf8HyySqLtMtlu80R3Tpc4
	Tt7EScrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBEOT-000000079go-1vqV;
	Wed, 13 Nov 2024 14:30:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBEOP-000000079eM-3ZN9
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 14:30:51 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C525C68C4E; Wed, 13 Nov 2024 15:30:39 +0100 (CET)
Date: Wed, 13 Nov 2024 15:30:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Garry <john.g.garry@oracle.com>, Daniel Wagner <dwagner@suse.de>,
	Daniel Wagner <wagi@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 1/8] driver core: bus: add irq_get_affinity callback
 to bus_type
Message-ID: <20241113143039.GA20331@lst.de>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org> <20241112-refactor-blk-affinity-helpers-v3-1-573bfca0cbd8@kernel.org> <76da6c05-4f28-41cc-a48e-da2ae16c64c4@oracle.com> <2d85aa5e-037a-45c3-9f2d-e46b2159b697@flourine.local> <bed15207-c3d8-4e0b-b356-4880f5a4fdff@oracle.com> <2024111323-darkening-sappy-23fa@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024111323-darkening-sappy-23fa@gregkh>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_063050_050872_C8CCE933 
X-CRM114-Status: GOOD (  16.69  )
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

On Wed, Nov 13, 2024 at 02:54:23PM +0100, Greg Kroah-Hartman wrote:
> bus types are good to set it at a bus level so you don't have to
> explicitly set it at each-and-every-driver.  Depends on what you want
> this to be, if it is a "all drivers of this bus type will have the same
> callback" then put it on the bus.  otherwise if you are going to
> mix/match on a same bus, then put it in the driver structure.

... and that is exactly the case here.  The driver itself has no business
being involved.

