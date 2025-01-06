Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073F7E77199
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 03:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sJM+i/PqWslq0z2O/NGhlrJk26OpN/YDEpqH1yQbUOY=; b=NQ8nw4Z2QMzeM1fzubrfhbsWqV
	4ACcLgwYpFkZNjjH7ZGWWl76ecXMb85wai0urOnOygefbC9Z4A8nEywf6kxTkRSyECOj3j4sxhDuO
	aHi0uaK6ioKMOPmD45a/ZJT+DkUgU+F0ZkzmRUMlMXcvmpoHLivRy3w0vX5p5l7byOHnKAkHwzIGb
	7Dabaj2L7xFXD9Pb9ygNiENF5V+ZisjIl6thhfITMPewqVnyGDsJsaH6znTjn5JqekDIkOwaeC/4h
	WcI3QgMKr81oBIn6Y4uezKTb9ps0khvgKQJVnY+wkpPkGm4eAsF713Xj4yZRJvpnOTGpAr3EE5Eu9
	Z8YIqe6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUdv1-000000008wo-1PKu;
	Mon, 06 Jan 2025 03:36:43 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUduh-000000008vO-0GhT
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 03:36:24 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4B959A40DF3;
	Mon,  6 Jan 2025 03:34:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3DFC4CED0;
	Mon,  6 Jan 2025 03:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736134581;
	bh=I2GldTGcZgIIImmzQZgZOa8Wv6n0xZbA+YpUx4jI3QI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tHiQXhVeFANvh9bVJ/TbjrFcpiF89sI/xC79oX52swwqqJzZZgO83Z5yPzDZd/4qZ
	 j6klsqcx+eYvfi/s5RcYaws0ReFjnbpknina6FwxYC7W9+4GBffxe4+RTyrmsi83uW
	 TvlmKwHPTdLbZclApQhW7UlAkoU6jbVmTUpS7sb2Y/d9wJdnX2F5R70b1BRDZEkNcF
	 vf/5pj4a8UlmzeObPLDIM7Czh0yt5PFRjPX/50w4Z+DfnXWo03nzA31EmZpXwmKUge
	 hUSW8zTIZuf+ply4xMCiRJvzpoISzEo5QrSt5bPiTdsKTv1g5lNFMIASUNmxd1jdBy
	 fvy7vQ8ig5dkg==
Message-ID: <ae75194f-334f-4337-b1e6-e68b8d63bc93@kernel.org>
Date: Mon, 6 Jan 2025 12:35:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] block: Fix sysfs queue freeze and limits lock order
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Nilay Shroff <nilay@linux.ibm.com>
References: <20250104132522.247376-1-dlemoal@kernel.org>
 <20250104132522.247376-2-dlemoal@kernel.org> <Z3tOn4C5i096owJc@fedora>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <Z3tOn4C5i096owJc@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250105_193623_352697_0B0F3D98 
X-CRM114-Status: GOOD (  23.05  )
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

On 1/6/25 12:31 PM, Ming Lei wrote:
> On Sat, Jan 04, 2025 at 10:25:20PM +0900, Damien Le Moal wrote:
>> queue_attr_store() always freezes a device queue before calling the
>> attribute store operation. For attributes that control queue limits, the
>> store operation will also lock the queue limits with a call to
>> queue_limits_start_update(). However, some drivers (e.g. SCSI sd) may
>> need to issue commands to a device to obtain limit values from the
>> hardware with the queue limits locked. This creates a potential ABBA
>> deadlock situation if a user attempts to modify a limit (thus freezing
>> the device queue) while the device driver starts a revalidation of the
>> device queue limits.
>>
>> Avoid such deadlock by introducing the ->store_limit() operation in
>> struct queue_sysfs_entry and use this operation for all attributes that
>> modify the device queue limits through the QUEUE_RW_LIMIT_ENTRY() macro
>> definition. queue_attr_store() is modified to call the ->store_limit()
>> operation (if it is defined) without the device queue frozen. The device
>> queue freeze for attributes defining the ->stor_limit() operation is
>> moved to after the operation completes and is done only around the call
>> to queue_limits_commit_update().
>>
>> Cc: stable@vger.kernel.org # v6.9+
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>  block/blk-sysfs.c | 123 ++++++++++++++++++++++++----------------------
>>  1 file changed, 64 insertions(+), 59 deletions(-)
>>
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index 767598e719ab..4fc0020c73a5 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -24,6 +24,8 @@ struct queue_sysfs_entry {
>>  	struct attribute attr;
>>  	ssize_t (*show)(struct gendisk *disk, char *page);
>>  	ssize_t (*store)(struct gendisk *disk, const char *page, size_t count);
>> +	ssize_t (*store_limit)(struct gendisk *disk, struct queue_limits *lim,
>> +			       const char *page, size_t count);
> 
> As I mentioned in another thread, freezing queue may not be needed in
> ->store(), so let's discuss and confirm if it is needed here first.
> 
> https://lore.kernel.org/linux-block/Z3tHozKiUqWr7gjO@fedora/
> 
> Also even though freeze is needed, I'd suggest to move freeze in each
> .store() callback for simplifying & avoiding regression.

The patch would be simpler, sure. But the code would not be simpler in my
opinion as we will repeat the freeze+limits commit+unfreeze pattern in several
callbacks. That is why I made the change to introduce the new store_limit()
callback to have that pattern in a single place.

And thinking about it, queue_attr_store() should be better commented to clearly
describes the locking rules.

-- 
Damien Le Moal
Western Digital Research

