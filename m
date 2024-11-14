Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 604CBD65C7E
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Nov 2024 12:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L/zV2KAxpZjydWsNw57XwUMhutjZiU+Vw7I7EOnl0yY=; b=mG3xBt7VX2qzP1mJ6v19BcT6uY
	J0cWJmLh9MDCtxobs1Icpp9jaKW9X4pHMEFIqydRZO2kyUG9FkzKu1uJWAFZ0cVxvAU9wJsm5cPFi
	/IZGMhOK6MghiXF8A+7kp4Kj0lWj2p+Xrm4J/WsqtGVzQEvwMKrF4va82lZz8aIwa4HrS0dylLwDY
	pe1AXzmyc9jZzYYLSPcnxkuiksQm/I2yNZoQzf8Kh7l5Rr3mxmuHmHSuDb2w5j0o4/UC8irF7pqiL
	sLodngAA2HT0bA2VKlMsq45kCsjPJFz1oolV7kQLfIvmTnhEfBwduRDqM89Ft6dPEOlAzGkSQ7NEc
	dAZLSBLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYhm-00000009rgY-035P;
	Thu, 14 Nov 2024 12:12:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBYhY-00000009rcJ-0Qnx
	for linux-nvme@lists.infradead.org;
	Thu, 14 Nov 2024 12:12:07 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 47A2568C7B; Thu, 14 Nov 2024 13:11:47 +0100 (CET)
Date: Thu, 14 Nov 2024 13:11:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>, Daniel Wagner <wagi@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	John Garry <john.g.garry@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev, linux-scsi@vger.kernel.org,
	megaraidlinux.pdl@broadcom.com, mpi3mr-linuxdrv.pdl@broadcom.com,
	MPT-FusionLinux.pdl@broadcom.com, storagedev@microchip.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4 05/10] blk-mq: introduce blk_mq_hctx_map_queues
Message-ID: <20241114121147.GA3074@lst.de>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org> <20241113-refactor-blk-affinity-helpers-v4-5-dd3baa1e267f@kernel.org> <ZzVZQbZOYhNF08LX@fedora> <9fa26099-1922-4b99-883e-bd5f6c58162a@flourine.local> <ZzW-9rWvKBxFZU1E@fedora> <4bd491e5-fab5-4e94-8719-560b5a4de01e@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4bd491e5-fab5-4e94-8719-560b5a4de01e@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241114_041156_319175_40FAF94B 
X-CRM114-Status: GOOD (  15.30  )
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

On Thu, Nov 14, 2024 at 01:06:49PM +0100, Daniel Wagner wrote:
> Oh, I was not aware of this ordering. And after digging this up here:
> 
> https://lore.kernel.org/all/20060105142951.13.01@flint.arm.linux.org.uk/
> 
> I don't think we it's worthwhile to add the callback to device_driver
> just for hisi_sas_v2. So I am going to drop this part again.

Yes, I don't really see how querying driver specific information like
this from code called by the driver make much sense. 


