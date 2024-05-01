Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 181EAC4345F
	for <linux-nvme@archiver.kernel.org>; Wed,  1 May 2024 10:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cGWvhIgXrNI2O6VT23pX5aJQXgnkmeYOaGQGYm6iAHE=; b=ztZTNZW39afTGV2g5ipnmNL7Yh
	EIccXQIVZH1DxMHAf4OgK3dfHgdfJQ6/bLiTzg3dNrqtF4iD+WI6tgSfXpJyd+h79prWo3o/W45qZ
	7okmlMitJtyWel6VijOHkocwU9ycJm9L1EJTZbXcz5egZzYZnFki5CVBq3ehBGyxBg0a60UOJNuVH
	gpLvKEM3b4GoL3WoHrCcnl3lq22hyvFMxsHQkhCYvAWgGzvJ4DYFS9TecjHtRfoGBE/49zvoYRymm
	QWWDkFepQ55DilDtw90GGDDedq173Y9BBu2qelYMtTPHrVJvHC6wfiHH2TKvqcg3kUU8RmmejQav6
	gENRHWnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s27Bh-000000095xV-3NsM;
	Wed, 01 May 2024 10:27:45 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s27Bb-000000095wU-1UE5
	for linux-nvme@lists.infradead.org;
	Wed, 01 May 2024 10:27:44 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34a42d6e216so1476509f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 01 May 2024 03:27:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714559256; x=1715164056;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cGWvhIgXrNI2O6VT23pX5aJQXgnkmeYOaGQGYm6iAHE=;
        b=lITVKPRqpH3l3bk+oN0ONYUDxW4iCD1RgM3AYv1PS7KrESkSPGSR0qh00+JkIYXZmm
         /SabxvD/J187B9PYMwXv30ZjzjUdZahUlPeWAhcPLwTbgn6h0J//q/yyH5/2G7GFAPFW
         J/ydx8pD20XAALpgzPfrhQiaxpyIOoe/Wezhd56uNmyfwabhafljVZvpAb01296S9/Ii
         cJCCcebykYceus5dkuP3tdihaH3KjQmUDX6OcMCphjbZNxXEyhOdbITPNIBCFfJ7I9Fd
         5jbnwRGWbU/c974s5xTpoyXkUETRa3WCXmg4FRuav/OBUO18EWUKSEx6byUG+2ytzQSh
         HL7A==
X-Forwarded-Encrypted: i=1; AJvYcCUYsgpFEdgxF+iKXzZE4b4y/4O5gzRUbwfFQK19kmn+JC1FxipeCaxVwGFHwEjAcbcawU0nqRmbKpm8IyZf3FA5RX1DgNoaLW+NohwG4/o=
X-Gm-Message-State: AOJu0Yz4lRx5hLoGcyLvFYeWXtnaoaSjkGuZEAmqAAYuMeHS7Xf3h8JM
	7exa6eBD7gJW44U3f6WeAmUSJUV9/7f9pqu7HCucKYx2khYxFCfg
X-Google-Smtp-Source: AGHT+IGdo7WdSn7uiTyrlyHt2sqja0G+7Zbm23lHxjfFi1wsrQsC4k2QcR2AqvEHWLQDICbuhjAirQ==
X-Received: by 2002:a05:600c:138d:b0:41b:fdf9:98b5 with SMTP id u13-20020a05600c138d00b0041bfdf998b5mr1507047wmf.4.1714559256137;
        Wed, 01 May 2024 03:27:36 -0700 (PDT)
Received: from [10.50.4.180] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id v17-20020a05600c471100b0041abdaf8c6asm1755829wmo.13.2024.05.01.03.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 03:27:35 -0700 (PDT)
Message-ID: <8f7fae86-414a-455c-8e5d-332c3c78cc60@grimberg.me>
Date: Wed, 1 May 2024 13:27:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] nvme: do not retry authentication failures
To: Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240430131928.29766-1-dwagner@suse.de>
 <20240430131928.29766-6-dwagner@suse.de>
Content-Language: he-IL, en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20240430131928.29766-6-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240501_032739_438379_1CE169DC 
X-CRM114-Status: UNSURE (   9.72  )
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



On 30/04/2024 16:19, Daniel Wagner wrote:
> When the key is invalid there is no point in retrying. Because the auth
> code returns kernel error codes only, we can't test on the DNR bit.

I still think that this patch has issues in the sense that in certain cases
the controller can suddenly disappear.

