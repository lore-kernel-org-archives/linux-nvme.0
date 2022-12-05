Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED48C4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Dec 2022 20:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i4H5uezEbMG5ZldNo/c3W56d4899NhGUYDjXb8nhkk4=; b=1guEdBF3j52EzeeBDs/ovNk7x1
	NssrVePLmlM/MihFv5zseujNw2COgjKmG9Ez+N4q7TeoF9I9Dqbu6vsQ5nX+QyU4jv5p5s7uV0axQ
	KyzN6ZctsfnEmfgB8IxlMD2J/CXNZnZ2kKaiv901xKw9dtPNQa5996qDHC3+68vRdPZf4DfzRnnaD
	w3OmCFZUNw+cVxhrEqQPyTWbjbYSJ3BqBuy4tr8+AbmbXz49rYigJ4NeI663xIxjsf3tru+nXj27R
	xEwartadp8t3KHU1noYVCUOGNiA/pEokTk33AtDpqZtveTr2Y/+bggyPihstw/0dZgMqzMj798Cff
	UvzjiS5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2I73-00AIUx-JG; Mon, 05 Dec 2022 20:30:53 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2I70-00AITo-Ri
	for linux-nvme@lists.infradead.org; Mon, 05 Dec 2022 20:30:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670272248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=i4H5uezEbMG5ZldNo/c3W56d4899NhGUYDjXb8nhkk4=;
	b=XVHDZaLzAiCRrrp4vJpmU10315DFB8wloYNPptLC0PUurNrO4e8pOoLW/0wvFgVf+VuDxs
	wbb7fky+5n4n1MybIa1nVwaQsD7S7wGKeMxD8n5F+75gdDH0i82yLSeG/ZXlxrQNkY04ca
	XZBz8hdyH1ZIv4IxZmVNYtrPzZfZFBY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-284-c4zDGZ3pMKOPfQVM7DmJjQ-1; Mon, 05 Dec 2022 15:29:09 -0500
X-MC-Unique: c4zDGZ3pMKOPfQVM7DmJjQ-1
Received: by mail-wm1-f69.google.com with SMTP id c187-20020a1c35c4000000b003cfee3c91cdso7358161wma.6
        for <linux-nvme@lists.infradead.org>; Mon, 05 Dec 2022 12:29:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i4H5uezEbMG5ZldNo/c3W56d4899NhGUYDjXb8nhkk4=;
        b=jT5SME9pMEDk73jf/jXcYOz7YTqv/A6Pqy+gqs6+sq5faVXjK198AAXOrZ9TX2Rjrx
         JLpf2cfnXRU45XPBhHMIHL01NHCLc6raFkGgbrcOuYzRnhYWE4A7KuYsVTE3XFcx5tT+
         jMxHEc9SmFMiDmXBVxQhul+PcFjANEY6D05OAvBNNzZ4lH2hw4p5j1G8WDYQWVYD1oVX
         JxRmIYrTeYSlqpDZMRMltekcvAtqa7v9Go3kaPTLSc6jd5lth2aEJkwAtouiGCjCrReM
         ze6VoS/1Ya5ZukXIdPmN1Nk97nbeS0uRbjIv7j5JeIRttcofJVnzrJb/imJJ/ETQ6nwV
         T/0w==
X-Gm-Message-State: ANoB5pmcmN1JzYWvOAYWkKYzF8W9cu9/ahY2QbIA35hSG6OP5U9/Ruu2
	FIJSKThMwvBQgP/d9Y0mDy/TgGmLmxrbOwQvglfB3YAOjYAX15f41s4Dr98ATKwNVQtDHGqatif
	5Zn1zmVDhKcr2s0o1wLBTmR2jAxI=
X-Received: by 2002:a5d:610d:0:b0:242:4fd1:1f5c with SMTP id v13-20020a5d610d000000b002424fd11f5cmr7301051wrt.376.1670272146268;
        Mon, 05 Dec 2022 12:29:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf78f2gBMfTc6pHwRJ9zUly9GcCuFO5gZSklgpcj2WDCa2T0RWsRGceUYvYzIHBgrSw3qKds3g==
X-Received: by 2002:a5d:610d:0:b0:242:4fd1:1f5c with SMTP id v13-20020a5d610d000000b002424fd11f5cmr7301041wrt.376.1670272146115;
        Mon, 05 Dec 2022 12:29:06 -0800 (PST)
Received: from redhat.com ([2.55.160.224])
        by smtp.gmail.com with ESMTPSA id b18-20020a05600010d200b002423a5d7cb1sm12096271wrx.113.2022.12.05.12.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 12:29:05 -0800 (PST)
Date: Mon, 5 Dec 2022 15:29:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org, dm-devel@redhat.com,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Enrico Granata <egranata@google.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221205152708-mutt-send-email-mst@kernel.org>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <fe2800f1-aaae-33e8-aaf0-83fd034162d5@kernel.dk>
 <CAJs=3_AKOMWBpvKqvX6_c=zN1cwEM7x9dzGr7na=i-5_16rdEg@mail.gmail.com>
 <23c98c7c-3ed0-0d26-24c0-ed8a63266dcc@kernel.dk>
MIME-Version: 1.0
In-Reply-To: <23c98c7c-3ed0-0d26-24c0-ed8a63266dcc@kernel.dk>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_123051_009995_92B5E47B 
X-CRM114-Status: GOOD (  18.93  )
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

On Mon, Dec 05, 2022 at 11:53:51AM -0700, Jens Axboe wrote:
> On 12/5/22 11:36 AM, Alvaro Karsz wrote:
> > Hi,
> > 
> >> Is this based on some spec? Because it looks pretty odd to me. There
> >> can be a pretty wide range of two/three/etc level cells with wildly
> >> different ranges of durability. And there's really not a lot of slc
> >> for generic devices these days, if any.
> > 
> > Yes, this is based on the virtio spec
> > https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html
> > section  5.2.6
> 
> And where did this come from?


Here's the commit log from the spec:
	In many embedded systems, virtio-blk implementations are
	backed by eMMC or UFS storage devices, which are subject to
	predictable and measurable wear over time due to repeated write
	cycles.

	For such systems, it can be important to be able to track
	accurately the amount of wear imposed on the storage over
	time and surface it to applications. In a native deployments
	this is generally handled by the physical block device driver
	but no such provision is made in virtio-blk to expose these
	metrics for devices where it makes sense to do so.

	This patch adds support to virtio-blk for lifetime and wear
	metrics to be exposed to the guest when a deployment of
	virtio-blk is done over compatible eMMC or UFS storage.

	Signed-off-by: Enrico Granata <egranata@google.com>

Cc Enrico Granata as well.


> -- 
> Jens Axboe
> 


