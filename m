Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FB3EB64DD
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 10:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1U107HDGRsnh6fdBS2dCkA5s3quKWrB4L5clKKz8Y48=; b=OY0/FQTGHfENDSFN/aLQZbWUEB
	0YOAL6eCq4FmGkzs9CHDQzPiP1FsB1ohg9d+r8f12m4b/+TU5+fvi/JFA+fhEFjYXC5Bgcn5tS7jd
	6tB/tn2P8wCoYfRtZic9bxNjO54pXZ8+U3VmMbBptcOn5X+XSqZt7l2NR11cfhVAfJ4b65PBvM1rt
	u+ojs00/IQYsNTThe+ya1zz5YF6374YJW8/HINk9QqWY2DlAVKue1jKiWYAczjUAlzoV54fqvav06
	xVdnKiiFyahYP59Lfz9+CGizK9k/2Bctg19ObZp3GPH2o4J6v338IHVY9SlYVSv0ARML5MnFx9t/L
	1GNvTisw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWaRD-006AeO-0C;
	Thu, 17 Aug 2023 10:41:11 +0000
Received: from mail-ed1-f42.google.com ([209.85.208.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWaR9-006AaN-3B
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 10:41:09 +0000
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-525691843d1so1242990a12.0
        for <linux-nvme@lists.infradead.org>; Thu, 17 Aug 2023 03:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692268865; x=1692873665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1U107HDGRsnh6fdBS2dCkA5s3quKWrB4L5clKKz8Y48=;
        b=OvTZsOXi8Mp+RiyL3go4w3GDHApUgLvch6VRL0I0ezC+H5uA6enakDMnlnaxZkwyzI
         cR8ycr84X1StZmyccL8gVzuReGnJ+pQM4KEYh7ETW084IsskpuvkT32pjFbFLgVe4NtT
         B6hYQWHAtUtyi352jrGczxqAQvTtGZ6VQA7OJ24kX5Dvtj9VOfhxOuWEgrSuyTtbAmVO
         UtglJjQKvnInWmLPA+CYZPCAjO+NnLbSAsNkCph9RuMNlTaW/eTjSw14i3AvT5RZ4Yz3
         4KtssdcowHsq1YkbA8USqozOlPotMC3MrSwD8lSR9xeqhDS4grUKgwQDbqpZmn+i6v2/
         ZKvg==
X-Gm-Message-State: AOJu0YyS9NrtHVwyXkco8sAuXwrJlg1j8yyhg60DS8vgnIpwJjVpFS4P
	RdbvcEbE7gmCJ2RaH8TG62M=
X-Google-Smtp-Source: AGHT+IEEcEG8xciklrkTtRDf013vKDyTeBMMfVJwWYnTLSpQ12iIDmmG1BPA1bQl4oRaikbABWmHdw==
X-Received: by 2002:a05:6402:350a:b0:523:2e64:122b with SMTP id b10-20020a056402350a00b005232e64122bmr3589269edd.3.1692268864434;
        Thu, 17 Aug 2023 03:41:04 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c23-20020a056402121700b00523653295f9sm9549069edw.94.2023.08.17.03.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 03:41:03 -0700 (PDT)
Message-ID: <615aaad8-b216-ceaa-1553-d283a3c4531b@grimberg.me>
Date: Thu, 17 Aug 2023 13:41:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 11/18] nvme-fabrics: parse options 'keyring' and 'tls_key'
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20230816120608.37135-1-hare@suse.de>
 <20230816120608.37135-12-hare@suse.de>
 <f250deb1-90d9-f9c4-667f-9e6ad580cb6b@grimberg.me>
 <b460dc0c-3254-0c97-557b-3cf42041c247@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <b460dc0c-3254-0c97-557b-3cf42041c247@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_034108_024258_14594F54 
X-CRM114-Status: GOOD (  16.56  )
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


>>> +        case NVMF_OPT_KEYRING:
>>> +            if (match_int(args, &key_id) || key_id <= 0) {
>>> +                ret = -EINVAL;
>>> +                goto out;
>>> +            }
>>> +            key = nvmf_parse_key(key_id, "Keyring");
>>> +            if (IS_ERR(key)) {
>>> +                ret = PTR_ERR(key);
>>> +                goto out;
>>> +            }
>>> +            key_put(opts->keyring);
>>
>> Don't understand how keyring/tls_key are pre-populated though...
>>
> They are not. But they might, as there's nothing in the code preventing 
> the user to specify 'keyring' or 'tls_key' several times.
> I can make it one-shot and error out if they are already populated, but
> really haven't seen the need.

OK, now I understand. its fine.

> 
>>> +            opts->keyring = key;
>>> +            break;
>>> +        case NVMF_OPT_TLS_KEY:
>>> +            if (match_int(args, &key_id) || key_id <= 0) {
>>> +                ret = -EINVAL;
>>> +                goto out;
>>> +            }
>>> +            key = nvmf_parse_key(key_id, "Key");
>>> +            if (IS_ERR(key)) {
>>> +                ret = PTR_ERR(key);
>>> +                goto out;
>>> +            }
>>> +            key_put(opts->tls_key);
>>> +            opts->tls_key = key;
>>> +            break;
>>>           case NVMF_OPT_DISCOVERY:
>>>               opts->discovery_nqn = true;
>>>               break;
>>> @@ -1168,6 +1216,8 @@ static int nvmf_check_allowed_opts(struct 
>>> nvmf_ctrl_options *opts,
>>>   void nvmf_free_options(struct nvmf_ctrl_options *opts)
>>>   {
>>>       nvmf_host_put(opts->host);
>>> +    key_put(opts->keyring);
>>> +    key_put(opts->tls_key);
>>>       kfree(opts->transport);
>>>       kfree(opts->traddr);
>>>       kfree(opts->trsvcid);
>>> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
>>> index dac17c3fee26..fbaee5a7be19 100644
>>> --- a/drivers/nvme/host/fabrics.h
>>> +++ b/drivers/nvme/host/fabrics.h
>>> @@ -71,6 +71,8 @@ enum {
>>>       NVMF_OPT_DHCHAP_SECRET    = 1 << 23,
>>>       NVMF_OPT_DHCHAP_CTRL_SECRET = 1 << 24,
>>>       NVMF_OPT_TLS        = 1 << 25,
>>> +    NVMF_OPT_KEYRING    = 1 << 26,
>>> +    NVMF_OPT_TLS_KEY    = 1 << 27,
>>>   };
>>>   /**
>>> @@ -103,6 +105,8 @@ enum {
>>>    * @dhchap_secret: DH-HMAC-CHAP secret
>>>    * @dhchap_ctrl_secret: DH-HMAC-CHAP controller secret for 
>>> bi-directional
>>>    *              authentication
>>> + * @keyring:    Keyring to use for key lookups
>>> + * @tls_key:    TLS key for encrypted connections (TCP)
>>>    * @tls:        Start TLS encrypted connections (TCP)
>>>    * @disable_sqflow: disable controller sq flow control
>>>    * @hdr_digest: generate/verify header digest (TCP)
>>> @@ -130,6 +134,8 @@ struct nvmf_ctrl_options {
>>>       struct nvmf_host    *host;
>>>       char            *dhchap_secret;
>>>       char            *dhchap_ctrl_secret;
>>> +    struct key        *keyring;
>>> +    struct key        *tls_key;
>>>       bool            tls;
>>>       bool            disable_sqflow;
>>>       bool            hdr_digest;
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index ef9cf8c7a113..f48797fcc4ee 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -1589,6 +1589,8 @@ static int nvme_tcp_start_tls(struct nvme_ctrl 
>>> *nctrl,
>>>       dev_dbg(nctrl->device, "queue %d: start TLS with key %x\n",
>>>           qid, pskid);
>>> +    if (nctrl->opts->keyring)
>>> +        keyring = key_serial(nctrl->opts->keyring);
>>
>> Maybe populate opts->keyring with nvme_keyring_id() to begin
>> with and then you don't need this?
>>
> We could; one would lose the distinction between 'not specified' and
> 'specified with the defaul keyring', but one could argue whether that
> brings any benefit.

Not sure I understand.
What exactly is the distinction and how is it manifested?

