Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62F09C4452B
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jul 2026 17:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:Cc:To:Subject:
	Message-ID:Date:From:In-Reply-To:References:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tsGHkYDWUyVUwK6j9CLOUT2+Uosgm0heWC5tQl2SEBo=; b=CHRW1NH14+OUDJeCK1cORnqOPW
	6clBamqXgynzYrtBYcW2WYaGVMZD//flyP9D//huGnu0jNkKTa8n2gNOgkLtd8F+A+iTrwHDzg2FY
	YZlotkmEtESzSTjtcZ+4G52TNZkuOD4As1ms0Lg/QWYt5kjFrZD35tH0DZ6dyWJ6VhEiea17qLSSO
	sQsPBcMy05EzutQ+JodCATWskO789mjYF+SXZFXCCHNCQSpf6WzXzsHz6jo/sAJLYh8f3ERyC14La
	rNUS0/fgjvAMqr5yRYeNuHkZSqbhXo3vgIBg1E+SaWlGGDeP3HcQCsiTWsbE2oL/u3VtAmmV+nbhw
	5i7BnN8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEbK-0000000A6It-3pR5;
	Tue, 21 Jul 2026 17:49:54 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmEbJ-0000000A6IS-06js
	for linux-nvme@lists.infradead.org;
	Tue, 21 Jul 2026 17:49:54 +0000
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-38dd55ad76cso4368070a91.1
        for <linux-nvme@lists.infradead.org>; Tue, 21 Jul 2026 10:49:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784656192; cv=none;
        d=google.com; s=arc-20260327;
        b=UUGzJPwyzrrjoVcF8cd1wL2r8lNQsWd5ihzQ2sqBr5VCW3tVVTeENmLOB4u0sU2sQe
         ++9hAXDJ5qDI/cnT5HmdQrgJro4/c6EwCXjPpgSFSkwMaaQjTUzdZ3Xn28nMRd2CCs0M
         7wk6frn2pasun8VZqAaN76g4qDjdqIuZUXqTrlNzI03a6fTGg3RL4Ee+HDjz980DYDaK
         yP0DEWR6ZFMBQNqnkH6jURPeI+Zn6USz9wxCuouGpq3NSamEhhP4Wh4jYLNEy2vCcvhV
         fSM+MffaMZF216g592A64dRQUkzvrfwWZTgczf2Tq9uNVFg1h8/WwHMyKRzi2X3SOpWC
         LRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=tsGHkYDWUyVUwK6j9CLOUT2+Uosgm0heWC5tQl2SEBo=;
        fh=HzbKq7Fk1gogwJ9XGaZIo+cERPE2qAyt6+lupUGEPZ4=;
        b=nEOeGs7xo3g52gHP0okJqJL1aKh2qLztmyThonHUuZh/KbPxcN0aE9c/YNx1t9qhg1
         5mwA+MWphdoX2uypHFhjYmSB2RVvqG8N5yHTas47HYpn9f8237tv6AnhU7UQx6JyCZrV
         1zWY9AMXjkuOg6pn2Wss0Lz/lZ/HR8uOm/EWLufOZz6R4K4Mv6IoaDOLeV+Xws/j/F9p
         53hhwrHbgWalY6jbp2Ad7eBI3lLdDuWp2HSgdqO+x2eD4urXfTxwi/JCgeOHCH5idMJZ
         Rk6+54Wltugs2h+5JWluS79g33YDAuAATG+g4Z+3dYwBx5EuLwmBxiPatvMcoQFiKBgh
         RU4g==;
        darn=lists.infradead.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784656192; x=1785260992; darn=lists.infradead.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tsGHkYDWUyVUwK6j9CLOUT2+Uosgm0heWC5tQl2SEBo=;
        b=DkR+dD18eUYC6Y2Qz4DFoZ/aSDz6rQrA4/Q72SiEa5eaOXUzQ4/cc6XASoWh5D3WU8
         LMHzfaVwM54e+PayBurgFYD/tPIkxtlTI9gOZDj8MMui6mYHXqM1ARDsCl30YefgCqXH
         q1uqo/mVoTKSioKqs4xAL1QBtO27jdMkArJ/9EQ/6UtSoeAsd3y2LiNQDSCEbFfDK96t
         PIbHLnga4Olkq9uPa+q2EK4ohDMvLDQ1GN1n7nIQ+RjuFHBx62XT+yVaqpWkcHTq1//G
         5mHEuICY4DgrHpDrZgent4iT6AKO9T3CXTGazGkTGRWxtXlyy/adhkKRlGXCp1PPBzft
         LYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784656192; x=1785260992;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tsGHkYDWUyVUwK6j9CLOUT2+Uosgm0heWC5tQl2SEBo=;
        b=jcW0w/EHsnvfHOJOhwSYJv9uspN3Y1yYyGN1ilOCd9zRGAZ/lFhey57sosiwD5VUmx
         s3Sg7CgPVbAUi/c3nRiZFoJAArqbC/U1RAvU3Sxke08F03BJrnYgTCylrQwWHafH0K0K
         kkZ86MLM0pMaoWTtcf69WNmTL5fN6P76A989FQx7ntWqY1JOKK7AHgsUJTjeHDsdlbJi
         2O/4TbnzFl9ibkMJ/IKA38uw2t33+hS7voRR9dCke7Zg4C3vCgmxzKZju7IEyDgO7fDU
         3iOx6BxcvIcd9BukH1ViUnDXHAohMKlE0l0Zn0coljiLDaZJriFE06oZBYJ+VvSKnN6x
         QJZg==
