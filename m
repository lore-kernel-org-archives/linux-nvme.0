Return-Path: <SRS0=3eeX=FV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B88C4361B
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Dec 2020 18:51:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0893823118
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Dec 2020 18:51:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0893823118
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=3e7a510G7ZkqtkTWMaIp9FSONOyTWWBCKVdfuYe46Js=; b=OorCD6im0DWdpnnpGDJIyqlsi
	LHGtHmCaIMdpr8lg5UcFsTRXStzPD+z8T/ixfyOEbcTLkjTAE5MfF5kJBBN0PL9iZKHTYycW7JP6P
	c6T6gAx/YqLVBYz+i5P9XuOHcWF5faiVl7bfUxiEVVlltiPTZJIaMK4meiLVYe7lXXlvjrEeQlRvO
	bY9wJiU2OCEqjg5V04h/sBy8g9nHbWSmv6VbTNAI46j+LinQIEIKTmJmIRjzDt6br0CWsyNP3Cl6p
	67fOfAkLT/kZylm96BPwx8CVakLPIJdCtIRBHSB3hKHTCzEphwfiw/QIVGBNNCA0iSErDPGU7ymei
	ZZnVb6PNg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpyNL-0002dz-ED; Thu, 17 Dec 2020 18:51:43 +0000
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpyNJ-0002dO-12
 for linux-nvme@lists.infradead.org; Thu, 17 Dec 2020 18:51:41 +0000
Received: by mail-wm1-x32d.google.com with SMTP id g185so6605444wmf.3
 for <linux-nvme@lists.infradead.org>; Thu, 17 Dec 2020 10:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PqIJU/UiiYdbQyKwDiZYB1eA+uLCOP7hSkA3qwa+zco=;
 b=McD3QmJiKEZC2vyxVD4y7kISfiGNAb5U2+z3LuY4GlGEB/sOXGudnGS95ebu1bjd2e
 ZybYiyV+oUg6OtiKuKLXdm2zCwCDMoms1GBto6HVJvHS4gNqs98AMCaFVMPy5ywHndQ3
 uDhk9g1+zU3md/Bq69wk3b57+MUbRYDQRPoXX1agn8qoR9eduoyhyTcmXadrcRREIBOn
 AkQ3TKl0Sufix48jV79VIllBm0R66u4xtbfZF7hSqprB6tQf01sdCt4jzfB9iaEhenY+
 tjjagr7Hb/4TqoekqIPok5MJhu6nvHTUFLdEJmVQNm31Dbbg0e5bp5IqbZZevmZIKowT
 LYcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PqIJU/UiiYdbQyKwDiZYB1eA+uLCOP7hSkA3qwa+zco=;
 b=XBxRxDIbI3KU4+/2p6aAmA/tcOH0qe5CXIqiREvHygp7ijXUP6QSgUUgJKvyHaLeBq
 xwJkHAlE1F6G9XwJFvzfZjbLDvSylA5jQjsdE8/QEoPP3NJwEFAIlVAxPpjW97DAb+GM
 EMyIborVvJnyC53C6i8lyao3FkNQeP7DTd4rfGFPrZmbL9WH9RP06GLN8R2L1gru7hx9
 /lMEB+AFj3ouGXEIxAXvHbVJ4xlXnYHMapoqOYaPrLD2RO6rbR1kD4CazOnnGyhli1qg
 WbbCDEA2vOq/fTZDycxyn82bIUqXAnz6+wlk1RSJO5OEjU7WYwVeDxZ5WET9dy0ehATP
 IwEg==
X-Gm-Message-State: AOAM5327J7FQzPE+JUuE/52kzPYUl5o/9dTs7Pqwa0VH5W35S4frgnsk
 K6bceBHDSWpzym/nYjlXGpo=
X-Google-Smtp-Source: ABdhPJwvd9Qf99bvDwqHusFUK1jWFZSS0hypNsWzRO4Qx002zrPwHv1FjEMMOcE8taNkkjgcvzYzdw==
X-Received: by 2002:a1c:630b:: with SMTP id x11mr719402wmb.138.1608231098472; 
 Thu, 17 Dec 2020 10:51:38 -0800 (PST)
