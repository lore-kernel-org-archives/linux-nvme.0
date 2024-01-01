Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DBA5C47073
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jan 2024 11:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0QMyR9MZs2f5BsZujTdKfKhGos0H/Pf2IflC8qv/jSc=; b=VxL5HGHMtVE+iDdbmkYYeBABZ4
	GFNJAdo0OsrdgjbU4zaE6cVmY57TWk8iz+v/dO8oUaSa7ka74b9+15TANPa4KFoP14u6xrXlsPZws
	ddtEnu+XaRLsEPCr1OMKXDRKpsSXqSbs6ZO5TBGdgalYLAyxikPhHS4kN6VZqIQRm69SiyZW9ENsJ
	+ZGPuhpY1piMoXBvKn2Tyhxjer9zMbQe6ppyxTjeANW9zZiuzEzXMXnBC240yrUmpJrxFo4Kzkj12
	JEp0VzwU9rXPWS0lRyMnWsNzSazBV+R6yWlWxq8psr3LywmB+Ox4ur+YYQx1X4/tVQjiTb6CMnBTU
	yLigIBTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rKGLg-005vzJ-26;
	Mon, 01 Jan 2024 11:20:48 +0000
Received: from mail-lj1-f174.google.com ([209.85.208.174])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rKGLe-005vyL-0C
	for linux-nvme@lists.infradead.org;
	Mon, 01 Jan 2024 11:20:47 +0000
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ccbefe570bso17740941fa.0
        for <linux-nvme@lists.infradead.org>; Mon, 01 Jan 2024 03:20:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704108042; x=1704712842;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0QMyR9MZs2f5BsZujTdKfKhGos0H/Pf2IflC8qv/jSc=;
        b=G7FhRi+lFwLcP+uYVTsP6FjdVfa3Y8ehV4rCGpsvYRv1ePNwicrqlEuMnlPGff4cIf
         GRDQsSC8JdlvT7vK7KEQ1KaCc2nIgWoihyFfZLJhQhl5lyOwZDWVi7a3PEro6U8xywrx
         QVo27w1kYiU++NGVa84J5+IJsM1EGQ2SJfkDZjkKV5TW6LsL6xxKWhOF7TRRXnE7z32s
         zS4T2R/9H0+aGtTsN78BduwnQHjhxJrzvBdX87j6Cvb31hlDxiR9t9HvhSK7Bm+cx0Mj
         co6jjzUyPTASowFq/W10GS8FEWdHAkRcK4JhSZesovRNuJ6v0TvBR4JLYkFvCx8CcDT3
         OPhw==
X-Gm-Message-State: AOJu0Yzp6Rl1MPiSRCMNetSMENc1Bvt/WvivrZY3KzWavNGRdrg10EJe
	pE9stE5tmiCOBRkMErbtB/s=
X-Google-Smtp-Source: AGHT+IHbkaVdUqP9uSDcdDn8VaZCs4hsJttShgjFrzWiWyYFPss4XCAeC+9tNVHYAXg/e3AUkaXs6A==
X-Received: by 2002:a05:6512:3d02:b0:50e:77b1:91ce with SMTP id d2-20020a0565123d0200b0050e77b191cemr13189479lfv.2.1704108042111;
        Mon, 01 Jan 2024 03:20:42 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m2-20020a05600c4f4200b0040d5c58c41dsm20303033wmq.24.2024.01.01.03.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 03:20:41 -0800 (PST)
Message-ID: <d034eafa-926a-4bd1-9492-84e94fdb1139@grimberg.me>
Date: Mon, 1 Jan 2024 13:20:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10] nvmet: remove NVMET_QUEUE_SIZE definition
Content-Language: en-US
To: Max Gurtovoy <mgurtovoy@nvidia.com>, kbusch@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org
Cc: kanie@linux.alibaba.com, oren@nvidia.com, israelr@nvidia.com,
 kch@nvidia.com
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
 <20231231005249.18294-5-mgurtovoy@nvidia.com>
 <c1f4a478-384a-4715-a7d4-0ac2c822e26c@grimberg.me>
 <bf5b30c3-9ec9-457b-93cf-143c9965e1e1@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <bf5b30c3-9ec9-457b-93cf-143c9965e1e1@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240101_032046_121658_D3CB4BCE 
X-CRM114-Status: UNSURE (   9.08  )
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


>>> Use the common NVMF_MAX_QUEUE_SIZE definition instead.
>>
>> Why?
> 
> In the next commits we introduce new interface to configure 
> max_queue_size of a port. We need MIN/MAX/DEFAULT definitions for this 
> configuration.
> I choose using existing definitions exist today in the hosts drivers.
> If needed, I can duplicate those to the target but I think there is no 
> good reason to separate these definitions.

Aren't they separated already?

