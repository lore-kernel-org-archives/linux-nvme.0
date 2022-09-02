Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C383ECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 21:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1twqOZV7+i5p56v6efC4Oh5HGPuhxWk74nNLDWtwDHQ=; b=HveZyZtvyejNVRoPy2K+mMGPUz
	5dnD5uETxSgT1FxM3eVw4cSv25LLokfToERpUtbrOHqf2cD87b/gOrjLFyYJpDOOu/4Ou2m4JQW+h
	EiiVYH2zK/MOYPdXS25zL1nmLbS3Ur040v8OPZfMug/ZiKbCJ74L8Zv/cybKWWJbusg4JOLcp9T1/
	PlBssNslA9BOw5cE24KrwCI/9c2cjwW1tNWimKXvDFSxihlB+xxT4IL6Leht7LWtU7s9XQotz4oRl
	T+51/BYZBlGjuDuqxN4ucmInDC9fvZnXVZv/gzbOtfJSjTZw9vklLMbBnD/q9MeM7zAhoN5kE5ukY
	KsVgYXnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUDsc-00B0PI-4Z; Fri, 02 Sep 2022 21:07:10 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUDsZ-00B0LY-UK
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 21:07:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662152826;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1twqOZV7+i5p56v6efC4Oh5HGPuhxWk74nNLDWtwDHQ=;
	b=EGiQXt/Sw77+G6NgKw8ZN/kJxMAfw4aTD8WuWyAAgMLCSHok5VlhImC5QuubMwSapkeQBB
	vlS3eGODRh696t+IkDoq++2tUJ3GKY1i4SalSPD9kKRgK6MMmtxEHhQZXNzevppkciuxeo
	SBr7WQe4QuPiej+WxSZCofVWJdPE+RE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-513-hxej9XIiNtylkwu_5rGvLQ-1; Fri, 02 Sep 2022 17:07:05 -0400
X-MC-Unique: hxej9XIiNtylkwu_5rGvLQ-1
Received: by mail-qt1-f200.google.com with SMTP id s2-20020ac85cc2000000b00342f8ad1f40so2425044qta.12
        for <linux-nvme@lists.infradead.org>; Fri, 02 Sep 2022 14:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1twqOZV7+i5p56v6efC4Oh5HGPuhxWk74nNLDWtwDHQ=;
        b=ILOHGRoVjp6Q1cpYfAhgs0KQ9WWYfj1s4s182rpaBdWHrE9+h6m9yDRp+3TEDtX8ab
         pffypLxAKKNf3/Soz9A8UESHF6UUz8JF7awcEQY3lwrl7RVb9Z8CPBZe+ao9U10tdaqx
         a9wgFMLZ2jy8lUOcfjE2NUNG11EKYqzZ1CP2d8qZw3HH3y0/rGEjWJcrypTJW340fA10
         fctVY25xfXb8mtbRiZ1rgwCrvqxhgSrqmDIvA1y8rIbFEZYh2O8fz4UrX3qQ7b0lR8lc
         m9KwEQ2z9eJNtx7VVasVRfqQrxDn/8oPqkLrtAPHnxEmMyQKJxKVuIBSYPjqHRFV92nL
         N1/w==
X-Gm-Message-State: ACgBeo0wqpbqIarsiSj/humi3rL9aW1Rk8quyiJ/2WxuY9VaMPnmo7pt
	T06AxuJZRpAwOoHzr703QY5xGdhL+1ERaONIwxdf0tWDFKuH3t9WRJcr2V0dKek9oPqICemTlJE
	38xQNyahj6UyesuUYgFDdIqvTJA==
X-Received: by 2002:a05:620a:d51:b0:6bc:c53:5789 with SMTP id o17-20020a05620a0d5100b006bc0c535789mr24465468qkl.47.1662152824824;
        Fri, 02 Sep 2022 14:07:04 -0700 (PDT)
X-Google-Smtp-Source: AA6agR43jROB3LezwXP2AO1Z1Rks2S9cODPmCHq7gntetrnSftSFIdvYUe2gMh7gmbyxRiTgUDi2IA==
X-Received: by 2002:a05:620a:d51:b0:6bc:c53:5789 with SMTP id o17-20020a05620a0d5100b006bc0c535789mr24465442qkl.47.1662152824589;
        Fri, 02 Sep 2022 14:07:04 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05620a178800b006b949afa980sm2029065qkb.56.2022.09.02.14.07.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:07:04 -0700 (PDT)
