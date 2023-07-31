Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BF4FC001E0
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 14:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GkPbCA2TPevhTxbXsKv5mYhpHeKKVeChUl7k+gz73oo=; b=GGnl2c0MJwsK6rqqnDBBE9Dkcw
	bE+NtXUgjspCGa0x7J689pYoGCMMhW5IiVmLDAqlzB/tyypTrS6+/LMVVFA9X9Ia+kvjdc/ppBlzJ
	x+rnCK1uoUA1DSDK5en8YDH0xXwtdi/p/l0DTV0EF6jTWFS7k42XYkQGQQ14P3nTMJyIuYekE3KNt
	Xs4TqnrUvkEVnBz20rrFcBaoyXoNaXFn0L9IwliqGc8pcLp/sZsUjzO9MwIdphVjJLNrlNolSvi38
	e/68rD6gDEu58ZJfeRHhh00bSU9VMcX1yp+RyHNseF3c3pt70JRIBKoXd5T5rvqn41kDiRDNrpEJA
	BVv5diCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTYc-00G4fM-39;
	Mon, 31 Jul 2023 14:07:35 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTYa-00G4dO-1d
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 14:07:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ED71E61176;
	Mon, 31 Jul 2023 14:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFFC0C433C8;
	Mon, 31 Jul 2023 14:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690812451;
	bh=D1+YU4EPYv+BROf4cd1V3nOZYFHR0JxHiQR1Ux2qNS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lAMYuNSSRx9ZJZhgVnMVt4HvOWgp+Mi3NwWbQoq7+xaj7Z/nO9Iri69CqLlmXbbN3
	 mi1c/5NjuSV3tEShgqvyG0W9AbX/F+eXKyGvOJbUBvkvwtHB85pY8wq5WqNs+Zy0+g
	 jAhiPcsTeadGsnwxPgQiIHr+6DZDQ5bznAfrpMBobwqcmln9A8GH5TyFh/Bn5dVs5f
	 Z+edLg5UCy+/C/6aAUN7de/uwTY7kAziiuV0s2+xyN263BI1Knfa72oh14AgLaheMu
	 BwUOIm428t9JhQ+XLHmeb+7LXCANJxmL3TYrg4GvCu5fio5Pg6FO4ZFQ84dy9/MOKN
	 FomrdQMSbfSFw==
Message-ID: <67078894-69d6-f89f-00c2-55e4556edf38@kernel.org>
Date: Mon, 31 Jul 2023 23:07:30 +0900
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
 <ZMe7Gck9MSo8Fn+a@infradead.org>
 <2dea2a1c-b127-4661-c232-4dcf0b249878@kernel.org>
 <ZMe/tFLYy8xR9EWs@infradead.org>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZMe/tFLYy8xR9EWs@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_070732_588451_A777E262 
X-CRM114-Status: GOOD (  15.28  )
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

On 7/31/23 23:05, Christoph Hellwig wrote:
> On Mon, Jul 31, 2023 at 11:02:35PM +0900, Damien Le Moal wrote:
>>>
>>> 	blk_queue_max_zone_append_sectors(q,
>>> 		queue_max_sectors(q), ns->ctrl->max_zone_append);
>>
>> blk_queue_max_zone_append_sectors() already does cap max zone append to
>> max_hw_sectors.
> 
> Then we should not need this..

The cap is not the soft limit. It is the large hw limit, which I think is mdts
as well for zns.

> 
>> We could also add the cap to queue_max_segments(q) <<
>> PAGE_SECTORS_SHIFT in that function as well given that all zoned devices should
>> have that anyway...
> 
> No.  That's a NVMe specific thing.  Most SCSI HBAs don't have this
> issue.  NVMe devices supporting SGLs don't really have it either, but
> for that we'd need to commit to always using SGLs for non-tiny I/O,
> which we should probably be doing.

-- 
Damien Le Moal
Western Digital Research


