Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16CDCD1283
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Mar 2024 21:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ILPcbheZHdFuGMTWruKarxpy4hrw4lKh6I10MWrFRbM=; b=dmtrMhFG5OQg1msYggei6Ml/9i
	/H+JqhDbPLqhLOu8rgUIvX0HFMycoAGKdXHrqTrbem+cwgwDcisVOfKxsdb6rekzE/PusoGggmGW7
	E6vmsA8TrFXIfN8OQszKbImo+RApTelOQbNq6bkM1jDN4tutz1i2QrTH2koL+N8VdvRRfigpSaTT8
	9f0iywtaOA2NJrluWeKlSfS9gmc25rJJaZ5E3bxDBqRapX08gVyCVPI8USc79Y/awwHRUMOJWusHv
	qe4MB4ffXaL0Gwug8Bqj3mikd/DL2kDb7/9QoM+iuvk6eYMi1RLLTy2nniU/H6Wk0DNvgYxeVxHl3
	oauhEDxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqJtx-000000024kj-1MtT;
	Fri, 29 Mar 2024 21:36:41 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqJtu-000000024kF-1zWI
	for linux-nvme@lists.infradead.org;
	Fri, 29 Mar 2024 21:36:39 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V5tyZ27TYzlgVnN;
	Fri, 29 Mar 2024 21:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711748195; x=1714340196; bh=ILPcbheZHdFuGMTWruKarxpy
	4hrw4lKh6I10MWrFRbM=; b=rp/leA2RXultcYnMXa9v+UnwR3CLLwP/CjuBcuuB
	ZD91YXxUS0iXi5XHbF6WDaQ5SN+++kq1O3N1oswPBzIlsGrpo2YkfSrAtpvhv6eB
	X7lthFYp37gBRogie2AlkEEOf0N39Wihz3HPBNTUrTbsGIpGqNc3UO2qmsI7qcKB
	udyCL4/LZbT68tAcJsVmsjSJkrtow/VQgB3xm9Fx4uIF2/oQ0nNSyqKGw5rr0NU/
	H7uaMHWdsvGAB2H0NLCu9eWhfVRowYVFKR+85hDF+6MngkVqcJQCEtPx27f2CsgP
	dfRubV8PFFAS+hz9ns/ZZNoW1FlLu2kmI+YxRHLvmQWTag==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id nzLAYjzdhXIG; Fri, 29 Mar 2024 21:36:35 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V5tyS6jhpzlgTGW;
	Fri, 29 Mar 2024 21:36:32 +0000 (UTC)
Message-ID: <b255e6ec-e698-4ceb-a193-2fcc0eaea5e8@acm.org>
Date: Fri, 29 Mar 2024 14:36:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/30] null_blk: Introduce fua attribute
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-20-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-20-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_143638_681113_9537942A 
X-CRM114-Status: GOOD (  10.55  )
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
> Add the fua configfs attribute and module parameter to allow
> configuring if the device supports FUA or not. Using this attribute
> has an effect on the null_blk device only if memory backing is enabled
> together with a write cache (cache_size option).
> 
> This new attribute allows configuring a null_blk device with a write
> cache but without FUA support. This is convenient to test the block
> layer flush machinery.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