Date: Fri, 2 Sep 2022 17:07:03 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
	damien.lemoal@opensource.wdc.com, hch@lst.de,
	Damien Le Moal <damien.lemoal@wdc.com>, bvanassche@acm.org,
	pankydev8@gmail.com,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	gost.dev@samsung.com, jaegeuk@kernel.org, matias.bjorling@wdc.com
Subject: Re: [PATCH v12 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Message-ID: <YxJwd7xcZRdznsYz@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de@eucas1p1.samsung.com>
 <20220823121859.163903-14-p.raghav@samsung.com>
 <YxJttvB2Z5I58SQ5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <YxJttvB2Z5I58SQ5@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220902_140708_118557_4D1A7DD9 
X-CRM114-Status: GOOD (  35.44  )
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

On Fri, Sep 02 2022 at  4:55P -0400,
Mike Snitzer <snitzer@redhat.com> wrote:

> On Tue, Aug 23 2022 at  8:18P -0400,
> Pankaj Raghav <p.raghav@samsung.com> wrote:
> 
> > Only zoned devices with power-of-2(po2) number of sectors per zone(zone
> > size) were supported in linux but now non power-of-2(npo2) zone sizes
> > support has been added to the block layer.
> > 
> > Filesystems such as F2FS and btrfs have support for zoned devices with
> > po2 zone size assumption. Before adding native support for npo2 zone
> > sizes, it was suggested to create a dm target for npo2 zone size device to
> > appear as a po2 zone size target so that file systems can initially
> > work without any explicit changes by using this target.
> > 
> > The design of this target is very simple: remap the device zone size to
> > the zone capacity and change the zone size to be the nearest power of 2
> > value.
> > 
> > For e.g., a device with a zone size/capacity of 3M will have an equivalent
> > target layout as follows:
> > 
> > Device layout :-
> > zone capacity = 3M
> > zone size = 3M
> > 
> > |--------------|-------------|
> > 0             3M            6M
> > 
> > Target layout :-
> > zone capacity=3M
> > zone size = 4M
> > 
> > |--------------|---|--------------|---|
> > 0             3M  4M             7M  8M
> > 
> > The area between target's zone capacity and zone size will be emulated
> > in the target.
> > The read IOs that fall in the emulated gap area will return 0 filled
> > bio and all the other IOs in that area will result in an error.
> > If a read IO span across the emulated area boundary, then the IOs are
> > split across them. All other IO operations that span across the emulated
> > area boundary will result in an error.
> > 
> > The target can be easily created as follows:
> > dmsetup create <label> --table '0 <size_sects> po2zone /dev/nvme<id>'
> > 
> > Note that the target does not support partial mapping of the underlying
> > device.
> > 
> > Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> > Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
> > Suggested-by: Hannes Reinecke <hare@suse.de>
> 
> 
> This target needs more review from those who Suggested-by it.
> 
> And the header and docs needs to address:
> 
> 1) why is a partial mapping of the underlying device disallowed?
> 2) why is it assumed all IO is read-only? (talk to me and others like
>    we don't know the inherent limitations of this class of zoned hw)
> 
> On a code level:
> 1) are you certain you're properly failing all writes?
>    - are writes allowed to the "zone capacity area" but _not_
>      allowed to the "emulated zone area"? (if yes, _please document_). 
> 2) yes, you absolutely need to implement the .status target_type hook
>    (for both STATUS and TABLE).
> 3) really not loving the nested return (of DM_MAPIO_SUBMITTED or
>    DM_MAPIO_REMAPPED) from methods called from dm_po2z_map().  Would
>    prefer to not have to do a depth-first search to see where and when
>    dm_po2z_map() returns a DM_MAPIO_XXX unless there is a solid
>    justification for it.  To me it just obfuscates the DM interface a
>    bit too much. 
> 
> Otherwise, pretty clean code and nothing weird going on.
> 
> I look forward to seeing your next (final?) revision of this patchset.

Thinking further.. I'm left confused about just what the heck this
target is assuming.

E.g.: feels like its exposing a readonly end of the zone is very
bi-polar... yet no hint to upper layer it shouldn't write to that
read-only end (the "emulated zone").. but there has to be some zoned
magic assumed?  And I'm just naive?

Mike


