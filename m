Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CB1C433DB
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 21:23:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447EA64ECF
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 21:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447EA64ECF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:To:Subject:Message-ID:Date:From:In-Reply-To:
	References:MIME-Version:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Rrr+gxVucfN5ftnUJg66x0M/ZWjK+B1P27yqnI77Xqc=; b=1V1a+iqOBbv0jXt/QPOc2Np0u
	1/faCddB8SdJDCqrcuPSv80883wgjQCjQofoIsEx94c8+Xn7sGvvF5tbmggWNDbSnLKGGuGviXqts
	Ae+lTDJUEqhMr4Egj18XJIwLykGZogEud9raks21Pc2q/CpGZF9JxV38Gnyj1fG0TNIwzLX8YzBI7
	zAhRYMylS7bKIvKgJOwuDGXOm0+0xvKdEMWpaODu92fKyEj8NvZTb1+DE/9s8/iWNQfgzYEHKP24e
	Q9n+rpxzn+p+7FNGzndri15beI6vK6FFqAFi9LyLFgiK9ATUSoXAN2Bf/wK9SDm5NG3snYNZVgYBu
	/hs9QuXPg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6gf0-0002x1-Kf; Mon, 01 Feb 2021 21:23:02 +0000
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6gey-0002wG-EQ
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 21:23:01 +0000
Received: by mail-oi1-x22f.google.com with SMTP id k142so6016773oib.7
 for <linux-nvme@lists.infradead.org>; Mon, 01 Feb 2021 13:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yOWrw7a+Nf/KygeG78AKIm4KgYP1X9MsGHak8Pcn4zg=;
 b=o5jpmsDsoy2ji8gpSb36ZTjvFoA1b9ZgnxGP7BNO941bOozBAgb85HxfqP7ke9weQZ
 SpK7oyNLgUjJX2fDxDZQDiKj5OnmmA1iQLR9Pql9Y7kN07+suHgVlZpX849oC7jsFT57
 cW0DfuuM2Hw+BuZiiWMrn3sKFp79qYjY1DUgakhu1dQ4GghBwUHxOdFyECtLgJOMYpS7
 W8pMJq1aTdPk1qovkiZBrTCtatjVdjA9o1hN0/ieRYZ0JWHw8Q5D/5SEmXQsU5cXpIOn
 sy0df7yFz7oIgQHyrO6/mHCdDwFjmVgfsBhSFTnEzLu5c/U7EipCXJRYolPbbg8FIuOo
 2P8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yOWrw7a+Nf/KygeG78AKIm4KgYP1X9MsGHak8Pcn4zg=;
 b=Gpc1bndDDXLI2ZCM2QFrE8Go6TmrUBQh65ISTLwQyiLSLc+kFyCELLztE3BGPFKIqN
 XGysuaxOy8IdgD3CeEZodplc6/bpoulvIRJKR8qyiWwesr0zWuz1xQCTJpzfzzcc/BkT
 erFH0K5LgeHlFCK5nmqXLNzEOozSbnCeKWcuOBcFSpeMLSx/I6WCil4LB3DD6V430oqu
 ip3Dr0mRqGveecWDaqD3XjRMrUXvPelF4FqrT1dJp/UcybPbrKrS2Hru2ZfWTacza37u
 X3Jvhthe9oT2Feul1ROEtuw8uzQu9tYnOEQ7vrb+4il0IjvOK8gWm12oCKZPsS3PbjOb
 cZbg==
X-Gm-Message-State: AOAM533z4+PQgvvCkThYonbjKpwqh+JF7c+SfCigbWgh0WsQtEnZQdxI
 tqgBsgRAElXVPKfaX9ls5UzCRDzlEUTH1wb5VZ36+A==
X-Google-Smtp-Source: ABdhPJwLLr7HE/FPtCzHw8vOCiRi6L3hhZDdCNDFos3jTHmz5rAH077nWm3ycDUwLoEjDXEKNGh/LvplLh9wMECNwRg=
X-Received: by 2002:aca:be0b:: with SMTP id o11mr575501oif.42.1612214578188;
 Mon, 01 Feb 2021 13:22:58 -0800 (PST)
MIME-Version: 1.0
References: <20210201183017.3339130-1-jxgao@google.com>
 <20210201183017.3339130-4-jxgao@google.com>
 <20210201205759.GA2128135@dhcp-10-100-145-180.wdc.com>
 <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
In-Reply-To: <CAMGD6P2Gz9nWELMdsAhwQvXx3PXv2aXet=Tn9Rca61obZawfgw@mail.gmail.com>
From: Jianxiong Gao <jxgao@google.com>
Date: Mon, 1 Feb 2021 13:22:45 -0800
Message-ID: <CAMGD6P1_cs1W8jMt7Sz6broDdnFNPrxbiZW-JZ+GAtg5aoTdOQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] Adding device_dma_parameters->offset_preserve_mask
 to NVMe driver.
To: Keith Busch <kbusch@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_162300_535235_F6EA2F15 
X-CRM114-Status: GOOD (  14.58  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: heikki.krogerus@linux.intel.com, sagi@grimberg.me,
 Saravana Kannan <saravanak@google.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Marc Orr <marcorr@google.com>,
 gregkh@linuxfoundation.org, rafael.j.wysocki@intel.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org, axboe@fb.com,
 bgolaszewski@baylibre.com, iommu@lists.linux-foundation.org, jroedel@suse.de,
 Erdem Aktas <erdemaktas@google.com>, dan.j.williams@intel.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 m.szyprowski@samsung.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> Why is this setting being done and undone on each IO? Wouldn't it be
> more efficient to set it once during device initialization?
>
> And more importantly, this isn't thread safe: one CPU may be setting the
> device's dma alignment mask to 0 while another CPU is expecting it to be
> NVME_CTRL_PAGE_SIZE - 1.

 I was having trouble getting the OS booted when setting it once during
 initialization. However when I rebased to the latest rc6 this morning it
 seems to be working with setting the mask on probe. I am still testing out
 and will appreciate any idea what may cause the nvme driver to fail
 with a single mask.
-- 
Jianxiong Gao

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
