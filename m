Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82A13C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jan 2022 21:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lBG4OVsjZHgF1uu6OZYtwAm/yBGBzeR/ms6vAaHQyzk=; b=Gx3fnLkAhmCmWKOF+fa4s+CjRi
	gJHXk7pvqMGkU4ahe/dv3WNw0LsVnKlq5B3oVr5AHS16YR9pi3x0Prt9xouy1Nn98rWjCHkV1yfuD
	Bt7v8+NpAqoTMg+XEJ4+P/K8KTKe2BG8KWnUr/U947sKgqRU0qTq1c5YRS96bc4QlvMoMS92RN6ll
	wFhSCqFo7w9eATn/5HYE5gMd78KryhXkFV4uBLc54w3+/Apfzizc4lZKjfFoJ1smD1wH+01B1HIvO
	fUqBVDGL4G1mOpjMp73OnPf9e2lRoIHA5tpeAm0AVzjmtASp6rKENFZCW1dTkOkXDgd2CtEwbX8Qd
	X3GoLvSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nDCnj-00HBeH-OA; Thu, 27 Jan 2022 21:59:31 +0000
Received: from mail-ej1-f47.google.com ([209.85.218.47])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nDCng-00HBdu-Q0
 for linux-nvme@lists.infradead.org; Thu, 27 Jan 2022 21:59:30 +0000
Received: by mail-ej1-f47.google.com with SMTP id ka4so9089692ejc.11
 for <linux-nvme@lists.infradead.org>; Thu, 27 Jan 2022 13:59:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=lBG4OVsjZHgF1uu6OZYtwAm/yBGBzeR/ms6vAaHQyzk=;
 b=APHJ26cOHVYZf9ggMTYzBhiAW7DouAFlA3w01q67W7unbeb5WM7Ucm2q4xCZ3IFAlL
 5zYnhXm0Cyah71Ako0qHawESvW36KSnoRIwNaudMxGTGC3XKD3jWgHM91FwM7Bw8kbNL
 h9qpOAKYRnkRfKjQXfXGwp8Xc/RvGJuRiTjEl0hGZGHK98u5uYgD0Bxi/u4T8jlwrMuM
 r7xLMkuiPU5MnJJiCvDRdTZFuM+tpXY+kmG9aBOyDAaCn4rwoyzuZvHzT67FBdcd5HL3
 qpUawTmEY0GZ6xcAW9xlbW9OYdN5MyX4Db3PLwUtNo/fbhxg9fKnMSR02SEBcY/69A2P
 GeOA==
X-Gm-Message-State: AOAM532zmyBeqB8v+Jl2G1h7Oxi15UOkJoOcEPhpJ6BRR/k9JOG3SRba
 yoeQ1pjzkz91xzQtr2f7jFk=
X-Google-Smtp-Source: ABdhPJxH8+Bo73s1mP68N1NXZMsdKxE3kSLscRy0zqDR3YzycSDXZCoBDtFHi0JxU41FxLbwIdYczQ==
X-Received: by 2002:a17:907:2da7:: with SMTP id
 gt39mr4522437ejc.563.1643320766879; 
 Thu, 27 Jan 2022 13:59:26 -0800 (PST)
Received: from [10.100.102.14] (46-117-116-119.bb.netvision.net.il.
 [46.117.116.119])
 by smtp.gmail.com with ESMTPSA id z25sm11951180edm.60.2022.01.27.13.59.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 13:59:26 -0800 (PST)
Message-ID: <12b4824b-f704-fe25-5511-012dfcdaf514@grimberg.me>
Date: Thu, 27 Jan 2022 23:59:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] nvme-fabrics: add tp8010 support
Content-Language: en-US
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Hannes Reinecke <hare@suse.de>, Martin Belanger <nitram_67@hotmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>
References: <20220125145956.14746-1-nitram_67@hotmail.com>
 <BL0PR13MB4291A94BED970C6599BBC6679C5F9@BL0PR13MB4291.namprd13.prod.outlook.com>
 <1ee5410f-3af6-8ca7-a860-e3fc1bc49a0e@suse.de>
 <92c36bc0-9489-ebc1-3176-fb215ccc8646@grimberg.me>
 <SJ0PR19MB45446D366BC530A5EE66339FF2219@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <SJ0PR19MB45446D366BC530A5EE66339FF2219@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220127_135928_885393_28F4A436 
X-CRM114-Status: GOOD (  18.46  )
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


>>> Wouldn't it make more sense to delegate explicit registration to
>>> userspace (ie libnvme/nvme-cli), and leave the kernel out of it?
>>
>> It would. There is no reason what-so-ever to place all this register
>> stuff needs to live in the kernel. We have a way to passthru commands so
>> it can and should move to userspace.
> 
> I wish it could be delegated to a user-space app, and in fact that was my
> original design.
> 
> Unfortunately, while testing I realized that the kernel can autonomously
> reconnect and user-space apps are completely unaware of it.
> 
> For example, let's say the network goes down momentarily. The kernel then
> tries to reconnect. Once it successfully reconnects it doesn't tell anyone
> about it.

Then add a uevent on the controller device-node. From there you should
trap it and do what you need (exactly like how discovery log change
events are handled).

BTW, I also don't understand why the host needs this reregistration on
reconnect, but that is besides the point.

> But let's say the kernel does send a signal to user-space on a reconnect.
> What if there is no user-space app to receive this signal? I'm thinking of
> the case where one uses nvme-cli to set up persistent connections to
> discovery controllers.  In that case there is no app to send the explicit
> registration on a re-connect.

This argument does not justify adding functionality in the kernel that
doesn't belong there. If we were to follow this argument we would be
placing everything in the kernel. If someone wants this functionality,
he/she needs to use the tools required for it to work.

