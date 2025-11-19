Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB12CF34B2
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 14:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S7aP8W+Aeaqnc8t5oPu3wVtzhhr1g6oARpgSmq5CAOE=; b=Gq2ZXKzSPAFSFWobTI1BFmZuU4
	C93YAWMPPoi/ZsLjnaqVSkmz8bV8CTHTJaleK9lT1Q/jjzlF3RMz0PPMgkzD8ZfaiWJuIwpmuoT2J
	8N4lX5FbDE+TkyKT4ZfFlvApZpkTA2v2jlUEqd3lSMh7A9uOQRQ1by74MUhckTDWXZ1Ul/rJfx35y
	/SCPgTqrJ9KDCtwligGbhCK2CLG54VyPnFEIPgKT9OwgvTfXaSrcjYjCNgLQ4WHa0aZqcXGodaYMX
	vs/8wAb8SIxyDvgy99MKI/sm/nhSKvuBSKupk9ZVATCb6PwvcD7/Bz6TK5oK9Q3mce9Af2l1KpA5P
	8DZdl5Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLivj-00000003LvY-1foM;
	Wed, 19 Nov 2025 14:13:07 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLivh-00000003LvA-0RRc
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 14:13:06 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so49303775e9.0
        for <linux-nvme@lists.infradead.org>; Wed, 19 Nov 2025 06:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763561583; x=1764166383; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7aP8W+Aeaqnc8t5oPu3wVtzhhr1g6oARpgSmq5CAOE=;
        b=nSYchRRZKmK19aX2JaVLZW90Up+WtoOcHMpwQUNp6AkuhqU92DEM7WYVBs8/FUCVzo
         ywZRxRjYqpJRWoeOKAIbV2YDJHfZRIvtz87tFYWR+OXpq5evInN/kj9QWFeE/+PWQ2rY
         AZiCa0L0mOrjASWCF2PL3hFSvm7+yNKHAGjK1ilv8kBOLG/jJtnmub65/SlIt1Beo7Xv
         i7gleWzPC+fi8w8GfyHCSPXQGE4ZTPk+2ZzgUPvc6gihbFXuYGrglAkx30ZlRF1FqGBw
         KJKJN/uRe0DaVIB0C1Q5LSz63lr7dGQBJemzyrXWymXj6qPQmWPHdr9lR29h4fqw6t7a
         Gqjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763561583; x=1764166383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S7aP8W+Aeaqnc8t5oPu3wVtzhhr1g6oARpgSmq5CAOE=;
        b=FZslf64ohsK6UtmjfK/LuWcH4AdKPCHdJHS9mtfF1OnZt0Fbv1ZfDOsu9350GlPZ88
         Ehc4mc9sMX3ydn/GRmCI05hLBbGar5zCDN8R3p3z5ncz/iPZRPsLSWGZmqhlvjq39Zn1
         jHM4/lCR69RbYncD18TVn6tFprAjelkSgEaGYScZaaOU13d3ZcWQSE0R21FDkvKG4hBF
         YASM7z91pNR75FPrrIFzAVi2GFrAqU1jj+XU6ZfoXM441ojVhxRR6CLp8J9ZEFx1ZyEl
         RrDIfcmD/Hoks6TpIW5PbbELrgN9PYN0hNllAEBD2gcIPxL7A6/gg3y4Fk760m3IWSf3
         9fSQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3GG+2NE1tza4yvXdMkfunbs4pmbTv8t+h24W0OZzPZhk7WQjBn7dL42UUdeZfhDVemvImpRo3J+nX@lists.infradead.org
X-Gm-Message-State: AOJu0Yz5hdx38NGk6fBz9ud6t/EKWjYqniSizulFsXqgfHRP6dO+Wv9R
	oAydiQScpYgUEE02AstTT9ZLgR1sHyKYdwad3qHgiQyNGDejqvYbpjw0
