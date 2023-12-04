Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15EE4C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Dec 2023 08:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=KaA0uRIGh0e3/Z7K4JPoA9NcE8
	4x8Wvor63M2kvgQmTl0jEE3UzQN5R9JQYmqpyRO1PI6p3M2+d1lrPdr/n088T+XVSDni2Kq4dZmVI
	3mNRv5roKZh3rrtfm1JP3m8vZUxtut+VlX+eWdcrqZu2KwacvmIeDdsBx/O6Gnus/OvL+huQ53bhc
	7nAKpLOJW7cIRcGovHy+pR2c88vXQh8CNUCnc/P6u4zCPhCe39x3oee5iCZJzZWRnhe3/AR3Hqcbj
	4pd4H64dGAZr/qO1Lam0Vw4uhRRGnQZtttMEOasxOtP0Y79pLNmI0chMSJQhG4xBUZkMo5u5Rf0/c
	dLyP0zlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rA4E6-003FvN-0o;
	Mon, 04 Dec 2023 08:22:50 +0000
Received: from mail-lf1-f54.google.com ([209.85.167.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rA4E3-003Fud-0S
	for linux-nvme@lists.infradead.org;
	Mon, 04 Dec 2023 08:22:48 +0000
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50bcbfe20e8so1141754e87.0
        for <linux-nvme@lists.infradead.org>; Mon, 04 Dec 2023 00:22:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701678164; x=1702282964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=SpSfhgYi84b5X3iY4L9bCUFSDRqpIXhBeutQD2GAOIvgzGhh4JvxSs6ogB3YKy2G+u
         AarBG4exHMp6UzpkVwVtjx9TRm67//mKtewBNa6yZ9dK7p1uXESTXqmzIH33/HP9gORF
         8wOjLjoiK1E8qlvbYYAAzJPc0MZ6GTJPHJ87jfqPeLkIVPjZDumzPkM7uEi0fpZPUg6f
         dqdw1EztyB/rorCLaKoJ+9oVs5UGGydP+x3aWXAKrY3KUlNuTRnXPt+eNKqiu0e+3wV+
         Cp9OjQng7DE8/jfvRnlV0nDFz2nrlMs5jqS+qGJlC6ELR6v7Tsi3MzLrkdUdDLhPnyqA
         jMHA==
X-Gm-Message-State: AOJu0Yy8lN2N9AM4b0yi89Vh1/4dRwP+UoqmRiYrbiMaatIxQbuX/JBs
	WoEXW8aex43Me7BA0UbMbro=
X-Google-Smtp-Source: AGHT+IHxDd0ao8p0wdyFfBo4MSgyEr9NQ8x15Y/XfoAMR3lRcVkPVaeiHi+SqVdIO2sqP0JJcj/OeA==
X-Received: by 2002:a05:6512:3e25:b0:50b:cab3:1102 with SMTP id i37-20020a0565123e2500b0050bcab31102mr7816304lfv.6.1701678164058;
        Mon, 04 Dec 2023 00:22:44 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id fa23-20020a05600c519700b003fee6e170f9sm14028002wmb.45.2023.12.04.00.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 00:22:43 -0800 (PST)
Message-ID: <32794051-0264-48a6-b0d6-2c14039f92c7@grimberg.me>
Date: Mon, 4 Dec 2023 10:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: improve NVME_HOST_AUTH and NVME_TARGET_AUTH config
 descriptions
Content-Language: en-US
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>
References: <20231129044951.610759-1-shinichiro.kawasaki@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231129044951.610759-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231204_002247_427534_89D7AEB6 
X-CRM114-Status: UNSURE (   4.57  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

