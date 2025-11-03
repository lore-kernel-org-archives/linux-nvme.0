Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F27ECCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 06:25:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aZdJxl8q/v+7lShDU04HkylqG17NQ57+UknddyW+jZs=; b=QwqQ1K7D457iBMjKT30X9/pgsD
	qO7vu9JUi3gkrXqMJCMLXBP2CNUOuQKbuPkB4G1g+ZQLzYaXRsxQFGLQE0TkXT3FEyrn+WPsu7sEz
	K5pE6F4ylNPTf08oROrm0aZS815JUc0PvID23XQXZqfo+u6Fc7vv1tX6lkEdrEJeoXLK7gNjpJ4uw
	WIlIFXAHp2LsQOEpx3COiigY1F7TOX+riu7Z+lnapY87i62frLHF8Td6O3QtQ0s800G64J4J1RMxK
	4FglvblYZeAHnyA8mCg76GcwPM5eqkt+qmkIQWbpmDI+pmVVNnIMOww9UTSDHwyV75rvreZph8gUw
	jcH/t0rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFo0G-00000009I3H-3NHr;
	Mon, 03 Nov 2025 06:25:20 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFo0F-00000009I2w-0byt
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 06:25:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 49C7B60144;
	Mon,  3 Nov 2025 06:25:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1936C4CEE7;
	Mon,  3 Nov 2025 06:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762151118;
	bh=8RRYCj8CkNNVJtCtEV8tgKWWs6L1hqdJYHMXRsKV0HE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=DZBX8osrTJxAdKvH+wcT21X1A5eMxob7PQblVQFuuJnZ4Q3S6WX1qXKmx0AaZYZvh
	 JOwIIu8TR4npxQdqUWfRSYGmHTkDOkZa6wCtyQ8EwNbpy+QgGHLJiTsN1Os8GKg8OA
	 +X0RS081onCc4np1J7Aku2I1rn+GAcpKm4Reito5X6tuWj8l+1/SKCnfayxnx/P0+H
	 UdAtdvB9/D7YdecaNcmuXbOuPGIiKQklT0c39ncHFKhbk/lNhU2y61RcsNKf6sU25k
	 HNfYL3y2egZrUdCw3rsikpcqESgZcc3VjW/T4EcidU34xgLHIvlp+YH51TTwYA5dso
	 FJvILdZJBWGWg==
Message-ID: <22af84c8-c670-4022-9b71-4451889e9986@kernel.org>
Date: Mon, 3 Nov 2025 15:25:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] block: handle zone management operations
 completions
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
 <20251031061307.185513-4-dlemoal@kernel.org>
 <1aebb8a7-ac7d-4e53-bbf3-034f520d58fc@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <1aebb8a7-ac7d-4e53-bbf3-034f520d58fc@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 11/1/25 03:01, Bart Van Assche wrote:
> On 10/30/25 11:12 PM, Damien Le Moal wrote:
>> +void blk_zone_mgmt_bio_endio(struct bio *bio)
>> +{
>> +	/* If the BIO failed, we have nothing to do. */
>> +	if (bio->bi_status != BLK_STS_OK)
>> +		return;
>> +
>> +	switch (bio_op(bio)) {
>> +	case REQ_OP_ZONE_RESET:
>> +		blk_zone_reset_bio_endio(bio);
>> +		return;
>> +	case REQ_OP_ZONE_RESET_ALL:
>> +		blk_zone_reset_all_bio_endio(bio);
>> +		return;
>> +	case REQ_OP_ZONE_FINISH:
>> +		blk_zone_finish_bio_endio(bio);
>> +		return;
>> +	default:
>> +		return;
>> +	}
>>   }
> 
> "default: return;" is superfluous and can be left out.

No, it is needed. Otherwise, with GCC 15.2.1, I get:

block/blk-zoned.c: In function ‘blk_zone_mgmt_bio_endio’:
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_READ’ not handled in
switch [-Werror=switch]
  778 |         switch (bio_op(bio)) {
      |         ^~~~~~
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_WRITE’ not handled in
switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_FLUSH’ not handled in
switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_DISCARD’ not handled
in switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_SECURE_ERASE’ not
handled in switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_ZONE_APPEND’ not
handled in switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_WRITE_ZEROES’ not
handled in switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_ZONE_OPEN’ not handled
in switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_ZONE_CLOSE’ not
handled in switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_DRV_IN’ not handled in
switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_DRV_OUT’ not handled
in switch [-Werror=switch]
block/blk-zoned.c:778:9: error: enumeration value ‘REQ_OP_LAST’ not handled in
switch [-Werror=switch]


-- 
Damien Le Moal
Western Digital Research

