Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC1CCD3442
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Sep 2023 07:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=d/LuZHHSnEA+ZRQK6hZMwwxNsZx+UGYYWxDQS26Kk7A=; b=Rpc8L7tm5+CIX/Mjc9dnfsKIK6
	2JIWDhmuabnhDaME0wN+s5GrQNUfOhgF3z9yPLhhVCXchTof+fX6qg53fkJ56wrcPDyXLd0DGa266
	3WyqAPOUla9vYCHmlxusdT9ec4eQWsfmk32Xig+Jbe9ljC/RqVYbkiJJaM07jy/PBh6qO+ZqeWQpL
	3VLoBDtx/naDR3/Mpjk91D4mjHUXTl6b3GN8eVKV2nyDEWej1UHo+zGzrVToAB7rs05UJJB82Hf2o
	hYT74X4G7GqG6m/bzvxPmu0QVEDdafSRawpa6a3IVNrjhMZiUj+32Ivfd3JUo2SQwYtfLMrkUTfHc
	e5bdXDXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qiUmP-00HBfH-1O;
	Tue, 19 Sep 2023 07:04:17 +0000
Received: from mail-ej1-f49.google.com ([209.85.218.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qiUmL-00HBbX-2W
	for linux-nvme@lists.infradead.org;
	Tue, 19 Sep 2023 07:04:15 +0000
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-98273ae42d0so111847066b.0
        for <linux-nvme@lists.infradead.org>; Tue, 19 Sep 2023 00:04:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695107051; x=1695711851;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d/LuZHHSnEA+ZRQK6hZMwwxNsZx+UGYYWxDQS26Kk7A=;
        b=X2RR3IoJkk24GZXQdaRmtrd72cWP9aXdGAwYcgElP4vJVavG4UdpIVL393ezN0dJ6C
         eqdX4gNHbkQ2OBKFBxU2hvN41+n84F8sNXoq9hG4yV025JE7LpqKuAQwTacx3WnP5IA0
         s0id2xZMNCvpOgQx/o2Qz9AN6/NBuWT5K9l4f4J/GRSITkoAACfVdn+zyf1fYpkvwOzC
         5JaDnHC1CyLvOwIEm9j3nhznN8qf323z8Bn5TSdv7dimsARfy0x9JteJT8MVeSFtCxpd
         IkxawKJySZPY8q2zu/vkjI7Y4eaCqwVBk3+39F9TBVcB7kjH5yzOjs1sbxLz3bgak6x+
         tQiQ==
X-Gm-Message-State: AOJu0Yz54RvU9AJVJWg0BKMu2XRpVEpRB1aLKUxbi7TjbYXOhSomyR4I
	WhaCUNIRPuXCWzcUGlkdj18=
X-Google-Smtp-Source: AGHT+IHWmj4W+Y9QZ2DqpEfiibOwPzes1Xi2G5DM9117uMzoXLq+26BklRQ62M9WKTUOYi7X5WHFeA==
X-Received: by 2002:a17:906:9e:b0:9a5:ce62:6e1a with SMTP id 30-20020a170906009e00b009a5ce626e1amr8790586ejc.1.1695107050998;
        Tue, 19 Sep 2023 00:04:10 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id jw24-20020a17090776b800b009a168ab6ee2sm7366103ejc.164.2023.09.19.00.04.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 00:04:10 -0700 (PDT)
Message-ID: <5b0fcc27-04aa-3ebd-e82a-8df39ed3ef5d@grimberg.me>
Date: Tue, 19 Sep 2023 10:04:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v15 06/20] nvme-tcp: Add DDP data-path
Content-Language: en-US
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Boris Pismenny <borisp@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, ogerlitz@nvidia.com,
 yorayz@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230912095949.5474-1-aaptel@nvidia.com>
 <20230912095949.5474-7-aaptel@nvidia.com>
 <ef66595c-95cd-94c4-7f51-d3d7683a188a@grimberg.me>
 <2537congwxt.fsf@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <2537congwxt.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230919_000413_812860_0C11227F 
X-CRM114-Status: GOOD (  12.33  )
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


>>> @@ -1235,6 +1330,9 @@ static int nvme_tcp_try_send_cmd_pdu(struct nvme_tcp_request *req)
>>>        else
>>>                msg.msg_flags |= MSG_EOR;
>>>
>>> +     if (test_bit(NVME_TCP_Q_OFF_DDP, &queue->flags))
>>> +             nvme_tcp_setup_ddp(queue, blk_mq_rq_from_pdu(req));
>>
>> Didn't we agree that setup_ddp should move to setup time and
>> not send time?
> 
> We believe we haven't reached a conclusion last time [1].
> 
> Moving the setup_ddp() call earlier at setup time is less efficient (up
> to ~15% less IOPS) when it does the work on a different CPU.
> 
> 1: https://lore.kernel.org/all/253h6oxvlwd.fsf@nvidia.com/

Can you please explain why? sk_incoming_cpu is updated from the network
recv path while you are arguing that the timing matters before you even
send the pdu. I don't understand why should that matter.

