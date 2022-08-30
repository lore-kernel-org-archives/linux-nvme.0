Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A756FECAAD4
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 08:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MyYjKxeRISls0klFzsZAI9vD8LndzbSX6L+3nhaZK68=; b=EHqNHyZ/c/i5SiMxWj25d6RpGt
	/x5bLYwQuWhb35vauoDJJeXiHhPfSSkrbjGpurbteoNvLY0HMleqOAsBbkDOtzmwyiGTO04x0CMul
	OvqwUgFJta5uSCid+q+TstslemrnYUh4lA/jMlke1lXT8WpC9noFSo+yB3v988tg0+jy49MscR6ZV
	ivYdVfRKOk0tfMABMiw9wLWkozrZ4bqigjcZf4M/mpNU0dfS221yVK4SzCMsfR6vFMjwYjre9bw+7
	FpfIVM3f6glaVQ3Mr6RxE/e6h2bk3f4nYZ/75v6UzujxMi0FzbKDCSo3HTt5iEaWwhNqVuSnCM/aZ
	mkGVGbjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSwWs-00FAro-61; Tue, 30 Aug 2022 08:23:26 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oSwUy-00F9ww-RJ
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 08:21:30 +0000
Received: by mail-wm1-f51.google.com with SMTP id s23so5389233wmj.4
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 01:21:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=MyYjKxeRISls0klFzsZAI9vD8LndzbSX6L+3nhaZK68=;
        b=MfCDUFdCNAEou3xzG0df1WfhjKV0UlnFrHn4d6Rr5a0xCCKQkoo451dGklnVdNUfZX
         f7CwNud0SGWfj4wsvv708UEPUsXW4+K7BIfaZzym6BKeKweKkrepoMDZBhIHiDfSPWfl
         WlskUbEU3WMP2N9tyXFL2NiV+nnp3W0999oA5mFTstoOrwPd0bQBl6CzK+m212rn+rzD
         /OOGVJcINwDXm7LlaZg1Dx1QR5JEqjpHYj3rWjlQhvThMyttneqqhJikv9LrbPkRvGZh
         gg97sXWBcjT5mVSpEObCl1k7EcARyhQBwyZljWb54ifD2DSPYYFZXYaln4Sj/zfl3okc
         yJZw==
X-Gm-Message-State: ACgBeo0YVKxtvSjdeJ6aLtFAGzcJ2/jwhWUBRcNGAOTsa0aQADpePLD7
	h2FLMowP6vp3wTQw/hkYlPI=
X-Google-Smtp-Source: AA6agR6qex3QGM+8ibX8uu3k7iPC2Te/Bo0hUc349eGpIOu75H5TvlQG77Px8H9YkbjU33etE5GL2Q==
X-Received: by 2002:a05:600c:600b:b0:3a5:b811:e7fc with SMTP id az11-20020a05600c600b00b003a5b811e7fcmr9407214wmb.190.1661847686906;
        Tue, 30 Aug 2022 01:21:26 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id v15-20020adfe28f000000b002255eebf785sm9162627wri.89.2022.08.30.01.21.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 01:21:26 -0700 (PDT)
Message-ID: <301f2b4e-9c7f-875f-e066-e9c3f4bfc9e7@grimberg.me>
Date: Tue, 30 Aug 2022 11:21:24 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 3/3] nvme-rdma: Handle number of queue changes
Content-Language: en-US
To: Chao Leng <lengchao@huawei.com>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
References: <20220829083856.1850-1-dwagner@suse.de>
 <20220829083856.1850-4-dwagner@suse.de>
 <5cc0b557-7e56-36c9-cfe4-05ca76f5e83e@huawei.com>
 <20220829093219.6ii76hne6pjzxjws@carbon.lan>
 <8df0c325-0215-4019-d4cf-c7516863dbe4@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <8df0c325-0215-4019-d4cf-c7516863dbe4@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_012128_944118_5B26C290 
X-CRM114-Status: GOOD (  12.30  )
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


>> On Mon, Aug 29, 2022 at 05:22:50PM +0800, Chao Leng wrote:
>>>> +    ret = nvme_rdma_start_io_queues(ctrl, nr_queues,
>>>> +                    ctrl->tag_set.nr_hw_queues + 1);
>>>> +    if (ret)
>>>> +        goto out_wait_freeze_timed_out;
>>> nvme_rdma_start_io_queues(ctrl, 1, nr_queues) need to clean.
>>
>> the teardown path in nvme_rdma_stop_io_queus() is using
>>
>>     test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags)
>>
>> when iterating over all nr_hw_queues.
> I mean that we need realloc the ctrl->queues for
> nvme_rdma_start_io_queues(ctrl, 1, nr_queues).
> Otherwise, unallocated memory will be accessed when
> the new queue_count is bigger than the old one.

That can't happen. ctrl->queues is allocated at the start
of the controller lifetime and will never exceed this queue
count.

