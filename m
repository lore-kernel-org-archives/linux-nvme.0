Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82789EEE27F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 02:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8WiAUOJol0H/8Zg9tIhphVBTbRJpyNgrQTkY0dFH5yY=; b=1YLOZ1hZbT2ugJMCibGGjUz/CR
	PUvutfuF4RTPWVgZSVQyl9x9ZDuJbM0bDorU+CSV0nM7qprd6UEzKmxAknOe9EMnyMPrBfUHCeWVI
	g8Uwmz2wewrwKebFCEj41xNwNJTTqHCDIbPD2PcyFIOCZ5C9hWb662SJi+uDN6R3NOIoRrZGxC8LD
	eaX+ZjOPmJVu5P25lMB0vRCff2aRcQiJGVP62eRqvW+EWsu7s3B7QWn6k6murbQNZHhn7hIjbSWyc
	T/NrUfi2pEkZJ9mJmQ3vLGHcXCR7JyrzM4SWE+kDo56b7ef6eJ4b0zE2EVy6MIwWPuBsty+eCPzIp
	trc3jbAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sovtZ-0000000Ej3l-0YHz;
	Fri, 13 Sep 2024 02:18:49 +0000
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sovtW-0000000Ej3I-1OW9
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 02:18:47 +0000
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2d8741c85bdso258620a91.1
        for <linux-nvme@lists.infradead.org>; Thu, 12 Sep 2024 19:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726193925; x=1726798725; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8WiAUOJol0H/8Zg9tIhphVBTbRJpyNgrQTkY0dFH5yY=;
        b=M0243XTYeiNx5hUoGYQFvdoTZFUelrKtAFQ+4JK9gvbGNP9iAYDoxyZuESby585tYK
         br1W6jbg3MeE4vsrMCKVZ+8xLvGEXVY7GbU7H+ueYw7O6sLzhlW/juJKK7ABX9/cH/B2
         yfyDSzl+SfBB2mBZvbFqzGCQWGcztGAM42zN6Rz881Wu8T65h2v25l++u18ubjAHTmxE
         mKrsuxv08pLStGLlX4qjS0H2FM0AeXpOy2gYDZqydYMTcvmhvIXpczDzddp32dkb2Zmw
         FU5JphrWO+eYG2XnnKNExUm/8LpHCv2UEmqOrfemXpJo2MU7B/icOB07qmfAVa6VEA4X
         z7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726193925; x=1726798725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WiAUOJol0H/8Zg9tIhphVBTbRJpyNgrQTkY0dFH5yY=;
        b=k6s+C0RtBPSM2Wlt7EDD+o+IytHz6+3K421s4YwvyqrWoutoCkl81gOXt1pMVyF19W
         b1W+WUcFoB3bMhQbySHkjWc4kKKVHg4y3mT0diA82ZI9SS/Y2n8EuKRebieA3+UWdoMP
         CWsY02ND3UWU+7EUPfDzfwr3Om2uYRLgkBIj3nV4UsJoOtRi2E3ZZa6aIkl/PlZM9ghD
         1kxHyoksuVqWNBRyg0E1cOisjn2IXKxOHa5jBTT56s2nXfL7sd8JTbNAgZceDniJ8+Ju
         K8nIJ2rE1RUlhxN6p+40uJfU8uGyKJg/PUR/B0X5ScZ8Nw42NkyGJ6dOlgn5w0o8GsDf
         5t5g==
X-Forwarded-Encrypted: i=1; AJvYcCWgMnkRPNrXlTqj10MQ046HKJ7le+8FKD4PXZYITOuV9xP95GR1zUDn60Z1j3t5mjNfNsttDyMf3T0O@lists.infradead.org
X-Gm-Message-State: AOJu0Yz9E+2qCtej+qSfKZiJhB7kzHFgWIy3CCl7j2EgsqygjMeW6GjN
	SIEJkiNpE1me3Bpz5zERnbdVUsNo2Leer0mCeDtDxFMB7xs/TRoyF8uzH9IEUds=
X-Google-Smtp-Source: AGHT+IHdtO8+cxbhbeqI3tP7JHLgV5iEvjTj4rxH+AkHVwfb6JRLwpN4Fv3w0alSftU+SsX6SGovWg==
X-Received: by 2002:a17:90b:1043:b0:2da:a6d4:fd5d with SMTP id 98e67ed59e1d1-2db9ffa200bmr2311583a91.1.1726193924807;
        Thu, 12 Sep 2024 19:18:44 -0700 (PDT)
Received: from [10.89.64.12] (mail.misaka4e21.science. [198.181.38.98])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2dbb9ad527asm455230a91.0.2024.09.12.19.18.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2024 19:18:44 -0700 (PDT)
Message-ID: <57fa3e1e-0b15-4dc9-a4ab-f7c4a1af57cb@gmail.com>
Date: Fri, 13 Sep 2024 10:18:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Force ns info updates on validation if NID is bogus
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>
References: <20240910095006.41027-1-xyh1996@gmail.com>
 <20240912094020.GB13465@lst.de>
Content-Language: en-US
From: Yihan Xin <xyh1996@gmail.com>
In-Reply-To: <20240912094020.GB13465@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240912_191846_396103_D478F737 
X-CRM114-Status: GOOD (  15.32  )
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

Dear Christoph and others,

I mean that, for example, there is nsid 1 on the device,
the kernel discovers it as nvme0n1. When the device
had been reconnected (in my scenario, after resuming
from an s2idle), the kernel would recognize the namespace
as nsid 2, although it is still nsid 1 on the device,
which makes the block device not found.

As Hannes said, it shall be myself misunderstood the
reason that leads to this situation.
I will try looking into the real reason. Maybe there is
something wrong in the controller?

I am sorry for the inconvenience causing to you all.
(Please forgive my poor misunderstanding, I'm very new
to kernel development.)

Best regards,
Yihan Xin

Christoph Hellwig 於 2024/9/12 17:40 寫道:
> On Tue, Sep 10, 2024 at 05:50:06PM +0800, Yihan Xin wrote:
>> When validating a namespace, nvme_update_ns_info()
>> would be skipped if nsid changed. However, this
>> happens everytime the in-use controller is
>> reattached if NID is bogus, causing nsid not being
>> restored to the previous one, eg /dev/nvme0n2 ->
>> /dev/nvme0n1.
> 
> What do you mean with restoring the nsid?
> 

