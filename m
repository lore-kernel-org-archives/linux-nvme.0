Return-Path: <SRS0=qcAl=45=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB1DC1975A
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 18:50:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF15920663
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Mar 2020 18:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KLp3mGTc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF15920663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=P13dD5qAIM/Hm8JIXX6GyOQLm82KX/X/iK7zzJeCQ+c=; b=KLp3mGTc7/BU7sjpp+S8Ovu3f
	eYXSXMvb6dREQWjJM2YJ82ZUfsFMKT8sBNS9v93NE7Za9wNBm2SCGTd+MU76iNQcnXuvVcjXW5mGf
	FFnRFeUaJZI8v+1uF2GCduUde7BXSSj4naLri9YueVksKjWc1kciYzrYROY7sAb+dbpC4cb6ITqto
	6cLH24T/HpbmvnO+lLfK11ZSkDNCXnvVmM+TxoxSDH5e8vVaEYe60y5CQmnRxlMOXtp0iF9TVbSBo
	xqW/SgvsWtbuAmApygPLn8Bqe++V+8kU/wd3xutw9UDDhcoetmTN0tFtZs7jEFNfZrS8nGECwJHKr
	OpVZvnSPg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jCSuO-00019e-Lv; Thu, 12 Mar 2020 18:50:16 +0000
Received: from mail-pf1-f195.google.com ([209.85.210.195])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jCSuL-00018i-MZ
 for linux-nvme@lists.infradead.org; Thu, 12 Mar 2020 18:50:15 +0000
Received: by mail-pf1-f195.google.com with SMTP id c19so3687580pfo.13
 for <linux-nvme@lists.infradead.org>; Thu, 12 Mar 2020 11:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aVeDcP2GLMR0aX//Ogt1RRYQRRkohGDFdUA0jaq53Qs=;
 b=jA3L9eJRSmb4NtVnW3ZqyTfXpoQuYpmtC3BpM6z2jxtp5gr6arbzxhuFFZXMuTqBqA
 Qk1162II02rZHrM9w1fFN/G3de0iflNoA2KwP/uMVWbqPDlLvAixIcyGT2DF4ytZ+14a
 oSL2nuLQrfPbqjw/Q2KnFxtnbecDcjPb3MsoI2TCFTZjArJwGFy1RAWBbwP1bKzaKKqt
 P+84Fco6XWqvYliUmgU5+OWFKUwkXOyku1AKtqWTgyj+O0KNF5ypcdHmUNCT84b0gqC+
 +Leu8Sx/HChlfs6BtIq8k4rlGXzNnd5fj1cw4yO2jt7apKLGV55iSn80VMhZIBzQZUZn
 pB5g==
X-Gm-Message-State: ANhLgQ2UA+Y0XNefuiFbA0WsbNfKRmqiye72ljiaCArghjbTyXLyBpK9
 tAQXaC++dkYuRtR8rVfsXlU=
X-Google-Smtp-Source: ADFU+vuCg/44F2XOXy+VHNIQVrts09wkHYa7AdbHNYs2LVO56aWT9OJhzkComda6rXurlEMfw0mt0A==
X-Received: by 2002:aa7:8d18:: with SMTP id j24mr7484991pfe.264.1584039010335; 
 Thu, 12 Mar 2020 11:50:10 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:af99:b4cf:6b17:1075?
 ([2601:647:4000:d7:af99:b4cf:6b17:1075])
 by smtp.gmail.com with ESMTPSA id n5sm3465841pfq.35.2020.03.12.11.50.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2020 11:50:09 -0700 (PDT)
Subject: Re: [PATCH v1] asm-generic: Provide generic {get, put}_unaligned_{l, 
 b}e24()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20200312113941.81162-1-andriy.shevchenko@linux.intel.com>
 <efe5daa3-8e37-101a-9203-676be33eb934@acm.org>
 <20200312162507.GF1922688@smile.fi.intel.com>
From: Bart Van Assche <bvanassche@acm.org>
Message-ID: <6d932620-3255-fbd8-7fc8-22e4b3068043@acm.org>
Date: Thu, 12 Mar 2020 11:50:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312162507.GF1922688@smile.fi.intel.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200312_115013_737586_930D2BEB 
X-CRM114-Status: GOOD (  16.80  )
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
Cc: linux-arch@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Arnd Bergmann <arnd@arndb.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Keith Busch <kbusch@kernel.org>, linux-scsi@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 3/12/20 9:25 AM, Andy Shevchenko wrote:
> On Thu, Mar 12, 2020 at 08:18:07AM -0700, Bart Van Assche wrote:
>> On 2020-03-12 04:39, Andy Shevchenko wrote:
>>> There are users in kernel that duplicate {get,put}_unaligned_{l,b}e24()
>>> implementation. Provide generic helpers once for all.
>>
>> Hi Andy,
>>
>> Thanks for having done this work. In case you would not yet have noticed
>> the patch series that I posted some time ago but for which I did not
>> have the time to continue working on it, please take a look at
>> https://lore.kernel.org/lkml/20191028200700.213753-1-bvanassche@acm.org/.
> 
> Can you send a new version?
> 
> Also, consider to use byteshift to avoid this limitation:
> "Only use get_unaligned_be24() if reading p - 1 is allowed."

Sure, I will do that and I will also add you to the Cc-list of the patch 
series.

Thanks,

Bart.


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
