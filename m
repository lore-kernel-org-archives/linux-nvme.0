Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23112CF2591
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Nov 2025 13:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c7Vh9iH410ocW2kXRvDe/advl/kXNqnUGcQOJSCBMWA=; b=w/RVXPbGGayq+1yKgmg7G0Xy4s
	1L2ELLOMJpnX4Arh8HsPl5HOFOnPjyyay3OgtcBvO4w9D1jnXUm8hCMKeZmQKmYIuO6JNi1n+2iJ9
	CKBg8uM56Iiy4dwHSHnq6eRsvGeluGeUX16eRZ2ULC2/g/Fm2mpRI7d8m8LBX57y0h7c8imYqnH4U
	PKGTJ4erEWutyT6MZzO1/ypyr9ypqUeLQQICB8pEFZ361T+3pffBrQk7yjcTm9gMycW9m29WPh3XD
	DqsPVk5fPHZF29EcMd5Ot2yUVrOojO7rLtZ43Lin+zRvL4NBL7+HFyjt2Kb4p3KMo2TJy/MQ62LFw
	xdm/o8pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLiMA-00000003IS5-2Pir;
	Wed, 19 Nov 2025 13:36:22 +0000
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLiM7-00000003IR3-3hAx
	for linux-nvme@lists.infradead.org;
	Wed, 19 Nov 2025 13:36:21 +0000
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-4777771ed1aso47228655e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 19 Nov 2025 05:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763559377; x=1764164177; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c7Vh9iH410ocW2kXRvDe/advl/kXNqnUGcQOJSCBMWA=;
        b=U+veGj8lHJSI6ZMX5Pf9BVvI7WDOtLzQVbvMlTLczgOLdaaYJSEwcIde9O9avXY9DZ
         4tGpqpYgXlNWci8IprluQ8Umujvl/rAA+h/G4KFmFLVBboF0vIPi37jxoinub7yT9Dy1
         w9hYM+khZDxALv4n7rRp5y1F/AYiz051kMMokqnud2S75rWrTdiwRWo6JwhXFI46guEt
         6lrzTtedoPOS0BxTl8Dk5aGhWlpGKI41p3eBM5oR9ZjG/Y2Q6y3nAbLMegk4XRZvwxpN
         AweHtQ9EnhkGiHGkPOwqxwy5djh3jG0pwn2ZrRUAzUpZQML95pxKGmFLvkV4N8QKtoIT
         uTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763559377; x=1764164177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c7Vh9iH410ocW2kXRvDe/advl/kXNqnUGcQOJSCBMWA=;
        b=JCENGja/m+uvPB3/kEZFvCsKOZQEkrFhN+VUrysGr2egqP6a2vGVTMwq5tQaaxTdvk
         jVDzNYydd/nPqcul5teJ7DcBGwQtBR5dMFI6Cgm+oTh6EkjeM0ye3cPhPRj5t4C3sPQK
         /JrjWRIrQCi9+y7DdfnpBQGRv4Wl/Bfj2k4yOBT2wT/KcyN3eGLyHgb+/x2gv9ghuwAV
         jEaVTQJYF9XuRpUn3IVm+Xj0Ad3qpLJaaj1oupCCPm2roG96JlN/iYmNWGo7DRipNDYw
         lFhcdV7YiQsY/qHdmCTh+DAY6b6/+ri0OiSYF9YqGKR89X/nfJnSOyUqcP/8yHQrU6x4
         +ZVg==
X-Forwarded-Encrypted: i=1; AJvYcCV9wZikqErGmCcnX4D8CwjN9X6Mj0WOogqL3wWxS4L5TvwaNfTBT/UppEmdI3zymQfHuaOJ2OhTsOz5@lists.infradead.org
X-Gm-Message-State: AOJu0YzgXPgXWmb06mteAg/AW1AK6pZG4mP++A4HijTS2cjj34gbcc0s
	VRmNJfQ49LqOKLYfKid6qBsDapC8CJ99NAEFYAJr9lT/nt8qDXoVd4+1
