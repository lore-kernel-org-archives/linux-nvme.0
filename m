Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DBAAC7EE23
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jun 2023 22:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vgGJ5Lk0BOPwMuA88tmJP2sjwCG8WTUAfO/6KG0I7FI=; b=wrZU18zMuliYlNfMn4a4GtIJji
	wSGVcBQKAfPjXVMalzgGaKpGo5nd5WHvrT/WCcjFWCtFRk1mG0uowQN0gMGD5JbilTG5YYa8gQGzI
	1UJ6VDLpuSLrDVOk604bi58un5qb5dEG6yqRaxMXBFp7LQBwFtH2+X3peN9NQhp/9x3HcKeDcwekL
	u9yJaqVDu3bMG2/KbEFojbyuUw1g/elRQkUbofhL3xfep5PMvr45/QqPGX/+J/53WXR1ynBNwziJX
	X+lIsSp3xV7uxAGSB3bZMOxK8H7/VVVPNAesBJButuoCDN4O7FqWVvadFs2MEOhiyGoaAY5N2pfsJ
	4pJ/Aa5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Isj-00H2RE-38;
	Mon, 05 Jun 2023 22:40:57 +0000
Received: from mail-lf1-f44.google.com ([209.85.167.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q6Isg-00H2QY-27
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jun 2023 22:40:55 +0000
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4f61307827cso651148e87.1
        for <linux-nvme@lists.infradead.org>; Mon, 05 Jun 2023 15:40:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686004853; x=1688596853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vgGJ5Lk0BOPwMuA88tmJP2sjwCG8WTUAfO/6KG0I7FI=;
        b=S1PE1DPqs50G+eej523Fc1D8FMYa/65nd7RRaivPVRQobtjT7wlVvC2LVYkOKdR6bZ
         ePCMUqUx4b5JI/EK08wO/IAmK2Jzo/woQVv/5k2zzc9/A1a3hk5WTLTbkIWzYIQA+Dkm
         JmT0X1krhozTwYCDekR68167BAhRZsVuxYGAG35Nx7eMnxrLrtb0K/UQkTg+a9ZUVKvV
         BfFzBdRW2vVH9opDxYtrrliHq3GqRKIb4cbjmVLmCCytJebHc5hmKpFfH4+Sba/yeWMJ
         YFjDyVipSCXmz45CJsasYa+GMXyhmCFAsthcMCIK+G9lNaOWgMqdIk80NMLDBOjWNrvs
         fw3w==
X-Gm-Message-State: AC+VfDweITsma8bM6ItWZLMzHGlTrrNP2VPAvgBGdXm4nMTF1GES7eSq
	5knMPJrNV62yv1i1u2DO1gI=
X-Google-Smtp-Source: ACHHUZ6mrvDrwir4Mi3Rz0vwF502QhCr0cxpOk23/4DAy4CMOfXOSssVYegGW0GIagu2rD87iH5ffQ==
X-Received: by 2002:a2e:b4af:0:b0:2b1:b741:7500 with SMTP id q15-20020a2eb4af000000b002b1b7417500mr257043ljm.1.1686004853011;
        Mon, 05 Jun 2023 15:40:53 -0700 (PDT)
Received: from [10.100.102.14] (46-117-190-200.bb.netvision.net.il. [46.117.190.200])
        by smtp.gmail.com with ESMTPSA id u5-20020a2e91c5000000b002add1f4a92asm1626530ljg.113.2023.06.05.15.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 15:40:52 -0700 (PDT)
Message-ID: <990fbacd-b5d8-768d-b67a-56879eacfbe4@grimberg.me>
Date: Tue, 6 Jun 2023 01:40:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] nvme-fabrics: error out to unlock the mutex
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de,
 kernel test robot <lkp@intel.com>, Julia Lawall <julia.lawall@inria.fr>
References: <20230602053713.43006-1-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230602053713.43006-1-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230605_154054_717702_ED32ADA3 
X-CRM114-Status: GOOD (  11.90  )
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


> Currently, in the nvmf_host_add() function, if the nvmf_host_alloc()
> call failed to allocate memory for the host, the code would directly
> return -ENOMEM without unlocking the nvmf_hosts_mutex. This could
> lead to potential issues with mutex synchronization.
> 
> Fix that error handling mechanism by jumping to the out_unlock label
> when nvmf_host_alloc() fails. This ensures that the mutex is unlocked
> before returning the error code. The updated code enhances avoids
> possible deadlocks.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@inria.fr>
> Closes: https://lore.kernel.org/r/202306020909.MTUEBeIa-lkp@intel.com/
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Can add:
Fixes: f0cebf82004d ("nvme-fabrics: prevent overriding of existing host")

otherwise:
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

