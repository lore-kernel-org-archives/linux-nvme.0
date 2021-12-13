Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D9BC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Dec 2021 09:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VvG9DQ5/5HpD56CzSTMBJ4VkJAcWFU5OBdmd9GGGqNk=; b=22uJB9e6H6/g/fjZr6VV+ZdCcd
	F1B0UJ1rBYcjaZjnZykRE4xe4Z18xU0FKHYF6aIvGtat41EmtImm8FjLgeErGVkBUnlKqUMY5+Zqb
	IBjE6vw2VTcf7OxrREd35uIWLUA1z/qCzTg0VKjikJnk9NBunhI/ZPejnmz7wNMwuewc74EudNcdv
	/UTX85QuCL238P/Y9Ij+sEZgFsEHOlCiJoXUFPkwoDDPl8jEPCHm5PuJL8oDL/o8ERo3FNcdOFi5P
	dYnsb5fpvpQTOepX/CKoHa5HECNoFPc9+9YK0rL7mJPEjplEyKPzNFgzXOK+tvl4y0YleGp8ekSxF
	bWg8zJvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwhLb-008X0g-G9; Mon, 13 Dec 2021 09:10:15 +0000
Received: from mail-ed1-f46.google.com ([209.85.208.46])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwhGY-008Uxx-Pw
 for linux-nvme@lists.infradead.org; Mon, 13 Dec 2021 09:05:06 +0000
Received: by mail-ed1-f46.google.com with SMTP id v1so50110800edx.2
 for <linux-nvme@lists.infradead.org>; Mon, 13 Dec 2021 01:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VvG9DQ5/5HpD56CzSTMBJ4VkJAcWFU5OBdmd9GGGqNk=;
 b=cVwP4wJHwilm98iYJFXfa7pheD+Ngyih36jhae5tbLkjUc1bz+NzypkIieT5+3F8O4
 2aP0AWsueQ6e3PluOP2Ur8eCChi9YSjarNjs5nbO0UBp/w0How/wWUKn2UBDaF/SNljG
 edFGF6KfU8Uh0a3Z/2mNCDpd/TPg82/ALmrSDhzzLtO4RuaXPhcGJervxjkYu7B+moQo
 Y1wPh7OpnJl3MF3220A7YlUtPuzGg41SGbRzyyM+tlxehnffinWE/nGMb1RlY58EaA5R
 qE4jbGp4GwVuErYsjdUpEnOw8GEr4EEEWoMFRw0gUEM7OZpMiXqC6PsdmLPkZpyxoRNO
 Ey8w==
X-Gm-Message-State: AOAM533eJm0jS40Nx/WGvRrQOlASxXznXdczC/BFFvdURUSEPMFNLsFS
 dQ03b3Wu+ubzvJSr8EKOEKTe9X9fwRk=
X-Google-Smtp-Source: ABdhPJwElPTR9llfH17INB+MYBkhqjve6QwhagGaiJy/0ST8RMoiKRnihfDBMI49Qxd6rjDjwi54OA==
X-Received: by 2002:a17:906:6a08:: with SMTP id
 qw8mr42652554ejc.200.1639386300700; 
 Mon, 13 Dec 2021 01:05:00 -0800 (PST)
Received: from [10.100.102.14] (85-250-228-224.bb.netvision.net.il.
 [85.250.228.224])
 by smtp.gmail.com with ESMTPSA id u23sm5951467edi.88.2021.12.13.01.04.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Dec 2021 01:05:00 -0800 (PST)
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To: Yi Zhang <yi.zhang@redhat.com>
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
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <42ccd095-b552-32f7-96b0-d34d46f7c83e@grimberg.me>
Date: Mon, 13 Dec 2021 11:04:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs8wBwDGhhtEPodyBdR-sCqJLYhwLhNHuPDm+KCan0hwWg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211213_010502_924184_8D658BB9 
X-CRM114-Status: GOOD (  15.37  )
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


>>>>>> Hello
>>>>>>
>>>>>> Gentle ping here, this issue still exists on latest 5.13-rc7
>>>>>>
>>>>>> # time nvme reset /dev/nvme0
>>>>>>
>>>>>> real 0m12.636s
>>>>>> user 0m0.002s
>>>>>> sys 0m0.005s
>>>>>> # time nvme reset /dev/nvme0
>>>>>>
>>>>>> real 0m12.641s
>>>>>> user 0m0.000s
>>>>>> sys 0m0.007s
>>>>>
>>>>> Strange that even normal resets take so long...
>>>>> What device are you using?
>>>>
>>>> Hi Sagi
>>>>
>>>> Here is the device info:
>>>> Mellanox Technologies MT27700 Family [ConnectX-4]
>>>>
>>>>>
>>>>>> # time nvme reset /dev/nvme0
>>>>>>
>>>>>> real 1m16.133s
>>>>>> user 0m0.000s
>>>>>> sys 0m0.007s
>>>>>
>>>>> There seems to be a spurious command timeout here, but maybe this
>>>>> is due to the fact that the queues take so long to connect and
>>>>> the target expires the keep-alive timer.
>>>>>
>>>>> Does this patch help?
>>>>
>>>> The issue still exists, let me know if you need more testing for it. :)
>>>
>>> Hi Sagi
>>> ping, this issue still can be reproduced on the latest
>>> linux-block/for-next, do you have a chance to recheck it, thanks.
>>
>> Can you check if it happens with the below patch:
> 
> Hi Sagi
> It is still reproducible with the change, here is the log:
> 
> # time nvme reset /dev/nvme0
> 
> real    0m12.973s
> user    0m0.000s
> sys     0m0.006s
> # time nvme reset /dev/nvme0
> 
> real    1m15.606s
> user    0m0.000s
> sys     0m0.007s

Does it speed up if you use less queues? (i.e. connect with -i 4) ?

> 
> # dmesg | grep nvme
> [  900.634877] nvme nvme0: resetting controller
> [  909.026958] nvme nvme0: creating 40 I/O queues.
> [  913.604297] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> [  917.600993] nvme nvme0: resetting controller
> [  988.562230] nvme nvme0: I/O 2 QID 0 timeout
> [  988.567607] nvme nvme0: Property Set error: 881, offset 0x14
> [  988.608181] nvme nvme0: creating 40 I/O queues.
> [  993.203495] nvme nvme0: mapped 40/0/0 default/read/poll queues.
> 
> BTW, this issue cannot be reproduced on my NVME/ROCE environment.

Then I think that we need the rdma folks to help here...

