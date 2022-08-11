Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACEB5C19F2A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 12:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Hiur2WQwytzBMaRfND7WTjEUNQaTxaBXs1jRHWSw7q4=; b=DSVTVSGB0rRzJL6pzpLILyIt22
	DgGS1xW0bRqWttQa8V7TKp5NXixdYfML/DcHX2vGbMfJw7CON0ZQ0gHSiaqChYiArFKPgMoS60osP
	6zpKoUuGxakBX2NLyokxCr65HCcrrh64Lhx08yQfL57PzRaGAfgoVr4O/pxuhB8hAnsXfD4Ir7xK6
	obx/r1Ju/q9gumzF7nc0K04cRqmCRISwObB/7Qe0CLCA94vfW6jYUSIuVUQfjwlmQq2zbAHQAD6af
	1fxkLAKh/7LuMrQbY9EElBZRTnGMv3vlXapXF+J+qSErRyylaOf36mO5U1ygo0l1ITqU7vcwzc5BS
	nfhddUZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM7If-00C7ai-D7; Thu, 11 Aug 2022 12:28:33 +0000
Received: from mail-wr1-f41.google.com ([209.85.221.41])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM7Ia-00C7XW-38
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 12:28:29 +0000
Received: by mail-wr1-f41.google.com with SMTP id p10so21149133wru.8
        for <linux-nvme@lists.infradead.org>; Thu, 11 Aug 2022 05:28:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Hiur2WQwytzBMaRfND7WTjEUNQaTxaBXs1jRHWSw7q4=;
        b=kJzXLQTzh4Cgt88d5lbUigsxz3bomz8IKbJ5aTkvzWPw776jWSXv4GvU11465yPlZh
         saZUpmo9hXxuKJv2u9O23ohZ++hqrHTa2WmY2fy7+EaTN59sYpUSDqHkaANaSZPsedtN
         9zQ7kd438gC03bJ9/usMoiMEQk9K1aLSoP2o67tdNHmU5eItYUE0HRbcvh/8U6T7R38b
         KXm57eKRIxf9Bj1kGyA6nEQ+YOqPd7SnmmXaPO0DzPpt9bogfvnR9cvOnXyYMeLUWnwy
         rYWzLK6KkrP0IcnE/6erydxbXJJ8AiXF8BLw8rJZv+x4fFJCh84isnN4Z1Gg0Q63nXwE
         Dn5g==
X-Gm-Message-State: ACgBeo2opQgUcK8w0b0MaZWs2sAdgppFzk8dB0Iztq0rao2Nzng2WxeU
	Dhv01T8C+fIjPS+60dbFajZ/sJcI778=
X-Google-Smtp-Source: AA6agR7qE/+mauxY//meaViDX9Obd4PY92EXON4OnbWH/Ay3qmLs/V0iE3IbfLffGnKjgzye11IPmg==
X-Received: by 2002:a05:6000:184c:b0:223:2c8b:c43c with SMTP id c12-20020a056000184c00b002232c8bc43cmr10416480wri.16.1660220903401;
        Thu, 11 Aug 2022 05:28:23 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id j3-20020adfa543000000b00223654e0eccsm9711287wrb.9.2022.08.11.05.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 05:28:22 -0700 (PDT)
Message-ID: <8a510b95-96e3-433e-221e-ffff06e04cf6@grimberg.me>
Date: Thu, 11 Aug 2022 15:28:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bug report][bisected] blktests nvme/tcp nvme/030 failed on
 latest linux-block/for-next
Content-Language: en-US
To: "Belanger, Martin" <Martin.Belanger@dell.com>,
 Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>
References: <CAHj4cs_7kR6DXi19CWh3veespFT=cJSTD0YGEFt8tw_Y8fEqZA@mail.gmail.com>
 <CAHj4cs8zXRTPpHt0Xu5BtSGtERK8cgniwrRPygEL9R=6qxjT5w@mail.gmail.com>
 <3af8153e-5e7a-f803-4dd4-cf7088a9d7d4@nvidia.com>
 <CAHj4cs90B+=Sjr43Xf+DWXw=oMCFLNPmMdenhyQn9fG=-ZXtVA@mail.gmail.com>
 <SJ0PR19MB45449CEC5FCA24EBE6C9BB90F29F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <CAHj4cs82ssuVX25yeHXhtqkkApxJbWDaoyOgq=0u5C4LWF2btg@mail.gmail.com>
 <53ed5142-f9ee-f373-25fc-69c14bc372b3@grimberg.me>
 <SJ0PR19MB4544485314F5FDAF0159C0ABF2649@SJ0PR19MB4544.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <SJ0PR19MB4544485314F5FDAF0159C0ABF2649@SJ0PR19MB4544.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_052828_160528_815F2688 
X-CRM114-Status: GOOD (  17.65  )
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


>>>>>>>> nvme/030 triggered several errors during CKI tests on
>>>>>>>> linux-block/for-next, pls help check it, and feel free to let me
>>>>>>>> know if you need any test/info, thanks.
>>>>
>>>> Hi Chaitanya and Yi,
>>>>
>>>> This commit (submitted last February) simply exposes two read-only
>>>> attributes to the sysfs.
>>>
>>> Seems it was not the culprit, but nvme/030 can pass after I revert
>>> that commit on v5.19.
>>>
>>> Hi Sagi
>>>
>>> I did more testing and finally found that reverting this udev rule
>>> change in nvme-cli fix the nvme/030 failure issue,  could you check
>>> it?
>>>
>>> commit f86faaaa2a1ff319bde188dc8988be1ec054d238 (refs/bisect/bad)
>>> Author: Sagi Grimberg <sagi@grimberg.m
>>> Date:   Mon Jun 27 11:06:50 2022 +0300
>>>
>>>       udev: re-read the discovery log page when a discovery controller
>>> reconnected
>>>
>>>       When using persistent discovery controllers, if the discovery
>>>       controller loses connectivity and manage to reconnect after a while,
>>>       we need to retrieve again the discovery log page in order to learn
>>>       about possible changes that may have occurred during this time as
>>>       discovery log change events were lost.
>>>
>>>       Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>>>       Signed-off-by: Daniel Wagner <dwagner@suse.de>
>>>       Link:
>>> https://urldefense.com/v3/__https://lore.kernel.org/r/20220627080650.1
>>> 08936-1-
>> sagi@grimberg.me__;!!LpKI!lYFKeBqI0lmp0AycSrZ6krKxEMUNjSwCO-tY
>>> -FyMAu5KLid5bBqYpfEBGaRgfGtk1c3HLXUekSSPXr6pKw$ [lore[.]kernel[.]org]
>>
>> Yes, this change is reverted now from nvme-cli...
>> I'm thinking how should we solve the original issue, the only way I can think of
>> at this moment is a "reconnected" event. Does anyone have an idea how
>> userspace can do the right thing here without it?
> 
> Hi Sagi. We had a discussion regarding this back in January (or February?).
> 
> I needed such an event on a reconnect for my project, nvme-stas:
> https://github.com/linux-nvme/nvme-stas
> 
> This event was needed so that the host could re-register with a CDC on a
> reconnect (per TP8010). At your suggestion, I added "NVME_EVENT=connected"
> in host/core.c. This has been working great for me. Maybe the udev rule
> could be modified to look for this event.

That is exactly what it does, that is why nvme discover unexpectedly
connects to all log entries, because the udev event triggers..

In order to address the problem of missed AEN while controller was
disconnected, we need to re-issue the log-page on a re-conect, not
a first connect.

