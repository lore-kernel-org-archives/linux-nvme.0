Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B846AC32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 14:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8eB83t+uAXU0eeIFIBcJy7R/AwuzdJ0SXvnM1E+9aQE=; b=TUAabQUMyhokl4r8LE9i6waXiv
	9NGZQmFA8XLtiV63RY78A9sfHcw39cLnZ/st/qJZULEdGufp4fO+Xi5HS0sB4jhkoxAVo57A/XoWD
	mYp9hURgXGiWrrQ05L56LK5n8l6aWsb1jv4pmTp/jZFJ4dwUae/1oxEw2DL9sjVmzkra2esgOgnFa
	w5opwEpVlGusfSxXEuN00kH8euf3j3ulP2BpQGuGbL6+CCIlAb55cP8NF0DNxH3uqQcSUzCWZspQK
	W51dEQ30hptnW5p4yqi9TW2FirmZ59M1LsFGOHMBfVQOX9mHTO/aKBGGHKbxiJLe0S/dBLo9Okxfc
	/g18uu/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXxX-00GezZ-B6; Wed, 28 Sep 2022 14:22:47 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odXxU-00Gey0-9w
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 14:22:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1664374961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8eB83t+uAXU0eeIFIBcJy7R/AwuzdJ0SXvnM1E+9aQE=;
	b=Om7vj+Ch44bylmAq2U/ayTODRpgTAcVgelr3IzpOot+mg5yDeQv0CXIqk75zJyxzDXlR8h
	1pK7/PeTx61YYD2fxPJfuFzPjrE1KRwBOdl+EBk7PqRXulv3tuNRZLpt6SpyiWdrXgKail
	nU4nf7CRlC5s/VsyJZNoDLSzNiTPFlc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-398--bvofIqtMX-CeHghzAQsVw-1; Wed, 28 Sep 2022 10:22:39 -0400
X-MC-Unique: -bvofIqtMX-CeHghzAQsVw-1
Received: by mail-qv1-f71.google.com with SMTP id jo23-20020a056214501700b004af8b197efaso3313183qvb.1
        for <linux-nvme@lists.infradead.org>; Wed, 28 Sep 2022 07:22:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8eB83t+uAXU0eeIFIBcJy7R/AwuzdJ0SXvnM1E+9aQE=;
        b=RqVbHyY0PnBE5xhH1s84hvHGi4Jvf+L3QDHAzTubS3PAvooZPav/doQLvOSrG8maqc
         UHibbtdCSpjwpKMU4ZWNsa52T1z/KnEX1XR/89459Funkkkrcf4kr3/L0d6kuyoj1Nt5
         jH2lhlEm4hPqXMpCUvVPLQWV9uAZb6U/dPPvXfjqyYoBrMnmQZUwF0FXqNKvw8j7fVpk
         Yo5xqgIqrm3Z6+Wn4CrTvh6DYNcr0nZk0AbosWajDrP5TkOCBo+c7nqEDZScejWvxsBf
         hZm/d1ULhmi21OQRjcbW11WMrlKGLFcWaNVrbzOZesQcQcTyuwCcYYgyhjbjYc6eN61c
         jwxA==
X-Gm-Message-State: ACrzQf098p95VwQknTGatWHdIeCVp0bFVZzoE0QUOfPs8K2OGajFRH2V
	gkX1sp3cm8S7dMidhyhOV0qmiq4e2dOrWkXsoxiXYJ3fHyyBG9RHaLbsepW+wxu3LD40WnzZTNU
	NRix6htkFximAwj0BgfukFFINXg==
X-Received: by 2002:a05:620a:12b5:b0:6cd:f08a:5d4f with SMTP id x21-20020a05620a12b500b006cdf08a5d4fmr21775555qki.8.1664374959195;
        Wed, 28 Sep 2022 07:22:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6fmKzRNXSuxW01rhdqH0LlsG4b/0woL5Epyq9ljOUekYyldjofq1FKZh/mDRdfgWqVKl7cTA==
X-Received: by 2002:a05:620a:12b5:b0:6cd:f08a:5d4f with SMTP id x21-20020a05620a12b500b006cdf08a5d4fmr21775532qki.8.1664374958971;
        Wed, 28 Sep 2022 07:22:38 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id cp4-20020a05622a420400b00359961365f1sm2859790qtb.68.2022.09.28.07.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:22:38 -0700 (PDT)
Date: Wed, 28 Sep 2022 10:22:36 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de,
	damien.lemoal@opensource.wdc.com,
	Damien Le Moal <damien.lemoal@wdc.com>, bvanassche@acm.org,
	pankydev8@gmail.com, gost.dev@samsung.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>, jaegeuk@kernel.org,
	matias.bjorling@wdc.com
Subject: Re: [PATCH v15 13/13] dm: add power-of-2 target for zoned devices
 with non power-of-2 zone sizes
Message-ID: <YzRYrNBB35fLjAO4@redhat.com>
References: <20220923173618.6899-1-p.raghav@samsung.com>
 <CGME20220923173634eucas1p18fccee11155c670354da389b4d2f4c60@eucas1p1.samsung.com>
 <20220923173618.6899-14-p.raghav@samsung.com>
MIME-Version: 1.0
In-Reply-To: <20220923173618.6899-14-p.raghav@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_072244_462582_13AF52D3 
X-CRM114-Status: GOOD (  22.92  )
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

On Fri, Sep 23 2022 at  1:36P -0400,
Pankaj Raghav <p.raghav@samsung.com> wrote:

> Only zoned devices with power-of-2(po2) number of sectors per zone(zone
> size) were supported in linux but now non power-of-2(npo2) zone sizes
> support has been added to the block layer.
> 
> Filesystems such as F2FS and btrfs have support for zoned devices with
> po2 zone size assumption. Before adding native support for npo2 zone
> sizes, it was suggested to create a dm target for npo2 zone size device to
> appear as a po2 zone size target so that file systems can initially
> work without any explicit changes.
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
> dmsetup create <label> --table '0 <size_sects> po2zoned /dev/nvme<id>'
> 
> The target does not support partial mapping of the underlying
> device as there is no use-case for it.
> 
> Note:
> This target is not related to dm-zoned target, which exposes a zoned block
> device as a regular block device without any write constraint.
> 
> This target only exposes a different zone size than the underlying device.
> The underlying device's other constraints will be directly exposed to the
> target.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Suggested-by: Damien Le Moal <damien.lemoal@wdc.com>
> Suggested-by: Hannes Reinecke <hare@suse.de>

If/when this series is accepted by Jens and others the DM changes can
just be included along with the rest of the series.

Reviewed-by: Mike Snitzer <snitzer@kernel.org>


