Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884A5C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 08:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=58vRWzDaY9l13t2k5HR5hZENSU0MOTc8Jqkj6M++lDg=; b=a9gTTNTv5H5M4NH5qn1CGGEazS
	JewWLDRjR/8LRb0eQhU3FJ6tvM464AsysZjNhVtGKgBqruI7ygeB6Z8cqMwnPwancMDmIQC1e+dmm
	8Rx+R9mbBn+IrNSSyk4PXcXvIvPOuSqDboZCmJukqp3Le5UZjML7vkcVOqKxWDo2dOHraok74+Gjw
	HgzCAkn9ClSdjfsRc/Z1u009/yu9/27ArH1CLWhzUU+H64EKYnacAJF1H2U4++mGn3IheL7Jc1Hnf
	XqgghEGtTmn3vq9+sKxoF59Wj1BJX5SSTDADZkUAmB5fIkH8VXyYQgUhPpUxjxTJImkROo17kTeJy
	L58FZYcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3vwy-009KFh-Hk; Wed, 22 Jun 2022 08:43:00 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3vwv-009KDN-Rc
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 08:42:59 +0000
Received: by mail-wm1-f49.google.com with SMTP id m32-20020a05600c3b2000b0039756bb41f2so8528018wms.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jun 2022 01:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=58vRWzDaY9l13t2k5HR5hZENSU0MOTc8Jqkj6M++lDg=;
        b=53DxziHIrt0sUpLecp6kw0PiYHzeY0KhD89PEj/sPSDxKWS1uUDLQSpGjN+IRLyuId
         GsXmq7Je/DXnjVoxnwXPK9ZxCi1zhHiPoewKRXnNEfBJ/6pcOL4P1QUxuNtvYHT7KiWI
         bm2Jc8EdbVXyTU7AkmfPO/WQcTrZEpctnP906BUlfQmNRg4bOFyt1X5prNKmGhk8Upo0
         SnkOcCKpZiKH/nFnRJLKyqmiEF37QMg7A9156IlrMxgCvmJF64xF7//ldXkRo77NnGJ8
         aX3c4eBNHmdcpqWN7dN9ze8bPKCWV7W44k+fmvsklR8e1c0ESR3hbBGOVdEUxjju11q1
         GxHg==
X-Gm-Message-State: AOAM531v8861I+UKGk0nu/1ND0VFMSBIvce8SsOa7A1Hr5fo7ncG5OrQ
	W3OJRU+ed0GcgOrvlfTL4Ko=
X-Google-Smtp-Source: ABdhPJxMIgjqrF/KzJcXYyPAWx598OBV1mgl68dUGpykdgCZ6XvvDhielHHGPYsqmmE8L3E8Fk6XZg==
X-Received: by 2002:a05:600c:2157:b0:39a:a4d0:54e1 with SMTP id v23-20020a05600c215700b0039aa4d054e1mr44849784wml.14.1655887375041;
        Wed, 22 Jun 2022 01:42:55 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v11-20020a5d4b0b000000b0020d07d90b71sm17941826wrq.66.2022.06.22.01.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 01:42:54 -0700 (PDT)
Message-ID: <38132a2e-fadc-82ef-64a0-0b27d4c6e67e@grimberg.me>
Date: Wed, 22 Jun 2022 11:42:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv16 00/11] nvme: In-band authentication support
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220621172414.82847-1-hare@suse.de>
 <3c375526-a967-0856-0f8b-da08f21c7d80@grimberg.me>
 <5406f9b5-000e-e543-020e-57de69f00413@suse.de>
 <67f5163d-6c8c-76af-9310-d06213e44d64@grimberg.me>
In-Reply-To: <67f5163d-6c8c-76af-9310-d06213e44d64@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_014257_946610_DCE430C2 
X-CRM114-Status: GOOD (  25.28  )
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



