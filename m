Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29715C433F5
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Oct 2022 20:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L9asvsQjLWyfgW9btnkCjW+SGbfmB1KCmQ/6zSqzCFk=; b=mvR4dxhMwRWI+XqkWrY229VpYy
	P9WeHMZNaHvIiTLS7yTYLwTYP773iLSJpsiDEg4MqHlxfBCl72YdmwA0yOuXMnz0J4yuqdSjXLn3d
	fL1XAXmf/FYfDXWgtJwA6BHnMiegH71YUBM/ufJrzLJpjuvlxFUa3BUTxWSKpj4qfYC797PXR48Hv
	7Dr8MO6ad150apwkpyvyR4D48QyzWS85gmiH+16hFL5ft8y0cV9H3Odh3ZfH4BRvKiA1Or73/zDSD
	i8SkOGjdVMXfKZXcGJmt2HFNj1cxt/bDhzGwO8hJDT2YcHvn3X7XjgEhkO+jcVlmQkYmE8Dnf8RnM
	zhXGHoqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogu3U-00AQoY-58; Fri, 07 Oct 2022 20:34:48 +0000
Received: from mail-pj1-f42.google.com ([209.85.216.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogu3Q-00AQmr-Vk
	for linux-nvme@lists.infradead.org; Fri, 07 Oct 2022 20:34:46 +0000
Received: by mail-pj1-f42.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso5704876pjk.1
        for <linux-nvme@lists.infradead.org>; Fri, 07 Oct 2022 13:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L9asvsQjLWyfgW9btnkCjW+SGbfmB1KCmQ/6zSqzCFk=;
        b=ZqGE4oQiNSdl1qRS/ek3v1motMjd13XXsbgxWvcw5wCJ/xVsDxCT3DEufE4RbUyVaT
         vmx4uNrfY05Q3uimiB40BpLbuq/RP4BaH3kLkfPwq6XdU5jMij2ZGTjx7kDJp8yHReBt
         XVdOv2VV13knSMometW88SvMVvw6MMOANv637LPwbS4BEWF3QwUQ912wCyhi5fDc4YuY
         izxfauKgCjGfvcWcUpehSsf2n9VtICmlqQlN07PfnxQ7HDpZqdb028n3N7d6katZDwyP
         F2Y1/wPXGi8uCs5khEheyl7P4aMJ224fE6fFnfD1EKi9bBIrw7mIAvGYIfn02q/QK7Po
         BNVA==
X-Gm-Message-State: ACrzQf0tOxq6pyX484eg9zuo2lyVqGPe31kCsouUvNwE3vMsitvpuHU9
	fd65QNoB1mgkl/4HaosOkX0=
X-Google-Smtp-Source: AMsMyM6BydEaYApF1kpvkydkwGqiz5MHQsEACQXWJZCuF58fkcCQA0BB2Q/t6WtpTKbSDnviD8UTiA==
X-Received: by 2002:a17:90b:3b86:b0:20c:705a:dcdf with SMTP id pc6-20020a17090b3b8600b0020c705adcdfmr940188pjb.205.1665174882265;
        Fri, 07 Oct 2022 13:34:42 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:b72:b06c:f943:31d5? ([2620:15c:211:201:b72:b06c:f943:31d5])
        by smtp.gmail.com with ESMTPSA id p13-20020a170902780d00b0017d0e793932sm533297pll.215.2022.10.07.13.34.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 13:34:41 -0700 (PDT)
Message-ID: <b6e9a4de-3200-f4c5-0665-8e919757035d@acm.org>
Date: Fri, 7 Oct 2022 13:34:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: lockdep WARNING at blktests block/011
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Tejun Heo <tj@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20220930001943.zdbvolc3gkekfmcv@shindev>
 <313d914e-6258-50db-4317-0ffb6f936553@I-love.SAKURA.ne.jp>
 <20221003133240.bq2vynauksivj55x@shindev>
 <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <Yzr/pBvvq0NCzGwV@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221007_133445_064629_8C8BEF74 
X-CRM114-Status: GOOD (  16.71  )
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

On 10/3/22 08:28, Keith Busch wrote:
> On Mon, Oct 03, 2022 at 01:32:41PM +0000, Shinichiro Kawasaki wrote:
>>
>> BTW, I came up to another question during code read. I found nvme_reset_work()
>> calls nvme_dev_disable() before nvme_sync_queues(). So, I think the NVME
>> controller is already disabled when the reset work calls nvme_sync_queues().
> 
> Right, everything previously outstanding has been reclaimed, and the queues are
> quiesced at this point. There's nothing for timeout work to wait for, and the
> sync is just ensuring every timeout work has returned.
> 
> It looks like a timeout is required in order to hit this reported deadlock, but
> the driver ensures there's nothing to timeout prior to syncing the queues. I
> don't think lockdep could reasonably know that, though.

Hi Keith,

Commit b2a0eb1a0ac7 ("nvme-pci: Remove watchdog timer") introduced the
nvme_dev_disable() and nvme_reset_ctrl() calls in the nvme_timeout()
function. Has it been considered to invoke these two calls asynchronously
instead of synchronously from the NVMe timeout handler (queue_work())?
Although it may require some work to make sure that this approach does not
trigger any race conditions, do you agree that this should be sufficient to
make lockdep happy?

Thanks,

Bart.

