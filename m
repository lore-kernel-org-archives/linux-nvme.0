Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3810CCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 07:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z9EIDJVHnxWpXuSmkqFNiQkRmlR2kW4dcxeWiKJPX3o=; b=j2SDChD6WnrWLgB70r9TKB+ujP
	Ph2o+1NRiDfQFxfYIUr9Em615WeiSlk7nuGXpA6rx2LV2j4nIL0zGGOYmMW4+9ewGIkHFvBCZAUdh
	HMO3YRIxJlNbu0DXLBET7MlzGLxu7iPuqmovrN4wzpNjkMVhDTdFTVoPkEcFomYW82xT9DXA0tv5i
	y7lr2dM/Ld2i+FZyItVKRW9IQVRFzTCTqvHDXs5mvMxgtA76pnj70+TTUbBZ57r5kNJUgv6NQjc16
	aDGGa8MwBIur80W5zf5tRJ2NyV/sBwEoDwB7r45prQ9IZ2jpf5R5XxpcpL9hARvzf+A4xaFnGtdtx
	dkUfvMBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFov8-00000009LvC-1BiP;
	Mon, 03 Nov 2025 07:24:06 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFov6-00000009Luo-1W3L
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 07:24:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AC31143A3B;
	Mon,  3 Nov 2025 07:24:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7AC9C4CEE7;
	Mon,  3 Nov 2025 07:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762154643;
	bh=4Z0nKMuf7VyPhF4RUcEACaMRlP3hxFLzOsnTGV5xGbE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pYWrRJ2DOBXKH7w6g7W9FAEECw+TQ2boNGYjR6P/XkjkWsLLYMi0hbKj/ltZ6dl51
	 9qiWL2uXI1rIo/yTXFDfBNLZolAg8aKc8/ORDAdK5RGw2yySqRFVx3m4VaRUknEEct
	 69H7EW9WnY0hPDebQro8qtcuNSr0yuJHxsT2k2K3r6JMFnUVmVkZqLYQsmZVD9nau2
	 K2a0t4YFN23Le3IuRchAJIf4KmRF8LR9yLkYxy+n0x1V1suOX5IYfEOQ52TGBRDhbm
	 sAUHD/y1tG/sn4TVpQu45XnZGB8MDM6DB0tjnA5ergwru5CYi6/cyAm5TcBd1uJV1P
	 yWLQ6qrS+p4dw==
Message-ID: <15c913fd-6c13-4b0b-8277-6d5e3ebe85c0@kernel.org>
Date: Mon, 3 Nov 2025 16:23:58 +0900
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
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251102_232404_447109_388F066D 
X-CRM114-Status: GOOD (  18.07  )
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

Hmmm... Matter of taste maybe ?
Personally, I do like better having a single error path that cover all errors in
blk_revalidate_disk_zones().


-- 
Damien Le Moal
Western Digital Research

