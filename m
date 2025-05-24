Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10CF6C54FC6
	for <linux-nvme@archiver.kernel.org>; Sat, 24 May 2025 14:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OGidEMc7TlFrOGebchzEkqtXpthREkRZyyBeI2wWYsc=; b=pIsW6HtWkLLpbkN9VRTHwQzHlr
	guAYvoYPfUj+N+n3RU7rFk/MNaD3fIP4vrtuI83tM902r1LXs3SIHddsshcAtY1byRIjo7mDudZLq
	mbInHU4v33VCRELNdU5kJFKIwqiMei/31nZiXECqD4IkXqOw3XpFr7VTO8TSIsflllWO5o9tsLGF7
	rDg33y462HIodqCmIcgFuuMXOIa87Z6n70lcWwtocAgzCXq3XhHhTlsKCCpRtTVv3JQyfHZFc+3XZ
	bW/mntBuqoMJoNeCpuLL/LjHCaKwow0+LxQqWcG2rrx46+8pLn+t+F97GjbcKRRyttcCwXay7EG1L
	y/SfeXow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIppS-00000005v6F-3Sf4;
	Sat, 24 May 2025 14:26:26 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uIppN-00000005v68-33SM
	for linux-nvme@lists.infradead.org;
	Sat, 24 May 2025 14:26:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8D63261136;
	Sat, 24 May 2025 14:26:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA578C4CEE4;
	Sat, 24 May 2025 14:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748096779;
	bh=WTvVBenFlDezx/zliaOwezIGhC51mUwlQ0TTQ5aS7TQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lEgNGXA/Ongs4rSPWDGfEcwbGOKV6D1fl26bumAzR9dJj+8LeTSII0iKhJmiH52hn
	 d+GqndL4HknkE4rvsUyPcez9NhXm7/kR9c2f3xS6T0QPNzsTdCG8+zb9efkcnxyopW
	 TzL2Mv4RvhUtuc4Bbdk3YCYeppjWIuaqNy06A92H4KegMaR3+p0kaAXGMcRBPsbnb+
	 w7cAB6NmYaJ/Tl3I2Dt94pdo+oeMIUcmbblYn+NYGOIWR6MusfGcF00/RBjQKxS9vE
	 Z1aH4MNzvVr/IQAtaQuSXTC9+A1znCtQSuNxsxJYYAjYjNGSWYRCBEACXjNpP/1kBn
	 2XBLMCqXRFDfQ==
Date: Sat, 24 May 2025 08:26:17 -0600
From: Keith Busch <kbusch@kernel.org>
To: Avinash M N <Avinash.M.N@sandisk.com>
Cc: Jeffrey Lien <Jeff.Lien@sandisk.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Rahul Jain <Rahul.Jain@sandisk.com>
Subject: Re: NVMe CLI Invalid PRP Entry Status Failures
Message-ID: <aDHXCFeQSlQjjnmU@kbusch-mbp>
References: <MW3PR16MB3897F0E659B34877C4D5197CF391A@MW3PR16MB3897.namprd16.prod.outlook.com>
 <MW3PR16MB38975C2057D1EF440FBD60B0F390A@MW3PR16MB3897.namprd16.prod.outlook.com>
 <aCX3offAfe1k0_KE@kbusch-mbp>
 <LV3PR16MB606775F391112B2DADF64463B590A@LV3PR16MB6067.namprd16.prod.outlook.com>
 <aCcwqhakl4JhrI2o@kbusch-mbp>
 <LV3PR16MB6067E928D739DCB65F31FE46B593A@LV3PR16MB6067.namprd16.prod.outlook.com>
 <aCdOtYYT8f3lL8zJ@kbusch-mbp>
 <F3C3A106-E0AF-4598-9E80-6F10A457F202@sandisk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F3C3A106-E0AF-4598-9E80-6F10A457F202@sandisk.com>
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

On Sat, May 24, 2025 at 04:22:11AM +0000, Avinash M N wrote:
> The below function is causing the EINVAL to be returned to the userspace.
> 
> int blk_rq_append_bio(struct request *rq, struct bio *bio)
> {
>         const struct queue_limits *lim = &rq->q->limits;
>         unsigned int max_bytes = lim->max_hw_sectors << SECTOR_SHIFT;
>         unsigned int nr_segs = 0;
>         int ret;
> 
>         /* check that the data layout matches the hardware restrictions */
>         ret = bio_split_rw_at(bio, lim, &nr_segs, max_bytes);
>         if (ret) {
>                 /* if we would have to split the bio, copy instead */
>                 if (ret > 0) {
>                         ret = -EREMOTEIO;
>                 }
>                 return ret;
>         }
> 
> There is no issue if nvme-cli sends a transfer length of up to 128K.
> Anything more than 128K is failed as ENINVAL. I guess this is coming
> from the limitation of BIO_MAX_VECS as 256. Since this was working on
> older kernels, did anything change in this regard?

Well, it's passing a virtually contiguous address, so if we assume your
page size is 4k, 256 vectors would allow up to 1MB without a problem.

But the NVMe pci driver has its own limit of 128 vectors, so 512k is the
largest you can safely go before you need to increase the size of pages
via hugetlbfs.

But you say you're doing something smaller than 512k, and your device's
MDTS is bigger than that, so what else is limiting here your transfer
size here? Do you have some udev rule that is reducing the size of your
max sectors value?

Check the value of /sys/block/nvmeXnY/queue/max_sectors_kb

See if it matches /sys/block/nvmeXnY/queue/max_hw_sectors_kb

If not, echo the higher value into the "max_sectors_kb" attribute and
see if that fixes your problem.
 
> The failing command was attempting to transfer a length of ~320K. It
> seems that nvme-cli does not split the transfers and sends the full
> transfer length to the kernel.

Your command is vendor specific; nvme-cli has no idea what your command
does so it can't possibly know how to properly split it up. Try
something nvme-cli knows about, like a telemetry-log, and nvme-cli will
split it up for you.