X-Gm-Gg: ASbGnctFVcx5Hcg+SOw+oDhniObt5fxYOpLI6neUE7NurVlglIK9DhTSoh3HRTjUkSN
	dYKRHhIJ2e4ApIekbto8b5PPoQO3KH47nBvbk7zsY9/xI/PRo1xR8XckgHKLoxI/zEAPrxKpo5j
	0R/Fk0eNdTXttW7p6KOa+ahaRlx++y4fKM3PpYPGX5o1GolgdeFIhKd8Y+ET9XaOPXJBKZK1av7
	y8P9NqBV02xLKKl+UUUHl6oPBq+yMuEqNLzj2a9ra04t2gWpq+mN8tHpeYRLgFr2s2h3clftjKi
	74b3W7RAYAJHblNakVJgu0vd/9lxpItKo7r49KubXlfdg6hCPrcqbJSit0IPaV2eM81+R8YYPFz
	DwapQZXGOvgerkBsoxk+uirLE240orEc7Vj9MQv6pmluiAHhoMDLnYog9Ho6pLeavh5bWTOcQHm
	ds41eWW6sUqlXVYTwEfm7WpDw5+jr3e8FcJC6jE4oHE7uh/dSr5g1FtLBo7CQ59Bk=
X-Google-Smtp-Source: AGHT+IE3Y1AoF6Zbsj6EnPiZSX/ljTgCnU9UJMmTnq9iwUTestBp2d1ByiGJgV/xm8MwNcR4oa6vPw==
X-Received: by 2002:a05:600c:3ba8:b0:471:9da:524c with SMTP id 5b1f17b1804b1-477b198ca22mr26146925e9.12.1763559376963;
        Wed, 19 Nov 2025 05:36:16 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b1012a92sm49026715e9.4.2025.11.19.05.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 05:36:16 -0800 (PST)
Date: Wed, 19 Nov 2025 13:36:15 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Keith
 Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v2 1/2] nvme-pci: Use size_t for length fields to handle
 larger sizes
Message-ID: <20251119133615.2eefb7db@pumpkin>
In-Reply-To: <20251119095516.GA13783@unreal>
References: <20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com>
	<20251117-nvme-phys-types-v2-1-c75a60a2c468@nvidia.com>
	<20251118050311.GA21569@lst.de>
	<20251119095516.GA13783@unreal>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_053619_944953_87C75742 
X-CRM114-Status: GOOD (  32.13  )
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

On Wed, 19 Nov 2025 11:55:16 +0200
Leon Romanovsky <leon@kernel.org> wrote:

> On Tue, Nov 18, 2025 at 06:03:11AM +0100, Christoph Hellwig wrote:
> > On Mon, Nov 17, 2025 at 09:22:43PM +0200, Leon Romanovsky wrote:  
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > This patch changes the length variables from unsigned int to size_t.
> > > Using size_t ensures that we can handle larger sizes, as size_t is
> > > always equal to or larger than the previously used u32 type.
> > > 
> > > Originally, u32 was used because blk-mq-dma code evolved from
> > > scatter-gather implementation, which uses unsigned int to describe length.
> > > This change will also allow us to reuse the existing struct phys_vec in places
> > > that don't need scatter-gather.
> > > 
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> > > ---
> > >  block/blk-mq-dma.c      | 8 ++++++--
> > >  drivers/nvme/host/pci.c | 4 ++--
> > >  2 files changed, 8 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> > > index e9108ccaf4b0..e7d9b54c3eed 100644
> > > --- a/block/blk-mq-dma.c
> > > +++ b/block/blk-mq-dma.c
> > > @@ -8,7 +8,7 @@
> > >  
> > >  struct phys_vec {
> > >  	phys_addr_t	paddr;
> > > -	u32		len;
> > > +	size_t		len;
> > >  };  
> > 
> > So we're now going to increase memory usage by 50% again after just
> > reducing it by removing the scatterlist?  
> 
> It is slightly less.
> 
> Before this change: 96 bits

Did you actually look?
There will normally be 4 bytes of padding at the end of the structure.

About the only place where it will be 12 bytes is a 32bit system with
64bit phyaddr that aligns 64bit items on 32bit boundaries - so x86.

	David

> After this change (on 64bits system): 128 bits.
> 
> It is 33% increase per-structure.
> 
> So what is the resolution? Should I drop this patch or not?
> 
> Thanks 
> 


