Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CEA7EB64DD
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Aug 2023 07:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IcnCQ8xaUB5P+nnoqcvRQHtgfnUd197HfgGPw0/AMZ4=; b=g0037WvrQAcbew9cnIXx3MH5GD
	Y/j/W2OTBRqKRR8Bxj4NBAd+g3nbOlPWBLCYH3YoZEivEGa3ugjbQkQyNYhz8y+skRVKB+bZmzJ4E
	CFZ9aqLMN2mufIMhPTYZYHhXrBBeiE70KZ8fm1bWroJLhW+lp9krcQ/uiMilBlo5juslBgOsexROA
	2RLQJtDHWK06GhJZPh/waBaztJ2z7RtUTLwa11ZTYtrUPdplIUe4z210fLxEZCNR9M05a4Db7bCUo
	lF+ET4r6OMBUw3sd8/6ypH7xvUfWpry1pmOZPxb8vKG6C0JuCDbeEuSBoGjHvcux0hc7o0JekBI7C
	OPbHR3jw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qTdnM-004Hq8-1l;
	Wed, 09 Aug 2023 07:39:52 +0000
Received: from mail-lf1-f42.google.com ([209.85.167.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qTdnJ-004Hpa-3A
	for linux-nvme@lists.infradead.org;
	Wed, 09 Aug 2023 07:39:51 +0000
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4fe1e7440f1so1687170e87.0
        for <linux-nvme@lists.infradead.org>; Wed, 09 Aug 2023 00:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691566787; x=1692171587;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IcnCQ8xaUB5P+nnoqcvRQHtgfnUd197HfgGPw0/AMZ4=;
        b=VvSQdEeh5AqyJJ+J11jmP5yqFjPhKFotPyNRzQPKlw95x09UdlYE0UTYd/eJolUsqy
         fSGvK7zeRnhz76M9WK7lr5XPYq3nxwjGRUvGGLb/1UDg0Wxg+pf1Dnr9BeBSeIZ3oIe/
         xlKentUROMfOoEJzfoDxdwtfor/AMbxtNT2CbFifTXHBdwRFUaX33tIOkKRPNscVPF3b
         SUw7u6RIrpwWhVE1iVvlcd4W8huu29c6aj9HC3I45gRXaPw0mEssckpN5KZMh89t/OZr
         34MShy0m5n2GQG3i3nRlQVuK3+HxD1Hu+PZCL+KQ4NU1Rsvi5iNLSKkM7w7xAbSlkEQl
         P65Q==
X-Gm-Message-State: AOJu0YznrFZV64nM1xOMw1jo81BGrUIGZMkDu1bngTMTMRyB3mEn62po
	oquantTlQ9mabOQr1PpC44a5zmIhKc0=
X-Google-Smtp-Source: AGHT+IFJX0Xo0Kww2n3GLSYlhtOJuzJjcw2BH3VbUdL+l46JRVFYUsKV5vo8Mm3CIUvknuBnWyY1QQ==
X-Received: by 2002:a19:750c:0:b0:4fd:d0f7:5b90 with SMTP id y12-20020a19750c000000b004fdd0f75b90mr1092919lfe.4.1691566786641;
        Wed, 09 Aug 2023 00:39:46 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id c21-20020aa7df15000000b005222b471dc4sm7504786edy.95.2023.08.09.00.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 00:39:45 -0700 (PDT)
Message-ID: <2ae6c96b-2b05-583e-55bd-2d20133b9b37@grimberg.me>
Date: Wed, 9 Aug 2023 10:39:42 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 07/26] nvme-tcp: Add DDP offload control path
Content-Language: en-US
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Aurelien Aptel <aaptel@nvidia.com>, Shai Malin <smalin@nvidia.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
 Boris Pismenny <borisp@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "kuba@kernel.org" <kuba@kernel.org>,
 "aurelien.aptel@gmail.com" <aurelien.aptel@gmail.com>,
 "hch@lst.de" <hch@lst.de>, "axboe@fb.com" <axboe@fb.com>,
 "malin1024@gmail.com" <malin1024@gmail.com>, Or Gerlitz
 <ogerlitz@nvidia.com>, Yoray Zack <yorayz@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Gal Shalom <galshalom@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-8-aaptel@nvidia.com>
 <8a4ccb05-b9c5-fd45-69cb-c531fd017941@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <8a4ccb05-b9c5-fd45-69cb-c531fd017941@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230809_003950_041627_CE5984F6 
X-CRM114-Status: GOOD (  21.82  )
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



On 8/1/23 05:25, Chaitanya Kulkarni wrote:
> On 7/12/23 09:14, Aurelien Aptel wrote:
>> From: Boris Pismenny <borisp@nvidia.com>
>>
>> This commit introduces direct data placement offload to NVME
>> TCP. There is a context per queue, which is established after the
>> handshake using the sk_add/del NDOs.
>>
>> Additionally, a resynchronization routine is used to assist
>> hardware recovery from TCP OOO, and continue the offload.
>> Resynchronization operates as follows:
>>
>> 1. TCP OOO causes the NIC HW to stop the offload
>>
>> 2. NIC HW identifies a PDU header at some TCP sequence number,
>> and asks NVMe-TCP to confirm it.
>> This request is delivered from the NIC driver to NVMe-TCP by first
>> finding the socket for the packet that triggered the request, and
>> then finding the nvme_tcp_queue that is used by this routine.
>> Finally, the request is recorded in the nvme_tcp_queue.
>>
>> 3. When NVMe-TCP observes the requested TCP sequence, it will compare
>> it with the PDU header TCP sequence, and report the result to the
>> NIC driver (resync), which will update the HW, and resume offload
>> when all is successful.
>>
>> Some HW implementation such as ConnectX-7 assume linear CCID (0...N-1
>> for queue of size N) where the linux nvme driver uses part of the 16
>> bit CCID for generation counter. To address that, we use the existing
>> quirk in the nvme layer when the HW driver advertises if the device is
>> not supports the full 16 bit CCID range.
>>
>> Furthermore, we let the offloading driver advertise what is the max hw
>> sectors/segments via ulp_ddp_limits.
>>
>> A follow-up patch introduces the data-path changes required for this
>> offload.
>>
>> Socket operations need a netdev reference. This reference is
>> dropped on NETDEV_GOING_DOWN events to allow the device to go down in
>> a follow-up patch.
>>
>> Signed-off-by: Boris Pismenny <borisp@nvidia.com>
>> Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
>> Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
>> Signed-off-by: Yoray Zack <yorayz@nvidia.com>
>> Signed-off-by: Shai Malin <smalin@nvidia.com>
>> Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
>> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
>> ---
> 
> For NVMe related code :-
> 
> Offload feature is configurable and maybe not be turned on in the absence
> of the H/W. In order to keep the nvme/host/tcp.c file small to only handle
> core related functionality, I wonder if we should to move tcp-offload code
> into it's own file say nvme/host/tcp-offload.c ?

Maybe. it wouldn't be tcp_offload.c but rather tcp_ddp.c because its not
offloading the tcp stack but rather doing direct data placement.

If we are going to do that it will pollute nvme.h or add a common
header file, which is something I'd like to avoid if possible.

