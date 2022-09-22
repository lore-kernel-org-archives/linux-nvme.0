Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C22E3C54EE9
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 15:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=usHFUIdejxHZ/jrI4dpClpQ7etJMQK8Sg+bc7Ez6W1A=; b=1VMkguK4Sq7rJIGhGXxsCXFCqD
	eS7Sx6Ge8iu+O/FcTd8PzQTQVbIDJdxltM98gGyia57cBY3GjpvrfwDbAbZ3YG7hiRgcqw8J8FtIE
	o0zyPqMx87pBJCRUflqodvxOF75QBPOpFW24ixs/ZIPjXm2FhVvzChAMguMwZ/cjZg7vtx4gEiYCU
	8fWrT0Xua8LIbDcoqC9ubXF97+AlDw2ERRfIBFd3UIzZLoz5mNdyAUxOfXTbN96UHhoUScsFr+0aw
	C61rNII4fop+PjrBJ31J/hV6W7yrItYMWQ7jHLkCxRoZa0ca5Sfqte4Ndwhfy09hYE7muJiY4BbuY
	YA1tMF+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obNuz-00GM07-OS; Thu, 22 Sep 2022 15:15:13 +0000
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obNmf-00GHuB-BY
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 15:06:38 +0000
Received: by mail-pj1-x102b.google.com with SMTP id g1-20020a17090a708100b00203c1c66ae3so2446925pjk.2
        for <linux-nvme@lists.infradead.org>; Thu, 22 Sep 2022 08:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=usHFUIdejxHZ/jrI4dpClpQ7etJMQK8Sg+bc7Ez6W1A=;
        b=CaIxk7g+BAe/zdu8/3LocWC7RkSwJlqCcgicmapfok9GoXJFOv8z2ce0bVCxEJvRq5
         SzsTb6A+yWUSk5IrX/uRySGoxdafqCKytZXkYx8mxQeZd0aQCJBi894slrk8N3uPo+NN
         AM23XhA3fqO5XKVEps+FCzj+WJfoxrHlTINGiHXcrAieIwSGQFMVztAlKW767lJJL61w
         o45L+HT7iqsxypJDRlYBc+5MwtokukymYndLQTnrA9q4CDUn8GdfFu4uIJlbRv8UEoHh
         TYetT5xQ3dNYsFrmg1azrdqmsli1T4BJe2R6ji4LTmDFPPHOrsLzQGk5Jv36yXInWi7w
         fWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=usHFUIdejxHZ/jrI4dpClpQ7etJMQK8Sg+bc7Ez6W1A=;
        b=s8vkBIA+dYdtp+6VKe4ycsLNV7OsnyZTB5fweauMO64ZqvLOSMP7awb/0FjEGDDNzW
         OOwLbgqGcg2JK3cwdrwGFe/RHHVwBA20FqW1aO6uSZMEQ1dsfjSWNJQspwuoC69RfXKk
         QhRFbUKdNX71TDh59xRD4JKOiyuDpyvM6/n7F2YMB1tkxpc1mEfxRQLoVCuSFPSJZBtb
         /6G/ykvdPdnvf60jtAKKGDOxCuWbkaCMoIsM5Qfha7bKjTqFrOmwkVkfznIG+GQx6ZVU
         giSBG2IyKuZWM9CkLuak4uOva+yxhCW6oy0SKUGNeJUG8/lksXiqBT5aJqWNyegSO4SD
         KtSw==
X-Gm-Message-State: ACrzQf1/XXSQ0i+QU9CRXHfc+oLwfN64b+xrW7/H5/knzRfE9Pp86f9q
	IWBVhNRz2eFZOv6NosCBKKy+YCYJZSU=
X-Google-Smtp-Source: AMsMyM7RcDXaC5L0UWKh8WvWoAWzmd92tfeISUfYmvQMUunqADpakre4Sjta9hJ9STVnNd4jK3tjgA==
X-Received: by 2002:a17:90b:1b4d:b0:202:c05f:6ea0 with SMTP id nv13-20020a17090b1b4d00b00202c05f6ea0mr4257879pjb.7.1663859195744;
        Thu, 22 Sep 2022 08:06:35 -0700 (PDT)
Received: from [192.168.50.208] (ip98-164-255-77.oc.oc.cox.net. [98.164.255.77])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090332c200b0015e8d4eb26esm4183717plr.184.2022.09.22.08.06.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 08:06:35 -0700 (PDT)
Message-ID: <908ea61e-32a7-254c-9cd0-b322bafcc0fd@gmail.com>
Date: Thu, 22 Sep 2022 08:06:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v2 3/2 nvme-cli] fabrics: re-read the discovery log page
 when a discovery controller reconnected
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>,
 James Smart <james.smart@broadcom.com>
References: <20220922081538.13364-1-sagi@grimberg.me>
 <20220922081538.13364-4-sagi@grimberg.me>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20220922081538.13364-4-sagi@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_080637_451896_876BD735 
X-CRM114-Status: GOOD (  13.07  )
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
> When using persistent discovery controllers, if the discovery controller
> loses connectivity and manage to reconnect after a while, we need to
> retrieve again the discovery log page in order to learn about possible
> changes that may have occurred during this time as discovery log change
> events were lost.
> 
> Upon reception of a udev EVENT=rediscover we can kickstart discovery on
> the existing discovery controller device node that generated the event.
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
>   nvmf-autoconnect/udev-rules/70-nvmf-autoconnect.rules.in | 7 +++++++
>   1 file changed, 7 insertions(+)
> 

Reviewed-by: James Smart <jsmart2021@gmail.com>

-- james



