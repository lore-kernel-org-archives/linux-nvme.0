Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08DF3C369AB
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Apr 2025 11:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=z08wL9iyWb1VXCRcjme/wszOKP/oNdB4DhXwHTpV9m8=; b=jV2x7qHSlP9/mgJGP8uUPFH5MX
	EBlrUxHZ+Ux1ValwOhIwUNwtKdC++KD7iPaOFcFiVyyFez5NGZMPDjm2f/npIzct9qHa813amVAA8
	oDWSycS88Wlt5p7Q01+LArDeZx/GqjU2LmihFgbHcFQb4YE2ya1jBCj04QatQ9ZtAWd+5XnZ+Nsc3
	ErpykV87euoou27onE+zSQRjjXF8hrxkM7WlZIAsioxhlwnhyE4vcuOW1/iBQrlRPXSzrv1dirs02
	L52zEtuBqgldIgXTBcQP3FvdoLPQmjfP+2527voT0sjViXFwBmind6QaFQj6NDc7yNI9bmJOhypzm
	bl3pvVvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5jgQ-0000000Fway-0SJQ;
	Fri, 18 Apr 2025 11:14:58 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u5jgO-0000000Fwab-0iw8
	for linux-nvme@lists.infradead.org;
	Fri, 18 Apr 2025 11:14:57 +0000
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39ee623fe64so1529450f8f.1
        for <linux-nvme@lists.infradead.org>; Fri, 18 Apr 2025 04:14:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744974894; x=1745579694;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z08wL9iyWb1VXCRcjme/wszOKP/oNdB4DhXwHTpV9m8=;
        b=tGHetUbAayOaYbfJorK87c063jciJ1ZjAZxVsNNTX8Rs0Ey9DDE3E/fI/tF+qkRxvT
         vD2wTrgQ/LgQITXX2nAqnd4v7X/50ihr+P9bEG2jglkE08f5j2GXeKnuLLHPGcVA423i
         /EOyQIhyylrsWRWwUkI9deEmLK1279VECkbSbblIop512QLJChcmu3diwVk529Lw5GCD
         P3N+cyn4tm1PFeYT7Ca2C98nG9/T7Qi7wy7Oer0gaOq32cTRbcWNGETpdi2rOTy/6V+Q
         cWlrifLiaMf9ILHFqigAyZd8BlqIaNGiw5nQW5LBrugD3AXS2+7y9Jr6k7FJhQvWU88f
         fO5g==
X-Forwarded-Encrypted: i=1; AJvYcCXVoBMQniOmOSTZ79qbs7tbCdzujv++p+9cgTMbRqMkPHNEJnYYbLi0b3RipOipFK2XuZ+bT9GU0Y+b@lists.infradead.org
X-Gm-Message-State: AOJu0YyComc80rEpXTjw0qxWu8vBbWCInyKpu6hhsTQe36NieVl63KDb
	qdNuU9HBzy3kWb6+88N6RMXfalBRthHM8v8YaaPqigJTc/BZuiyt
X-Gm-Gg: ASbGncsr/eD2gkr6A96A49neevE6W2pfsAUfnLvqojknUE8uKjR14CQuKnw7lCh+QBT
	Xzlrc7akrnUg3wxZHEOUI9nrDORGXbox8AIgsA7wYrm+daFWXLZ9EvKLa+H2bhKe7E+RX1JuB9h
	jug9eLxKrVaocYQsv2vheMSe61zhluKOV263uwACWC5jCfCAzCJhxr1F/WkkRGIwS+zfrGfLuma
	neUWcO7Gr76U846NTVryhGUDWbR/mNI+XireAa+i1qQAwaspPuACu7yhC2xjIinjKNXxDa93+/x
	i0KY9fpiuTj4S2HuBRr67Hj6TFu46eBTuN2nrTeE
X-Google-Smtp-Source: AGHT+IFFNCEDC5GCC0VsLJ0Cm8olBEJ+QjD3VLcQwqMgGbmAd1Qvl0w859FmXTAIjLjevrguxfW1hQ==
X-Received: by 2002:a05:6000:144a:b0:391:2a9a:478c with SMTP id ffacd0b85a97d-39efba3cc88mr1879518f8f.23.1744974894360;
        Fri, 18 Apr 2025 04:14:54 -0700 (PDT)
Received: from [10.100.102.67] ([95.35.174.203])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43bef1sm2426434f8f.49.2025.04.18.04.14.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 04:14:53 -0700 (PDT)
Message-ID: <0c60225a-6a48-484e-9526-27e699da4f1a@grimberg.me>
Date: Fri, 18 Apr 2025 14:14:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 1/2] nvme-tcp: Prevent infinite loop if socket closes
 during CONNECTING state
To: Maurizio Lombardi <mlombard@bsdbackstore.eu>,
 Maurizio Lombardi <mlombard@redhat.com>, kbusch@meta.com
Cc: hare@kernel.org, linux-nvme@lists.infradead.org, zhang.guanghui@cestc.cn,
 loberman@redhat.com
References: <20250404082801.1614252-1-mlombard@redhat.com>
 <20250404082801.1614252-2-mlombard@redhat.com>
 <c4695327-0a0d-4b8c-a852-ee2ce4beb924@grimberg.me>
 <D966L87J0CQ2.2WV0U5JZEMZ9Q@bsdbackstore.eu>
 <fc197a49-32f9-44ff-be3c-4efa1d42d0b0@grimberg.me>
 <D98XO9X62V98.1OGPR20IUZ9EO@bsdbackstore.eu>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <D98XO9X62V98.1OGPR20IUZ9EO@bsdbackstore.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250418_041456_217639_74EBD7BD 
X-CRM114-Status: GOOD (  12.77  )
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



On 4/17/25 16:04, Maurizio Lombardi wrote:
> On Mon Apr 14, 2025 at 11:35 PM CEST, Sagi Grimberg wrote:
>> I see the issue, but we need to make sure that if the connection closes
>> before
>> the controller finished establishing, then it cleans up correctly.
>> Because at some
>> point in the past - it wasn't the case. Things have changed in that path
>> so it might
>> be ok now... Just need to check. I'd trigger the race while the admin
>> queue is establishing, as well
>> as in the middle of the sequence of IO queues are establishing.
> I believe my earlier testing for this patch already covered this scenario,
> but I can rerun the tests to confirm and report back.

So you indeed made sure that the failure starts sporadically in the 
controller establishment sequence
and there is no use-after-free issue?

>
> Either way, any fixes needed should be unrelated to this patch in my opinion,
> as this one covers the case where the controller
> has already finished establishing the admin and I/O queues.

Well, you are changing code that was added to prevent double free issues 
when the error recovery
and the initial connect sequence ran together. Hence, I want to make 
sure that these issues don't come
back now that you are changing it.

