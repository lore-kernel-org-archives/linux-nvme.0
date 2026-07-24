Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ABA5C531C9
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 15:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5nuOP4jxO16NLocZBZK4AZLVxWBdOiKE7BUbgb7/Hes=; b=1np6Wvo9IWvWkLn91vC9e+wego
	n8NlcmIK8hMXEC0b8f3JWK7psfVoKrM6dKzAyRFPWhPxXZrsZ/asK+fXUpZldj3bTKM1Pkqfm+caJ
	Q+Aew6R2Qb4sg5DN+NcL2LpbbRzU2IkNT7NyEgmPtIabBxJ4ZHZRxHlpN5odWhcoYgDJ+QxyIemOa
	wYgvDCq7ii4m+WqPsRmv8wbxq+hzI50I3ReajfUbvdaVtMABEwFOcVBrUVKXIDXWLs/yaUjlhEXMG
	mNmjtQAnSzIB0OscbkqFMrAMXi/hq2IB5UOOpOs5H1cqokA0Kp38+eoAxud6sIpVOdJCUSJD2MIs9
	JnZcdV0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnHpt-0000000GiBU-3eYI;
	Fri, 24 Jul 2026 15:29:17 +0000
Received: from out-170.mta0.migadu.com ([91.218.175.170])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnHpq-0000000GiAs-18Ff
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 15:29:15 +0000
Message-ID: <f76e9466-4b66-4a32-a491-728e24d34052@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784906950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5nuOP4jxO16NLocZBZK4AZLVxWBdOiKE7BUbgb7/Hes=;
	b=ewCezjJxZxHKTLJcNu3qWDk6XBcK2Q1TLojeyfPWR8VzZo9OZUNSIr3HGxDLJ59AQr8wRK
	IZ05ayaRiWY8ZOxcW7+FSwjxPzAv7NDzrOu8jYl41KqnRXlQxOg+5K/TUlzLUMqcvzXZ7o
	iI+MEXRWdN9270MdvnTga9goe6/ijg4=
Date: Fri, 24 Jul 2026 16:29:08 +0100
MIME-Version: 1.0
Subject: Re: [PATCH RFC] nvme-multipath: fix diskstats for partitions
To: Keith Busch <kbusch@kernel.org>, John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, sagi@grimberg.me, axboe@fb.com,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20260721114553.1657841-1-john.g.garry@oracle.com>
 <20260724050152.GA3680@lst.de>
 <987782a9-e12a-4098-b438-a54a5765c2ae@oracle.com>
 <amNegPEvRX99EvPN@kbusch-mbp>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: John Garry <john.garry@linux.dev>
In-Reply-To: <amNegPEvRX99EvPN@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_082914_718725_6CF3B530 
X-CRM114-Status: GOOD (  22.00  )
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

On 7/24/26 13:45, Keith Busch wrote:
> On Fri, Jul 24, 2026 at 08:09:51AM +0100, John Garry wrote:
>> On 24/07/2026 06:01, Christoph Hellwig wrote:
>>> On Tue, Jul 21, 2026 at 11: 45: 53AM +0000, John Garry wrote: > Setting as an
>>> RFC as adding this extra bio field is not acceptable, but I > can't see how to
>>> lookup the original partition. In general it is not, but you should mark this a
>>>
>>>
>>> On Tue, Jul 21, 2026 at 11:45:53AM +0000, John Garry wrote:
>>>> Setting as an RFC as adding this extra bio field is not acceptable, but I
>>>> can't see how to lookup the original partition.
>>>
>>> In general it is not, but you should mark this a block patch so that
>>> Jens can better cream at you :)
>>>
>>> I'm also not sure that supporting per-partition diskstats on a multipath
>>> device makes too much sense, but then again there's a lot of setups
>>> that are crazy and actually used..
>>>
>>
>> It just seems to me that we should have same behaviour as if it were not
>> multipath.
>>
>> So we can't use bi_private as that can be set by original bio submitter. I
>> was thinking that this bdev pointer could be temp stashed in bi_next (as it
>> should be originally NULL), but that it dodgy and maybe won't even work.
> 
> Failover is corner case to consider here. We always reset the bio bdev
> to the part0, so your stats will be incorrect when that happens. I think
> you can quickly fix that in your proposal with the "bi_orig", though.
> 
> Can we just thread through partitions for the bio's block_device instead
> of assuming part0? I know the hidden path devices skip partition
> scanning, but maybe if we let it happen, then those will have the same
> partition setup as the head gendisk. Then we can go right to the
> disk->part_tbl for what we provide to bio_set_dev() for both submission
> and failover, and everything should work out from there.

I guess that we would just scan through the per-path gendisk->part_tbl 
and match somehow to lookup the partition. Maybe vs start address of 
bio->bi_bdev. Or is there a simpler (and quicker) way?


