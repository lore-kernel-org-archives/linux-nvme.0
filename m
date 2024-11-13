Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87920D637CE
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 22:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gk4zJTuuGCZq8YdlR7rEOEIOkX+EpzyKcyBLyLJ6C58=; b=uX/4MpJNJMbnD85M3ZJ0ZvQoEg
	Zjln4RXpSPvtdUaSr0C5D7pHGtSDJWbxC3kez35Br2cacsMWFHz0BBHryLyo5ri1mUsS3thhHRHM7
	atpPqfMS9qHMd/nS1k/dtUNg7Bn0LEZyQIyTuR862/39Xf6YFji45SnabVYjqsg0MGkkN0fbQ/4WL
	kBLL6c8eWZ4xGjP7f1lc/7kyu26crf64knt0dIbMqgTGjYDY5VoBWOe/hCf8bjecoeaC7Xer6g9yi
	T+fWsT8EgcJ3kAzyNtnKM/fNJxEGzAseS8BrxHdlASSpo79GWVf5hOAocNNuoKywtrn5IIo+DC+jE
	vzI4g0TQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tBLpT-00000008AfP-1gcr;
	Wed, 13 Nov 2024 22:27:15 +0000
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tBLpP-00000008Ae9-12Xh
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 22:27:13 +0000
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-5ee3e12b191so3117728eaf.0
        for <linux-nvme@lists.infradead.org>; Wed, 13 Nov 2024 14:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731536830; x=1732141630; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gk4zJTuuGCZq8YdlR7rEOEIOkX+EpzyKcyBLyLJ6C58=;
        b=O40iGc083hyCD4cs1rsBp3Ur1IQqqj7NHPDhgFb/ZExmQiFZg7QR+2uwogKyz/s0SL
         uvzvtuy4S5qeJP/5Jm+udVoUNliqwKuYUzqVGSCeyGjt4GcDBb6Yji5uNE6BSo6rud5F
         VFhXsnfORD2W17UeFxedABGMv/HRbE1I03O/dMVGPREMXaxHgTdNIe5RY3DE4bxjbZrp
         aY8rPb1Dfz6rONSEJ+fxX/0UJEyGfzvQbZKnnWIJiFI8sIFNbK7qgHR4j/P8bBBlvkbs
         DuVVh34sZGZpKTdimbkfp36kCdoitqsr7GxN5EHswK6P5bbQTLEFABMGlUJrKPCvGWdY
         U2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731536830; x=1732141630;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gk4zJTuuGCZq8YdlR7rEOEIOkX+EpzyKcyBLyLJ6C58=;
        b=AcifTDA3VpUoh8jEJWdTzG3/31zkin39gJoWshFy9xsezyDFtaOM8A7VhxKsF6m3FQ
         NNMa8nqQiaNA3xc8bi1/b0iDcq4H5mQoccRUMTX96Ermm5mVvehqoTDH5cMw8LY/Wu6I
         XOX14x/C4psmBSWhwVacV16h5c1LNlC/IfSBadftcIOAbU/OLR9AMJl6NuGezQwfnclf
         IkCZCo0NpFiPqf8E1knDFV3BQBl2CwSFeaczAmIH53l4JVo7VuyjjviW/gLGh//1K2Wv
         UR1SdJguqoLRgCfUiW2GXdFwB0RF0Ob3INlnXKh7sbc2JQP65OQRAtnLyQ4f19+abWN/
         1cbg==
X-Forwarded-Encrypted: i=1; AJvYcCW6GlJ4eKSii3WEBRRDDeYYHJAF/bBjKZtyuSm5LQChwViDdHpPE/lQoKXiLJqkr2AwbYfpYkuC0v2G@lists.infradead.org
X-Gm-Message-State: AOJu0YwRy7kxiHF5f+rD3XpzmDecycd+wPXQNgjKzPWvHi0Qv+i8Z8y9
	ZV8e8yoIpvlaGCBEpehXB6ZiCekgmvUVplTsK7T0kdeIvEZQYqkHnzfgQoV3wHk=
X-Google-Smtp-Source: AGHT+IGoqd96MY7bfoXv+9tibkBAuG/6TDsL/wWWwAgL5vAB2DYrndf+hvSgNBskdlUVxt9rcbSY2A==
X-Received: by 2002:a05:6870:a58f:b0:288:570d:8fe2 with SMTP id 586e51a60fabf-2956010ababmr20540208fac.11.1731536829597;
        Wed, 13 Nov 2024 14:27:09 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-295e9351aeasm1230872fac.54.2024.11.13.14.27.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 14:27:08 -0800 (PST)
Message-ID: <0376df05-0b60-480d-84b8-76dd2d58f1a8@kernel.dk>
Date: Wed, 13 Nov 2024 15:27:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: don't reorder requests passed to ->queue_rqs
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>, Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Pavel Begunkov <asml.silence@gmail.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "io-uring@vger.kernel.org" <io-uring@vger.kernel.org>
References: <20241113152050.157179-1-hch@lst.de>
 <eb2faaba-c261-48de-8316-c8e34fdb516c@nvidia.com>
 <2f7fa13a-71d9-4a8d-b8f4-5f657fdaab60@kernel.dk>
 <8156ea70-12a2-46f4-b977-59c9d76a4a65@nvidia.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <8156ea70-12a2-46f4-b977-59c9d76a4a65@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241113_142711_501538_A935CB20 
X-CRM114-Status: GOOD (  11.85  )
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

On 11/13/24 3:23 PM, Chaitanya Kulkarni wrote:
> On 11/13/2024 12:51 PM, Jens Axboe wrote:
>>> Looks good to me. I ran the quick performance numbers [1].
>>>
>>> Reviewed-by: Chaitanya Kulkarni<kch@nvidia.com>
>>>
>>> -ck
>>>
>>> fio randread iouring workload :-
>>>
>>> IOPS :-
>>> -------
>>> nvme-orig:           Average IOPS: 72,690
>>> nvme-new-no-reorder: Average IOPS: 72,580
>>>
>>> BW :-
>>> -------
>>> nvme-orig:           Average BW: 283.9 MiB/s
>>> nvme-new-no-reorder: Average BW: 283.4 MiB/s
>> Thanks for testing, but you can't verify any kind of perf change with
>> that kind of setup. I'll be willing to bet that it'll be 1-2% drop at
>> higher rates, which is substantial. But the reordering is a problem, not
>> just for zoned devices, which is why I chose to merge this.
>>
>> -- Jens Axboe
> 
> Agree with you. My intention was to test it, since it was touching NVMe,
> I thought sharing results will help either way with io_uring?
> but no intention to stop this patchset and make an argument
> against it (if at all) for potential drop :).

Oh all good, and like I said, the testing is appreciated! The functional
testing is definitely useful.

-- 
Jens Axboe

