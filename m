Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11E3C6FA82
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 20:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=e/i1xNela7arfufOlEWSIrFxi0oQo+ouwTHhQRBJeIY=; b=Xokg7xVTwPonO4EwONOI66Ocq8
	xbHF6/3u6g5g06SVpmaf3lZIY7+lMfAkCDIalT3QouiIRE0xwEfvAbR0Q+JwZlWNyFLmkeLye+CBM
	JMfs4fHXGhj9+hlx6h+ngDrehFzzn7cItVXKWobX6stHFiHI9epLEM4zBdh3vN/iZ4OWDWDTD5p4K
	GdDlT1Y8s6VOajzZjht/1SweOtb52/pYUrmXusIOPKTzxInDu44yE4JuzMwHGO3KlvnQhQnIuzPIS
	wPi7aSgvGNoQrL+qv1s0PARFuxhBm6vtJsE18IEJY9jsKlSYpsCjRUCE3idN2/5Dy8h2MALQZDrpY
	n6rciTQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUDhK-00AtdN-2d; Fri, 02 Sep 2022 20:55:30 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oUDhG-00AtbF-UI
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 20:55:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662152122;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e/i1xNela7arfufOlEWSIrFxi0oQo+ouwTHhQRBJeIY=;
	b=QmNeXyOhkMEj57sXm1+1Xg6S/er5x7DfqkrGw96NAyF+R1dub3ZyQ3R7r0GEWgiBlYhTr0
	riJ+WpA+HUGbHlx4G00kOxZq91k2h155bFsMK+a3qmvlnLQt5CTODdhY1D39mUO+hgLR53
	Vwvx0nIfO+9kHSPxeT0rvJ7e9q1KjZo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-581-z1wF0pMHOSiRvxe4J2XFJA-1; Fri, 02 Sep 2022 16:55:21 -0400
X-MC-Unique: z1wF0pMHOSiRvxe4J2XFJA-1
Received: by mail-qk1-f197.google.com with SMTP id bp11-20020a05620a458b00b006bbeffab91dso2844746qkb.11
        for <linux-nvme@lists.infradead.org>; Fri, 02 Sep 2022 13:55:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=e/i1xNela7arfufOlEWSIrFxi0oQo+ouwTHhQRBJeIY=;
        b=P+OEGWX16xEcKaCzrfpjXQXMdmNyf5Lo6V+VTWsElUuuBCqEKOcpAb/MXfU32+Q3x/
         B3n/87tLMSpIL7qiQm9QCp8+HgGPimBxszPumd//UVh4NUOSVxD0AUxjd0lFzernckL8
         xKFMKuZ6haUknyM6UMXdnwM0NJX3T7igZT8I1oranj7JCBEoYrYRTLqtR//noCuDGEke
         KE+U/WX39EpLzAf/fJyct/kXJhuXF1JkKFCWtejXeYcToFHLK66zZXoB6iEZ1lkSGsgr
         cMTdZmqJAyuUIz5Law3O/gD/eUWDQR5LmWxxhJKMeeWAHAS7v4pMDwVRXgc7wcK5SOct
         ssvA==
X-Gm-Message-State: ACgBeo0F74xWoBQ9CIpsuM2jhLohCP1fp3SH6wBxQKbvnKvN3/NN5hcR
	YAASy9eMYBeauwCwyxDsFBgypjPF3nBkhVWBqZydJD/4HaxX19d5s9c8BPIw6750haHa4ErysP9
	Lk8QVxHRHvKhCHJA1GTQGEFg6pA==
X-Received: by 2002:ac8:574f:0:b0:344:5a94:28fc with SMTP id 15-20020ac8574f000000b003445a9428fcmr30044837qtx.670.1662152120816;
        Fri, 02 Sep 2022 13:55:20 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7htZ5gZN01TeQlX/VJoxT2IaqgKvr8JeqKIGVMnyaeNem7TxDPPSJJMlag+j644UTpDAvlmQ==
X-Received: by 2002:ac8:574f:0:b0:344:5a94:28fc with SMTP id 15-20020ac8574f000000b003445a9428fcmr30044821qtx.670.1662152120587;
        Fri, 02 Sep 2022 13:55:20 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id fw10-20020a05622a4a8a00b0034361fb2f75sm1584123qtb.22.2022.09.02.13.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 13:55:19 -0700 (PDT)
Date: Fri, 2 Sep 2022 16:55:18 -0400
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
Message-ID: <YxJttvB2Z5I58SQ5@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121915eucas1p10296d6a2ab00de5e73791a7d6b8e39de@eucas1p1.samsung.com>
 <20220823121859.163903-14-p.raghav@samsung.com>
MIME-Version: 1.0
In-Reply-To: <20220823121859.163903-14-p.raghav@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220902_135527_216034_B0974FF0 
X-CRM114-Status: GOOD (  25.59  )
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

On Tue, Aug 23 2022 at  8:18P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> Only zoned devices with power-of-2(po2) number of sectors per zone(zone
> size) were supported in linux but now non power-of-2(npo2) zone sizes
> support has been added to the block layer.
> 
> Filesystems such as F2FS and btrfs have support for zoned devices with
> po2 zone size assumption. Before adding native support for npo2 zone
> sizes, it was suggested to create a dm target for npo2 zone size device to
> appear as a po2 zone size target so that file systems can initially
> work without any explicit changes by using this target.
> 
> The design of this target is very simple: remap the device zone size to
> the zone capacity and change the zone size to be the nearest power of 2
> value.
> 
> For e.g., a device with a zone size/capacity of 3M will have an equivalent
> target layout as follows:
> 
> Device layout :-
> zone capacity = 3M
> zone size = 3M
> 
> |--------------|-------------|
> 0             3M            6M
> 
> Target layout :-
> zone capacity=3M
> zone size = 4M
> 
> |--------------|---|--------------|---|
> 0             3M  4M             7M  8M
> 
> The area between target's zone capacity and zone size will be emulated
> in the target.
> The read IOs that fall in the emulated gap area will return 0 filled
> bio and all the other IOs in that area will result in an error.
> If a read IO span across the emulated area boundary, then the IOs are
> split across them. All other IO operations that span across the emulated
> area boundary will result in an error.
> 
> The target can be easily created as follows:
> dmsetup create <label> --table '0 <size_sects> po2zone /dev/nvme<id>'
> 
> Note that the target does not support partial mapping of the underlying
> device.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
> Suggested-by: Hannes Reinecke <hare@suse.de>


This target needs more review from those who Suggested-by it.

And the header and docs needs to address:

1) why is a partial mapping of the underlying device disallowed?
2) why is it assumed all IO is read-only? (talk to me and others like
   we don't know the inherent limitations of this class of zoned hw)

On a code level:
1) are you certain you're properly failing all writes?
   - are writes allowed to the "zone capacity area" but _not_
     allowed to the "emulated zone area"? (if yes, _please document_). 
2) yes, you absolutely need to implement the .status target_type hook
   (for both STATUS and TABLE).
3) really not loving the nested return (of DM_MAPIO_SUBMITTED or
   DM_MAPIO_REMAPPED) from methods called from dm_po2z_map().  Would
   prefer to not have to do a depth-first search to see where and when
   dm_po2z_map() returns a DM_MAPIO_XXX unless there is a solid
   justification for it.  To me it just obfuscates the DM interface a
   bit too much. 

Otherwise, pretty clean code and nothing weird going on.

I look forward to seeing your next (final?) revision of this patchset.

Thanks,
Mike


