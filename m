Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E10C197A0
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Nov 2023 11:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=yumYh0iMW2BpMao1XVpVZ2jOkF
	i+w+npSUNQSIOuQZDCMuIriiqljqHKwn/QuOo4YuKUG1bR2T6+wP8pixCO7DxKPIbAHEsAG5LWjdX
	QvzV4h7uoiVvsofp1cpHopve6XCFkVj5/dZzHLfBRmefyiPHJu0HTUZ/4UjG6paixqxCMonScZxJf
	8nshAOGhtJrtMi0KpPOeLzXvgnKZK8t46cnduZc/6O/myhSDj6VPgT2+4710a0X/Uey6FfPQV4YUk
	+JH0FQScRcglAbKLDLMXgZUm/0U2eTSmKqi00oYygyRTsRfnT0PkOtfLtMqiMQzedVbMHLcZ+Bj0I
	T5FEdWdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r521q-00BqmV-1U;
	Mon, 20 Nov 2023 11:01:22 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r521c-00Bqgl-0U
	for linux-nvme@lists.infradead.org;
	Mon, 20 Nov 2023 11:01:20 +0000
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40837396b1eso2167125e9.1
        for <linux-nvme@lists.infradead.org>; Mon, 20 Nov 2023 03:01:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700478066; x=1701082866;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=BSWuylSvGOGAQ9a+s/uDabeagwkuH63S/WBFntNJMbKzBGgroemaYymwOiweRd26v5
         5oL7YwVITcs1tB9dES3+EBtz7FAuv3ypx+gHjFlA3Tbn+US6FO8ONTmt7kn5EUyVkDZn
         fqoIRPY9YJsfyReXc8TjjkeY7X6n6Ebe4teemru9VlSBnlM76s1eNURI2hEKg5SRZXVK
         jMDKvrkePxaPFgrkQMPbtAaEY3LK7vZ42vMMCEm3/4TaiBK3sAgNPG3zP7iAoIOsdsp6
         0VPOopBtMq2flNhtNf8S9qYUpXkHWTswBg78AyT1B9bL+qgF8nOLvZhqze05lAvmNnAi
         t0aA==
X-Gm-Message-State: AOJu0YyQQZGBX8Tjb0+aRpElLGCQF7e2coHNibUDeDJJ8FfRW0ar0Y/a
	bvbKwkzzqiWp0JVXDTsPbAE=
X-Google-Smtp-Source: AGHT+IGhlldqDixGyGllvnolSag0cu3gFPwbWA1e4u9fC5SdAdWMJO1V1YinqrYKHdrIj54JFTR4DQ==
X-Received: by 2002:a05:600c:4e41:b0:404:7606:a871 with SMTP id e1-20020a05600c4e4100b004047606a871mr5977827wmq.2.1700478066190;
        Mon, 20 Nov 2023 03:01:06 -0800 (PST)
Received: from [192.168.64.177] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id t13-20020a05600c450d00b004094e565e71sm13041848wmo.23.2023.11.20.03.01.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Nov 2023 03:01:05 -0800 (PST)
Message-ID: <550c6580-bc39-42ac-ac19-230f54a6e10c@grimberg.me>
Date: Mon, 20 Nov 2023 13:01:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2 RESEND] nvme-auth: set explanation code for failure2
 msgs
Content-Language: en-US
To: Mark O'Donovan <shiftee@posteo.net>, linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
 kbusch@kernel.org, hare@suse.de
References: <20231011084512.1835614-1-shiftee@posteo.net>
 <20231011084512.1835614-2-shiftee@posteo.net>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20231011084512.1835614-2-shiftee@posteo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231120_030108_444866_F9A36431 
X-CRM114-Status: UNSURE (   4.72  )
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

