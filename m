Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366DFECAAD2
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 00:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/3zSW4akroZH3AEa4Ob/zy2W13gQovdXsrNdOSGyuxY=; b=00kCJ4mt6wgquklGLqR7Zw9DAS
	RZcCOExwc7zO5ZfC6G49t1hCgPEl0WXiQ07zCxzehAHS5q+n5Pn/zi7fA1dhqcGpkviwHlv9nO1Qs
	naYsVjNpOTNO43ol9K9cCjHDVHBY7eoPG4tkbJPvWAsbx9cOHiyUV5wx3WT1i/BWN+o6qICZuf3lM
	iV3410nhBl6MLden9aUTZvPg1zmseGQ4fJht/Kwap4RkMT7YaVlt2gOIhczOJvZ0fbV237jr6R5B1
	0VDWgx3SiWbOVVmqIKQ8/IAEGgIuIosml14jBpdoI7lRRXEq69hg0djKxk6RKm998EKihVWo7hlgz
	i3+yGa0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTuOB-00G6pp-AU; Fri, 02 Sep 2022 00:18:27 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTuO8-00G6oA-EN
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 00:18:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662077903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/3zSW4akroZH3AEa4Ob/zy2W13gQovdXsrNdOSGyuxY=;
	b=IT5ypTpDjatWfCCtAsZeoWDfj37WyH4b5U9iSD5bvBQ2/l8j6t4AH7Sfoz655aYk7OCfbM
	3WzqaRGDCNUngNQYcUI72CO3buHMqKMoUY1IadFeocWN4LdVhQY0ncbyM5YKpg1BLCBBfn
	7Nlxo29gY6BlI/brggVf6/CFvjDeBWM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-445-7QEBgjBZNL6JUekD-937rA-1; Thu, 01 Sep 2022 20:18:22 -0400
X-MC-Unique: 7QEBgjBZNL6JUekD-937rA-1
Received: by mail-qk1-f198.google.com with SMTP id h20-20020a05620a245400b006bb0c6074baso690487qkn.6
        for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 17:18:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=/3zSW4akroZH3AEa4Ob/zy2W13gQovdXsrNdOSGyuxY=;
        b=C4N4rB7eHVfdFGJ5y7e5NcvL5RD9H3BeDR59WF9FGxMd0yQY0DBXqOCfrtp0Oxfwy9
         hiF4UTPxyzwM09i0QXAG4xJVEAOFGQrF+a2mCnkzYAT/C2pnejbGsHiXY0zcTSx9hP09
         19/bbQeDMemorL19FE6Uz0XHlBVXcyaQ5MWQAVZ8eptJhRfLpsjML/fRKXUuDvBPjNLT
         ZboEadxFeDdI/wQBSGcVDqjU2NGqLXIbrlpVpOwXiEdv7pqjy3rTbaGKPZTxIrP2SQv2
         6Qwz8QLFqczz4bERpZWWeCwWp+JzNNKhZYITHgUn9wavvs0B8US5MbWOKr3a6ocPmU45
         U3BQ==
X-Gm-Message-State: ACgBeo0FrJckf4ftWceqIN4q4OQTLkrXqV7gyx/AWkZlqxQlvnhHydil
	VGgJeIXvs4btnJfViYzku8vm6kwZvJrFa6siMULmmwQc0Q4Hvc5xho2n8S98/pL+xah+Sx/k2+K
	ucjQEZoFlexoe4PZFOvk10SXmHA==
X-Received: by 2002:ac8:58c6:0:b0:343:6ea4:c5d with SMTP id u6-20020ac858c6000000b003436ea40c5dmr25886991qta.371.1662077902201;
        Thu, 01 Sep 2022 17:18:22 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6oRhhYYJ6PrG/1HFlpvhf8UmICNazDZnq0j+/fuj1YsRN/1lRkHtGn1KfEAsjk0buEiHYDsQ==
X-Received: by 2002:ac8:58c6:0:b0:343:6ea4:c5d with SMTP id u6-20020ac858c6000000b003436ea40c5dmr25886979qta.371.1662077902000;
        Thu, 01 Sep 2022 17:18:22 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id bn5-20020a05620a2ac500b006bb41ac3b6bsm267782qkb.113.2022.09.01.17.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:18:21 -0700 (PDT)
Date: Thu, 1 Sep 2022 20:18:20 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
	damien.lemoal@opensource.wdc.com, hch@lst.de, bvanassche@acm.org,
	pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	gost.dev@samsung.com, jaegeuk@kernel.org, matias.bjorling@wdc.com
Subject: Re: [PATCH v12 11/13] dm: call dm_zone_endio after the target endio
 callback for zoned devices
Message-ID: <YxFLzHoYF7damFip@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121913eucas1p11c222f4c57a0132117bb9712e6018668@eucas1p1.samsung.com>
 <20220823121859.163903-12-p.raghav@samsung.com>
MIME-Version: 1.0
In-Reply-To: <20220823121859.163903-12-p.raghav@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_171824_609520_48EEDF92 
X-CRM114-Status: GOOD (  16.85  )
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

> dm_zone_endio() updates the bi_sector of orig bio for zoned devices that
> uses either native append or append emulation, and it is called before the
> endio of the target. But target endio can still update the clone bio
> after dm_zone_endio is called, thereby, the orig bio does not contain
> the updated information anymore.
> 
> Currently, this is not a problem as the targets that support zoned devices
> such as dm-zoned, dm-linear, and dm-crypt do not have an endio function,
> and even if they do (such as dm-flakey), they don't modify the
> bio->bi_iter.bi_sector of the cloned bio that is used to update the
> orig_bio's bi_sector in dm_zone_endio function.
> 
> This is a prep patch for the new dm-po2zone target as it modifies
> bi_sector in the endio callback.
> 
> Call dm_zone_endio for zoned devices after calling the target's endio
> function.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>

Great patch header, explains the situation nicely.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>


