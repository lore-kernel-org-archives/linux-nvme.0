Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F3CECAAD4
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Aug 2022 13:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JbpcG0pFac/dIKIt2+psRiQAYsJAMXYfnXL802Il8TU=; b=HymZl2Bh/dmGHXx7UsCwkw9Sra
	TW7pJtIa7tbh0mbzlIJ5F+Ialjblv/tpAjHECEkjhXiZRDBmReZuq8vJlABHDMkMzYBIhf2XwmvoY
	ghbAKhyAQtDIdNM8LwVccBMzOlIp8iNIhxvxgnGyPLXQ3jEo0dhQwQ5I2U7GrRvyY4J1w2sT0ExZE
	+xzLHTxaEwOE4RGskO/MnFj4Ap4vh3N+lR/lLMi5kc/t2OdV4dVgh60GpG69mRMMJWuDQXXBWH5hi
	0DSkCPXx495KijMFKY8Jlkji+xDg8Kpv542580Mjd4Oc9kwsGWJ69CwyyM05Z1ulOU6CAZ7uKJLFF
	A1Ghb6gg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTNur-006QNH-MH; Wed, 31 Aug 2022 13:38:01 +0000
Received: from mail-wm1-f45.google.com ([209.85.128.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTNuo-006QLc-9Z
	for linux-nvme@lists.infradead.org; Wed, 31 Aug 2022 13:37:59 +0000
Received: by mail-wm1-f45.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so11719924wmk.3
        for <linux-nvme@lists.infradead.org>; Wed, 31 Aug 2022 06:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=JbpcG0pFac/dIKIt2+psRiQAYsJAMXYfnXL802Il8TU=;
        b=dyzjx1ddicoaeaVAaszwLHB/hMB89KA1B6vvjv9kR+9uVJzsnBFLiBRIaW17fkqw3F
         VEgKvlvBWPVfPRT7eu5kyGBkKqwvuvDDA+gx7F/pgQVZFfyerh0RVVA3OYOln8lzcNdA
         iKSKyfS9VEBlahAcCxJe1kjiCEXVBbZ/l5P42Wizs6GOZkEAi5arM0f8W5GfWAOWbmff
         Zltekn8OOrOtXwanC7UKBZRSEqfjt1FW/coYe2mxeAi+r1bComnblpZNFT2/KTqSkiuX
         bfuTUCC6tsaJpxqTikPmJ542EoyIcfZ/kQEbSejk061jsstuQKlvgSGhJOnLky+7C2nw
         fVdA==
X-Gm-Message-State: ACgBeo2FQJG+BwEdFf3O5Uu7wbiZujaJG1MkFikOrSC8hzjcIIgsGudo
	E1CE6+Um2UYcAkNC9PkUb5E=
X-Google-Smtp-Source: AA6agR7iKvfpMfy1pedaKAsrCEt8n5Nc/L2FICfpMiRFgtMLT11fEstkPzyVc7v2qgFzrWLkncjwTw==
X-Received: by 2002:a05:600c:1c19:b0:3a5:a3c7:3800 with SMTP id j25-20020a05600c1c1900b003a5a3c73800mr2106827wms.69.1661953075624;
        Wed, 31 Aug 2022 06:37:55 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id q3-20020adff943000000b0021efc75914esm12328211wrr.79.2022.08.31.06.37.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Aug 2022 06:37:54 -0700 (PDT)
Message-ID: <89aedf1d-ae08-adef-db29-17e5bf85d054@grimberg.me>
Date: Wed, 31 Aug 2022 16:37:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH blktests] nvme/043,044,045: load dh_generic module
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Hannes Reinecke <hare@suse.de>
References: <20220831052729.202997-1-shinichiro.kawasaki@wdc.com>
 <dc677c86-284c-21c2-ff42-ce40a1797613@grimberg.me>
In-Reply-To: <dc677c86-284c-21c2-ff42-ce40a1797613@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220831_063758_353166_60D9ACE4 
X-CRM114-Status: GOOD (  16.16  )
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



On 8/31/22 16:32, Sagi Grimberg wrote:
> 
>> Test cases nvme/043, 044 and 045 use DH group which relies on dh_generic
>> module. When the module is built as a loadable module, the test cases
>> fail since the module is not loaded at test case runs.
>>
>> To avoid the failures, load the dh_generic module at the preparation
>> step of the test cases. Also unload it at test end for clean up.
>>
>> Reported-by: Sagi Grimberg <sagi@grimberg.me>
>> Fixes: 38d7c5e8400f ("nvme/043: test hash and dh group variations for 
>> authenticated connections")
>> Fixes: 63bdf9c16b19 ("nvme/044: test bi-directional authentication")
>> Fixes: 7640176ef7cc ("nvme/045: test re-authentication")
>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Link: 
>> https://lore.kernel.org/linux-block/a5c3c8e7-4b0a-9930-8f90-e534d2a82bdf@grimberg.me/ 
>>
>> ---
>>   tests/nvme/043 | 4 ++++
>>   tests/nvme/044 | 4 ++++
>>   tests/nvme/045 | 4 ++++
>>   3 files changed, 12 insertions(+)
>>
>> diff --git a/tests/nvme/043 b/tests/nvme/043
>> index 381ae75..dbe9d3f 100755
>> --- a/tests/nvme/043
>> +++ b/tests/nvme/043
>> @@ -40,6 +40,8 @@ test() {
>>       _setup_nvmet
>> +    modprobe -q dh_generic
>> +
>>       truncate -s 512M "${file_path}"
>>       _create_nvmet_subsystem "${subsys_name}" "${file_path}"
>> @@ -88,5 +90,7 @@ test() {
>>       rm "${file_path}"
>> +    modprobe -qr dh_generic
> 
> You should not do this, dh_generic might have been
> loaded unrelated to this test, you shouldn't just
> blindly unload it.

btw, even failing with a reasonable error message is fine rather
than loading dh_generic, the problem is that now it will fail the test
in a way that. requires to open the code in order to understand what 
happened.

Perhaps the original commit is better...

