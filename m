Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 385B3CA9EDD
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Oct 2026 16:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gjubPOuxdvWHce9i4IPxOTkmVc5NCDr07T7TK4hmZvk=; b=SUpCpz8benfFBz2L4S++nITM2v
	cVorqCiLxwu4ZzS9pVVRRJd+JWWFFgYZoQP5YxNq3971pivEZDXG9MXSX2tR9EJIqh0f0VlHzQFjR
	5VtGsjZMtlFO5DU1JgH/Dva7D2DtmXpv8sYnJtyzv4bVFWSRrO34h5IS/vgzODGVyZ6YP8H560Z5B
	nlos1GEOWypI7swFKEH9ZEWnRumh8GpWpemu6bJIQt5IhGeq/hyVBZB2339DjP2xB6vlcvNOMCS9t
	OruHhaUNXzvD58Ut5a1U4WI1RA19hFh2kissguOxit60aNY4ytxTutUB811GaWJ3hW5Na+F5FkzUV
	S9Ci1IGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGIpY-0000000AxHT-1Ags;
	Mon, 12 Oct 2026 16:24:52 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGIpW-0000000AxH6-0GMS
	for linux-nvme@lists.infradead.org;
	Mon, 12 Oct 2026 16:24:51 +0000
Received: from [192.168.1.70] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9B36F20B7166;
	Mon, 12 Oct 2026 09:24:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B36F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791822285;
	bh=gjubPOuxdvWHce9i4IPxOTkmVc5NCDr07T7TK4hmZvk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=auFpsEqBZP5CtAUsUXapXjiHxzL3yHdCBeIWvsSEpxJ2jaqJdVuHLgCmgl1tyBjlD
	 SwbWsRo7ypCwS0Lmq4EEZ1t4IFLm4BXqUMVFJEY4vADjN8+IA/uluugycMCOwzoEWy
	 GWLSXp/x4gR4qO5Ssazj8JKBL+6LCK30YpoKhci4=
Message-ID: <b3f3b6fe-893c-4a24-b8c0-3a929cb581ac@linux.microsoft.com>
Date: Mon, 12 Oct 2026 21:54:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] nvme-pci: defer completions when rescheduling is
 needed
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <20261009050556.2817978-4-namjain@linux.microsoft.com>
 <askIoNon8UVyNJiJ@kbusch-mbp>
 <8aba4809-6655-4bfd-a83a-25c5ab816645@linux.microsoft.com>
 <aszuckZVkc2-kXM3@kbusch-mbp>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <aszuckZVkc2-kXM3@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_092450_137193_18443001 
X-CRM114-Status: GOOD (  17.94  )
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



On 10/12/2026 7:58 PM, Keith Busch wrote:
> On Mon, Oct 12, 2026 at 12:17:38PM +0530, Naman Jain wrote:
>>> The disable_irq_nosync still does non-posted transactions for msi and
>>> msi-x. NVMe has a shortcut for msi, but there's currently nothing for
>>> msi-x. For that case, I have a prep patch I consulted with Thomas, and
>>> the result is below. I'm delayed sending it out while catching up from
>>> travel, but I think this will be even more efficient.
>>>
>>
>> Thanks for sharing. I'll give it a try. IIUC, after your patch goes in, I
>> should be using disable_irq_nowait() in above and see better performance.
> 
> Yes, exactly. It should save hundreds of CPU cycles on every switch from
> irq to polling.
> 

Understood.

>> Please correct me if I am wrong. I'll monitor your patch in LKML for future
>> versions.
> 
> I need a user for the new API. NVMe is the only one I have in mind
> right now, so this new irq disable would have to be tied to the series
> that does the adaptive polling.

Acked. For this series, there are couple of solutions floating around in 
LKML, and we are trying to converge on the final approach. Once 
finalized, if we still need to call disable_irq_sync(), we can make use 
of this new API. In any case, if I happen to send the next version of 
this, I can use the new APIs, creating dependency on your changes.

Regards,
Naman

