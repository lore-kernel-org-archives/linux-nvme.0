Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5F5EE4993
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Aug 2023 10:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xzS6FOY5DluVyxJ0R/l4YI6y1Nc/Zcc8HgLIVuxHk50=; b=dHfV3a2tIDmwBQqoZgg4Dm9voN
	OpwLQeUnq/m0UhfK1j88rqzYoXUBwgI/MmwvjsUOkCtLZS3k5qFywFWdjuyJ9IdR3VpeiBMgqhD0o
	i7zEi0sBpc3mcB0qTq2B2Sv4B7ubMxFP0BJZ1/lEddBrjJbOobnZwamo6Rs5xo3F7mzeAdhX8W8xi
	4YtRJRc20NpJ4CERu6pdt5dJlejD8WfnNxYTc0+aNOHsupi0bjah+JYceHKxw8H9j4RGS/ZAEaIHx
	yDbsiF+DaFALcyiu7BHryV1Zxl3oyWmi8OEfwijnSPIKMiPvP8mjZnZDDGTsuthX4vRTrF70M8ODf
	K7cZMC5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXg1I-00BkFd-2z;
	Sun, 20 Aug 2023 10:50:56 +0000
Received: from mail-ej1-f49.google.com ([209.85.218.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXg1G-00BkCu-04
	for linux-nvme@lists.infradead.org;
	Sun, 20 Aug 2023 10:50:55 +0000
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-99dff8b95b9so60423166b.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Aug 2023 03:50:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692528651; x=1693133451;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzS6FOY5DluVyxJ0R/l4YI6y1Nc/Zcc8HgLIVuxHk50=;
        b=aFZLUsCrLagFJaGAYV4VJJve/Bq4BbEnB7kKS5p1vA2+h47Ns7oEzajieaFWX9Lfz3
         Tm3haGFXBPAgz/QIEG/k/dH72jfNzv6KibwX0QepXJLfcsrqmzWF+Jtr0R5aD0fNKaOf
         9+EMAZg72X3e4UTpg8GjSZZgS/f/0AKuNHZunO0c8OL+PD8SKSHLibQGbYSPVCd8CHL0
         UhTK+HInEiiBHf5ze++6Dor6ih9YybxRrwmKh2sOvy6beL3ijm3T/p0YAlfzL6O/2gP4
         jiYs02Iz6zRlQBwnqh9a7H6D8rbQa9ml1l8PyVF6V1Ep0IMoCNxtUNClbNFmCocc54X9
         tO0g==
X-Gm-Message-State: AOJu0Ywt4nRod3abUKOZDLq+7+bmgwWsY33cHPn2Fk3JebdJZIkbEiqt
	jJmtemkC7BLT//Ju6XK3imM=
X-Google-Smtp-Source: AGHT+IGw3UA/xFtqp40aBGeG//jAZQEVe97PIsavTwgbZi2r1SQHPVDIDp3n8XwqvtSDU4F2kt/UKw==
X-Received: by 2002:a17:906:535d:b0:99c:d995:22e6 with SMTP id j29-20020a170906535d00b0099cd99522e6mr3037131ejo.3.1692528651192;
        Sun, 20 Aug 2023 03:50:51 -0700 (PDT)
Received: from [10.100.102.14] (46-116-234-112.bb.netvision.net.il. [46.116.234.112])
        by smtp.gmail.com with ESMTPSA id s15-20020a1709062ecf00b0099cd008c1a4sm4398763eji.136.2023.08.20.03.50.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 03:50:50 -0700 (PDT)
Message-ID: <f92abcda-695a-b427-f342-a3540a45be1a@grimberg.me>
Date: Sun, 20 Aug 2023 13:50:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v12 10/26] nvme-tcp: Deal with netdevice DOWN events
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, hch@lst.de, kbusch@kernel.org, axboe@fb.com,
 chaitanyak@nvidia.com, davem@davemloft.net, kuba@kernel.org
Cc: Or Gerlitz <ogerlitz@nvidia.com>, aurelien.aptel@gmail.com,
 smalin@nvidia.com, malin1024@gmail.com, yorayz@nvidia.com,
 borisp@nvidia.com, galshalom@nvidia.com, mgurtovoy@nvidia.com
References: <20230712161513.134860-1-aaptel@nvidia.com>
 <20230712161513.134860-11-aaptel@nvidia.com>
 <b94efb3f-8d37-c60c-5bf6-f87d41967da4@grimberg.me>
 <253pm3nuojy.fsf@nvidia.com>
 <186675e2-464f-bec4-1a26-5a516ef11540@grimberg.me>
 <253bkf5vjyu.fsf@nvidia.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <253bkf5vjyu.fsf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230820_035054_082703_B75FAC6F 
X-CRM114-Status: GOOD (  15.58  )
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

>>>>> +     switch (event) {
>>>>> +     case NETDEV_GOING_DOWN:
>>>>> +             mutex_lock(&nvme_tcp_ctrl_mutex);
>>>>> +             list_for_each_entry(ctrl, &nvme_tcp_ctrl_list, list) {
>>>>> +                     if (ndev == ctrl->offloading_netdev)
>>>>> +                             nvme_tcp_error_recovery(&ctrl->ctrl);
>>>>> +             }
>>>>> +             mutex_unlock(&nvme_tcp_ctrl_mutex);
>>>>> +             flush_workqueue(nvme_reset_wq);
>>>>
>>>> In what context is this called? because every time we flush a workqueue,
>>>> lockdep finds another reason to complain about something...
>>>
>>> Thanks for highlighting this, we re-checked it and we found that we are
>>> covered by nvme_tcp_error_recovery(), we can remove the
>>> flush_workqueue() call above.
>>
>> Don't you need to flush at least err_work? How do you know that it
>> completed and put all the references?
> 
> Our bad, we do need to wait for the netdev reference to be put, and we
> must keep the flush_workqueue().
> 
> We did test with lockdep but did not notice any warnings.

I'm assuming you are running with lockdep and friends?

> 
> As for the context of the event handler when you set the link down is
> the process issuing the netlink syscall.
> 
> So if you run "ip link set X down" it would be (simplified):
> 
> "ip" -> syscall -> netlink api -> ... -> do_setlink -> call_netdevice_notifiers_info.

ok, that should be fine I think.

