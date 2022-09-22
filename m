Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177A1ECAAD8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 19:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rERQeRLk6iWsos2UmkmvbVMjyj1EWySRrEtJrBO4h4Y=; b=QtjFfNxXd8j/C2q3YHkCqRwWcK
	DDo4s3zPRk6f1YRT/tMX/B2wWhRoW9Q/2C41kC8wbYwanU6FZNcb9GrLr1F6KUxdo/m1kBhUx0bnE
	qSOV89fnk43em5S6S20ofauI4AVrYGzEGMSZYlEE8hYY/UhJTYlVSDBG4aoTwAY4kMrWRVSUCujKW
	SPKiunldvwxsI9nbYKHLlXlg1hva2mciNmcAXuRVaZ475nQmSqMa7nPg6oPwNT+OcVd5IjUoFCJP8
	SC/A6EaNsjcBMRg2xL1xjgMtuTnWXhDah5B1mXtkepJVqCm99fvy9S9r8Zi0zUYCzfps4SnjQh2jX
	2qMjwY5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obS0X-00HZwZ-Ec; Thu, 22 Sep 2022 19:37:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obS0T-00HZvC-Nl
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 19:37:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1663875425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rERQeRLk6iWsos2UmkmvbVMjyj1EWySRrEtJrBO4h4Y=;
	b=W1dVw74iaSfLoYmdvnWZQPSr0hJ5HkIOHRrTdA6t1Es2VUa8xGw0PUSOEYzbG3cVtDUx/0
	cGoaJKoKsgesFyPx3CSNuPSdghF0JZsVp0KSqAs9gP2m+d5f6jJZqHNd/5p8dwRKBncU3x
	OQfPQvBdEiHXIfW9mHE1U4SWKX3BoB4=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-35-DtBuCMiFNRq4vfGA8vV1Zg-1; Thu, 22 Sep 2022 15:37:04 -0400
X-MC-Unique: DtBuCMiFNRq4vfGA8vV1Zg-1
Received: by mail-qv1-f72.google.com with SMTP id i10-20020ad45c6a000000b004a25d0fea96so7084594qvh.3
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 12:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rERQeRLk6iWsos2UmkmvbVMjyj1EWySRrEtJrBO4h4Y=;
        b=Xhe3trcloTZ7Sif6Cr64gXtzbmFSVCiBIOE5lv9EV1Puh2X87yv+nO78f3G1WaA9U6
         31Q662LyMnki5tqXswF0I0wfASY+CvejrqsZO4j+6mNhgxRv2/PjzZqpm5HTf/X8xTU3
         goc9SogxChwkPUYdTpJ9VT0Dp17R0GaLM2nOw6S6MuTDmNMS/7uzkiPCnXEm6N2/zkss
         h0XMmJOhlQPnmY2uO8WSitrKUKTrsFpbUL8ZPodB3v5gjcOzNyCCFEqy3E5409eIJGcN
         LYAVjknqYlty1+Tvs9R2nRNP+PE138YG159LG1g5sZngQtd6rWlronp8H4y7Xk/J3Jev
         kZxg==
X-Gm-Message-State: ACrzQf3h0HAG95Vv5KnGzU8yuZuN0MKOxUDtLxoIORbdNmsNyWmB1rOr
	COsMeR3Y2w5ptqxkwP2E9yKqh2y4ZgkWkpQ7gktGKvtoPsWKspfpkZkNrcEzjBQo8O8hkitQ1JZ
	giMR9B0GbyT3Whms577F+E8kRcg==
X-Received: by 2002:a05:620a:15f2:b0:6ce:dea8:1d6d with SMTP id p18-20020a05620a15f200b006cedea81d6dmr3356160qkm.324.1663875423427;
        Thu, 22 Sep 2022 12:37:03 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Gh6yqO6EUXrtfv7UsM7htLnKxemapjlfZVl58O6Xzz8jniK66rHh4oKk3Qsil7SKcL3dprA==
X-Received: by 2002:a05:620a:15f2:b0:6ce:dea8:1d6d with SMTP id p18-20020a05620a15f200b006cedea81d6dmr3356136qkm.324.1663875423127;
        Thu, 22 Sep 2022 12:37:03 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id k16-20020a05620a415000b006cbe3be300esm4768662qko.12.2022.09.22.12.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 12:37:02 -0700 (PDT)
Date: Thu, 22 Sep 2022 15:37:01 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>, agk@redhat.com,
	snitzer@kernel.org, axboe@kernel.dk, hch@lst.de, bvanassche@acm.org,
	pankydev8@gmail.com, gost.dev@samsung.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Johannes.Thumshirn@wdc.com, jaegeuk@kernel.org,
	matias.bjorling@wdc.com
Subject: Re: Please further explain Linux's "zoned storage" roadmap [was: Re:
 [PATCH v14 00/13] support zoned block devices with non-power-of-2 zone
 sizes]
Message-ID: <Yyy5XUUWGkU8B3IP@redhat.com>
References: <CGME20220920091120eucas1p2c82c18f552d6298d24547cba2f70b7fc@eucas1p2.samsung.com>
 <20220920091119.115879-1-p.raghav@samsung.com>
 <YytJhEywBhqcr7MX@redhat.com>
 <7dd9dbc0-b08b-fa47-5452-d448d86ca56b@opensource.wdc.com>
MIME-Version: 1.0
In-Reply-To: <7dd9dbc0-b08b-fa47-5452-d448d86ca56b@opensource.wdc.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_123709_903495_02B8E459 
X-CRM114-Status: GOOD (  48.56  )
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

