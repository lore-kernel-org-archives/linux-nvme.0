Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C8FCD11DF
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 21:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=66AKkG3PE4cQTzggRWxgRNhOM7zTlOgr921WiYgCRQ4=; b=HTQU4w8Lyu6XwHx8IMpYx/O4WN
	xY+nsM07AAS5rZNotEd0QmFNn5oWREe5Q7y+ULvKRLl4V/sLNvpFVA2vxTpgAW95tGcwQyHNgj+Dy
	ogZ1/HbrYDcHeQDffE9vvzmAanE9wcaI3SaPmkYqk42olzNXuyGmMg/xl09G/oMkrDaLZyfR6yrDZ
	sbPwp7K0mRwyZs1oJb9w8rWduwYkFVIqkz6lSI18GexX5KVyv9yJulY44+ozmhUT4FugOHorKCijU
	ckdMtbsS6z19jehgSCnvlkDFSLQCzDXs8cK/lRCVb3gX+ZZ8LlZnMKD4wrUsPnopRfghr+aIv0JfJ
	GP2XE9aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpxRw-0000000FnOO-1M6i;
	Thu, 28 Mar 2024 21:38:16 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpxRs-0000000FnO0-1GW5
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 21:38:14 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4V5H2q5dwJz6Cnk8t;
	Thu, 28 Mar 2024 21:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711661888; x=1714253889; bh=66AKkG3PE4cQTzggRWxgRNhO
	M7zTlOgr921WiYgCRQ4=; b=qT4k6f3JyJQBxUXRjsL8Om0gTzhKGsfTk957Swks
	qpxzTuUT94giBQhW8CqaEn0Vjbz1Y3cpmdRVqDzAWyi9IMZ/uY2MkZ0Fb3HC+WPr
	inVs0AGA65ZoFlINUUv+oJBh7IAAjoOMIPIjlv4OykZeK6Uk3XdxMahObbP2RGVz
	GW7NxcgQ/tbYFFoPhxUrXQ8+Y76khG0lVS8Qh4dlksmOKwL5L3nDqGzX6D01JjY2
	cSknGsp2sbwYlu1ynId+ndtgKYfqpTtsUvGwKo1sEg+Q+HV7tfnwLH+2RJ+6qN+e
	OiZVsud85jc7WJqDeMZmw3H0JBbRJ1O2DuDgdLxIXEwTJg==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id t-6wXCmN5Kaw; Thu, 28 Mar 2024 21:38:08 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4V5H2k69fwz6Cnk8m;
	Thu, 28 Mar 2024 21:38:06 +0000 (UTC)
Message-ID: <38575b90-7cd1-48f9-8c86-a77ef372900d@acm.org>
Date: Thu, 28 Mar 2024 14:38:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/30] block: Remember zone capacity when revalidating
 zones
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-8-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-8-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_143813_220911_12FD672B 
X-CRM114-Status: UNSURE (   9.93  )
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

On 3/27/24 5:43 PM, Damien Le Moal wrote:
> +		/*
> +		 * Remember the capacity of the first sequential zone and check
> +		 * if it is constant for all zones.
> +		 */
> +		if (!args->zone_capacity)
> +			args->zone_capacity = zone->capacity;
> +		if (zone->capacity != args->zone_capacity) {
> +			pr_warn("%s: Invalid variable zone capacity\n",
> +				disk->disk_name);
> +			return -ENODEV;
> +		}

SMR disks may have a smaller last zone. Does the above code handle such
SMR disks correctly?

Thanks,

Bart.

