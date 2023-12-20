Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C035C41535
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Dec 2023 03:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NLmGMx4K5hEaXAODJ57U/aqBAUhk4fK2nhxwc2xJRI8=; b=dmjKTN7ji0CgTNmGZVO0tGgmf8
	4THooa9Ql8GEG1SctG0DBUaFjuYg89D0cUo5nhcT6Ic+V49PJhqkQMXWrF2oGnzvyZUCHJQVlMxbo
	7GZ2wfayS+ux/PO3NuI/qO6Ds7Ut3eVHhZxqruBaHaySLCa1U6ygMz7A3mZsY+ez3/FccG4tHxjaT
	0NYXqNli7kJBjBHN7bBc+63F25TDlU/BgT6CnEubrjEocDtW1SiIGJFtaHKAETmW53Yfeu2cQn+Pu
	uLVc6vrG2tPYGyJ8wXaSbB2EfE2RWVSoBzbC4uFYcA3Vf4b7bu1yCQRkB/ye8MMjwCN9LnYCxDbzw
	Z/zxYwsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFn3D-00G1y7-1J;
	Wed, 20 Dec 2023 03:15:15 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFn39-00G1xp-29
	for linux-nvme@lists.infradead.org;
	Wed, 20 Dec 2023 03:15:14 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6d2793532d2so723387b3a.1
        for <linux-nvme@lists.infradead.org>; Tue, 19 Dec 2023 19:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1703042110; x=1703646910; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NLmGMx4K5hEaXAODJ57U/aqBAUhk4fK2nhxwc2xJRI8=;
        b=nl+rwc8uX0gJSeisAVilOGCoNTL+q1979YzCUCnvVPe9rvVV7LH5XM3CbU82FE/df8
         CI+DQ1iKDdc10YV0jdOYBvANhBJnXP3t7u1Fe/IJtrasc3JJ0coh9BSYZaAN2VbaLCh3
         9t0PZdrUjk8Rhk6p5I1OBmsXcuotGia1ecARNyjvhq12zjsdsQJkuVQm+EAB2q5HALgt
         wucjnl90O+OP1/8QnI7S9OsZOIeDcdSfydHUPE0cuK7nwYxCIZCEMtP60CtlqXko6Ipj
         o+ATqgt9mrjqNGL12sT9jW5Vzp5KUoyJcS2mFmBUaFTEI/v0DqOvutvJVqCyOy1CRePp
         hU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703042110; x=1703646910;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NLmGMx4K5hEaXAODJ57U/aqBAUhk4fK2nhxwc2xJRI8=;
        b=iS84o9X+BU1V/Pg022tmafAuh52HIhfmSAdYLYclgvF3C0L79HEOBveEqNbM+AhP3E
         k/12xFwltSimW7i5Id7h9AxPAw61U7BTCv7BytW8axKyUUpoDzWk74FjBWnXiJrrSV2u
         lA96c1tv56WEnSU1USvj9MWpgPTe1xUjM8RG0BrQputTJ989M1eDxvNZv8F73GuTT4vG
         bDUevD1gXMVK3FtKpMDEn2/0UTA5Olo6D1yTgUW/jrENJjZbHCIq1gftaFuOI4W8LoLr
         pINYrET+6fm8j1ost+2GbkeOh9uuqqwp6qTa4f+5d9p05AhY0ld0kgOz4XJ8aCrNJKqY
         /vjQ==
X-Gm-Message-State: AOJu0Yyff2jUFN5f5Nv4csBo2q95HRCxtRsDTDktTVGDSyKT/n+7cigX
	8SzVvkg56s4YexgAcgi/MoNsvQ==
X-Google-Smtp-Source: AGHT+IHhQem/TRkVGncaO2m5MTdFzKb8Agqzc+T5Cii+MFwQJF3TIBnicSn0Y4VCxwX8bn5KgaxyRA==
X-Received: by 2002:a05:6a00:4655:b0:6cd:e328:9d8e with SMTP id kp21-20020a056a00465500b006cde3289d8emr40510590pfb.3.1703042109947;
        Tue, 19 Dec 2023 19:15:09 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id w17-20020aa78591000000b006d3b7f40292sm6970224pfn.19.2023.12.19.19.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 19:15:09 -0800 (PST)
Message-ID: <678b7be5-78c7-4a52-9f03-b28d01e482b9@kernel.dk>
Date: Tue, 19 Dec 2023 20:15:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-fc: set numa_node after nvme_init_ctrl
Content-Language: en-US
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
 james.smart@broadcom.com
Cc: sagi@grimberg.me, hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20231219174934.20400-1-kbusch@meta.com>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231219174934.20400-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231219_191511_925416_4EB50422 
X-CRM114-Status: UNSURE (   7.37  )
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

On 12/19/23 10:49 AM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> nvme_init_ctrl() always sets ctrl->numa_node to NUMA_NO_NODE. Set the
> desired value after that function call so it won't be overwritten.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe



