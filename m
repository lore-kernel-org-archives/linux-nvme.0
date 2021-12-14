Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DC1C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Dec 2021 10:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6tqg7ZllETzZFYUuz7AvFPji63lPc6QcMad0j8o0TuE=; b=1lyREOQba/J11G+cuExYZBZA34
	GS0IhVplOjNrQvAg82/0mo9qhCqqgfp0qNwyfQCkUIS6xNGNW2Tr6wriPPbxPFL8cwusoNs2aZo58
	o0+cVWLuDuGYif44IU+Dyv+FZV71ACbmSJCDe1Aq+deymh9+DT9BGsQO7sj/V9WibsLlyWEfWhnLe
	j7JB9EqwjTxl28paJB08f2NQUq3jv+GDTVmbVWcekAlgFx1vNc+ZcO0C3sgZYczyZ47FDeUxDAfe8
	7RgSRKHi/8+JU1xMU+K56yPic6BXPjHM5g3jxhZCj6AwWP4XrFaCb7bjxpiozo/I9KkxZhoBK7SKh
	djuq4f5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mx5Dh-00DUS3-J8; Tue, 14 Dec 2021 10:39:41 +0000
Received: from mail-wr1-f49.google.com ([209.85.221.49])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mx5Db-00DURF-0i
 for linux-nvme@lists.infradead.org; Tue, 14 Dec 2021 10:39:36 +0000
Received: by mail-wr1-f49.google.com with SMTP id j3so31648374wrp.1
 for <linux-nvme@lists.infradead.org>; Tue, 14 Dec 2021 02:39:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6tqg7ZllETzZFYUuz7AvFPji63lPc6QcMad0j8o0TuE=;
 b=wYyfWk5ma4uSCvMCLPALgVCC4W0J9fOeQGdjsWftHN1FvRI//2Hlfj/nDY4xw9v3kT
 3MyFHREo/ZB5+GYGfHki0ttRNbtCXzC7pzuSnpmQ4PzX/R0EQ+c0l4n4z8On2P4FjNT3
 eqiXhaH3Lt92vDsb34vmNz4DcHn7ZSEsxFo4fp0GC4tWZW9C8cG9doubHHDFuismRNyU
 I3obH5k11DhX7QqeeLBm2qLA0yqU1cf0HBJRJuLdpMypJVYD9m687ll6pFm1Ino+ghvl
 X/Pb6CPqqFWt6mIcVWp4+76jbGfmtNgqerfhVZZKYxkEMzPMp1NsDcTQVNJMoZBWG9gz
 bwuA==
X-Gm-Message-State: AOAM532l9pufn9sM4/gBbH6+TKySMGMEfSXiMkFtEtVLxXs1w/Ilcp4N
 wZIadVg0pCIY88JWhd/BIzk=
X-Google-Smtp-Source: ABdhPJwbBepmVuVd8nDai1PFqvJwBc1g05Q4FiPml3SRRwSfBVvbU+WWHsACssYVtDsO1RnCvPyEdA==
X-Received: by 2002:adf:c182:: with SMTP id x2mr4967032wre.646.1639478370531; 
 Tue, 14 Dec 2021 02:39:30 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id u13sm1944913wmq.14.2021.12.14.02.39.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Dec 2021 02:39:29 -0800 (PST)
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To: Yi Zhang <yi.zhang@redhat.com>, Max Gurtovoy <maxg@mellanox.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 RDMA mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
 <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me>
 <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
 <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
 <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me>
 <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
 <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me>
 <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <c6d43a10-44bc-e73a-8836-d75367df049b@grimberg.me>
Date: Tue, 14 Dec 2021 12:39:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs9EazUmtbjPKp5TXO4kRPcSShiYbhmsHwfh7SOTQAeoyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211214_023935_094901_66226BA2 
X-CRM114-Status: GOOD (  11.41  )
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


>>> Hi Sagi
>>> It is still reproducible with the change, here is the log:
>>>
>>> # time nvme reset /dev/nvme0
>>>
>>> real    0m12.973s
>>> user    0m0.000s
>>> sys     0m0.006s
>>> # time nvme reset /dev/nvme0
>>>
>>> real    1m15.606s
>>> user    0m0.000s
>>> sys     0m0.007s
>>
>> Does it speed up if you use less queues? (i.e. connect with -i 4) ?
> Yes, with -i 4, it has stablee 1.3s
> # time nvme reset /dev/nvme0

So it appears that destroying a qp takes a long time on
IB for some reason...

> real 0m1.225s
> user 0m0.000s
> sys 0m0.007s
> 
>>
>>>
>>> # dmesg | grep nvme
>>> [  900.634877] nvme nvme0: resetting controller
>>> [  909.026958] nvme nvme0: creating 40 I/O queues.
>>> [  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>>> [  917.600993] nvme nvme0: resetting controller
>>> [  988.562230] nvme nvme0: I/O 2 QID 0 timeout
>>> [  988.567607] nvme nvme0: Property Set error: 881, offset 0x14
>>> [  988.608181] nvme nvme0: creating 40 I/O queues.
>>> [  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll queues.
>>>
>>> BTW, this issue cannot be reproduced on my NVME/ROCE environment.
>>
>> Then I think that we need the rdma folks to help here...

Max?

