Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16642C47258
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 15:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qzoGxW6pH/WpYWngyXGD0kQIjaz97ERFEX4tjqulbh0=; b=1xHbd+nL2jKroAOW88nyTKPugi
	jOQxU5OKt2fhOQ7h4VMJyS8pJjPfSw9GsD9kcS3SVuuXUmW4VdPS//+NflbXQuy9GGk1gV+f3fUn9
	YsnX4qc7gMoNV31FHaQrDMcOXwXBbiJAb6kLTqZAdNK/lVyn4JwrCG8f+4aeYg5uTzC631pCmjiJF
	9bxtksaBodrkwZ2psYNtQ3Sf5DH0nNZMuUYmoGV9D57uoBP3IcO8v2L2QhViAgLR5AngDAVeUujye
	7tQPdDdH2dyCjpDXIs/fwgk46btb1RjuRl2bquiEWMAZz8KyhTZZS6IfYB5K+mQS3BjfF45EvHpzm
	amyicJYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT1ru-00000000euh-3oId;
	Thu, 25 Jan 2024 15:42:18 +0000
Received: from mail-io1-xd2a.google.com ([2607:f8b0:4864:20::d2a])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT1rs-00000000etu-0bin
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 15:42:17 +0000
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7bb06f56fe9so81953439f.0
        for <linux-nvme@lists.infradead.org>; Thu, 25 Jan 2024 07:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706197334; x=1706802134; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qzoGxW6pH/WpYWngyXGD0kQIjaz97ERFEX4tjqulbh0=;
        b=DebsTjHpqU9tqmUQSSunrPRGQaPWYINHYlkvWYfXTxpNeNeEemSa0xp3H5ck0UdXkJ
         i+8ZcCsD1M9qsZOxpt7Vch0P/ehAb4JPU577g1ycr0M0zM7158h1oR3Hg8HftCGDNNhk
         KOfV72ZQLqGaCPMNJUBY0pOP3MlN7yw7z/Mc91u5vOj+88y60gqx6Bt2hewqLQXQRGQz
         GZVnXAIYWAa3cPFExMSaJmZYu114AHQ4/NkQY7H6AcX2hqnkjZHP0I8TFYuPRWvHko4W
         0LHl6KBg9OlN8KnlpGhIg6cdwnyhdFD0n2uaMpOrMPqDNYtV8VMi3Soi7O9+nZGStLvy
         IQgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706197334; x=1706802134;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzoGxW6pH/WpYWngyXGD0kQIjaz97ERFEX4tjqulbh0=;
        b=F6Yxy3vw4IX66tN/atmbrrZpV49YqAtu1389h/wna2szo6AjIzt2m3itZvhu+lmCjO
         khJP7IWRJOJ1+iYLFYosvkU+Wx0qsbr/JN9mJaDk2z0lXlPTCMc22qDyoabKD8aZ02JH
         YuF3MTY4o5c+KoDuDncMH99VvN/agiEhvLe6T7+J04UsoeB+OyjSyz2RK1f1XuBoXyuc
         mc93rQucCKbhSy3cQfTyfCuSX2s3HqDyUjnVIgDXaq51U1f33DKcIuyrB89wj2UKcgfS
         Y/7tLJglvZ9KoQwjBKlJwsd+2okUEuPtZ6UyxgNEjqwxhss4Fse2u1gimWB4DqhXmSwr
         Ujcw==
X-Forwarded-Encrypted: i=0; AJvYcCXmCLVQVj5W3kKNEtk9hoAnWRSXjldtflGG+WnY8m3DSkRLkG1Akr+b8UqJnCfsrCr+paoCuutc20CCCtKR49xbLh8KOTOjs1balloJJA0=
X-Gm-Message-State: AOJu0Yx2f9v3/Z6y6EtUvNe1wAx/4bmV+W13D5ricdb1bW9E7XdwBH4V
	AwYw+EXPY+3vORmUepFVPh7h3XgQKFuwXTAqCBiU5g+kxxX9BWEILSlf+duYBkxofQ4Av5rVqP+
	gCd4=
X-Google-Smtp-Source: AGHT+IHOcT0c80w+bnyJ1dMqNP0f0ETWWqSAl5XY9BxqEtaLdl+2aCCgPKinCUN7n5wy/BaCX/+S4A==
X-Received: by 2002:a05:6602:89d:b0:7be:e080:6869 with SMTP id f29-20020a056602089d00b007bee0806869mr2695473ioz.1.1706197332251;
        Thu, 25 Jan 2024 07:42:12 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t4-20020a02ab84000000b0046ceccc798asm4551478jan.6.2024.01.25.07.42.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 07:42:11 -0800 (PST)
Message-ID: <13922738-7cdb-457d-9ba6-4a3a9a064a8b@kernel.dk>
Date: Thu, 25 Jan 2024 08:42:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: enable retries for authentication commands
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>,
 Martin George <marting@netapp.com>
References: <20240125130906.94874-1-hare@kernel.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20240125130906.94874-1-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_074216_238005_C117D6B1 
X-CRM114-Status: GOOD (  11.04  )
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

On 1/25/24 6:09 AM, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> Authentication commands are normal NVMe commands, and as such
> can return a status where NVME_SC_DNR is not set, indicating
> that the command should be retried.
> Rather than checking NVME_SC_DNR manually for each command completion
> this patch adds a flag 'retry' to __nvme_submit_sync_cmd(), causing
> the REQ_FAILFAST_DRIVER option to be cleared and the command to
> be retried via the normal mechanism.

Can we please do this without adding Yet Another parameter to that
function?

-- 
Jens Axboe


