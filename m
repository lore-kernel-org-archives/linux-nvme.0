Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD85DC25B74
	for <linux-nvme@archiver.kernel.org>; Fri, 24 May 2024 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RL9o1EucUiKUfzLSAEf4MWEvUVNDrZv5GTp4+vNgYb0=; b=keLmTubH5KQ096jqJssxId4gDG
	ZV+KLn/ILOJOd0/x+zEoPl3isQ5XF8536H5zmHlX+ixR2aBWw46Qk3W9hYphVRyWyVcZY3hAhXTNX
	FnKpfScyAo6UJHShVyIvfEq2tupQi4yFRbL8V9WZlrYt+KWKGv2H+9HD0vf2Qko/wlwZ2nbyczw/L
	YMonT3b1XL9psRpHEdiA0C0c6jQhJ3L3/rNZn+9gKr+ph9SdQy205YPLllIys59wWsqay5JP9k3Vk
	8U3q3sUlcDq0QnPfS+e0Q8MoQFbDhUW0G+zcLD6EKEu9wbnYgqQOOrtnfqQATepolaYOBn9jmEm1Q
	sG1oRqaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAWr7-00000009F1b-1TP1;
	Fri, 24 May 2024 15:29:17 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAWr4-00000009F0Y-06PX
	for linux-nvme@lists.infradead.org;
	Fri, 24 May 2024 15:29:15 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-354f89a59b8so403853f8f.0
        for <linux-nvme@lists.infradead.org>; Fri, 24 May 2024 08:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716564552; x=1717169352;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RL9o1EucUiKUfzLSAEf4MWEvUVNDrZv5GTp4+vNgYb0=;
        b=hmBx2Il6OWWPqiE2oDHJGf7PuxUs16lwgZV/OV9w+X+kcfFTb+6Vm8j2prq1+aP6NI
         cOY4vEqL2RDTKdpIMSgoxQ/s/3QBJ2vhqRcxtIWf9D7zKjV9s9JpIMznKA7KlXwcwWW1
         Y+o2C67BNo4300Xp4wPww1TUU9JNjbmz6PFJyZtpm0k/LkPF+gP6PyC/tLxVQmYjcgLm
         Wgc1NfxufGTWxsYtIU+ACkFXZqtbUKnWIDFXsJjTgMU2UgrhwNgfi7cF/EzZ20s94P+F
         FemhV27FofMkgH4RskV21+D3Gw79GcvWEqIq3yRKtY+FLSoxVylPhBsFMjSo8SeDmyZj
         RrFA==
X-Gm-Message-State: AOJu0Ywll4M/Jv7yO2M0Dxcyyl49WKCWLKfLlBZk+ZTMgB+FRPmzhNYx
	Tv4k4xZtDUuIF8L8cpTixm4Drwq7ZCS5AxeyJ+C0R0xFD03+sPIJ
X-Google-Smtp-Source: AGHT+IENock6S47CeMSpEiLJP3DTe4WdB20Tv9MDzMD1Z6B6ZnfPqg87WEvjTrXNbfGaWBa/ROWm9Q==
X-Received: by 2002:a5d:4f04:0:b0:354:dd6a:a5bb with SMTP id ffacd0b85a97d-3552fe17d9bmr1718449f8f.7.1716564551935;
        Fri, 24 May 2024 08:29:11 -0700 (PDT)
Received: from [10.100.102.74] (85.65.193.189.dynamic.barak-online.net. [85.65.193.189])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35579f9649esm1823427f8f.29.2024.05.24.08.29.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 08:29:11 -0700 (PDT)
Message-ID: <27b6c6da-8ee5-4ac8-9e8e-f640261f61dc@grimberg.me>
Date: Fri, 24 May 2024 18:29:10 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] nvme: use srcu for iterating namespace list
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Keith Busch <kbusch@meta.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
 Keith Busch <kbusch@kernel.org>
References: <20240523172050.4080218-1-kbusch@meta.com>
 <c7l5prtn3nxihfvbrecmf32mcfchuwrdredyl5ofhbta4a66v5@f4u3iiyev2ex>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c7l5prtn3nxihfvbrecmf32mcfchuwrdredyl5ofhbta4a66v5@f4u3iiyev2ex>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240524_082914_096053_FFD4CD69 
X-CRM114-Status: GOOD (  12.75  )
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



On 24/05/2024 7:41, Shinichiro Kawasaki wrote:
> On May 23, 2024 / 10:20, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> The nvme pci driver synchronizes with all the namespace queues during a
>> reset to ensure that there's no pending timeout work.
>>
>> Meanwhile the timeout work potentially iterates those same namespaces to
>> freeze their queues.
>>
>> Each of those namespace iterations use the same read lock. If a write
>> lock should somehow get between the synchronize and freeze steps, then
>> forward progress is deadlocked.
>>
>> We had been relying on the nvme controller state machine to ensure the
>> reset work wouldn't conflict with timeout work. That guarantee may be a
>> bit fragile to rely on, so iterate the namespace lists without taking a
>> lock to fix potential circular locks, as reported by lockdep.
>>
>> Link: https://lore.kernel.org/all/20220930001943.zdbvolc3gkekfmcv@shindev/
>> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
>> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Keith, thank you very much for the patch. Sagi, Christoph, thank you for the
> discussion.
>
> I confirmed this patch avoids the lockdep WARN that I reported. I also ran my
> test set with the patch and observed no regression. Looks good.
>
> Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

I'm assuming that all blktests ran with this change? including fabrics 
and permutations?

