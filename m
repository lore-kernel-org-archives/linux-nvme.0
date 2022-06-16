Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80892C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Jun 2022 16:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bewGKNu60ce93OglEfrUE0YxII8yhxsWSngVzrxtmZs=; b=hDBqFLXo03Msh2HdBafiq7kTiR
	uhUlfmYCqfTCAHxcDA45SQk2GCdMXWB368mw3r5DfaDpGEAONIUvDXqVtDynD939VRL+g9UdaZJUe
	IHz+nKpZ8AGPwAK4j3HlR4pQKIAvWTCqpv2x4fu9Q/h2Svtmc5ua2luJngjgkyAsPUDsEz7O7CNca
	eC9YSC+02eEr56kkJl4nEpAbdLgVXaMWunV9rgcY08nbxsVPSBj7jMPlmZj772Ew5QE8sviqKvEsZ
	wgJwUWR/M9FFz/wvG2Xrvx7k7SaM6NdHHlKQq1rht9rB6XrKMg1S+YoGJNeXk7pxKuwkCCbqsYwss
	Vqfd3wag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1rzG-003Jh0-Tv; Thu, 16 Jun 2022 16:04:50 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o1rzE-003Jg0-9g; Thu, 16 Jun 2022 16:04:48 +0000
Date: Thu, 16 Jun 2022 09:04:48 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Bart Van Assche <bvanassche@acm.org>, hch@lst.de, snitzer@redhat.com,
	damien.lemoal@opensource.wdc.com, axboe@kernel.dk,
	pankydev8@gmail.com, gost.dev@samsung.com,
	jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	dm-devel@redhat.com, jonathan.derrick@linux.dev,
	Johannes.Thumshirn@wdc.com, dsterba@suse.com, jaegeuk@kernel.org
Subject: Re: [dm-devel] [PATCH v7 02/13] block: allow blk-zoned devices to
 have non-power-of-2 zone size
Message-ID: <YqtUoK4KzvG7NQS0@bombadil.infradead.org>
References: <20220615101920.329421-1-p.raghav@samsung.com>
 <CGME20220615101931eucas1p15ed09ae433a2c378b599e9086130d8eb@eucas1p1.samsung.com>
 <20220615101920.329421-3-p.raghav@samsung.com>
 <857c444a-02b9-9cef-0c5b-2ecdb2fd46f6@acm.org>
 <e04db101-5628-2a1d-6b5c-997090484d7d@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e04db101-5628-2a1d-6b5c-997090484d7d@samsung.com>
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

On Thu, Jun 16, 2022 at 12:09:35PM +0200, Pankaj Raghav wrote:
> On 2022-06-15 22:28, Bart Van Assche wrote:
> >> +        if (!is_power_of_2(zone->len) && zone->capacity < zone->len) {
> >> +            pr_warn("%s: Invalid zone capacity for non power of 2
> >> zone size",
> >> +                disk->disk_name);
> >>               return -ENODEV;
> >>           }
> > 
> > The above check seems wrong to me. I don't see why devices that report a
> > capacity that is less than the zone size should be rejected.
> > 
> This was brought up by Damien during previous reviews. The argument was
> that the reason to allow non power-of-2 zoned device is to remove the
> gaps between zone size and zone capacity. Allowing a npo2 zone size with
> a different capacity, even though it is technically possible, it does
> not make any practical sense. That is why this check was introduced.
> Does that answer your question?

Perhaps just add a comment because unless you are involved in the prior
reviews this might not be clear.

  Luis

