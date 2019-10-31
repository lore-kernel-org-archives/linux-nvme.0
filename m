Return-Path: <SRS0=hE+E=YY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F43CA9EC7
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 02:54:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A71BF2080F
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2019 02:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G2r5uXVp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qz+MgiJR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71BF2080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KPpCWzxYfeLiZmzO1M/WndGg9/bbOG3EruidOceDKgY=; b=G2r5uXVpKUHwQu4Zrz+NG0hur
	FPYAQjKjncmW19n2JkqYiNxhygqolqYc2zfOX7wLSbHiXCOsIg3p3XdtBlJmVeLxu6Tp07bBRwxEo
	uL75oeQ44EwcwlL4UVmOd24rO6+uSyb7c3FPxA/0AmKU+It4B56gAYn4nPZUgb4sboJq6n5ojUoZe
	iiCcgWaUICy6EYxpRa9hzp37e74gdhQYcm8ImQrwq9Yxagsk7mUX1SJj3+YOCpyppAYH1MXRYUZGd
	8nzaZC0EJ6CdnD2J7lh1m3g4JRzxucUUItvBs5ZYBiNOVXqGbihPA6eC1etc8vqLbRYSOsb9QYfwX
	ecxRgiWSQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iQ0bt-0005Ja-Km; Thu, 31 Oct 2019 02:54:53 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iQ0br-0005J5-17
 for linux-nvme@lists.infradead.org; Thu, 31 Oct 2019 02:54:52 +0000
Received: by mail-pf1-x441.google.com with SMTP id c7so3160294pfo.12
 for <linux-nvme@lists.infradead.org>; Wed, 30 Oct 2019 19:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=R0JsaK4f1xEtQSFbcUbhcY9DkK+W7bL2F/GkfdJxzSc=;
 b=Qz+MgiJRm/rzwAsKbUsraO3YsUz8V+lcF4/JjYTi4WgR41qcgdyhb1oQgSLSU9sSiw
 eUHFzaK7qBrbaMyacOf+pnyHvP9+Cuo9sExjxKt9Hs6Czfdzqm0Om3qAuvc6OfQtAg9h
 +/BDYeqgbjksorYsDyA+SYS/WlWhNza5pmMtVoCXoniqa/nRKRlm5Lvm/nN5/7htRUhQ
 d8oVpPONtGPQl9tcOfLYFElxsTo2LrSWV163eH4/H3FdrVE42U0O3x2knSCoPJgHk6VL
 VybJ0Mphzh8IY2lX8CWQc8j8TsmEoDTu7/Pdhnu3IlrEO3sF499cJVTAzo8NMhbg1zFL
 cDUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R0JsaK4f1xEtQSFbcUbhcY9DkK+W7bL2F/GkfdJxzSc=;
 b=CGuu6P/XUN9w7RxTc6tSpCYkXvmuvNQKmQYE2uPafu6fpjW/mv5gZwuozkc1vc+3ad
 HQpe/1xAjy0dRftcZkMePhKUjVjPyXLqF+ut7swAaaZnHSgPsfnOauaEJxf1L6yBc0HT
 vLBGb9YOiANk4R9/zTx70AnQDPPT+RupXBMLSTDDzC5sebRLtRZACZTHuqHZnEqN1Ycs
 uQyzmVWALzR66LmKl1FmpWY002OvqD+jWPPzDhvY8SUXn/KjW2MWjPGye0L1L+/ZbRyb
 +gT4nypegNUmL33vVXpjSAgqYJwLM3jS25PsDoxDbm4VWkIyTbFZRw4qwLklpzhlfxYe
 bv9A==
X-Gm-Message-State: APjAAAWe5WoyQ127fbz9kQPDGtkM+jSWRxaUoEM+tv//75vbCyaQldml
 +6laMxTuuX7LJxdPvTaMn58=
X-Google-Smtp-Source: APXvYqxe7VnkXFg8g+xbspGRNveCtft+qIbKnqnBRnS3ojLwCM8ombIddlnwCvXSy79F0Z/pCclLew==
X-Received: by 2002:a17:90a:aa98:: with SMTP id
 l24mr3562033pjq.96.1572490490330; 
 Wed, 30 Oct 2019 19:54:50 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 ck20sm3573710pjb.5.2019.10.30.19.54.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 30 Oct 2019 19:54:49 -0700 (PDT)
Subject: Re: [PATCH v2] nvme: Add hardware monitoring support
To: Christoph Hellwig <hch@lst.de>, Akinobu Mita <akinobu.mita@gmail.com>
References: <20191029223214.18889-1-linux@roeck-us.net>
 <CAC5umyhc=6yULiLwXu65VDvDk2cBiF0R9O39B-T5ftapJfj0rQ@mail.gmail.com>
 <20191030140511.GA14252@lst.de>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <2931487e-2720-fd42-fda0-e47cf89c90c9@roeck-us.net>
Date: Wed, 30 Oct 2019 19:54:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191030140511.GA14252@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191030_195451_097172_14456783 
X-CRM114-Status: GOOD (  17.54  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Linux PM <linux-pm@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Jens Axboe <axboe@fb.com>, Keith Busch <kbusch@kernel.org>,
 Chris Healy <cphealy@gmail.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 10/30/19 7:05 AM, Christoph Hellwig wrote:
> On Wed, Oct 30, 2019 at 08:16:48PM +0900, Akinobu Mita wrote:
>> The nvme_init_identify() can be called multiple time in nvme ctrl's
>> lifetime (e.g 'nvme reset /dev/nvme*' or suspend/resume paths), so
>> should we need to prevent nvme_hwmon_init() from registering hwmon
>> device more than twice?
>>
>> In the nvme thermal zone patchset[1], thernal zone is registered in
>> nvme_init_identify and unregistered in nvme_stop_ctrl().
> 
> So Guenter said above the thermal subsystem could use the information
> from hwmon as well.  Does this mean this patch would solve your needs
> as well?
> 
Depends on the requirements. Unlike hwmon/iio, we don't have clear
guidelines describing when thermal vs. hwmon would be a better choice.
There is some interconnect between thermal and hwmon, but quite often
it is a one-way street (hwmon devices can easily register thermal
zones, for thermal zone devices it is a bit more difficult to register
associated hwmon devices).

For the most part, peripherals (memory, network devices, video
controllers, real time clocks, etc) are today handled by the hardware
monitoring subsystem. The one notable exception is the ath10k wireless
controller, but even that registers both a thermal device and a hardware
monitoring device. Sometimes peripheral devices tell the hardware
monitoring subsystem that it should also register thermal zones (I
would guess that ath10k doesn't do that because the mechanism didn't
exist back in 2014). On the other side, SoCs typically register
thermal zones and rarely register as hardware monitoring device.

Guenter

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