X-Gm-Gg: ASbGncu98Lh6fvSSQTrbXV3+7dm0lr6FjpuEoPBlWFaoq+4c78FgoG9Fkr/THEAvyK7
	XHQCABqzv/m01A4LMNtLawLrgSDKTVqflv7aKtMrz8Tu/0N3it5xI/Xd4/B5qDX/PrDBvqt0Am8
	RqiUOmJQaIhm5hJBVxGbQrXm0La8MG9U3OhVsDZXS8ZaAPKja66iMN0emtutSq+IhBcMVsvcD7O
	1f4j+hzrW3UliPUvxAW/cTpmwgHhsobq99P83f6E0XWbYnwUTsowVfdHZCaXP5PFOewXCIR6VLj
	ELl7cpF35Cjj+o7KV4FXJLkL24icoAzpVZ3tg2ghnDKfu80JdaTDm9IsS0acmV7rGQow+sfY00V
	NFVwxWxMzUxM1lOTyMxZw+KSYNRugP4I1PLK3wveeIcY46fDygC+701fdRtAc5wwbFSwyXyVSNc
	oOboRZ+SRkUJ7iksJPk02BtxjzomNYU2YIUm2BwgwIVwei/jjpDOuO
X-Google-Smtp-Source: AGHT+IEtVM7lrLxA2BQPvt9R5nz+4TxPuoPf0muPqE8Gc4OLySQB28IfuFlpBF7XjUUBcohtoZ0Sgg==
X-Received: by 2002:a05:600c:3b19:b0:475:daba:d03c with SMTP id 5b1f17b1804b1-4778fe62088mr167939805e9.13.1763561582690;
        Wed, 19 Nov 2025 06:13:02 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85cc0sm39416229f8f.17.2025.11.19.06.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:13:02 -0800 (PST)
Date: Wed, 19 Nov 2025 14:13:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251119141300.2209ea72@pumpkin>
In-Reply-To: <20251119135821.GH18335@unreal>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
	<20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
	<20251118050311.GA21569@lst.de>
	<20251119095516.GA13783@unreal>
	<20251119133615.2eefb7db@pumpkin>
	<20251119135821.GH18335@unreal>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_061305_176291_B36A294C 
X-CRM114-Status: GOOD (  39.30  )
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

On Wed, 19 Nov 2025 15:58:21 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> On Wed, Nov 19, 2025 at 01:36:15PM +0000, David Laight wrote:
> > On Wed, 19 Nov 2025 11:55:16 +0200
> > Leon Romanovsky <leon@kernel.org> wrote:
> >   
> > > On Tue, Nov 18, 2025 at 06:03:11AM +0100, Christoph Hellwig wrote:  
> > > > On Mon, Nov 17, 2025 at 09:22:43PM +0200, Leon Romanovsky wrote:    
> > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > 
> > > > > This patch changes the length variables from unsigned int to size_t.
> > > > > Using size_t ensures that we can handle larger sizes, as size_t is
> > > > > always equal to or larger than the previously used u32 type.
> > > > > 
> > > > > Originally, u32 was used because blk-mq-dma code evolved from
> > > > > scatter-gather implementation, which uses unsigned int to describe length.
> > > > > This change will also allow us to reuse the existing struct phys_vec in places
> > > > > that don't need scatter-gather.
> > > > > 
> > > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > > > ---
> > > > >  block/blk-mq-dma.c      | 8 ++++++--
> > > > >  drivers/nvme/host/pci.c | 4 ++--
> > > > >  2 files changed, 8 insertions(+), 4 deletions(-)
> > > > > 
> > > > > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > > > > index e9108ccaf4b0..e7d9b54c3eed 100644
> > > > > --- a/block/blk-mq-dma.c
> > > > > +++ b/block/blk-mq-dma.c
> > > > > @@ -8,7 +8,7 @@
> > > > >  
> > > > >  struct phys_vec {
> > > > >  	phys_addr_t	paddr;
> > > > > -	u32		len;
> > > > > +	size_t		len;
> > > > >  };    
> > > > 
> > > > So we're now going to increase memory usage by 50% again after just
> > > > reducing it by removing the scatterlist?    
> > > 
> > > It is slightly less.
> > > 
> > > Before this change: 96 bits  
> > 
> > Did you actually look?  
> 
> No, I simply performed sizeof(phys_addr_t) + sizeof(size_t).
> 
> > There will normally be 4 bytes of padding at the end of the structure.
> > 
> > About the only place where it will be 12 bytes is a 32bit system with
> > 64bit phyaddr that aligns 64bit items on 32bit boundaries - so x86.  
> 
> So does it mean that Christoph's comment about size increase is not correct?

Correct - ie there is no size increase.

> 
> Thanks
> 
> > 
> > 	David
> >   
> > > After this change (on 64bits system): 128 bits.
> > > 
> > > It is 33% increase per-structure.
> > > 
> > > So what is the resolution? Should I drop this patch or not?
> > > 
> > > Thanks 
> > >   
> >   


