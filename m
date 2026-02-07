Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E0B9EE0AE0
	for <linux-nvme@archiver.kernel.org>; Sat,  7 Feb 2026 13:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZRTqpKdfqDJSZWcE8kwZwVt5WVQ+D1cv5aDjl0Hs7zg=; b=XTFRP83Jn85+4O//EjWxhuPglR
	NkSxXw2o4C3iBifgzpg7NYQY8UelXiJVlA8g08RSUZA2DtjBK7rNXPqzYora4fygpUQlCIz+0O6ao
	eE3UYZhHpOvkpjRYuZwYRCg/qXfvteGklXUlZrehPmV3FHHzkFrTbZ01mok9dlXVQ6JaYbd55tYAv
	utioBTbw624/zsXX6wkO9c5l/1CHNhTrq6U01k0AHge30N4BoMUU4w/nIJ7aA1sE/oGMphwNsEEvk
	Iyc2tA0AoexYJjnQYmnOwpWvdCO7DbxYSRhxYPojR6JyZxh+sR4qcCKXn36d+SMMBj19d9+p81Sj4
	RT2ZZ9Lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voiUp-0000000CUei-2YWa;
	Sat, 07 Feb 2026 13:37:11 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voiUm-0000000CUeD-2T0P
	for linux-nvme@lists.infradead.org;
	Sat, 07 Feb 2026 13:37:09 +0000
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4362c635319so1220525f8f.2
        for <linux-nvme@lists.infradead.org>; Sat, 07 Feb 2026 05:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770471426; x=1771076226;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRTqpKdfqDJSZWcE8kwZwVt5WVQ+D1cv5aDjl0Hs7zg=;
        b=RWYRiFZHyxreWFvRNW/P9XTYfvpUCAyq5/id3jO7lAt5qQw1ZEnC+VGDiQnWiJNL0d
         27TzBWCvnX9yQgLHV7wDbz3N8y7+CJRaycAxNE8FyMJEE8tpTjH35BxST9Bnv56NU68m
         QI4JKyrEMkM/R8DzhHx2mleKOpJSy/E2tnxvAqihu1R53YAvKDxyzpIvxYU+eYiOsfw7
         AOSXjGEthuS+m71Qi80cNfQNGEiYXNHmei1U6VqfHZeHeCPytosDNjnCW27J5TJdf6ag
         fAyXT3F+RGaLsQ0Cjx9rRJ+OyUIlLLM1tnOi8PXuR/f9jW1o29MsyT0qbDRJ7PcRP0v7
         t33w==
X-Forwarded-Encrypted: i=1; AJvYcCXniUC+1csjyZfDioKgCBEMlbIidihFFWWVPgSbCFCSeWvIGUDchtb4INqmNuoG5kYJfwrbg/ntukLy@lists.infradead.org
X-Gm-Message-State: AOJu0YxKNXWl/cy06WcCH9RkCM8hOhA8AgQ4r8CUkfaLQDa5/TgrkGTU
	Ni9yIJSNfw1kVZRf1styU8kiHEBcbudS6HdoB0T4uGBhOjPtp0zGf3Di
X-Gm-Gg: AZuq6aJp4hRwBf8VwWtmAKpd1Ebbhadem/wCBV/vDuxj/bgzB+ZwNycs3/LCXb5gVlL
	tnUZf9ZbqmZ8L//XswvpR0IJNZqUJT7g0e9XykbyeI63Q71D9T54ZS41wiQCe+9N/S1EBhPkQ0K
	mtXdfwIL983afxNeo+poSuiB/r2U3JL2kLVxGQAfCChlpha5toAFYp5b2P+wmOTD3TV/EPWknqe
	o4UKtCGd27usTQ7GEY3fP9AzKLdxAS++toUZBo4IdEL7mRS+Db3iSgMPQXFM2pwE1oZUPsDkCIa
	ga3lvTZky9+RahbFoWmi9E2BbgcymzQIPEyrNV/+CzJtHIMXtq+Ztf4LzsKwuP6Ok8MJ6NubKoc
	+JOzdok2XDNYpLPDsOxXBlzzuXf5r7htzYxxScYc2vaejZMmHqE0Tt0LSgECuQBSI8SDhIezRyx
	eC1pvvK6raI18V2MnWFH3vq+n7Fn0RLeIJNler1pQonOc=
X-Received: by 2002:a05:6000:2dc5:b0:436:8058:453 with SMTP id ffacd0b85a97d-436805809cemr1614862f8f.33.1770471426401;
        Sat, 07 Feb 2026 05:37:06 -0800 (PST)
Received: from [10.100.102.74] (89-138-75-89.bb.netvision.net.il. [89.138.75.89])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-436296bdc11sm12381302f8f.14.2026.02.07.05.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Feb 2026 05:37:05 -0800 (PST)
Message-ID: <48d9c8a1-3fb4-40ec-8bd1-67a82a3c2652@grimberg.me>
Date: Sat, 7 Feb 2026 15:37:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 7/7] nvme: export controller reconnect event count via
 sysfs
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, hare@suse.de,
 dwagner@suse.de, wenxiong@linux.ibm.com, gjoyce@ibm.com
References: <20260205124810.682559-1-nilay@linux.ibm.com>
 <20260205124810.682559-8-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20260205124810.682559-8-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260207_053708_635249_E15CAB9C 
X-CRM114-Status: GOOD (  10.82  )
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



On 05/02/2026 14:48, Nilay Shroff wrote:
> When an NVMe-oF link goes down, the driver attempts to recover the
> connection by repeatedly reconnecting to the remote controller at
> configured intervals. A maximum number of reconnect attempts is also
> configured, after which recovery stops and the controller is removed
> if the connection cannot be re-established.
>
> The driver maintains a counter, nr_reconnects, which is incremented on
> each reconnect attempt. Currently, this counter is only reported via
> kernel log messages and is not exposed to userspace. Since dmesg is a
> circular buffer, this information may be lost over time.
>
> Expose the nr_reconnects counter via a new sysfs attribute, reconnect_
> events, to provide persistent visibility into the number of reconnect
> attempts made by the host. This information can help users diagnose
> unstable links or connectivity issues.

This unlike the other is zeroed once the controller successfully reconnects.
I think it is better to have consistency across these sysfs entries.

