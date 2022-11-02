Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24203C433FE
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Nov 2022 19:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sxjdHr5HfplAifaT8iogACZ1S3qCi0eDD569vOmEXnc=; b=cEv8Sz7FNUfjZmB/1On81fKSGM
	uSUTJ2DU/v1WFtBSvyYQWnxGB9aIpqA5C4xXK1517etre7KrFvyMAuMF8ZfcrF6v6IM0VaIXDmO6Z
	ojEl66A/01J1axB1C7BATbJPrKJYw11/8j1tTUEoLs+yy5Yc7IkygsGvEd1xJFlTTwPQKzM3gki9S
	oXOI4wso93HxapB3RRrMb+d/7pNItefWIMrDjFbJUnYfXVrpD/CryKfOIBHITvoywqReRNV9u2ArR
	X8FElfdL930m7AYWF5fyrvAZ0KKFF6ufy07AkAkH9eoTQ6T/ZS9M5mRFVOWV337gP/sS3/ZB2XXji
	CSyNk1vQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqJTX-00DrmP-79; Wed, 02 Nov 2022 19:32:35 +0000
Received: from odysseus.binarus.de ([144.76.90.229])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqJTT-00DrYu-1V
	for linux-nvme@lists.infradead.org; Wed, 02 Nov 2022 19:32:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=binarus.de; s=b201601;
	t=1667417539; bh=FUh5CECrGPid8n5WK5DzFYbBJ4TtZmT9PN4Dd9ffUHc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Reply-To:
	 Subject:Date:To:Cc:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	 List-Subscribe:List-Post:List-Owner:List-Archive;
	b=QzsOeGJQaedXq8uVppSOcULljGoE1eMB5C5BjKmbEflE3aKeeIctDDfxBGoOTlS6/
	 zaFfAjoPDNciZ4SsriaecBYYhc8PdNfQE45mG6ZU7otFF6OVLUVmNoLzzKcz32y9F6
	 OLpI863K9Y86XgRZzX84HnDJX8gwP/Qpo9glhiKlY7oxadTsHHw0RWNDJP95KWF5gl
	 kuphjiu2TRj/ojZXM6ltLdK6P969fcRL/WVARcp9qXXwa4O8cpKIqb2s8sVqKkgs3Y
	 3O8n/leeDp3BfoExs4BYKTj1gcWyLMrCowyVKr7nVsayYh64qdoxv8LmbWt3uGw/wM
	 ZDRqz/A2q3CD8oXT3fx0RlgKTQbKFMn1IErUsTZmxlW7hn2RycJ/n+sNo4cui9BxmI
	 DKEu6fgS7eHX0zFATeeeZtshcg/pFUUej4FgtJ+ssIdm8szOYf+Tbl738XuFMSmYDq
	 ensL4htSeOHbht4HmsuBwtHTsm4XU5JZGcDCPloKx1z2wHmEeQjhclIm0SqbLMpHfO
	 0Wg/f0LiY8MPaStvI55VP1iCFWxu7QneDA9gyOPoNG6u0G6zcZg60iIy/eSOssUSzw
	 h0eYc5Vv/v3wrwK0/+ovwJz27xZVe4JkOpED1hmOXw7QccmYF8MEQKB/JWvTB034Kt
	 dfM1oWJ37RLaN6L2UpQ1tyi8=
Received: from [192.168.20.110] (pd9fb9b07.dip0.t-ipconnect.de [217.251.155.7])
	(authenticated bits=0)
	by odysseus.binarus.de (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTPSA id 2A2JWJL5014110
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT);
	Wed, 2 Nov 2022 20:32:19 +0100
Message-ID: <d75c7e0b-e8a5-5f01-05ae-3cd86b2d95bf@binarus.de>
Date: Wed, 2 Nov 2022 20:32:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Betterbird/102.4.1
Subject: Re: nvme-format: protection information enabled although metadata
 size is 0
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <b9ca7931-0384-d0e1-92b5-c2ffbadc195f@binarus.de>
 <Y2KN8wHy5l9HxOgW@kbusch-mbp.dhcp.thefacebook.com>
 <0865c0c4-1632-3a86-939b-feb2d2ce7f32@binarus.de>
 <Y2KT7ypZZdK4nlHq@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Binarus <lists@binarus.de>
In-Reply-To: <Y2KT7ypZZdK4nlHq@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Bin-MAIL-FROM: <lists@binarus.de>
X-Bin-RCPT-TO: <kbusch@kernel.org>
 <linux-nvme@lists.infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221102_123231_740618_6C096884 
X-CRM114-Status: GOOD (  28.26  )
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

On 02.11.2022 16:59, Keith Busch wrote:
> On Wed, Nov 02, 2022 at 04:42:21PM +0100, Binarus wrote:
>> Thank you very much for confirming that this is a bug. May I steal your time again and ask what you would do in that situation? Throw away the device because we can't trust it, or format it with 8 bytes of metadata and hope that the PI works correctly then?
> 
> I think that's going too far. To the best of my knowledge, the device
> works fine. You just hit an untested parameter combo. The device may
> report you requested PI, but without metadata, it's going to behave the
> same as a non-PI 4k format. If you supply valid paramters for pi
> formats, then the device will correctly honor that.

In the meantime, I have updated the firmware and confirm that this die 
not changed the wrong behavior. There is still no error message when 
using nvme-format with the wrong parameters shown in my first post.

Thank you very much for confirming that using the correct parameters 
(i.e. LBAF 4) will actually enable the PI. That's the way I would have 
expected it.

> I'm not sure if you're familiar with the different nvme metadata types
> though, so I'll add that this particular model's does not work with the
> Linux kernel's end-to-end protection. This device supports only the
> "extended" metadata, not the "separate" that the Linux block stack
> requires. You won't be able to use the generic block layer for IO with
> protection information, but you should be able to use it in passthrough
> modes. And if you are using the 8-byte format (LBAF 4, I believe), then
> the driver will have the device strip/generate PI without the host ever
> seeing it.

I have a vague notion of the metadata types, and have recognized 
something which worries me even more:

In the datasheet / manual for the P3700 from October 2015 (newest 
version I could find), in table 34 on page 38 which describes the 
Identify Namespace data structure, it clearly says that byte 27 will 
report value 0x3, which means that both metadata types (extended and 
separate) are supported. From the "Interpretation" column of the "MC" row:

"Indicated support for metadata transferred with the extended data LBA 
and in separate buffer - both are supported."

However, when I execute nvme id-ns /dev/nvme0n1 on the machine in 
question, it shows the value 0x1 for the MC, which means that it 
supports only the extended LBA metadata.

That means the either the datasheet / manual or nvme is wrong. I guess 
that the former is the case, and your statement supports that.

I had absolutely no clue that the standard Linux IO does not support 
extended LBA metadata, and thus does not support extended LBA PI. That's 
quite disappointing. Currently, I don't know what the passthrough mode 
you have mentioned is, but I'll research it.

Perhaps I am using it already, because the SSD in question acts as a 
cache device in a ZFS pool. Since ZFS circumvents the normal I/O layer 
at some places, maybe it can use extended LBA PI.

I am aware that I wouldn't need the PI anyway with ZFS (because ZFS has 
its own checksumming which sets it apart from other file systems), but 
I'm eager to learn more about NVMe and the PI for future cases and other 
constellations, so I'll read about passthrough and Linux. Plus, we have 
a few (consumer) Samsung SSD 980 Pro in Windows machines here, and of 
course we would like to learn how to turn on the PI on them (if Windows 
supports it at all).

Thank you very much again, and best regards,

Binarus


