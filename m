Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAF4C3DA5D
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 02:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bIFfDmFpN4eqAMaaNo7FF8H1RWJDQ9fSWvSB6h3IB14=; b=D/z0+DVWjlsifMg/x1KVeROwVZ
	WAOyW23yhnT+RK197xzpjCAcxrU1do7/CxaVy6hQpLOrlp3ahGPWQjpt4Tc5/cUyuHEyv7jFwSKef
	QWWrGvqwyqC+f1oFhhKttuUT15zD63r5Nj/dEj28Qpa9P7bsqgnEIdf+91GlI1jiEtHUlibJ6hWt8
	8NxJxqeoYTbg9AOZPLeGs8z9g2edatSdv4NqqwplMLM9JlfBaV7GcSbh6unVdtqm4ZkyD55LCu1PZ
	OcHd2TcHdGNpN2hLdYBrv6LLP0EQACjhQAJUrJw/kODCMZCa94dnE4qvqkPw1lLcvhOnrisGZIT8T
	TZhzHT4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUGbE-0000000FVAG-2NRj;
	Thu, 18 Jul 2024 02:10:28 +0000
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUGbC-0000000FV9d-1hpz
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 02:10:27 +0000
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-7039e4a4a03so167481a34.3
        for <linux-nvme@lists.infradead.org>; Wed, 17 Jul 2024 19:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721268625; x=1721873425; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bIFfDmFpN4eqAMaaNo7FF8H1RWJDQ9fSWvSB6h3IB14=;
        b=A2itu+lukucHj9S2IFXOVeoXaqEVpfCothK51KqFPmzTXhpANct3dF9klMqd+2pz8l
         IWf3qjVF+nkOoeUHO6mH3hfn03bVl208B9ZDFai8fVAv+E/89Q5GR17DLuFjzVeXwVqp
         hXZyZshTDGCtZPSHzpzI0MGM6EfUzuPqoboqfyhltsnMtg/sQtMo7Fxu4TWJO7KlDbLi
         8GCCnW7G/8YDpBpB4XPlbenUtgrhfRj1QYqyFBB/8nVSx8DQsusup0tRrwSI+ixHruiL
         yqvnDug2SHpZaRhHibzN5RUJnxG4KA7hrN4pgx79Xam83dz/Vx7uBkUfujOjqUxcZZ+x
         nvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721268625; x=1721873425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bIFfDmFpN4eqAMaaNo7FF8H1RWJDQ9fSWvSB6h3IB14=;
        b=IZzvj7EIYfRHehqZ0bGRo/eF08wBvmG5R+ppM0D5/3AVuGcacXqAPHR23tMeUf+Y/4
         +HST1bWauQx+0qwMjGMvUhu5frl5SD/41Tv76L5nGDRuW6SY3Gbgy4QMEmqFU47qFWmd
         tDnYOEcGO71ia57OceWjg2WkVynvZMvPX+IG3hGb5xcvzh6t3bh4KE9Hgd6zw31FP2oz
         IlPBDIvjDjNHkTMxJrWOGGQlTtZylpfAxV9YjgMEakBTfgFtDxPB4MUU7ZuMJGcU3BQK
         zd1PffgvcooQmv1NkFffbgsXsiITksuMNt0ZH9jSrkPS1LGUtpsp2aoF5I8puvIv0D81
         yCAg==
X-Forwarded-Encrypted: i=1; AJvYcCU2pGG9ChBgYAc17kdb/Y8h/uoZzga8sSDSF3LtJ5OpB9jcDbgU39UziNQ2+hGn6bRQy3tWbBputQkYPXZ3QhmsuChT2MDs3XOhz/DRWEo=
X-Gm-Message-State: AOJu0Yx9124H4NOA0E1S6jmDUXa027GQPnINIu6ErpsaN+oMWsh7grJ2
	PNVW3AWnOLIHBCo1J4mp3hySMMTqN2pZ21RRw5VpnSzit9rf3AME
X-Google-Smtp-Source: AGHT+IFdfi1fpC7A1dDA7DH5ZmL+8xb4lKgvB0goy07ZvGthxot9YWzsXiGqELyb/+bAn7uzc0FvNQ==
X-Received: by 2002:a05:6830:314f:b0:704:2dd4:3628 with SMTP id 46e09a7af769-708e37891a2mr4276406a34.9.1721268625174;
        Wed, 17 Jul 2024 19:10:25 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-708e7901391sm314553a34.74.2024.07.17.19.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 19:10:24 -0700 (PDT)
Message-ID: <6629583d-4681-49bc-8a7c-a87c3051c30b@gmail.com>
Date: Wed, 17 Jul 2024 21:10:23 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] nvme_core: scan namespaces asynchronously
To: Keith Busch <kbusch@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Martin Wilck <martin.wilck@suse.com>,
 Ayush Siddarath <ayush.siddarath@dell.com>
References: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
 <Zpgtr33uqbMogK7c@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <Zpgtr33uqbMogK7c@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_191026_482155_4CB29669 
X-CRM114-Status: GOOD (  18.99  )
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



On 7/17/2024 3:46 PM, Keith Busch wrote:
> On Wed, Jul 17, 2024 at 01:55:50PM -0500, Stuart Hayes wrote:
> 
> Looks good to me. Just one minor comment below.
> 
>> @@ -3978,11 +4008,15 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>>   	__le32 *ns_list;
>>   	u32 prev = 0;
>>   	int ret = 0, i;
>> +	ASYNC_DOMAIN(domain);
>> +	struct async_scan_info scan_info;
>>   
>>   	ns_list = kzalloc(NVME_IDENTIFY_DATA_SIZE, GFP_KERNEL);
>>   	if (!ns_list)
>>   		return -ENOMEM;
>>   
>> +	scan_info.ctrl = ctrl;
>> +	scan_info.ns_list = ns_list;
>>   	for (;;) {
>>   		struct nvme_command cmd = {
>>   			.identify.opcode	= nvme_admin_identify,
>> @@ -3998,19 +4032,23 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl)
>>   			goto free;
>>   		}
>>   
>> +		atomic_set(&scan_info.next_nsid, 0);
>>   		for (i = 0; i < nr_entries; i++) {
>>   			u32 nsid = le32_to_cpu(ns_list[i]);
>>   
>>   			if (!nsid)	/* end of the list? */
>>   				goto out;
>> -			nvme_scan_ns(ctrl, nsid);
>> +			async_schedule_domain(nvme_scan_ns_async, &scan_info,
>> +						&domain);
>>   			while (++prev < nsid)
>>   				nvme_ns_remove_by_nsid(ctrl, prev);
>>   		}
>> +		async_synchronize_full_domain(&domain);
>>   	}
>>    out:
>>   	nvme_remove_invalid_namespaces(ctrl, prev);
>>    free:
>> +	async_synchronize_full_domain(&domain);
> 
> A goto this "free" label appears to mean the async domain has nothing
> scheduled, so synchronizing won't be necessary. This should be moved up
> tharmlesso the "out" label, I think.
> 
> I can change that up when applying; just wanted to mention it in case
> I'm missing something.

I agree, you aren't missing anything.  Thank you very much!  If you want
me to submit a new patch with this and Thomas' changes, let me know.

