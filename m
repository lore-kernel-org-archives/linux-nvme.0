Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF23C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 21 May 2022 20:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+E2KNUTZjApgDa8mJH/kaCqOvK4XPH45C3Kl0hrSq8U=; b=kZs4jo6z44Z5bAeCDUZXW0lRTh
	76dJRla6XfjYcMRQWJLfAr8qL85cfHRJRoOPW1HqEKi8mpHokdqK6P8uM0VjMs3u072DOCgthG2et
	Q5EVD3v85+dYjgRMU1JPiamXKLonEOzBpzehQaXte+vTMJ0UIMzOxe/nAt52kdY9rGHxJBZhbbrXJ
	GvsIyQu1UTW1Q30Pbdu0DlVAVQlumVm1iL8AgOY0mvx2noZ/NLZ/u1PBEVyTmFgnRKASIgFg2CuZf
	iPIS9uCtV6clN2+9yqKqx7VC1vdQr9vp/9XnelzqndURspcyNsqVDQU2EwT9qnuMtP7U9eShThqt+
	VRMUIYHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nsVIq-00HNVc-5O; Sat, 21 May 2022 20:02:20 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nsVIn-00HNUy-Hd
 for linux-nvme@lists.infradead.org; Sat, 21 May 2022 20:02:18 +0000
Received: by mail-wm1-f46.google.com with SMTP id
 r9-20020a1c4409000000b00397345f2c6fso3909813wma.4
 for <linux-nvme@lists.infradead.org>; Sat, 21 May 2022 13:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=+E2KNUTZjApgDa8mJH/kaCqOvK4XPH45C3Kl0hrSq8U=;
 b=y9ZyoW8USHJmEwZSX7TboCVdRpWrV4BzSb+/hKzuGZI5egeESUwyzR65HnQMSHg4K1
 dbY6bGe7LwTrukUDgHtoc1QYv4zRstkDdZg+dZh/ABVxuQBfGg6Mp4sHALD48yMYvBwM
 6Kq7wUNahVWXWB5XsjJA5w5dPChiIRhNtmZZzS8fDPeWZ6CrFAq43PrvRh9twy/8YKlk
 IrLepFKvUgQ45WmliFrmc1Ygp+MTO0cdaFAMGZYFrVG6wCa/SL/lQ6HNZ8jwxFi2hSR5
 QR/lIDynL3/Vr0BjCMdRPSObkRaDisyy5eDnHDehAxu7DMAu6JfbzzYkST6UUkQXWD4f
 I24w==
X-Gm-Message-State: AOAM531zTjy25GSVbcL/CjHhC8aDgKL05UvU7K/+kZ5YNd28wkNy0gCf
 mw3YyI1h+JyuyUHIZc1+IxE=
X-Google-Smtp-Source: ABdhPJzkaYwpTceoPEHDgCor54jAORKGpDEgyDUUX4e48sHMCDqlcu80uNHu2ZO7kDCx6xcCBCGP1Q==
X-Received: by 2002:a1c:f717:0:b0:396:f89f:897c with SMTP id
 v23-20020a1cf717000000b00396f89f897cmr13172418wmh.165.1653163335620; 
 Sat, 21 May 2022 13:02:15 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il.
 [46.117.125.14]) by smtp.gmail.com with ESMTPSA id
 u22-20020adfa196000000b0020c5253d8dcsm6012212wru.40.2022.05.21.13.02.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 May 2022 13:02:15 -0700 (PDT)
Message-ID: <4ced278f-57a3-5e2d-3365-f660c129b3b1@grimberg.me>
Date: Sat, 21 May 2022 23:02:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/3] nvme-tcp: send quota for nvme_tcp_send_all()
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Daniel Wagner <dwagner@suse.de>
References: <20220519062617.39715-1-hare@suse.de>
 <20220519062617.39715-4-hare@suse.de>
 <6c685c87-519e-68a1-bce8-8ac69929adb7@grimberg.me>
 <86bde5aa-aa48-3aa8-f47e-6f2e7ab1ac7a@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <86bde5aa-aa48-3aa8-f47e-6f2e7ab1ac7a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220521_130217_621128_BBE6C8F5 
X-CRM114-Status: GOOD (  13.11  )
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


>>> Add a send quota in nvme_tcp_send_all() to avoid stalls when sending
>>> large amounts of requests.
>>>
>>> Signed-off-by: Daniel Wagner <dwagner@suse.de>
>>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>>> ---
>>>   drivers/nvme/host/tcp.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
>>> index 606565a4c708..87d760dfa3a9 100644
>>> --- a/drivers/nvme/host/tcp.c
>>> +++ b/drivers/nvme/host/tcp.c
>>> @@ -308,11 +308,12 @@ static inline void nvme_tcp_advance_req(struct 
>>> nvme_tcp_request *req,
>>>   static inline void nvme_tcp_send_all(struct nvme_tcp_queue *queue)
>>>   {
>>>       int ret;
>>> +    unsigned long deadline = jiffies + msecs_to_jiffies(1);
>>>       /* drain the send queue as much as we can... */
>>>       do {
>>>           ret = nvme_tcp_try_send(queue);
>>> -    } while (ret > 0);
>>> +    } while (ret > 0 || !time_after(jiffies, deadline));
>>
>> Umm, this will stay here a deadline period even if we don't have
>> anything to send?
> 
> Ah. Yeah, maybe. We can change it to '&&', which should solve it.
> (I think)

See what is done in io_work()

