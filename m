Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C925C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Mar 2022 16:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=x3CSxfWiPMeexpjcxnvsCSa7jVBDlA3IiXoD0HRPXkY=; b=uLKsGAtcgjJ2wVImJsTOKdaWLz
	k1rW3ozfkkEa1faPv8vpC7MdeB4s/xCiQntYUsHq/dBsxjyL7k6he0lOBjY+KHawQjLhsx/cCaw68
	F85LurC3YPvNAyyU4ZIV8ygitVKwh8NbL49Yu1f44K1x349tWzOBMuiyLmAsB3o7r8gNa5x+YX5S9
	ZPY5pc4UuITgBSlUWHcNRxSyFjNG0Hw53SL3RIPEnt/VbuGdu1w+7EiEv20bTXwEDEjl/RTzCQr7S
	3+0XoUvhQ4J9loDY66QWpSJmKCgIqpsDb3zilJFsMh7+u0T4RDUzhmV/dc2JGlCnxq99gO6jNM/Fu
	8PLc7Z6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nPo6N-0075EQ-LV; Thu, 03 Mar 2022 16:14:51 +0000
Received: from mail-io1-xd36.google.com ([2607:f8b0:4864:20::d36])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nPnyz-0072bz-0C
 for linux-nvme@lists.infradead.org; Thu, 03 Mar 2022 16:07:14 +0000
Received: by mail-io1-xd36.google.com with SMTP id q8so6358046iod.2
 for <linux-nvme@lists.infradead.org>; Thu, 03 Mar 2022 08:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=x3CSxfWiPMeexpjcxnvsCSa7jVBDlA3IiXoD0HRPXkY=;
 b=IRmPLEnRG/Jb+9kmq2sd1/CGMb6aGeR2Gy3r1cncnqd/6U6E10p8ZOypK9mED9eUQl
 PIliJl5VFst82zMkAswtL7KgYgNXxGHnz2QRHUbOXooD1LD3BegkK5kcCa1yhwcpeVkY
 q/3wVDdYU5ykE8dqpW+P7apm1QASGsMtNOQvKfGZRnzDxeYAE+H596pw9Ynx40OzwVE/
 JRk5sFJEjf0exH2sFBlLGCRmrNsM5tNHYXp9K40Ygzs1LztkhjWNx5lI5kG22ZLvypGn
 D876/q6g2Z4HBTWXbFbtGzePeRPRk+pfMvc5C5dJ64GFMGf35b+jYrLhxGXWnHDFrlKu
 yVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=x3CSxfWiPMeexpjcxnvsCSa7jVBDlA3IiXoD0HRPXkY=;
 b=yJRTc1z/aIXi94LoCTf6DerAwVRGjd4++j8GP+ZA5n60wTbKFvDBf5m7bqtpgloVd6
 rFfZL0g0VacRFtZ1V5k2BUHbt/5AApabUF3Wd17ZBLqGSo019iTJ2sjPpbuSpyV3IbW5
 cRH7MIIjKIgBbKdFrlu0dr52cnnqStHdvWcTLVxwNu6njtpy6qWmzn+KkRqtEUhYfvJq
 6L1orjfjnc3bdnM32t9EqhHQl9BwackOERnOM9PAetJ2gaEdnCE1FrHjATFncOqkayRN
 7IDrg6MYMlT7mvSuSTarSd0nA2ZgLJKHHezIQBMXmR5rAfONnpkUcs+nHVSB+dVcKASW
 ypfw==
X-Gm-Message-State: AOAM533Yqmx52J5nXFLaSkowyEcgtm4tXz4fR5JVc0jjXR1Yle+yxIDZ
 5RCEppZ48OXNUEAFaj5oblzFyw==
X-Google-Smtp-Source: ABdhPJzeXVJeyMRq7uwtmyLgDSmWDDFL2a0XaFuhDsfeiLaZ/X092W+WBXPYspwB8lAs2HOSi13kqg==
X-Received: by 2002:a05:6638:2172:b0:311:9f6f:cc56 with SMTP id
 p18-20020a056638217200b003119f6fcc56mr29624834jak.148.1646323631692; 
 Thu, 03 Mar 2022 08:07:11 -0800 (PST)
Received: from [192.168.1.172] ([207.135.234.126])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a056e02160e00b002c60907ec07sm2300382ilu.62.2022.03.03.08.07.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Mar 2022 08:07:10 -0800 (PST)
Message-ID: <3523636d-dbce-4f31-60a9-503c5e77e492@kernel.dk>
Date: Thu, 3 Mar 2022 09:07:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [GIT PULL] first round of nvme updates for Linux 5.18
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <YiCcsBPAQwEaDCH2@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YiCcsBPAQwEaDCH2@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220303_080713_167361_0ABCCE65 
X-CRM114-Status: UNSURE (   8.93  )
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

On 3/3/22 3:47 AM, Christoph Hellwig wrote:
> The following changes since commit df00b1d26c3c3ff9dae4b572a6ad878ab65334e1:
> 
>   null_blk: null_alloc_page() cleanup (2022-02-27 14:49:49 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.18-2022-03-03

Pulled, thanks.

-- 
Jens Axboe


