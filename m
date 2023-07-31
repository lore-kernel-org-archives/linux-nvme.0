Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79CAC001DC
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 14:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pNUg6YLqYajqSVg7y5U83A/CFJJpONWu88vK4CV4Etw=; b=ABv9eflUlrG1YGWHh779oZEghV
	FY8P4Yr9rcIZd3ZXKQBqtxZKTGV3QAM6LTSv0iYN8A6cZKdc4WT4MAB6eLyq2Kra5RNebJczEcaN6
	PAnuQ46xtjDs9pOZHzuEp4T9jKREvbsRRmw8lkRNvfOxCEd73sP4tabQvO7bTjDF2wqq6Lc1ye8rz
	1PLp34f3uoQ27UjdQYomk7wixNKet8QCKzh3qu53WZ9n+LoN/xu2mbEZzTLXGwn30N5FiG5NSE79o
	w6KQvQuliBShh8todYX+tB/L2KwcxIDj9N+aOHwmwbYr7XEZWyU9pcm83aWTC+KGpFCswfqKMVWv8
	TU0sc+xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTSg-00G3oK-17;
	Mon, 31 Jul 2023 14:01:26 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTSe-00G3nY-0V
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 14:01:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9B16A61154;
	Mon, 31 Jul 2023 14:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E028C433C7;
	Mon, 31 Jul 2023 14:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690812083;
	bh=QnnO+ArqnYMvUlDuzQUcPlRkcnUbnWqHyk3jl9JzeTs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mtXAlSnerEjI5rctkaIxcyCKQ3HOmN6jsKm5u+t3sRfvfzkG2PPyrOTSgQwb2N75Y
	 QMkpUDQN1+f8Or3JUjzBeg+hQw+weBkBm+dVcGzt1IdAdWOvJ79WLY9clgGjLkjsav
	 edjGrlVz1iRHURQtLzzRxxG7oIHouwV0dJB5OhO3vFa0EHdGokPnLyKw515w7DXVhV
	 F5D0YfHQCqVgK9aLBQHC9iDAxImllrZbwMTI/XkWOnaNFneT75hYRjpcncuFjdPi0Z
	 gx/EjfOLgFAs54C5T7wtKG5E8lvSmVvJQ6n+3iN9hqSynRQ6tOKGYxmCpEnUwvYF+d
	 NlP2lAuWOXn+Q==
Message-ID: <3a827ef4-4143-a7d4-f3b1-6b50837f6fd9@kernel.org>
Date: Mon, 31 Jul 2023 23:01:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] nvme: zns: limit max_zone_append by max_segments
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
References: <20230731114632.1429799-1-shinichiro.kawasaki@wdc.com>
 <e0f88870-73a8-05a3-024d-52cefcdef71d@kernel.org>
 <ZMe8XvFDDdAom97/@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZMe8XvFDDdAom97/@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_070124_279413_2FE94951 
X-CRM114-Status: GOOD (  24.59  )
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

On 7/31/23 22:51, Christoph Hellwig wrote:
> On Mon, Jul 31, 2023 at 09:03:46PM +0900, Damien Le Moal wrote:
>> I feel like a lot of the special casing for zone append bio add page can be
>> removed from the block layer. This issue was found with zonefs tests on real zns
>> devices because of this huge (and incorrect) zone append limit that zns has,
>> combined with the recent zonefs iomap write change which overlooked the fact
>> that bio add page is done by iomap before the bio op is set to zone append. That
>> resulted in the large BIO. This problem however does not happen with scsi or
>> null blk, kind-of proving that the regular bio add page is fine for zone append
>> as long as the issuer has the correct zone append limit. Thought ?
> 
> A zone append limit larger than max_sectors is odd, and maybe the
> block layer should assert something.  I think the root cause is that
> many NVMe devices have a very large hardware equivalent to max_sectors
> (the MDTS field), but Linux still uses a much lower limit due to memory
> allocation issues (the PRPs used by NVMe are very inefficient in terms
> of memory usage for larger transfers).  So we cap max_sectors to the
> ѕoftware limit, but not max_zoned_append_sectors.
> 
> Zone Append needs some amount of special casing in the block layer
> because the splitting of Zone Append bios must happen in the file system
> as the file system needs a completion context per hardware operation.
> I think the best way to do that is to first build up a maximum bio
> and then use the same bio_split_rw function that the block layer would
> use to split it to the hardware limits, just in the the issuer.  This
> is what I did in btrfs, and it seems like zonefs actually needs to do
> the same, but I missed that during review of the recent direct I/O
> changes.

We cannot do that in zonefs because there is no metadata to handle a possible
reordering of the fragments of a split large zone append. Hence zonefs limits
writes size to max zone append on entry and never tries to do larger writes. But
the ZNS limit bug resulted in the split. At least for zonefs, I think there is
no need to use the special bio add page since with a proper limit, we should
never see a split.


-- 
Damien Le Moal
Western Digital Research


