Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A232EC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 22:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=QmotokHL53lfiADf6pSwMymKqX
	xs6FI/IBnGtav+LWRD8pnBWxvb7Z0cGHkyw5GbuedynB6hjJX1/ymA8H4x4TjnYnu43DnNgJ4hej9
	fFNRwVaegK0EvJQFkXRhL6WHiwj0GE4k7VSMTDx8xKa5l6R+j6UFrMges8johUw0TX2jUBj48LYl9
	PayoP+R61U6lBkPQrs5M95VvN7DMsa+QYAlC2luGasbNV3QtBpSOvUOM9WX8qyzVd8YMd4sJHy+Wh
	kYegw85yV0P1R3v+vnPS6OrsMZDZaUpaDL5gE/oBLdOd5MKB8zPPwHeFaU3kuQ+GDQZL5/Ic6Owy3
	+03/gXfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeZ3-00Co3S-0y; Thu, 21 Jul 2022 22:22:37 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEeYz-00Co10-7X
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 22:22:34 +0000
Received: by mail-wm1-f52.google.com with SMTP id p26-20020a1c545a000000b003a2fb7c1274so4157357wmi.1
        for <linux-nvme@lists.infradead.org>; Thu, 21 Jul 2022 15:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=CWlVMeJFfmcNasy2mSXIPMRCjgZY7qbBe3rxRPgI9tzepSkZcbYocUARmzvTRRccLC
         9V8ugLq/aaNZRRaRPtqk5KaawFDOzZCxllOm4qdGsYvH4/76VdhufiEuJLYkAbnUP4xx
         IJBCQc59csh0m6S5io5kCgoep80hVJCQUci0EKZyAUOejGQYq+taA0M5VWS6ujxkdeqK
         0XprHdE/Z1j1hvhwgJXrsNHWdqm7HouNYHyZ4fATTMgQSJQmIx4xqDQu7bqOh3j6QWE2
         DHNQzSKbTi/8cfp7YnYnyK0BS6FEklqnc35X48VLjctqX6YG8OoXEEsVs9RNFbm7Jl+l
         BSDg==
X-Gm-Message-State: AJIora8dSIA/deA0BhSvfFU9tWF3QIpg36d9bHQZGzEJhXy/RIXgK0lw
	Ao6mF9D59xw8coa2xELPu8xqfnkyFOw=
X-Google-Smtp-Source: AGRyM1tbcnnG6S22URh8nCVUz6meEFNoU+cUKnDC2tHyd9Z3Cb3M59livNDuWIc6NXaI6DN41QXXdw==
X-Received: by 2002:a05:600c:1d1b:b0:3a3:e2:42d1 with SMTP id l27-20020a05600c1d1b00b003a300e242d1mr170709wms.137.1658442151864;
        Thu, 21 Jul 2022 15:22:31 -0700 (PDT)
Received: from [10.100.102.14] (46-117-125-14.bb.netvision.net.il. [46.117.125.14])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm13304965wms.3.2022.07.21.15.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 15:22:31 -0700 (PDT)
Message-ID: <bc8522a9-c159-9641-ffa1-0107092caaa4@grimberg.me>
Date: Fri, 22 Jul 2022 01:22:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvme: consider also host_iface when checking ip options
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
References: <20220721174414.28294-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220721174414.28294-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_152233_281345_47CC60B0 
X-CRM114-Status: UNSURE (   5.26  )
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