On 6/22/22 11:33, Sagi Grimberg wrote:
> 
>>>> Hi all,
>>>>
>>>> recent updates to the NVMe spec have added definitions for in-band
>>>> authentication, and seeing that it provides some real benefit
>>>> especially for NVMe-TCP here's an attempt to implement it.
>>>>
>>>> Thanks to Nicolai Stange the crypto DH framework has been upgraded
>>>> to provide us with a FFDHE implementation; I've updated the patchset
>>>> to use the ephemeral key generation provided there.
>>>>
>>>> Note that this is just for in-band authentication. Secure
>>>> concatenation (ie starting TLS with the negotiated parameters)
>>>> requires a TLS handshake, which the in-kernel TLS implementation
>>>> does not provide. This is being worked on with a different patchset
>>>> which is still WIP.
>>>>
>>>> The nvme-cli support has already been merged; please use the latest
>>>> nvme-cli git repository to build the most recent version.
>>>>
>>>> A copy of this patchset can be found at
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel
>>>> branch auth.v15
>>>>
>>>> The patchset is being cut against nvme-5.20.
>>>>
>>>> As usual, comments and reviews are welcome.
>>>
>>> Hannes, did you see my panic report on a malformed dhchap_ctrl_key?
>>>
>>> Also, why does the dhchap_ctrl_key not passed when connecting
>>> via discovery?
>>>
>>> I have in the target:
>>> -- 
>>> # grep -r '' /sys/kernel/config/nvmet/hosts/
>>> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f/dhchap_dhgroup:null 
>>>
>>> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f/dhchap_hash:hmac(sha256) 
>>>
>>> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f/dhchap_ctrl_key:DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVN6mFaS7YQOMYhk9zSmlatobqB8C: 
>>>
>>> /sys/kernel/config/nvmet/hosts/nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f/dhchap_key:DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I: 
>>>
>>> -- 
>>>
>>> Then on the host I have:
>>> -- 
>>> # cat /etc/nvme/config.json
>>> [
>>>    {
>>>      "hostnqn": 
>>> "nqn.2014-08.org.nvmexpress:uuid:302ae323-4acd-465d-ace4-3d4102e9d11f",
>>>      "hostid": "14f15c4e-f6cb-434b-90cd-7c1f84f0c194",
>>>      "dhchap_key": 
>>> "DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I:",
>>>      "subsystems": [
>>>        {
>>>          "nqn": "testnqn1",
>>>          "ports": [
>>>            {
>>>              "transport": "tcp",
>>>              "traddr": "192.168.123.1",
>>>              "trsvcid": "8009",
>>>              "dhchap_key": 
>>> "DHHC-1:00:Jc/My1o0qtLCWRp+sHhAVN6mFaS7YQOMYhk9zSmlatobqB8C:"
>>>            }
>>>          ]
>>>        }
>>>      ]
>>>    }
>>> ]
>>> -- 
>>>
>>> And when I do connect-all (i.e. connect via the discovery log page:
>>> -- 
>>> # grep -r '' /sys/class/nvme/nvme1/dhchap*
>>> /sys/class/nvme/nvme1/dhchap_ctrl_secret:none
>>> /sys/class/nvme/nvme1/dhchap_secret:DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I: 
>>>
>>> -- 
>>>
>>> This means that I can corrupt the dhchap_ctrl_key entry in the config
>>> and no one will care (because it is not authenticating the ctrl if
>>> dhchap_ctrl_key is not passed)
>>>
>> Unfortunate design on both ends.
>> It's the host who requests controller authentication.
> 
> Yes.
> 
>> So if the host doesn't request it nothing will happen.
> 
> Correct.
> 
>> But that also means that controller authentication is optional, and so 
>> I didn't feel comfortable to refuse connections for an optional feature.
> 
> If the ctrl authentication is unsuccessful then of course we need to
> fail it. If the host requested the ctrl to authenticate, it needs to be
> successful.
> 
> But I don't think that it explains what I'm seeing.
> 
>>
>> But we can make that a real error, and refuse the 'connect' call if 
>> the controller key is invalid. Might be a better choice after all.
> 
> In my mind it is mandatory, its not really an interpretation thing...
> But I think that if I pass a wrong dhchap_ctrl_key to connect I get
> a failure.

Yes, when I send a valid ctrl dhchap_key, but just wrong, I do get
a failure:
--
# nvme connect -a 192.168.123.1 -t tcp  -s 8009 -n testnqn1 -S 
"DHHC-1:00:QpxVGpctx5J+4SeW2MClUI8rfZO3WdP1llImvsPsx7e3TK+I:" -C 
DHHC-1:00:Ic6ygXy+/+IZQ3jato0k1GbcQWj/pnjo6kmjhbFofQnRHSyg:
no controller found: failed to write to nvme-fabrics device
# dmesg
[63655.518509] nvme nvme0: qid 0: authenticated with hash hmac(sha256) 
dhgroup null
[63655.518514] nvme nvme0: qid 0: controller authentication failed
[63655.519068] nvme nvme0: qid 0: authentication failed
[63655.519103] nvme nvme0: failed to connect queue: 0 ret=401
--

Please have a look into the case I originally mentioned.

