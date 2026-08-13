Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF219C5B572
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 03:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KJZI+BRoYQPBkd8Un6DeGhhVX1mkGxgW/RiL+FisMrA=; b=Ha8it0h+KHlKUEJ3PvfYBp6Jxp
	2rZzor3LNtoEqcafScgTezxf0lmVg+dfwk2/Zfkx92eAJkJCnDJ2ET2m0qU7meBIczRMKTqgzrqKK
	mLXbUfm0SVwO+7HrtzqFQpJ7eC0we18WHfR90Rk22nCWOff45eYbMrs59BYZyTd19aC75K+E9DMce
	PYseCfRBDrv7C0+ie9lNa6BkPxe5jzmnVPVDsdqsBYLgyWolbX99XuLmJiLUfpi8a3jh45qIp0K9X
	k/0rn2CT839qBZWCa7OH1anW7Jw8Q9oc4emb21PvKr8KfR10JMfu3BjXevZS/ZqGDV/h+FJVwS2cv
	PYWsNlIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuMO3-0000000HKQj-1sKe;
	Thu, 13 Aug 2026 03:45:47 +0000
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuMNx-0000000HKQM-0Usu
	for linux-nvme@lists.infradead.org;
	Thu, 13 Aug 2026 03:45:42 +0000
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-38a0c7e841fso2435391a91.2
        for <linux-nvme@lists.infradead.org>; Wed, 12 Aug 2026 20:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786592740; x=1787197540; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KJZI+BRoYQPBkd8Un6DeGhhVX1mkGxgW/RiL+FisMrA=;
        b=qCdx5iXWuP9IeiBgO/cPkUwtDHlkFlWOSSlzCGNEXFnQ1MB76O5nY9KmI9n44hmryY
         jsIbuvmMd0oQn6vS7SbbkL1eIBfvOcdywImllVZCsBrrxeP7LyVcDa/+mjlhNKVce17a
         r445ORsx6ugNS5qK3jZKCRoYQo11VL/9XeUj4/+1bZ0zFLSLCtoAdTJI1NRMZjZ2F4gK
         u0lFL4GiXOxKLSEiXl9w4cIPSy2j4QCJB7RUAi/VWzRI1ZufEJxQ0Uu8iGYloivg5iWj
         /dbSrC0y9nOCzLKZfWbbJSmtuqQnw+mhkPBJBuVcdQFMvYAYHW7ZsSq7B7EHw40NQgnn
         M40Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786592740; x=1787197540;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KJZI+BRoYQPBkd8Un6DeGhhVX1mkGxgW/RiL+FisMrA=;
        b=UhhAXsqXUBpeOtzJW/36nJaS9jUosHNFEspyhWelBBDnu4wMTTveApncIh5FK0+LoD
         LmZcxfq7UG/LX4mDAYQNCwYEOzSLGcigpgb2CRtVg4rewJQ6pTlRAuDiFEQm9Fps74SQ
         SyZCVwiHYqWPVxXyOmwDDJAzySn1JcZwdP9qjDZYBRoptEXiLIAk9+ZVGCQc0Zf5wDyo
         j9E2aEnSaW2qewQ9HEdJUiF5Bhe+BqsupOyJmgGjoRrlAKwURxlZc0CEOq6qt9CrL4nN
         bGxP20gLGdZmhqGlNSJ2Sw1WxKtI9UyWZe+CwSYCwpLg+fuYeWhMO5qTBKjoWZ8l/k6v
         /PMA==
X-Forwarded-Encrypted: i=1; AHgh+RqOAIdUINNKVDz7uKrhKLYnF1/s9Cz5uipC+Euq+jwbC6QO30UmZUnxtDwde3Rr4muKAxmtXRzMnsFH@lists.infradead.org
X-Gm-Message-State: AOJu0YwjF3dsmXzZvN14PdFnVlzYoMUFi3sC4hV+vRddiUQ8pzfr12Vn
	gvyzkGQWEtQ97yqfGioqjPKWWE9+PHThgebfaRYoDjRZga9kCnGIXzY=
X-Gm-Gg: AR+sD13wzMkLQnwha6Z9qsSEd+TaC4DUJZkReYYcUTZxXzGSYisCN9UV2BxQjTVyobt
	GBPW696xg7LUbcyZrO1ny68xLyFgdD9NbsvoHF9dig06hGLOr4ScG61vhiCjvGzaHz2i+pqozhL
	Zd+tj6qIGCiOiHa6XbMEyiSQTbTa26WBx7yrEF5Y/fXnsoi+lO6USo/MXDaBc34bGZziVYu57Eq
	7iDpCpjeW3f5roVMkHrPZa7YSKJhaVgmwWYfV53zQmJ5BHuoHSZUCLZpW7rtS5uaN4Rve7OzP6f
	9rkwrhLCSK1mZ6GhUYCfrEcGWZ1LgETjcmBltQegEBdgjWpb/tWS+AvC3HLJwinMR5O6PdwMNne
	Sn4WJAkG/56PcYZlICl5OXXY32zHBu6gx4uYGmOQ0RQTTc3Za7k9JcYVkNyK5DvW3UirpwrNlcD
	4tsY/Ng//vEuvbxOuJhAtXX3KZHs9Xflp2nemJF/mwy23H9R3x1oIIjzeSHAwLKlMmdqBwPLbUB
	EBoj/kvnZFj6eXHOZqgwD1KcmOt
