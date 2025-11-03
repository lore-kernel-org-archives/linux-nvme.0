Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273BACCF9F8
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8+ZnI63ovUK1I7wBR7LkOuvP2rrk7ZSWPowftFD0GXY=; b=iK4yzscVXhGpMsTuwfL/osJc7Q
	YbvKHNXgMzap8AcAHLFGfvecNDZsLXELuruDVc+UqOQ8GlChFoJWSoT5k149VEw5g+sjSZeoRD2qT
	/e9QlXHlQhDQxU63E4Oll+QHwZCr3oCuYyjHzhy4J44Yp8UWIW4ijbEiQPpkYgfWK/gtjPssYLidg
	tHn/4y/eOSVxQgTRP1G5nWegb12vnkayEuOZ9sDFrHT8r+8Ykgy61h19dMslTt/EjGVG9aokkxiPj
	ZiveFAhtIz1ILnaDsiybuERl9VJT9TAMnfJJ+w24qpb53yCYm8NhXQFDUdflqhsbSG7LNLavjgB+a
	yLHagrqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFwo4-0000000ABwL-0mGP;
	Mon, 03 Nov 2025 15:49:20 +0000
Received: from 004.mia.mailroute.net ([199.89.3.7])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFwo1-0000000ABvZ-49Pm
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 15:49:19 +0000
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4d0bcB4tb7zmV4CC;
	Mon,  3 Nov 2025 15:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1762184952; x=1764776953; bh=8+ZnI63ovUK1I7wBR7LkOuvP
	2rrk7ZSWPowftFD0GXY=; b=02WulxwHEs8MyMtxjIJK7WJgs5zSkdrxPgnr2hXx
	Aj005502n0zYHgaxpfkmmjClPgnX6gUyoxFaDwxk/Doj40Hfrb3CNbroypmkbuVH
	oh1nrA6ZvRZzyhWG9Z2d8CrHuMfEigfkF+p9SvtXWYcG7RhtLid/jt6uhxiUM53w
	f/NqvFt5I+kELSkk5RUYvh8uv9EbKfLuJx/g4QgtkSDGZkZpg8bT6N1cK9C15+nz
	Iltvy47MrGSKu0OD2BQOMF03X2osqY2VJc+HLXrgk6HENnG7wlgDCSb8gKsc2DzQ
	vX4OSfRMzF5y4fsgXJMIq15aGGyQwdBwwQ79htaeSFmw3A==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id aMFMxo0XxxXk; Mon,  3 Nov 2025 15:49:12 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4d0bbt0fDwzm5mQ7;
	Mon,  3 Nov 2025 15:48:57 +0000 (UTC)
Message-ID: <95c729d6-fd73-4480-af1c-68075b31cd1d@acm.org>
Date: Mon, 3 Nov 2025 07:48:54 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] block: track zone conditions
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <keith.busch@wdc.com>, Christoph Hellwig <hch@lst.de>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@kernel.org>,
 Mikulas Patocka <mpatocka@redhat.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org, linux-xfs@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>
References: <20251031061307.185513-1-dlemoal@kernel.org>
 <20251031061307.185513-8-dlemoal@kernel.org>
 <40c87475-7d5a-4792-b2a6-3eeb8406f9be@acm.org>
 <93215b7c-80bd-4860-8a77-42cdd4db1ec6@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <93215b7c-80bd-4860-8a77-42cdd4db1ec6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_074918_135883_275B7DBE 
X-CRM114-Status: UNSURE (   9.70  )
X-CRM114-Notice: Please train this message.
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

On 11/2/25 10:05 PM, Damien Le Moal wrote:
> On 11/1/25 06:17, Bart Van Assche wrote:
>> On 10/30/25 11:13 PM, Damien Le Moal wrote:
>>> Implement tracking of the runtime changes to zone conditions using
>>> the new cond field in struct blk_zone_wplug. The size of this structure
>>> remains 112 Bytes as the new field replaces the 4 Bytes padding at the
>>> end of the structure. For zones that do not have a zone write plug, the
>>> zones_cond array of a disk is used to track changes to zone conditions,
>>> e.g. when a zone reset, reset all or finish operation is executed.
>>
>> Why is it necessary to track the condition of sequential zones that do
>> not have a zone write plug? Please explain what the use cases are.
> 
> Because zones that do not have a zone write plug can be empty OR full.

Why does the block layer have to track this information? Filesystems can
easily derive this information from the filesystem metadata information,
isn't it?

Thanks,

Bart.

