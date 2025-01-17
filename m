Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58BE4C02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 09:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9TSWTbzFOjQI35Ms/FoU8HyF1BS7JwOhnBq64tiVCoY=; b=FSk3ydRspAabJvNFqKEAPjtNjY
	7FeYcYoSVCx+4ti83+l3EuM0g8dcEgzFu+tqFEbK/ZmM3BIGPKrD86Yq/t22ufeY/YQb+l4IMpsJ1
	zzc6OXzHwiQfMC5V5G70dnBcVDVaF177qcP8OAdqg/e1sq89Mcnm1PTTrdpk6WZ/aJCHVWEVGe+5G
	758RiRyGKNAc4UWSD0m3U6bwld2/vrESkz3yb+MuIi+/YIFn2QJnStrWPsU47uS14TAHDZ9kCFFMz
	Sm6NukjQg4eeGAX8LsiHYT88mbhTJ+eOxLtv22pi4N+IwfDnHuOAvRrGY4+J97Sw6xOp3DJibt0ma
	tgAZCjlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYj0a-0000000HUUw-3ozG;
	Fri, 17 Jan 2025 09:51:20 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYj0Y-0000000HUTy-2YO1
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 09:51:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=9TSWTbzFOjQI35Ms/FoU8HyF1BS7JwOhnBq64tiVCoY=; t=1737107478;
	x=1737539478; b=p0gHeq2iVj1sTM9V4nI2PVd+UHTIVrQbdM5KFn/zcCjOAoPHdFIwKRHbbxqxr
	O47z5eJAfJOJJnJ3AJn1Vrf7aURKyGyoz5bcKl6OpgP+60pWVkamC1Yd530dUnHchW3VsKCgpkiJq
	+luwpTF8da5drljzJqB3ektG2qfH2gKSwn7J5t6nBv2c5oS3tFV7kyfx8nPTn+s4gAmhVmYP//lyx
	3Mtmu6BDRAxEt56QfC3JNc4yooyLS91kkdgZc55R5Z6suXR8bTO1A1uKH6cXFcwGKSwMB8T6jXLyQ
	5R1kkhY4OZ/rlYP9XzFhYNCkWMcRMa9AIulaa5bZ6EPnEsyOGw==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1tYj0Q-00CSES-0t;
	Fri, 17 Jan 2025 10:51:10 +0100
Message-ID: <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info>
Date: Fri, 17 Jan 2025 10:51:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
To: Christoph Hellwig <hch@lst.de>
Cc: Bruno Gravato <bgravato@gmail.com>, Stefan <linux-kernel@simg.de>,
 Keith Busch <kbusch@kernel.org>, bugzilla-daemon@kernel.org,
 Adrian Huang <ahuang12@lenovo.com>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 LKML <linux-kernel@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
 <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info>
 <20250117080507.GA25953@lst.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20250117080507.GA25953@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1737107478;5cb3cb0b;
X-HE-SMSGID: 1tYj0Q-00CSES-0t
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_015118_801850_083D2328 
X-CRM114-Status: GOOD (  17.65  )
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

On 17.01.25 09:05, Christoph Hellwig wrote:
> On Wed, Jan 15, 2025 at 09:40:04AM +0100, Thorsten Leemhuis wrote:
>
>> hch initially brought up that swiotlb seems to be used. Are there any
>> BIOS setup settings we should try? I tried a few changes yesterday, but
>> I still get the "PCI-DMA: Using software bounce buffering for IO
>> (SWIOTLB)" message in the log and not a single line mentioning DMAR.
> 
> The real question would be to figure out why it is used.
> 
> Do you see the
> 
> 	pci_dbg(dev, "marking as untrusted\n");
> 
> message in the commit log if enabling the pci debug output?

By booting with 'ignore_loglevel dyndbg="file drivers/pci/* +p"' I
suppose? No, that is not printed (but other debug lines from the pci
code are).

Side note: that "PCI-DMA: Using software bounce buffering for IO
>> (SWIOTLB)" message does show up on two other AMD machines I own as
well. One also has a Ryzen 8000, the other one a much older one.

And BTW a few bits of the latest development in the bugzilla ticket
(https://bugzilla.kernel.org/show_bug.cgi?id=219609 ):

* iommu=pt and amd_iommu=off seems to work around the problem (in
addition to disabling the iommu in the BIOS setup).

* Not totally sure, but it seems most or everyone affected is using a
Ryzen 8000 CPU -- and now one user showed up that mentioned a DeskMini
x600 with a Ryzen 7000 CPU is not affected (see ticket for details). But
that might be due to other aspects. A former colleague of mine who can
reproduce the problem will later test if a different CPU line really is
making a difference.

Ciao, Thorsten

