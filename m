Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AC3D462A2
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 13:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9jYgVThsvte0BEQIGpjTNIFqL/mtJ1KLr8xMq9a3Pd0=; b=GvZ1oI2V7e5x4fe+Qod97qyTUB
	wRbVMHPtl1bVXPrWdXGjjBnYrde0rKvjDg7R3ntJPB1ol6DlTscEsepksS5dtrVk91nhu8+lnPami
	A0R6jIJSVL6jmf8wQaukzOpHhv7Ie6Pu6LVnPiVXm8y84vvsvdc3YrdQjHxXOU+G2h6HNSAvshcnp
	0UfCfA/nmUs9QdN0tYyRAd6enbLQmhNlkPO+GtpXBuloDPaF40gZYSSm0IacTq6F1quXYjVxG7qXV
	onBS5coaJJDQVcszOc5C2nyR/t2Qa9p3qc7bNWndKAxm+sw+gTWub3quaw0crhRaDcuqS9KTlBhjM
	Qklu8clw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBDpG-00000007089-0le3;
	Wed, 13 Nov 2024 13:54:30 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBDpE-0000000706Y-0otr
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 13:54:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E1DA4A40BE8;
	Wed, 13 Nov 2024 13:52:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5DDC4CEC3;
	Wed, 13 Nov 2024 13:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1731506066;
	bh=3B/JCdh4iX3172gc1ZApZTKHI0NdrBjDEoJdyOuJKVg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GTnOZNgKse/6G382NfGAX65+kCSYHKUzAxz0956dUBqo8v40DlGKgyR586nlN3IJw
	 ofuXXUrwDQCp6V46XTbPsSv3ex0dB+Jo9L1ITVX0d2b4pwAhhbQ3/s/gAyosdw64y+
	 sgZN9gs5iFNYdC0rf0Gt40QH65rx3mjQHbcDeOu0=
Date: Wed, 13 Nov 2024 14:54:23 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Daniel Wagner <dwagner@suse.de>, Daniel Wagner <wagi@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>,
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
Message-ID: <2024111323-darkening-sappy-23fa@gregkh>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
 <20241112-refactor-blk-affinity-helpers-v3-1-573bfca0cbd8@kernel.org>
 <76da6c05-4f28-41cc-a48e-da2ae16c64c4@oracle.com>
 <2d85aa5e-037a-45c3-9f2d-e46b2159b697@flourine.local>
 <bed15207-c3d8-4e0b-b356-4880f5a4fdff@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bed15207-c3d8-4e0b-b356-4880f5a4fdff@oracle.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_055428_382073_13C49E15 
X-CRM114-Status: GOOD (  36.34  )
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

On Wed, Nov 13, 2024 at 01:44:02PM +0000, John Garry wrote:
> On 13/11/2024 12:36, Daniel Wagner wrote:
> > > > @@ -48,6 +48,7 @@ struct fwnode_handle;
> > > >     *		will never get called until they do.
> > > >     * @remove:	Called when a device removed from this bus.
> > > My impression is that this would be better suited to "struct device_driver",
> > > but I assume that there is a good reason to add to "struct bus_type".
> > I think the main reason to put it here is that most of the drivers are
> > happy with the getter on bus level and don't need special treatment. We
> > don't have to touch all the drivers to hookup a common getter, nor do we
> > have to install a default handler when the driver doesn't specify one.
> > Having the callback in struct bus_driver avoids this. Though Christoph
> > suggested it, so I can only guess.
> > 
> > But you bring up a good point, if we had also an irq_get_affinity
> > callback in struct device_driver it would be possible for the
> > hisi_sas v2 driver to provide a getter and blk_mq_hctx_map_queues could
> > do:
> > 
> > 	for (queue = 0; queue < qmap->nr_queues; queue++) {
> > 		if (dev->driver->irq_get_affinity)
> > 			mask = dev->driver->irq_get_affinity;
> > 		else if (dev->bus->irq_get_affinity)
> > 			mask = dev->bus->irq_get_affinity(dev, queue + offset);
> > 		if (!mask)
> > 			goto fallback;
> > 
> > 		for_each_cpu(cpu, mask)
> > 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
> > 	}
> > 
> > and with this in place the open coded version in hisi_sas v2 can also be
> > replaced.
> 
> Yeah, I think that it could be plugged in like:
> 
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> index 342d75f12051..5172af77a3f0 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> @@ -3636,6 +3636,7 @@ static struct platform_driver hisi_sas_v2_driver = {
>                .name = DRV_NAME,
>                .of_match_table = sas_v2_of_match,
>                .acpi_match_table = ACPI_PTR(sas_v2_acpi_match),
> +               .irq_get_affinity_mask = hisi_sas_v2_get_affinity_mask,
>        },
> };
> 
> 
> > If no one objects, I go ahead and add the callback to struct
> > device_driver.
> 
> I'd wait for Christoph and Greg to both agree. I was just wondering why we
> use bus_type.

bus types are good to set it at a bus level so you don't have to
explicitly set it at each-and-every-driver.  Depends on what you want
this to be, if it is a "all drivers of this bus type will have the same
callback" then put it on the bus.  otherwise if you are going to
mix/match on a same bus, then put it in the driver structure.

hope this helps,

greg k-h

