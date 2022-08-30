Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BDD0C0502A
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 07:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eNBaPHnxbiQ6yKQoJwWSkcw5860l2H72wMufKuOd9KI=; b=OwOYL0K/wRwyOhEBYUyDlSJeOA
	a3kevsfAlhqAFfujTYisJBrTdM2n6+/6ctWyIuEp0Op2LUXu5lb6FKsI4sYlNtpWhyWQNKcjpk0Ab
	tNUF6dLOMfvuTUl47sToZVKm75NHxdsFHkmEZZLvxSkf0/kPb2uhE0rfrH1FUeu7cotG4lDMQUq/A
	l5We5uqs2fu7kf1YHmYQbnyEXDT1Bb3/zN3esxmXN0B/QJVT31ZJzgLQzadlucNmsVIzVhUZwDQWs
	j13tjd5bIFvL/8FqhjbDbJS+btJeLTLJNnHWstTfKxrlcvQByF+twRF9I11mNt86iKTCN14J1aFTm
	c7CC1M9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSvJG-00Eeju-OF; Tue, 30 Aug 2022 07:05:19 +0000
Received: from mail-wm1-f47.google.com ([209.85.128.47])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSvJB-00Eehx-Gz
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 07:05:15 +0000
Received: by mail-wm1-f47.google.com with SMTP id r204-20020a1c44d5000000b003a84b160addso1283425wma.2
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 00:05:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=eNBaPHnxbiQ6yKQoJwWSkcw5860l2H72wMufKuOd9KI=;
        b=oEKIE5aESZouTE6GjhtYrYG68n7+024FQdTR+NmhFuN9sC14jx8l5SV/EnJMyOmqoN
         9xIZCms2XypbaE/KIr8IAZ9KYXzb7WEaO0RoaFYYODWCztniWEksJbkTUdvtruTJY2VS
         IFmY/HfXBBfw/KaAa+AoDUBCg6P1zSutEamXyvb6jyrTObHQNusrLdh3oH6GkYXS9oeZ
         oX/xNJTaJizziWaEGH5CqeRxrqJiCjiGrRE2gjL4Jh42WWcLjVPjlWLLr5YyR+hFM9F1
         BVu3lVsQo9/sq+ilP5akVZ8TFsjS3A2l75j8AMxwKQn3exlvFkygV1ULvZvhf701zX7g
         hHdg==
X-Gm-Message-State: ACgBeo2ceRnu3k002pfHrZZk1w4culKX+Nxrj/gkXrHphgNlNS47WPcO
	Cp7CFt+y8t0HivpGzXMlaC0=
X-Google-Smtp-Source: AA6agR6lHUqstw27OUXRK7iEnBGRYQGYcDOzbqhUTllFwM/N9l93JWBOLZqGtYBKU2JBwVjKKjcxew==
X-Received: by 2002:a05:600c:1e08:b0:3a8:39bc:d416 with SMTP id ay8-20020a05600c1e0800b003a839bcd416mr7986143wmb.202.1661843110972;
        Tue, 30 Aug 2022 00:05:10 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id v14-20020a5d43ce000000b00226d1b81b45sm9778835wrr.27.2022.08.30.00.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 00:05:10 -0700 (PDT)
Message-ID: <05548286-8d18-e3b4-06db-640c9d6b1399@grimberg.me>
Date: Tue, 30 Aug 2022 10:05:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests] nvme: add dh module requirement for tests that
 involve dh groups
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Hannes Reinecke <hare@suse.de>
References: <20220829083614.874878-1-sagi@grimberg.me>
 <20220830044632.j7k45lhdlyvksrxh@shindev>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220830044632.j7k45lhdlyvksrxh@shindev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_000514_179334_1B2E1811 
X-CRM114-Status: GOOD (  11.65  )
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


> Hi Sagi,
> 
> On Aug 29, 2022 / 11:36, Sagi Grimberg wrote:
>> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>> ---
>>   tests/nvme/043 | 1 +
>>   tests/nvme/044 | 1 +
>>   tests/nvme/045 | 1 +
>>   3 files changed, 3 insertions(+)
>>
>> diff --git a/tests/nvme/043 b/tests/nvme/043
>> index 381ae755f140..87273e5b414d 100755
>> --- a/tests/nvme/043
>> +++ b/tests/nvme/043
>> @@ -16,6 +16,7 @@ requires() {
>>   	_have_kernel_option NVME_TARGET_AUTH
>>   	_require_nvme_trtype_is_fabrics
>>   	_require_nvme_cli_auth
>> +	_have_driver dh_generic
>>   }
> 
> Do you see failure without this check?

Yes, if dh_generic is built as a module (CONFIG_CRYPTO_DH=m).

