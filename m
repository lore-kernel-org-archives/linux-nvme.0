Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF05C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 11 May 2022 00:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QoRYyZFYqOCYeEPoaKoS4IMRtm0mxY9WhxzlW1K9FLc=; b=tXvdT8TMD277umUA7tDho2bqvM
	V2dIig/iklnA5uEGwj3Tq7QiIziIAJz9y/bzmfk7vwNC6j72stcX/aKa1XGiSYDnVjGDKcMZRe9yK
	q5dbJC+4zIe0hgWaidlgK5mx52UalRKG+yhm6dvGTrb30eamXTHTSryjpprRGQAsBNpa4sA+lxzgD
	NEuH86fVe7Y+Eh2y3aDiIAbhm8ZLnVTJDupfwgn8Z1oIk7/2TsneU5DhgwwLdU7GHeZzX3k4Z0Kgw
	dqSCeY38yeoMh0Q1Glk2G+u2t3V6/1hZ29s6FujoiG1PWkUN7xLbML+gwFYvav473rYElI2WUy82Z
	9TJYg4TA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1noZrp-004Sma-Nf; Wed, 11 May 2022 00:06:13 +0000
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1noZrl-004SmB-AX
 for linux-nvme@lists.infradead.org; Wed, 11 May 2022 00:06:13 +0000
Received: by mail-pf1-x42a.google.com with SMTP id y41so506965pfw.12
 for <linux-nvme@lists.infradead.org>; Tue, 10 May 2022 17:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=QoRYyZFYqOCYeEPoaKoS4IMRtm0mxY9WhxzlW1K9FLc=;
 b=VkYVMjzV+TPFdj749OMz9tAsMC9F7OhhKUI0/CMtRoMYSVPKVul3/+ISEV21Mt5BCC
 pwC+DUHIKQ27hcE7kQQpzRU+wGjn4TURxgbNXhRNzncYnXPesuBtmAKnpeCv0fGPTxS7
 lAtWhW4FzNw86082+A8zazgWG+eB6EW5FMlhXFzbBqwntYtE8uSpHqCu4FJV4ykEJzDx
 iQid2t3QiuflehZ084uHNE9gelqudoj59Et/hWywVm2B9IPCd6Pxp2RhvhtA5AKUAyjB
 ycqjppbk9los2XHgpwkhET4QfUR4Qg3w/Em6LJ/msZWqjJnAJxD3xuXWa74VjjDhqrGE
 42bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=QoRYyZFYqOCYeEPoaKoS4IMRtm0mxY9WhxzlW1K9FLc=;
 b=Br2nfv2Bs8Nq29B+hjRmQr/dXzlt+qgWTRCVjpHYqP0mXAh3yk0mKNh5BREIelrGuV
 2t0IqG11BAo9he+wgG5DC62ILhPAxFsoZFaEz8ClIJSat+HDmSWsGE7mlJewko3HKoay
 GNi3lja+q9gyUq1n9ji8FJH34VON9L40R1EF4g92SYwXS91j+34oq3soF44InbI62MLz
 wpAdwVakjvNppIK8y9MizcQTU/OxTUAOOIYRvAWAm1exO93tYnR4j9AQ1Odc99wP6Uss
 BdMGPADrgKNlGaZwlgnFSu++KGWoHFs+iqXqoekn06UmlOYAQxR+BRyLLVer/0cFafH9
 obtg==
X-Gm-Message-State: AOAM530m+z+sKGl6CB1B8/baHkus5bIvhqmZKYTOvGNB5q1ICzfTsEze
 FprZatn8ho4JhqpXg/9mJAOH7Q==
X-Google-Smtp-Source: ABdhPJymSIxMmHAzXsVLUOe9z+7vsY1KbCrEE3tZ9MEhiemiYYcHvtEYR6p0zSkPWjjgpUUtD3e4ag==
X-Received: by 2002:a65:6451:0:b0:3c1:cb83:8e4 with SMTP id
 s17-20020a656451000000b003c1cb8308e4mr18668161pgv.339.1652227566423; 
 Tue, 10 May 2022 17:06:06 -0700 (PDT)
Received: from [10.255.89.252] ([139.177.225.255])
 by smtp.gmail.com with ESMTPSA id
 c14-20020a62f84e000000b0050dc76281e8sm116517pfm.194.2022.05.10.17.06.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 May 2022 17:06:05 -0700 (PDT)
Message-ID: <21bb1776-6ee9-c32d-0049-cd52b14fd133@bytedance.com>
Date: Wed, 11 May 2022 08:02:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: Re: [PATCH 0/3] nvme: enable smart AEN
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>
Cc: axboe@fb.com, linux-nvme@lists.infradead.org, kbusch@kernel.org,
 hch@lst.de, linux-kernel@vger.kernel.org
References: <20220507065026.260306-1-pizhenwei@bytedance.com>
 <3c233d71-af16-d230-c207-b9c2ae38afbb@grimberg.me>
From: zhenwei pi <pizhenwei@bytedance.com>
In-Reply-To: <3c233d71-af16-d230-c207-b9c2ae38afbb@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220510_170609_589310_B8F37DAC 
X-CRM114-Status: GOOD (  11.66  )
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



On 5/11/22 03:13, Sagi Grimberg wrote:
> 
>> Hi,
>>
>> There are several changes in this series:
>> - Add missing NVME_SMART_CRIT_PMR_UNRELIABLE enum type.
>> - Add missing NVME_AEN_CFG_SMART_CRIT_* enum types.
>> - Enable smart AEN.
> 
> Is there another side to this patchset? meaning some userland agent
> that listens to these events and does something with these?

I tried to test SMART AEN end to end by QEMU NVMe emulation. I did not 
realize that the SMART AEN CFG is not optional.

Also sent this to QEMU(Klaus corrected me):
https://patchwork.kernel.org/project/qemu-devel/cover/20220507072644.263105-1-pizhenwei@bytedance.com/

-- 
zhenwei pi

