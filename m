Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD545C4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Dec 2022 16:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UXlbX1VyAp1OUkMGBpH9EiNGKAxy9fO5IsYvI0ywITo=; b=jMwlfiiUW1CFb+v6hwfxfDS6XQ
	eLv9xMA/xMbX8uOl8dELHb5u9bLfD1aA0U2U0fOLlCCJp7feBEXe1tsGbGnTFfVnXtY9Rjn6lOvhe
	tjKRb5Lh5bK4mU2oegNVsGYbNmEW+vuuQNXmF/Fic6kNuhWXxvKlBFQvo53MBuc0NKBILoGyhTcLu
	+oCmAHsRpQUoF+YHHMp9lRqI/be3bntNg3V9vcRtxX3LAxyp9fIC3Fq2Q1boLeIOPXTFaKRBQEG9y
	uaAy4G6Z/cDTGq/QN+ZSL6zhxiSIKBvsg0WT+nJLQo/YeMVH14fQcF8Z06LqBh7qYHAZtg248938d
	DZ29wAwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8OOw-00E2hE-TE; Thu, 22 Dec 2022 16:26:35 +0000
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p8OLm-00E0ss-GF
	for linux-nvme@lists.infradead.org; Thu, 22 Dec 2022 16:23:21 +0000
Received: by mail-pg1-x531.google.com with SMTP id b12so1638868pgj.6
        for <linux-nvme@lists.infradead.org>; Thu, 22 Dec 2022 08:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UXlbX1VyAp1OUkMGBpH9EiNGKAxy9fO5IsYvI0ywITo=;
        b=3GhP48iDsw7f3PN/e0bFTcv0wTw99koJKRq7qbRwENHRRKiyLXG4lVTjrlwLgrDMfK
         m45LccLNE8dr7UUTsyzS3klT75UkUXzdYCBIHBBO51foNhFQTaS6Ph2diBUX8v8T30Wz
         y/z3CU++6aFCJ7nU1mgRzOsD5NlKHG1+ArdJd77AdbWCCG2TNdYW6xwtBMXQAKKYxMwl
         niR8b1PcoiGawFC2t7R6ADFbPAK++sOTnxPe5r2NveIM+HWRTdKVMioCEXDCU02ViOBW
         vFrWlAH0QHZMHivIhLCx9VJEvZK26CktVAi0guj63kaKwWAT4cZoulHpczOf5JD3nt5j
         nwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UXlbX1VyAp1OUkMGBpH9EiNGKAxy9fO5IsYvI0ywITo=;
        b=y+AcE58SkKclnJvCN341kEQGByTtwUMC4UnTMAunN+Eza9gpmZAdfKOAaiNFDFYr3s
         Jer8GVV96wtCx+cwme6rVshKA4kdRZH6/V9K5fBYVrjOgMdCXMCxcCHy5sryN2cszI62
         IF6RpFacMaNvxKhxD6lR2yrtEpmE2Pq1aZ0yK+TdtExSaAI1wqiB/Iy1nRvczBHJ0mTZ
         NNblamRKiymJwVCYeX8BbLG8qITFotPAMj3u3PxtW8YOHyCSSUCX/m3ZHCRPXR+vxjmf
         jG1KjGG5rPG9d7wJuthaIReFr7np0cRa91p56rZdnaLpUeE69goGitaAeeafOOagoMVH
         zWgg==
X-Gm-Message-State: AFqh2kpx/RGmY4q88/31dv26hGEIDzZSRs1aK3ptRf7cXMyx/xcvDRW4
	lxJdZAwyhLCFpPswnYouXfdnkRWNSkZe7VJr
X-Google-Smtp-Source: AMrXdXtgaBwVjVuK9ElEkuRLLaMFoufiteDPKp8RMN9JoNyAuUkFKncyt6MbxWyHiFtw/GNAQhz5dg==
X-Received: by 2002:a62:3894:0:b0:56b:a661:5a5a with SMTP id f142-20020a623894000000b0056ba6615a5amr1672622pfa.2.1671726194457;
        Thu, 22 Dec 2022 08:23:14 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id z7-20020a623307000000b00576d4d69909sm952358pfz.8.2022.12.22.08.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 08:23:13 -0800 (PST)
Message-ID: <7c253b8a-7535-51f0-5325-fb3866f7634e@kernel.dk>
Date: Thu, 22 Dec 2022 09:23:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [GIT PULL] nvme fixes for Linux 6.2
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <Y6R7MBrn2xzmwT1J@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y6R7MBrn2xzmwT1J@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221222_082318_585528_C22ADA96 
X-CRM114-Status: UNSURE (   8.68  )
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

On 12/22/22 8:43 AM, Christoph Hellwig wrote:
> The following changes since commit 53eab8e76667b124615a943a033cdf97c80c242a:
> 
>   block: don't clear REQ_ALLOC_CACHE for non-polled requests (2022-12-16 09:18:09 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.2-2022-12-22

Pulled, thanks.

-- 
Jens Axboe



