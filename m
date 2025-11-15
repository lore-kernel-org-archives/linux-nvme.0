Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1707ECEBF86
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Nov 2025 22:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o2Xrv0xJ9oC9kn5c/x2EsBp3So4jCy6049Ql9XrALiM=; b=Rd+X9otEhC2MqhdbxLIC0bK3Gm
	KOhzL9B1E80ZqX0DNx25brSfcdbAONPJKlm+GaV0tA1Bb2X36HToQQJ7oDCQh1yMRSrDGaXYSv97I
	soxk0Gk2ZHncDYuQeivcXDcjASPq7U+nGbfZyR8CHL/e+2cWK+afPfsne6hcTkJ6ecjJNMey7m3TK
	pQXeJBbf3BzaOd5B0VqgmAVM3500Md4Vcyey/gVUxn5P2jMyJBYsy2sPEv9kLzKHq3hvG1L5IMp91
	8Az8dudIUcksY4HJ1xrpaFJfJ1PMSBZboQTeE9OAfBwq8svnrv0jDN/po8Ck8fWil/E+kUbVkqLDY
	/ypeD8Gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKOlM-0000000E9gM-1uwS;
	Sat, 15 Nov 2025 22:28:56 +0000
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vKOlJ-0000000E9fq-3roa
	for linux-nvme@lists.infradead.org;
	Sat, 15 Nov 2025 22:28:55 +0000
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so34678505e9.1
        for <linux-nvme@lists.infradead.org>; Sat, 15 Nov 2025 14:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763245732; x=1763850532; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o2Xrv0xJ9oC9kn5c/x2EsBp3So4jCy6049Ql9XrALiM=;
        b=R5uC/PGhvIz1yO2E7VODq0hVgKOlrRXXWeW22E6H+M1Z4jCD2y8SAiqeK/KNAhssFi
         47UOq6GH5fmSiKUblWAfTsHCZopbcUeZnEF8kk2KdFjlvaxAO+RqTjcD+Ptrp65nI1jC
         YWrfl36CoSSINJXA7jMfD2DoQD519puOls4lF6VrrdkAJig6d8sk35bBqRGthmwaVld4
         1udlDDsN3RCbWgal+Vj14PmwoZEAjlV24Jdd2WryHOPqPXxzOBMktyrBmZu7a+PIurnm
         +WXfb+PX8uvJ1CrQEi8Nkt69flA9cq8D+ccqiuFsdZ1re5F6zI8uybmnianQoOaHEL21
         7WTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763245732; x=1763850532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o2Xrv0xJ9oC9kn5c/x2EsBp3So4jCy6049Ql9XrALiM=;
        b=fBumCfXFhSCfxE43zeOdrg+mjd8+0PZ5H7QcmYio0HIogEKSMHzyFQdKbg43ilpD6D
         IRZctTrXIu+hqoyT+XMc98/xtttKHZcQKLP+6SG+6c+SubJQKl9HPtw2C3g5zGYVRMsg
         csdNYScf4s1kr6PQTrlPFJ66me62tgYmkAEdoc+RfmjrHm1ktq0T8+3uH/iJ5eg/h040
         2tUZaov9m5UNeLamzjEJfwZ0gCM6nIGecJaCwPfmGtCvt2qyyldjra1V4V9wPBtgKi9x
         FF8c0sX1KMwMatbK540PXUH7JKcADfgGrpI5/brjrjNrVD8jr9vuelYmJjfaSP+rbTHl
         hN0A==
X-Forwarded-Encrypted: i=1; AJvYcCUzrU8uKBHS7LDVAUlIHvBZCGS5FGfVzrObz6jhh3Nl87YrYbHDKkDbxRyX7ra4pUtPwXk8X35/XvOz@lists.infradead.org
X-Gm-Message-State: AOJu0YytzDEPFHajXfBeIefLLmTYoftA1ItKIS7q7dwTlVvsbCa+miLn
	LqbFpiFEflIYk+44dIqMWXUzD2zuxRa2v3J6f/gtodX4fKFUUvERzUAm
X-Gm-Gg: ASbGncvRBjdybDexlMqzIquk9pE4lGDRNZn17DSI3+LJ/lNFo8JtZGR93amDlkeR+2Q
	wpQ5XsDyh5Cy1tO3n1L1sgPDofzgdLOXSA8jO1BMa2LjKtHF49bF4KD8qmykLlx0tSQ/MjYC8l1
	Gu2GDj9J+o+d5lcBfHz0PqNJstZGePCeLzThvc+Kp71nqzEzgLsL7V9jMsNCkrJH3YWNDRp4Vmv
	5QYeuhdi6TVKu3UQ22ZAalYWnNnk0eCV/IVITQ95erhb+vwNJrpiD4pjqhwu0TtvGm7dKnTygFT
	yLzhv2kxt6rN5rI7vqHwyihBEQRiQ4dEkSdfOIYoB2qE8SFe3d2qu9kGVpg7cCCrrV0mjv6rv5I
	HEQ+JDnHynJiUDqMUjjgIaHxt1IvAqdl0Ss+yMgp48eRrQcytBXJo7SCzugxjp4IycMfFphdOdS
	zimvnGSMaACY6nUznRclPCBhjJh9IDXxvH0ocD7xrnEXa1U2mv1PXq
X-Google-Smtp-Source: AGHT+IFdxdzmeev3HrNzWJ2sskEhMPRWYP1zgllLH3n3dfgpFJwxPquIa2N+BHT4Jqy6QmXptGNXLQ==
X-Received: by 2002:a05:600c:8b43:b0:477:6e02:54a5 with SMTP id 5b1f17b1804b1-4778fe6098dmr71627895e9.18.1763245731840;
        Sat, 15 Nov 2025 14:28:51 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4778bb34278sm76630295e9.4.2025.11.15.14.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Nov 2025 14:28:51 -0800 (PST)
