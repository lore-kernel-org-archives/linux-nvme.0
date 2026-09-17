Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEE6DC88E72
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2026 03:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WdZytDFux5XnrW+jquReOqJ2UV3d87OKKRnUrIg0b2Y=; b=OHykoo3rQ1IU8DBPNvHk0oR8j1
	F1DfRlZtIXJ8ErYfTW6BCsb1+1dG54wPJuYUNGrUyJ2BHZPcCNe63qqDOIefBqO/SRAqZvPcBc3+k
	xL019BC2qc9sA1KAZnqu8bK6eW+GANO8JSGFl4dEDazZ16JVJkeSRAlADDHx4rUABviAzZ2iIRJRD
	XNUKNa+DeyWb1vIbbDA4vPgZye34BpNHlzsr/VDu2prD9/IRomfYiHZwoiICmDadXuUBCsMmHSqbT
	fL0FE6dv42xBWHBs4LF7WqdricZLUD33KQHXzbM+r1DoJpDnh6cv1UCSh5abNvMwgkEORCjcbpzzC
	oB112igg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x72zb-0000000AXEF-3dwO;
	Thu, 17 Sep 2026 03:40:59 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x72za-0000000AXE6-3Nqt
	for linux-nvme@lists.infradead.org;
	Thu, 17 Sep 2026 03:40:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4502D4050A;
	Thu, 17 Sep 2026 03:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC481F000FF;
	Thu, 17 Sep 2026 03:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789616458;
	bh=WdZytDFux5XnrW+jquReOqJ2UV3d87OKKRnUrIg0b2Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oOetpGb+e6zC5JtDULljJXRYZmTaL77xZsZb3CaO2VuDPqqH43otufbeIpOln3v+h
	 dgZ7Bl+sXyZW0ve86v8vgu/VGC5fIrJuXKJx/+bSQRvGR5r0GyzC27a267Nwzkwk43
	 pvWdIyOPxgrnQ8GUiElptWhIA4frlcqRUDnY8pOm/6BRHHs1DtcBZnSPQDoa6HGFN3
	 krr4OgTdw6oOQgUlafgDaeR5ZpFYqvP5Uy7agG5RTtxyF1KbPO4Oqr1OgKxOddowml
	 LQ4d5nJWxlyom5P0djiPWYs/QxuhOg8aIAkVpW2cHgHL94kKMmVOCgg3Gmo5CqFZqg
	 WkYg0wEJWqtmg==
Message-ID: <cda5c92e-bc41-4cae-a199-8a7fdb9eb187@kernel.org>
Date: Thu, 17 Sep 2026 10:40:51 +0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: work around -Wformat-security warning
To: Arnd Bergmann <arnd@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Maurizio Lombardi <mlombard@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@kernel.org>,
 Nilay Shroff <nilay@linux.ibm.com>, John Garry <john.g.garry@oracle.com>,
 "Martin K. Petersen" <mkp@kernel.org>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260916114533.237863-1-arnd@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260916114533.237863-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 2026/09/16 18:44, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Passing a string variable into dev_set_name() causes a warning
> when building with -Wformat-security enabled:
> 
> drivers/nvme/host/core.c: In function 'nvme_cdev_add':
> drivers/nvme/host/core.c:3911:9: error: format not a string literal and no format arguments [-Werror=format-security]
>  3911 |         ret = dev_set_name(cdev_device, name);
> 
> Remove the temporary strings and let dev_set_name() do the
> same thing internally.
> 
> Fixes: 26acdaa357cd ("nvme: fix crash and memory leak during invalid cdev teardown")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

