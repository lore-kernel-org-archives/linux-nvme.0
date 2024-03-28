Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 690B7CD11DF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 22:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=biHmi33YIfGx176ee0cuOTX9tPVA38ASjA6C7DNKzzc=; b=zh9lNFHt8zFSXa6ptXof3MdL4i
	0puwRmpNwcVDMLmmqhSzS3zcKbciZ4sIp4kWl5PErol9OyuSiSvuHs3iZir64/zmtwpyRNNW7tg67
	4iwLAJ3miR8JaXTjBkNkzpvS/2hcQwptY3lJ8rW8lpDRypHXxfbAg6EgVXqIDpGC5O9aOz5qY+k7f
	NsshlPQKl6lVDDQVhsMxgQu6hzyxNVy0paQqdd0olzM3ueFNWb+iDpQCmWJ/VXdGPfrQxDRzqtWGJ
	RIa4uu5yTwpIW8qInYZnhxbn6yFLPPEa3RaQSeCrmaDu3lIzB8g4TmHLma+pyi33ieeyZquZTGrGV
	jX0LgUJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpy6j-0000000FumS-13Or;
	Thu, 28 Mar 2024 22:20:25 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpy6f-0000000FulQ-3dbc
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 22:20:23 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V5HzT2dwDz6Cnk8t;
	Thu, 28 Mar 2024 22:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711664416; x=1714256417; bh=biHmi33YIfGx176ee0cuOTX9
	tPVA38ASjA6C7DNKzzc=; b=l0Iqx4wsPxCNSTyduWDzbW4fjR19IlBtTP6gJH+r
	NIi8nOXwGV8tke4FTPjMLey7r+Q32Zc6nfhvuWpoPtixNItr66IGljL81VPrJnvb
	BH3lxrfxtsBnrOAXmYMTu9xzrU1/nBFZ7tNViHStqGZK4O90LjjSF4JRQVXfC0ek
	kbE/93ok6J+OlHcpH+S8/lVZXK9wyCGyXJGKU7kYbrxPA/jg7Knc5ML5YDAfA0Fx
	F0/cY6XuUSp6BxBqeVKlbObYI30Cu8+FQ03qNPya68XPCPwTnvQ4nCWagerl0+B5
	I+f9A7RHRpWJ1fS9WOGizbzr/hmAPPVgUS/sRVBbQ0sVkQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id l62VJEqGq-6D; Thu, 28 Mar 2024 22:20:16 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V5HzM1Blqz6Cnk8m;
	Thu, 28 Mar 2024 22:20:14 +0000 (UTC)
Message-ID: <688607d9-6dfe-4c37-81e8-4fea91ec8da8@acm.org>
Date: Thu, 28 Mar 2024 15:20:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/30] block: Introduce zone write plugging
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-9-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-9-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_152021_961401_FB40F228 
X-CRM114-Status: GOOD (  16.49  )
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

On 3/27/24 5:43 PM, Damien Le Moal wrote:
> +	/*
> +	 * Initialize the zoen write plug with an extra reference so that
> +	 * it is not freed when the zone write plug becomes idle without
> +	 * the zone being full.
> +	 */

zoen -> zone

> +static void disk_zone_wplugs_work(struct work_struct *work)
> +{
> +	struct gendisk *disk =
> +		container_of(work, struct gendisk, zone_wplugs_work);
> +	struct blk_zone_wplug *zwplug;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
> +
> +	while (!list_empty(&disk->zone_wplugs_err_list)) {
> +		zwplug = list_first_entry(&disk->zone_wplugs_err_list,
> +					  struct blk_zone_wplug, link);
> +		list_del_init(&zwplug->link);
> +		blk_get_zone_wplug(zwplug);
> +		spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
> +
> +		disk_zone_wplug_handle_error(disk, zwplug);
> +		disk_put_zone_wplug(zwplug);
> +
> +		spin_lock_irqsave(&disk->zone_wplugs_lock, flags);
> +	}
> +
> +	spin_unlock_irqrestore(&disk->zone_wplugs_lock, flags);
> +}

What is the maximum number of iterations the above while loop can 
perform? I'm wondering whether a cond_resched() call should be added.

> +
> +	/* Wait for the zone write plugs to be RCU-freed. */
> +	rcu_barrier();
> +}

It is not clear to me why the above rcu_barrier() call is necessary? I'm
not aware of any other kernel code where kfree_rcu() is followed by an
rcu_barrier() call.

> +static int disk_alloc_zone_resources(struct gendisk *disk,
> +				     unsigned int max_nr_zwplugs)
> +{
> +	unsigned int i;
> +
> +	disk->zone_wplugs_hash_bits =
> +		min(ilog2(max_nr_zwplugs) + 1, BLK_ZONE_MAX_WPLUG_HASH_BITS);

If max_nr_zwplugs is a power of two, the above formula will result in a
hash table with a size that is twice the size of max_nr_zwplugs.
Shouldn't ilog2(max_nr_zwplugs) + 1 be changed into
ilog2(roundup_pow_of_two(max_nr_zwplugs))?

Otherwise this patch looks fine to me.

Thanks,

Bart.

