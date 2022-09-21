Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579A8C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Sep 2022 08:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=h89hG5JRFoI68cGC9Lyky24iH9
	MQ4AyBLzdnbCqRFKT0GES1rDRhxN7+ombXlE5Wx2FT/0lz72Edi3PvmrlnTlfoOx7LlqSKszEBVdW
	T8Rxth6hKxuZXy0iJ1IcZ4bHncu4k6N2RZjFCdv0jhpXMOj1HfPmsXiaoO4LXcbSNfqL8/pHcL6k4
	AuEZHhPd0hfI5SJnWmhAAyDvK6bzY7rgRng1mN/DEQvYhIj3LD3fYeHn1PJM/U19QIKslyWjgsk1o
	QU3B6YhYx3leZQPm2MJf0ZJapcJiPEe7sbfmJYUwClEPzplSRSz6Sd0Hr/Sl7UFU++hhibV0HWaMD
	XKXvl29Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oav4A-009wjG-Oa; Wed, 21 Sep 2022 08:26:46 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oauxf-009tTX-FN
	for linux-nvme@lists.infradead.org; Wed, 21 Sep 2022 08:20:04 +0000
Received: by mail-wm1-f43.google.com with SMTP id r133-20020a1c448b000000b003b494ffc00bso8000513wma.0
        for <linux-nvme@lists.infradead.org>; Wed, 21 Sep 2022 01:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=uH6YG20w5u8tfZq7AsAVMj2S/GSm2Drwe0q+teQwOSR3ziBDFxWMhBuPb/BZMedoal
         NvGUx+Jh9ZfkcOXcDpIMq2H1u1QFWRoKxUignw0/P6ust17wjYm4wR4HbBgyDLhybnK0
         2Oimg4Ah/Hm+ldivbXIuVyXsJz/IgGpEnt0dZguOUuL+Y3eJVDv7FcD/bjap71BulV8q
         K3MXrM1kQpxoPaAm0F4KnXcXDzPaaLwAUQQixacs+80kC0P0+W8elAJeApsGJ7beEe8u
         ZU6jEJ5QH5CyNpJDjqZPWNdXYzX1LxPy/9rkdhYo7n+MZiyqhRZcGTRqqlWKhA/qvzcV
         1xhw==
X-Gm-Message-State: ACrzQf0+7pbSIGrM+26iw03WtbwaC9gh5JXHUGVTG8URI9DQtCfxzivu
	Vpfu9SbcpUuB/q2XvwmAfhk=
X-Google-Smtp-Source: AMsMyM4h2zDGt+vn6AyQun4HJyW6Y2Lle3mR8TTxYwuuTQR/tT1arlqDqTS/ivATS5t+r4sPlCQUFA==
X-Received: by 2002:a05:600c:46c6:b0:3b4:cad4:7d3e with SMTP id q6-20020a05600c46c600b003b4cad47d3emr5096775wmo.78.1663748400152;
        Wed, 21 Sep 2022 01:20:00 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id q16-20020adff510000000b00228c375d81bsm1991026wro.2.2022.09.21.01.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 01:19:59 -0700 (PDT)
Message-ID: <7b092d84-f92a-cfde-9ddc-a6ab03a507dd@grimberg.me>
Date: Wed, 21 Sep 2022 11:19:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCHv2] nvme: handle effects after freeing the request
Content-Language: en-US
To: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org, hch@lst.de
Cc: Keith Busch <kbusch@kernel.org>,
 Jonathan Derrick <Jonathan.Derrick@solidigm.com>
References: <20220919193646.1599162-1-kbusch@fb.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220919193646.1599162-1-kbusch@fb.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220921_012003_536628_AA74BF4A 
X-CRM114-Status: UNSURE (   5.90  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

