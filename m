Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A8F2C6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 08:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b8rP1ZYW1+4UGw2AGBpTb97ika+944ELYP16pHdrYj0=; b=zq7awf/D6e36yP0jyc8ZXoxYKk
	cFI9eyFCtVWsrmSNzF06s12p+0AxwIvxJPSMcifQrgsh6+hBtAihsTqyUiE0ZS2UqTQlVirWpUMI/
	L2PhKjgfDp5FxFIWU0CKWk07VQ3F/aArEJS3hOfehwPolrz02rmFppiE7+bdbDcu80fQWHoiz5JnT
	yPzQ6PAiwW4IJJ4MrVha2BVNgmWfifXSHZmGTE8q31Oq2myPVQjjgrViEkBgJGc0SRxtW0iRJmqE8
	6c1S3C+QtLoN2Ised7gT+thEXC5qqWgBVfqIOjVnb5UFweRwDVzytw7SLgGCYvBUpxZbmBG5sDzQy
	lhbkJIQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHeK-00EBDB-5S; Thu, 22 Sep 2022 08:33:36 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHeH-00EBCS-Eb
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 08:33:34 +0000
Received: by mail-wr1-f44.google.com with SMTP id bq9so14322057wrb.4
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 01:33:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=b8rP1ZYW1+4UGw2AGBpTb97ika+944ELYP16pHdrYj0=;
        b=h6OY9ENKJ3daZxzKb1Tg0/KBHDEloeycPYJxKGtOTA9nCZKDfHNYnZ4wkaQ+ziGLH0
         QWJAzjHUseLcsU/kr4QgYXTHESKuz67BBIhDYTKPZ52NtP24SvRqJ1ubU/S1WiqT+oIU
         KE2SwZV3/lVcIsRMU9m3HRgCVpjGdcj8Rmyce258jAGuE1SRXq72/x1BnorZgr/ItPbb
         gLg9wsR6XjpRPL5UYl4NeF36DyXKkL4VsSFvNnfd5ac7G7kcLYVDzklhpfCRj3wiJRxh
         avlpn8paaQx4GHHyyK0WeOXiNXsAk9uDeU9YZxwu334fT1R+3QhmSdpAPsQ1iXNn7hcJ
         uGag==
X-Gm-Message-State: ACrzQf2XSnxopfAJUmO/HMmBJHnvF4AaWo/lMlVKt323zqjodqhk+3zP
	Pn8uxBWCTQA8V1JMKjVkz6I=
X-Google-Smtp-Source: AMsMyM5zYx5hUWVkmDNYQnWOOavJX2an4I1cSebaBcFZiNOFgILHGqxDIPguX/ckaPoKF2EwJcFJlQ==
X-Received: by 2002:adf:bc13:0:b0:228:6d28:d2cb with SMTP id s19-20020adfbc13000000b002286d28d2cbmr1200015wrg.375.1663835612153;
        Thu, 22 Sep 2022 01:33:32 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c3b0700b003a2f2bb72d5sm6715426wms.45.2022.09.22.01.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 01:33:31 -0700 (PDT)
Message-ID: <8148f20a-5d08-6425-8a95-1e310d5e2079@grimberg.me>
Date: Thu, 22 Sep 2022 11:33:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/2] nvme: send a rediscover uevent when a persistent
 discovery controller reconnects
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, James Smart <james.smart@broadcom.com>
References: <20220922081538.13364-1-sagi@grimberg.me>
 <20220922081538.13364-3-sagi@grimberg.me>
 <20220922083024.rk2igxroroqextzc@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220922083024.rk2igxroroqextzc@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_013333_513561_BB320926 
X-CRM114-Status: GOOD (  15.29  )
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


>> When a discovery controller is disconnected, no AENs will arrive to
>> notify the host about discovery log change events.
>>
>> In order to solve this, send a uevent notification when a
>> persistent discovery controller reconnects. We add a new ctrl
>> flag NVME_CTRL_STARTED_ONCE that will be set on the first
>> start, and consecutive calls will find it set, and send the
>> event to userspace if the controller is a discovery controller.
>>
>> Upon the event reception, userspace will re-read the discovery
>> log page and will act upon changes as it sees fit.
>>
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   drivers/nvme/host/core.c | 10 ++++++++++
>>   drivers/nvme/host/nvme.h |  1 +
>>   2 files changed, 11 insertions(+)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 70ebf27ad10e..07a21e0b9cf7 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -4822,6 +4822,16 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
> 
> Stupid question: nvme_start_ctrl() is obviously also used in pci.c. Is
> it expected that a PCI device also sends out the rediscover event?

It won't pass the nvme_discovery_ctrl test.

