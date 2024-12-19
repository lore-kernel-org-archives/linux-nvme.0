Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AAAFE77184
	for <linux-nvme@archiver.kernel.org>; Thu, 19 Dec 2024 14:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:Subject:From:To:In-Reply-To:MIME-Version:Date:Message-ID:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=PO0zPmztdC5j72zStCRzKBOf0n1b3ICvvJZMOp/c/bo=; b=jYytEvdpsGcIgt2PSXMfVR0fro
	Wxpc5oKyccyxFCkgA9lYqSlOLp6G5jAL179QUjNsJunIT9V4mCLd124wHSKiW4nYOyrjqRETnaNXl
	1XBnoullfUUYYzt4NfROMmaSwGWbEGvN8xT6D4uI5oLVHPtjBRX35Xpd+gGLAUOvJZJ9vjnqjRdJu
	kcRo4ipLmfpzyn/nSv3Ey72wDFzdsjrbETSpMykNClwS6L0P/1AaLmE12MnGL0AbRxmQJPW7o/WvW
	+KGbxzCLYB4oBxpNMFNSOdxte7M+/zUvTTUfO4hC5pc8EwsIOvPycNYAhhY7kuDdCykBj+/Au5rlV
	OnF+HG3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOHi6-000000025Ba-281k;
	Thu, 19 Dec 2024 14:41:06 +0000
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tOHi0-000000025BA-1lWG
	for linux-nvme@lists.infradead.org;
	Thu, 19 Dec 2024 14:41:01 +0000
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5d3d14336f0so1381624a12.3
        for <linux-nvme@lists.infradead.org>; Thu, 19 Dec 2024 06:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=yawk.at; s=google; t=1734619258; x=1735224058; darn=lists.infradead.org;
        h=content-transfer-encoding:subject:from:to:in-reply-to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PO0zPmztdC5j72zStCRzKBOf0n1b3ICvvJZMOp/c/bo=;
        b=gWg7Tn8x6Lhb5IB+0M1IsYGxzVulhUmdK8KewhE33ZNaR0CcGDZ0T3yS8K0XUoMZTY
         JtxYeqbwSYw4T+revqJC6Q30Mc5JGC3EuRugr5hgERyrXc6XwC1l/H+XwcIVwanbhrk8
         vJCD3PIMdrF4QO/EVnJr1sdB2Wm2u/rEjdHeJ+aGDfYQUbYSjD5fMjNK71ZM/5AQBVvs
         ASXd5c3tqAN6FckLv39LlYM54rArigyndnEtBnHVwjdNa4mziahT8y9/xZPp0gQ8H45w
         3qOcJaOt611av5K5uUx15L9jpImUkacWCDLvikWH1AcYFLwLsiPspcdHsYK6bV/dx92r
         /edQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734619258; x=1735224058;
        h=content-transfer-encoding:subject:from:to:in-reply-to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PO0zPmztdC5j72zStCRzKBOf0n1b3ICvvJZMOp/c/bo=;
        b=AZ9dJ1qnsOROcTEp5L3ypL64X8a5NUNche54SNOtyWxLYxfiX0dfKy16eWcOpYxdu9
         p7Zf65wzWXYjKfM6Wqkln55iDcQtQlVzQFidVUjrw3ra0+ZmI3Sab5p/2B4CQkTvb6OQ
         L+ZeBpNlN17R4IYEYBHM5ZF7L5kIkSA2rZIDd7nREXjBa5wG8t6rRTwXO/AkM21FNZmE
         7cgKSXo08GGuNvZvHa3L30RUiOqSaZISXSsoK9E9yci1OU/zNl/+2K/DCJC4SY2Bx9M5
         VdGvcKC8ascQx4ytHgzSDwY/SElyBs0vC5QH06hS7qo3cUx3OzfG/tYuOdTgY9DBEu6+
         Ftow==
X-Gm-Message-State: AOJu0Yyx8DJqIr+3NHv/qYhenvUR1pDC9ZZSLNGhfMTT6v24XMtBS7NZ
	pAv0JX+jvGMdkrvxumUzoGmh+Us5rCC7WA5AijlMV6lFwXsvCqN7AHuxec2rKq1rjgLWPW9HC4o
	c
X-Gm-Gg: ASbGncuCobfXzK+799KWGpu1K6VjqIhBb2XCtM1cZ5YaT6GfAwzSOXqWrepDNIoBLPT
	yZAg3q6RmnI5IJhF2NPhsS5CWQbE4co1RkTG4R0alukWQGD3A0Xji0IDBlWSyAKNzVRd49KRYEW
	59SjYTsM8PQilp9abMYXpouNrfWkLImFXmZtoNeIkVmi6hwAqOdnkVzn5/DP3ko1EWxZr7ElsQI
	VMhrcJgLqo4J7/YrHnFbLpfz3SUWElq4Vqa3V/dornsaar8serG6KbTXv4kTaQCh1bBWgdEqoOJ
	jm3sKRoga16D
X-Google-Smtp-Source: AGHT+IGE1ojxrsYmelVqYTlsfX+phYJCuhXxODY/MgzweMJQ9VJe9i7v1FKZOyv/w3eEmnlapAHFow==
X-Received: by 2002:a05:6402:13cf:b0:5d2:73b0:81e8 with SMTP id 4fb4d7f45d1cf-5d8025c5f25mr2605126a12.9.1734619257801;
        Thu, 19 Dec 2024 06:40:57 -0800 (PST)
Received: from [10.0.3.127] (ip5f5af6eb.dynamic.kabel-deutschland.de. [95.90.246.235])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80675a3d2sm714567a12.16.2024.12.19.06.40.55
        for <linux-nvme@lists.infradead.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 06:40:56 -0800 (PST)
Message-ID: <21f8ea47-6db8-44bb-a723-a34e0b0cdd8c@yawk.at>
Date: Thu, 19 Dec 2024 15:40:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
In-Reply-To: <2ed1a7ca-9591-4726-bba2-c091f28cd91e@suse.de>
To: linux-nvme@lists.infradead.org
From: Jonas Konrad <me@yawk.at>
Subject: Re: Re: [PATCH] nvmet-tcp: get rid of a high-order allocation
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241219_064100_470217_7C0BE9A9 
X-CRM114-Status: UNSURE (   7.91  )
X-CRM114-Notice: Please train this message.
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

Hi Sagi and Hannes,

Can you move this patch forward? (from August, if you have to check the 
archive)

5572a55a6f830ee3f3a994b6b962a5c327d28cb3 fixed the kernel crash 
resulting from the failed allocation, but the allocation still fails 
regularly in my setup. `echo 3 | sudo tee /proc/sys/vm/drop_caches` 
works fine as a workaround to free memory to make the allocation work, 
but it's inconvenient that I have to do this daily.

Thanks,
- Jonas

