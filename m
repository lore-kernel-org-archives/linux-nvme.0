Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D35BC4345F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Apr 2024 17:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n+HLUjf4Ec921cDOe34OXWrTEtib0L9ZdmgXujdfGBQ=; b=Ta3YtrdZqiRZLZOfCI71z3w3Nf
	lKKc/ri97LfhxD9AfyQJhk6kBMVS/MSf+AzuF3Qf2RzY3izLvoIhKXIFP+xgPbQoLva7lfafUGasV
	WjGJxay6F1CbB9gGEhEKSOOhGktH29XzhwTaTJKBW4t1QlRThoePu9/7mxAk4lJEdQYS4/zLXzI2k
	Wu+qewsKcQRpsgIyomTA14uX0gSKnIpQsHMPhXMNcVYym1JI93ibZvRwhTol3GHOlUQOwvG2DPMsi
	u4N7HQc9sV9BwumkvydJw/7g0yXiXGQ+0Je5V4Yy9523rsqXi1I4Bs9LXvO1qtrnswSoobyb5ty3m
	XFqoG3Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryxGf-0000000ES9B-0TTi;
	Mon, 22 Apr 2024 17:15:49 +0000
Received: from out-176.mta0.migadu.com ([91.218.175.176])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryxGb-0000000ES8H-1zuz
	for linux-nvme@lists.infradead.org;
	Mon, 22 Apr 2024 17:15:47 +0000
Message-ID: <dfa3124d-f2e0-4a57-ae1b-618552711b8d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713806142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n+HLUjf4Ec921cDOe34OXWrTEtib0L9ZdmgXujdfGBQ=;
	b=ktNv6d5OL7NoonVORzxhzZasbuDFvJvHYczqImWOGZYQPCcgBpOQCgEOoqkjXM6afPa2DS
	vEFiG1pTZqOhQE9/Aco6VqEHR0o3bC3ag16tCJBFgUw5pygFtmmzUAhWnufe4o3tG4l4KI
	bgI1JmZtJZhcV10KsnCZTTixhrwCD2g=
Date: Mon, 22 Apr 2024 13:15:38 -0400
MIME-Version: 1.0
Subject: Re: [PATCH] nvme-pci: Add quirk for broken MSIs
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240422162822.3539156-1-sean.anderson@linux.dev>
 <ZiaVEfdUXO97eWzV@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <ZiaVEfdUXO97eWzV@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240422_101545_826145_2AF48D44 
X-CRM114-Status: GOOD (  17.13  )
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

On 4/22/24 12:49, Keith Busch wrote:
> On Mon, Apr 22, 2024 at 12:28:23PM -0400, Sean Anderson wrote:
>> Sandisk SN530 NVMe drives have broken MSIs. On systems without MSI-X
>> support, all commands time out resulting in the following message:
>> 
>> nvme nvme0: I/O tag 12 (100c) QID 0 timeout, completion polled
>> 
>> These timeouts cause the boot to take an excessively-long time (over 20
>> minutes) while the initial command queue is flushed.
>> 
>> Address this by adding a quirk for drives with buggy MSIs. The lspci
>> output for this device (recorded on a system with MSI-X support) is:
> 
> Based on your description, the patch looks good. This will fallback to
> legacy emulated pin interrupts, and that's better than timeout polling,
> but will still appear sluggish compared to MSI's. Is there an errata
> from the vendor on this? I'm just curious if the bug is at the Device ID
> level, and not something we could constrain to a particular model or
> firmware revision. 

I wasn't able to find any errata for this drive. I wasn't able to
determine if there are any firmware updates for this drive (FWIW I have
version "21160001"). I'll contact WD and see if they know about this
issue.

[1] https://www.westerndigital.com/products/internal-drives/pc-sn530-ssd

>> 02:00.0 Non-Volatile memory controller: Sandisk Corp Device 5008 (rev 01) (prog-if 02 [NVM Express])
>> 	Subsystem: Sandisk Corp Device 5008
>> 	Flags: bus master, fast devsel, latency 0, IRQ 16, NUMA node 0
>> 	Memory at f7e00000 (64-bit, non-prefetchable) [size=16K]
>> 	Memory at f7e04000 (64-bit, non-prefetchable) [size=256]
>> 	Capabilities: [80] Power Management version 3
>> 	Capabilities: [90] MSI: Enable- Count=1/32 Maskable- 64bit+
>> 	Capabilities: [b0] MSI-X: Enable+ Count=17 Masked-
> 
> Interesting, the MSI capability does look weird here. I've never seen
> MSI-x count smaller than the MSI's. As long as both work, though, I
> think nvme would actually prefer whichever is bigger!

--Sean

