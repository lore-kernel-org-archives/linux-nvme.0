Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 771BFC369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 11:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RpRkdpAvcp854nYcu4b+4U/JshdV4biSxvSAiqFQCS4=; b=gBwmxFYOY1N7aZFtv75SQPEU7F
	TsYr1WuFj/vyHnKmdxcDVhf6VxDiJVtHaDkK5YmUUhihImC3qZMX3ersNsQdGOKMU9m8lpOYPhQjE
	EVXz9Q6x/sJW5LAcASlEh1V2zpoM/Rzi4mv01KPosNU/HOZbR50bGSfJNJ2gKUHfKYL1j8hF0buA6
	TNSUMZr1toyj4/8M8NaCKP+jXzu5zQRUJemCXdhjrHJnhpT8Pz2PM6yZgZY9izl/b5clGbTEEPp1H
	u6R2eu70eyJcpyqFy1HTVxKuMEUrwWGPHLtRCIYGgDFaGC/lrI5uAZCmdQtiGfCLDhpr3VeVUYNyR
	dTaMZlBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5jdz-0000000FwPN-1UI1;
	Fri, 18 Apr 2025 11:12:27 +0000
Received: from mail-wm1-f53.google.com ([209.85.128.53])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5jdw-0000000FwOw-2syg
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 11:12:25 +0000
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so14853325e9.1
        for <linux-nvme@lists.infradead.org>; Fri, 18 Apr 2025 04:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744974743; x=1745579543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpRkdpAvcp854nYcu4b+4U/JshdV4biSxvSAiqFQCS4=;
        b=nqx6GuHGNrEzeap6ycuuz0eC4+d3JvohSS2eg1Ln4ffeJz44ZIxjhA1Y9/swWZmLpw
         3XusShVx0U5jMcNUQjlPqLWAeWtz8qNfSTvxf4zTyBb9bF+fdDEX+wTXSuzpu/bbFLQN
         X0lI9es8SYNI+5r/4SWT7pYMDWwHhQT7uqfCuj1WsXAe/uPxTwNlXii1+Jy9IMNeBM2Y
         KaOUZqcfRqmkA9xPOICIMf20gs2oUJDQys2bX/02VBkywLNAajdqr5P2SELTMXllfRak
         f1zgcKqDa2B82gfS60nE0DxsiHHfjx1bDXjlsPMhx8QcDWt7mD8eJoj1H+90HcgRjPKx
         q7Bg==
X-Forwarded-Encrypted: i=1; AJvYcCX4EE4/diaVFLvIB/onbL5ivzYCriQicdZQbJIxEfXfs63eu8smDk8wyiTwhlftvINkBBcdVC0y1wMc@lists.infradead.org
X-Gm-Message-State: AOJu0YzZ7S4KVQ4B58xFIVWM5nt//MIoXh/CZaZjjfjC9fPv+mJSmvpJ
	snxNFklvEiQ7T5BL+Y5835h/P3NNixZzxzTBVmil7wNSMyfspyCB
X-Gm-Gg: ASbGnctb5mDpl+bPo8UMfthpNozoPYtoekl0sIq3OGljqyLptXZBUaYXlZGaTCco83M
	c/D7UZuwb2UaBZNBv1OCpUOxhJ0DDAlzgt9WqRC0FdsEMx/wENVVYzEwqZjajZIOqJNp9GEhTFH
	8x8N+FqeFfAi072jSVKkJeh3fJgF7gCFL48qXeMmwfOFGstYe5YSjMZQHCJ3yXwvKDZ1rewoozV
	FwtytkIBQhU+2Hdxkm2NO8+kVJXs7XQLSoq73LSISWicFUK6qZz02eN5IGIqCGRbLzlFR8agg6y
	nSEdJmTAKm504MBU6ugMOB7giMBEwiVeI2DauLEn
X-Google-Smtp-Source: AGHT+IGEaAKjfS32bGQ6rS1F37l8e7oX86YEhNDtBpzVo2GimGfeu8eW3mL/z8rsZ94QlstP6mVcMg==
X-Received: by 2002:a05:600c:524f:b0:43c:fb8e:aec0 with SMTP id 5b1f17b1804b1-4406ab7ff18mr17711095e9.1.1744974742729;
        Fri, 18 Apr 2025 04:12:22 -0700 (PDT)
Received: from [10.100.102.67] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4406d5bbcaasm18759785e9.21.2025.04.18.04.12.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 04:12:22 -0700 (PDT)
Message-ID: <83b86e82-4e9a-435b-90f1-1c676afdc83e@grimberg.me>
Date: Fri, 18 Apr 2025 14:12:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nvme-cli connect regression
To: Daniel Wagner <dwagner@suse.de>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 bluca@debian.org, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>
References: <b0904029-2ffd-4ea9-a8b7-bf7d4182ea29@flourine.local>
 <6b081163-2b00-4de9-85c1-7bc72909f90c@grimberg.me>
 <066cb0d9-95b1-49ac-92b4-43a212d0a7fa@flourine.local>
 <076c96a5-f399-457f-9ef1-491d81e0d8fb@grimberg.me>
 <CADUfDZo8mRaaT3RhXXGJiXmkkgUmY6+=O8cEPp2rE-U-LMupKg@mail.gmail.com>
 <d7737471-8b06-4a78-af2a-6d8e3fb8ba38@flourine.local>
 <d1d76c7f-e8c7-4554-adf0-663bb49d2d82@grimberg.me>
 <852a4c64-9ed3-41d3-adc0-ae18aa320fa7@flourine.local>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <852a4c64-9ed3-41d3-adc0-ae18aa320fa7@flourine.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_041224_723102_67F25631 
X-CRM114-Status: GOOD (  13.67  )
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



On 4/17/25 13:12, Daniel Wagner wrote:
> On Thu, Apr 17, 2025 at 12:26:51AM +0300, Sagi Grimberg wrote:
>>> I think I can reproduce it. I have two connections and do a
>>>
>>>      while nvme read ....; do yes; done
>>>
>>> and block one of the connections, when the error handler kicks in the id
>>> ns command fails with EINTR.
>> What happens before Caleb's patch though?
> I am able to reproduce it with the distro kernel 6.13.9 on my laptop
> (real hardware) but not with one of my test setups (qemu) and a strip
> down configuration. Neither HEAD, v6.14 or v6.13.8 is returning EINTR.
>
> I will try the distro config in qemu as next.

Does this change make the issue go away?
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 5041cbfd8272..87177ec75e49 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1517,7 +1517,6 @@ static int nvme_tcp_init_connection(struct 
nvme_tcp_queue *queue)
                 msg.msg_control = cbuf;
                 msg.msg_controllen = sizeof(cbuf);
         }
-       msg.msg_flags = MSG_WAITALL;
         ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
                         iov.iov_len, msg.msg_flags);
         if (ret >= 0 && ret < sizeof(*icresp))


