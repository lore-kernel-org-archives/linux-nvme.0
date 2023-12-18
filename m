Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACA8C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 11:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WD0ik0Mfzsmo5R+mcKvrdsKmsWk18xrwCPzAUFUjx6w=; b=PsLe3KcCv01qN1PVlUYK3w05WS
	/Sa8S+Oh3MhBhbg7O4qrhfFOAQRPbiY1/miMxrXefRGbhwBcM/6WZDYuTT1phoyySaHAR+mFCN7ZO
	iLyRkcIiXU1ZHVJ8NDRiF0gb/4TM6pbRdsgQqgHH0esvNZd8/bydJYI7dkS6vIkliCSLTXu8/MCH+
	DG7nKSxt6V8gvZWeQC+RWmfiEuLYhM+HqpEpBEEr8bv7UTgmrsc0jJT2EtLRxDJOVKJ8BEynmIfNp
	arb+Ew/6UKLyvk9PgnBwBQYd4vA1iYLQD9pX32iZ6JltypFdAxIRR462cBOQZUSBnaFwwbPWZZsYK
	HcY8FfiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFCAs-00AOBI-2U;
	Mon, 18 Dec 2023 11:52:42 +0000
Received: from mail-ed1-f42.google.com ([209.85.208.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFCAq-00AO6g-0t
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 11:52:41 +0000
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55378cdd5ddso49417a12.0
        for <linux-nvme@lists.infradead.org>; Mon, 18 Dec 2023 03:52:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702900355; x=1703505155;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WD0ik0Mfzsmo5R+mcKvrdsKmsWk18xrwCPzAUFUjx6w=;
        b=EYW40q0FWNaHF4nKzpj9qch1ogTmC0uKgKPVxMZMlr1GIuhF53H6uGV4nNDMouam80
         8wplmj8bb9VSdWPyVCTCNeYURB5s/We5HY9/9uZ1VhkHXcy0/Q366SIKt4elAsvaamhB
         lTuqqvhR0DAwnhVoLeA3skaKfy0hxS5sAZMxx5bijEPW+x6zvesOUkEo/C8x0/PtXgSv
         hXJcNZBgXNC/itF6jXGD0zwk4wyQUi4PsUzdn4H3uBHqQNaoWFVy9Kv7XmXltYf35N/W
         3xFghl0x3dQObWpBN+bc9aX8wYDxGW6i8LuAYa+w/Dl7mkRlR1Vb1AW+uwkpG52ujSdS
         r85Q==
X-Gm-Message-State: AOJu0YwC3AAAEHwSsX6lLGE2ue590j6LBT9n96gtcG4OKX/6Vovu/Nz/
	nQsWkJI37QeIxGZTiMEKVyQZ1ujKYFA=
X-Google-Smtp-Source: AGHT+IEx0a11ULF4QKtTan/MVUQvMkpOBKjF4Iy1HOhAZ2RTCxs1CHVN8g6JT7MXEY+ejBJ4kXAdGw==
X-Received: by 2002:a50:c189:0:b0:54c:6fc0:483a with SMTP id m9-20020a50c189000000b0054c6fc0483amr17222894edf.2.1702900354820;
        Mon, 18 Dec 2023 03:52:34 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id bo14-20020a0564020b2e00b00553543c936fsm765735edb.32.2023.12.18.03.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 03:52:34 -0800 (PST)
Message-ID: <12a77956-ec86-4774-afe0-29e22e446870@grimberg.me>
Date: Mon, 18 Dec 2023 13:52:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] nvmet: change get_max_queue_size param to
 nvmet_sq
Content-Language: en-US
To: Guixin Liu <kanie@linux.alibaba.com>, hch@lst.de, kch@nvidia.com,
 axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
References: <1702897533-49685-1-git-send-email-kanie@linux.alibaba.com>
 <1702897533-49685-2-git-send-email-kanie@linux.alibaba.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <1702897533-49685-2-git-send-email-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_035240_331009_94C3A620 
X-CRM114-Status: UNSURE (   6.04  )
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



On 12/18/23 13:05, Guixin Liu wrote:
> The max queue size is an atrribute private to each transport,
> use nvmet_sq to let transport get it's own private queue and
> port.

Don't see a reason for doing this. ctrl does not span transports.
Why can't you just take this limit from ctrl->port?

