Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F743C3DA79
	for <linux-nvme@archiver.kernel.org>; Mon, 15 Jan 2024 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5/10vs4HWe516pGTe3L7woNpjjKUUUT4vvNQBG6j5+Q=; b=TgW1dPTjldZtRoch63rvZTS3MC
	vUD2KDnTpvZR2xfHGsOsYk+1zPgZXm6xqxmMJseG5ZVyE6268Y3L3enMF01KEQiMOZiOb65Vt++n8
	4UIBrVv9c1QFinFoNtV3aiH8rMaupkGrKBEJJu2dXL/dXO17K9yBqNb009CJiPCmLn/NF5LTrUvf1
	4KY+19F8ZeOHKOCxAMX7dDTX/PHRN6Jusrp8rUZYQVNxKPUi0RvixRImH08oTLsPsEypMJzMgXzc9
	Ls3Oh/kfRpiruh0NULQM+ojT4IWAeumJR4B+38KxZFwr+d9YUfbvMXCfAeRH+gVL8twPRzaxLtRut
	abkSlMXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPMO3-008wDR-2K;
	Mon, 15 Jan 2024 12:48:19 +0000
Received: from mail-lf1-f49.google.com ([209.85.167.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPMO1-008wCw-2E
	for linux-nvme@lists.infradead.org;
	Mon, 15 Jan 2024 12:48:18 +0000
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e79299da9so1589903e87.1
        for <linux-nvme@lists.infradead.org>; Mon, 15 Jan 2024 04:48:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705322894; x=1705927694;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5/10vs4HWe516pGTe3L7woNpjjKUUUT4vvNQBG6j5+Q=;
        b=TJK3/l3HTT3BoUNiJ8SXvZDV9nlHfkioZYzGLju3f3h0n7iXZCob/RaJjvrxtfS091
         zTHIxbmvc8sbmPQrogQJ9OyM6anCXjn6unb0x9fbVIs7pahIxsHiwa9uhzMKVr+gl5/o
         9xUJgj3QV68EfSdA8goPQ9pZ3pXmjKQFQtzbsWWhqEph2Eufv9nELzEuTi7qgCPvhE4K
         a5J7Q9OyJLjEReeuMyriiFOpqKw9VE+PglsA0q9OH3qYc9UQKpmwSKYRTfVAOts5uYQo
         /b8bfT2vas60zTs72BO8FV6pJBt45TSNbFn+J3BcZCR0lsC4ad3IW6iH+GvjZmdCtx24
         bGMQ==
X-Gm-Message-State: AOJu0YwJi6Ua1cv8obptdZrYQfSDb9wfEOIUnX7qUgWRk9tznuG+OPdj
	My4mXgkjTEr51KMEE16oImU=
X-Google-Smtp-Source: AGHT+IG8dNy/A8kicks0EZ2Ca7voprolgaAAm2anpBsf6XBvv33s9JCiglINp3RQs7lBYXFO+RfAJw==
X-Received: by 2002:a19:2d55:0:b0:50e:76a4:f593 with SMTP id t21-20020a192d55000000b0050e76a4f593mr4506068lft.5.1705322893854;
        Mon, 15 Jan 2024 04:48:13 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id d6-20020a170906c20600b00a28c8ab1342sm5257155ejz.96.2024.01.15.04.48.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jan 2024 04:48:13 -0800 (PST)
Message-ID: <f2822df1-22db-426c-86cd-a7509e624e06@grimberg.me>
Date: Mon, 15 Jan 2024 14:48:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: Add quirk to fix hang issue on SanDisk SSD
Content-Language: en-US
To: =?UTF-8?Q?Sa=C3=BAl_Valdelvira?= <saul@saulv.es>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org
References: <20240113213012.30898-1-saul@saulv.es>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240113213012.30898-1-saul@saulv.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_044817_726533_DBD33044 
X-CRM114-Status: GOOD (  10.24  )
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


> The WDC PC SN520 SSD hangs on boot when APST is enabled, unless the
> nvme_core.default_ps_max_latency_us kernel parameter is set to a lower
> value. Add an entry for this drive to the 'core_quirks' table with the
> NO_DEEPEST_PS quirk to fix that.

Is this specific to a certain fw version? otherwise this should perhaps
live in the device ids table in pci.c ?

