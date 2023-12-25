Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F6AC3DA6E
	for <linux-nvme@archiver.kernel.org>; Mon, 25 Dec 2023 10:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fXSJXZOiPuspplkzkrordZXr53ZHravyg/EWps5Ddu0=; b=uOC6By9V0h88mSqEL8JRj4LFlE
	vlZkKuEXPO6fsKsQGWrRUtcL19Qxb4ffh3VQLxrcImeQFpVXmg6jq1yfE4ACqVMpKAZIFJOs/t3uM
	P67dTG/QBMsqJ5efSaaOIvQlWuriGqfbXkTbx7p6p6WTOafwcJHhn5QNBkKEWd7gnuTY9reKIquVl
	gqc8AKegDkGrBxD2lAPhsSUyetMWppmQIaOjhmckadpTbGcQDZgYBUTTPvRFGel4rus3u/7FVd+qE
	Ms7sNsMGFuin9s9LpzdfDTasHwC10rcUtPZYf40U1FCW3R8qui4P7yziIlm7g3xYJchp4lG4GYHoV
	Vkv5oL2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rHiCB-00AXYN-2T;
	Mon, 25 Dec 2023 10:28:27 +0000
Received: from mail-wr1-f54.google.com ([209.85.221.54])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rHiC8-00AXXI-1d
	for linux-nvme@lists.infradead.org;
	Mon, 25 Dec 2023 10:28:25 +0000
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33678b10a6eso663048f8f.0
        for <linux-nvme@lists.infradead.org>; Mon, 25 Dec 2023 02:28:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703500098; x=1704104898;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fXSJXZOiPuspplkzkrordZXr53ZHravyg/EWps5Ddu0=;
        b=nQVUNQR5Ds8PUv5r2L66nMUv1S/KDVg/f0f/GI1jCf9uKa4WwHgDVwjGTuR8hJ2SO0
         h6JCCEEy6EdcCfglzcjle3CF1n4HJWR1hvqGCLloNbwX/VVr3LqcgccjbPBMIpDyA8AX
         mybVPbvaC8YeCFr3oJPBAM10+IgUEInGCs4gfXACjxUZ6eYqM0O5H1+vab1CnGEj/1bC
         TE0Ewh7PuMJceI9u0uleqHLFwYNfAKFg2R03pSHAZUdTM7ypxsB5V8qswZkGOOcBKn/F
         lljnjf1hy6OmTLL/XHisUDvuWeLnqGjGdpnpro0Rbxf6zARnFlHnNJ0sdQiZQPRMpRZX
         UBxg==
X-Gm-Message-State: AOJu0YxKG58e2QQTAFC5GywaclZFqJnjHcMPQnBXn4j0lIOOKi7NYoZ6
	uX31lDf+XQuCdK9ip8QdO3w=
X-Google-Smtp-Source: AGHT+IGQUer9HlHqpsGAeSWflbDvfcvZLM3K5Uk3H4C+OIA7zQLGj1vZHyTRxuviWGBCDwl3wfSB0Q==
X-Received: by 2002:a05:600c:b87:b0:40c:24d6:40a0 with SMTP id fl7-20020a05600c0b8700b0040c24d640a0mr7557536wmb.3.1703500097717;
        Mon, 25 Dec 2023 02:28:17 -0800 (PST)
Received: from [192.168.64.172] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b0040d4f95dcc7sm8569275wmq.8.2023.12.25.02.28.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 02:28:17 -0800 (PST)
Message-ID: <a2274654-bc7e-4a8c-a7f0-33da8a2147c7@grimberg.me>
Date: Mon, 25 Dec 2023 12:28:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/3] nvmet-tcp: fix a crash in nvmet_req_complete()
Content-Language: en-US
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: zahavi.alon@gmail.com, hch@lst.de, chaitanyak@nvidia.com,
 linux-nvme@lists.infradead.org, kbusch@kernel.org
References: <20231222151750.655751-1-mlombard@redhat.com>
 <20231222151750.655751-3-mlombard@redhat.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231222151750.655751-3-mlombard@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231225_022824_547196_250BC58C 
X-CRM114-Status: GOOD (  13.46  )
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


> in nvmet_tcp_handle_h2c_data_pdu(), if the host sends a data_offset
> different from rbytes_done, the driver ends up calling nvmet_req_complete()
> passing a status error.
> The problem is that at this point cmd->req is not yet initialized,
> the kernel will crash after dereferencing a NULL pointer.
> 
> Fix the bug by replacing the call to nvmet_req_complete() with
> nvmet_tcp_fatal_error().

This is indeed a bug. However nvmet attempts to gracefully fail
a particular nvme command when there is a recoverable error (see
nvmet_tcp_handle_req_failure).

In the case where the length is arbitrarily long, then it really
doesn't make sense for nvmet to just accept it and throw it away,
but if this is an offset error, maybe it is...

I'm not hard set on this, but it would be beneficial to have
allow some graceful cmd failure here... Perhaps you can share
more about what was causing this error?

