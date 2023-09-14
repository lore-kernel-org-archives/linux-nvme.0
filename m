Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA0CDEEAA7A
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Sep 2023 22:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+PqC6H41R94oIEtAqkvPL8FkaxIuI7zR7zQtIJEFvIA=; b=NbX0ZUK7nkrbTV8XSdame1qsOT
	sQIJZeUYAqrp59y4SzZVX9P1BcvnwMtwJLqs+gPX+ftCpHiRbQFVo/9ULVt0hZY5iZMNtIIamer7k
	mI+2roZvxCCZIJwsdXsWkX7LASlXQnqN5LTkt9wdLC3Iw4FffaSPAeJ/OQ9aYzK40e5I8Ejnm0rev
	PDT35QoTXQPUaUWFW6VBik2XyjZ5RiWV5cPCazohWXibHWADYd44G4EpotPwOz4UZTyP6Zgh9bz64
	BWznAaklWhuzJoCB7ha5xWHAZ+DAoiFY72PJERGNYDX5WFp1+sQ3ue0//UfiWfSU82gw5Oy3l/gBy
	BzkWXWAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qguhw-009Miz-22;
	Thu, 14 Sep 2023 22:21:08 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qguhq-009MiC-00
	for linux-nvme@lists.infradead.org;
	Thu, 14 Sep 2023 22:21:06 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c3aa44c0faso3198915ad.1
        for <linux-nvme@lists.infradead.org>; Thu, 14 Sep 2023 15:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694730058; x=1695334858; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+PqC6H41R94oIEtAqkvPL8FkaxIuI7zR7zQtIJEFvIA=;
        b=sSRnZGYt1yUSj5b0VlFeveEzyztZdUwSL6FIdKgEKq2OTc03HEIg+v8YaaHA57hA0r
         9YclcggxIeqO9EXQbFl6oVeVB65anj91SeOJbgAX9tK0AbPB1hNJc4MGkqb17VU0lyx5
         1Cc8c4pX2FiQWnfVc8quJkFFNpOQeP8bvZ18ZE9y3YXcUQJ6s42oFGPCcgjMLsyVi+Ya
         RyUMgRY92FhypvrQ/zZ/ppWGCqMRUw+Covvn7J92HpqwNYbkp7oVK+o7AUAFBE14AnIg
         Bf5eN+gAXFV6sNnR2qfd6V0Tkt/afWSLzz/lAPtX1n0SdSZnOl8ku2EL23RjhC1+J83f
         fH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694730058; x=1695334858;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+PqC6H41R94oIEtAqkvPL8FkaxIuI7zR7zQtIJEFvIA=;
        b=KM47/LICbxj73eDYGJ2cpYHF9BqdDrz3LDCmCCPv2TKtJZbWMF3mCVhxVQkPOAH7cS
         rxiYq8vH5MRP8P2kOahxlnI7oDA6YMLFtlG3FMt3QKbTR+VAs886If4E9S6KuPUBc+Zg
         nEKOf/Z3Bg1THhK0LYvoTIOAwAq3uTHqVqgQYNJw/e3FV0LNDkCOVmCaYMWiZYnxXfFS
         y6lX5BGwAcrHsvpjRtGsXDn3sB9/ICDuMun+tv+FQUew66LX+ePFhWdzvgJ6FJuWdyyM
         tz4tC0qRPe00T33t6sSqZm55pW1NAIXNY25LgFOTVf+PnsuDQGaQimjbR4a9yNvPiktW
         ZEAA==
X-Gm-Message-State: AOJu0YySIXWvwWk/+gen5lu97PNX7o0FS8nlx3Jrff42cQggqrPbjTWr
	gT3b/zXBisevRN8OnCCPdnNrKRJtSq4rTYZ2gq7GpQ==
X-Google-Smtp-Source: AGHT+IEeg10rGz4Kstizg6NFtjBDkjWiFTsz4uAhqTf+2aewd2dvPoBHrPjTYWfu8Pn7s/YsdxdBkA==
X-Received: by 2002:a17:902:e74c:b0:1c2:c60:8388 with SMTP id p12-20020a170902e74c00b001c20c608388mr7481927plf.6.1694730058405;
        Thu, 14 Sep 2023 15:20:58 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902968700b001bc675068e2sm2068992plp.111.2023.09.14.15.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 15:20:57 -0700 (PDT)
Message-ID: <5a418c38-8379-4d9a-ae70-2062a8f0858b@kernel.dk>
Date: Thu, 14 Sep 2023 16:20:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme fixes for 6.6
Content-Language: en-US
To: Keith Busch <kbusch@kernel.org>
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
References: <ZQNrKAmt0kiR2Zjj@kbusch-mbp>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZQNrKAmt0kiR2Zjj@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230914_152102_268518_1DB712AE 
X-CRM114-Status: UNSURE (   8.13  )
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

On 9/14/23 2:20 PM, Keith Busch wrote:
> The following changes since commit 851e06297f20bbd85c93bbf09469f2150d1db218:
> 
>   ublk: zoned: support REQ_OP_ZONE_RESET_ALL (2023-08-20 20:24:34 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.6-2023-09-14

Thanks, pulled.

-- 
Jens Axboe



