Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF5FCD1292
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Apr 2024 00:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CMQXDZ5oL05wxxqjbU5l5RGBDt7zv3RVPZVyQGnPVqU=; b=V31CdUarLTN7AHV42KCV6qmnn5
	nfwooVSunedVI2gha/17GMDVhFQ6GPcKTn0I88MuLN78ScsBfdOwDJGVvkw4XphXkUVlbKWFkQoJj
	bXOyMgOyBJ72FlPVQ6Ak1a9Ied/89mZ7uWoMp2OqjnaVDcaaGRRC6S1qK0Pl4JXIUSz5RU64VoSWK
	fVjalo0Az+Bdyo4kE0ukSwK9o7We+wvNOIAWYOQTMsM7B2Lw47x8hAIbRmv2ppMQhdwAze2nBkTwM
	Brdd6U61YTd1CCujNj0jkqMFx4Ya2l9FmoFkHydmqGptedxeDrACM3wlivKRGKalNwxC69zBIqJLe
	skgfrH3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsX2D-00000004ffM-0WyF;
	Fri, 05 Apr 2024 00:02:21 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsX2A-00000004feS-0EoW
	for linux-nvme@lists.infradead.org;
	Fri, 05 Apr 2024 00:02:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5DE1461797;
	Fri,  5 Apr 2024 00:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E953C433C7;
	Fri,  5 Apr 2024 00:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712275337;
	bh=xbhU7T49GjyVw9bdxl/bVzNDUlf0wYK6PLeUZovQFKA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=iyt5fW8RabvPfGTho0BP3Mf9gfxl3otqhFQ8bjoCrq7uVwqev3yq8iVv3LUVJmmN1
	 8skAeXQjBZR6IgTLzOZibpYRpf3RYtNjY1CP1EZig3HjPIUd97hQtMgnzrfwIpmXBJ
	 FGxvoGtRJk8rbp1gQ9Js2Uk0Xmvwr0GgTi2GY6S5T/stHwPzv20h6PCPVu2bZ6Go8U
	 Cp4O0/d8ozJEgV4PDk9/vBWcu9/eFPkVFYIibZkLklwSFLpNnL4KTrlHYqFoy7T46f
	 kuFPIZisol+iAvDqhp1FM4fFh3oTYIwuZdZnOTVPhdjlH8AtlxCV78BwEWYsjrz76t
	 TzBkJuhmhp36g==
Message-ID: <649192c7-4cbe-489b-86e7-6f8ee37d57c1@kernel.org>
Date: Fri, 5 Apr 2024 09:02:13 +0900
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
 <6bad5d07-01bf-466a-86bb-e082ed961049@kernel.org>
 <889ca9a7-833c-4a78-9c59-328f54d28219@acm.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <889ca9a7-833c-4a78-9c59-328f54d28219@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_170218_175985_2EA090C9 
X-CRM114-Status: UNSURE (   9.46  )
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

On 4/5/24 08:42, Bart Van Assche wrote:
> On 4/4/24 16:18, Damien Le Moal wrote:
>> On 4/5/24 03:31, Bart Van Assche wrote:
>>> The order of words in the blk_zone_write_plug_bio() function name seems
>>> unusual to me. How about renaming that function into
>>> blk_zone_plug_write_bio()?
>>
>> To be consistent with your other renaming ideas, what about "blk_zone_plug_bio()" ?
> 
> That name is fine with me. I hadn't suggested this yet because I wasn't
> sure whether that name would be correct.

That function is also called for all BIOs to a zoned block device. So the change
will make things consistent.

> 
> Thanks,
> 
> Bart.
> 

-- 
Damien Le Moal
Western Digital Research


