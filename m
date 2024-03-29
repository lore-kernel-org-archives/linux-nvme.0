Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219E4CD1288
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Mar 2024 18:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zzP43llTKg7DoHlGhnYSqTEepAlnkQyaYFDOl5YgzqM=; b=n54LJEa+JMoYaAkZP7amdruIAR
	oDWqOl2N77Uje7+ZSpCxoTVHpIow14McOd1Yze4O/5F/CBQsEyg07p2l+OIJV8J++4JSYRpY/A0Te
	fqGmxrb/lbYorf274uYtZDhsi9ztmCxPmNnXQspNVdy+aLfqaSp/4oPMm741LOrtCrLpHvD7WTAWt
	5ePfCi4TgfS1TsM+Jk1pZUbabP0uNsIlDOvhGQ/iRHbUHg1cj8ayQ1uwEB4C1qcoaB+IAlMkEoS5/
	64kAsA3pgNmu/rWlfpG3lhqfO7+zNOMc8k26gAOc25C7rcr0jUa2rTNzLZHi8uG+7uN8YrA7VbeBV
	PxNg2qlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqHPs-00000001gGK-2KNR;
	Fri, 29 Mar 2024 18:57:28 +0000
Received: from 009.lax.mailroute.net ([199.89.1.12])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqHPp-00000001gFR-2nGf
	for linux-nvme@lists.infradead.org;
	Fri, 29 Mar 2024 18:57:27 +0000
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V5qQs2LWRzlgTGW;
	Fri, 29 Mar 2024 18:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711738642; x=1714330643; bh=zzP43llTKg7DoHlGhnYSqTEe
	pAlnkQyaYFDOl5YgzqM=; b=2Ef14ySES0oYGSxY8mTnPZZHm5q2wiSA9jvdY7Dz
	7NRmpccfKxLWUcN1wRI+kuYOJr7es7gMtnFpN/dvV5wRqDx15AHr6G88rkUd1S2p
	nx1/f5M39ll7JjrslUTQAodi1C0rGbE36nbImo9pwDbbD391M3PUtnNUkwGkiJwI
	L/qxvyLBprw0iTnmXCh3tedwFsSt9a7NXw3SttzNRZ3+/wKCJgamGwncA3S+Ppmw
	4TYJQf5FPqTDGmk3z8VQ07IFfAgcgNHaCBT+7uWbQd/FrVjAaurZMD3lVdUE26UG
	B7p7ywK1/VbkLVWD8ccgooHZ4ZSZvLTkZsWlRz28/U2Njw==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9vmC3TeOYjRz; Fri, 29 Mar 2024 18:57:22 +0000 (UTC)
Received: from [192.168.3.219] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V5qQl4GmdzlgTsK;
	Fri, 29 Mar 2024 18:57:19 +0000 (UTC)
Message-ID: <a690683c-9390-441c-b640-230f4b76cb59@acm.org>
Date: Fri, 29 Mar 2024 11:57:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/30] block: Remove zone write locking
To: Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
 Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, Mike Snitzer <snitzer@redhat.com>,
 linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
References: <20240328004409.594888-1-dlemoal@kernel.org>
 <20240328004409.594888-29-dlemoal@kernel.org>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240328004409.594888-29-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240329_115725_994537_8ECD6A42 
X-CRM114-Status: GOOD (  10.98  )
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

On 3/27/24 5:44 PM, Damien Le Moal wrote:
> Zone write locking is now unused and replaced with zone write plugging.
> Remove all code that was implementing zone write locking, that is, the
> various helper functions controlling request zone write locking and
> the gendisk attached zone bitmaps.
> 
> The "zone_wlock" mq-debugfs entry that was listing zones that are
> write-locked is replaced with the zone_wplugs entry which lists
> the zones that currently have a write plug allocated. The information
> provided is: the zone number, the zone write plug flags, the zone write
> plug write pointer offset and the number of BIOs currently waiting for
> execution in the zone write plug BIO list.

Shouldn't the second paragraph of the description go into patch 27/30?

Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


