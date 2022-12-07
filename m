Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 243A3C352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 10:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lPzI0+evVSHS3ztOGGIP3CFHgC5aN3okr0QkVN6UmJ0=; b=NomaOQ6WMZzx8+U6n91iKKAcTF
	eBSozRZgeesSQw1uuw/2ivM3vLMyw6QNy2vdKfLI76Rga2zLvn2ehXCZ41bWZMnwQHZz9BQX6UkYM
	PZyHFPCkBhkyAzf7XvPI2vvk7eyx043cVpKD1t1aQIjYQL8361etuLWtlRzmBfm3kNElIGfAvX0Pq
	7mpCmx7ooBIuGj5TcDy22t7ZoDm2glWtYEKmkFt7LZCnf6w0uI0Y5nSBcXxnWomSN1erHtezOq97i
	5tRhvEtfS3IGoGAZ21YDQVWL+om78n6dF3myWMKgkg2sFGYxjUMMJ7RmXVTCiG0Jn8fGlghq5ILeY
	3EEAQvXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2rYy-00H9g7-Ic; Wed, 07 Dec 2022 10:22:04 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2rYs-00H9R4-Re
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 10:22:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670408516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPzI0+evVSHS3ztOGGIP3CFHgC5aN3okr0QkVN6UmJ0=;
	b=IO6KDsRpg4sTvdXWK7fEUUcKPXZpFqw/BqIJdPQab2p+F45dm23lqSOQsKAs3uoPy8l6CS
	Rt4Ds/qqJECZBqP+gQof8DmV7vFfhY45Fn4rHBtAf0nUnAOUlGq1HUu/vvW/iORxmoJaw8
	gsnCcAD48cf0Irx56OqDusjXhsST9xI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-654-rv7gHYUePVKsfk0LCykSIw-1; Wed, 07 Dec 2022 05:21:54 -0500
X-MC-Unique: rv7gHYUePVKsfk0LCykSIw-1
Received: by mail-wm1-f70.google.com with SMTP id i205-20020a1c3bd6000000b003d1d8d7f266so3900217wma.7
        for <linux-nvme@lists.infradead.org>; Wed, 07 Dec 2022 02:21:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPzI0+evVSHS3ztOGGIP3CFHgC5aN3okr0QkVN6UmJ0=;
        b=TCyAvt/UzzSDUtSLjaCsL40vOHjFr1cITuvaM7WMbPBuEKymPlkBwUX5asHDZLUrfk
         QAcMfKtNcD0brKzYNP4y4EIoVfWq7sSELq4+ngDTNZxqIPO02WTLbveuThjG8xrCdC2o
         CJN8ggpjXwcImKnoz3Mu34wU6v1d0A88bycD8RXCXLlwDdKhNoWEdAVUfXKyb+g4Yu9z
         V1JfDk8icg5ZvGphp5PNvTfALbgxzlKR+5+MaFzAaRiBYjnynTkANrc8Izx8dD7KOmk3
         yeGwbLKdaOqNkhqCRzJ7vPYJ+I2WzzoMhFfhmHutQLU64XzzB/LlU+SQG09jSpREojYj
         rFKQ==
X-Gm-Message-State: ANoB5pmtXHO2RPN7z+m9HoiZ3K0GdcrbF/HrDs4FyiCv/cMgV2A+QJoA
	g7wzaFg4Gz63ww0QvRE+an9MczB9uUx85yvdb6fkUQ5FUqWqze2a9BgbjccG39QvRZj7cJhWqUk
	rRTrigeGAs6VngYPBSO8oD+sQyYQ=
X-Received: by 2002:a5d:6745:0:b0:242:7e6:a0a0 with SMTP id l5-20020a5d6745000000b0024207e6a0a0mr32733378wrw.512.1670408513092;
        Wed, 07 Dec 2022 02:21:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7DMVf3SQ+wTGuF0LUdq4DNgtoQvJFTl9h4t7vhp8I5BZbj8QdljNko1W2iVKGLUD6JkmsMhA==
X-Received: by 2002:a5d:6745:0:b0:242:7e6:a0a0 with SMTP id l5-20020a5d6745000000b0024207e6a0a0mr32733365wrw.512.1670408512850;
        Wed, 07 Dec 2022 02:21:52 -0800 (PST)
Received: from redhat.com ([2.52.154.114])
        by smtp.gmail.com with ESMTPSA id a3-20020adffac3000000b0024245e543absm13739316wrs.88.2022.12.07.02.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 02:21:52 -0800 (PST)
Date: Wed, 7 Dec 2022 05:21:48 -0500
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
Message-ID: <20221207052001-mutt-send-email-mst@kernel.org>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <Y5BCQ/9/uhXdu35W@infradead.org>
MIME-Version: 1.0
In-Reply-To: <Y5BCQ/9/uhXdu35W@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_022158_998492_FF50D2F3 
X-CRM114-Status: GOOD (  13.49  )
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

On Tue, Dec 06, 2022 at 11:35:31PM -0800, Christoph Hellwig wrote:
> This just seems like a horrible interface.  And virtio-blk should be
> a simple passthrough and not grow tons of side-band crap like this.
> 
> If you want to pass through random misc information use virtio-scsi
> or nvme with shadow doorbell buffers.

Christoph you acked the spec patch adding this to virtio blk:

	Still not a fan of the encoding, but at least it is properly documented
	now:

	Acked-by: Christoph Hellwig <hch@lst.de>

Did you change your mind then? Or do you prefer a different encoding for
the ioctl then? could you help sugesting what kind?

Thanks,

-- 
MST


