Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBB6D2CE12
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 17:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mqALD539c/0UI3ZnLVYZjy9roMfmG10xDEhh534qxd0=; b=vsqQjA8ZIGViq0c+vmbqf59P7K
	iGXRM78i52eoBA/M/TQZwIA4i5eECpENE0F4aaNx2jVbrX+K5Mzxaf8XwUFzNklsUFJjDJyFkYORi
	1wIZlCqLSwGy+LpRfQo1UCkJSrZR/w3jWhWoxyFenJjxtG4tGe88PWHsQN7SvsmWj+3N4l2HVVLnz
	5fmL9BRLkfxQ4IxcLAJ8pCqA36eVTHeUXKmePVB6aOFhZx87wZkoNvY0RWuhhNVm5r+wad28HNMbT
	HHGU9nOz6ofj1kiXvMsqF/hD56O5A/Kl/jru6C4TB7h6Het8tFP7yaWViF204Sn9SY2lzsgDr11Wq
	wUGrZMzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Ina-0000000BfvL-3zya;
	Tue, 22 Oct 2024 17:36:02 +0000
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3INL-0000000BbHS-0nPP
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 17:08:56 +0000
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-20ce5e3b116so46894645ad.1
        for <linux-nvme@lists.infradead.org>; Tue, 22 Oct 2024 10:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729616934; x=1730221734; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqALD539c/0UI3ZnLVYZjy9roMfmG10xDEhh534qxd0=;
        b=GTS0eshXAg0xTxovtS4LYM0/KQAqMe5xbFTk5BqyAQAMvclhgj9NF41Py0qU0SwtCv
         TtVkr8hHz43fY6mD1Jc/NvLXx0FCZRSnRF7ScCS+2727MIFaKEl/vJNwYFTFPfmtnMOf
         tZIbXSBFHZhroYcKFhrfm8DtdoAILH7wYHJVB4WTM1HJK4wu4V9ZXdx2dj6vpC/LOH7A
         7M0XJnZSApqEFjiz27X9GF7dSA43nG93/OEFjHoTNeV3M2nlBrs9nYiVESeRp/PHRDvX
         uSHLYQMCy0WSM33/WfcDEJlW959a+7PvAcbShef+tFjwBDCMYTqgFKTo2Z7oKKgkd/eX
         5Rtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729616934; x=1730221734;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqALD539c/0UI3ZnLVYZjy9roMfmG10xDEhh534qxd0=;
        b=TcOg5kmIw5iT8SwElAdAKVuKJ6o6Jd+TPr2Z2nDzxzDmKc43V7J2OuB7riBgg9yBjt
         nm8bcmt/N4p8iZvlwaRlJWGLDxIJD/BGWyqWrZlmo72f7ZC8jrNoQHAqoVYhltviitK4
         mGBaYKV7D2k8miB83MMXEOgFyuNHb+tyjwq574W6uQ9ZsAZ8Q61npKSJ1h9c8tQH7+XC
         RAQvozRifOD1ITmJrL6c7Rg2It29VUlInWTTEMbGeC91iZDZct5tKYCle1QCUyFR6j3M
         b2v3oosNA3bPsihRXcpllZYHvOCnI+iUq/foiFg1Bt9ie1QelSFOQTWfIOEVfRbNHnoP
         G4Og==
X-Gm-Message-State: AOJu0YyJ9z59i4SE0HCjdDuDEq7a8nXUqiu94RwI3/HyplxWuTbodGC0
	R2Y0E5A+EfFi9su+zBiTUXHmzAEbLGiySoBFMsIOlzalJyc556CN
X-Google-Smtp-Source: AGHT+IExe2lOjUJjEowV+0wjhD/37hGWKjrIepGPdWjUAxJ1OYzbWQUr5YycBYjI/FzCRP9oCRKNqQ==
X-Received: by 2002:a17:902:cf07:b0:20b:3f70:2e05 with SMTP id d9443c01a7336-20f3962a2d6mr1437075ad.41.1729616934376;
        Tue, 22 Oct 2024 10:08:54 -0700 (PDT)
Received: from [192.168.122.100] (220-147-208-16.tokyo.ap.gmo-isp.jp. [220.147.208.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f364bsm45024975ad.264.2024.10.22.10.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 10:08:54 -0700 (PDT)
Message-ID: <d5735ddc-a3b4-4204-b8fa-b97566f8a91e@gmail.com>
Date: Wed, 23 Oct 2024 02:08:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: check PI size if metadata size or below
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20241022163504.10738-1-ikegami.t@gmail.com>
 <ZxfY2IT15o_2vTZq@kbusch-mbp>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <ZxfY2IT15o_2vTZq@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_100855_251574_A41A6A86 
X-CRM114-Status: GOOD (  13.19  )
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

The existing function nvme_configure_metadata() code checks as same as 
below but is this checking case only okay?

static void nvme_configure_metadata(struct nvme_ctrl *ctrl,
         struct nvme_ns_head *head, struct nvme_id_ns *id,
         struct nvme_id_ns_nvm *nvm, struct nvme_ns_info *info)
{

...

     if (head->pi_size && head->ms >= head->pi_size)
         head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;

On 2024/10/23 1:54, Keith Busch wrote:
> On Wed, Oct 23, 2024 at 01:34:27AM +0900, Tokunori Ikegami wrote:
>> -	if ((io.control & NVME_RW_PRINFO_PRACT) &&
>> -	    (ns->head->ms == ns->head->pi_size)) {
>> +	if (io.control & NVME_RW_PRINFO_PRACT &&
>> +	    ns->head->ms >= ns->head->pi_size) {
>>   		/*
>>   		 * Protection information is stripped/inserted by the
>>   		 * controller.
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 093cb423f536..fbcb2243ba84 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -542,7 +542,7 @@ struct nvme_ns {
>>   /* NVMe ns supports metadata actions by the controller (generate/strip) */
>>   static inline bool nvme_ns_has_pi(struct nvme_ns_head *head)
>>   {
>> -	return head->pi_type && head->ms == head->pi_size;
>> +	return head->pi_type && head->ms >= head->pi_size;
>>   }
> It would have been nice if PRACT worked this way, but spec says it
> doesn't. The control bit is a no-op if Metadata Size does not equal the
> PI size, which is what these checks are looking for, so we can't take
> this.

