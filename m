Return-Path: <SRS0=rw3x=BR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7C4C433DF
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 17:15:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B364F20748
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Aug 2020 17:15:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="rdYg+xxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B364F20748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aYesGORwIYVs6EkISmbSyL3bH/uVANtegScBgsB9Jns=; b=rdYg+xxRRc+V1Ry7SMfafLdVY
	IWtbHsDP3czLWSctrGZ5yBYWjnagSoLmDVv2PNpuLCZD1Rg6IS4kpn5iIjaDN694D4SVUPBKMhLIC
	zAE9bln3+HTToou5Ta+YIJ3w9pEYE2lyYgk5J/OOsHufz5wMGgrPAwgI8bIg9jSDDWym1mfkr5txc
	FLA1BMMn6EwqOfCUDXtEKhgl4wUq4M9l/CW/BGnK3vizqA60RuZpsb7+2iSEHZYKPuAaihA7IBrks
	ZpK4ThP/LCCHdnaidavfI58RRWAzAZFJ3Eo6ncDAaqToQy/pNd0Zk/5NxgWAr3GnhwqwSyTq7HK46
	wqTvrwV6w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k45xt-0000iB-I3; Fri, 07 Aug 2020 17:15:33 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k45xq-0000hb-Hp
 for linux-nvme@lists.infradead.org; Fri, 07 Aug 2020 17:15:31 +0000
Received: by mail-pj1-f67.google.com with SMTP id l60so1201562pjb.3
 for <linux-nvme@lists.infradead.org>; Fri, 07 Aug 2020 10:15:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mSZBHQoFco6MmpafCg+12XHweWdRqSYtg9yoUgQCrUg=;
 b=fSBKRsHvGWpB895N8TiB6kZ6XX7da0q3Bu0SG6plhm2pDHrqVJc14WAVSRbaylg1av
 bXKtW4hoIXDe2xnAHh51cD1RCMK5Ud1yGsnvlsbFkBWcl1pXA38bad5dxzCQrVTlEzXA
 z+0b0MJIeupFKeDSwJyBlfYhABC46axnwrjpZY1VTgxOHgx0lwoQhtyPsh7inADtQhMQ
 THQJO4QOTNQivN5Hj9dwrZGFdl8M5YSNabtAoIo1t/0gz4OVsraDKSJktW0MyFYKyurt
 Tr0WxgZCjoTCmUarjvGLUWLIiYmL4ot9tgE51KfeDkBEcZ22gkWeS8dhLw4eaKIDfGpD
 KNDA==
X-Gm-Message-State: AOAM531ab0uknWal7CiAHU8Rc8rBML+NbFmzQygiC8kna4qNUItdqBzK
 JRCiAirq3R3u9mEmPH4XXUw=
X-Google-Smtp-Source: ABdhPJy+qRGV6XhNzN6gEhQjVDuBmpBPKZ932w255Rjai0n+mHLkIEbLpMaEvWyzlivpILe2zwzo1Q==
X-Received: by 2002:a17:90a:f416:: with SMTP id
 ch22mr14300270pjb.232.1596820529424; 
 Fri, 07 Aug 2020 10:15:29 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:3dec:a6f0:8cde:ad1c?
 ([2601:647:4802:9070:3dec:a6f0:8cde:ad1c])
 by smtp.gmail.com with ESMTPSA id g10sm13440948pfb.82.2020.08.07.10.15.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Aug 2020 10:15:28 -0700 (PDT)
Subject: Re: [PATCH v2 2/7] nvme: consolidate some nvme-cli utility functions
To: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Omar Sandoval <osandov@osandov.com>
References: <20200806191518.593880-1-sagi@grimberg.me>
 <20200806191518.593880-3-sagi@grimberg.me>
 <BYAPR04MB49654E81437918F224CDD26486490@BYAPR04MB4965.namprd04.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <aef21d09-e31a-de7a-54dc-974c0d65756d@grimberg.me>
Date: Fri, 7 Aug 2020 10:15:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR04MB49654E81437918F224CDD26486490@BYAPR04MB4965.namprd04.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200807_131530_653190_64377DCA 
X-CRM114-Status: GOOD (  17.91  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 8/6/20 7:53 PM, Chaitanya Kulkarni wrote:
> On 8/6/20 12:15, Sagi Grimberg wrote:
>>    
>> @@ -97,6 +97,33 @@ _setup_nvmet() {
>>    	modprobe nvme-loop
>>    }
>>    
>> +_nvme_disconnect_ctrl() {
>> +	local ctrl="$1"
>> +
>> +	nvme disconnect -d ${ctrl}
>> +}
>> +
>> +_nvme_disconnect_subsys() {
>> +	local subsysnqn="$1"
>> +
>> +	nvme disconnect -n ${subsysnqn}
>> +}
>> +
>> +_nvme_connect_subsys() {
>> +	local trtype="$1"
>> +	local subsysnqn="$2"
>> +
>> +	cmd="nvme connect -t ${trtype} -n ${subsysnqn}"
>> +	eval $cmd
>> +}
>> +
>> +_nvme_discover() {
>> +	local trtype="$1"
>> +
>> +	cmd="nvme discover -t ${trtype}"
>> +	eval $cmd
>> +}
>> +
>>    _create_nvmet_port() {
>>    	local trtype="$1"
>>    
>> @@ -206,6 +233,6 @@ _filter_discovery() {
>>    }
>>    
>>    _discovery_genctr() {
>> -	nvme discover -t loop |
>> +	_nvme_discover "loop" |
>>    		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
>>    }
>> -- 2.25.1
> 
> I'm okay with having a wrapper for disconnect but for connect and
> discover command it can have many arguments having a call in the
> test-case might loose the readability.

That's why these has default values.

> The downside is it will need argument count handling in the future
> and makes things not easier when user want to skip certain
> parameters, closest example would be _create_nvmet_ns().
> 
> Also if we are adding wrappers why not move $FULL 2>&1 to avoid
> duplication ?

Not exactly sure what you meant

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
