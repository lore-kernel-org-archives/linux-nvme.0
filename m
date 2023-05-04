Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13DADC77B7C
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 10:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GHdkDwrOfS1Pl3Nuhj1rXOfP6XDushocOsRTj6KWz1M=; b=3DLozxvq5nERaS5tMRyDkOQc+l
	QeTp2eiWZbAQOKoT0tdK+z9BIo9Vg7CVGwIXOwfWvUjpA567O1M5QQi7Zkm8qqwtlpXvrnRUmcvRo
	HJFzY3NuDYA8vjb+USZmVRvpMf9K6M1/ZsxLp1zbDqel3SvzL2TqzoGYpv1oNvEPiANGIFcw1KgOY
	FPpA6cdXSdOUbS2nErZbziSH0cZxsOVbfQABXk2H66TJMx1G9oKb+tUcZG0tTlA+NihCYj0HWobp8
	pa+CjVoOOEpKCTeHRFTejW7Lib7eys6uEnCYPD5s+M4CGQlX87wdSda6XRAJkP6iKvauTUcjdz2H2
	8to2kDWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puW9Y-007PKj-1S;
	Thu, 04 May 2023 10:25:36 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puW9U-007PIe-3C
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 10:25:34 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f3284dfe34so550225e9.0
        for <linux-nvme@lists.infradead.org>; Thu, 04 May 2023 03:25:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683195929; x=1685787929;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GHdkDwrOfS1Pl3Nuhj1rXOfP6XDushocOsRTj6KWz1M=;
        b=kU5fbjbWMDYYcfVHZ4PC+52cLOqR3S0XBIFq1rELhiSwp/sZGT275G9fEUm+No/w8D
         OoQi1+MQwAXxa2t7Qj/exflZ6Vxqu3zKTYzQwFdVruLQRR4M46DK2oiEisKkEGNJnupt
         mNxY9YHbHXt/K9QMjO2CgRjXJnKLruFANQgZQVbu0on17AOBty5mCZjkgb8OR9XtsTCj
         JDXJCyAqsbBPqfx7aYmuaNI2uDc8cvV7Uq6XK1/8o2nmwgAYr6Gg9rB93G4pxb4+WhAo
         UTaov+GTyW+DA0j0RYPuT/fTbZ39THA8C5iq2d0hnW94E6TDcJegTUfr8Xd6ic4ltaAs
         E44w==
X-Gm-Message-State: AC+VfDzSXpXTTzkARAf+Efy8u82lAOoy+w9f7LanBXHXM5X3gqjrYL9Y
	BQtHjDwA4uV9KnBnv9bWKII=
X-Google-Smtp-Source: ACHHUZ7t6M+shOVxJ7YoMgvBWCMlytSjbzzI/g47scm56f7mEpYxhxFFG4jVNweVmv2Ev8pE7eBdPA==
X-Received: by 2002:a05:600c:602a:b0:3f1:8c5d:145 with SMTP id az42-20020a05600c602a00b003f18c5d0145mr7009157wmb.0.1683195928651;
        Thu, 04 May 2023 03:25:28 -0700 (PDT)
Received: from [10.100.102.14] (85.65.206.11.dynamic.barak-online.net. [85.65.206.11])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003f17122587bsm4466407wml.36.2023.05.04.03.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 03:25:28 -0700 (PDT)
Message-ID: <dca2b65a-2b76-50ed-7c58-e304efe1021c@grimberg.me>
Date: Thu, 4 May 2023 13:25:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC v3 0/9] Unifying fabrics drivers
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>
References: <20230504091259.29100-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230504091259.29100-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_032533_029163_2C3E0CAA 
X-CRM114-Status: GOOD (  12.93  )
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

> I've rebased on nvme-6.4 and gave it a bit of testing. Up to the last patch it seems to
> work fine, at least blktests doesn't trigger any errors.
> 
> I've tried to split the pure moving code around part from the part where we need
> to change some code. That means the last two patches highlight the problems I
> run into with this attempt to implement the setup_transport() callback

This should be perfectly fine covering loop as well. I think that
eventually it can cover pci as well, but we can promote it there in
time perhaps.

