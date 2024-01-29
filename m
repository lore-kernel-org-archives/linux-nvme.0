Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882A1C47DB3
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jan 2024 20:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FxpcR0PR8ObziG7SrxGp8xYBxpkHGjuk7n55TmDx6cU=; b=iWJXh+Wv1UK4IF2Y+Uldi0/Xbs
	z9E1AYAfEVNgPmuAhAerjUbmnj979y4zGPna28a4g5dYk9Yx4Yz9wl6spm65zRP0phXw+iNTC+uAL
	SeKN1CJvDWDf12QDwNydR04/1fOUeQ6yjesce0nJmEbgOipVynOhTDSHqinyk2XV+qOFeVtr/limk
	QKGlbZk+6O4s7LSgl1WOp7bHpKV4uuTCWAtnPZe0/507mLzzxrtIZWpDHkc0CQM9nahxpNXot2dox
	Ox6q62vAnuUHKHe8uuVH7NaO9OH6cO2Jl1fM9yB1Y2HpkSPtAI7kiZ3ODLgIFzMW6MRZwbRVLup86
	J99uzxiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXov-0000000EBg1-0M9N;
	Mon, 29 Jan 2024 20:01:29 +0000
Received: from mail-wm1-f42.google.com ([209.85.128.42])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUXos-0000000EBf2-2dJF
	for linux-nvme@lists.infradead.org;
	Mon, 29 Jan 2024 20:01:27 +0000
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e544fac26so8314455e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 29 Jan 2024 12:01:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706558485; x=1707163285;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FxpcR0PR8ObziG7SrxGp8xYBxpkHGjuk7n55TmDx6cU=;
        b=hM5SiEcW8+BxEjTWlKo4h+fgmEpY13MrGNAegXnqwFsvHPmjD+xZFkuxH4++w8CbzL
         FdowEQCB81PR+sSqSnPu5fl2aJHwX3GwFAq/5m0/K421H0PQlPValB8Yqx0z+e2BF6jn
         UvGbO9umVVsK3gWegSly8UE0QAGCV41Cvd8sENU2BFdHm5AVW6IFicJ2bsYsiILiZ/zI
         EZVEgr8LBrhgbSVhTtVJ91nrntX466joelOkkAgFk2CwaA2AVTyGzhsXDFauiDymFtbz
         n0nZo7u/Zk3sRcevgWAFxAtC9Jcp8zFdSDuprCLmSIhbnyiu1xcfUctu2oUNbnmX3Xlk
         t+GA==
X-Gm-Message-State: AOJu0YyG0GbGmB53qMLDYlQsMYl2oJxG5IZsy8KCxwsmr5la/2xXzWLE
	/fUITQk/QcmPzYKscTuC5qlnC3Vpp66delZlB10AdITTTQivvNusRy/dgZvl
X-Google-Smtp-Source: AGHT+IHIfqNU6OpVH3NVjWBHqI9ji7Xuwz2m2a6cs0FwmXTxA0z7QYmjskIGx8HKcGbBm+gL9fEWPw==
X-Received: by 2002:a1c:720a:0:b0:40e:e9dd:c290 with SMTP id n10-20020a1c720a000000b0040ee9ddc290mr7043163wmc.0.1706558484788;
        Mon, 29 Jan 2024 12:01:24 -0800 (PST)
Received: from [10.100.102.67] (46-117-114-124.bb.netvision.net.il. [46.117.114.124])
        by smtp.gmail.com with ESMTPSA id eo6-20020a056000428600b0033af5086c2dsm1401965wrb.58.2024.01.29.12.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 12:01:24 -0800 (PST)
Message-ID: <40fdfb12-ceee-4acf-bc3f-39013aab53a1@grimberg.me>
Date: Mon, 29 Jan 2024 22:01:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] nvme: simplify __nvme_submit_sync_cmd() calling
 conventions
Content-Language: en-US
To: hare@kernel.org, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>
References: <20240129063948.3105-1-hare@kernel.org>
 <20240129063948.3105-4-hare@kernel.org>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240129063948.3105-4-hare@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_120126_726570_622199BD 
X-CRM114-Status: UNSURE (   4.75  )
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

Probably leftovers ?

