Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484CCC47258
	for <linux-nvme@archiver.kernel.org>; Sun, 28 Jan 2024 14:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JUPVbwBbIb932VoPr/Xkz7yfsnw+0AknslUEu6iiqtA=; b=UOcLmR37iTbHJgr3IBKFMXasrB
	pTiNaG6ZD5TFwUXwNUlItZnGM3ffi69VKofIpnssgF3YITgU6Y0K8RAFlih9+9CJIYp7RECq8+IkB
	dYP+u2hhl++fkErnLK6622E/oTWUpsg4hKq/hfcAmn3pIJg/xxjsOf5KXenMGD09Rjr1+ohYbert6
	Hlj+bezOxSE8ZZYEoRQNkP7mTugOA7/HqvP52ZdKXqjNxAJ2t3PyuUXwvB0Zt3Xtut/VdAJ7W15S5
	i0JXGkBMKjIMt19j3+aquYxfGpMR6ZPQ15FKuPT6A2hXiMiP+1Nz1kyv0czObZPe25OlCNschmXGy
	uN3ETkiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU5yp-00000009cJI-38wy;
	Sun, 28 Jan 2024 14:17:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rU5yn-00000009cHj-1D6V
	for linux-nvme@lists.infradead.org;
	Sun, 28 Jan 2024 14:17:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8016761ABC;
	Sun, 28 Jan 2024 14:17:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5151C433C7;
	Sun, 28 Jan 2024 14:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706451468;
	bh=RoxJSSEQ4kBSEYdnq0+0Opb+KfmxggM7Lnpp+Qcsv6M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ou+AJSfBH8gAJXTmPmXqF6d2llBOk6QxOSMs19UpUw/KvXutvACQOczuZX4Z9KYJ4
	 Iaw4gP+3XpYo7ZcediLiD/faJ+aqW9dXVLqXAL63bSqlg4i6YN3f3o0AoRmwtY7nm3
	 Io+Q0MI69HPWQsHPbD3ePcnE0n63IMRoeIFjhEiqhRlW+iumdVlCqjqb1oQPbtVOUC
	 rlw0iDJlN+8s7p+dILwU4hzlqjQOG/sT3+MeMgV0kvhLKjS96gAZS/rnt0HtsoT8/K
	 t32GFm6AqbZyjh5NnP2F8T9i8k+cIc/gjskCi4ax3ekSIBTcAjuRqJxoHXZXwVHn9j
	 BXwAtgcJxtScQ==
Message-ID: <0431e068-9371-48a3-bf16-a7caaf1902b8@kernel.org>
Date: Sun, 28 Jan 2024 23:17:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Western Digital SSD freezes on power saving
Content-Language: en-US
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Frank Tornack <f-tornack@t-online.de>,
 Linux NVMe <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, Guenter Roeck <linux@roeck-us.net>
References: <dfe9213bb86939ca4502b5b3fdd3ab77ef1b6f1b.camel@t-online.de>
 <ZbZe5OPlqhwi_erM@archie.me>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <ZbZe5OPlqhwi_erM@archie.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240128_061749_431139_0893429B 
X-CRM114-Status: GOOD (  23.39  )
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

On 1/28/24 23:04, Bagas Sanjaya wrote:
> On Sun, Jan 28, 2024 at 01:26:23PM +0100, Frank Tornack wrote:
>> Hash: SHA512
>>
>> Hello Linux kernel developers and experts,
>>
>> I have a question that I think is not tied to a specific distribution
>> and goes pretty deep into the Linux kernel. I hope you can help me
>> without subscribing to the mailing list and remember to include me in
>> the answer discussion. 
>>
>> In my old notebook I used an nvme-ssd from WD (wds500g1b0c-00s6u0),
>> which is affected by a well-known bug. I currently use the parameter
>> `nvme_core.default_ps_max_latency_us=0` to prevent the system from
>> freezing. 
>>
> 
> What well-known bug?

Indeed... What bug ? Is there a firmware update for that SSD ?

> 
>> I would like to use a new SSD in my new notebook. However, as it is
>> difficult to sell used SSDs, I would like to continue using the old SSD
>> affected by the bug. I plan to move the SSD to a Thunderbolt enclosure
>> for this purpose. I think since Thunderbolt is based on PCIe, the same
>> energy saving measures and the associated bugs will probably apply.
>>
>> In the hope that my new SSD doesn't have the same bug, I would prefer
>> not to disable the Powersafe in the laptop. Is there a way to set this
>> flag only for a specific SSD? By identifying it by name or serial
>> number? 

echo 0 > /sys/block/nvmeXnY/device/power/pm_qos_latency_tolerance_us

will have the same effect as nvme_core.default_ps_max_latency_us=0 but for this
device only. For reliable device name, see under /dev/disk/by-id and find your
"buggy" nvme device there using its model name+fw-revision.

If a more permanent fix is needed, then we would need to add a quirk for this
device to the nvme driver.

>>
>> I apologise prophylactically if my question is completely out of place
>> and thank you for your help. As a long-time Linux user, I would also
>> like to thank you in general. If you have any follow-up questions,
>> please do not hesitate to contact me.
>>
> 
> Confused...
> 

-- 
Damien Le Moal
Western Digital Research


