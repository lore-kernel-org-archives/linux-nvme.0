Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A60CDDE40
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Oct 2024 10:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=woF5q3pESPJk+4/WKMXM3SDBqmy29+UPMBlAR59Ig20=; b=ubha4/JbM5OigvvfOFKzuAZgXh
	Zqu2TsuJn9+HrgQWIEHqKTkzaRLPJKyLuDVkPuNLnVFM8F32nHswz0LKR0XmAoAmVQpwsxf6suT3t
	Bl27cHs9euIIe9XzpL9JT2zF2SwZ/Rao4hox63nh+aWE3JPxbIPlYEJqM27vvk9ieYmR5O9gOAG3F
	p9oKPMyTS5qbrm+/KBZbfZj1s3Sn1I6FvbIecX/cJbQzrRZEkCAednk52D/CfwdUS24cABYsiwbar
	XesPUclG1IpB0HVPcomqkTiGa6mr2j1drPZnOjmEd6GIby0sWh9iGbmWEU9oca6oxiCngJKiahroP
	4FLIvOYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3YAS-0000000Du7J-0WPd;
	Wed, 23 Oct 2024 10:00:40 +0000
Received: from mail-ej1-f52.google.com ([209.85.218.52])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Xxa-0000000DrHU-0sTw
	for linux-nvme@lists.infradead.org;
	Wed, 23 Oct 2024 09:47:23 +0000
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a86e9db75b9so868111466b.1
        for <linux-nvme@lists.infradead.org>; Wed, 23 Oct 2024 02:47:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729676840; x=1730281640;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=woF5q3pESPJk+4/WKMXM3SDBqmy29+UPMBlAR59Ig20=;
        b=Eu1xayWlYbrIsqU6Ws1rXahYgm/ESYu7UEBTbxKKX98S06Wm3xHKVAuwEV3EKywaeM
         Hr5u2jMrp7cDm3jmmJwNn3FDvzN4eCji2DBm/NyWI74c33rjvPmWrKFLRs0gvIJLJNe/
         GXTXUeTPKQGBqAm3bEsAyKZT9wJFMalSHYwD9ynuxs4CM1BqfF4k9DQIxUn2ftWWfmSC
         u/wA/6xrRlBJ4WlXNMsDJ4BIuhxYM2pCdLfALtYDjPll6mthXYHV96FzugwW6gL0apht
         xgaXvEhf7ZBTx0rc7Yqno2nEjUhDeFbMn5xSngQtH1tmPgp9SuhfUnbvhiPTgj6n+Nsn
         vjoA==
X-Forwarded-Encrypted: i=1; AJvYcCWSzTyMHvk7uv8bTn8aSkdbzNM+1cgCKmoOZF+zhXqVInzxRPZEitbz4qQpFqDGC8OzjY4wB9FHs263@lists.infradead.org
X-Gm-Message-State: AOJu0Yy5BGSZgZcYynu47Xeut1y+wtepbf3EDc69rY5k2AgPJPWeljsA
	Ghis7HTJrgNL+hwOG88KpIllOu4Z/PgERs5SAmOyLWqw2G2e2AYdCz7JFw==
X-Google-Smtp-Source: AGHT+IGY61ZsPuBvI/QH9aKmiOpOuy6+oKGeCbiXlliZD278FpkCfl/TmavvW7l0xDH8iO2qXiGBSQ==
X-Received: by 2002:a17:906:478f:b0:a99:ee83:2b19 with SMTP id a640c23a62f3a-a9abf8a4f28mr199033366b.35.1729676840080;
        Wed, 23 Oct 2024 02:47:20 -0700 (PDT)
Received: from [10.100.102.74] (89-138-78-158.bb.netvision.net.il. [89.138.78.158])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a9159a231sm450360766b.210.2024.10.23.02.47.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 02:47:19 -0700 (PDT)
Message-ID: <dfa54876-5ed4-4cbe-b62b-be1cb0fdd296@grimberg.me>
Date: Wed, 23 Oct 2024 12:47:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-sysfs: display max_hw_sectors_kb without requiring
 namespaces
To: Keith Busch <kbusch@kernel.org>
Cc: Abhishek Bapat <abhishekbapat@google.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Prashant Malani <pmalani@google.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20241016213108.549000-1-abhishekbapat@google.com>
 <ZxE-BE4hLVRR2Zcp@kbusch-mbp.dhcp.thefacebook.com>
 <CAL41Mv4_UjsD1ycpNU1xuQJdGWMf2L-SQYs=LupoM9BKurNXCg@mail.gmail.com>
 <Zxe8e2zS5dA61Jou@kbusch-mbp>
 <6b00d25e-fe6a-4552-9945-d6181af83137@grimberg.me>
 <ZxfJ_TfT7MMGWs4X@kbusch-mbp>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <ZxfJ_TfT7MMGWs4X@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241023_024722_314487_9FB20431 
X-CRM114-Status: GOOD (  16.57  )
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




On 22/10/2024 18:51, Keith Busch wrote:
> On Tue, Oct 22, 2024 at 06:35:11PM +0300, Sagi Grimberg wrote:
>> On 22/10/2024 17:53, Keith Busch wrote:
>>> On Thu, Oct 17, 2024 at 02:32:18PM -0700, Abhishek Bapat wrote:
>>>
>>> The request_queue is owned by the block layer, so that seems like an
>>> okay place to export it, but attached to some other device's sysfs
>>> directory instead of a gendisk.
>>>
>>> I'm just suggesting this because it doesn't sound like this is an nvme
>>> specific problem.
>> Won't it be confusing to find queue/ directory in controller nvmeX sysfs
>> entry?
> It's the attributes of the request queue associated with that
> controller, so I think a queue/ directory under it makes sense. That's
> how it looks for gendisks, so why not for disk-less queues?
>
> Many queue attributes only make sense for gendisks, though, so maybe
> need to tweak visibility if we decide to do it like this.

It'd be good to name it "admin_queue" to clarify a bit (although its still
confusing).

