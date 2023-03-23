Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E6CC74A5B
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 19:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lr5SCRaLnnassC/wG2V2g1s24IM6Sp4Gt06w6T5TsjE=; b=YzitiiCfoLtBFxYNGuuJDF9Lsw
	XUJKvVABcUGrTD/AytfhJBtaoM0BheqwgjaYSkJ9Q7T/1Le03Jz1+sMF3nv+1v/r66EbAwk+/4Iry
	bppgcbIHbkgLpr21exIbz8jhz1Wt/jLaIFZWoX1AWmI2VUGf55MSoBPNBM7ToYzt/TCvudASdYMrq
	wRnlRrO8BZ3eM0Lc6MJg1up0rbxc7WanF3GzCuzpgGfDX7EI1l5aqr7h0EtggM2m2A7eFt+tou5LH
	8UQf0IsNzDfW8wp5cA24GTGu94/D11ZEVfjKGEuNTlm2Y4hPZ19FvEmtZrHN7RczmOuemhl8p4oiJ
	aenelkzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfQD5-002nAb-2m;
	Thu, 23 Mar 2023 19:02:51 +0000
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfQD2-002n8b-2p
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 19:02:50 +0000
Received: by mail-io1-xd2c.google.com with SMTP id bl9so3965774iob.8
        for <linux-nvme@lists.infradead.org>; Thu, 23 Mar 2023 12:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679598164; x=1682190164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lr5SCRaLnnassC/wG2V2g1s24IM6Sp4Gt06w6T5TsjE=;
        b=O7wNq4xvbwJ8xOsZWh5it31XAuwYnvxpQCeGCCuyuXAckJmiPAV6oAazyjH5psvAGb
         zjpTncNoe69qWf3maFYANYtoOczFPHeCIDGBlNZ5SRJUlAd3PgibBmF9C0LAgjF9VLOD
         mdRXShuYDR5UAbwbGhsx3H8g3A1ErtUsPrgJrhz9Nk1ZwqOdUqUOmAwKRmffilUChEoJ
         PMdjnBesNEQnRYDmQhwrz2IgmZRhanWw9t5xfTIbktIrWfoxF9mDOKMJ605Mu1YnzuJ/
         62cTWeNH2dDYyijixaXb+NKrA9vPAkeibRUkO1TbJ9EdRa7XTzuVoljfH+C3DTi2c2qG
         fYXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679598164; x=1682190164;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lr5SCRaLnnassC/wG2V2g1s24IM6Sp4Gt06w6T5TsjE=;
        b=pcdCeMZpVp/w/EZ6UptIesYcvgcFx1kL+lNkgp68J8t+6BNtAExfQjWwpMIfuHSL/h
         S1p+0ixeXjLJ8bcH5NVcaB65+0lBa84hkrjTh0L0rvu/NuXNwVvMVB5VwH7EVzxf+XAa
         Phf9p7+KYaQsWB/EKvjkF8w92v/1OEjDl/rzT3FCJx6pD4P+vNw4N1AEAI/fziMylDSi
         qsHXvBObJwcGukzAJdfhhY39VCa5JTL6eP8ubOM2ao2ZKXxGQrSwlnL5Rm0O/ZnKv7Dr
         p8fpHT/9kOx2eXBMvioSkm149MOVJn7/bNLpGdhokjudoyrfZck4dItbQfPiVHonr7fe
         /+PA==
X-Gm-Message-State: AO0yUKXv01GVWjQILnNJTOx5plXo6ROE0L2VGobAfld5WO9/BHvYNNkX
	TGOC26Ny2WSMfgI4HUXGDrhDaw==
X-Google-Smtp-Source: AK7set/lQt6FMHnB63T9//h60ZloE9026C9/GVrTJ/eidrJe5Nam+szzcKe1u6/WmobRkaZOP4pQYA==
X-Received: by 2002:a6b:b257:0:b0:758:8b42:ce5a with SMTP id b84-20020a6bb257000000b007588b42ce5amr142316iof.1.1679598164093;
        Thu, 23 Mar 2023 12:02:44 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id i18-20020a026012000000b00406496ef3dcsm5797377jac.49.2023.03.23.12.02.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 12:02:43 -0700 (PDT)
Message-ID: <bb3aa601-f8e1-c883-7b36-bde0650ce355@kernel.dk>
Date: Thu, 23 Mar 2023 13:02:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] nvme fixes for Linux 6.3
Content-Language: en-US
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <ZBvQbMungfXYQaL8@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZBvQbMungfXYQaL8@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230323_120248_914783_A1A05AD5 
X-CRM114-Status: GOOD (  11.97  )
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

On 3/22/23 10:07 PM, Christoph Hellwig wrote:
> The following changes since commit 9d2789ac9d60c049d26ef6d3005d9c94c5a559e9:
> 
>   block/io_uring: pass in issue_flags for uring_cmd task_work handling (2023-03-20 20:01:25 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.3-2023-03-23
> 
> for you to fetch changes up to aa01c67de5926fdb276793180564f172c55fb0d7:
> 
>   nvme-tcp: fix nvme_tcp_term_pdu to match spec (2023-03-22 09:19:56 +0100)
> 
> ----------------------------------------------------------------
> nvme fixes for Linux 6.3
> 
>  - send Identify with CNS 06h only to I/O controllers (Martin George)
>  - fix nvme_tcp_term_pdu to match spec (Caleb Sander)

Pulled, thanks.

-- 
Jens Axboe



