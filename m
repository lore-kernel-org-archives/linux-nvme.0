Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9756DC19F2A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 09:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DK6hIvfNJmmPv3MAsVSk2g/l4JEAuweSmbOZl+8rwLg=; b=ZtZpkE2EDeOvvEZbIKuqViqZ0q
	r4kXmTi8ZQDscguZ5z3RZdCNtws3SeJktUbb/BdjSIAOxn/azJ5+zhdTa/RJh1lcoMM5un5lxnSKR
	3I9sgZO3QjqnA8z2iX2Ck/HG6OFMNkDxlQh/pYxEuFCOfx4fBIW8jK7ahRhTHBxQ3jE96XA/9Nhsu
	iF8+PXKJL32HsRz1yTVNC844jU+oZMcZtuVqP9aKg3juZFGHechNLrcunh3rhKxxoI/kC5YklAWmN
	J6gR4pcvcp0QFns5mEHiV0S9hCj1LrVMfWaSSAdz+DvRuZlyaBl4Ry2/6+e3YJiuVG/hyQY4MvhEL
	44A74tVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM4bv-00AnNh-B2; Thu, 11 Aug 2022 09:36:15 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM4bs-00AnLW-C6
	for linux-nvme@lists.infradead.org; Thu, 11 Aug 2022 09:36:13 +0000
Received: by mail-wm1-f52.google.com with SMTP id az6-20020a05600c600600b003a530cebbe3so2385673wmb.0
        for <linux-nvme@lists.infradead.org>; Thu, 11 Aug 2022 02:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=DK6hIvfNJmmPv3MAsVSk2g/l4JEAuweSmbOZl+8rwLg=;
        b=dB6L55b6t9+5LVct3puWQr00vVOyM/EEEeqYe+AaEcIk2nrG1aCcSDbK9+Gzz2QXwR
         zhxgi5Gf4T7YSXMy+JXR1M1AuxCFwg7GOhAj7BRZDkCpp2lIgc2LfR4xn7qISfmPZSCG
         csKF+KmiuXS8NB7cjjTS+7HqEjiChFyPVTWYBLl/edDH3zsUF0ptNaXd6Ii4L/xbwydp
         EdNhu1pptxW4oA6/JVqElJYC35pF9LfyLtU8P5xEUX1E/gWM9aE985wYaPjoRl99eX4J
         0+xrTC7rGMTRSAAreMsTbLDcC4+s0vSTL34QJ6hjNyVQIxXy9IYDppALXx86f2+kXAa3
         ujXw==
X-Gm-Message-State: ACgBeo3xkDg1PJyNRLMUwJQkHd6GitXRyV+WEbCLSkyy4vO/ZHvpedCN
	ngXfPPWO8bUunKw18DhH/TM=
X-Google-Smtp-Source: AA6agR5eSX2zL7y/pnqAB7Hx+c7iKtYqCARnJPfBOgIMSss5NluS9164WMGoeQwgWpD8jL/QQeQRXw==
X-Received: by 2002:a05:600c:1e8f:b0:3a3:1cfc:ba6 with SMTP id be15-20020a05600c1e8f00b003a31cfc0ba6mr4993714wmb.177.1660210570255;
        Thu, 11 Aug 2022 02:36:10 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t188-20020a1c46c5000000b003a327f19bf9sm5289035wma.14.2022.08.11.02.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Aug 2022 02:36:09 -0700 (PDT)
Message-ID: <53ed5142-f9ee-f373-25fc-69c14bc372b3@grimberg.me>
Date: Thu, 11 Aug 2022 12:36:08 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [bug report][bisected] blktests nvme/tcp nvme/030 failed on
 latest linux-block/for-next
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-block <linux-block@vger.kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 "Belanger, Martin" <Martin.Belanger@dell.com>
References: <CAHj4cs_7kR6DXi19CWh3veespFT=cJSTD0YGEFt8tw_Y8fEqZA@mail.gmail.com>
 <CAHj4cs8zXRTPpHt0Xu5BtSGtERK8cgniwrRPygEL9R=6qxjT5w@mail.gmail.com>
 <3af8153e-5e7a-f803-4dd4-cf7088a9d7d4@nvidia.com>
 <CAHj4cs90B+=Sjr43Xf+DWXw=oMCFLNPmMdenhyQn9fG=-ZXtVA@mail.gmail.com>
 <SJ0PR19MB45449CEC5FCA24EBE6C9BB90F29F9@SJ0PR19MB4544.namprd19.prod.outlook.com>
 <CAHj4cs82ssuVX25yeHXhtqkkApxJbWDaoyOgq=0u5C4LWF2btg@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs82ssuVX25yeHXhtqkkApxJbWDaoyOgq=0u5C4LWF2btg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220811_023612_459161_91423166 
X-CRM114-Status: GOOD (  17.61  )
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


>>>>>> nvme/030 triggered several errors during CKI tests on
>>>>>> linux-block/for-next, pls help check it, and feel free to let me
>>>>>> know if you need any test/info, thanks.
>>
>> Hi Chaitanya and Yi,
>>
>> This commit (submitted last February) simply exposes two read-only attributes
>> to the sysfs.
> 
> Seems it was not the culprit, but nvme/030 can pass after I revert
> that commit on v5.19.
> 
> Hi Sagi
> 
> I did more testing and finally found that reverting this udev rule
> change in nvme-cli fix the nvme/030 failure issue,  could you check
> it?
> 
> commit f86faaaa2a1ff319bde188dc8988be1ec054d238 (refs/bisect/bad)
> Author: Sagi Grimberg <sagi@grimberg.m
> Date:   Mon Jun 27 11:06:50 2022 +0300
> 
>      udev: re-read the discovery log page when a discovery controller reconnected
> 
>      When using persistent discovery controllers, if the discovery
>      controller loses connectivity and manage to reconnect after a while,
>      we need to retrieve again the discovery log page in order to learn
>      about possible changes that may have occurred during this time as
>      discovery log change events were lost.
> 
>      Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
>      Signed-off-by: Daniel Wagner <dwagner@suse.de>
>      Link: https://lore.kernel.org/r/20220627080650.108936-1-sagi@grimberg.me

Yes, this change is reverted now from nvme-cli...
I'm thinking how should we solve the original issue, the only way I can
think of at this moment is a "reconnected" event. Does anyone have an
idea how userspace can do the right thing here without it?

