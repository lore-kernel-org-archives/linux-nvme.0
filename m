Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8AA4C433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Apr 2022 03:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qUwunun/VVG6pwTOWhDwXkr9BbstGxHqbcx5TzpKkl0=; b=pgMoDuMfP7PF8Qy9r4WHUbxp+P
	bOtoqBpE7FXGe96AHi3aND2BztvPdpZLQqw1xjUlQRKdSecF5XZrd/QxlfRf05M/YNtJSH15mp5g9
	rIfb1Otabp3e9YAlZE+9Itn1OicQcW1yq+7PLflIa+fuYbK4PNdwr6d2WnLSHXB+nWgdrGGgYpI6s
	ZsP9w/i16MHh5rmLQR4qPtI6l9TpAL/6/NVdL4aW3homp6j6jPaXi4th1Iayw7fBT5PkSbK0R8uWQ
	zqbv2HK027Fga7Pi7oO21DRp33p5cgHuWWCe06YMnf2nPYrFzjbtPJS2wvN9YdC3mUheqycL6d6AR
	UYs2umwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nkHTn-009So3-MC; Fri, 29 Apr 2022 03:39:39 +0000
Received: from mail-pl1-f176.google.com ([209.85.214.176])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nkHTl-009SnK-2a
 for linux-nvme@lists.infradead.org; Fri, 29 Apr 2022 03:39:38 +0000
Received: by mail-pl1-f176.google.com with SMTP id c23so6092184plo.0
 for <linux-nvme@lists.infradead.org>; Thu, 28 Apr 2022 20:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=qUwunun/VVG6pwTOWhDwXkr9BbstGxHqbcx5TzpKkl0=;
 b=gY9kmtGhn5aWneJi8A/B3bspp9ackQm0VffFHJiBP77Be8GnbQHlDHEsQ65ypzUZ+D
 WtVJPrpCrmshpv0JdE3rUd2LW9mC+Wi19YBDOZwrxYfpDbaMk884CSl6r6tl5SHvTmJ7
 yC+sFk5Lx+otoExf/Py51Jd9S3KilODJ0oR2zkHf/gGhkUyF+WVxjq+z4bTU7+t/eFgE
 TFE79/WQKZe50U2SRAlpLKVDVEZ4rtGCBLj3BUX/OlkBziwnM0UdGjkJZ6Li0gjPm0Jz
 t6TywfwHHY9Krl0n5u8T5cgKU4ben42C1khvjbd+j8hd4cF/7+kR9le4gzYY5Yi/M0Z6
 wNhg==
X-Gm-Message-State: AOAM531J+NkQx2RJy9Hzjg5z9eMxd0Vtkx6Ap1P0PUYd1tRY0qE51a3A
 aEh8Bwh70Wy5rpAqpOjCrUc=
X-Google-Smtp-Source: ABdhPJxtxVjuFEv0W1FHl8AvFyGb++7DZPYLFEeHuA6owahJDEYGMQWByu+vBRdjF/5hfBrS312ruw==
X-Received: by 2002:a17:902:7884:b0:158:b5b6:572c with SMTP id
 q4-20020a170902788400b00158b5b6572cmr37168381pll.144.1651203575217; 
 Thu, 28 Apr 2022 20:39:35 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd?
 ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
 by smtp.gmail.com with ESMTPSA id
 z2-20020a655a42000000b003c14af505efsm4537074pgs.7.2022.04.28.20.39.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Apr 2022 20:39:33 -0700 (PDT)
Message-ID: <8f00ce03-ec87-b356-29a1-3b01d6c75efa@acm.org>
Date: Thu, 28 Apr 2022 20:39:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [dm-devel] [PATCH v4 00/10] Add Copy offload support
Content-Language: en-US
To: Damien Le Moal <damien.lemoal@opensource.wdc.com>,
 Nitesh Shetty <nj.shetty@samsung.com>
Cc: linux-scsi@vger.kernel.org, nitheshshetty@gmail.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-fsdevel@vger.kernel.org
References: <CGME20220426101804epcas5p4a0a325d3ce89e868e4924bbdeeba6d15@epcas5p4.samsung.com>
 <20220426101241.30100-1-nj.shetty@samsung.com>
 <6a85e8c8-d9d1-f192-f10d-09052703c99a@opensource.wdc.com>
 <20220427124951.GA9558@test-zns>
 <c285f0da-ab1d-2b24-e5a4-21193ef93155@opensource.wdc.com>
 <20220428074926.GG9558@test-zns>
 <a6d1c61a-14f2-36dc-5952-4d6897720c7a@opensource.wdc.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <a6d1c61a-14f2-36dc-5952-4d6897720c7a@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_203937_152435_795171C5 
X-CRM114-Status: GOOD (  13.31  )
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

On 4/28/22 14:37, Damien Le Moal wrote:
> On 4/28/22 16:49, Nitesh Shetty wrote:
>> On Thu, Apr 28, 2022 at 07:05:32AM +0900, Damien Le Moal wrote:
>>> On 4/27/22 21:49, Nitesh Shetty wrote:
>>>> O Wed, Apr 27, 2022 at 11:19:48AM +0900, Damien Le Moal wrote:
>>>>> On 4/26/22 19:12, Nitesh Shetty wrote:
>>>>>> The patch series covers the points discussed in November 2021 virtual call
>>>>>> [LSF/MM/BFP TOPIC] Storage: Copy Offload[0].
>>>>>> We have covered the Initial agreed requirements in this patchset.
>>>>>> Patchset borrows Mikulas's token based approach for 2 bdev
>>>>>> implementation.
>>>>>>
>>>>>> Overall series supports –
>>>>>>
>>>>>> 1. Driver
>>>>>> - NVMe Copy command (single NS), including support in nvme-target (for
>>>>>>      block and file backend)
>>>>>
>>>>> It would also be nice to have copy offload emulation in null_blk for testing.
>>>>>
>>>>
>>>> We can plan this in next phase of copy support, once this series settles down.
>>>
>>> So how can people test your series ? Not a lot of drives out there with
>>> copy support.
>>>
>>
>> Yeah not many drives at present, Qemu can be used to test NVMe copy.
> 
> Upstream QEMU ? What is the command line options ? An example would be
> nice. But I still think null_blk support would be easiest.

+1 for adding copy offloading support in null_blk. That enables running 
copy offloading tests without depending on Qemu.

Thanks,

Bart.

