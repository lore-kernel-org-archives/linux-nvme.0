Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C00EC00A8F
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Oct 2023 13:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qHLUl2rviwOEYzkUoWMIc0UMrw0kyEP+QEE0nMFVMXY=; b=PntgtUP5Z9GrYodc6tZKHGdniC
	VaupqmXxYpSZd1T2cygI3Y0sQ3LrZaBoh6k3clmvpwmRAvkFTaRi5PRni5i1hTDuOiEMys0lXPOUL
	3WKpH+DyQriNvKkgQLXvimrfpPhzoGfR/ePJgd+86RnLSfLpwbbIKrrWlztpQiZVSHTzkv9tXA5KE
	vRtpWKQrp5wk+3b4mMpEMlXf21SrF4EcP6pkpZVghHnWaMwwHxntKS7tXsVNzTetiGdYWUEUQL5OH
	ewPZc44CXsQo1rg+boEgxG/dalicy0D2tyM1+h81vHh/4RpjtH1PVcQcJf40hdGXfFOM4+iPH7bIN
	FyUrtAnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvHuw-00A3MZ-03;
	Tue, 24 Oct 2023 13:57:58 +0000
Received: from mail-pg1-f177.google.com ([209.85.215.177])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvHut-00A3M8-0U
	for linux-nvme@lists.infradead.org;
	Tue, 24 Oct 2023 13:57:56 +0000
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5aaebfac4b0so2581551a12.2
        for <linux-nvme@lists.infradead.org>; Tue, 24 Oct 2023 06:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698155873; x=1698760673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qHLUl2rviwOEYzkUoWMIc0UMrw0kyEP+QEE0nMFVMXY=;
        b=MRFYOPh+WVRVtR44QAfhFTExATwJEOox3qewrmLQlmel50RZjx6VWasEZaattOrrKU
         /bGMEzRwqB68piPSXWl4reI0JZaLCfb0SzT6PkRQjHOZD5UqlG4tuUFy014XU5gWRx1O
         pTmLhem/AxxfaXFxBKkcucD9W45RW8fFa/rWSN485d/nFuyIji2NfXOZgSF8klYBoG7j
         58QFcVsKmZzUtLQMeVnWbXyxpDpq8zptglS5dJD9FdCvVaotAyVLc26PPykjgn+B8osC
         NMlM2b3UTiJ4X6DmyyjVFH2Sqwgd+dTIGHmMpaZLDGeeUhUBMc8DMIvRbvJ1LACzYHq5
         Mobw==
X-Gm-Message-State: AOJu0YwBFyn9jaIQbcr0NOGGv/qLjRZ3XZIQZhFVOJKOnAxdpD9g4h8G
	yM/7v8EIBsjxRndwnLtlaLs=
X-Google-Smtp-Source: AGHT+IE5qx6HN3EzbKUIwvWTv+TC582ScGTYgsPVwjueuwXYih+yxExY/typ39RJ86V4tTyBd6Kg8w==
X-Received: by 2002:a05:6a20:bf19:b0:17b:cd83:6555 with SMTP id gc25-20020a056a20bf1900b0017bcd836555mr2103715pzb.23.1698155873483;
        Tue, 24 Oct 2023 06:57:53 -0700 (PDT)
Received: from ?IPV6:2601:642:4c01:f978:8cc6:940d:123f:6f04? ([2601:642:4c01:f978:8cc6:940d:123f:6f04])
        by smtp.gmail.com with ESMTPSA id 23-20020a630f57000000b0059cc2f1b7basm7070593pgp.11.2023.10.24.06.57.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Oct 2023 06:57:53 -0700 (PDT)
Message-ID: <aa259295-1ec9-41e1-9527-409f3799e8df@acm.org>
Date: Tue, 24 Oct 2023 06:57:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: blktests: running nvme and srp tests with real RDMA hardware
Content-Language: en-US
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>
Cc: Daniel Wagner <dwagner@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
 Hannes Reinecke <hare@suse.de>
References: <vaijnbobhxyz4nkk2csv3nfhnpeupbudakcn3qgmo7o6vii4x5@rfnfdll6iloo>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <vaijnbobhxyz4nkk2csv3nfhnpeupbudakcn3qgmo7o6vii4x5@rfnfdll6iloo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231024_065755_186263_20E754CB 
X-CRM114-Status: GOOD (  13.95  )
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

On 10/23/23 19:59, Shinichiro Kawasaki wrote:
> Hello blktests users,
> 
> As of today, software RDMA driver "siw" or "rdma_rxe" is used to run "nvme"
> group with nvme_trtype=rdma or "srp" (scsi rdma protocol) group. Now it is
> suggested to run the test groups with real RDMA hardware to run tests in
> more realistic conditions. A GitHub pull request is under review to support
> it [1]. If you are interested in, please take a look and comment.
> 
> [1] https://github.com/osandov/blktests/pull/86

When I wrote the SRP tests, my goal was to test the SRP initiator
driver, SRP target driver and dm-multipath drivers and also to allow
users who do not have RDMA hardware to run these tests. Running these
tests against a real RDMA adapter tests other functionality than block
layer code. I see this as a use case that falls outside the original
scope of the blktests test suite. Running NVMe tests against a real
storage array also falls outside the scope of testing block driver
functionality. I'm fine with adding this functionality but I hope that
it does not become a burden for blktests contributors who are not
interested in maintaining functionality that falls outside the original
scope of blktests.

Bart.


