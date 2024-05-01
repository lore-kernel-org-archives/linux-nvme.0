Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1EAC4345F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 May 2024 21:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PKNNWCshZo5IMqUo5Tp4LUaPWoT/EewF4SNVvkiGENw=; b=Aqq7epMmcuIPwCCjQevWRfTJVt
	+467cU2vyLksSa0NHZVuM0tNqwesb9KzxL++65VnaOdPU79W7139eXGDhktIq25t9pQO5T8CovzJL
	PKSot/288bjn8wYuv8QqB/J9WhUuv4uisZpgcSZ83P8n5VJ8/SBDk8uDpsDSeLAzYSchU84yZR0cy
	6bhE9hOGXwYtR9cn3ygBsDS29dLsqvH9ogqQf9irub3LKL0H9oRM5tENZyWsAQmpe3R+t18AsyicT
	fPi2KBsbfEaxkXWVt0+jD/aw1FBpn8oHDOXy8HCbfbOL7ASKyYjZC5xckfRpbm4f7FV4IvkANe3xw
	iIqXyoLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2H4K-0000000AhKV-0gbx;
	Wed, 01 May 2024 21:00:48 +0000
Received: from mx3.molgen.mpg.de ([141.14.17.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2H4F-0000000AhIB-2QXg
	for linux-nvme@lists.infradead.org;
	Wed, 01 May 2024 21:00:46 +0000
Received: from [10.50.1.206] (unknown [89.187.201.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9500761E5FE05;
	Wed,  1 May 2024 22:58:06 +0200 (CEST)
Message-ID: <93c29602-b162-47b3-9a03-a18158b9f6ef@molgen.mpg.de>
Date: Wed, 1 May 2024 22:58:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: `nvme_disable_ctrl()` takes 411 ms on a Dell XPS 13 with SK hynix
 PC300 NVMEe
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org
References: <19a6071a-7fb8-4e0f-8050-6f3ba5ee4774@molgen.mpg.de>
 <20240501045145.GA32110@lst.de>
 <ZjH2Coc8Wz9QrdRM@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <ZjH2Coc8Wz9QrdRM@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240501_140043_783914_72F6DFFC 
X-CRM114-Status: GOOD (  15.95  )
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

Dear Keith, dear Christoph,


Am 01.05.24 um 09:58 schrieb Keith Busch:
> On Wed, May 01, 2024 at 06:51:45AM +0200, Christoph Hellwig wrote:
>> On Wed, May 01, 2024 at 06:29:12AM +0200, Paul Menzel wrote:
>>> Could a warning be logged, when this takes more than 50 ms with a hint that
>>> the disk vendor should improve their firmware?
>>
>> Not sure why we'd warn about it.  A clean shutdown can definitively take
>> some time and there's nothing tha forbids it.  I don't think a linux
>> message is going to have any effect on firmware engineering..
> 
> Exactly. Unless the device reports a lower D3 entry latency, then this
> sounds like everything is working-as-designed.

Maybe according to the spec, but I have a hard time to believe, that 
disks should take longer to shut down than coreboot to initialize a 
mainboard.

In the end, in my opinion, users cannot make an informed decision, if 
these things are hidden. If it would be visible somehow in the logs – 
maybe not warning but info level – then even not so technical users 
could inform themselves and factor this in their buying decision.

> You can check your device's advertised shutdown time (assuming your
> device is nvme0):
> 
>    nvme id-ctrl /dev/nvme0 | grep rtd3e
> 
> The value is reported in microseconds. If it shows 0, then the device
> doesn't report an expected shutdown time.

Thank you for sharing. It’s 60 ms:

     $ sudo nvme id-ctrl /dev/nvme0 | grep rtd3e
     rtd3e     : 0xea60

6 * 16 + 10 * 256 + 14 * 16 * 256 = 60000

No idea, if ftrace skews something.


Kind regards,

Paul

