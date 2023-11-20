Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B6DAC54E76
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4RJyGgnp6NBCl9J/WIHKzo6XEq2Go5nbnAJnrLmQenc=; b=ZZmAzAetVuoyJK31Ebk/rse+ng
	abFph3I1HizNLlpXjsG8P5I9NWGXd95/d6gzf0Kva9PW8zfvUoJsFzTPU69mP5iSNdHJ0pUVpcNIQ
	W6IlNzYALDeQnLyVcpxigIcDc/O3laeQT2ELY8rdeUv71E6OXNDGAyzi9/1XT/asWiab6379nNNuK
	qUJXi5UueE8iW2w4I+CaViLp4CwKot9cYvrvNIRcGCyuEKzwR1qWEC72m0CyttpCrqRC41odzb249
	vs8qOMqNv7mVJqwYQEyf4NWEFQ2BF3CEZjXyc/ZO3TRWfkT2cKgyNuqAdKa+ZkaL/nVeXsdWYoS4D
	dQywK7Ng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r54jP-00CCo9-1t;
	Mon, 20 Nov 2023 13:54:32 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r54ix-00CCg8-0K
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 13:54:28 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40a279663a2so11161175e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 05:54:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700488440; x=1701093240;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4RJyGgnp6NBCl9J/WIHKzo6XEq2Go5nbnAJnrLmQenc=;
        b=s7Yrp5FZoIdabrJMS8W0ee9nk/ONZ3s/4HAJJzOr+KNft/Va+qbQlju4xEGadukUk7
         4ywwCruVPaGJjAhVWlRZmDtYgf864Z0dm1cTphEEsXNpw8q+fWB6TktiB4YQnQ60gDVS
         s4fKHGadD6EXhIsrYLTLwKNxqxglz/5eMF7rjWtJI8eIouQtbvwQf3N5mPmDfxjFkNo+
         CsosvWETdTidZiDmuFPJ35Sz1yu6Za3lK78CvpkVLzMIUyfK8g3cRShBAxCkLo4lygl9
         +ml8TVCVtMOkvS+KdBRQ3gHdDek76dOnaDg7ha8OR+bpia0NKDyVejSJN8nBEBXliGbk
         Yxqw==
X-Gm-Message-State: AOJu0YwZJ7JAC4mlOUqjtuLHQpVjOzpxFpSGYMh+P/3Zdq4S5758cM8s
	8TZIuEMQVfh37IA+9pPlKL6GxxH2aQQ=
X-Google-Smtp-Source: AGHT+IHm4HD+QsmTaVK8Y/2gGcf7lQheqtcD93BhoEgaNN/lHISW/LmbQf+s28p7eIx4je/7AfKFjw==
X-Received: by 2002:a05:600c:4f45:b0:406:513d:738f with SMTP id m5-20020a05600c4f4500b00406513d738fmr6923424wmq.2.1700488440490;
        Mon, 20 Nov 2023 05:54:00 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id z18-20020a5d4c92000000b00331424a1266sm11249805wrs.84.2023.11.20.05.53.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 05:54:00 -0800 (PST)
Message-ID: <0e19bd16-a544-457e-aecd-70b7ff6433cc@grimberg.me>
Date: Mon, 20 Nov 2023 15:53:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme: ensure reset state check ordering
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>,
 Minh Hoang <mh2022@meta.com>
References: <20231027180752.2527653-1-kbusch@meta.com>
 <20231030132738.GB21741@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231030132738.GB21741@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_055403_186215_E1F8CD81 
X-CRM114-Status: UNSURE (   9.02  )
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


>> From: Keith Busch <kbusch@kernel.org>
>>
>> A different CPU may be setting the ctrl->state value while flushing the
>> reset work, so ensure proper barriers to prevent reading a stale state.
>> Reading the wrong state can report unexpected ENETRESET errors when
>> everything was successful.
> 
> smp_load_acquire needs to be paired with a smp_store_release.
> 
> We should either always hold the lock or use WRITE_ONCE/READ_ONCE

which lock?

