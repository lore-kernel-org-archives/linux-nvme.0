Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557CAC02183
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Jan 2025 10:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y5cEtfBREYaGqWmqOHQr7JmJKxS9Ebst+7cMQ+meioQ=; b=Oux05uUaFSO5PZ6ofQ4XrAq/Mr
	Cg7q1wSRdZuQSbiD4THqbOb19/EJ6DI5Cup6MDsdxbPyhIwywIzHw/ioZlPmdTYGKVK/5WIzLIcda
	yc6cDzhZefZ7ymbAy60kn8fW35H8unSNBZgarniuFkXgniKiKMI3FQHfg142YDP8zIMpjrXvoUUcD
	sCQ5N1U1kMM8xQixbjBxxw40hri0NM78O54imO2mJANL60RfMy5O7nnUB3TpE0sp3jOSIR4vIGPC0
	nLw16pjb1xapxSuhqy4V2bxTqYYwI0kpIwYedxbmUNuVccZgn+xNpDDgqKSxJv9vhnSVVTInpqk3c
	ey/GJkeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tYjcw-000000001m4-1nkW;
	Fri, 17 Jan 2025 10:30:58 +0000
Received: from wp530.webpack.hosteurope.de ([80.237.130.52])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tYjct-000000001lO-3WDt
	for linux-nvme@lists.infradead.org;
	Fri, 17 Jan 2025 10:30:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=y5cEtfBREYaGqWmqOHQr7JmJKxS9Ebst+7cMQ+meioQ=; t=1737109855;
	x=1737541855; b=R1giJEPc67c+YJ3DT7tjFWmVhIyib+Qtz7rio+bdJJfLdDWi9kcIaI2Xo12pa
	hJAmYJ7Sr+/3gSwtR9aZ2JVZ89ASPOAA2OjZkIJQgMrWOjS3LMWcZc/wSVCVJMN6JCY5NaaEGsof3
	KyRc0GQa/CLkZl5ykktm73L7MBwjygppdtOBx0j7iSgCW/6VCrhwM5gQjYQL7emvRYnvKVoZzEkBB
	Uapu4HT58XBlCnB5TEiZxMdZk2FmcqLmdcxd+JuPLVu7YcErlOK8jZ+xiEPZlbMBY+yOHAPyBmU85
	3vCScKBqKD7+lHXfFP2Ens/9uOLLS+9uPJvKxQRNZD0FOEA9vg==;
Received: from [2a02:8108:8980:2478:87e9:6c79:5f84:367d]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1tYjcm-00CaAU-2e;
	Fri, 17 Jan 2025 11:30:48 +0100
Message-ID: <266965cf-9cf9-4434-be42-458e92d7366d@leemhuis.info>
Date: Fri, 17 Jan 2025 11:30:47 +0100
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
 <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info>
 <20250117095522.GA2391@lst.de>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <20250117095522.GA2391@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1737109855;222a57ba;
X-HE-SMSGID: 1tYjcm-00CaAU-2e
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250117_023056_037890_0A40C13A 
X-CRM114-Status: GOOD (  13.34  )
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

On 17.01.25 10:55, Christoph Hellwig wrote:
> On Fri, Jan 17, 2025 at 10:51:09AM +0100, Thorsten Leemhuis wrote:
>> By booting with 'ignore_loglevel dyndbg="file drivers/pci/* +p"' I
>> suppose? No, that is not printed (but other debug lines from the pci
>> code are).
>>
>> Side note: that "PCI-DMA: Using software bounce buffering for IO
>>>> (SWIOTLB)" message does show up on two other AMD machines I own as
>> well. One also has a Ryzen 8000, the other one a much older one.
>>
>> And BTW a few bits of the latest development in the bugzilla ticket
>> (https://bugzilla.kernel.org/show_bug.cgi?id=219609 ):
>>
>> * iommu=pt and amd_iommu=off seems to work around the problem (in
>> addition to disabling the iommu in the BIOS setup).
> 
> That suggests the problem is related to the dma-iommu code, and
> my strong suspect is the swiotlb bounce buffering for untrusted
> device.  If you feel adventurous, can you try building a kernel
> where dev_use_swiotlb() in drivers/iommu/dma-iommu.c is hacked
> to always return false?

Tried that, did not help: I still get corrupted data.

Ciao, Thorsten

