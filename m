Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D07BC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 10:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EsFQb3/xHn5OHtCI1h6v44vSOdb9xpnBde10jfyqZxA=; b=uW2xriLU27BKo5GspYO4VUXKvu
	wdzvzFRhy3oY1OLCcQQBZc59i5b2B9COxnEeDSx5Ll/YN1pcw7QvHRN8wjHW6lW9fF5XVTISzIfz5
	cuuFwaS8Neaunzkq7veZ6MVGr+hM38uiyOPXzf6QBf/81+nTqyipet+sbJiIvykTXBNLvUDfJ9a9N
	4kpJt7ceZL7jfycFyvonIojGXDF7O7ZnJObTvVsyI5yfS/Lt7c/7LS5XC5OCa24V97/bZeTucDcl7
	mK0BdylIpEZu4JQIyBB6sv6GHhrXdrqIOhSpKUo3lH2bG1P28XydJ0ZKCqjNrBtJ44xrnWcTKh0XS
	pZAZp8Aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3xbq-009u9C-De; Wed, 22 Jun 2022 10:29:18 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3xbg-009u4n-OA
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 10:29:10 +0000
Received: by mail-wm1-f51.google.com with SMTP id e5so8973914wma.0
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jun 2022 03:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EsFQb3/xHn5OHtCI1h6v44vSOdb9xpnBde10jfyqZxA=;
        b=rG4e26/RD6ucNY8LojsiMJoreQHfr2iC1JSVekW//5KYrMJ735jfBYRsBf5vD0+6hB
         MEZe6l1mIMWJvrLa6HFWOTNK2BA/vLZbzpk4SCygZPuTWeVxoNvbjMqESlqS+5s+UMsy
         oP+AIlUgp5UcBfjfcKdD5HjxpYLYBWq/pnQ0DVsvPv1wV/jjklxCF+xGtSshx1OivstY
         3z+hAPtldBwk3n+JkvdCnIauGeXqtuS7lU/4u3sDdiAt9j/gwza2pIZkjcz1mAaHPxgM
         1+9K5zKDHkhl4aOoVY+8pnQi4LfVkGAYMdLo8IBVNkX8K+H506cKePJvdwkBlim7MmDI
         IypQ==
X-Gm-Message-State: AOAM533zEijiKwQeHzFqBnT1rwgXiGdOkz4KBPyg/jSoQ/+/9VtXzFSx
	B5sX9mJMTCbGo3rzXOVGubZi1wKZNTs=
X-Google-Smtp-Source: ABdhPJx6zGiH0M+5pOa30h704SGsjOsKpBYOryMQDXwi5QCKSKyWKTcG0D254WTnzz3udS5h1XVv1Q==
X-Received: by 2002:a05:600c:500d:b0:39c:5890:7cb3 with SMTP id n13-20020a05600c500d00b0039c58907cb3mr45847517wmr.178.1655893747429;
        Wed, 22 Jun 2022 03:29:07 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id b9-20020adff909000000b0021b956da1dcsm5770046wrr.113.2022.06.22.03.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 03:29:07 -0700 (PDT)
Message-ID: <872b4b59-de37-bf29-44a4-9f01ffb8d226@grimberg.me>
Date: Wed, 22 Jun 2022 13:29:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv16 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220621172414.82847-1-hare@suse.de>
 <3c375526-a967-0856-0f8b-da08f21c7d80@grimberg.me>
 <05b8a18b-d052-0f06-c43b-939766d5d5df@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <05b8a18b-d052-0f06-c43b-939766d5d5df@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_032908_823126_32724820 
X-CRM114-Status: GOOD (  21.87  )
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



On 6/22/22 13:03, Hannes Reinecke wrote:
> On 6/21/22 23:22, Sagi Grimberg wrote:
>>
>>> Hi all,
>>>
>>> recent updates to the NVMe spec have added definitions for in-band
>>> authentication, and seeing that it provides some real benefit
>>> especially for NVMe-TCP here's an attempt to implement it.
>>>
>>> Thanks to Nicolai Stange the crypto DH framework has been upgraded
>>> to provide us with a FFDHE implementation; I've updated the patchset
>>> to use the ephemeral key generation provided there.
>>>
>>> Note that this is just for in-band authentication. Secure
>>> concatenation (ie starting TLS with the negotiated parameters)
>>> requires a TLS handshake, which the in-kernel TLS implementation
>>> does not provide. This is being worked on with a different patchset
>>> which is still WIP.
>>>
>>> The nvme-cli support has already been merged; please use the latest
>>> nvme-cli git repository to build the most recent version.
>>>
>>> A copy of this patchset can be found at
>>> git://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel
>>> branch auth.v15
>>>
>>> The patchset is being cut against nvme-5.20.
>>>
>>> As usual, comments and reviews are welcome.
>>
>> Hannes, did you see my panic report on a malformed dhchap_ctrl_key?
>>
>> Also, why does the dhchap_ctrl_key not passed when connecting
>> via discovery?
>>
>> I have in the target:
>> -- 
>> # grep -r '' /sys/kernel/config/nvmet/hosts/
>> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f/dhchap_dhgroup:null 
>>
>> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f/dhchap_hash:hmac(sha256) 
>>
>> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f/dhchap_ctrl_key:DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVN6mFaS7YQOMYhk9zSmlatobqB8C: 
>>
>> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f/dhchap_key:DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I: 
>>
>> -- 
>>
>> Then on the host I have:
>> -- 
>> # cat /etc/nvme/config.json
>> [
>>    {
>>      "hostnqn": 
>> "nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f",
>>      "hostid": "14f15c4e-f6cb-434b-90cd-7c1f84f0c194",
>>      "dhchap_key": 
>> "DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I:",
>>      "subsystems": [
>>        {
>>          "nqn": "testnqn1",
>>          "ports": [
>>            {
>>              "transport": "tcp",
>>              "traddr": "192.168.123.1",
>>              "trsvcid": "8009",
>>              "dhchap_key": 
>> "DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVN6mFaS7YQOMYhk9zSmlatobqB8C:"
>>            }
>>          ]
>>        }
>>      ]
>>    }
>> ]
>> -- 
>>
>> And when I do connect-all (i.e. connect via the discovery log page:
>> -- 
>> # grep -r '' /sys/class/nvme/nvme1/dhchap*
>> /sys/class/nvme/nvme1/dhchap_ctrl_secret:none
>> /sys/class/nvme/nvme1/dhchap_secret:DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I: 
>>
>> -- 
>>
>> This means that I can corrupt the dhchap_ctrl_key entry in the config
>> and no one will care (because it is not authenticating the ctrl if
>> dhchap_ctrl_key is not passed)
>>
>> I think this is something wrong with nvme-cli/libnvme though...
> 
> Using the latest patches (and latest nvme-cli) it works if I specify:
> 
> nvme connect-all -t tcp -a 127.0.0.1 -s 4420 \
>    --hostnqn 
> nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f \
>    --hostid 14f15c4e-f6cb-434b-90cd-7c1f84f0c194 --config config.json

No it doesn't, see my patch in the other thread.

> (You have to specify --config to instruct nvme-cli to use the 
> configuration file)

If the config is in the default path you don't need to pass it.

> We have had some fixes for the config handling recently, so maybe it's 
> enough to update nvme-cli.

It isn't

