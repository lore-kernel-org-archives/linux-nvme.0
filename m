Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AFF3C00A5A
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Jan 2023 14:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OzgsiHNFafg9OuoZBVQAxwkGBmRTSBugx3N+qaA0rBI=; b=eqwg1yQVpDtqUA/trqcjMPz41G
	w8Qw4mcS2ANYgNpUPXg5PArkG62xzdpwVW/bFJ8Ox5czpDYAd1u9Lg2L8IusO8mCC36dcmk4RyFqJ
	GNfMeZxY1jTK9PaKNnjOj7ap1WlzgLHfD43bRZAULvYj9M+CI8IQpx36azFC8o9qjYNgGIGQEBrbb
	NbFi8JWvfhb/l/JngwGTEAxiUN224On4P4PQQehnUdTkl9cYmCkuoSOh7ekAfU1Su9wFIkhvGaGhl
	+m/8wLYLMWScFL2vVwOap5GRyxchBu6IWpdnS1Fgg8DS0SI6M83kalLyYGs0EHhbdkLrIg3cYcZjA
	M636iFfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIVy7-005KOI-Ax; Thu, 19 Jan 2023 14:32:43 +0000
Received: from mail-oo1-xc2e.google.com ([2607:f8b0:4864:20::c2e])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pIVxg-005KFm-WB
	for linux-nvme@lists.infradead.org; Thu, 19 Jan 2023 14:32:19 +0000
Received: by mail-oo1-xc2e.google.com with SMTP id z12-20020a4a490c000000b004f21c72be42so531538ooa.8
        for <linux-nvme@lists.infradead.org>; Thu, 19 Jan 2023 06:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OzgsiHNFafg9OuoZBVQAxwkGBmRTSBugx3N+qaA0rBI=;
        b=ca9PfG3z/EllduhdK6CDNGJ7qAylteR3X1AjKID79cJKs9dNOQtZfCq0WpbYeCFRpn
         AZGBzK1xTiXHeBtUlmTEAJx4GopUssIpHcTttmqZk21lCLTyIsbOuA01LAJU6QUnnPv4
         zppFSpWUaZFPwyxNI9OYcYU6qre5wiqE3X6UKVq3ok01tGCiv7lJwyCoD8OB8Ky3T+v5
         +AuPj/fJtr1a2FmaNIFC3FYxkqSgA4SJ8Ya/RC7ogm3WRLtz47eUePUyBb0Z+IuzIgdI
         yphrOLgWfpM8OLDvA4TNbkRqsxhVurzVZ219FETwgKhDAqH5WQZZceT75HU4nuZIvBUE
         6mxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OzgsiHNFafg9OuoZBVQAxwkGBmRTSBugx3N+qaA0rBI=;
        b=AOYKJAc1LAgJ8Bv0+VnsrRFJ4p6FEL2Vqoj7K+9VJG3ENVYq3Og0SOUtCsTIHdM3rZ
         lYG0yRUW/fn7Yx1aPFbtaoQVTlCznGg1uNhnYcw/OVH/e7PxnzjfuE+TKtT5Mli7SxFH
         hO4OAKPVroU6qmHi6z/dGh6vjADYLsLh/pJrc1XYtWECPQ9uwkvGIPnzM37JL/f9/v1H
         q1pHEbwO8Qxb3hoefR9c8PqdSEHBIFIVEZSgJBPi0yVuYel/j2F7uwHCijiXVZBjjY33
         YdHsHgMwok1hRxbNemEXPNc8n5ezGFOX0lOlFS5qzqPAjkF+rcyHBFCAt5n4D643depM
         gqyw==
X-Gm-Message-State: AFqh2kpmPFjHN9MU/uELGbrIa8sXa0C+b4MTPWfyHDyqa8oM9aGy5Lb5
	rpYPqxTqkzJprghx4MDIuGE=
