Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11A27C001DC
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 14:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=s1h9FnBNW0HGmWAtDUe8odTzUfBs/mFnqsbWdcAWKXI=; b=HVWFWG9yImtUkJ2AsQ6eAkYLXi
	9w1LIFq/C2RxKELBiwhPNwnZ8FgS6VVOfq+irybvqwkzFtWlfbYtom+lMFw6wHPgM22uAfvugGlMk
	u7QOTXpiDdgfLTn5dREtOogzYWXTLzdAamdsP2xc8obod6RUTLDC5pQcA456P7HE2W/Q5NJA5dnUQ
	dZdbOJAwE7YiJsTdbkr0g59BNosuBfN44f5RljgERiZZxj9zHudIbDdJQYAk25bTp6yxFIyajPFEg
	CbcQhOzuNNLZpSGFJLTCat9u1uiMMiWiSalwm4nPVfZJshruec+YalYRzpFTNnI0iagrgqN0JBR9I
	9jw9L4OQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTTs-00G3vu-35;
	Mon, 31 Jul 2023 14:02:40 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTTq-00G3v9-04
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 14:02:39 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5DABB61132;
	Mon, 31 Jul 2023 14:02:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B423C433C7;
	Mon, 31 Jul 2023 14:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690812156;
	bh=LMRr1XsRzjNg4BrFx2nNlB6pAFsKEl7n2pBzquD6fXc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KCjtn0i/NqSufrfP9RQTsPb+/LX+aPZtpYs7FPst3C08yJhqWgYt1fZTRoCvOGyMY
	 tJS06wdD+h90BXm2bBU8nERozqz6O8xEjJA2PJyUeoBO/oOvO8viZoeuI5zpdR2RbZ
	 xa1eoNXNaAqN5XPKASKu8Kvltl+er81MfYhv+sdv1jG/Jnj7f4CaNZXY5IwaLN2bSh
	 VDK2lcQTlKOxni/dfk2D/xBoQM8FwoOpI5Heb254oauSp0RqqGJEoOIFUq5zWYvpFa
	 DBs6AxLvbQjPp9KBxD8E8VLDx6Q92m1ojQfa7fZoHenSJPpmbGHfn7rlyIDm1YZhmk
	 Givu1kxigOKJA==
Message-ID: <2dea2a1c-b127-4661-c232-4dcf0b249878@kernel.org>
Date: Mon, 31 Jul 2023 23:02:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvme: zns: limit max_zone_append by max_segments
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230731114632.1429799-1-shinichiro.kawasaki@wdc.com>
 <ZMe7Gck9MSo8Fn+a@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZMe7Gck9MSo8Fn+a@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_070238_154454_00690DC0 
X-CRM114-Status: GOOD (  19.48  )
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

On 7/31/23 22:46, Christoph Hellwig wrote:
> On Mon, Jul 31, 2023 at 08:46:32PM +0900, Shin'ichiro Kawasaki wrote:
>> To avoid the unexpected BIO split, reflect the max_segments limit to the
>> max_zone_append limit. In the worst case, the safe max_zone_append size
>> is max_segments multiplied by PAGE_SIZE. Compare it with the
>> max_zone_append size obtained from ZNS devices, and set the smaller
>> value as the max_zone_append limit.
> 
> This is true only for NVMe and a hand full of drivers that
> set the virt_boundary.  For others the maximum size is completely
> unrelated to the maximum number of segments.
> 
> Can you reword the commit log a bit to make that more clear?
> 
>> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
>> index ec8557810c21..9ee77626c235 100644
>> --- a/drivers/nvme/host/zns.c
>> +++ b/drivers/nvme/host/zns.c
>> @@ -10,9 +10,11 @@
>>  int nvme_revalidate_zones(struct nvme_ns *ns)
>>  {
>>  	struct request_queue *q = ns->queue;
>> +	unsigned int max_sectors = queue_max_segments(q) << PAGE_SECTORS_SHIFT;
>>  
>>  	blk_queue_chunk_sectors(q, ns->zsze);
>> -	blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
>> +	max_sectors = min(max_sectors, ns->ctrl->max_zone_append);
>> +	blk_queue_max_zone_append_sectors(q, max_sectors);
> 
> And while this looks correct, it also feels pretty ugly.  Shouldn't a
> 
> 	blk_queue_max_zone_append_sectors(q,
> 		queue_max_sectors(q), ns->ctrl->max_zone_append);

blk_queue_max_zone_append_sectors() already does cap max zone append to
max_hw_sectors. We could also add the cap to queue_max_segments(q) <<
PAGE_SECTORS_SHIFT in that function as well given that all zoned devices should
have that anyway...

> 
> do the same thing in a somewhat more obvious way given that max_segments
> is already taken into account for the queue_max_sectors calculation?

-- 
Damien Le Moal
Western Digital Research


