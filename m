Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00723C4345F
	for <linux-nvme@archiver.kernel.org>; Fri,  3 May 2024 19:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y1oIMl8WbrPn3vhHIGpaNgf49/6UPOvNrGm1EXjpmcc=; b=ARDkqriOGQls2XTjrtlMvEVOQO
	3DLeAUq/+xPybKDoEPiXefM2ncABIKDBJ7AKhlDnvOGFn+Jo4J+aThfErq4XsSOclf9NWKMt1ULq0
	yh7S2pT5PLvqLJ5EpndQVFXOl/v4J6SnoHWCiF4X0pM+mMh9Phcd+lbAZty2bygSBwY7dL98omQ/q
	qQx0rErjxoFd1M0wEkbbZgU3AUTT4NAvsBw07xZ3itiQy9yHuHwwO1cBgaQAUuF/j/L5y4fcfrrtw
	EZl5sjQ8kZl4qy6vT1u25x5yN9dAMj8u4RrnMLv2W4hma6OQja+E5clXNAEl0iQ8rGhkjGd/WzthF
	Cw1Wy7xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2yeN-00000000Bm0-2rMI;
	Fri, 03 May 2024 19:32:55 +0000
Received: from out-170.mta0.migadu.com ([91.218.175.170])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2yeI-00000000Bh4-3DFN
	for linux-nvme@lists.infradead.org;
	Fri, 03 May 2024 19:32:53 +0000
Message-ID: <334617fa-71c2-40a9-9c6f-d5f56c11448c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714764766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1oIMl8WbrPn3vhHIGpaNgf49/6UPOvNrGm1EXjpmcc=;
	b=FAIxbpGsFB8+hDiycUmcDDDpjn0XWNq06ICBKUiW6G642mFuP0IM1nOSmXSzNK+f4Nn7Uq
	eqqQwVvgHphCpn+hPyMfBudvHw3aLtkUd5YnPZ2lcddwK8C0z+a10lbUcLYJuCK/YkIJQH
	GH8ub1+fMRUXrATuQbyJ9r2+hv12w10=
Date: Fri, 3 May 2024 15:32:41 -0400
MIME-Version: 1.0
Subject: Re: [PATCH] nvme-pci: Add quirk for broken MSIs
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240422162822.3539156-1-sean.anderson@linux.dev>
 <ZiaVEfdUXO97eWzV@kbusch-mbp.dhcp.thefacebook.com>
 <dfa3124d-f2e0-4a57-ae1b-618552711b8d@linux.dev>
Content-Language: en-US
In-Reply-To: <dfa3124d-f2e0-4a57-ae1b-618552711b8d@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240503_123251_224823_3753DC6A 
X-CRM114-Status: GOOD (  16.35  )
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

On 4/22/24 13:15, Sean Anderson wrote:
> On 4/22/24 12:49, Keith Busch wrote:
>> On Mon, Apr 22, 2024 at 12:28:23PM -0400, Sean Anderson wrote:
>>> Sandisk SN530 NVMe drives have broken MSIs. On systems without MSI-X
>>> support, all commands time out resulting in the following message:
>>> 
>>> nvme nvme0: I/O tag 12 (100c) QID 0 timeout, completion polled
>>> 
>>> These timeouts cause the boot to take an excessively-long time (over 20
>>> minutes) while the initial command queue is flushed.
>>> 
>>> Address this by adding a quirk for drives with buggy MSIs. The lspci
>>> output for this device (recorded on a system with MSI-X support) is:
>> 
>> Based on your description, the patch looks good. This will fallback to
>> legacy emulated pin interrupts, and that's better than timeout polling,
>> but will still appear sluggish compared to MSI's. Is there an errata
>> from the vendor on this? I'm just curious if the bug is at the Device ID
>> level, and not something we could constrain to a particular model or
>> firmware revision. 
> 
> I wasn't able to find any errata for this drive. I wasn't able to
> determine if there are any firmware updates for this drive (FWIW I have
> version "21160001"). I'll contact WD and see if they know about this
> issue.

Well, the response from WD support was "we don't support Linux, and if
we did there aren't any bugs in the drive anyway".

--Sean

