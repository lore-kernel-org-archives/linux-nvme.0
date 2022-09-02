Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3FDECAAD2
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 00:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JoL26AsmguCoQC8iT7uL94/0V02t17IP8zjffwCfRFk=; b=Y2miK4P0EDWI9HNUVEPl5PwzOZ
	cLGiX1aZeqp2RlMwvGc/3ZtdaPqHW7zE6pbeWa9IwF87avNb3mVaFcCxiefNe2JQ4xzOuje7wyKgH
	jtoRc8DVrlo6Ya92AIzwnSpc/dl0I5tCLExVfRbTg4BM+bs+9jDTk8lg8rEUTjC1QJqutN06+wrjc
	w3XMJRafygKuj+/B6k9yPaZGzWEUkxhjd8wlBoW5R47Jz8vejrEhYP/D+xS7ieZ703UQ10vRTGQTD
	1K6S869Kh4Ho9h/ribSy/9PVdw8Bgmp0RCSDVXWCx49wQmNieHgFpRvif/vY6ge5+HoNJMGpLie0Y
	PQ2TR6CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTuYb-00GBo9-9Y; Fri, 02 Sep 2022 00:29:13 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTuYS-00GBhr-0w
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 00:29:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662078542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JoL26AsmguCoQC8iT7uL94/0V02t17IP8zjffwCfRFk=;
	b=FWTONVXgdrjiSf6GSUsFwQ4pKZpFXYRUzAiFAi8rTa7kGtlfF3LSj2YeryzSwsEJgXyqwf
	swd4WsmnXxemCmI30alXn9SAPd4vq8RV6OB3dMsCyK2TslBhyk/aa0m3lo6eU4yBFIKUv4
	o7OEi4bDxybZYp7zUDLfDIdzAWPsmFU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-609--uaSwAK6PB6RVSvDR1ZMQw-1; Thu, 01 Sep 2022 20:29:01 -0400
X-MC-Unique: -uaSwAK6PB6RVSvDR1ZMQw-1
Received: by mail-qk1-f199.google.com with SMTP id w22-20020a05620a445600b006bb7f43d1cfso679568qkp.16
        for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 17:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JoL26AsmguCoQC8iT7uL94/0V02t17IP8zjffwCfRFk=;
        b=DDNzSpv4fYLh6ehhiFtgMQaAmrNVoNnW7xCafPpcRZXXi+TK0/RJHtq19nc1jOKnri
         27VWwMKq04LmvChTno+nKyTAGxplX6UEcF1SelT1MzAQHGz5ThpRr3BYtrCXuDlF1EOu
         nw0KbnQAJ5QNMUS0C/kUAlfIhRNoP/lsm4Uf0YvrYA4nws20//r2dy5dek9xC1IsNPh+
         XOWpfM0ee0fEkn49NnPBKn7eA+Lidye7xBjU2/ithyGldHZ3SVzOhEUe/N0bUW0kU8kT
         p++VErf+AHFbfoIjjLjN8N0kliGxujPJP3kM8Kx1lMoG2+c1Ow6uLIvU0IFpCcmu2oI4
         eb3Q==
X-Gm-Message-State: ACgBeo0WIzpiKOQwYHDvOgZdTqiT3f4lhrnTg7QmjeyqHuV/DkVKpJUC
	7FclOqszqATvMdNWkeR9UnR2tUqn8AE71xAKHGd0m7VdWxH8Xa4XdE5agmY2ABYbWcEZHbDicAV
	wJiQB5GdPiedI9L2G/pRTwNwmIw==
X-Received: by 2002:a05:622a:56:b0:344:50e3:3363 with SMTP id y22-20020a05622a005600b0034450e33363mr26078601qtw.217.1662078541493;
        Thu, 01 Sep 2022 17:29:01 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4ummQqIzdjpLP2wlMT3mmzaahpZ4roXiEIZrDjJAlvbH341hXfcfEvnw7FaTjjSfTvav+c8Q==
X-Received: by 2002:a05:622a:56:b0:344:50e3:3363 with SMTP id y22-20020a05622a005600b0034450e33363mr26078588qtw.217.1662078541288;
        Thu, 01 Sep 2022 17:29:01 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id 15-20020ac84e8f000000b0031f0b43629dsm180519qtp.23.2022.09.01.17.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:29:00 -0700 (PDT)
Date: Thu, 1 Sep 2022 20:28:59 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
	damien.lemoal@opensource.wdc.com, hch@lst.de, pankydev8@gmail.com,
	Johannes.Thumshirn@wdc.com, linux-block@vger.kernel.org,
	dm-devel@redhat.com, hare@suse.de, jaegeuk@kernel.org,
	linux-kernel@vger.kernel.org, matias.bjorling@wdc.com,
	gost.dev@samsung.com, bvanassche@acm.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v12 12/13] dm: introduce DM_EMULATED_ZONES target type
Message-ID: <YxFOS8fq8AeE5mkf@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121914eucas1p2f4445066c23cdae4fca80f7b0268815b@eucas1p2.samsung.com>
 <20220823121859.163903-13-p.raghav@samsung.com>
MIME-Version: 1.0
In-Reply-To: <20220823121859.163903-13-p.raghav@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_172904_168585_5CAC30A9 
X-CRM114-Status: GOOD (  11.94  )
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

> Introduce a new target type DM_EMULATED_ZONES for targets with
> a different number of sectors per zone (aka zone size) than the underlying
> device zone size.
> 
> This target type is introduced as the existing zoned targets assume
> that the target and the underlying device have the same zone size.
> The new target: dm-po2zone will use this new target
> type as it emulates the zone boundary that is different from the
> underlying zoned device.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

This patch's use of "target type" jargon isn't valid. 

Please say "target feature flag" and rename DM_EMULATED_ZONES to
DM_TARGET_EMULATED_ZONES in the subject and header.

But, with those fixed:

Signed-off-by: Mike Snitzer <snitzer@kernel.org>

(fyi, I'll review patch 13, the dm-po2zone target, tomorrow)


