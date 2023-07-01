Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 303E8EB64DC
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Jul 2023 12:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f1GyuonBm6IUr0u+r5GEAQVpS0cfgB5k80PSwBGFToY=; b=EU6nOCGABFbRkpozxO0b2WPv8A
	+8SZ7xcIFCz9G4gzidC0PR26iRhBESd055za4t1MziIjcwrt8khuLgfr6B/qFVlTbdioGBhhR7fds
	TcURbM9+OaJOqEqOVZIVMX0jFnXzg+9zNmTT+t1rMLre0Qwu8p/U0BSedaXvVr2SdMHXvj2GbRpBk
	/JPUenBsA/ms2P+7PKYhjucRUtx54FYWiYpnW2xQpU0f3tX+aW/z2I1Fpk2r3uaTRk36GJ4YJTTb+
	hZolVwVflbYPUAsNOWx1+in+mOv4+5DbzqEmkFyGv81w2qLMNfI/LWIhqtkA6nQAk5U7I0BYbFIAy
	ueYG7KeA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFZkQ-005yO8-0P;
	Sat, 01 Jul 2023 12:30:42 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFZRb-005qlP-03
	for linux-nvme@lists.infradead.org;
	Sat, 01 Jul 2023 12:11:16 +0000
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6687446eaccso2201806b3a.3
        for <linux-nvme@lists.infradead.org>; Sat, 01 Jul 2023 05:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688213473; x=1690805473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f1GyuonBm6IUr0u+r5GEAQVpS0cfgB5k80PSwBGFToY=;
        b=KfCNmTFBwiLTda6Dm+DznJq70IhnOvAFC/zYQHCxe3keuHYR4JHjK5JzgH4OkDx2yc
         hXpmbi/rlz80nZG5ufKcxKROcSkcMnBzEzjN+EDQtS3VlvdbOpRBAVlBpgBnv/BYemCc
         wwjnVDGWI4Qzw2yXTiy3Id8dcsfpr+15qamDPQ7CYGPm1bGG6DTkZaT/j87fsezktniz
         A78OIPMEG9uotIa/b1AmRA/pcI9ZJVIL51/IaKmIWTytbxVRL9bH6W0wS5KPuWYcgZGT
         X1X0YWjCoQEJB5G7XGtcQV45Dis4/iB0Rtm+TH4X6Lu0/mQAT7RmcK72eszUsej+8JpZ
         COiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688213473; x=1690805473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f1GyuonBm6IUr0u+r5GEAQVpS0cfgB5k80PSwBGFToY=;
        b=L2qgYW0VmiqoYsAdFN7H1LUh4mK3S6xQvaHnrylWdsptKPyhqxElbLdEsAWGomiLbI
         2X2iY/4id0RBSjrkdoN7ulYHUjK4dkfzbdwy5Au8LQnaZDSbriFVJESIuPgfOgW4BqE6
         1ijfqekv2lHF/SdF5ZPh3JIdv9Stjd470ODXNh4riilb60FDQc4167YaGH3oNw+DfYSC
         dXPQYHjmpcgKmr1euKgTos+akIROV7mPfq0FYBPzXiAXw1YXHUp97Y/C2HDiy08oXpVN
         /JsJ0C7WW74XTlLWdosdxAnDyyNdEZWQHWdNvLz9psyQgwSBgtXqx74QFvcPUuMWr4k9
         Cbmw==
X-Gm-Message-State: ABy/qLYN4FLqABanEqKiCQ0lO4X/JqCqr7uXov7lAAh3/+ZeUAhsuwId
	PtWQbfj9u+ACXXN1VL2ZFHU=
X-Google-Smtp-Source: APBJJlFta5cKHhIgxiLxamDAB/Qw2W5giLxoywNe8po2TJMX0I3gw3Sfh3ev9H6ouhWZEi/AI96i4g==
X-Received: by 2002:a05:6a00:14cc:b0:66f:912b:d6f with SMTP id w12-20020a056a0014cc00b0066f912b0d6fmr7785028pfu.0.1688213473510;
        Sat, 01 Jul 2023 05:11:13 -0700 (PDT)
Received: from [192.168.50.210] (ip68-109-79-27.oc.oc.cox.net. [68.109.79.27])
        by smtp.gmail.com with ESMTPSA id i22-20020aa78b56000000b006687198c3easm11781138pfd.179.2023.07.01.05.11.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 05:11:13 -0700 (PDT)
Message-ID: <594f73f2-59b0-bbcb-d7a0-6d89e2446830@gmail.com>
Date: Sat, 1 Jul 2023 05:11:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 4/5] nvme-fc: Make initial connect attempt synchronous
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 James Smart <jsmart2021@gmail.com>
References: <20230620133711.22840-1-dwagner@suse.de>
 <20230620133711.22840-5-dwagner@suse.de>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <20230620133711.22840-5-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230701_051115_056732_3771F799 
X-CRM114-Status: GOOD (  15.43  )
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


On 6/20/2023 6:37 AM, Daniel Wagner wrote:
> Commit 4c984154efa1 ("nvme-fc: change controllers first connect to use
> reconnect path") made the connection attempt asynchronous in order to
> make the connection attempt from autoconnect/boot via udev/systemd up
> case a bit more reliable.
> 
> Unfortunately, one side effect of this is that any wrong parameters
> provided from userspace will not be directly reported as invalid, e.g.
> auth keys.
> 
> So instead having the policy code inside the kernel it's better to
> address this in userspace, for example in nvme-cli or nvme-stas.
> 
> This aligns the fc transport with tcp and rdma.

As much as you want to make this change to make transports "similar", I 
am dead set against it unless you are completing a long qualification of 
the change on real FC hardware and FC-NVME devices. There is probably 
1.5 yrs of testing of different race conditions that drove this change. 
You cannot declare success from a simplistic toy tool such as fcloop for 
validation.

The original issues exist, probably have even morphed given the time 
from the original change, and this will seriously disrupt the transport 
and any downstream releases.  So I have a very strong NACK on this change.

Yes - things such as the connect failure results are difficult to return 
back to nvme-cli. I have had many gripes about the nvme-cli's behavior 
over the years, especially on negative cases due to race conditions 
which required retries. It still fails this miserably.  The async 
reconnect path solved many of these issues for fc.

For the auth failure, how do we deal with things if auth fails over time 
as reconnects fail due to a credential changes ?  I would think 
commonality of this behavior drives part of the choice.

-- james

