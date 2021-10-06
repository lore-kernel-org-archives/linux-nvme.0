Return-Path: <SRS0=nAjD=O2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A403C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 13:21:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FF5461130
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Oct 2021 13:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0FF5461130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=B5pl4sL6St0Umwod3410tyOrfhG6IxRmO09AcSzdAgQ=; b=UXnqAIe3fXUnY1
	gHI/BQB5LXroz8lcU6J8QqCWa1UHA98+KK7rsYVFD45m0JZk0RPYfZIN2Lm1FaUp5u6lAw3qGS+I+
	+82i5QRY2NqJ1BJV3ee76H0119PbAWiDpW/R4GuC8y9h/AH4o4KmpbcVCFVkgNM9CtEbarDd7PKKm
	Ezpkpax9MNBRBaIjFfxegrn+FDImCof876nUwPoDUCkmB/2XF4jxGmA94Zknp9WorNH9NWabBh+AY
	GzTio4+WFhM6nBe7CuUIFPJ4Brp34t3ulp0RBMInv/6moOvJi59hRIm7NmXKdc9wFTz0UR1BTV4dx
	5iNIIBYnUdZGWGatI8Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mY6qB-00EMdT-OY; Wed, 06 Oct 2021 13:20:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mY6q8-00EMcE-EP
 for linux-nvme@lists.infradead.org; Wed, 06 Oct 2021 13:20:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633526405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+zbCfVnHe3hEOXNTzkBOuBqFXs5HnnXgmi37Lbo5cf0=;
 b=dDOVndOxjbd1BpuIMMr0vRddUX1gKi90fG+5nEXoNii96xYuUVPhDgtQKHYeFYvlW575tr
 Fs+VB3m/R1KvsRPG9fBZIgGXzaf1Rz5tWf2kSbJ5qqoOXyaLcZFrotFjEZK03i5NVLOw0+
 TImEp244iU5B3JCC2al2BkVL4qQOFZ8=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-zsWxqq20M3-pw2_SdmsXzA-1; Wed, 06 Oct 2021 09:17:52 -0400
X-MC-Unique: zsWxqq20M3-pw2_SdmsXzA-1
Received: by mail-qv1-f72.google.com with SMTP id
 gi5-20020a056214248500b00382f7a7c7e6so2623295qvb.21
 for <linux-nvme@lists.infradead.org>; Wed, 06 Oct 2021 06:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=+zbCfVnHe3hEOXNTzkBOuBqFXs5HnnXgmi37Lbo5cf0=;
 b=BwRlUJRBcxw2PiHHv8F40VTmGTtxJLOY0zelaEdRjd/8rFjtu3AnRxOV1ORPh/gFaM
 g6+l6QKJ6tWbUGviTWzAOspCbwjuoPdHuhn1oN41hpc0iun16wD5u57QgVjULa6if520
 zE3RbuFWg54vB4EqfXUjGTVHTAB/jZ+oRmAjCNJlbnjTPrXfto8csKDo/6httyjx2Pls
 kprE9wit1/dpJ+giQRbWBI7uZd3Z26PK9C84O6RzGHdMgjD5SC4amu/gEz2ezZMc+rob
 iLFvxIkUILLCDjKR3Ytvgo+kraaWdF6is5pVwBovFdS4yJ9l9TvrWJyMdhcwSGmEovIs
 n1Cg==
X-Gm-Message-State: AOAM531c4CT1DOJWOzXfkwWXUYVOq3idi/tpc8tAH96j1TXKFLItBHu9
 9ns0ndNAP/499iSTwbPREM58QrIjvCwP3ifPEQziY0y1ur5++l5KNZDAqs6dzp5Sffk78VqIkzR
 LlfldnoR4JoHVl91miXjoahOnJw==
X-Received: by 2002:a05:622a:180f:: with SMTP id
 t15mr25944890qtc.314.1633526271468; 
 Wed, 06 Oct 2021 06:17:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJ/dfz8opFCb2v5qUfLE0aMcIttTRFyUR16Rj5nDfAcBalXCGeyEeOx/El3NjgM1QYp0hnaw==
X-Received: by 2002:a05:622a:180f:: with SMTP id
 t15mr25944862qtc.314.1633526271274; 
 Wed, 06 Oct 2021 06:17:51 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net.
 [68.160.176.52])
 by smtp.gmail.com with ESMTPSA id r17sm12574405qtx.17.2021.10.06.06.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Oct 2021 06:17:50 -0700 (PDT)
Date: Wed, 6 Oct 2021 09:17:50 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: axboe@kernel.dk, martin.petersen@oracle.com, jejb@linux.ibm.com,
 sagi@grimberg.me, adrian.hunter@intel.com, beanhuo@micron.com,
 ulf.hansson@linaro.org, avri.altman@wdc.com, swboyd@chromium.org,
 agk@redhat.com, josef@toxicpanda.com
Cc: hch@infradead.org, hare@suse.de, bvanassche@acm.org,
 ming.lei@redhat.com, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-mmc@vger.kernel.org,
 dm-devel@redhat.com, nbd@other.debian.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/6] dm: add add_disk() error handling
Message-ID: <YV2h/iA79JhMJt07@redhat.com>
References: <20210927215958.1062466-1-mcgrof@kernel.org>
 <20210927215958.1062466-5-mcgrof@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210927215958.1062466-5-mcgrof@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=snitzer@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211006_062008_604437_D724BD04 
X-CRM114-Status: GOOD (  12.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Sep 27 2021 at  5:59P -0400,
Luis Chamberlain <mcgrof@kernel.org> wrote:

> We never checked for errors on add_disk() as this function
> returned void. Now that this is fixed, use the shiny new
> error handling.
> 
> There are two calls to dm_setup_md_queue() which can fail then,
> one on dm_early_create() and we can easily see that the error path
> there calls dm_destroy in the error path. The other use case is on
> the ioctl table_load case. If that fails userspace needs to call
> the DM_DEV_REMOVE_CMD to cleanup the state - similar to any other
> failure.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Mike Snitzer <snitzer@redhat.com>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
