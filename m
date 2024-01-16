Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A686C4706C
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Jan 2024 07:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zmbAkwekZgr+NIDRIaO9jb/dsyRwmfTLFWdAQQMOjc4=; b=P+ET67odWk4QKOcXRG7WRDIb9G
	2jiWnQalpwysV26qvzcVA3nBFE7fLxXjCi43GfUBswYWw7wa78Obg5x628QpFE/3h3milzXCUTWYA
	JnijnUldsDrYj9dV8EF2JL/YjMAUXHdah/mM58Ckv66ZW6Kisv89WRj+NaYctyMRVz/Ong7BCbmfs
	qHVCfSgmApwOJmLq0OdGpg8ktel9Gz6p4N3sEzxRIkPAEYyH03oPgkmKKHhP0Tvd2kHzyJiisUxS4
	/frs5eiY6KH48zaQbUXqxMmUSTeiBv/JsYrtf0lhvh3r6wbv5O6NT3eiJ13lnKrq8STz2cNJto7BC
	m2JVT2LQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPeLm-00BKJ6-2Q;
	Tue, 16 Jan 2024 07:59:10 +0000
Received: from mail-ed1-f53.google.com ([209.85.208.53])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPeLk-00BKHs-0c
	for linux-nvme@lists.infradead.org;
	Tue, 16 Jan 2024 07:59:09 +0000
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55369c59708so1926965a12.1
        for <linux-nvme@lists.infradead.org>; Mon, 15 Jan 2024 23:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705391945; x=1705996745;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zmbAkwekZgr+NIDRIaO9jb/dsyRwmfTLFWdAQQMOjc4=;
        b=csOnQSSjM1JntRUQ2cjst5dpeWaQKenwAgK49T+UDxZUxDs8JC7Rc5BfsbF40V5y4h
         T73aFO44ErOjmES6W9r+Id/uC1B47vY7N7qMOf6epn4jyOYLfw8eebfghBPt1ANZBRyV
         c/jDZwmrPyX6sWyKYSWtJnWZ4OWqWGFgpbkKchE6er6MRTIvCemGzruEvRxDhZ/6GXi5
         +AoMnPhRIBBiivvG1+JG01M88lwUSZ6uzljbF1b/FQPdcVKdpZYxcUNkXKbZLn/dtmu2
         UTOgvuuf+BxU2cbzLekXMyqCsEkmflMccrs5+M2RTTDDDKfHsazEiDXLeUAATRZWdvfc
         DuFg==
X-Gm-Message-State: AOJu0Yy0l98nV+6eTdWRAD9oZmSLgkqe08Y5hO9oprkoogYnStNKb5WO
	pal/C2iomIaxFa4lUX+eh0zAQ5x0/0c=
X-Google-Smtp-Source: AGHT+IFE2XucBp0zjrnJE2eJRqJSKzycmeer0tBwNf8woe2b3if9p606Moe1K6sQPWIDZ/j3IU1bKA==
X-Received: by 2002:a05:6402:1a44:b0:559:87b5:9692 with SMTP id bf4-20020a0564021a4400b0055987b59692mr697834edb.2.1705391944869;
        Mon, 15 Jan 2024 23:59:04 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x9-20020aa7cd89000000b00558e0481b2fsm4955288edv.47.2024.01.15.23.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 23:59:04 -0800 (PST)
Message-ID: <0351e7e8-2bfd-4161-a4a4-1a0c521bd337@grimberg.me>
Date: Tue, 16 Jan 2024 09:59:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 3/3] nvme: introduce pr_work to handle resv event
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com,
 chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240114092314.63694-1-kanie@linux.alibaba.com>
 <20240114092314.63694-4-kanie@linux.alibaba.com>
 <dcfe1277-bb99-4245-9f28-ae14e8ed8954@grimberg.me>
 <11bdf630-66b4-433a-a7c2-ff5d6d4f1b76@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <11bdf630-66b4-433a-a7c2-ff5d6d4f1b76@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_235908_227377_7B9319C4 
X-CRM114-Status: GOOD (  13.27  )
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



On 1/16/24 04:02, Guixin Liu wrote:
> 
> 在 2024/1/15 16:59, Sagi Grimberg 写道:
>>
>>> When a reservation event is reported, the corresponding log page is
>>> already on the target side, and the host side needs to send a get
>>> log command to clear these log pages.
>>
>> AENs are already sent to userspace, I don't see why the kernel
>> should read the log page unless it has something meaningful to
>> do with it.
>>
> Is it tolerable if we dont clear the log page?

Its up to the host. If the host has nothing to do with it
then it doesn't have to do anything with it. I'm assuming
that the user exercising reservations would listen to udev.

Perhaps libnvme would be the place we want to allow users
to consume an api to deal with reservation events.

