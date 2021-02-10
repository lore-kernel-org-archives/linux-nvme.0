Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F8EC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 22:37:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02DA064EAC
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 22:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02DA064EAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uEvT0lgVPj7E5bPIRxrKp3G8kSjnuCLrCYmVt4IVAQw=; b=aZg5f1WK03PhP/TqoOXC9wS/X
	70FHtqANRNq9ed3upty+cZhcmznKayTmVTGH+v9McDSWphDDjSl4prEFY5OWqtBwmWb2khm//Otpw
	ZX0Jnq4dMHWomejwS9ZT9yL2D3N2bxAc8+TP2ZWGeKZ+T5Xi2+KyjvFduje1ARIAPqenz9kpiCbWl
	RW11LaoxMmgXo51eARallrhk0O7TPenyLFlT9kUoRQfYJO6HqIW9uZlCgJtLd22ZIX8aoknHXts2u
	0eCx+firU3RcD9m43BFY9MLM2zJUcungRmXk7MESlwSPlAqvq58W3Oiha81/YvAsWtjs+v0oydCEe
	SI8mJi4YQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9y6k-0007Ne-OM; Wed, 10 Feb 2021 22:37:14 +0000
Received: from mail-pg1-f180.google.com ([209.85.215.180])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9y6i-0007N2-71
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 22:37:13 +0000
Received: by mail-pg1-f180.google.com with SMTP id m2so2205702pgq.5
 for <linux-nvme@lists.infradead.org>; Wed, 10 Feb 2021 14:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TYaDnSLSaFbiHy0Aui/StZS1EYSVndgP2IS+G3cTqwY=;
 b=k+vow2R5akrX1ZqSx+xwcPe13KMFKlCSlWJas1ZrYRbj013/jrzZCi+WbDZbNIrCzz
 euBBSdcxtIAaEm3ZzPsOZWJLXM4ZgfhbtbIdcOp2nrG9mI1374VB3Km5l1aZILegfFoz
 E+VgCsRFHv1BEhLcP6ONEaCBiZjsrvxMPbDkNv/6jJtLuuFb5OOoAY2oi6LV9C4I7rvv
 ROEFuS1TAl2l7pGbUJlWi3cqX6cksEmPW/dwyZJIfSkNFIRmxVP/du2dkd6hjclgE6OC
 LHGjR55FSzh7E5cOMgbL8WhX/ML1CAqzZssAWiVK2OQqq/Ovb9MDW8LTZMlZ8Zsf1hrd
 ZIZw==
X-Gm-Message-State: AOAM531jmEBMqZ6d3rHNyEoZgUuzaF34AzMbUkM+nVpRnN4fokThHnSJ
 pyQfEAK9rCb+wTsnIwED2iBLE8NyL2g=
X-Google-Smtp-Source: ABdhPJxiHmNmBYLpHj4udTa9dPnlIyQKm8gYd6QjWnDCDVz8RdtWladLgochj4+gWI+ZsyFH3JqOKw==
X-Received: by 2002:a63:4084:: with SMTP id n126mr5126154pga.80.1612996630866; 
 Wed, 10 Feb 2021 14:37:10 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:d52b:e830:d3b2:ec6f?
 ([2601:647:4802:9070:d52b:e830:d3b2:ec6f])
 by smtp.gmail.com with ESMTPSA id j17sm3305655pfh.183.2021.02.10.14.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Feb 2021 14:37:10 -0800 (PST)
Subject: Re: [PATCH 2/2] nvme: don't set iosqes,iocqes for discovery
 controllers
To: Christoph Hellwig <hch@lst.de>
References: <20210209101235.1539917-1-sagi@grimberg.me>
 <20210209101235.1539917-2-sagi@grimberg.me> <20210210101126.GA26624@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3702938a-cfd5-b725-bb75-7c9072a42fde@grimberg.me>
Date: Wed, 10 Feb 2021 14:37:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210210101126.GA26624@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_173712_306462_5345438F 
X-CRM114-Status: GOOD (  13.16  )
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
Cc: Keith Busch <kbusch@kernel.org>, Martin.Belanger@dell.com,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

> So if we change this we break interaction with all old Linux (and maybe
> other?) targets.

Well yes.. Do you think that we should do a retry in case it fails for
backward compatibility?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
