Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88273CCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 07:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6f3wj+htQY02A3eK8hl9PDeuv/RAKbJlKOgP0LTJDLo=; b=rPN42+AQVW0JWlAV7WZ3LmybvE
	Unv+srLSaxSMQRMiqYTx1leEkMFJWxCfqk+9OBZ01Zasf4psbf0y5C7KwxDlwL/8gPxHjzg7xzR/s
	RE/pxYUQ33DJJoIPilSRgoSp2HSS4N0aGUDn0ouRhADdy5XgKnbt+QlRWorZ3hlNVfbIerPnHHkaI
	S5F12PLPE0Mx8TbB56JglTw+3YBhMWLt405xoyBkJJYpxeaTffr+rZo8oNADfMA1TSjhzc25Gh0BU
	Y+OtUizxt7g0SMEyfjCegz8wRHODbBOjA5y2P8j2kidHQ04oUuYM4yGk6dtO/c5qUIIBs5LddMCFG
	jnOZY4XA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFp1V-00000009MQ7-33z8;
	Mon, 03 Nov 2025 07:30:41 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFp1U-00000009MPy-2Zwh
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 07:30:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 60DB7601D5;
	Mon,  3 Nov 2025 07:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC116C4CEE7;
	Mon,  3 Nov 2025 07:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762155038;
	bh=fNPEgWhmKcSfXgHxY8vQ6zDm8hy1QN8YPkQR/O50gEk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GwOFFC0Qu1g/MgQu4yB4BGazeSYVXu7QOTJ+EMkLVI5N1EIFimk3bn1scoQrD6vLC
	 Evn9J2oxFzNX2KdKVdDmZ0XS4naB8WkFv1YBXXniCy7oV8GIcNkU4AVFd7VZm0pOeH
	 E/dIFrMTSQ0q9jnaWOTnNGr2oUBbpYqhm3LzpVaqG93dMBejtWBMCCq4T0Xylgzj0+
	 k4KReocg/4eFiPA9zBQK+mq2IbffujegIuTfbQq1WUEHY7Fv4BrDVgc6gtp2NyP0AI
	 wbtkqReZ9p8BS+4ut/UwgOmK1SbuBxOt7mSCer/fPybYFflSsYlOsUJ6rnOlMbUfPs
	 RsxmdR54fDyvg==
Message-ID: <f0124d2d-880a-4c44-bd42-178838891b20@kernel.org>
Date: Mon, 3 Nov 2025 16:30:34 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/13] block: freeze queue when updating zone resources
To: Daniel Vacek <neelx@suse.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-2-dlemoal@kernel.org>
 <55887a39-21ee-4e6c-a6f3-19d75af6395a@acm.org>
 <bd71691f-e230-42ca-8920-d93bf1ea6371@kernel.org>
 <CAPjX3FebPLu_P=-BuP63VuaiAnC62rthcQ0vb+J8b-w0OckyqA@mail.gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <CAPjX3FebPLu_P=-BuP63VuaiAnC62rthcQ0vb+J8b-w0OckyqA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 11/3/25 16:18, Daniel Vacek wrote:
> On Mon, 3 Nov 2025 at 06:55, Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 11/1/25 02:48, Bart Van Assche wrote:
>>> Hi Damien,
>>>
>>> disk_update_zone_resources() only has a single caller and just below the
>>> only call of this function the following code is present:
>>>
>>>       if (ret) {
>>>               unsigned int memflags = blk_mq_freeze_queue(q);
>>>
>>>               disk_free_zone_resources(disk);
>>>               blk_mq_unfreeze_queue(q, memflags);
>>>       }
>>>
>>> Shouldn't this code be moved into disk_update_zone_resources() such that
>>> error handling happens without unfreezing and refreezing the request
>>> queue?
>>
>> Check the code again. disk_free_zone_resources() if the report zones callbacks
>> return an error, and in that case disk_update_zone_resources() is not called.
>> So having this call as it is cover all cases.
> 
> I understand Bart's idea was more like below:
> 
>> @@ -1568,7 +1572,12 @@ static int disk_update_zone_resources(str
> uct gendisk *disk,
>>       }
>>
>>   commit:
>> -     return queue_limits_commit_update_frozen(q, &lim);
>> +     ret = queue_limits_commit_update(q, &lim);
>> +
>> +unfreeze:
> 
> +       if (ret)
> +               disk_free_zone_resources(disk);
> 
>> +     blk_mq_unfreeze_queue(q, memflags);
>> +
>> +     return ret;
>>   }
>>
>>   static int blk_revalidate_conv_zone(struct blk_zone *zone, unsigned int idx,
> 
> And then in blk_revalidate_disk_zones() do this:
> 
>         if (ret > 0) {
>                 ret = disk_update_zone_resources(disk, &args);
>         } else if (ret) {
>                 unsigned int memflags;
> 
>                 pr_warn("%s: failed to revalidate zones\n", disk->disk_name);
> 
>                memflags = blk_mq_freeze_queue(q);
>                disk_free_zone_resources(disk);
>                 blk_mq_unfreeze_queue(q, memflags);
>         }
> 
> The question remains if this looks better?

Rereading everything, I think that Bart has a good point: moving the call to
disk_free_zone_resources() in the error path of disk_update_zone_resources()
allows doing the error handling without unfreezing and re-freezing the queue.
That's better.


-- 
Damien Le Moal
Western Digital Research

