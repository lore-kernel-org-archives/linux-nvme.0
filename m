Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 976C9C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jun 2022 08:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=STh4DgShCsD98mumtc+U1bpPHHjyMyFzBJhn/B32vD4=; b=S2JieWbR0N1wcd+BTvKDYI6PNG
	VabnPFWw1beWa2Bnc3VRfycWuYIPZ3aSAfnY/sr8U6QtA9bsRFcK8f6DLBUErNg2KhM/3WFYsPkgT
	DnSJuhKBuCkSDOhxyMA4kafM9+Gm7gVOLgFV31DqF0k58hyWX0e5BwUsAMXx+mqRn4QBevBNGw2CY
	rsLBpRFGTumRt+n4Q/qEhITBE2pR9P0q9HbmRQ3mqstDed2iwIX9Pbh+SaxAmoEsGPKy+gjNIxGBn
	MqGq+ArhHSAXJycYPnqaVHY7sO5QwJn+QkPLATHycGlOSsOV81OcTtIczqVEeVIBOfWe99CeYZdRO
	dYFzdd+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3voL-009Gze-5v; Wed, 22 Jun 2022 08:34:05 +0000
Received: from mail-wr1-f44.google.com ([209.85.221.44])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3voH-009Gtn-Gs
	for linux-nvme@lists.infradead.org; Wed, 22 Jun 2022 08:34:03 +0000
Received: by mail-wr1-f44.google.com with SMTP id o8so22325847wro.3
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jun 2022 01:33:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=STh4DgShCsD98mumtc+U1bpPHHjyMyFzBJhn/B32vD4=;
        b=kjVw+St9nPM/QMfdokkYHjR5T7P7LldszoIXf9hAiZ/X9qRE9Eu+sRAMpE/Nr0NG5V
         BAV+os6UeqjqBR5ebuqadFXnEbPsLxfnFTNly7Lr2nOvH3pfUqC1n92emCDMEnF0wGnd
         E03XzxCP3Z+lLg7ZyWXfMmFB3xAP2SMfE5E0w6HaifDV0QL/6wYpQgwzg1oKGv9H5lFi
         Vn4cJ0dXWAVdL9OYOLCwpVCosYyVosGaLlpvrGBq3olOeneTnLExN24/ufAyCGgZ3x+4
         NP/INXrjq/g8NqZIuUMpMsRvaDbKtUyqVtzI8UAcboeitEcX6htbKfk9ubsRs/r4Z3Mx
         zUkQ==
X-Gm-Message-State: AJIora+kH8qrXOmg1sFJe3Am/qC+HSST7TyQPLhEy7ZrHbtKX12ZgTC3
	yyMUO/pqHZfY6ALOILEKcBtezhk+UlE=
X-Google-Smtp-Source: AGRyM1tQ6SBPpdO6MxKLp/DcAWghqJ5Mz6MKENgU7PxDiUlQQosGvwzYU8/K0OtMpRmsTfSKbV7Qsg==
X-Received: by 2002:a05:6000:1542:b0:218:549a:2a8e with SMTP id 2-20020a056000154200b00218549a2a8emr2087045wry.314.1655886830960;
        Wed, 22 Jun 2022 01:33:50 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id r13-20020a5d4e4d000000b0021b96cdf68fsm4448354wrt.97.2022.06.22.01.33.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jun 2022 01:33:50 -0700 (PDT)
Message-ID: <67f5163d-6c8c-76af-9310-d06213e44d64@grimberg.me>
Date: Wed, 22 Jun 2022 11:33:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCHv16 00/11] nvme: In-band authentication support
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20220621172414.82847-1-hare@suse.de>
 <3c375526-a967-0856-0f8b-da08f21c7d80@grimberg.me>
 <5406f9b5-000e-e543-020e-57de69f00413@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <5406f9b5-000e-e543-020e-57de69f00413@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_013401_603161_39953128 
X-CRM114-Status: GOOD (  31.25  )
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
> Unfortunate design on both ends.
> It's the host who requests controller authentication.

Yes.

> So if the host doesn't request it nothing will happen.

Correct.

> But that also means that controller authentication is optional, and so I 
> didn't feel comfortable to refuse connections for an optional feature.

If the ctrl authentication is unsuccessful then of course we need to
fail it. If the host requested the ctrl to authenticate, it needs to be
successful.

But I don't think that it explains what I'm seeing.

> 
> But we can make that a real error, and refuse the 'connect' call if the 
> controller key is invalid. Might be a better choice after all.

In my mind it is mandatory, its not really an interpretation thing...
But I think that if I pass a wrong dhchap_ctrl_key to connect I get
a failure.

> 
> Something like this would help:
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index 53184ac76240..a03f41fa146e 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -842,6 +842,10 @@ int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int 
> qid)
>                  dev_warn(ctrl->device, "qid %d: no key\n", qid);
>                  return -ENOKEY;
>          }
> +       if (ctrl->opts->dhchap_ctrl_secret && !ctrl->ctrl_key) {
> +               dev_warn(ctrl->device, "qid %d: invalid ctrl key\n", qid);
> +               return -ENOKEY;
> +       }
> 
>          mutex_lock(&ctrl->dhchap_auth_mutex);
>          /* Check if the context is already queued */
> 
> 
> Is this what you had in mind?

So you are saying that nvme-cli does pass the ctrl key in the above
case? And even so when I read /sys/class/nvme/nvme1/dhchap_ctrl_secret
I see "none"? I'll clarify, in my test the ctrl dhchap_key is _valid_
and still it behaves like the ctrl dhchap key is ignored...

