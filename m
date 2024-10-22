Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC22D2CE14
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 18:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=msYqstjct0oAQ/cW9g3XRszkR69o1mt90GYAsJNGvvU=; b=ibmpQH2K5UJmgAD1USEZ5auNGD
	+Fg0Tx0Si8y3vkIDa19Rkh+kP3ZfGCYiJDEhWzV3jy/QuOzwlm3G3xD6v1Qq5Lse0O9ysUOD2JYtp
	xvWCnO/9k/xfc6outGBPqisgdIW88enXG6UoPsRpfeIBACY/N+HecmQ1FpFluKB6ccl4ODw4W5BXU
	3jFe8yeKwEJh7+Lm7xq4/hKineSRGxZ87b8QTCasldyvTHb0cshpCbJ6KjiZh1g+KhSWrySg8Enwm
	ReWvoenhl1JAV8UfnlHOKSKk19aueQfqqL8dPYge3BpIKpqYC8Tz2w/7eX11q+iWd5161PQzolb/s
	SAtg1EaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3JNG-0000000BmZl-1pE2;
	Tue, 22 Oct 2024 18:12:54 +0000
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3JND-0000000BmZ8-3X5p
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 18:12:53 +0000
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-71e74900866so3995563b3a.1
        for <linux-nvme@lists.infradead.org>; Tue, 22 Oct 2024 11:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729620770; x=1730225570; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msYqstjct0oAQ/cW9g3XRszkR69o1mt90GYAsJNGvvU=;
        b=Nbqnum4CPyu4mzhQsohnAOI0hWMEoFDCbbWnkXdSkbnNJQTjY/3sa811CQoJ63lHnQ
         P5YPEBAZ2otWORYI1b0lHstIUZvqOiA7wGlAaHae6F46jh+ERBNP1gZOIu7BmV0Ppps7
         jQquq9Y69vEK9DipEKTN6VSbEgwbY0Phc65/JdhEKFSkCLx+RE0yMmknQVHWY2ljuRR1
         yS7dbDT9409ttyEqvjbWY5v6Rkvkm/S1iaUJOUYxp/TSWxLpWY6MF6UF4/9bpcbapxVB
         MMhz4mFX0ZxSOXiEwbG9t1ji15KIyptKVn4Pyd9XCe+Trp8n8Rgnq3fCm9xqXXvU6IdM
         Sp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729620770; x=1730225570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msYqstjct0oAQ/cW9g3XRszkR69o1mt90GYAsJNGvvU=;
        b=aztlNjq1BADeFdrxHJFBVKh4U//P6S476CRezpn07nR0sZeEf3pvQhPE1uSSKyeamE
         GkuutSxN4wKz05Ia8VMsyGcUU/+5OVrUaRM5kiJBtAcarJJHfm0S9ybdtuG/AhhpTkDz
         ffmC0XDuzYtVgL4ooWrMQWeZL9yFCphuyPZ6AHXrYTBinlDjUWN1Ph+YUlkSsfqoh6w7
         h06mMaVhqKy/vIJVQeyK5OSQlz+eYAxswDN6I/4FnD+gfrb8q95VWZb0oLMuCEgffST6
         BJwg4FRDPVrba768tXvWpuBzZADw1eXhTS50dNIcwk6FfdsEAArbNPawjvM4jarx9uNY
         ISIA==
X-Gm-Message-State: AOJu0Yys3OmVLTsBFC0ESaThOkgyW/R76887YTN2znEJj+MkI3CyVVXX
	EXH1FJztNwPu9478usu9t7AxquajAEaSHjrm4JEBRrUKsgl5sx31
X-Google-Smtp-Source: AGHT+IHtmm1ADoPtizA1bx6aRlpW6Ei8Vw+wb3sfiAXxILfHJKXF5CNEDlj6wFS4/bFNEgoYLXCNrg==
X-Received: by 2002:a05:6a00:3ccb:b0:71e:4c20:75fc with SMTP id d2e1a72fcca58-72030a94778mr151225b3a.10.1729620770237;
        Tue, 22 Oct 2024 11:12:50 -0700 (PDT)
Received: from ?IPV6:240b:10:2720:5500:f6f1:2f90:dd68:7e46? ([240b:10:2720:5500:f6f1:2f90:dd68:7e46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13ea230sm5016973b3a.151.2024.10.22.11.12.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 11:12:50 -0700 (PDT)
Message-ID: <b5504bf0-95c7-459d-8192-cdd80371dbdd@gmail.com>
Date: Wed, 23 Oct 2024 03:12:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: check PI size if metadata size or below
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <20241022163504.10738-1-ikegami.t@gmail.com>
 <ZxfY2IT15o_2vTZq@kbusch-mbp>
 <d5735ddc-a3b4-4204-b8fa-b97566f8a91e@gmail.com>
 <ZxfiADxyL-uZYgBf@kbusch-mbp>
 <d38404e8-e01e-4dad-99f2-7bce3a68bba5@gmail.com>
 <Zxfnj3HwRjZpHTHa@kbusch-mbp>
Content-Language: en-US
From: Tokunori Ikegami <ikegami.t@gmail.com>
In-Reply-To: <Zxfnj3HwRjZpHTHa@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_111251_915808_50483E45 
X-CRM114-Status: GOOD (  11.48  )
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

Thanks for your confirmation. Just sent the v3 patch to change only 
nvme_ns_has_pi(). Thank you.

On 2024/10/23 2:57, Keith Busch wrote:
> On Wed, Oct 23, 2024 at 02:51:16AM +0900, Tokunori Ikegami wrote:
>> I see. Thanks for your explanation. To make sure let me confirm again below.
>> The nvme_ns_has_pi changed does not use PRACT as mentioned but still is it
>> not okay to change the function only also? (I could understand as
>> nvme_submit_io() uses PRACT then it does not work correctly as mentioned.)
> The function name could be better. It's just reporting if the namespace
> format supports inserting/stripping metadata, such that the host doesn't
> need to provide it.

