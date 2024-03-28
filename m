Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0695CD1288
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 23:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=deX4ViV6F30oJLu3+OU3qeKsXEQFAnxMjLn6FQcQgbE=; b=FZGWUpV1Cjegi/LEhQIDjMzchX
	bYWlSZ5R4GtDWl3N8fOCCHBWDGrAEbSEvW+YeeMVcvkp01xcaycnNNfdW9mIG4RCC+gc+Fkll0dVD
	YIpWNvNhhah+P3JUXT80eT2mPuRUrWV7Dq6d9Ync7saTCYzgSMFIgThamsu42JQ12nAayRUZsLRJ8
	1GHsZxFUAvZxK4CZQ/NkS6YcGgcxDMrmlRQsvUinzJ1HjmWBRzrHyQsLcmTaU5S4sq/6WOZ+lpbH1
	2Fevq1+CeH15RvVLEUD4qL3KTvRDz/R0WZGLRMcEaCVuqxhyzg2etyXlqrkpremLRnjkDqAufaNMn
	ZErdJ7xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyvx-0000000G351-26Fy;
	Thu, 28 Mar 2024 23:13:21 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpyvu-0000000G33h-1lFv
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 23:13:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0EAF2CE2C14;
	Thu, 28 Mar 2024 23:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F74C433C7;
	Thu, 28 Mar 2024 23:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711667594;
	bh=v+SHLoICanV0vkiVj8XhdUNtq5t4L5mpSMibAdWlRH4=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=cT8prdCZz9XivJJApdhCvLOJ4goauShlKHJaLq+b+uICqNBuGR/Lvh3EdSaGF/pd8
	 gzBthPKPLoLB/TlURkx6cxIoTBD27fAd6pN+oU94Mt1Sdk+VL8oplTwFepRbPZRt0E
	 6suPEZcEUciCk7M/VLtccqTHwBzVsLXcC+NTX0aiNv4LDVj6Lsvf4DqrPb7tunyDkz
	 gJAFZkDeeCFPP1N0pdTkjJwwsEZ6l7b5NWlwI6QyGpiWKuaMtQmcbb+UdU2fir7izu
	 VhmW2VOdknu8yV+b8mEEHyNDK52tg9xxgU+qjkdoOMaZsJfu9SnCne7X7XQA6LSVtp
	 svINZGsMXOuqw==
Message-ID: <67a6eeea-253f-4568-b73d-aa05173cdb41@kernel.org>
Date: Fri, 29 Mar 2024 08:13:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH v3 00/30] Zone write plugging
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, dm-devel@lists.linux.dev,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <171166712406.796545.15002324421306835511.b4-ty@kernel.dk>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <171166712406.796545.15002324421306835511.b4-ty@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_161318_679458_FE2C3C9F 
X-CRM114-Status: UNSURE (   9.39  )
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

On 3/29/24 08:05, Jens Axboe wrote:
> 
> On Thu, 28 Mar 2024 09:43:39 +0900, Damien Le Moal wrote:
>> The patch series introduces zone write plugging (ZWP) as the new
>> mechanism to control the ordering of writes to zoned block devices.
>> ZWP replaces zone write locking (ZWL) which is implemented only by
>> mq-deadline today. ZWP also allows emulating zone append operations
>> using regular writes for zoned devices that do not natively support this
>> operation (e.g. SMR HDDs). This patch series removes the scsi disk
>> driver and device mapper zone append emulation to use ZWP emulation.
>>
>> [...]
> 
> Applied, thanks!
> 
> [01/30] block: Do not force full zone append completion in req_bio_endio()
>         commit: 55251fbdf0146c252ceff146a1bb145546f3e034
> 
> Best regards,

Thanks Jens. Will this also be in your block/for-next branch ?
Otherwise, the series will have a conflict in patch 3.

-- 
Damien Le Moal
Western Digital Research


