Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE7FC4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Dec 2023 17:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3LaLRr9W1ZE98V0N5k2e/LRswRIvzV6lWoQScfDsyPI=; b=x7k00a3vkHjCvihz4U/MvDpEL8
	brZ9BgkyCP9iD8fslWKT7GalAai4mADnqpub/QDBNRiU01QuRUp4xaj5Z8oR16le2MKNpQty1YGYf
	b37Zgx0RsdnvChj7qMCcjqeribsGP6o3BXh/hyzSwjW5LEY3477lYMJpOEzjXziI9WAQI90JuDsWK
	taSyqtToNcSJhRcbja8H9mWcrrN+3jQKYKQ2SalPkd0vk3o81ejrNKooQkI25swfYjXV525bRKvJr
	oEES0GS5V6VyRC818wGZeEKXADqSHuoF/8W+hcCbUn1KBJlDk2/EIMSWRDsT2Rx2Pcf6rsN2mFoGr
	9Hw++sAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rDTNB-00Fefp-0F;
	Wed, 13 Dec 2023 17:50:17 +0000
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rDTN7-00FefQ-17
	for linux-nvme@lists.infradead.org;
	Wed, 13 Dec 2023 17:50:15 +0000
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5c210e34088so5930568a12.2
        for <linux-nvme@lists.infradead.org>; Wed, 13 Dec 2023 09:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702489812; x=1703094612; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3LaLRr9W1ZE98V0N5k2e/LRswRIvzV6lWoQScfDsyPI=;
        b=cOp+SA0d6uPCIsctaVBUKNrQ5nPRdJ4KeZWpSCeGFwtHk3d7Sc7STo9s1relFE48rt
         nx2fAe6tI+xAQQZ/S9n7KeD6L9/MYYvkgRoIuVoZeyfzMY5JWXEXV2/DAQEvY11vM7f5
         lJN/gott32T3m1XxqMh7O7S4UyoQzS5NpPYAf8ITf7ergB3cyf1xtF0zI8fdwQWhJx8w
         ZZN4szvxO4OlWYffgsHiZ8r5u/ODpykR8TJMwRx7J9Bg1PSx8k0pqCe/PhJRWGKzGrUW
         80agsXDcuhmdcuBu2t179sXmXOlCcyxZUKw74j8Li0SadtZXR4FGG/M6a499h7ZjFsVH
         v2sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702489812; x=1703094612;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3LaLRr9W1ZE98V0N5k2e/LRswRIvzV6lWoQScfDsyPI=;
        b=tpKdu+APuVxmF2zpRz6LCvFeJxrR0RF4oB3MVRbW/dF86LzixsLRi0PI2VVJRJyzfP
         lsWZocIpi1Fvnlu+dLJxEr6zDt8URuADHJJ9Q4NwkGV2gVJZvWE6IrJNUkUxigOQw+/7
         Cs86cWFnLEai9j+5qkzH7bQ/ROgoo7oOuo03sFTdBHxo19ikDCSMDs5srD70mQqDoKyF
         7rbY9wt6Ep6JQA6nuAGzfBrvlO8fJgpVI1dDXjycIpNuzE/+dyjlAUCjeV5cLnfInsyU
         FwEgsfK1GOJibUdA9CpCRdRV1okGGQKc8vvlnCjmE+qK4rgVTm1e0wi6iJvonftUX2Id
         IWug==
X-Gm-Message-State: AOJu0YyJYmbsOQ80xqVuU4f4RluER77THGHgRCW86rKRaDMgHQkGsy50
	3Ug9VTo094UOINbtbfkCwjvVqzOZ8lc=
X-Google-Smtp-Source: AGHT+IHvcGQxC80NHTd50sMoD9mtd9BdgX90gBXqF90IM71cg6N7b7O6tLWqGqCMgZtb8U8UKNdPzg==
X-Received: by 2002:a05:6a20:9149:b0:18c:b133:dea4 with SMTP id x9-20020a056a20914900b0018cb133dea4mr10402221pzc.42.1702489812038;
        Wed, 13 Dec 2023 09:50:12 -0800 (PST)
Received: from ?IPV6:2620:0:1000:5e10:fdd1:592b:d4d0:1d05? ([2620:0:1000:5e10:fdd1:592b:d4d0:1d05])
        by smtp.gmail.com with ESMTPSA id s35-20020a056a0017a300b006d0bff2cc81sm2091742pfg.123.2023.12.13.09.50.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Dec 2023 09:50:11 -0800 (PST)
Message-ID: <5efd3187-fdec-4e82-8871-6f93ba20c158@gmail.com>
Date: Wed, 13 Dec 2023 09:50:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] PCI: Support asynchronous shutdown
Content-Language: en-US
To: Jeremy Allison <jallison@ciq.com>, jra@samba.org, tansuresh@google.com,
 hch@lst.de
Cc: linux-nvme@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20231212180938.397403-1-jallison@ciq.com>
 <20231212180938.397403-3-jallison@ciq.com>
From: Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <20231212180938.397403-3-jallison@ciq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231213_095014_161878_86C90C49 
X-CRM114-Status: GOOD (  15.49  )
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

On 12/12/23 10:09, Jeremy Allison wrote:
> From: Tanjore Suresh <tansuresh@google.com>
> 
> Enhances the base PCI driver to add support for asynchronous
> shutdown.
> 
> Assume a device takes n secs to shutdown. If a machine has been
> populated with M such devices, the total time spent in shutting down
> all the devices will be M * n secs, if the shutdown is done
> synchronously. For example, if NVMe PCI Controllers take 5 secs
> to shutdown and if there are 16 such NVMe controllers in a system,
> system will spend a total of 80 secs to shutdown all
> NVMe devices in that system.
> 
> In order to speed up the shutdown time, asynchronous interface to
> shutdown has been implemented. This will significantly reduce
> the machine reboot time.
> 
> Signed-off-by: Tanjore Suresh <tansuresh@google.com>
> ---
>   drivers/pci/pci-driver.c | 17 ++++++++++++++---
>   include/linux/pci.h      |  2 ++
>   2 files changed, 16 insertions(+), 3 deletions(-)

Please Cc the PCI maintainer (Bjorn Helgaas) when reposting this patch
series.

Thanks,

Bart.


