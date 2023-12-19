Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864D0C46CCD
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Dec 2023 13:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8tZj8pdDLQnE952YO3Em4AiH6BrmYAqYHmtMDKLc3BQ=; b=YgyJKxGYm89zEHGpO2P2szsapw
	4Guj49f5HpkjRIrJPiqXa110EtfCJjVsU6UTjdyo1mg7mkMIOwvxYc27HIJP4oea7VP6ssUMUXB34
	6aF/59BF/UihTdNjNTCTLzY5idkPzgl4yH8oKAQlKVeMb2ePUsaNC13g7P0ZZ0Xk96U5KxcabSzK6
	5YcPDPEjd9pGpKJRianExIaOu/W4ZfiUysvwQTRnY/W8VS+09+jeb/fizD4OmRNB1zWygP/iRwWz1
	6Ipxkl55fvNjVqrVSnRR27lRaKPeKq0KT4CmW33MsMvkMCj1HpryFa0pI696N9NPaXCGbFMhxytIw
	gZuCC1KQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFaTT-00EEgw-24;
	Tue, 19 Dec 2023 13:49:31 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFaTO-00EEgR-0T
	for linux-nvme@lists.infradead.org;
	Tue, 19 Dec 2023 13:49:29 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d08be5fdbso7964595e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 05:49:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702993764; x=1703598564;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8tZj8pdDLQnE952YO3Em4AiH6BrmYAqYHmtMDKLc3BQ=;
        b=v0F7fwU2idUzJJ4p35+X5wM+DYgRFoOcoBF9QXD/RlEb024CLr+3TuYVVupEhMEKJs
         8UQNwzqIEvbu4HW1cm4oK5X8dg6FELQ8/yiXpfOPdizv3YXHzOeqZbd0+n+EY1h/3tk/
         OIiC9cwVtC4a7bSz0q0PLs5DkJ+FH9oCWXMVk6WGnOhvtRUO+EohJYMTonAcTgWULvHm
         8Hlz0+UUiVv8rwOV/95+6OPNbWpbC1l+5P0+pva6Yq8silx+Tidpg0nsRiwlvQF7LP6S
         9r5okCKAxMWATrdnj27fWKpxYJjlsjVbWmlbeDwGY8ktcGwlMnVdieanwx7hE5xc8Fai
         rRFQ==
X-Gm-Message-State: AOJu0YyRf/Ez6EeOVz8BKVuhpEOMHRCZ7pA20aX5aUpKNirTqUiy5yZf
	BUAQOqrfeJI6KL8zhdSAW3U=
X-Google-Smtp-Source: AGHT+IHOGRZKPIFjKeSeuchu0nQz4Pw85T43tA7noPyb/hi5B7KkXLBPbz5EQKF/3rO7RqMCohFkMw==
X-Received: by 2002:a05:600c:1c1c:b0:40c:24d6:40a0 with SMTP id j28-20020a05600c1c1c00b0040c24d640a0mr22338885wms.3.1702993763893;
        Tue, 19 Dec 2023 05:49:23 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id a8-20020a05600c348800b0040b4b66110csm2972611wmq.22.2023.12.19.05.49.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 05:49:22 -0800 (PST)
Message-ID: <4f3084d3-10ce-49b9-8219-70dbf504cd6a@grimberg.me>
Date: Tue, 19 Dec 2023 15:49:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] driver core: Support asynchronous driver shutdown
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jeremy Allison <jra@samba.org>
Cc: Jeremy Allison <jallison@ciq.com>, tansuresh@google.com,
 linux-nvme@lists.infradead.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, bhelgaas@google.com
References: <20231215000358.1203338-1-jallison@ciq.com>
 <20231215000358.1203338-2-jallison@ciq.com> <20231219053318.GA559@lst.de>
 <ZYE1/xighk0dqjIY@jeremy-HP-Z840-Workstation> <20231219062102.GA1702@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231219062102.GA1702@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_054926_185408_D0C22CBC 
X-CRM114-Status: GOOD (  15.47  )
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



On 12/19/23 08:21, Christoph Hellwig wrote:
> On Mon, Dec 18, 2023 at 10:19:43PM -0800, Jeremy Allison wrote:
>>> Is there any reason to have a separate shutdown_pre method?
>>> Especially with all the method wrapping in the driver core, yet
>>> another method just keeps confusing everyone.
>>
>> Currently in the patch the existence of a shutdown_pre() method
>> for a device causes it to be added to the async_shutdown_list
>> which is walked to reap the completion status after all the
>> calls to shutdown_pre().
>>
>> I could change this so that the existing shutdown() method
>> is always called, and the device is only added to the async_shutdown_list
>> if a shutdown_post() (or as requested below, shutdown_wait())
>> method is defined for the device.
> 
> Yes, that's what I mean.

I think its usually better to separate sync vs async interfaces. However
I assume that the suggested interface exists elsewhere in the kernel, so
its not a big deal.

