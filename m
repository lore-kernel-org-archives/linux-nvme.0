Return-Path: <SRS0=dfbP=KU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4CFC4707F
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 17:33:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA71961423
	for <linux-nvme@archiver.kernel.org>; Tue, 25 May 2021 17:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA71961423
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=A60YHWAtyftDXNQ/6FPOs9dSLPd1wdjJI9kgnZhP0OI=; b=DkaUWMreIzjm15C3yUrbqcV9XX
	WLDjsRc1xfLmUt+95Vb3l+H+M2zjI42cbFfD+N7jfWkJHrcmCs+Lv0EeTDzKVXhB/xFlZrxYeTjUA
	nuwhgH35GJQ+/9kxpvzOIVaIxeCWEmXk9gI6jbMi9ylfsWdTrq47/BQUf9OFm4xfccjaLs0k6fcyK
	8L7HxSaWC3Tlx0fGgYfBkSnbrmULTpKQE9kQ+apnUuhgBxLUr3CBKViWWFcr28bus/iueLujlnJwk
	nM6QKXXnTt/7Crrmu4GPR0Sx0lVnMktuW1nqj2xEPNVjVashdCgeSujCmgghBzvEf1ruBuN2LQVPQ
	F4PYNg7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1llavW-006ual-Ce; Tue, 25 May 2021 17:33:10 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1llavU-006uZ0-0Y
 for linux-nvme@lists.infradead.org; Tue, 25 May 2021 17:33:09 +0000
Received: by mail-pg1-x530.google.com with SMTP id 29so12208349pgu.11
 for <linux-nvme@lists.infradead.org>; Tue, 25 May 2021 10:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=XM3/5IYnmifYeNLRv6r2aAO14RLCFa09MsHrhJu0OY4=;
 b=GpDxC/rh5F44PQCnS5KLDTYE8wzYYqVAe9oqe4dwE2rEijRbYRuShW67+OsW5gdwtE
 oLMtWuVWrGhLbWdOytLJrHtZteP+5sGkdAGZJQHmVf6qoUzWhziUPj3GQmXhp1HO6QM0
 WWEe0r4fY2Ctz1Byv3ic7uavK0nuYifb/ZyboVucEAsAv4uiY7UoRWnOZ8Qd1JDarkJG
 GcBcIYHyl1zvllGUYgZCu1sgYOt8zV83YHY8iFwGYUWk+rl3A4lwfQ07/p/HRXwVUm4N
 BrNQs0MG31hSTjR6citvcKZEQlUdnKniwLnUNRB4+FrejSQ+1zJC7uB2eBKa/q/PO593
 FWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XM3/5IYnmifYeNLRv6r2aAO14RLCFa09MsHrhJu0OY4=;
 b=Exa78yZz/Fzg9kDRO7UQCe8AmVk2zxx4Ew2NN+V4j9EHSrnmOdo/8oRiPWqnGUdZZR
 kpUKhs90LRVZDuhGXgI+LeOB/zojYrBEBtYgdArGQIffDFSscQ4iViYYZqwvxM0AqNq2
 S6P3XBgh2/26lZKX4MbSgJPqZeZQTITPAOXXVh7/EO8szHXbaGS+ZRVt5MdCJ3VdzcaW
 uPI+yWPyLO88RbmaAyjkEd+92Jt536DUYdnv68ln5LrONKG4M8EF+iT4aNjCusM6G0qH
 YgAzMgR9u9B6UI7p9Itb1/Ku4Zv48xCdfRh0srIHsOO5T/ct3cEfYFCRanmEGp3S8gnt
 SQvQ==
X-Gm-Message-State: AOAM530ImOZDA0/7YE4zGOscN3PD1GTYdiVgm317D/wL+e38VI5hxrOa
 6JROSz4V5HdpHl/NxA20HbedYX7/u3Q=
X-Google-Smtp-Source: ABdhPJzPkupdZKqU1mja57+o5XChp76ONjCSSUBg6f+6HXDWeE+u4PeHZ9j4qGdjtYhQwmpYCPlYvw==
X-Received: by 2002:a62:17cc:0:b029:2de:39c1:7eb7 with SMTP id
 195-20020a6217cc0000b02902de39c17eb7mr31081202pfx.26.1621963986267; 
 Tue, 25 May 2021 10:33:06 -0700 (PDT)
Received: from [10.69.69.102] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r28sm14500940pgm.53.2021.05.25.10.33.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 May 2021 10:33:05 -0700 (PDT)
Subject: Re: [PATCH] nvme: Have NVME_FABRICS select NVME_CORE instead of
 transport drivers
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
References: <20210525155946.2249322-1-sagi@grimberg.me>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <ba9c27c7-5eea-0c93-7b20-e6a5d48c9e02@gmail.com>
Date: Tue, 25 May 2021 10:33:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210525155946.2249322-1-sagi@grimberg.me>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210525_103308_109900_4628DF50 
X-CRM114-Status: GOOD (  12.46  )
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

On 5/25/2021 8:59 AM, Sagi Grimberg wrote:
> Transport drivers need both core and fabrics modules, instead of
> selecting both, have the selection transitive such that NVME_FABRICS
> selects NVME_CORE and transport drivers select NVME_FABRICS.
> 
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/Kconfig | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig

Agree...

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
