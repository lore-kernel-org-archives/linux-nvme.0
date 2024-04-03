Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4296CD1296
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 09:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uj0mT6ecsQmbbD3y84s+Blq2Eu930+4GVa0se5gXceQ=; b=ooNeKvMp6YlgcWAx+K8+dCDAd9
	HVWl4t2bHUagrHGE9+cLlwhowHiiY6gjlAw0Lrpz/ki2O+sy7NsIePPPahwmnBFTc7APs2FkC/qh2
	vOhu9nm6DfmqEL9Ihro2snD/P97tdQ81N/mXD41TS4i0ImB5v8ekeNm7M7ge6eu2+c6I0DoArOVMS
	V+ubhA1PDjrprxamqnanUoqtmJ/HXR//51CcYPoQmq8WyDgyfuuDZx4K7hZ/s0siSO3qUPWUz7383
	fQaNUPhIn1Er/lUTeEFZJnhpq6T6S81nR1AXOCr21uqe0wD4Th1wA6pgANSMAyWXzI0JF/Ikf8Rr2
	QoMHFWyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwrR-0000000FCH8-1rNf;
	Wed, 03 Apr 2024 09:24:49 +0000
Received: from mail.tuxedocomputers.com ([157.90.84.7])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwrO-0000000FCDO-1TXE
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 09:24:48 +0000
Received: from [192.168.175.29] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
	(Authenticated sender: g.gottleuber@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id 8CADA2FC011E;
	Wed,  3 Apr 2024 11:24:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1712136282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uj0mT6ecsQmbbD3y84s+Blq2Eu930+4GVa0se5gXceQ=;
	b=p1TiY3WAXu4vSaL3Qv6MAobK13vs1HWOeO3ktp0jZJACSf79Xz4kf7vvJbxzuc/2y3yEZQ
	GmxyZQbzptUSq+DetyjQLiRqC8fyws80Yk2EOfmjZTX/ZxsDInaw9Ipg7mfEVHMojvngHc
	qLRuEQi+igaq0Y/txxXvEEm91iH6OqI=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=g.gottleuber@tuxedocomputers.com smtp.mailfrom=g.gottleuber@tuxedocomputers.com
Message-ID: <f7a70add-4d65-40a4-91ff-70bc14a64467@tuxedocomputers.com>
Date: Wed, 3 Apr 2024 11:24:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: Add sleep quirk for Samsung 990 Evo
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Werner Sembach <wse@tuxedocomputers.com>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Georg Gottleuber <ggo@tuxedocomputers.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240328130923.61752-1-wse@tuxedocomputers.com>
 <20240402131658.GA31963@lst.de>
 <230e3f41-9f6b-42fd-a411-567abbaebbbe@tuxedocomputers.com>
 <ZgwtYpbcyM_ffjaF@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Georg Gottleuber <g.gottleuber@tuxedocomputers.com>
In-Reply-To: <ZgwtYpbcyM_ffjaF@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_022446_870321_B28FABE1 
X-CRM114-Status: GOOD (  12.23  )
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

Am 02.04.24 um 18:08 schrieb Keith Busch:
> On Tue, Apr 02, 2024 at 05:13:48PM +0200, Georg Gottleuber wrote:
>> Am 02.04.24 um 15:16 schrieb Christoph Hellwig:
>>> On Thu, Mar 28, 2024 at 02:09:22PM +0100, Werner Sembach wrote:
>>>> From: Georg Gottleuber <ggo@tuxedocomputers.com>
>>>>
>>>> On some TUXEDO platforms, a Samsung 990 Evo NVMe leads to a high
>>>> power consumption in s2idle sleep (2-3 watts).
>>>>
>>>> This patch applies 'Force No Simple Suspend' quirk to achieve a
>>>> sleep with a lower power consumption, typically around 0.5 watts.
>>>
>>> Does this only apply to a specific SSD or all SSDs on this platform?
>>> How do these platforms even get into the conditional?  Probably
>>> through acpi_storage_d3 setting, which probably is set incorrectly
>>> for the platform?  Any chance to just fix that?
>>
>> Yes, this only apply to a specific SSD. I tested these SSDs (on
>> PH4PRX1_PH6PRX1):
>> * Kingston NV1, SNVS250G
>> * Samsung 980, MZ-V8V500
>> * Samsung 970 Evo, S46DNX0K900454D
>> * Samsung 980 Pro, S69ENX0T709932L
>>
>> S2idle consumes around 0.4 watts with these SSDs. But with a Samsung 990 Evo
>> s2idle on this platform consumes 3.7 to 4.4 watts (6.8 vs 6.5 kernel).
> 
> For all these different SSDs you tested in this platform, do you see the
> "platform quirk: setting simple suspend" in the dmesg? I just want to
> confirm if the platform is changing the reported acpi_storage_d3 value
> for different SSD models or if they're all the same.

Yes, without my quirk for all tested SSDs (including Samsung 990 Evo) 
"platform quirk: setting simple suspend" is printed in dmesg.

