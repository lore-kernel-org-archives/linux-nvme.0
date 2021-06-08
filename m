Return-Path: <SRS0=UQCu=LC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED18C4743E
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 15:40:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4371D61359
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jun 2021 15:40:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4371D61359
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Q6z23rubp6Zo//Mqn6Q4tQqc60hVMslYfBnFLW+05c=; b=18d8/E3LhRO+9sqZ+VzKLN2k7x
	S+pkXYgDzSHG9+6vXJdc4k9SgS68hA4ymI0DV9NuN16SYHNbfOjpJ+48+U8b3u51aV0s3BQZUIv8I
	+LJv6LX71Fssq/Ttu0/uUilPBdNn3yW5UDth02Vhb7hAjeXxXqFctxeHcws+MJp9ZEVJattU4/SBO
	ybt1hWDyUXQIp+ZNaAGnet8vW1Ay9vNFPh7SVd+EJFzbAZgzpfvFYsx+OhnSCyzJXnC9m0gG6a/hw
	9dRS3mRmO4Z8lRhFJjF87uFZLaQmM9NyGvnVyBWdTV1rQB7HqPjEBsyepFrlmmGlr9CC4FMxKxdBN
	pegZWA0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lqdqE-009HhU-0u; Tue, 08 Jun 2021 15:40:34 +0000
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lqdq9-009HdR-L1
 for linux-nvme@lists.infradead.org; Tue, 08 Jun 2021 15:40:32 +0000
Received: by mail-pg1-f172.google.com with SMTP id j12so16809196pgh.7
 for <linux-nvme@lists.infradead.org>; Tue, 08 Jun 2021 08:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4+Bw3nsX13gozCMmD+SjZAMDGVZYNb9RelUZbLJhK/c=;
 b=nTStSQIr9HRXXG1TAFn/xPzyI9BEa25RTxxkR5VEhbPEyzfWbvqyXBvOxqMFW7mnQk
 9DBJ2JtChi+Hh7zQEVWkTuzQPqw7CpOs9g7AJp5g066TthyiRby2pFZF5zeuAQDAvBjF
 7ZEhD/lb46cspHC3YpfGgcCLQ2XAKqUfVp587EnJjhccibeuoBKgZw6/ZYy4mH0qst3f
 +G8P5pv3F5KIwvsmvFMoWXiLv4fVJuAnxMsBw5XLEXgkm8dXQxbv+VHLPBULH6OXZl9k
 7HnC6PkQnPUzrOclNvoyZ0Amf+wGrS5FWJ+shZDuEmO5oSX0WgghmP2inQFH8YEj9oAM
 g0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4+Bw3nsX13gozCMmD+SjZAMDGVZYNb9RelUZbLJhK/c=;
 b=OrroJuOyrQRlBJbjCF0UqkBa/Gc6ePPtwXOEFvjHcr7ZN9BHrIpaQksbzErS19viqz
 EI2JklyGmbGFGKfDgjQ1QUHYVuFzxwKWjM/qI0wFoIRdgbPHBX/+2Yo8Azk8fW7a84CW
 mEO6TfnZhsgqJYHm/1z1SkE5rLxnmJdTQH4+JqY8CgRYhxuFloDeEsRf+vPDSzVf5wm9
 /8hBjm4+I+to1UAqEU3RjxaAjFBQ/d1Gov222TY3PhsfXjI0JG7hSP6fGKmEDKdADhND
 VV02pWnEcMqXAmOZxvrq1KiJHptFCDSpT5pq/u0MG5LD5i6EyyCd/onZ25AM8nMpHGER
 3TSg==
X-Gm-Message-State: AOAM530H/EugVXuvr+yZwkWavlT1KYFI+RZGXccyNknSdRWS9G8DrDKW
 I/tDbN25TiTTntryUs22ec8=
X-Google-Smtp-Source: ABdhPJzBYUL8IH8MPtXdW+0Nr+QiqWAJy+Fr4lrSQwRosuWDN1+i2yfmC+A0V9RqYj3kY6Fqy7Samg==
X-Received: by 2002:a63:1360:: with SMTP id 32mr23217155pgt.233.1623166759768; 
 Tue, 08 Jun 2021 08:39:19 -0700 (PDT)
Received: from [192.168.0.217] (ip98-167-23-218.lv.lv.cox.net. [98.167.23.218])
 by smtp.gmail.com with ESMTPSA id n23sm11276132pff.93.2021.06.08.08.39.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jun 2021 08:39:19 -0700 (PDT)
Subject: Re: [PATCH V2 2/5] nvme-fc: add a helper to check ctrl sgl support
To: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Cc: james.smart@broadcom.com, kbusch@kernel.org, hch@lst.de
References: <20210607195454.16829-1-chaitanya.kulkarni@wdc.com>
 <20210607195454.16829-3-chaitanya.kulkarni@wdc.com>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <4ba3579f-7223-c665-6cb0-c00f0a4c773e@gmail.com>
Date: Tue, 8 Jun 2021 08:39:18 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210607195454.16829-3-chaitanya.kulkarni@wdc.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210608_084029_727119_A7AAC56F 
X-CRM114-Status: GOOD (  13.17  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 6/7/2021 12:54 PM, Chaitanya Kulkarni wrote:
> For transports it is common to check if NVMe SGLs are supported or not
> by the controller.
> 
> Add a helper instead of open coding controller SGL support and use it
> in fc transport.
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
> ---
>   drivers/nvme/host/fc.c   | 2 +-
>   drivers/nvme/host/nvme.h | 8 ++++++++
>   2 files changed, 9 insertions(+), 1 deletion(-)
> 

looks good

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
