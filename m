Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9382FC07E95
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 02:39:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40BED610D2
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 02:39:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40BED610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z9eZb6mYUnhZij6uRmVjjI2upzOI8tTif9IW8Dh7cfg=; b=sUX5XfyQafXGm4
	woqRt4jRWTLlzEvevoD8NFWL4XC+lWLGTzGbJw+r1SUJ10RdYA2msFaw7QvATwsRXsY5icvo4X79P
	Vj09UEzTdZVOoliZHV/oE9U0aT4ST8SISEciJJ9X/rW0LeQltixa1TZUSgF7z6tvzqXpvrvmIAxaB
	GoHOVHKU5C4RiC8jqigxNwtHrkwfbHg5T+6L9ydY9Mu4oa6H/JIvDqv6YhhvklMTFvoNOA1c/JfF1
	qPMGnJot2gKN9dmP30OMnkNmsXh/YswKIQO5PTpDyOnIDP85FOG8J9ewV6DapLiqw53oRvEdEAM5N
	3D4OD0+i/Uj5IeVkSgxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5feW-00BiFu-Ae; Tue, 20 Jul 2021 02:38:36 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5feT-00BiFa-Be
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 02:38:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626748707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G3SWoqsOcAK0oX6I/hgpTqrzjtvMRxHWPl/NBHoZkvM=;
 b=ghZnFX9+8NnOGVhv/9hqM5OtwarOUehaYa3/JMLlwZhrehPyt3VD6T5zOBZFV35efv0nZr
 61ax1p0wo1a7dLtg16i8rTkxfSEWGqqJJyg86IelGEQztn0BVjVxhBxjjYw9Gmhl8dXKE4
 1rXEE4jajdmozGxuPNUH6W7L4v1F9Vs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-53-Ir__ZHnNMo2aKSHiw_R7PA-1; Mon, 19 Jul 2021 22:38:26 -0400
X-MC-Unique: Ir__ZHnNMo2aKSHiw_R7PA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6318F106B7DF;
 Tue, 20 Jul 2021 02:38:23 +0000 (UTC)
Received: from T590 (ovpn-12-229.pek2.redhat.com [10.72.12.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CFF919C79;
 Tue, 20 Jul 2021 02:38:13 +0000 (UTC)
Date: Tue, 20 Jul 2021 10:38:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: John Garry <john.garry@huawei.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 1/3] driver core: mark device as irq affinity managed
 if any irq is managed
Message-ID: <YPY3EMngyf2JFZ3j@T590>
References: <20210715120844.636968-1-ming.lei@redhat.com>
 <20210715120844.636968-2-ming.lei@redhat.com>
 <5e534fdc-909e-39b2-521d-31f643a10558@huawei.com>
 <20210719094414.GC431@lst.de>
 <5153406c-e3ed-d466-5603-14fd919304f4@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5153406c-e3ed-d466-5603-14fd919304f4@huawei.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210719_193833_531468_60532023 
X-CRM114-Status: GOOD (  28.89  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Jul 19, 2021 at 11:39:53AM +0100, John Garry wrote:
> On 19/07/2021 10:44, Christoph Hellwig wrote:
> > On Mon, Jul 19, 2021 at 08:51:22AM +0100, John Garry wrote:
> > > > Address this issue by adding one field of .irq_affinity_managed into
> > > > 'struct device'.
> > > > 
> > > > Suggested-by: Christoph Hellwig <hch@lst.de>
> > > > Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > > 
> > > Did you consider that for PCI device we effectively have this info already:
> > > 
> > > bool dev_has_managed_msi_irq(struct device *dev)
> > > {
> > > 	struct msi_desc *desc;
> > > 
> > > 	list_for_each_entry(desc, dev_to_msi_list(dev), list)
> 
> I just noticed for_each_msi_entry(), which is the same
> 
> 
> > > 		if (desc->affinity && desc->affinity->is_managed)
> > > 			return true;
> > > 	}
> > > 
> > > 	return false;
> > 
> > Just walking the list seems fine to me given that this is not a
> > performance criticial path.  But what are the locking implications?
> 
> Since it would be used for sequential setup code, I didn't think any locking
> was required. But would need to consider where that function lived and
> whether it's public.

Yeah, the allocated irq vectors should be live when running map queues.

> 
> > 
> > Also does the above imply this won't work for your platform MSI case?
> > .
> > 
> 
> Right. I think that it may be possible to reach into the platform msi
> descriptors to get this info, but I am not sure it's worth it. There is only
> 1x user there and there is no generic .map_queues function, so could set the
> flag directly:
> 
> int blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev
> *pdev,
>  		for_each_cpu(cpu, mask)
>  			qmap->mq_map[cpu] = qmap->queue_offset + queue;
>  	}
> +	qmap->use_managed_irq = dev_has_managed_msi_irq(&pdev->dev);
> }
> 
> --- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
> @@ -3563,6 +3563,8 @@ static int map_queues_v2_hw(struct Scsi_Host *shost)
>                        qmap->mq_map[cpu] = qmap->queue_offset + queue;
>        }
> 
> +       qmap->use_managed_irq = 1;
> +
>        return 0;

virtio can be populated via platform device too, but managed irq affinity
isn't used, so seems dev_has_managed_msi_irq() is fine.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
