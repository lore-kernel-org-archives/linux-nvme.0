Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEB7CCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 05:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8UacuMw7PLDQU0+hiLPaLck+JO6nlBAs5kbtWwu0zAs=; b=QP8O0fYhSYpIG354Xbj9fBWn+7
	d/HkAjEmLOmwP1kDj9ZfoIF6teUTwL1cW3bMYhMVvU0Yh7rTs6RwCzA/cNAUGXYYR6YAQrU64p9uG
	UowsmmvG/cekXyzQjZijsFGuRKjwvDnkpweVKuD/JPzkr63r/hmpnjYOGCrIxbUCjJeJMy2kZGkHd
	GXmJhKw5e4Lqt+f7YDVfGbKXPlxSTcAj8j72I+IvOKKqTLssvlqCy0+rBdd2kDXNIbPI32DzXDx3q
	1lLr8DP4pKIwCeNsIx3NV2t7jUDeWAMQjKqIRDsmqkxdRTOBAfYiUE17poLN4Q+kg/M/XZv5z5u51
	Gd7lyaNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFnYe-00000009G0y-09VA;
	Mon, 03 Nov 2025 05:56:48 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFnYc-00000009G0l-0Gw8
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 05:56:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4380F6013A;
	Mon,  3 Nov 2025 05:56:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AD1C4CEE7;
	Mon,  3 Nov 2025 05:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762149404;
	bh=OWgpJBUmjAQFzDZtAAZZ0Sd8ZrZM9CKgu0LIbDLG9AQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=D82YnSuwC/ok3efYFZswWAbAIk62KqKZBrdnK2YlhwHYjpCyNRaYsKXo+2md8Cw0w
	 Pqbq+WYXlB+suTSba/fkMOOM6O9xMqp0aT3/gqBuhNah6epzLNwDsAAC9m91RXgWuQ
	 UH5RgkrryElVV3sf+QgJZxe2F45SMgELKj2Us1QZsSDDbIwFJcZC2MA5cJs1EAxQgh
	 sHUzLLt5elTQocPSwmlRmWSkOEhDPumL1HuMw+cUCEF9YBIwvgaZVVV8wcYI+YrZil
	 YYLCM+7YjzFM+UeqoApPC/Ic9EP6sHVkc6Y/IN23JFPBuJly1CYk1BLS5BB0BvfAOk
	 EddU/Jom8+9sA==
Message-ID: <949eeeb5-3a16-4033-b71d-56c058ad4838@kernel.org>
Date: Mon, 3 Nov 2025 14:56:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] block: introduce disk_report_zone()
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-5-dlemoal@kernel.org>
 <c2734f13-aad7-43a0-a164-b8504ffc1cb4@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <c2734f13-aad7-43a0-a164-b8504ffc1cb4@acm.org>
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

On 11/1/25 05:54, Bart Van Assche wrote:
> On 10/30/25 11:12 PM, Damien Le Moal wrote:
>> -struct disk_report_zones_cb_args {
>> -	struct gendisk	*disk;
>> -	report_zones_cb	user_cb;
>> -	void		*user_data;
>> +/*
>> + * Zone report arguments for block device drivers report_zones operation.
>> + * @cb: report_zones_cb callback for each reported zone.
>> + * @data: Private data passed to report_zones_cb.
>> + */
>> +struct blk_report_zones_args {
>> +	report_zones_cb cb;
>> +	void		*data;
>>   };
> 
> The suffix "_args" seems confusing to me because this data structure
> includes a callback pointer. Please consider changing "_args" into "_cb"
> to make it clear that the data structure includes a callback pointer.
> Another data structure that follows this convention is struct
> blk_plug_cb:
> 
>    struct blk_plug_cb;
>    typedef void (*blk_plug_cb_fn)(struct blk_plug_cb *, bool);
>    struct blk_plug_cb {
> 	struct list_head list;
> 	blk_plug_cb_fn callback;
> 	void *data;
>    };
> 
> Since struct blk_report_zones_args is passed as an argument to
> disk_report_zone(), how about renaming this data structure into
> struct disk_report_zone_cb?'

See patch 8. That structure grows beyond just the callback. So I prefer to keep
the name as it is more generic.


-- 
Damien Le Moal
Western Digital Research

