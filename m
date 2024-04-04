Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348F4CD1296
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 23:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=01uocpjKEsB2M6tD06VUPChfysZ8lREOswGWs0p27SM=; b=X9T/z3e407DaOlgqlXKEiHltN/
	b+6hkd7xzI48BMjuP7A7Gv8sZaRc9XnhVPmHdvpFlNDAaSx1ixB57Mt46QYiSrAVTC9UVbMp2T0s2
	xHBqUFhiLsmpfbZr8Jk9WCDFZ1+VoxcWPUN7dAgGMSMqEYjWa6JoCSEl2+p5HGhDZmj8zHz6Xy6Hx
	oVzU/P7OWONpMtWv7BZEBwzdd97PS8aJsaYIDbm7cBOrxsEffCHRTbbYBOTug8B3VU8bsXfUfykhp
	2BHZrLvDqg8pOPkhfMxeazon7V6BNfGracTIqgReIDTbSsIecH47BFTbRIUcFQJfLCEdrBW4dkkDG
	kyHURwig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsWLu-00000004ZCE-2bcr;
	Thu, 04 Apr 2024 23:18:38 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsWLr-00000004ZA9-3YfS
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 23:18:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1A46361794;
	Thu,  4 Apr 2024 23:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C35C433C7;
	Thu,  4 Apr 2024 23:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712272714;
	bh=DXDFCwVy4/NBkqIwL6pbhRxV4Qhsh8G+zaqbv0EcJyY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=K4/qaj6R1uigkUmlm5TVYTIBqmO2WVqWd3EZUAZlgzEYruuRw/RcKSCKjEdq+guPa
	 eTfsic9eH/cD7TrOmxMYD5zc/k20ux47Jr5LhIoADRlIQWFs+ne+3C+/VU6kO2N7hr
	 2ibHoS+IPbpRsxQRE4aONDQjhc0oobXFLL88lGXd1ST0ALg8Y5baSV853yEAzWeEmX
	 wjSkaeOCGOWC67O70IdaMeNKBOI9tk9hRcvHsT5SgZuX83qbsMe5GCjZlVthpmFra1
	 nG0b61SoF4FMrMtZ6q6bpeDzzLQIxcz9FP40uzrpbrNP8obeB7pPuf44FPjzl5mSYx
	 95g4Dgq1TAfyg==
Message-ID: <6bad5d07-01bf-466a-86bb-e082ed961049@kernel.org>
Date: Fri, 5 Apr 2024 08:18:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/28] block: Introduce zone write plugging
To: Bart Van Assche <bvanassche@acm.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240403084247.856481-1-dlemoal@kernel.org>
 <20240403084247.856481-8-dlemoal@kernel.org>
 <c3bbe9ac-690c-43a7-bc75-3634af5cfe7a@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <c3bbe9ac-690c-43a7-bc75-3634af5cfe7a@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_161835_982040_56B0E9D8 
X-CRM114-Status: GOOD (  13.49  )
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

On 4/5/24 03:31, Bart Van Assche wrote:
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 88b541e8873f..2c6a317bef7c 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -828,6 +828,8 @@ static void blk_complete_request(struct request *req)
>>   		bio = next;
>>   	} while (bio);
>>   
>> +	blk_zone_write_complete_request(req);
> 
> Same comment here as above: the function name 
> blk_zone_write_complete_request() is misleading since that function is
> called for all request types and not only for zoned writes. Please
> rename blk_zone_write_complete_request() into
> blk_zone_complete_request().
> 
>> +	/*
>> +	 * If the plug has a cached request for this queue, try use it.
>> +	 */
> 
> try use it -> try to use it (I know this comes from upstream code).
> 
>> +	if (blk_queue_is_zoned(q) && blk_zone_write_plug_bio(bio, nr_segs))
>> +		goto queue_exit;
> 
> The order of words in the blk_zone_write_plug_bio() function name seems
> unusual to me. How about renaming that function into
> blk_zone_plug_write_bio()?

To be consistent with your other renaming ideas, what about "blk_zone_plug_bio()" ?


-- 
Damien Le Moal
Western Digital Research