Received: from [192.168.1.11] ([213.57.108.142])
 by smtp.gmail.com with ESMTPSA id f9sm11279137wrw.81.2020.12.17.10.51.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Dec 2020 10:51:35 -0800 (PST)
Subject: Re: [PATCH v1 net-next 05/15] nvme-tcp: Add DDP offload control path
To: Shai Malin <malin1024@gmail.com>, Boris Pismenny <borisp@mellanox.com>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "saeedm@nvidia.com" <saeedm@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "axboe@fb.com" <axboe@fb.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>,
 "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
 "edumazet@google.com" <edumazet@google.com>
References: <20201207210649.19194-1-borisp@mellanox.com>
 <20201207210649.19194-6-borisp@mellanox.com>
 <PH0PR18MB3845486FF240614CA08E7B4CCCCB0@PH0PR18MB3845.namprd18.prod.outlook.com>
 <0a272589-940c-6488-9cb9-1833400f38b3@gmail.com>
 <CAKKgK4xvS9SeM3NmNKDNe5oFxxfi0m_=iHCXeXX0DGcgzG_BBA@mail.gmail.com>
From: Boris Pismenny <borispismenny@gmail.com>
Message-ID: <c667ccb0-7444-6892-f647-8971d0b0b461@gmail.com>
Date: Thu, 17 Dec 2020 20:51:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <CAKKgK4xvS9SeM3NmNKDNe5oFxxfi0m_=iHCXeXX0DGcgzG_BBA@mail.gmail.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201217_135141_113615_E754835F 
X-CRM114-Status: GOOD (  19.29  )
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
Cc: Yoray Zack <yorayz@mellanox.com>, Ariel Elior <aelior@marvell.com>,
 Ben Ben-Ishay <benishay@mellanox.com>, Michal Kalderon <mkalderon@marvell.com>,
 "boris.pismenny@gmail.com" <boris.pismenny@gmail.com>,
 "yorayz@nvidia.com" <yorayz@nvidia.com>, Shai Malin <smalin@marvell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "benishay@nvidia.com" <benishay@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Or Gerlitz <ogerlitz@mellanox.com>,
 "ogerlitz@nvidia.com" <ogerlitz@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 15/12/2020 15:33, Shai Malin wrote:
> On 12/14/2020 08:38, Boris Pismenny wrote:
>> On 10/12/2020 19:15, Shai Malin wrote:
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c index c0c33320fe65..ef96e4a02bbd 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -14,6 +14,7 @@
>>>  #include <linux/blk-mq.h>
>>>  #include <crypto/hash.h>
>>>  #include <net/busy_poll.h>
>>> +#include <net/tcp_ddp.h>
>>>
>>>  #include "nvme.h"
>>>  #include "fabrics.h"
>>> @@ -62,6 +63,7 @@ enum nvme_tcp_queue_flags {
>>>       NVME_TCP_Q_ALLOCATED    = 0,
>>>       NVME_TCP_Q_LIVE         = 1,
>>>       NVME_TCP_Q_POLLING      = 2,
>>> +     NVME_TCP_Q_OFFLOADS     = 3,
>>>  };
>>>
>>> The same comment from the previous version - we are concerned that perhaps
>>> the generic term "offload" for both the transport type (for the Marvell work)
>>> and for the DDP and CRC offload queue (for the Mellanox work) may be
>>> misleading and confusing to developers and to users.
>>>
>>> As suggested by Sagi, we can call this NVME_TCP_Q_DDP.
>>>
>>
>> While I don't mind changing the naming here. I wonder  why not call the
>> toe you use TOE and not TCP_OFFLOAD, and then offload is free for this?
> 
> Thanks - please do change the name to NVME_TCP_Q_DDP.
> The Marvell nvme-tcp-offload patch series introducing the offloading of both the
> TCP as well as the NVMe/TCP layer, therefore it's not TOE.
> 

Will do.

>>
>> Moreover, the most common use of offload in the kernel is for partial offloads
>> like this one, and not for full offloads (such as toe).
> 
> Because each vendor might implement a different partial offload I
> suggest naming it
> with the specific technique which is used, as was suggested - NVME_TCP_Q_DDP.
> 


IIUC, if TCP/IP is offloaded entirely then it is called TOE. It doesn't matter
than you offload additional stuff (nvme-tcp)



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