On Wed, Sep 21 2022 at  7:55P -0400,
Damien Le Moal <damien.lemoal@opensource.wdc.com> wrote:

> On 9/22/22 02:27, Mike Snitzer wrote:
> > On Tue, Sep 20 2022 at  5:11P -0400,
> > Pankaj Raghav <p.raghav@samsung.com> wrote:
> > 
> >> - Background and Motivation:
> >>
> >> The zone storage implementation in Linux, introduced since v4.10, first
> >> targetted SMR drives which have a power of 2 (po2) zone size alignment
> >> requirement. The po2 zone size was further imposed implicitly by the
> >> block layer's blk_queue_chunk_sectors(), used to prevent IO merging
> >> across chunks beyond the specified size, since v3.16 through commit
> >> 762380ad9322 ("block: add notion of a chunk size for request merging").
> >> But this same general block layer po2 requirement for blk_queue_chunk_sectors()
> >> was removed on v5.10 through commit 07d098e6bbad ("block: allow 'chunk_sectors'
> >> to be non-power-of-2").
> >>
> >> NAND, which is the media used in newer zoned storage devices, does not
> >> naturally align to po2. In these devices, zone capacity(cap) is not the
> >> same as the po2 zone size. When the zone cap != zone size, then unmapped
> >> LBAs are introduced to cover the space between the zone cap and zone size.
> >> po2 requirement does not make sense for these type of zone storage devices.
> >> This patch series aims to remove these unmapped LBAs for zoned devices when
> >> zone cap is npo2. This is done by relaxing the po2 zone size constraint
> >> in the kernel and allowing zoned device with npo2 zone sizes if zone cap
> >> == zone size.
> >>
> >> Removing the po2 requirement from zone storage should be possible
> >> now provided that no userspace regression and no performance regressions are
> >> introduced. Stop-gap patches have been already merged into f2fs-tools to
> >> proactively not allow npo2 zone sizes until proper support is added [1].
> >>
> >> There were two efforts previously to add support to npo2 devices: 1) via
> >> device level emulation [2] but that was rejected with a final conclusion
> >> to add support for non po2 zoned device in the complete stack[3] 2)
> >> adding support to the complete stack by removing the constraint in the
> >> block layer and NVMe layer with support to btrfs, zonefs, etc which was
> >> rejected with a conclusion to add a dm target for FS support [0]
> >> to reduce the regression impact.
> >>
> >> This series adds support to npo2 zoned devices in the block and nvme
> >> layer and a new **dm target** is added: dm-po2zoned-target. This new
> >> target will be initially used for filesystems such as btrfs and
> >> f2fs until native npo2 zone support is added.
> > 
> > As this patchset nears the point of being "ready for merge" and DM's
> > "zoned" oriented targets are multiplying, I need to understand: where
> > are we collectively going?  How long are we expecting to support the
> > "stop-gap zoned storage" layers we've constructed?
> > 
> > I know https://zonedstorage.io/docs/introduction exists... but it
> > _seems_ stale given the emergence of ZNS and new permutations of zoned
> > hardware. Maybe that isn't quite fair (it does cover A LOT!) but I'm
> > still left wanting (e.g. "bring it all home for me!")...
> > 
> > Damien, as the most "zoned storage" oriented engineer I know, can you
> > please kick things off by shedding light on where Linux is now, and
> > where it's going, for "zoned storage"?
> 
> Let me first start with what we have seen so far with deployments in the
> field.

<snip>

Thanks for all your insights on zoned storage, very appreciated!

> > In addition, it was my understanding that WDC had yet another zoned DM
> > target called "dm-zap" that is for ZNS based devices... It's all a bit
> > messy in my head (that's on me for not keeping up, but I think we need
> > a recap!)
> 
> Since the ZNS specification does not define conventional zones, dm-zoned
> cannot be used as a standalone DM target (read: single block device) with
> NVMe zoned block devices. Furthermore, due to its block mapping scheme,
> dm-zoned does not support devices with zones that have a capacity lower
> than the zone size. So ZNS is really a big *no* for dm-zoned. dm-zap is a
> prototype and in a nutshell is the equivalent of dm-zoned for ZNS. dm-zap
> can deal with the smaller zone capacity and does not require conventional
> zones. We are not trying to push for dm-zap to be merged for now as we are
> still evaluating its potential use cases. We also have a different but
> functionally equivalent approach implemented as a block device driver that
> we are evaluating internally.
> 
> Given the above mentioned usage pattern we have seen so far for zoned
> storage, it is not yet clear if something like dm-zap for ZNS is needed
> beside some niche use cases.

OK, good to know.  I do think dm-zoned should be trained to _not_
allow use with ZNS NVMe devices (maybe that is in place and I just
missed it?).  Because there is some confusion with at least one
customer that is asserting dm-zoned is somehow enabling them to use
ZNS NVMe devices!

Maybe they somehow don't _need_ conventional zones (writes are handled
by some other layer? and dm-zoned access is confined to read only)!?
And might they also be using ZNS NVMe devices to do _not_ have a
zone capacity lower than the zone size?

Or maybe they are mistaken and we should ask more specific questions
of them?

> > So please help me, and others, become more informed as quickly as
> > possible! ;)
> 
> I hope the above helps. If you want me to develop further any of the
> points above, feel free to let me know.

You've been extremely helpful, thanks!


