Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B172EC369B2
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Apr 2025 05:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hh3kV57LiDX7manrXAEW9HUCJLEmcGX3IJLDmSlBULk=; b=eZ4+GWrNovmyy02zkRcQSDDPTE
	BQB1CKm/z5PL7Lx2A+alB4QUD2MkmNdyy9OKqxKUIDemF4YRScQj0m01zv6XGO9kqp7SAAk3vWeKf
	HJRD0yGZWEP1mRHqP/c9KccC2jV7M26nyxlZ8DutBLFAqR/3m5vNsSMbb32nAJNhuL+2xAoAD1YsG
	wMDHYJjqmUkZOg/wZ6VXr2L/NE04HUVWjKwG+7ClnHjz0nIpkhLfVn+yNEpCqpVhMOXAvtmRLvgG7
	FPngeS1Py/V0nrThwiK1oonP6sdLifS4H2j8F8AsV2avM8pTKs5dImg6/il2iWIKDUaNjEccXgMo3
	bjIjPYKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5HYQ-0000000BkID-45xn;
	Thu, 17 Apr 2025 05:12:50 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5HYN-0000000BkHX-3ohH
	for linux-nvme@lists.infradead.org;
	Thu, 17 Apr 2025 05:12:49 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-2255003f4c6so4533985ad.0
        for <linux-nvme@lists.infradead.org>; Wed, 16 Apr 2025 22:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1744866767; x=1745471567; darn=lists.infradead.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hh3kV57LiDX7manrXAEW9HUCJLEmcGX3IJLDmSlBULk=;
        b=fnj2gYyoOBqFK1TzGuPnebHOs36a4KWhSR+8V/eYX5dET7vGK8J8lRtmJrQyMFXBQe
         2AOPh/0b7URWzrfJ2qLfmCr2biIUvIfR/PCb6rrTEzjAxYht2IsmgaajbpYIbA8gqJNl
         clQ5PmB+Wk2MD1UMaRhO7/hauCuh448+n5vL7dhYiJQfVELxPMSqxO/HgGRUs/AqT8wP
         yX/lJkjdRnY4i+oerJ7zol2T2HpUZ6kEFWqkIKOqkcvJPIdFXXhC0dgHSSgR64P4eYbd
         wCgxeY+bssSXilmtIyZc3T5YQT8GALmqIN58VbwPNflME/eDrFDr7bZaBXDg+ibTEdMv
         y7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744866767; x=1745471567;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hh3kV57LiDX7manrXAEW9HUCJLEmcGX3IJLDmSlBULk=;
        b=RC370BRSaxVzpJBdQ89Rr14VARt9GgQtyPx2lkUGS+gdl7SWh2Mzx7ptm1NkVyE8Vw
         9L9T7rALY/wN9qWEXcuPPPxHYpB1Zss4eacFy/JJlB5y45yZWgNyTFemrfMG318vZqHW
         WEJuoxMqpdP3TMHNA2hFklvwPkFaJNqwjLtACZ99HK5NnlX8RXZ6kL7W7VuHq/KjK+Fo
         JEIGhOANIk5cDA2iaNPDMatHPQ0+KXDxZzOjSFICRM46iAFZ2kEhiCotX90CHG+jKod8
         m4q8mkoRyUv+JBorS3U9+U7Mc+lcakLJ9lEtMPrdsnoBYZDX9pT933KTRxkALgKVKbps
         8MIA==
X-Forwarded-Encrypted: i=1; AJvYcCUy3rViTQAsYP8zZX4NyzyhOfYVCrmDkWhMqieIUtlDktHcLIDgVObdTJyXpZJaG2oI9cNa4W2oYHGA@lists.infradead.org
X-Gm-Message-State: AOJu0Yxg5fXs7eOYPuWz39u16mmrPI9juk99IO7ISrePSkPZzJ3q5Cwp
	SJJ4N188Do947Lhjfx2fuBoAbFYRA6Hq0hVfbQs6/Rqx268tC/xkoffAT6m9xYo=
X-Gm-Gg: ASbGncuOh/dbu9s9U+OSi1RMJRD2BGPCU1GK1nByaCBSAtVe1DCHMoTJk2VUhHNcNlO
	ZY7w3/8e2IFnjYkqsZkLj7b6YyOUO6NHfhlWxLZ/gjoXbu+uAfq5Bd7SUgfxMB+YA5AZoMCuMFq
	6qPXvn8wsLtdCbzTWVfR6Ffyj1CsL1+/opPhQ88BNh6u22HnDgWqq3ZxJbzdQ5gs9pxIyuNMIBg
	0istJxmYK1xihBYiA1syFtVObOCb3hxF3aDe5oe8eyuYondPvsbt5bGRnssQ+hEt9K9IczGD3Hr
	6gVZYkTbySUjzp3znRPcEADNLE7Tc0l+r3VjbP3FEJzt4Sg/lpDBgcIDaodjgL8saVRW65fThg=
	=
X-Google-Smtp-Source: AGHT+IG+DJ8hFvCH+e3tMNsQubnMI6xLQ0x1LAhdNsGyukov9JTMdxIRePZdTqUQNcjXeFL0RV3m+A==
X-Received: by 2002:a17:903:2ec5:b0:224:18b0:86a0 with SMTP id d9443c01a7336-22c3597ec0amr63501095ad.37.1744866766946;
        Wed, 16 Apr 2025 22:12:46 -0700 (PDT)
Received: from xldev1604-tmpl.dev.purestorage.com ([208.88.159.128])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd21e00e8sm11393282b3a.80.2025.04.16.22.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 22:12:46 -0700 (PDT)
Date: Wed, 16 Apr 2025 23:12:41 -0600
From: Michael Liang <mliang@purestorage.com>
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nvme-tcp: wait socket wmem to drain in queue stop
Message-ID: <20250417051241.b3cnkp5svew3zhud@xldev1604-tmpl.dev.purestorage.com>
References: <20250405054848.3773471-1-mliang@purestorage.com>
 <612d817f-33e1-4e2d-99eb-0ea87e1a958c@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <612d817f-33e1-4e2d-99eb-0ea87e1a958c@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250416_221248_002063_A0A8A0E1 
X-CRM114-Status: GOOD (  14.62  )
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

On Tue, Apr 08, 2025 at 09:00:00PM +0000, Chaitanya Kulkarni wrote:
> On 4/4/25 22:48, Michael Liang wrote:
> > +static void nvme_tcp_stop_queue_wait(struct nvme_tcp_queue *queue)
> > +{
> > +	int timeout = 100;
> > +
> 
> is there a guarantee that above will work for all the setups?
> using configurable timeout values helps creating more generic
> fix, do we need to consider that here ?
The value here primarily reflects the latency between __tcp_transmit_skb()
and the freeing of the skb in the TX completion path. For most scenarios,
100ms should be sufficient. While it's theoretically possible to see higher
latencies, such cases might not be typical or practical for NVMe-TCP (please
correct me if I’m wrong).

That said, I'm open to making this timeout configurable if needed—perhaps
via a module parameter?

> > +	while (timeout > 0) {
> > +		if (!sk_wmem_alloc_get(queue->sock->sk))
> > +			return;
> > +		msleep(2);
> > +		timeout -= 2;
> > +	}
> > +	dev_warn(queue->ctrl->ctrl.device,
> > +		 "qid %d: wait draining sock wmem allocation timeout\n",
> > +		 nvme_tcp_queue_id(queue));
> > +}
> > +
> 
> -ck
> 
> 

Thanks,
Michael