X-Google-Smtp-Source: AMrXdXuzZK0/qeneeoKtkR5uanVU13P0DyIhyVKzXEDf9UVDbzHQsxVUQcff/azGPvHSfERmd5gibA==
X-Received: by 2002:a05:6820:413:b0:49f:dba7:5e65 with SMTP id o19-20020a056820041300b0049fdba75e65mr4855150oou.3.1674138734167;
        Thu, 19 Jan 2023 06:32:14 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g6-20020a4aa706000000b004f9cd1e42d3sm3702525oom.26.2023.01.19.06.32.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 06:32:13 -0800 (PST)
Message-ID: <01c6a8f8-881b-66b2-781b-c334e3a9fecc@roeck-us.net>
Date: Thu, 19 Jan 2023 06:32:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: completion timeouts with pin-based interrupts in QEMU hw/nvme
Content-Language: en-US
To: Klaus Jensen <its@irrelevant.dk>, Keith Busch <kbusch@kernel.org>
Cc: Alistair Francis <alistair23@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <CAFEAcA9pS7P=SvKsOtRHPtkrNAD8LF2ZpFJ870G3B-rhWYap4g@mail.gmail.com>
 <20230117192115.GA2958104@roeck-us.net>
 <CAFEAcA_T8QqSg4SzszP+wR3pR1P1WTZg4f7mHHBGRw4UrTw+DQ@mail.gmail.com>
 <Y8gfQXPYdHKd1v4I@kbusch-mbp> <Y8h7aOuVfCb+RsAP@kbusch-mbp>
 <CAKmqyKMHs_-RgagMDYE7vn3MHEP2caBc+RERjaK0DNJw4hFYiA@mail.gmail.com>
 <Y8iulgdgOdVCjuKE@kbusch-mbp>
 <CAKmqyKMveR=RD6fgnzY0SV39tofD+Ws_AbrSZXE_o4m=M6GZHg@mail.gmail.com>
 <Y8jBG/j8w2R43kYd@kbusch-mbp> <Y8jxHuVYoTo6KcH4@cormorant.local>
 <Y8j5B+c3mM01d+Gk@cormorant.local>
From: Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <Y8j5B+c3mM01d+Gk@cormorant.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230119_063217_112784_4358E26C 
X-CRM114-Status: GOOD (  22.17  )
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

On 1/19/23 00:02, Klaus Jensen wrote:
> On Jan 19 08:28, Klaus Jensen wrote:
>> On Jan 18 21:03, Keith Busch wrote:
>>> On Thu, Jan 19, 2023 at 01:10:57PM +1000, Alistair Francis wrote:
>>>> On Thu, Jan 19, 2023 at 12:44 PM Keith Busch <kbusch@kernel.org> wrote:
>>>>>
>>>>> Further up, it says the "interrupt gateway" is responsible for
>>>>> forwarding new interrupt requests while the level remains asserted, but
>>>>> it doesn't look like anything is handling that, which essentially turns
>>>>> this into an edge interrupt. Am I missing something, or is this really
>>>>> not being handled?
>>>>
>>>> Yeah, that wouldn't be handled. In QEMU the PLIC relies on QEMUs
>>>> internal GPIO lines to trigger an interrupt. So with the current setup
>>>> we only support edge triggered interrupts.
>>>
>>> Thanks for confirming!
>>>
>>> Klaus,
>>> I think we can justify introducing a work-around in the emulated device
>>> now. My previous proposal with pci_irq_pulse() is no good since it does
>>> assert+deassert, but it needs to be the other way around, so please
>>> don't considert that one.
>>>
>>> Also, we ought to revisit the intms/intmc usage in the linux driver for
>>> threaded interrupts.
>>
>> +CC: qemu-riscv
>>
>> Keith,
>>
>> Thanks for digging into this!
>>
>> Yeah, you are probably right that we should only use the intms/intmc
>> changes in the use_threaded_interrupts case, not in general. While my
>> RFC patch does seem to "fix" this, it is just a workaround as your
>> analysis indicate. >
> +CC: Philippe,
> 
> I am observing these timeouts/aborts on mips as well, so I guess that
> emulation could suffer from the same issue?

I suspect it does. In my case, I have an Ethernet controller on the same
interrupt line as the NVME controller, and it looks like one of the
interrupts gets lost if both controllers raise an interrupt at the same
time. The suggested workarounds "fix" the problem, but that doesn't seem
to be the correct solution.

Guenter


