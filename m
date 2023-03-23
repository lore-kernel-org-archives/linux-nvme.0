Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC92C6FD1D
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 07:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=ERYn1/BgmLe+CTCjiNvwZ3kwxV
	kqLQF/DxdKQIKMCk8Q8108W6MjQa1RxrZxN8llLTqbmUlDd/CzvKA7MLdo8wVkwZxOGFi5CBHSvzM
	vmkfPf76hLv/Cr1NrtCuNTMf6+OORXH/GH0YStzF87ICnrEfXP39DFxMPEbDSIZblObtv66ujiRa8
	N9oJxLceZ6RNG34T8egn41gJ7DDjqyKZRcR4yTwSq2BgZZi2E4gEsagkjozq5ZVxEIVtFMpW3QcEp
	3v5m1q+2i0WQhaDNrosYXorTh5D+3MlmfDyCO33lVAfuMA8IDbowTdVQAlNvneBXqdqrVkDETLbVi
	FUezlitA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFou-001BWk-2O;
	Thu, 23 Mar 2023 07:57:12 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfFos-001BVp-1R
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 07:57:11 +0000
Received: by mail-wm1-f49.google.com with SMTP id bg16-20020a05600c3c9000b003eb34e21bdfso577335wmb.0
        for <linux-nvme@lists.infradead.org>; Thu, 23 Mar 2023 00:57:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679558228;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=GZC3W6v46PoCHWlM5v8ex2Iyq7Z14vObVRpUXPw/YoAiQkL+vODTMnv13kQcTCr1j3
         95hoAfOnt4MQE3lytaJ513ptwoJ6ZpOiSsGvFElS7h7CFbBnHQ/IDi/glrDfTZFqqT31
         0wftMt6MJiE3aggQS60++C8oGh9GbzGFDObVAuEPrkQelm4IHcvRgyWlYt2X8B+niQg2
         R6qSIFeMSEHqBKV3RePuozubeyyH4W6jva1DFsxKW5NW/ZOLTnzKOf2aHVWkcHYhiJKi
         znWaZI3fgG6Xw6KqK12aBaELIkgoqATykDId5c8eDKf4tPRL/22bRWdMkjsxDYw2HheE
         ffeA==
X-Gm-Message-State: AO0yUKVTtKezuV1I6AdmDSgMb244nmURhdIEdZuw6KBSRWiZIvQMzaD/
	fb+GGXmFigvUVFnwizbjSrM=
X-Google-Smtp-Source: AK7set/Dy/OiIoWPsFP25FzKvurgSrrz/ZgPSaAT+n7L2HU758PGsW8uIvv88tH+x1V2kVFngp9/cw==
X-Received: by 2002:a05:600c:45c3:b0:3eb:42f6:ac55 with SMTP id s3-20020a05600c45c300b003eb42f6ac55mr8876379wmo.1.1679558228072;
        Thu, 23 Mar 2023 00:57:08 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id p26-20020a7bcdfa000000b003ee443bf0c7sm1078433wmj.16.2023.03.23.00.57.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 00:57:07 -0700 (PDT)
Message-ID: <655d68b9-af0f-faae-b214-8dc564ae987c@grimberg.me>
Date: Thu, 23 Mar 2023 09:57:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/9] nvme-core: remove unnecessary else
Content-Language: en-US
To: Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de
References: <20230323033636.812758-1-kch@nvidia.com>
 <20230323033636.812758-3-kch@nvidia.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230323033636.812758-3-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_005710_485134_AA3F879A 
X-CRM114-Status: UNSURE (   6.13  )
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