X-Received: by 2002:a17:90b:3b81:b0:38f:5801:cd76 with SMTP id 98e67ed59e1d1-3931dfdd5b1mr3426522a91.3.1786592739933;
        Wed, 12 Aug 2026 20:45:39 -0700 (PDT)
Received: from anuj-MacBookPro ([2406:7400:63:2611:ab4e:433a:b523:233a])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1412d8a973asm3548064c88.1.2026.08.12.20.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 20:45:39 -0700 (PDT)
Date: Thu, 13 Aug 2026 09:15:31 +0530
From: Anuj Gupta <anuj1072538@gmail.com>
To: changfengnan <changfengnan@bytedance.com>
Cc: Keith Busch <kbusch@kernel.org>, axboe@kernel.dk, hch@lst.de, 
	sagi@grimberg.me, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Guzebing <guzebing@bytedance.com>, anuj20.g@samsung.com
Subject: Re: [RESEND RFC PATCH v2] nvme-pci: add adaptive interrupt polling
Message-ID: <mxcthoo4vrlki7smlaqwh64hdyjkuovjrfzsyzdma4ktcrrc4k@g4dph2ouwnbv>
References: <20260806031058.40176-1-changfengnan@bytedance.com>
 <ano6o6i4Yr2JfMgu@kbusch-mbp>
 <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.9f189e7a.e65a.4eb9.b86b.c83b70bebfb9@bytedance.com>
 <anuGRKqdCFG9381L@kbusch-mbp>
 <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.0698c0c0.7344.4eb9.96f0.08703e79ece6@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d9210bcdf73fbe1ac8b6ec132865609a3ed68688.0698c0c0.7344.4eb9.96f0.08703e79ece6@bytedance.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_204541_183628_A2409E14 
X-CRM114-Status: GOOD (  28.87  )
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

On Thu, Aug 13, 2026 at 10:11:19AM +0800, changfengnan wrote:
> 
> > From: "Keith Busch"<kbusch@kernel.org>
> > Date:  Wed, Aug 12, 2026, 04:30
> > Subject:  Re: [RESEND RFC PATCH v2] nvme-pci: add adaptive interrupt polling
> > To: "changfengnan"<changfengnan@bytedance.com>
> > Cc: <axboe@kernel.dk>, <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Guzebing"<guzebing@bytedance.com>
> > On Tue, Aug 11, 2026 at 10:32:35AM +0800, changfengnan wrote:
> > > The code looks much cleaner when using dim, I'll see if I can replace the
> > > sample-and-poll logic I wrote myself with the dim library. 
> > > I ran a quick test on the POC patch and didn't see any performance
> > > improvements; in fact, there were quite a few regressions. Maybe some
> > > parameters need to be adjusted.
> > 
> > Yeah, I'm just now testing mid-tier devices and it's also performing a
> > bit worse for high throughput workloads. But I hadn't really tried to
> > tune the settings here, and maybe my criteria is all wrong. I was mainly
> > trying to see if we can utilize the dim library before honing in on the
> > right implementation details.
> 
> I tried modifying the original approach to use DIM, but the results were
> consistently poor. Using the original approach, my current optimization
> has managed to keep 4K random read backoff within 2% (tested on 10
> different drive models), but when using DIM, the backoff rate is 10–15%.
> I believe there are several reasons for this:
> 1. The core of NVMe adaptive polling is determining when polling is more
> efficient, but DIM cannot answer this question. Although  irq and poll can
> be disguised as a DIM profile, this is essentially just borrowing the DIM
> framework—the core decision-making still requires writing your own baseline,
> thresholds, backoff, and re-baseline, so the code complexity and volume
> haven’t actually decreased. 
> 2. The DIM state machine is relatively heavy, which reduces performance
> gains under I/O-intensive workloads.
> 
> So I tend to avoid using DIM. Please correct me if I'm wrong.

I also had a similar assesment on DIM. Emperically, with Keith's POC
interrupts per IO drop from ~1.0 to ~0.29 but with a small performance
regression (572K -> 557K IOPS). With your original approach they drop to
~0.03 with a 23% performance gain. The DIM machinery overhead maybe
outweighing the partial interrupt reduction.

> 
> > 
> 

