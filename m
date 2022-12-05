Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFEBEC4332F
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Dec 2022 18:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bKqfMwQzWVOYOX0yr/2heukDSWlHU0sCLL6O1tBRc7A=; b=rtGjHvQ1v2LlLhUU8WErNAFfSe
	ndMV8Clf22ZOW02Xitvd14KC+cAcUer36p2Hja2IC4nYl2c5Ozw+3Eb9yXohbw/6z2dKQPrBNvc4Y
	liUSrJP/MQQZiAGv8Tolj78K0cfmzCVqT2o+2KPu2N01kWEZBRTINzTzEn3JfIDLlqkVPJRyG929x
	gGm1TYs6je/034Q6KJQIe9ZxpGcWzJRFFLx8btWGdwOo7WrdDo2DsdE+lvAwP09Hxr5UlEiQTmC1m
	JMBBZMeeJb/Jg5o9JfnyQwuPRURs0YfTRZKhO8mE51MY9nftbG76ZKV0P6SFI6SIYkLJvwb8cY2eh
	4N/uAuQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2GL6-008Sun-DG; Mon, 05 Dec 2022 18:37:16 +0000
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2GL3-008Srl-A4
	for linux-nvme@lists.infradead.org; Mon, 05 Dec 2022 18:37:14 +0000
Received: by mail-io1-xd33.google.com with SMTP id n188so8139456iof.8
        for <linux-nvme@lists.infradead.org>; Mon, 05 Dec 2022 10:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=solid-run-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bKqfMwQzWVOYOX0yr/2heukDSWlHU0sCLL6O1tBRc7A=;
        b=r2nugea+/S+x1+A/NKJxhGhSo46KlCg0/YSPkE4xZ65fZB3u3y4swnhKZToZJV53y9
         W9ZuR4fGX6HPrGTQoaamF83HV2266vhVLmtnTqs0f08R19v4/QjYZHxHkxNpukL6bq0T
         2RNtr7QF3zxGwPNAWXt2lxtnP8HKNHLrQNZWZRjIkLp+m6CJBuuAzxLg7wn6L7NeH5Br
         Ykj6XHfBLizr5eRdyrLbdpPVKMOx9NAw8tufqLVjkmkB+eGjAdId2ThIt3wJmqhKSbJT
         h7O2hmgsO0npQxMPs01kiVL2/tcv7qdJOM/Wj3xa/a2hq4E1YFE6m6+itmy/n/6DMF31
         q9xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bKqfMwQzWVOYOX0yr/2heukDSWlHU0sCLL6O1tBRc7A=;
        b=guQw+c8w5rvaznAyJxrn3GkeiEYFDOm5soK4kLqDJkJ86CgW3pa9RHfsGQr/9Viq03
         8ehCNwWObQ/iPM8UyP+9d2NummgS3HAMjU26IcCUQOVut5Xf2QrBGNvi7T7aFWDCnbEm
         jVqh873iwomfebRWUJJJyZbEvzJvw9P7QFqL6bRXAp59f0s44j19XRfGqxxCipczKPwg
         8WhXleJB/AcIsOWY4Tu4rQFHDP3rXjrO4v7P5Igb43cxSpezM9SCDq34/1tzS0yVGzCH
         kJBW2ShYxysCDK1PZ2LznmLNLmBNR2BQC2xJGkT6gQkqRF6JypEz3MqhG97MQqtJe9//
         Lfzw==
X-Gm-Message-State: ANoB5pljgvwOb6bPYwHSdEPF/mnz7k5pSKJCnCLbRjr4KCO9unlf8HDC
	5IOTNejxOgbkCox5Jy/p1/M61t2uTsn9TCSYIpUWfW6rIo5zLnwMz0k=
X-Google-Smtp-Source: AA0mqf7iS69oYWO13rn/6u9i2SOCARyk4OODHe8uFql4/VPC3ttbr8u6HDq0kZnXhGPO5q+l052KxdhC7ngmMQnNADM=
X-Received: by 2002:a02:6603:0:b0:375:9e02:b459 with SMTP id
 k3-20020a026603000000b003759e02b459mr38421363jac.30.1670265429512; Mon, 05
 Dec 2022 10:37:09 -0800 (PST)
MIME-Version: 1.0
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com> <fe2800f1-aaae-33e8-aaf0-83fd034162d5@kernel.dk>
In-Reply-To: <fe2800f1-aaae-33e8-aaf0-83fd034162d5@kernel.dk>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 5 Dec 2022 20:36:33 +0200
Message-ID: <CAJs=3_AKOMWBpvKqvX6_c=zN1cwEM7x9dzGr7na=i-5_16rdEg@mail.gmail.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
To: Jens Axboe <axboe@kernel.dk>
Cc: virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org, 
	dm-devel@redhat.com, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221205_103713_604153_840122AC 
X-CRM114-Status: UNSURE (   8.01  )
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

Hi,

> Is this based on some spec? Because it looks pretty odd to me. There
> can be a pretty wide range of two/three/etc level cells with wildly
> different ranges of durability. And there's really not a lot of slc
> for generic devices these days, if any.

Yes, this is based on the virtio spec
https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.html
section  5.2.6

