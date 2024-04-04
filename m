Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E882ECD1284
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Apr 2024 23:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hCNNSFTHXgF2NbuSv1+knxGgM+QOk7VTtWOf3chMhZk=; b=1pJBpl/PF0miHpvR5XBxZEEh7L
	VSCuXcEuWnvVwbQR3cYmVpII95Qqy7pCEStp5gMjp4iu2pD5rWnyYvpD1q21OicY3USUb4/gJRpf2
	bc5Na4NmLfAS97e6ekeq44N24x7lR0WCwSHkDHoFZnKfgBFmVnS/Sv56X0ZYzFcd42fndES7YTD0R
	Rlfnos5Ey0DmlPy5CdmcUwXx6nRHYrNE5X/NvtJQnkLQuQSLBCIPssHvOdAACUc//FGR4ZxesXhBZ
	sz2kdtwqH2MsjginaEL94rRYNe8DHc/6WdF9OPQm+LqNtHD66ESewKhE1DCxJEyDpvVtG6IJ+5Z1+
	2/DeNLrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsWj4-00000004dDP-15HF;
	Thu, 04 Apr 2024 23:42:34 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rsWj0-00000004dCf-3wQd
	for linux-nvme@lists.infradead.org;
	Thu, 04 Apr 2024 23:42:32 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V9dT14jxVz6CmcjL;
	Thu,  4 Apr 2024 23:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1712274146; x=1714866147; bh=hCNNSFTHXgF2NbuSv1+knxGg
	M+QOk7VTtWOf3chMhZk=; b=IcekslrO0yYvDrQj9oYpX8SP2P9SxxVvqpG7qQlo
	myaaJJ3coLr2VpEjsnnDcfnI9cmLwG4/FQgMeb9zvK1lbOtmzNTIL1vXSOEpFPYr
	/dGIY2oAak8OwIYC9FkBSWltcCiiC85YGSq6w0MzPfhRPbgwV7ZeNaZ6B9hqJHju
	a3p0evgcFLvB2xPvsgeysd79Kblqx1BK42AmsYDz9aFdokVoY51uqKV7AwvkZOuf
	hyqA7Ph2HKp+rnBrsGM9ZUCTDCedzaFyIohq/JLRU91Im2q9wv/74A4SEhXk6HBw
	fEIGXTmpqL9Alqz5juKrENJTajW5gLZZY+MtKZqeq4z91A==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id FM9lWrRTfceT; Thu,  4 Apr 2024 23:42:26 +0000 (UTC)
Received: from [192.168.51.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V9dSt52y5z6Cnk9X;
	Thu,  4 Apr 2024 23:42:22 +0000 (UTC)
Message-ID: <889ca9a7-833c-4a78-9c59-328f54d28219@acm.org>
Date: Thu, 4 Apr 2024 16:42:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/28] block: Introduce zone write plugging
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240403084247.856481-1-dlemoal@kernel.org>
 <20240403084247.856481-8-dlemoal@kernel.org>
 <c3bbe9ac-690c-43a7-bc75-3634af5cfe7a@acm.org>
 <6bad5d07-01bf-466a-86bb-e082ed961049@kernel.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6bad5d07-01bf-466a-86bb-e082ed961049@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240404_164231_046089_B111C2D2 
X-CRM114-Status: UNSURE (   7.58  )
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

On 4/4/24 16:18, Damien Le Moal wrote:
> On 4/5/24 03:31, Bart Van Assche wrote:
>> The order of words in the blk_zone_write_plug_bio() function name seems
>> unusual to me. How about renaming that function into
>> blk_zone_plug_write_bio()?
> 
> To be consistent with your other renaming ideas, what about "blk_zone_plug_bio()" ?

That name is fine with me. I hadn't suggested this yet because I wasn't
sure whether that name would be correct.

Thanks,

Bart.


