Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22524ECAAD4
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Aug 2022 13:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+6ybMWm+nJfaMsa9REP+Ibn60VIAbbZOs3JbQXwrqEM=; b=SMmzBrq9n28FpLb41j5L23ZMp4
	TdHeMgNrRrlj1TVQbuZQsP46NAXUgbW9ohCkzfMrnOwT4JutkMPuLhvNVFVdSCC8++F8Gq5alFmFi
	kStQVpCZYjb6WvPnQUHDec4ExciMc2IGxGGM7gbtqbmqDOC7klubd4WAkshBqr+KSEZusAWQnfvls
	wAD7+F9fAhKPcjOcve8fd+HJulLcgJ7ledNtGSFYflGnhxP6p3hxJT7Jr3Li+Vprp1kOwrV65j9Ma
	eLwUELS7/lyidKfSGYacko42DMnEkTjF6M0WhfrWHs2aAx9RwuTkei1M0t7ak3EANHdPj1RUkfdbB
	citBlQ/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT1CB-00HLvs-5G; Tue, 30 Aug 2022 13:22:23 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oT1C8-00HLuz-6S
	for linux-nvme@lists.infradead.org; Tue, 30 Aug 2022 13:22:21 +0000
Received: by mail-wm1-f51.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so6128273wms.5
        for <linux-nvme@lists.infradead.org>; Tue, 30 Aug 2022 06:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+6ybMWm+nJfaMsa9REP+Ibn60VIAbbZOs3JbQXwrqEM=;
        b=a6VgK8PwVd2uL0b0uVx53Jbi6Tdv/Q8v9uP13Bcop1k+UJFpCqZBHj4FCOcva1YkOP
         0UqDCNNAyHqTNRwBMGn7wi1K1BsGc4UBDMzyy2sehzV2sOA8wasxU9pcPDn+JT2wDh1U
         aSrBdKcBNSN5oLiYG7+MsoBQUgP2tzgT8vUQ14dGtSB2BsnRxDq9ukx+rM/9lI1eFpXU
         IEEotXOXXX6zeL/WvFq1eqdTZkCKH2PdOI8lmVhGxATti6RQe/8S7mohNOz8sWmfFFGC
         NST6w5gDiTzV5kKTA8TqAvxyE1df4TO4ESKQsyoHJfuanAOQ2pvck/o3FAO2Wx7o/ca9
         v1HQ==
X-Gm-Message-State: ACgBeo0dkQXtUI0YCCZvMhzSfLbcmPSlEh4UUvNjPFGHjk3X+ece9GGd
	KrfYo4K9Pjab9DSA/3bwAHM=
X-Google-Smtp-Source: AA6agR4EVj13b3Q8Etlia3N8OyLNfJuF1efZvAokNsQECAn/Kptf5xcxuz9G+XtdEtXZAgxGw2ahGA==
X-Received: by 2002:a05:600c:4fc2:b0:3a5:c491:5ee1 with SMTP id o2-20020a05600c4fc200b003a5c4915ee1mr9301593wmq.62.1661865736235;
        Tue, 30 Aug 2022 06:22:16 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id c191-20020a1c35c8000000b003a608d69a64sm12212210wma.21.2022.08.30.06.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:22:12 -0700 (PDT)
Message-ID: <0f7249a9-9e37-0f53-9624-be0ba3932392@grimberg.me>
Date: Tue, 30 Aug 2022 16:22:09 +0300
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
 <301f2b4e-9c7f-875f-e066-e9c3f4bfc9e7@grimberg.me>
 <c046d4c6-49c9-afa4-1740-656517413941@huawei.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <c046d4c6-49c9-afa4-1740-656517413941@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220830_062220_259832_94A8C239 
X-CRM114-Status: GOOD (  12.23  )
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


>>>> when iterating over all nr_hw_queues.
>>> I mean that we need realloc the ctrl->queues for
>>> nvme_rdma_start_io_queues(ctrl, 1, nr_queues).
>>> Otherwise, unallocated memory will be accessed when
>>> the new queue_count is bigger than the old one.
>>
>> That can't happen. ctrl->queues is allocated at the start
>> of the controller lifetime and will never exceed this queue
>> count.
> I don't understand why it can't happen.
> nvme_rdma_start_io_queues(ctrl, nr_queues, ctrl->tag_set.nr_hw_queues + 1)
> is designed for dealing with the scenario that the new queue_count is
> bigger than the old one. it will access the unallocated memory.
> ctrl->queues is just allocated the first queue count buffers at the start
> of the controller lifetime, if the new queue count is bigger than the
> first queue count, ctrl-queues will be insufficient.

queue_count cannot be larger than what the user asked for, and that is
the number of entries ctrl->queues is spanning.

