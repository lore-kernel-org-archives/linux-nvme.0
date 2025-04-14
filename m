Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2041C369B5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 21:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qg+Ns1utWC80v1Wun/6WipTlgWeY35SSoWczjVLyHv8=; b=ELXSYFI6lDIyQb6ZWPZtkPQB7B
	Tsgz98GlNKZa3NsW0lhy9KGEeGzGeHAdWhMW/krRuySTZPfKKLh2CyLq3mWy5fYK7mE+nlqNrkzsq
	vL0UKEwp+VEFBPbKBl7vFpDMqtJSBrDCX52NJ8v4cXl+bYEJdfOihKrxd2mmGMmRzHJ3+BORIvSbp
	9oC71gikwCxVSPVRptmUDgIO1VFJdgBwLydP4i4jT0y0I8TEMQeK/GFUawxFI4mHush2ymst3NkY6
	nRVIWjp+xVULyVK/Q6oVNsszhMueZaBxNOe5F+XXDUVBY0MEDh5XEcwSxQNCcguLYF4A/ns9OVrkc
	0NwQ5Emw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4RU0-00000003ZyY-1N7a;
	Mon, 14 Apr 2025 21:36:48 +0000
Received: from mail-ej1-f42.google.com ([209.85.218.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4RSV-00000003ZrI-0LPS
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 21:35:16 +0000
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ac339f53df9so954964666b.1
        for <linux-nvme@lists.infradead.org>; Mon, 14 Apr 2025 14:35:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744666513; x=1745271313;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qg+Ns1utWC80v1Wun/6WipTlgWeY35SSoWczjVLyHv8=;
        b=v5CXemI5i0X5YYhwxw9/tXbQlIAgbcxdkp8NA37pE7sK2iaI7CX6uP06y1BU6CWy+Y
         9acHFix5yjljOq4loWxOq2RzEX8K/ZgTNRQflA5puIIydij3MsudTE4r4ImvWIWJE0Gq
         xSmDvtlyfabkYgZxsxlX0IVF6lnA8xenLObrv8pyfS1HY/wZM+h/TBF98M+QIS+WG7dk
         v1T5nzs6s8Nx/NpgqMgMRF8PElTmM+BFyyzx2mvcMYeJb8X8BmiqqOpQK+mvRf1sCj8j
         lEJXZ/kBQ7MRJQJG3gMFiNMeXHKgwebMxdIO1MsjwNak0lgxX2tZ6OMnr6qtzBmR2f1w
         hZZA==
X-Forwarded-Encrypted: i=1; AJvYcCU/zl1QEdhcq5eNQR7wykwz1Y46mrExsUjXcdA8ddkoGpS90jRnwWJQDe243J1TcAGHw/YNEnx5E8x6@lists.infradead.org
X-Gm-Message-State: AOJu0Yyo0ie4wDImJv8weU7rZN1cdqTUN/OkrwDeNKiBndyAdX6BVFtv
	WoV/7N02pn/XHQpWOOyVIzwFIvx36aGDRtQ6V8e5yUjq8WLv7DPIgtOumXsM
X-Gm-Gg: ASbGnctiKRq5spwqKBxWG1omu2ftyogR8/zSPBR20zZ3DaArkWWhuNI0t/QZmEif8EA
	88tJHgh2oZNYEn/8uu2XCBlePG1LklG+7oVXQj93CEwOSDyqbFcRE4r+lgTDzOwXKH5SBeq0vNx
	O7qaMz7PwDMGASeGQQJOGTfRMFgeKCvCgnF3+blSrQbbzzLZnegiaRUWL6qoH13v3xFq3HU1Mux
	iOhA7SztgBq1rA4F7DJkF1hxITJDnj5GUxy8iLyIu8GE6cHKITAz87d5gOyajFfVFszKTFgEpI2
	FDjB/JIR8CAsQ6TmcAmwwZT5f1TkCCxqswfvacpmMcS/HNATOjuyLYf/h/q90F+Tvn0NYHT7
X-Google-Smtp-Source: AGHT+IFNNJDqbvCpIB3Wh15MIKDBdxGhgJvsikeKF6H8KaDM/24qC+5pfJ1j+DSSOwMxM0/vn/bomw==
X-Received: by 2002:a17:907:da16:b0:ac6:bca0:eb70 with SMTP id a640c23a62f3a-acad36d9154mr1263146666b.56.1744666512676;
        Mon, 14 Apr 2025 14:35:12 -0700 (PDT)
Received: from [10.10.9.121] (u-1j-178-175-199.4bone.mynet.it. [178.175.199.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1ccd2c4sm961085466b.129.2025.04.14.14.35.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 14:35:12 -0700 (PDT)
Message-ID: <fc197a49-32f9-44ff-be3c-4efa1d42d0b0@grimberg.me>
Date: Tue, 15 Apr 2025 00:35:11 +0300
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
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <D966L87J0CQ2.2WV0U5JZEMZ9Q@bsdbackstore.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_143515_125867_426F7263 
X-CRM114-Status: GOOD (  19.80  )
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



On 14/04/2025 10:25, Maurizio Lombardi wrote:
> On Mon Apr 14, 2025 at 12:44 AM CEST, Sagi Grimberg wrote:
>>
>> On 04/04/2025 11:28, Maurizio Lombardi wrote:
>>> There is a potential race condition that can occur if
>>> the target closes the socket while the host is in the CONNECTING state.
>>>
>>> If the socket's state changes to TCP_CLOSE, the nvme_tcp_state_change()
>>> function is invoked. However, nvme_tcp_error_recovery() is unable
>>> to transition the controller state to NVME_CTRL_RESETTING because
>>> the controller is still in the CONNECTING state. As a result, error
>>> recovery is bypassed, and the controller incorrectly transitions
>>> to the LIVE state with closed sockets.
>> I think that the issue is that the controller moves to LIVE state - it
>> shouldn't.
>> However its not clear where this happens.
>>
>>> Subsequent attempts by the host to communicate with the target
>>> will result in an infinite loop.
>>>
>>> Fix the bug by initiating the error recovery process to correctly
>>> handle the disconnection in case we missed this event
>>> while transitioning from CONNECTING to LIVE.
>> The problem is in the initial connect - here there is no error recovery
>> and we want to propagate the error to the user.
> Maybe there are other problems that I've not found, but this race
> condition definitely exists.
> This can be reproduced by deleting the port, target-side, with nvmetcli
> just after the connection has been estabilished, before the controller
> goes LIVE.
> Yes, it's quite hard to hit it in practice, but if you want to see it
> yourself, a small sleep in the right place in the host driver will
> help you.

I see the issue, but we need to make sure that if the connection closes 
before
the controller finished establishing, then it cleans up correctly. 
Because at some
point in the past - it wasn't the case. Things have changed in that path 
so it might
be ok now... Just need to check. I'd trigger the race while the admin 
queue is establishing, as well
as in the middle of the sequence of IO queues are establishing.

