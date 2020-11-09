Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CD0C55ABD
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 08:53:49 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05356206ED
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 08:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kc98mN/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05356206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ie6OJ34YptRV3opdktVKtTKxYmHGdD0ulfMxop3nEWI=; b=kc98mN/PvPMf0gIhb8ww46xMx
	gcawfSBu3ZLWWP4EPg3056Np6oyJb40hSqHpYtWBWIIFFweuGkfi6tNSSjAMSfozHz62lSGui4S7g
	yrQ1DZ6J4/1LI/LCIU/7ci4Zqd1NjNv+7CnccJdm4nLKGGH5OyY7pakNUZtqnXGSK/77Yz1c+JBMq
	vBbQG4sLyOhWpiWaji1yvPcJKVHVY/ZMv7U/yO5qjIwT1LCfJLmUiojHNE/rSj+aarFvQWhYkEKot
	MixbwuHBlrCWjhiFlM04Ok36wMJucgEVtgLQmUfOnDNTFi5Zgqki6srlk2AFIMzuWOpMFuDUrydS+
	z+JZP+PzA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kc2vp-0008Kw-Ro; Mon, 09 Nov 2020 08:53:45 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kc2vn-0008KU-0K
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 08:53:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id AB71E6736F; Mon,  9 Nov 2020 09:53:40 +0100 (CET)
Date: Mon, 9 Nov 2020 09:53:40 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 03/24] nvme: let set_capacity_revalidate_and_notify
 update the bdev size
Message-ID: <20201109085340.GB27483@lst.de>
References: <20201106190337.1973127-1-hch@lst.de>
 <20201106190337.1973127-4-hch@lst.de>
 <1d06cdfa-a904-30be-f3ec-08ae2fa85cbd@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1d06cdfa-a904-30be-f3ec-08ae2fa85cbd@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_035343_180295_8E2635BE 
X-CRM114-Status: GOOD (  14.48  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, Christoph Hellwig <hch@lst.de>, drbd-dev@lists.linbit.com,
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org,
 Ilya Dryomov <idryomov@gmail.com>, Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-block@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-raid@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 09, 2020 at 08:53:58AM +0100, Hannes Reinecke wrote:
>> index 376096bfc54a83..4e86c9aafd88a7 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -2053,7 +2053,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
>>   			capacity = 0;
>>   	}
>>   -	set_capacity_revalidate_and_notify(disk, capacity, false);
>> +	set_capacity_revalidate_and_notify(disk, capacity, true);
>>     	nvme_config_discard(disk, ns);
>>   	nvme_config_write_zeroes(disk, ns);
>> @@ -2136,7 +2136,6 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
>>   		blk_stack_limits(&ns->head->disk->queue->limits,
>>   				 &ns->queue->limits, 0);
>>   		blk_queue_update_readahead(ns->head->disk->queue);
>> -		nvme_update_bdev_size(ns->head->disk);
>>   		blk_mq_unfreeze_queue(ns->head->disk->queue);
>>   	}
>>   #endif
>
> Hold on.
> This, at the very least, should be a separate patch.
> With this you are changing the behaviour of nvme multipath.
>
> Originally nvme multipath would update/change the size of the multipath 
> device according to the underlying path devices.
> With this patch the size of the multipath device will _not_ change if there 
> is a change on the underlying devices.

Yes, it will.  Take a close look at nvme_update_disk_info and how it is
called.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
