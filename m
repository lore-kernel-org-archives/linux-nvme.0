Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C26EC2BD09
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Jun 2024 13:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VbKwt14gFQqPYlFlJyY3C86g+aG7f2ya06N7n4GnsqM=; b=l3iBAwEpLfPs+rshf7jd9aRMMU
	mxjb69m1cUGZ3X0UZBDRHQ5QpvUWkmws2QNZ2dphp3tKyI3ax8zlR+SzDR/AgV46zjIE0yM5inz9W
	Cuo+RpVQix16zpF6FMSVdnCi1yqC7IZo3kIaSLMXgy8b1LXyXjGIYU9YS90uVPcZRfxC+EnFbmFXM
	pXj1pRjGYPn31/L1AjMUnPHLp8SxVOAmMhKMJjTfAd4JqqT3RgvhojxVrwDHMUVokWKBqXA1S/Zh6
	rrrmQGkBEpNpTTCSu0wRgZjQz+rzJcxv0rSnZYJocSuyahIAgxyoiKBDYvuBP5dvr5bgtatdVFyMD
	+uQYj1vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNC35-0000000DsT0-0mWl;
	Fri, 28 Jun 2024 13:53:59 +0000
Received: from 008.lax.mailroute.net ([199.89.1.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNC30-0000000DsSJ-3EZN
	for linux-nvme@lists.infradead.org;
	Fri, 28 Jun 2024 13:53:56 +0000
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4W9cNf08FXz6Cnv3Q;
	Fri, 28 Jun 2024 13:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1719582824; x=1722174825; bh=VbKwt14gFQqPYlFlJyY3C86g
	+aG7f2ya06N7n4GnsqM=; b=cPu8YqjzwECf6/Cvud2z6XgE7OuVVZpV4zNBFDKq
	Qnz6dXkmXMG2hdXwgF0J3DCK5KFzyBzii2dwcGWleHWJ0WrScYadFKPOir+f0Aft
	/nFDLgOsb+aUTixwvE92CC+CZi0xZcge2zzA/ZdpZorE/6XyzkqpmdRbSOiEXzIc
	AIoi+BoRmjAPh7VWDnm7wd1TEmcZFp4uUjTW7gHOGaZ6dZHjoce+WokXQ0w2ipzx
	If5KRynp2k6se3CDq+a3umpwSLVrJOttaF4yociv9RlGG09v7sScsKMkWi+zxTb6
	eStAs+EBoGJELvA9i2svY+GIP9bm/QSbqgSdu3JoyhFI3Q==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id d1VM3CVtcbxI; Fri, 28 Jun 2024 13:53:44 +0000 (UTC)
Received: from [192.168.50.14] (c-73-231-117-72.hsd1.ca.comcast.net [73.231.117.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4W9cNJ4zk2z6Cnk9Y;
	Fri, 28 Jun 2024 13:53:36 +0000 (UTC)
Message-ID: <4c7f30af-9fbc-4f19-8f48-ad741aa557c4@acm.org>
Date: Fri, 28 Jun 2024 06:53:32 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v20 02/12] Add infrastructure for copy offload in block
 and request layer.
To: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>
Cc: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, martin.petersen@oracle.com, david@fromorbit.com,
 hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
 joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
References: <d7ae00c8-c038-4bed-937e-222251bc627a@acm.org>
 <20240604044042.GA29094@lst.de>
 <4ffad358-a3e6-4a88-9a40-b7e5d05aa53c@acm.org>
 <20240605082028.GC18688@lst.de>
 <CGME20240624105121epcas5p3a5a8c73bd5ef19c02e922e5829a4dff0@epcas5p3.samsung.com>
 <6679526f.170a0220.9ffd.aefaSMTPIN_ADDED_BROKEN@mx.google.com>
 <4ea90738-afd1-486c-a9a9-f7e2775298ff@acm.org>
 <de54c406-9270-4145-ab96-5fc3dd51765e@kernel.org>
 <b5d93f2c-29fc-4ee4-9936-0f134abc8063@acm.org>
 <05c7c08d-f512-4727-ae3c-aba6e8f2973f@kernel.org>
 <20240626052238.GC21996@lst.de>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240626052238.GC21996@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240628_065354_947217_6053DB30 
X-CRM114-Status: GOOD (  13.95  )
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

On 6/25/24 10:22 PM, Christoph Hellwig wrote:
> It's not just dm.  You also need it in the partition remapping code
> (mandatory), md (nice to have), etc.
> 
> And then we have the whole mess of what is in the payload for the I/O
> stack vs what is in the payload for the on the wire protocol, which
> will have different formatting and potentially also different sizes.

Drivers like dm-linear rely on bio splitting. If the COPY_SRC and
COPY_DST operations travel independently down a stacked block driver
hierarchy, a separate data structure is needed to keep track of which
operations have been split and to combine the split operations into
requests. Isn't this an argument in favor of storing the source and
destination parameters in a single bio?

Thanks,

Bart.

