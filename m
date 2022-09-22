Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DDDC54EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 15:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NEnLVD5j9vobjfcDGWieKHQePfE9soF8vbvl6nRjUZ8=; b=W3YsMGXOGjSTqjK9b8nnRqvy7o
	7xJuTqrhcSqQ3xN+42lcstVRIIAsFeXOxoNkzBxu625N2eU28iShicRIBRXpPNAnFdPjY7zK8iKuZ
	4MroUeXNumE4Mju+juCehwp9O7mQTcsiO9FrGR011ObzKh80559x9KaZzdWUPRZ2p/mQeXOtYqVA2
	TDClzhbMi6YwhZRYPTLVFEtwReyHzV1guxokyAXMGYr+b7ov3y/CfDxgQG/0W6Z0wxkRniTSz5EDC
	Jo/4l+xj/DW0A9K7Le/t+5n9BZqlp/Cj4ooXyxv01Pi0LUPwxHkNW1tUs+PWKF5Xjv7xcDtYaYOKn
	xpZ+o8wQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obNu0-00GLZS-IM; Thu, 22 Sep 2022 15:14:12 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obNm4-00GHUH-1h
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 15:06:01 +0000
Received: by mail-pf1-x42f.google.com with SMTP id b23so9573554pfp.9
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 08:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NEnLVD5j9vobjfcDGWieKHQePfE9soF8vbvl6nRjUZ8=;
        b=VQKhpQuQPC0CNMZWf8mmgK9K1BDEnN+8tsu1vEQyrONgflvRNXtx/ayx8pEAD/mpRe
         reoBByd4zwCF6swUOU9Aq9XItBV/eJhnsH/PPGWnKY0yYkTRTdKnYnTaWedSRmoEXSlX
         9TXjI7GjoG3L1CVGF3RTITmZ3gJqFkqOx0Ch9C+xi7l1q846LIYy4F9KBBIHWvx25dVw
         SeFiQ2R0/yTJgFKbpZLD0EHjFT0910Y1/YHDXwBvp3U1011iNe/QQnCyhYRHJEY/dmzd
         Im4aGdiHgzeYSRCzElSNLHvJ7JQlwuCa3D41fG4oXEm2IcGbztNMOYRfBZBWifgdv8dy
         KV3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NEnLVD5j9vobjfcDGWieKHQePfE9soF8vbvl6nRjUZ8=;
        b=gWcVZ/VVhvLxYI3jvSSx1I8qJXeiFCh3NGMRgh6O3J1JRRZHoUaocNyGtJlXn/+5jN
         0oQiT6bvy8CcCmhIIyIpdAdyggPotAwO+uO5yEIuMYBhB78Vg2vX0qbpFkFTTaIRLWU5
         oPVD3Pg88/7GfQxMB37bKyDFTedaxVfhloJMjbcQequnDR0hzKnC8vnD2IWw2Bo5e5QS
         xZkPd7eNpwVpT7qLyUOEz3VO5qRxWeI7jzJPiafl2yHFjLAwtZQDsH++HXSajTgpXDhW
         zfTg8OjICZn2GpdH8G0/XZ1fpDAfH3L9lvMDNno3pwcCj6qIbj284D23xoPr/dHYEWED
         Fkug==
X-Gm-Message-State: ACrzQf08VcSloAg+cWYv5V5LSgqtLQYUZlgY3nwGwLnXnr6lzZkh6cF6
	MY7NWzlxnFM2k4p3OXHDKvqgRa5vlXs=
X-Google-Smtp-Source: AMsMyM5dTKTLg8sx2jKwNeGyRQfIyLd06kRmEymAYc5lKc2va54h+zkau1JJ2JOWzxLfILCttX0OJA==
X-Received: by 2002:aa7:8801:0:b0:555:46a9:b3db with SMTP id c1-20020aa78801000000b0055546a9b3dbmr2718912pfo.11.1663859158169;
        Thu, 22 Sep 2022 08:05:58 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id a14-20020a1709027e4e00b00176d0b44be2sm4202238pln.47.2022.09.22.08.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 08:05:56 -0700 (PDT)
Message-ID: <48f3586e-5a63-6dbe-db5f-e885e72781dd@gmail.com>
Date: Thu, 22 Sep 2022 08:05:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 2/2] nvme: send a rediscover uevent when a persistent
 discovery controller reconnects
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 James Smart <james.smart@broadcom.com>
References: <20220922081538.13364-1-sagi@grimberg.me>
 <20220922081538.13364-3-sagi@grimberg.me>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220922081538.13364-3-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_080600_159738_F653FF99 
X-CRM114-Status: GOOD (  15.55  )
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

On 9/22/2022 1:15 AM, Sagi Grimberg wrote:
> When a discovery controller is disconnected, no AENs will arrive to
> notify the host about discovery log change events.
> 
> In order to solve this, send a uevent notification when a
> persistent discovery controller reconnects. We add a new ctrl
> flag NVME_CTRL_STARTED_ONCE that will be set on the first
> start, and consecutive calls will find it set, and send the
> event to userspace if the controller is a discovery controller.
> 
> Upon the event reception, userspace will re-read the discovery
> log page and will act upon changes as it sees fit.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   drivers/nvme/host/core.c | 10 ++++++++++
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c


Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james



