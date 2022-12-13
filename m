Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3ECC4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Dec 2022 06:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:In-Reply-To:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zdosc0+4UprGU1f9HW8VSDzkH/4Gm3wZqjmhjmwHaoc=; b=2RM87BSZTQRMEAeOJVTrt3lXDS
	eSrWvGWx8bLlw1r00UZK3Ziy+NT+2TF3ot+UDB1ga7TSw3eXT0Rq94nkO9wnjTqVLHxk0wcvGvJTA
	41YPcIKBz2D/3d9HzNfcQwxzStlmuB1+xx++VrsHKnKPiW26SstFedEFu6ArFxnaOthjX6BecvK9o
	fVIGOQYtvdbFp1IJYD0acygCBmNhpaRYJhCjpPYRs0izwTbWmHMB+KNAUVpNpRzjXXwvOAHDEeaNg
	dRd6mnRoChB03Hun55UlkjGPY3fcdC1N4gmdHWe2UgXlW0EWNkq8U0nfY5w0akh98toThQmyJP54E
	lMjzvm6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4yhp-00BOsb-15; Tue, 13 Dec 2022 06:23:57 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4yhl-00BOkt-Px
	for linux-nvme@lists.infradead.org; Tue, 13 Dec 2022 06:23:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1670912629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zdosc0+4UprGU1f9HW8VSDzkH/4Gm3wZqjmhjmwHaoc=;
	b=TEUcTCe6Dy4qlCXRrmfnFldFoBtD1Emh8sDSHp9/bdvFgHouBzdqlGwofAYhvvKfaASv1C
	DUfyNSIT5k6lWEvE3yrO33silByTchh5GdpcxVktbtfqPa9/yITZkTbkHnd8/rzgZloCuV
	vl/rnrq+IT6Y3JswMxCqsc2FqXyHORI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-643-9NUiBfzSM-OH9y0zlZlyHg-1; Tue, 13 Dec 2022 01:23:48 -0500
X-MC-Unique: 9NUiBfzSM-OH9y0zlZlyHg-1
Received: by mail-wm1-f69.google.com with SMTP id e8-20020a05600c218800b003cf634f5280so2571137wme.8
        for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 22:23:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdosc0+4UprGU1f9HW8VSDzkH/4Gm3wZqjmhjmwHaoc=;
        b=G8mMtcmhCYLK+b/Bj/VAb11r29dVjsqxy0KrWsTlazDCBcS4O1iRAEMtUsZU4EMwWp
         jvcNFEhL8tIfMeghtnjS7Gab4cFntARTw+k4H+V0PXI8zfJMW4ZyLFUugrl8TdcHhD0J
         UyK1q38woLFgQ8w2oHyrzSPVU15LZvYYn2QAD9DdqtFczL5aXpdiAZzX/9ZbIz5oZD2x
         ichvTkSkjtl7M6DYteLzkS4E/pS08OfJf2mbw3L7FraV/kmhG7oD6NqUwbUXXwSaQIbr
         KONqJWcj34i8f9OH5WtxVHQx2FDczDhOvXoaAInw+R5PpJIbdO74Dj+NwTR/yU8NCKsM
         0qYA==
X-Gm-Message-State: ANoB5pn/FPwIiQ70bFtjYcBij5BFubhaKuzX4fJCLk253uMUJStKoR7Q
	7oEnkwM7E/EN4DNBQumvsQt2IXSOEmwtbDWr21ojCkke0ylyVPcfdPPU2XLa3HMVMaS4Io98oeq
	wRH8puDg78ugnMOSDAz43yAgO0EM=
X-Received: by 2002:a5d:4b0b:0:b0:241:f8b6:9693 with SMTP id v11-20020a5d4b0b000000b00241f8b69693mr10657857wrq.37.1670912627218;
        Mon, 12 Dec 2022 22:23:47 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4I9L5F8Y2mNHOKhXS0GG3uRTSVP0X4b9ULK97I3031/HbGTKYGoQr9e4elbaLdVkvuI9TpMQ==
X-Received: by 2002:a5d:4b0b:0:b0:241:f8b6:9693 with SMTP id v11-20020a5d4b0b000000b00241f8b69693mr10657848wrq.37.1670912626982;
        Mon, 12 Dec 2022 22:23:46 -0800 (PST)
Received: from redhat.com ([2.52.138.183])
        by smtp.gmail.com with ESMTPSA id q4-20020adffec4000000b00241c6729c2bsm10574835wrs.26.2022.12.12.22.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 22:23:46 -0800 (PST)
Date: Tue, 13 Dec 2022 01:23:42 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"dm-devel@redhat.com" <dm-devel@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221213001034-mutt-send-email-mst@kernel.org>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <Y5BCQ/9/uhXdu35W@infradead.org>
 <20221207052001-mutt-send-email-mst@kernel.org>
 <Y5C/4H7Ettg/DcRz@infradead.org>
 <20221207152116-mutt-send-email-mst@kernel.org>
 <ccb5388d-4976-31a3-0559-e94c14c90573@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <ccb5388d-4976-31a3-0559-e94c14c90573@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_222354_018809_DE5A48DD 
X-CRM114-Status: GOOD (  32.19  )
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

On Tue, Dec 13, 2022 at 04:58:47AM +0000, Chaitanya Kulkarni wrote:
> Michael,
> 
> On 12/7/22 12:28, Michael S. Tsirkin wrote:
> > On Wed, Dec 07, 2022 at 08:31:28AM -0800, Christoph Hellwig wrote:
> >> On Wed, Dec 07, 2022 at 05:21:48AM -0500, Michael S. Tsirkin wrote:
> >>> Christoph you acked the spec patch adding this to virtio blk:
> >>>
> >>> 	Still not a fan of the encoding, but at least it is properly documented
> >>> 	now:
> >>>
> >>> 	Acked-by: Christoph Hellwig <hch@lst.de>
> >>>
> >>> Did you change your mind then? Or do you prefer a different encoding for
> >>> the ioctl then? could you help sugesting what kind?
> >>
> >> Well, it is good enough documented for a spec.  I don't think it is
> >> a useful feature for Linux where virtio-blk is our minimum viable
> >> paravirtualized block driver.
> > 
> > No idea what this means, sorry.  Now that's in the spec I expect (some)
> > devices to implement it and if they do I see no reason not to expose the
> > data to userspace.
> > 
> 
> Even if any device implements is it can always use passthru commands.
> See below for more info...
> 
> > Alvaro could you pls explain the use-case? Christoph has doubts that
> > it's useful. Do you have a device implementing this?
> > 
> 
>  From what I know, virtio-blk should be kept minimal and should not
> add any storage specific IOCTLs or features that will end up loosing
> its generic nature.
> 
> The IOCTL we are trying to add is Flash storage specific which
> goes against the nature of generic storage and makes it non-generic.
> In case we approve this it will open the door for non-generic
> code/IOCTL in the virtio-blk and that needs to be avoided.

Wrt these fields that horse has bolted, it's in the spec.

> For any storage specific features or IOCTL (flash/HDD) it should
> be using it's own frontend such as virtio-scsi or e.g. nvme and
> not virtio-blk.
> 
> Hope this helps.
> 
> -ck

I don't understand what you are suggesting, sorry. It's a hardware
device. It can't just "switch to a different frontend".

-- 
MST


