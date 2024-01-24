Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03C18C46CD2
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jan 2024 19:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F6WIWhJATA1SsppEYdczg5RfpFlWPa9HCZcE6BQQX/A=; b=rEuxMJ53gThX4/Fmz9MxDMt7VD
	PQLLpbqBYCjdqQsmFUJ17duTSVgk0m5z2LE3IGNMnXQO+nNVdJIPsZsKhECBroejy0U3kqW4OrjK4
	XphA5/skLm9qGlLwqagg9sPC1e/I2h3fwGyCip6dTlTmv6n16LvQA3KALAzoPvb+32qBOSAcSaJSD
	O2cSJTwY9k/TsLA+lXRXAUUDnpouT6gwXmyfwzgkQie0ZjzizXmcpPDSSO+j5HF1i1hi9J/hgB6D0
	UmXljUWt1lSdUviE+kPGZ8k1K2SODVF4JJS23gm25A5aIFMsN0K9JxAo/RH/OEmRAaE5i8mucwt8x
	tE8/z5tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSizX-004scI-2l;
	Wed, 24 Jan 2024 19:32:55 +0000
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSizU-004sbf-21
	for linux-nvme@lists.infradead.org;
	Wed, 24 Jan 2024 19:32:54 +0000
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3bdbf401bd3so2017385b6e.0
        for <linux-nvme@lists.infradead.org>; Wed, 24 Jan 2024 11:32:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706124770; x=1706729570; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F6WIWhJATA1SsppEYdczg5RfpFlWPa9HCZcE6BQQX/A=;
        b=hOayEIAuJswt4O1scMagzf8ARjIaWmFc+qffPSmep9Zh3LJ9MtLXPGq9THwtIodpmJ
         SBqDzsI0XMPP4mxgEz/1EofOpJrInLPM61RWp+veY3J8rDJ97fLwSGmNGUub2rNagjzK
         xqXdEkHa7p+7VqUK0i4wJITnCiKr+PJmHux0VXWjyHJrcj+H1PNuCsqwCNFb6ul1Ov/Z
         11RFdQVPAkfwh+WwshxTCSmH5aQ5QEkxgRIH4QAr83UQa18memkTE7DP5XIXdYFZBxm0
         bFmqVmwLlIj1wsQCuoS8ZwVvD/xEDJ4vx3hSjBdTmR/Ls9bPQHKUc+g4WyFhAy8hmxKq
         hgdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706124770; x=1706729570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F6WIWhJATA1SsppEYdczg5RfpFlWPa9HCZcE6BQQX/A=;
        b=MobKL99GuVLBcbw7wb3bRWDr/b9aN3xbYMnlOwunAVP73ovbikJMhUEDlxRz4pKJBA
         AqY6kQr1lyAWhx+zYkSqaXUisOq+tMIjEfKPJFJOa/2t9haMzM2d0f/DoAMTFLq+O6fw
         Yqsymj3Uz6dfqahEwbGleqkXMuAyr0wVOw090KvktobuDq1wGoa7JeIAAnNJuioXODjZ
         7/UCaoZd2UqRu35xNLWO1jT7E7ZC2UjjIO8bQrfJPnkouopyj2QzO4HwWpI1hhF57pqC
         QyCjCfXMItJXAg3yHkCx6Eidw6EL1oqG8nFCVPA654uEQzXH8OkwZm1jsFy1QJBnnod7
         zZVA==
X-Gm-Message-State: AOJu0YzplBwXg2T6Zm1mMlrzVrRaNujrRrfAl1hcxAWspPx+YP+o5WaC
	1Ge74ORi6thUAsp1+1W3+XrM62pw0rlSIb/2k3JtPZm1RGOC4c79
X-Google-Smtp-Source: AGHT+IE0HlVZMXTmSNHVek8JV9LSgIpm+uPZZTsUTtJ7fN1qL7ohm+sLpbuUiJ2/05syQL3PUSz32w==
X-Received: by 2002:a05:6870:5d91:b0:214:c782:8acb with SMTP id fu17-20020a0568705d9100b00214c7828acbmr279168oab.27.1706124769764;
        Wed, 24 Jan 2024 11:32:49 -0800 (PST)
Received: from [192.168.1.224] (067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id o42-20020a0568301c6a00b006dc092ece16sm2671939otg.67.2024.01.24.11.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 11:32:49 -0800 (PST)
Message-ID: <87f86921-373d-436e-93d8-4616a57e0697@gmail.com>
Date: Wed, 24 Jan 2024 13:32:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme_core: scan namespaces asynchronously
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20240118210303.10484-1-stuart.w.hayes@gmail.com>
 <189cde89-9750-476f-8fbb-1c95dc056efb@grimberg.me>
 <Za_rVS-0MEr2U731@kbusch-mbp.dhcp.thefacebook.com>
 <c05add9f-d375-44a4-a859-2757b19c70dc@nvidia.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <c05add9f-d375-44a4-a859-2757b19c70dc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240124_113252_684578_0015EB46 
X-CRM114-Status: GOOD (  25.23  )
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



On 1/23/2024 2:21 PM, Chaitanya Kulkarni wrote:
> On 1/23/2024 8:37 AM, Keith Busch wrote:
>> On Mon, Jan 22, 2024 at 11:13:15AM +0200, Sagi Grimberg wrote:
>>> On 1/18/24 23:03, Stuart Hayes wrote:
>>>> @@ -3901,19 +3932,25 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>>>>     			goto free;
>>>>     		}
>>>> +		/*
>>>> +		 * scan list starting at list offset 0
>>>> +		 */
>>>> +		atomic_set(&scan_state.count, 0);
>>>>     		for (i = 0; i < nr_entries; i++) {
>>>>     			u32 nsid = le32_to_cpu(ns_list[i]);
>>>>     			if (!nsid)	/* end of the list? */
>>>>     				goto out;
>>>> -			nvme_scan_ns(ctrl, nsid);
>>>> +			async_schedule_domain(nvme_scan_ns, &scan_state, &domain);
>>>>     			while (++prev < nsid)
>>>>     				nvme_ns_remove_by_nsid(ctrl, prev);
>>>>     		}
>>>> +		async_synchronize_full_domain(&domain);
>>
>> You mentioned async scanning was an improvement if you have 1000
>> namespaces, but wouldn't this be worse if you have very few namespaces?
>> IOW, the decision to use the async schedule should be based on
>> nr_entries, right?
>>
> 
> Perhaps it's also helpful to documents the data for small number of
> namespaces, we can think of collecting data something like this:-
> 
> NR Namespaces        Seq Scan        Async Scan
> 2
> 4
> 8
> 16
> 32
> 64
> 128
> 256
> 512
> 1024
> 
> If we find that difference is not that much then we can go ahead with
> this patch, if it the difference is not acceptable to the point that it
> will regress for common setups then we can make it configurable ?
> 
> -ck
> 
> 
I believe the only reason the async scanning should take any longer than
sync scanning is that nvme_scan_ns() has to wait on the workqueue until it
is scheduled.

Testing on my system (with pcie nvme devices with a single namespace), it
looks like it only takes a fraction of a ms (100us or less typically) for
that to happen.  Then it takes 6-10ms or more for the actual namesapce scan.

So scanning asynchronously, even using a local pcie device with a single
namespace, doesn't take significantly longer.  Of course I guess it might
take a bit longer on a busy system, but I wouldn't think that scanning
namespaces is a critical path where a few milliseconds would make much
difference (?).  It wouldn't be too hard to make it scan synchronously if
there aren't more than, say, a couple namespaces, but my opinion is that
the minimal benefit wouldn't be worth the extra code.


