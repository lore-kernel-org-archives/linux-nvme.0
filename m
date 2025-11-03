Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35E6CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 13:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s1G575AwRy0OrtFxAnK7lAYmB+ZT3EDAWYRDpkKIoYM=; b=QvVnzyKMpXQFmULTRCZ2R2b2jv
	0OD2Zn2wDCMJDS5iun3ZdnRXjD2tiCb4wP5udobbH9mEB/5opDV/21anABfVfjEQzz3VrIwTGRnqB
	tkAuDh5jED/ocJr1vK0RVs3LFOT8sBGfWof5X7VK0dtBy0CqJDGPt9E86XVmqrG3ieRw0FOj8XVlk
	IoFqVKIRAZ7b1KG3kac0VqXpISZXyS+OiSJMkJBbD6zWIq7J4VnJQ6wHfaYuKH2MhH6Y74uvd+9MK
	cDcev9vd70G5BLuS2CD4e4akH3lmZq5dbQA/NqdI2oyjbDQkAVi1AOEFwCjNuGsDjcUQbwBxfhe6+
	StOLlHFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuA8-00000009rrl-2G07;
	Mon, 03 Nov 2025 12:59:56 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuA7-00000009rrc-2XXJ
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 12:59:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B9B42600AC;
	Mon,  3 Nov 2025 12:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAC8C4CEE7;
	Mon,  3 Nov 2025 12:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762174794;
	bh=mg14JfajU5W0qY3xKlC1LzugPqDhaogBLa+MoPCu9po=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Tfzuyc0w0PG8B9qeo4EY1e6oWHR35RGpaPLMhqntB/ik1LckO74VHTfp82JdQfC9k
	 0XUUezUYERCKbPcEpQY508qcq5lLukAr+xy/HgvMMnFHFrhxq+AwL0mtcl8g3ynIYb
	 FsW8Nr3O/XJikCmQBNqdHGt7OEq0tEcBuNdvdKHO7YvkkFHuIcD0/uRGGFqYSqR9u1
	 Pd7ZRjdZfeTJpyRPVCSwWFC4B9ujnv6yxK+/mq21WfNfEkreGE0imhdNkpA+pHbXy/
	 TECb2JVsfxse8iQFM6majHDvwTu6aCy7dgtulG1U5hG4HAxVR6J6cFHyAK4kOVvqY9
	 uSZasy7Ak7n8g==
Message-ID: <32f2f32a-eafd-43ef-a599-fc4784fdf492@kernel.org>
Date: Mon, 3 Nov 2025 21:59:49 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] block: handle zone management operations
 completions
To: Hannes Reinecke <hare@suse.de>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-4-dlemoal@kernel.org>
 <8947e877-cd53-4f1d-989c-bdde311c00e9@suse.de>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <8947e877-cd53-4f1d-989c-bdde311c00e9@suse.de>
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

On 11/3/25 20:41, Hannes Reinecke wrote:
> On 10/31/25 07:12, Damien Le Moal wrote:
>> The functions blk_zone_wplug_handle_reset_or_finish() and
>> blk_zone_wplug_handle_reset_all() both modify the zone write pointer
>> offset of zone write plugs that are the target of a reset, reset all or
>> finish zone management operation. However, these functions do this
>> modification before the BIO is executed. So if the zone operation fails,
>> the modified zone write pointer offsets become invalid.
>>
>> Avoid this by modifying the zone write pointer offset of a zone write
>> plug that is the target of a zone management operation when the
>> operation completes. To do so, modify blk_zone_bio_endio() to call the
>> new function blk_zone_mgmt_bio_endio() which in turn calls the functions
>> blk_zone_reset_all_bio_endio(), blk_zone_reset_bio_endio() or
>> blk_zone_finish_bio_endio() depending on the operation of the completed
>> BIO, to modify a zone write plug write pointer offset accordingly.
>> These functions are called only if the BIO execution was successful.
>>
> Hmm.
> Question remains: what _is_ the status of a write pointer once a
> zone management operation is in flight?

On the device, it will be unchanged until the command completes, or rather, one
can only see it that way since the drive will serialize such command with report
zones.

> I would argue it's turning into a Schroedinger state, and so we
> cannot make any assumptions here.

Let me try to skin that cat below :)

> In particular we cannot issue any other write I/O to that zone once
> the operation is in flight, and so it becomes meaningless if we set
> the write pointer before or after the zone operation.
> Once the operation fails we have to issue a 'report write pointer'
> command anyway as I'd be surprised if we could assume that a failure
> in a zone management command would leave the write pointer unmodified.
> So I would assume that zone write plugging already blocks the zone
> while an zone management command is in flight.
> But if it does, why do we need this patch?

There is no such "blocking" done, the user is free to issue a zone reset while
writes are n flight, and most likely get write errors as a result such bad practice.

For this patch, the assumption is that a failed zone reset or zone finish leaves
the zone write pointer untouched. All the drives I know do that. So it is better
to not modify the zone write plug write pointer offset until we complete the
command.

But granted, that is not always true since the failure may happen *after* the
drive completed the command (e.g. the HBA loses the connection with the drive
before signaling the completion or something like that). In such case, it would
not matter when the update is done. And for zone reset all commands, all bets
are off since the command may fail half-way through all the zones that need a reset.

But in the end, logically speaking, it makes more sense to update things when we
get a success result instead of assuming we will always succeed. This has also
the benefit of leaving the zone write plugs in place for eventual error recovery
if needed.

-- 
Damien Le Moal
Western Digital Research

