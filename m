Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 443BBC77B71
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Apr 2023 10:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6WI0nA37AUp34sTUjy1NIlOnJmsm+QM2pR8okkZqu20=; b=fIL4UBfPLqQQ1bNqz3K4Ru+gM3
	/YUeSBeR2KWF0Wc60wj8AEwW6YuLz0m3+qphUI0y7VeXBbi2ItnKg/WJJvYbzVV8z/PEcEVAp4TXb
	WcpyD3ZVGwzZ04sYOyW7z2B1OkAVJ6Mae6OLZGlv8Tl/Avm0bsBgpQ3e0N8YTii5znP/syuWMwp2z
	h5x85ITlaIg0aBxD6o/JqiJIMQBEhcgWAzmbi2s+wrybV6Rpxc7ftxWCq+O9YeV8UHxLHidBAwNLP
	Mzz+7n1ImbRfBWpbE6A0l+a936obLDraEVPuaRYVfxph50XK+Dj/ZPfeEOBYDBXgvo1zkovA/vJYK
	UXbDxLSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poiKM-001bZv-0s;
	Tue, 18 Apr 2023 10:12:46 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poiKJ-001bZH-0W
	for linux-nvme@lists.infradead.org;
	Tue, 18 Apr 2023 10:12:44 +0000
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-3f167d0cbb7so5800755e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 18 Apr 2023 03:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681812760; x=1684404760;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6WI0nA37AUp34sTUjy1NIlOnJmsm+QM2pR8okkZqu20=;
        b=bgPZWrBO8xlGSq76AmnuPg/y5g+QEP3ZPYfjaAxpTwHljYnJGUi3aUeIu/Y67faenY
         6I34GpcdMcvT00s3Kur0//G3aXUEprZ5bJeBhiiaqbPDDEigbhhPouQGRnQ5PISJns3a
         YNHW7DwzYcsEpHATDJ/feLcyjx3dZR3cXmJNPTCSLhdgAVy8eAyAm8xzf7P0fC6wLZ/P
         WB39PLZfhv26j4b8XhZR2AaUIcnZV3jvhBhDV2u9vx01p/a1m3mvzjx2u68Ic8wof+8/
         lhLNYuELcrbVWthaaVjY3PVsfMca9jzq1zXfRRC+C9XbV1Mf2Ki9ozMgFo4/QHsZ0h2F
         rslg==
X-Gm-Message-State: AAQBX9ffGgXguNDHXoCzMveNE+lWIspnjBxtPqgW5R0VWkJbHITGxpLG
	PKXwF4296bE3LIdciO146Vw=
X-Google-Smtp-Source: AKy350YTDVIUKRtWrSVLFXu8L525ljTg1GyDAY9qN5XohQJESPSBxTCyNQ2XmYjb09rMimH5tOAYyg==
X-Received: by 2002:a05:600c:4f95:b0:3f1:7376:2335 with SMTP id n21-20020a05600c4f9500b003f173762335mr4855498wmq.3.1681812759849;
        Tue, 18 Apr 2023 03:12:39 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j6-20020a05600c1c0600b003f173987ec2sm5560981wms.22.2023.04.18.03.12.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 03:12:39 -0700 (PDT)
Message-ID: <f3c2fd60-b09c-6dd4-86f1-1c1e5b371ff4@grimberg.me>
Date: Tue, 18 Apr 2023 13:12:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 11/18] nvme-tcp: enable TLS handshake upcall
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Chuck Lever <chuck.lever@oracle.com>,
 kernel-tls-handshake@lists.linux.dev
References: <20230417130302.86274-1-hare@suse.de>
 <20230417130302.86274-12-hare@suse.de>
 <msf6bjfbqiaj7s3ejxjwiueg7omvctsjftnux3qfvwadeg2jiq@hawgvoslzjo2>
 <c6ff524b-df91-f0ef-259e-ada0e1623cd5@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c6ff524b-df91-f0ef-259e-ada0e1623cd5@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230418_031243_197020_05E7322A 
X-CRM114-Status: GOOD (  18.76  )
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


>>   --- a/drivers/nvme/host/fabrics.c
>>> +++ b/drivers/nvme/host/fabrics.c
>>> @@ -609,6 +609,7 @@ static const match_table_t opt_tokens = {
>>>       { NVMF_OPT_DISCOVERY,        "discovery"        },
>>>       { NVMF_OPT_DHCHAP_SECRET,    "dhchap_secret=%s"    },
>>>       { NVMF_OPT_DHCHAP_CTRL_SECRET,    "dhchap_ctrl_secret=%s"    },
>>> +    { NVMF_OPT_TLS,            "tls"            },
>>>       { NVMF_OPT_ERR,            NULL            }
>>>   };
>>
>> Coming back to your previous discussion about this. 'tls' is always 
>> announced
>> but not always supported. This renders the unsupported option 
>> filtering added to
>> libnvme useles:
>>
>>    https://github.com/linux-nvme/libnvme/issues/612
>>
>> Let's assume we go ahead with this patch. The user set explicit the 
>> tls option
>> via 'nvme connect ... --tls' and the kernel will return EINVAL, but 
>> userland
>> can't really know what it was and drop --tls and retry again (or print 
>> some
>> useful information). It could be any other parameter provided by the 
>> user.
>>
>> How is userland supposed to do any feature detection?
>>
> And that is a good question.
> I've just removed most of the #ifdef annotations on request from Sagi.
> If we were going with your suggestion I would need to bring them back.
> 
> So, Sagi: What should we do?
> Re-clutter and allow nvme-cli to figure out if TLS is supported?
> And have it always enabled and invent other means for nvme-cli?

I don't understand the issue.

userspace already has a way to know if a feature is supported by reading
the misc device.

