Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53002C25B78
	for <linux-nvme@archiver.kernel.org>; Wed, 22 May 2024 18:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7/Rno11Nmksi7kRklYNZ2j8WW2GA82Mwb2yy+eydqEA=; b=tsjhV8u9wVFb4l2l6hvthH3jWP
	IDa1+j4yWzbRnXabF9xGnYDqZspk75XDRG+6Xt71fMra1j8Dlq8cc2cAC+98emTHjUTQljTflBGVW
	oLE7lz0Dh8hEZMLt10lx18jT0yMgifu3/g2i277fjz86xApmS2eGOP8eDl57CVHXgO9Ld0659CTIz
	4qBuKGYImej65OFqfY63WY0pnas2hTmaz0ZYKWPuFuCZ54sRIfig1ksaVW9SP7WHeQt1g920405HT
	Mn+tWf0Z1vcwXNgdvsT1JLflbKchkR3UwGYtZPIXteesarHtzEfcBGyQiY9fSo2rqMMJbotDFQz/m
	wDoDeT8Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9qGi-00000003jZz-43qC;
	Wed, 22 May 2024 18:00:52 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9qGg-00000003jXu-1hNp
	for linux-nvme@lists.infradead.org;
	Wed, 22 May 2024 18:00:52 +0000
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-354c3b445bbso496908f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 22 May 2024 11:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716400837; x=1717005637;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/Rno11Nmksi7kRklYNZ2j8WW2GA82Mwb2yy+eydqEA=;
        b=Hut+GilCeaKZMZnLI6JnaK89mrot4Y0LXKh6ERmhhC9kiI8W70tSI8+Rfc8/zEvZMK
         rfIhXR3tJfZYPRHCYJGrzDP2xp78pgiV126OA9o571T0vEBRD/M0PeerJwIRRApWcxBE
         kkiQ3wHlNWngvwYikBaKbC6IFDS/u49Pr2gtwc80vn21PKYRCNA69FGn8U9MBj5UYI73
         uVuf0uzvnjWFbwHI/TrEYLb4baXNVuxeGe7oUHJsP1J7UkzT3ersd5SRNbL2/dxB1ywO
         PTLQ/OWaf4AzSNTbWPVQ6mf0G+h3dnMBw+OxKfmA/660Y/i25mr+EUOHO/oR5k7e6buD
         gokA==
X-Forwarded-Encrypted: i=1; AJvYcCVRkVcuGfxIydK6OygFwelNx6nBQIOD93vBG0O7wRyLespIR6KKqGoYWo+CPpnmgJMJyBSmZGrPe8z4ZH2sySJA+R4Cb8IXwSVptAdt+KU=
X-Gm-Message-State: AOJu0YwomJIB1JgENJ5CowV2lwCIkJgi7+tLtZpYI8Py/ER2xR55GcxO
	ACAX6JW7DWx4mrfhq3yv5gaxgzRTKljnIWOIFpX4FNG9l5c1t0Os
X-Google-Smtp-Source: AGHT+IE8xZnI/GfxOfv5q1Vc2KZQTYUgsAS4XAEZiDVbKDXKfmqYL81wwl6CkcCeM0RhL9RqQyyBSQ==
X-Received: by 2002:a05:600c:3ba8:b0:418:f770:ba0 with SMTP id 5b1f17b1804b1-420fd22a4d5mr21652695e9.0.1716400836613;
        Wed, 22 May 2024 11:00:36 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42100f1c618sm1372195e9.14.2024.05.22.11.00.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 May 2024 11:00:36 -0700 (PDT)
Message-ID: <a0657f0a-44af-4765-abe3-acc8a1017b40@grimberg.me>
Date: Wed, 22 May 2024 21:00:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-pci: silence a lockdep complaint
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20240522091534.472449-1-sagi@grimberg.me>
 <vjurqn5g6k5fkzqo6iz2rzkxlljrjfna3efgub3o24ol2yv55u@lx77me5f47gm>
 <Zk4ZY2n7dSztQ4Xs@kbusch-mbp.dhcp.thefacebook.com>
 <20240522162845.GA16783@lst.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240522162845.GA16783@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_110050_486536_ABA0C276 
X-CRM114-Status: GOOD (  14.80  )
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



On 22/05/2024 19:28, Christoph Hellwig wrote:
> On Wed, May 22, 2024 at 10:12:19AM -0600, Keith Busch wrote:
>>> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> This is not desireable, but I give up trying to appease lockdep for this
>> one.
> lockdep_off is a cure that's worth than the desease.

This is not ideal for sure.

>   If we can't
> explain the "can't happen" using lockdep classes I don't see how
> we could actually be sure that it can't happen.

I don't understand lockdep well enough to do that. This warning
exists for 6 months now. The conclusion that Keith came to (and I agreed)
is that it can't happen, because nvme_timeout handler will not disable the
device while the ctrl reset_work is running, the ctrl state machine will 
prevent
that from happening.

There was an attempt to convert namespaces_rwsem a srcu, but my comment to
that was that this is an intrusive change for a complaint that we think 
is a false-positive.

Do you see a proper way to solve this? Would love to see a better 
solution here.

The original report is at:
https://lore.kernel.org/linux-block/20220930001943.zdbvolc3gkekfmcv@shindev/ 