Date: Sat, 15 Nov 2025 22:28:50 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251115222850.183b8557@pumpkin>
In-Reply-To: <20251115180547.GC147495@unreal>
References: <20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org>
	<20251115-nvme-phys-types-v1-1-c0f2e5e9163d@kernel.org>
	<20251115173341.4a59c97f@pumpkin>
	<20251115180547.GC147495@unreal>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251115_142854_039621_D5A24090 
X-CRM114-Status: GOOD (  43.85  )
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

On Sat, 15 Nov 2025 20:05:47 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> On Sat, Nov 15, 2025 at 05:33:41PM +0000, David Laight wrote:
> > On Sat, 15 Nov 2025 18:22:45 +0200
> > Leon Romanovsky <leon@kernel.org> wrote:
> >   
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > This patch changes the length variables from unsigned int to size_t.
> > > Using size_t ensures that we can handle larger sizes, as size_t is
> > > always equal to or larger than the previously used u32 type.  
> > 
> > Where are requests larger than 4GB going to come from?  
> 
> The main goal is to reuse phys_vec structure. It is going to represent PCI
> regions exposed through VFIO DMABUF interface. Their length is more than u32.

Unless you actually need to have the same structure (because some function
is used in both places) there isn't really any need to have a single structure
for a a phy_addr:length pair.
Indeed keeping them separate can even remove bugs.

For instance (I think) blk_map_iter_next() returns an addr:len pair
that is only only used for the following sg_set_page() call - which
has separate parameters for phys_to_page(addr) and len.
So unless there are other place it is used it doesn't need to be
the same structure at all.
(Other people might disagree...)

> 
> >   
> > > Originally, u32 was used because blk-mq-dma code evolved from
> > > scatter-gather implementation, which uses unsigned int to describe length.
> > > This change will also allow us to reuse the existing struct phys_vec in places
> > > that don't need scatter-gather.
> > > 
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  block/blk-mq-dma.c      | 14 +++++++++-----
> > >  drivers/nvme/host/pci.c |  4 ++--
> > >  2 files changed, 11 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > > index e9108ccaf4b0..cc3e2548cc30 100644
> > > --- a/block/blk-mq-dma.c
> > > +++ b/block/blk-mq-dma.c
> > > @@ -8,7 +8,7 @@
> > >  
> > >  struct phys_vec {
> > >  	phys_addr_t	paddr;
> > > -	u32		len;
> > > +	size_t		len;
> > >  };
> > >  
> > >  static bool __blk_map_iter_next(struct blk_map_iter *iter)
> > > @@ -112,8 +112,8 @@ static bool blk_rq_dma_map_iova(struct request *req, struct device *dma_dev,
> > >  		struct phys_vec *vec)
> > >  {
> > >  	enum dma_data_direction dir = rq_dma_dir(req);
> > > -	unsigned int mapped = 0;
> > >  	unsigned int attrs = 0;
> > > +	size_t mapped = 0;
> > >  	int error;
> > >  
> > >  	iter->addr = state->addr;
> > > @@ -296,8 +296,10 @@ int __blk_rq_map_sg(struct request *rq, struct scatterlist *sglist,
> > >  	blk_rq_map_iter_init(rq, &iter);
> > >  	while (blk_map_iter_next(rq, &iter, &vec)) {
> > >  		*last_sg = blk_next_sg(last_sg, sglist);
> > > -		sg_set_page(*last_sg, phys_to_page(vec.paddr), vec.len,
> > > -				offset_in_page(vec.paddr));
> > > +
> > > +		WARN_ON_ONCE(overflows_type(vec.len, unsigned int));  
> > 
> > I'm not at all sure you need that test.
> > blk_map_iter_next() has to guarantee that vec.len is valid.
> > (probably even less than a page size?)
> > Perhaps this code should be using a different type for the addr:len pair?  
> 
> I added this test for future proof, this is why it doesn't "return" on
> overflow, but prints dump stack and continues. It can't happen.

No, on a large number of installed systems it prints the stack an panicks.
Were it to continue the effect would be all wrong anyway.
But blk_map_iter_next() guarantees to return a sane length.

> 
> >   
> > > +		sg_set_page(*last_sg, phys_to_page(vec.paddr),
> > > +			    (unsigned int)vec.len, offset_in_page(vec.paddr));  
> > 
> > You definitely don't need the explicit cast.  
> 
> We degrade type from u64 to u32. Why don't we need cast?

Because you don't need to cast pretty much all integer conversions.
Any warnings compilers might output for such assignments really are best
disabled.
The more casts you add to code to remove 'silly' compiler warnings the
harder it is to find the ones that actually have a desired effect and/or
unwanted effects that are actually bugs.

I'm busy trying to fix a load of min_t(u32, a, b) which mask off high
significant bits from u64 values.
The casts got added (implicitly by using min_t() instead of min()) because
min() required the types match - and in a lot of cases the programmer
picked the type of the result not that of the larger parameter.
Others are just cut&paste of another line.
But the effect is the same, the casts add bugs rather than making the
code better.

I've even seen:
	uchar_buf[0] = (unsigned char)(int_val & 0xff);
(Presumably written to avoid compiler warnings.)
and looked at the object code to find the compiler (not gcc) anded the
value with 0xff for the '& 0xff', anded it with 0xff again for the cast
and then did a memory write of the low bits.

casts could easily be the next 'bug'...

	David

> 
> Thanks


