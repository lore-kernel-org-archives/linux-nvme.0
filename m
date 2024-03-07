Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E1D2C48BF6
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 09:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b1XouiGKi30g+vXyHcKfWDYRYQ4QuBS+K6KwtF0qd60=; b=mZsamxWh8IqrHCXOMxfM9WAf/1
	/s3xyzfwIwENtI/Xl8r+I9PuKlQSWXPIftKGoIkJfyZFug2WVFBkJ6QhRmmz8sX+5dv4NhdHGd8yT
	ueUMfaAzCk6guuXvNovdY8kl6U47DjQdKscOGdmnJCSHoxLK82bwLvtYE4FfH5k1rsWg57u+rOM9A
	Aqt1r6SzFUZz79CyQs7KvnHVcUTwMhK7C4cwSKkXdLhGZlQ4CN70BVvwH5p8u3+y7W4acvi4AGY2j
	CjKrydP4s3Mj11bTGhNCpw3YDYLSRMJ1K/6Mll5/stk3Txx49cOIrgtedEw37VCXhMyrbOAjjx9tZ
	zvDjyU8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riA2Q-00000003qta-3JwL;
	Thu, 07 Mar 2024 09:27:42 +0000
Received: from mail-lf1-f46.google.com ([209.85.167.46])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riA2N-00000003qsm-2ylP
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 09:27:41 +0000
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51334491779so218347e87.0
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 01:27:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709803657; x=1710408457;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b1XouiGKi30g+vXyHcKfWDYRYQ4QuBS+K6KwtF0qd60=;
        b=omXZ02OgW7fT+tpwX/D5JRJqcvpQB56yAkRi3u50mE5LqLEeeJansOwkoJxQIurAH2
         comOKuBaMLIA4a4wHChpN0t6PzhE5cl0sCgbVrYsfS4QCs8qfP1G/DftVCZdqw9jNA+J
         AVmIWW+HeHgPHeiHOgNxuTI7eB+hugTK8/UJtITH0yp+9PZnJkfimM3SgNZSaP0B42ag
         4HivTO7ePcWSEe+05/L31upAJMlNOWsA6MBEkbdzqBc6SBN0HLLdls4S3YH5LYkWyc8g
         VtKBANn4Vnn/BYn246avBX58r4/1N0iVbMgy+qk9nI/uDi1lVf2m+JbGNf9D3rEevAuO
         KqHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqslVidbuG/feQ28fAG0i00rzOD/LC1EDj7DWc0zmt0VTdwuTcSmIk/g7O1Ecax12mNgAMMxVTwwvmt1eaH0NZz+WkZjJG4NYL+hDMFKo=
X-Gm-Message-State: AOJu0YwlzztigEpkF8GR8HJFDBhQDIhp3/rSZVN+5zsdmbpiw9hrfGzs
	f2mpt4upQUxC2Dm9IbCEfYBYk3HequSH4+D/ePjH1VLoIKdP5wh3g62j188Q
X-Google-Smtp-Source: AGHT+IFAtS7gPs94QfuT5fWV10lVMKQYAZHjXQvUyvJVO2A5yYZawvRCRk09oAiX/NomdQIy2nIFkg==
X-Received: by 2002:a05:6512:23a7:b0:513:3fa6:efdf with SMTP id c39-20020a05651223a700b005133fa6efdfmr1060211lfv.4.1709803657413;
        Thu, 07 Mar 2024 01:27:37 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id f15-20020a05600c4e8f00b00412ea52b102sm2037138wmq.34.2024.03.07.01.27.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 01:27:37 -0800 (PST)
Message-ID: <6e34a652-da40-46f2-8a43-b45b08682e41@grimberg.me>
Date: Thu, 7 Mar 2024 11:27:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] nvmet: support reservation feature
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, kch@nvidia.com, linux-nvme@lists.infradead.org
References: <20240201023207.112007-1-kanie@linux.alibaba.com>
 <20240201023207.112007-2-kanie@linux.alibaba.com>
 <ee516418-d072-4506-acba-d02f22cc4476@grimberg.me>
 <0c74a2c2-c9d9-4b0c-9deb-bdc3caf72005@linux.alibaba.com>
 <Zd6msstIWsNQMPfK@kbusch-mbp>
 <727aabbc-1464-48d6-9915-a1c22343c2b2@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <727aabbc-1464-48d6-9915-a1c22343c2b2@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_012739_856136_DB2A30C1 
X-CRM114-Status: GOOD (  18.14  )
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



On 28/02/2024 5:40, Guixin Liu wrote:
>
> 在 2024/2/28 11:21, Keith Busch 写道:
>> On Wed, Feb 28, 2024 at 10:21:57AM +0800, Guixin Liu wrote:
>>> 在 2024/2/28 08:40, Sagi Grimberg 写道:
>>>> Hey Guixin,
>>>>
>>>> On 01/02/2024 4:32, Guixin Liu wrote:
>>>>> This patch implements the reservation feature, includes:
>>>>> 1. reservation register(register, unregister and replace).
>>>>> 2. reservation acquire(acquire, preempt, preempt and abort).
>>>>
>>>> Overall patchset looks in decent shape to me now.
>>>>
>>>> I do have one more question though.
>>> My thanks for your patient review.
>>>> You say that this patchset implements preempt and abort, however I 
>>>> don't
>>>> see how this is actually implemented or even how can it be implemented
>>>> at all at this point.
>>> Yes, the nvme target does not do any useful workto abort command, the
>>> comment of nvmet_execute_abort() says that
>>>
>>> "we are not required to do any useful work, and we couldn't really do a
>>> useful abort",
>>>
>>> so I don't know what to do about preempt and abort, and the NVMe 
>>> spec says
>>> that the abort is best effor.
>>>
>>> My statement here may be a little inaccurate.
>> I think you may be mixing up the NVMe "Abort" command with a different
>> command, "Reservation Acquire", where RACQA is set to value 010b,
>> "Preempt and Abort".
>
> Sorry, I just want to explain that I dont know how to implement 
> "preempt and abort"

unlike abort, preempt-and-abort needs a semantic guarantee because the 
consumer
may rely on this for fencing purposes. So it cannot be supported in 
"best effort" I think.

A possible implementation would be not to abort as there is no such 
interface, but
nvmet may wait for all pending ns IO to complete and disallowing new IO 
to come in
(using percpu_ref_kill and percpu_ref_resurrect on ns->ref). This won't 
work very efficiently
withALL_REGS reservations though.

