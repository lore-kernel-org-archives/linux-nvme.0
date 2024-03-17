Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDB30C54E67
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Mar 2024 07:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Dzf9HkPavBqg3tIvWy98WN0LdnXe6unSBkuUeEE1SEY=; b=M/+Nibno0tcVwAlTdaNv3ToELT
	BCELLWwnPbXqw/YErXT+3RQFE3vdgS3H4/SwlLEYvgRORXyBhCErmUbeP5HpjEDX2utzCIACJwJOw
	SmHDPGdcuD117wZgpKzRX/4ZEivlCAS4xvLF1Znyf2wVhb8AzAODrSnOueyBGBeNP7SJk6alv8c4R
	TugxEMlzMLs9G7LqoMiF3fihYTO5N4rgwXBCDowJGz6jhQoFJsMFpY16dEsOfoyprLnAfhWoK2Gj6
	RKDQJp1AY8fKdfQMvw02PV5vhb12bxj9/pLppnbb8rxieLsk846fJHFQtanFUQHBIfi34IHVkefs0
	Cny1v8wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rll1A-00000004fzL-1qcZ;
	Sun, 17 Mar 2024 07:33:16 +0000
Received: from mail-wr1-f50.google.com ([209.85.221.50])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rll16-00000004fyU-0Thp
	for linux-nvme@lists.infradead.org;
	Sun, 17 Mar 2024 07:33:13 +0000
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-33ed7eb88d9so481949f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 17 Mar 2024 00:33:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710660790; x=1711265590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dzf9HkPavBqg3tIvWy98WN0LdnXe6unSBkuUeEE1SEY=;
        b=hS1C47l09MGqBpmrmXfhk3Irc9htW3rMmBYBws2F+r5UaQAld9qbZJoxZSr77x0Fes
         tRI2cntvWZiOG0JcgVXTJ/0pcws87GNQx8LRWd1NyyU9/cLQiZRQxHecakrls1xQ2Vka
         t+CPQxdtOhZfibvoSlYxm8IainIQmHJZXDk1tgIMS+NEk4KCLEAfmyO3TTfs50SFdyzZ
         7ITfzmjmPDelgH1/ICzgxWM6EFRESn8zV3IDsoecD7ocVR8rdUoiR3V1JcAIkDoRpAlP
         fpda9dEym/PdmpOWcnZLAWZ623xWAyNz8VrLx0kdUQ2JnFr01sIzct9K3VjHK9hKcqx6
         6ydw==
X-Forwarded-Encrypted: i=1; AJvYcCXWLTYBVZUZyMJkEB8HSjnYHMSCuBxZGkUd0iXuqzdRkZfNWHNMnpFQYVFrPD4MJfiJKEpy5bYnUVSyqBz9DYcD4L/uZ9u76Ih+jQqLNDw=
X-Gm-Message-State: AOJu0YwQ/vdmYt+AZ765GjQ8FGyZhkt8QPyK/MxOaNLjpHH5Zr4wPcLL
	KSny2O9BM+VDlszXY7qFXX6Qcl9ThLW4BYTDtvGV+zjMHWyF/VaShlm2Gils
X-Google-Smtp-Source: AGHT+IH6xz5FONLbWgJbpeZCcnU7KCx71IIql3lifGelyNFxEjHilP63cGBHWCq5YrJWdSIWbV2ksg==
X-Received: by 2002:a05:600c:1d2a:b0:413:f1c0:a888 with SMTP id l42-20020a05600c1d2a00b00413f1c0a888mr5259968wms.1.1710660790230;
        Sun, 17 Mar 2024 00:33:10 -0700 (PDT)
Received: from [10.50.4.153] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id d6-20020a05600c3ac600b004140b96dd4dsm1503659wms.21.2024.03.17.00.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 00:33:09 -0700 (PDT)
Message-ID: <2db9e75c-7c17-4f1d-9328-5eb18fd86d23@grimberg.me>
Date: Sun, 17 Mar 2024 09:33:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-multipath: fix bogus request queue reference put
Content-Language: he-IL, en-US
To: mengfanhui <mengfanhui@kylinos.cn>, Christoph Hellwig <hch@lst.de>
Cc: kbusch@kernel.org, axboe@kernel.dk, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20240117065043.79192-1-mengfanhui@kylinos.cn>
 <b926d754-130d-424e-b099-001e14badc50@grimberg.me>
 <20240117143952.GA27918@lst.de>
 <c934831a-ec84-4ea4-a156-782880086ffe@kylinos.cn>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c934831a-ec84-4ea4-a156-782880086ffe@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240317_003312_263822_E43E8F30 
X-CRM114-Status: UNSURE (   6.86  )
X-CRM114-Notice: Please train this message.
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



On 14/03/2024 8:13, mengfanhui wrote:
> Purpose that to check if we ever added a live path (using
> NVME_NS_HEAD_HAS_DISK flag) and if not, clear the disk->queue
> reference.The purpose is to perform security checks and remove the disk.

Does this issue happen in upstream? If it isn't I don't see a reason to fix
a non-existing bug here.

