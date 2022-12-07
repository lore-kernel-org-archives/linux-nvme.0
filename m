Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2313C4708D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 20:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ERzjyp7zk5Z5+YVLaxlhiooylxoMa/YnIAQSVI50Phc=; b=Piyl+WFg8uIPgSLKiLwfUqcLPJ
	bxg/+B1Ogtw8x9ruUn3pp0lOHsvAqqpmKlZzm4YA7ZEb9JuWWP5PAKdq95ioZRNQ+YRbsbCvlUnCO
	8pifCC4UNDDG8WwjV/p3x0uyHrkYu/yvQ2qfjkdB5bnIHx2Mu9jGJT+nuteTRuqF0XfaV0fXBbfcQ
	9JnzCRnJCGRvYrVj44q/mNfBkB5G502h6NGyYhYsrnNexzU3ckdHZSfGvx915VFFp3iHiXX2tYk7I
	8y9MCVUmgThN9UDSSZKr0DOQ1BnN6/FNEqKuh2CNBIxPV3wQivKGGtbfvvIzkIYY41s0h/CGMgzIe
	P+kWgahQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p311j-00BnOP-L0; Wed, 07 Dec 2022 20:28:23 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p311g-00BnKh-Ft
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 20:28:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670444899;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ERzjyp7zk5Z5+YVLaxlhiooylxoMa/YnIAQSVI50Phc=;
	b=HNfgA+EBdik8a7ImgHBkU261GvxFLalqqOlJh1EE5gbfAPKF36NxpZa8qVD9wrzcp/adNT
	kS9kJ7FL/HlkELxVa5h3KDrkNaKqo5SjLZ9Qkd+LtmCb/zvAz8QwCddWEZMF/UmpTfVlaF
	ipCfryf8vSSMuMMY8CH4hRwRYnLZ5rY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-343-R3mUo6quM5Oi3fax-BVh6Q-1; Wed, 07 Dec 2022 15:28:18 -0500
X-MC-Unique: R3mUo6quM5Oi3fax-BVh6Q-1
Received: by mail-wm1-f69.google.com with SMTP id s24-20020a7bc398000000b003d087485a9aso903362wmj.1
        for <linux-nvme@lists.infradead.org>; Wed, 07 Dec 2022 12:28:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ERzjyp7zk5Z5+YVLaxlhiooylxoMa/YnIAQSVI50Phc=;
        b=VFPCSqcyqRTTtDGmrfXAe7f4wbbVol3QdSEdXCKh+EPD6/HwJR0L7seV+ZbKILqQJO
         2nIaFrB9HIDpzMDTYwBrrfLgdjA8geVaoIw+gUuYvvEGOGfJfxUYcY+htjOsoaMz4LTM
         EcIkIKqWgrX0kj75vayBkyApd5zqAGbXsYrNDDdYveFCmaMYiBqgZwD2GihkSjMPPy11
         vSGejnkO2nvWDlyqSB25pFNdBl44qqC8DrfHI8OzujTlOnfw7qYAIIqoZ5VYGUR6MXZ9
         Yx1UQbnbD4Vqcejv2ZqjOw9FdYAwdH10RwOz3vEWJt6t5Thr5FToCOAu1g5mMVApPLeo
         y+Ww==
X-Gm-Message-State: ANoB5pm0pmYVSyWDYEJwUmR+HaKhUvAZigv7/ON9kosvpT9UjNo41s2/
	wgcz318oeFNxJEDSGRW/47g29lHdwT4+nOlnNcFKYGyO+QQCNYz6beiwgXhW/+8mzjSALPm+9W0
	DI34LspPWZNra8VlZubeW4feUBoI=
X-Received: by 2002:adf:f98e:0:b0:242:324:ff88 with SMTP id f14-20020adff98e000000b002420324ff88mr35473842wrr.81.1670444897079;
        Wed, 07 Dec 2022 12:28:17 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4QOq0RAPymVdkyXnh7/V2ZIzFLtZtJ+dwe3UW02/93b8NTVphp6L78PZAaWRCEXF7iho9Mtw==
X-Received: by 2002:adf:f98e:0:b0:242:324:ff88 with SMTP id f14-20020adff98e000000b002420324ff88mr35473829wrr.81.1670444896831;
        Wed, 07 Dec 2022 12:28:16 -0800 (PST)
Received: from redhat.com ([2a02:14f:17a:1a4f:ce60:357c:370b:cc7e])
        by smtp.gmail.com with ESMTPSA id b12-20020a5d634c000000b00241e8d00b79sm25007953wrw.54.2022.12.07.12.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 12:28:16 -0800 (PST)
Date: Wed, 7 Dec 2022 15:28:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221207152116-mutt-send-email-mst@kernel.org>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <Y5BCQ/9/uhXdu35W@infradead.org>
 <20221207052001-mutt-send-email-mst@kernel.org>
 <Y5C/4H7Ettg/DcRz@infradead.org>
MIME-Version: 1.0
In-Reply-To: <Y5C/4H7Ettg/DcRz@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_122820_625634_1BCDD72E 
X-CRM114-Status: GOOD (  20.06  )
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

On Wed, Dec 07, 2022 at 08:31:28AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 07, 2022 at 05:21:48AM -0500, Michael S. Tsirkin wrote:
> > Christoph you acked the spec patch adding this to virtio blk:
> > 
> > 	Still not a fan of the encoding, but at least it is properly documented
> > 	now:
> > 
> > 	Acked-by: Christoph Hellwig <hch@lst.de>
> > 
> > Did you change your mind then? Or do you prefer a different encoding for
> > the ioctl then? could you help sugesting what kind?
> 
> Well, it is good enough documented for a spec.  I don't think it is
> a useful feature for Linux where virtio-blk is our minimum viable
> paravirtualized block driver.

No idea what this means, sorry.  Now that's in the spec I expect (some)
devices to implement it and if they do I see no reason not to expose the
data to userspace.

Alvaro could you pls explain the use-case? Christoph has doubts that
it's useful. Do you have a device implementing this?

-- 
MST


