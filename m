Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FFDFF885A
	for <linux-nvme@archiver.kernel.org>; Sat, 25 Apr 2026 02:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mtw4qllgvTM2qvcTGWg0CUFN+XhXzX2Zq52T1MPVWwM=; b=V5AhTrc1IFY1PLOZCdbaYfkmSY
	iYx/qsgsfg2PRj4PWtv+ebtkd4cQhIrUyjh6QYPnJT70nkLz9xPNjVryKgsxHLnJVBbEqKj3/x/wG
	jA6YbIizR1zcoslxwk/b8pDpYcJFC2ma909ZblNV3fLmfO2wDrcLppuLagMEEnXB/iY+z8Smd94lH
	1k/Zhvup4KGitpofh/333F/pEFs9kBv2vWAUez5Cm0+FiDqYQbTRMyQ7Wa7+Vlkd1MiVy5KuN5fyL
	0HfTPJemWHCeHokArK0JiL55FjwWGH7MlFNaRWHq83ZQut8xS5akX6IL2Rp8VKilQqBqENTXWyNbg
	pO4U+2sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGSKA-0000000DzCG-1h4F;
	Sat, 25 Apr 2026 02:00:50 +0000
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGSK6-0000000DzBR-3wks
	for linux-nvme@lists.infradead.org;
	Sat, 25 Apr 2026 02:00:48 +0000
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-7dcc9b506d9so5176900a34.1
        for <linux-nvme@lists.infradead.org>; Fri, 24 Apr 2026 19:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777082445; x=1777687245; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mtw4qllgvTM2qvcTGWg0CUFN+XhXzX2Zq52T1MPVWwM=;
        b=pRt1ykd3e/H9XdkTv5UanmEi2efOuu2TDGA+FjTrjPNaq1BL6P1eabDaVY6iXcITT4
         Wmjl04xGonNYplU+0I0OYZi2mXdCJJ2LbFUGBrV068ppRsZo1EbH1Yk0csEIJ3ftz7cd
         kizdlbGyXT26n2aR14Pc2hjPNn+0ofYUvDPDlReCGgmfRdwdAm0h3yCn2Nq/Q0jSOtzg
         e/iTnhRnagSZ+p5gXdKIFn/SgDWu3ZYf+0PkuoA5f3pU+E4s5tHOjrDl/jAvYk6DqQnv
         surClOQZckY7H68nPfl/Z4DlvJdNLw1QVRWSIEcSXz6ReVJFBywqzqv9UADsyCKxrF9V
         7iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777082445; x=1777687245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mtw4qllgvTM2qvcTGWg0CUFN+XhXzX2Zq52T1MPVWwM=;
        b=TCMO3RYmTQVb1BkhiWmDVRWPfCL1u8uPbkzRJt1LKtIxRIYnaO8z56S000XzKX6LKO
         cPTa8ixh0qGOYxIRF8sEy+zXPqFb0Hf7Y+ERAsycgOMHy9Yyvd1SWP0G5qSOwjl3E1zT
         MY/Rsk7/8plMj5mOeMPKv2KlQkLC1Wq76lXEQt/P74qqfs+iY+WBhLgKcPAWBLMumWE+
         RK3NSAc64dsKfMv+yP0G/hnZ+GxWg8E3ivLkEERbxgO+/ICeudyDeVI5kpzLnfF3xtQ9
         Hyc4emUAwj2P+GQau7+xqimPfBtEo6BnUClY6cgUYZdBc9bjWE2wU5HwGu8FWjaRo0D+
         2mRw==
X-Gm-Message-State: AOJu0YwcAj+qi7F86smYYFLy7EvmVVRMnbboG3T3oojqTnUnsWZBo1BD
	nlbjkrO3z/oDhdjWzVRErl+tij+hxzFiwJC2cxP0mH4OEjRbEnkPtd4Sjy0aBu3EgX4=
X-Gm-Gg: AeBDieubVaTpTQS6T5YE1Q7rOoPVxE+j0m6RanNtouZ+OED8RY8TAHbYS2KiLEtLHFs
	mXCi1Noi//wH5L7HvVaz4uuXHkpHgrjrO5zsu0Mt2305WllmG8mMFf+9+hT54FWPaXpwJNwjV2D
	p6d7x6Ursf92viwV1bwD+nPS7N/y0jRW8VZBcah7Lj3+Jj0ghtrEcEpaN1yPL64lSZMQDoDIteR
	jX0uKPky3M/gSCVvYIBDJZp1ZjAfMRLwDsy2PlZTJPXF5vr+4bEbrTmo/LU+6PXkoMp6XdXsYX4
	9AHh+zmjHbh12N/sTL+AKoNLOA++bAUjlY4TTEFXUyTQM04s1AwOp3thw2YumAXAGz6TAOWqLUO
	DclD3j+0dD24Tin4AczEUCSUUW8j4br6KodPW6011tD9vYSLSOggd4OTf79/Cm/8KS3x2TwKExC
	hOzX9vwgyfynWqAbbgkiHAC36oUFzp76ZN3HXSxNB2asL4jCl3hf/V8fUKP5P7MCDbNbaYPK1E0
	1FRvMD4WAdnM5Htqar0
X-Received: by 2002:a05:6830:6581:b0:7d7:e045:b489 with SMTP id 46e09a7af769-7dc951084f9mr23012311a34.12.1777082444844;
        Fri, 24 Apr 2026 19:00:44 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975b057bsm22832132a34.20.2026.04.24.19.00.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 19:00:44 -0700 (PDT)
Message-ID: <fba13b53-b2d8-4db0-99d2-edb382708830@kernel.dk>
Date: Fri, 24 Apr 2026 20:00:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] nvme updates for Linux 7.1
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
References: <aeutKVHQDxuEfEVn@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aeutKVHQDxuEfEVn@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260424_190047_125403_D67B3FB8 
X-CRM114-Status: UNSURE (   7.56  )
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

On 4/24/26 11:49 AM, Keith Busch wrote:
> I realize I missed the pull for this week, but sending this now just to
> get into your queue in case other distractions get my way again.

No worries - just a heads-up that I'll pull this in after -rc1, as I want
to fast forward block-7.1 to -rc1 as its current base has the buggy arm
commit that causes full rebuilds of the kernel regardless if anything has
changed...

-- 
Jens Axboe


