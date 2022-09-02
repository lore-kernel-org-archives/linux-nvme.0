Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68C1ECAAD3
	for <linux-nvme@archiver.kernel.org>; Fri,  2 Sep 2022 00:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1VQaTuOirjpYt85+XINqeDWNmKGLZ6/kyCDRTLfcVcM=; b=EshXHJkC+zgeC2HtR9BgKSUiwU
	GRgBGOEGXsvI/yxI9YpIGYHUQYqduFCm3g97J9SdfaKCQZK1HXrwHDeqhwkBc4i+n7jhEy2N4I94j
	uqUB3eBdjBLnaPKG0pe4lPUDrD4F1TBVUE2N96V/A05Gq3ZfGAemLrb3BGV/OL74ScwcaXu9MO8GA
	KL+nGNIUhNodpsEm0vbt2mVpjouRuAqa+BJNUycm0/Y6PKwSLW5TK1+zxRce4gJA/I7Kdxz5abwPA
	+qyfr0hUkTZm6vkLuAlb91s7nP3cVtc/hUFE7ogNHiUZhawJoLuXbQ/BeguNxxlNmsgvRGgUIfmU3
	RuRF1iKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTuNN-00G64G-1U; Fri, 02 Sep 2022 00:17:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTuNK-00G5wf-Cg
	for linux-nvme@lists.infradead.org; Fri, 02 Sep 2022 00:17:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1662077852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1VQaTuOirjpYt85+XINqeDWNmKGLZ6/kyCDRTLfcVcM=;
	b=d+JfhFC+L4OOkN5yOGaHQGmF+sruV0cOneiuAoz5z+3m8v4EOjlD2K37IGLxgKU+iIeI1J
	zdaT1c7l2CtXCX+gLv2Fq73DVM9Jy3Z8GqQvKAMtZgPk765TV/4YatByHhW5yrR1ox/zVI
	RVMHAaB1gBV1N8dhdSVcsJZwnEdh7E8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-661-QHwRTz72NeechyiUhPaqrw-1; Thu, 01 Sep 2022 20:17:31 -0400
X-MC-Unique: QHwRTz72NeechyiUhPaqrw-1
Received: by mail-qt1-f197.google.com with SMTP id o21-20020ac87c55000000b00344646ea2ccso403360qtv.11
        for <linux-nvme@lists.infradead.org>; Thu, 01 Sep 2022 17:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1VQaTuOirjpYt85+XINqeDWNmKGLZ6/kyCDRTLfcVcM=;
        b=VRqACKMYyYHAIJWSBXo2GbwGAV4mYemYwnqRF7SLFEWwk9/scBPsrWBNvsSNukwKJc
         om1BLrCyKjawSXyoIVl9y3ETaiXpbZC/vPL+yj2LDfq0mtPiZT/xeo3Cd5ymVdGL9bgG
         UJlhzy/ScUCozb3z8r+lBrWCXZPArElgPB+sLQ8sfqlPklGaT3THn8XZ6lERD+n2vjc5
         erFdP5UlIW6T9sQ2YSPRVSKER0JrFavQk8z1OxMy043i92xkkK3dQv/0YjY6fcGrwPNI
         vrynyinEYTGJ25Mgxn6ZzQVZvLjj8S7mIPl0k5RWsHmufEBgS02k2tFBbfrENxlHQwoT
         WR1g==
X-Gm-Message-State: ACgBeo1JIAV+8xJQJllfqIVkD4QzTknDYXAMPPeTzwUZYCKGU0n00GvH
	WPS0ZRg6psnptaVGnmC0eYfTtlt3njPDhkU5gNloEeRf0tsEZRtq6ei1yZy6ZMpe8ICpWJdoc0e
	NTqENKsgB26XliqBQrJQiMxhSmg==
X-Received: by 2002:a05:620a:170c:b0:6bb:208c:d276 with SMTP id az12-20020a05620a170c00b006bb208cd276mr21623965qkb.539.1662077850967;
        Thu, 01 Sep 2022 17:17:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5l1Y1wPC9cb0WfGk58FA5BvETyt3RQ0Hl5DfpLwLcYUCBnnMhNzZcJHR6wWE4FxqLZfiIC3A==
X-Received: by 2002:a05:620a:170c:b0:6bb:208c:d276 with SMTP id az12-20020a05620a170c00b006bb208cd276mr21623953qkb.539.1662077850790;
        Thu, 01 Sep 2022 17:17:30 -0700 (PDT)
Received: from localhost (pool-68-160-173-162.bstnma.fios.verizon.net. [68.160.173.162])
        by smtp.gmail.com with ESMTPSA id m7-20020a05620a290700b006b9593e2f68sm345562qkp.4.2022.09.01.17.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 17:17:30 -0700 (PDT)
Date: Thu, 1 Sep 2022 20:17:29 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk,
	damien.lemoal@opensource.wdc.com, hch@lst.de, bvanassche@acm.org,
	pankydev8@gmail.com, Johannes.Thumshirn@wdc.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	gost.dev@samsung.com, jaegeuk@kernel.org, matias.bjorling@wdc.com
Subject: Re: [PATCH v12 10/13] dm-table: allow zoned devices with non
 power-of-2 zone sizes
Message-ID: <YxFLmZ1KUwQ9LLDK@redhat.com>
References: <20220823121859.163903-1-p.raghav@samsung.com>
 <CGME20220823121912eucas1p18223e1b04b65a8a10f6c50187e7474ea@eucas1p1.samsung.com>
 <20220823121859.163903-11-p.raghav@samsung.com>
MIME-Version: 1.0
In-Reply-To: <20220823121859.163903-11-p.raghav@samsung.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_171734_548921_2FEB62A3 
X-CRM114-Status: UNSURE (   9.00  )
X-CRM114-Notice: Please train this message.
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

> Allow dm to support zoned devices with non power-of-2(po2) zone sizes as
> the block layer now supports it.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Reviewed-by: Mike Snitzer <snitzer@kernel.org>


