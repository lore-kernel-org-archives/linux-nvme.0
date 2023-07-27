Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6ECC001E0
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jul 2023 15:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F0vvwsh2rxMF2ShvbYgqpo5URMyKXI0NTlXbCxD/+r0=; b=NthcGDbOzTMLPphowOnQt9QoFy
	6UoFB88K6wKKIuLY3lhbC7oNTlkGpdnvgqdm6rI7o7ZHuRrfFDgX5wHPIcb6jtCCl0hfU14DRApn/
	Aer6jFEPlemlpYOtNVfMYw0hzT6fs3rzNRmOggS144E5FZI0TWWPKblapjqJuI6DUqkMyTu2nZaTi
	YU5zEMrS7YHPC/CMMfEA3VlaeylQ+lOkspyhQIUmrUxf+kFQc1PavigaI6dVeKZrSU48u2/+u5vrB
	IH53cw7kLIcktSZHbNw5Wgq6I1G72WOEBGGhFniNrSGkmGWWSavHdWem9Vuu0+JoI/0c+cBswKP2U
	Z2oBhXhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qP2lb-00FmV0-2i;
	Thu, 27 Jul 2023 15:19:03 +0000
Received: from mail-pl1-f182.google.com ([209.85.214.182])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qP2lM-00Fm9Z-0q
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jul 2023 15:18:49 +0000
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1b8c81e36c0so6814165ad.0
        for <linux-nvme@lists.infradead.org>; Thu, 27 Jul 2023 08:18:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690471124; x=1691075924;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0vvwsh2rxMF2ShvbYgqpo5URMyKXI0NTlXbCxD/+r0=;
        b=Q/zNJIm7IFTtZAuZnKtjiiKrLGCqcC4VZZCDoXRUeso0zbnL9cikomuNMWmDK59odT
         360Tw91tKBdibadxL9/4lanabnv+pO3a93rgdJ++DCOdtteYA6Wm93i/2v+TnoH+bbYc
         MDMT1Fx0o49DCPgzdZNfViqy+tDpPsGk5bKG4Fe/uFKHJl3GWE0oIGb2edLTjqvSPTmj
         sOgMQm2EPcXILRqj57LzDqdQq9ciy29V3jrGAh8de484kd4HNRLMbugHCpDm7/lIYywI
         7UtqZrFtbJFnWPeYM0kzulub7Nlm6K7ZJJAOnlcZDDUmWFsFJ/SFTGFt/+NBu3pJDSMD
         i9Ww==
X-Gm-Message-State: ABy/qLZnv+A4VF8WKwySfX/ApqeJIsqLxxYzPw7jZEu5kmcmPG7jFvJG
	Z9CE9Th/Zwkx4D3xv71/wwQ=
X-Google-Smtp-Source: APBJJlG+bh/RGLvfVKFEqRfijkNNCjs6JeTHl2tGDJdRVSJtDHktXPCXP8zZXKWwmTtRjnw0V8qL1Q==
X-Received: by 2002:a17:902:e550:b0:1b5:5a5f:369b with SMTP id n16-20020a170902e55000b001b55a5f369bmr5439261plf.65.1690471124010;
        Thu, 27 Jul 2023 08:18:44 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:32d2:d535:b137:7ba3? ([2620:15c:211:201:32d2:d535:b137:7ba3])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902ceca00b001b872695c1csm1748294plg.256.2023.07.27.08.18.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 08:18:43 -0700 (PDT)
Message-ID: <c3bff0d9-957a-fbb7-a433-4cab457c62bf@acm.org>
Date: Thu, 27 Jul 2023 08:18:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests v1 01/11] nvme/{003,004,005,013,046,049}: Group
 all variables declarations
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Hannes Reinecke <hare@suse.de>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <jsmart2021@gmail.com>
References: <20230726124644.12619-1-dwagner@suse.de>
 <20230726124644.12619-2-dwagner@suse.de>
 <7e4f6c51-43f4-c039-07bc-6724748a1d3e@acm.org>
 <kya2ayzcgz7iemknkx6xuef4m37f2ms7rt3uxamtxr2w7zbwfc@onladguxa7bk>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <kya2ayzcgz7iemknkx6xuef4m37f2ms7rt3uxamtxr2w7zbwfc@onladguxa7bk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230727_081848_308425_06D58466 
X-CRM114-Status: GOOD (  11.48  )
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

On 7/27/23 00:11, Daniel Wagner wrote:
> On Wed, Jul 26, 2023 at 07:54:24AM -0700, Bart Van Assche wrote:
>> On 7/26/23 05:46, Daniel Wagner wrote:
>>> Group all variable declarations together at the beginning of the
>>> function.
>>
>> An explanation of why this change has been proposed is missing from the
>> patch description.
> 
> Sure, I'll add one. The coding style to declare all local variables at the
> beginning of the function.

Isn't declaring local variables just before their first use a better style?

Thanks,

Bart.