X-Forwarded-Encrypted: i=1; AHgh+RoC6Toh6r/oZNkhSTwEv5DIT2psE3hGypJYUUST/RrVm9Eq30H13HPdSJQC5spPhcX47BbgkCqY6/I1@lists.infradead.org
X-Gm-Message-State: AOJu0YxAkreA6Grn3qBRnGd/mWPHf9SJ4O5rfXBrEhHBYf+FmGXony2t
	oijNEGUiDFyqkzC1EMp7md/ZmQgtJrgcVZ5Wgm/Hl/eMycTkgR29XTpEFDeSaoJKJ4bWYpjyOYn
	hITuK42pRIACmW0/fXtG8h2chLplo6xU786Gwd+Qd
X-Gm-Gg: AR+sD10q3VSuABI7uGA4LKS491FzgPqfs+klr6KbdG/Drihx9+bd3qtXHcxlpYT/06B
	YBvwt8+863zPIByj8vB7UW7/hjw2/5sZDEXOwfkfGeWffxotibBqaifrqXBqvzgBYVVifOheZsl
	XEn7BEiN/Dp6Msj9o8pEn/3sS/BMrHnuwYdjq+lMukc4zp2zOVAjj5xhQg8oyiELrjp0RtWk3Qf
	QHt+nosIG1HciMFXivsLnxv/dwTBji4w7Dmj6X8g9d18iLOtzsKAuOXj9SVF2SElMRr47Rdr+Uu
	s2oJ19g2YubY/W7rQjdleNgc4tj638qFp2xHm3/43D1PEYHB0PYdIQ==
X-Received: by 2002:a17:90b:4c81:b0:380:86d8:8162 with SMTP id
 98e67ed59e1d1-38ea37ddacbmr527514a91.18.1784656191610; Tue, 21 Jul 2026
 10:49:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260719105327.864949-1-mykola@meshstor.io> <20260719105327.864949-2-mykola@meshstor.io>
 <20260720144943.GA17375@lst.de> <CAPzsNDv6hUV3gHdaxuwjRcr4couUKq_M5DKObFNaYqCHnm7ZMw@mail.gmail.com>
 <b2c37f4f-79dd-428f-915a-2a862d20924c@deltatee.com> <cb297ebf-3731-425a-8f48-6be3c7944366@deltatee.com>
In-Reply-To: <cb297ebf-3731-425a-8f48-6be3c7944366@deltatee.com>
From: Mykola Marzhan <mykola@meshstor.io>
Date: Tue, 21 Jul 2026 19:49:39 +0200
X-Gm-Features: AUfX_mzYRDnXZ96aQ_20QUIhDQu3bcp65YEqla-rQQb3UzXkujG9BSCJpITYkqE
Message-ID: <CAPzsNDvKwg1SCDyd2Cf4SVeCMQicUPYRgBmq-0ZN9m6QjQQ74g@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] blk-mq-dma: restore BLK_STS_TARGET for unsupported
 P2P transfers
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Song Liu <song@kernel.org>, 
	Yu Kuai <yukuai@fygo.io>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-block@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Li Nan <magiclinan@didiglobal.com>, 
	Xiao Ni <xiao@kernel.org>, Guoqing Jiang <guoqing.jiang@linux.dev>, 
	Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>, Chaitanya Kulkarni <kch@nvidia.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Shivaji Kant <shivajikant@google.com>, 
	Pranjal Shrivastava <praan@google.com>, Henrique Carvalho <henrique.carvalho@suse.com>, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_104953_089339_DC92AD25 
X-CRM114-Status: UNSURE (   8.44  )
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

Thank you for review!

> (Arguably it might have been clearer if the switch case explicitly
> stated PCI_P2PDMA_MAP_NOT_SUPPORTED instead of relying on the
> default).

Unchanged in v3 to keep the stable backport minimal.

Mykola

