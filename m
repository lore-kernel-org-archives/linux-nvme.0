Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C91A3C7EE23
	for <linux-nvme@archiver.kernel.org>; Thu,  4 May 2023 14:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RM9Ca/E1x9z/ehVV2ens1sHIiZlbsELcW8zbvp45NXU=; b=CQQRqYPKf9ZiFmrtIgrLa/Pg3g
	rHlIW1FPsxMf8w+tHno0wYlMD9qLXEZFyuKYwO6r+eeFNc2syCjo2s3pEJzvjPg81Pip0jCRVt9V8
	b4DHXPZORne8y8AJB2LfnnG/wmXfpBDjM3aA/xYKY64IFHazlk9fp+cCGfIsv3arhaFCcDqY18aMW
	hfIJb1szWlon73VP2xZaSSoPHkyGLWlV/NYVjF3VdMzwGmMyXCGDBlNCK/Ng6kHeRg1c9f6w3ocZc
	bhltLFf3M2qb2nvkMtNK/yEQWJEK8hOQrj9lnYezlh71BUjG9zONeQ1K9E5tR+WizbJ1xg1Aaz3iQ
	tZi58t5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1puZeh-0082vm-2F;
	Thu, 04 May 2023 14:09:59 +0000
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1puZef-0082uW-2C
	for linux-nvme@lists.infradead.org;
	Thu, 04 May 2023 14:09:59 +0000
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50bc4bc2880so858867a12.2
        for <linux-nvme@lists.infradead.org>; Thu, 04 May 2023 07:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683209394; x=1685801394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RM9Ca/E1x9z/ehVV2ens1sHIiZlbsELcW8zbvp45NXU=;
        b=S8sXJlk1Z3ujOWn83w/A8d4Kgo9fsdXVYJAs4vUU7pbRrJ5FH/ubU4ru5YVtB5Xvi4
         O0gZY5/31T/iNK+MBdZbuYNjjGICfbPQbL/akOtxSZkHqPq8rkq+QHUifNG7u7tRufcK
         w4x3CGLFowKa958P2P7Dh7ePYMXcmHsu6lsitLaOcQyqEtJALZA4pIa3nIFGr4P95gVA
         /VG32ESjd/8kd9Pv/HILCf69NsbzjDwuOwU5sHGRPm4zLW2SPA4LGn/cqw851mc5pOL2
         W9dCK2y9fJIT1ZwUhbffq/Rf8u3V2zJn11luZ8Ck262KwHxW0+2LW9ImbYO94lsFh4Am
         7eDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683209394; x=1685801394;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RM9Ca/E1x9z/ehVV2ens1sHIiZlbsELcW8zbvp45NXU=;
        b=JFsUyTTcWdpvCbTaw6+AGczscP2en2cXROrYEscerFM+D5QuQBI5eV0byIZXMnaeKg
         utH4tibQikWMlrhXQJXiGK7zUF2Ac9tC875RO78t2RUS0bWbbgCatYXG6czHPzbZjP/T
         kOWyN6fbipn9Uzl/Ja67LXRswutmuMKMSJHzqTXjoB7+IYG59UfkGaj0HbRemWdmOM27
         +XIwcyZgscHVSTKYe1TM5C9pNsFobpYLTZOlYFMc3T6/g6tp4y87mmOfVt6uSsgA4JwT
         HNjLGkOQatiO2YjbsCSEci0q0P05yD1YpMiEE1DNmHOrB0IuiNOfk1P22xF8Hiz65L7s
         YOOA==
X-Gm-Message-State: AC+VfDydijhpx//aknrz2zc3igOecjyXEOY5WN/Jygig/oI1jeNB5+qh
	N5vz/QURIdQwTVnuC8lK6l8=
X-Google-Smtp-Source: ACHHUZ6w78XWE7vgQ5zdFqMb3sHlKvkr5gsykVkpVOQwrs3z4tt1/+k9hZ5rIvPjqFwJuvLOlt9AwA==
X-Received: by 2002:aa7:da5a:0:b0:50b:d421:a0f1 with SMTP id w26-20020aa7da5a000000b0050bd421a0f1mr1531749eds.41.1683209393664;
        Thu, 04 May 2023 07:09:53 -0700 (PDT)
Received: from ?IPV6:2620:10d:c096:310::20ef? ([2620:10d:c092:600::2:1631])
        by smtp.gmail.com with ESMTPSA id w17-20020aa7dcd1000000b004ad601533a3sm1907576edu.55.2023.05.04.07.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 07:09:53 -0700 (PDT)
Message-ID: <4451b9da-09b2-1269-54fb-630178e78391@gmail.com>
Date: Thu, 4 May 2023 15:09:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 0/3] io_uring: Pass the whole sqe to commands
Content-Language: en-US
To: Breno Leitao <leitao@debian.org>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, hch@lst.de, axboe@kernel.dk,
 ming.lei@redhat.com
Cc: leit@fb.com, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 sagi@grimberg.me, joshi.k@samsung.com, kbusch@kernel.org
References: <20230504121856.904491-1-leitao@debian.org>
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20230504121856.904491-1-leitao@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230504_070957_721624_028E7677 
X-CRM114-Status: GOOD (  21.92  )
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

On 5/4/23 13:18, Breno Leitao wrote:
> These three patches prepare for the sock support in the io_uring cmd, as
> described in the following RFC:

It doesn't apply, seems there are conflicts with ublk, but
looks good otherwise.

Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>


> Link: https://lore.kernel.org/lkml/20230406144330.1932798-1-leitao@debian.org/
> 
> Since the support linked above depends on other refactors, such as the sock
> ioctl() sock refactor, I would like to start integrating patches that have
> consensus and can bring value right now.  This will also reduce the
> patchset size later.
> 
> Regarding to these three patches, they are simple changes that turn
> io_uring cmd subsystem more flexible (by passing the whole SQE to the
> command), and cleaning up an unnecessary compile check.
> 
> These patches were tested by creating a file system and mounting an NVME disk
> using ubdsrv/ublkb0.
> 
> Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
> 
> V1 -> V2 :
>    * Create a helper to return the size of the SQE
> V2 -> V3:
>    * Transformed uring_sqe_size() into a proper function
>    * Fixed some commit messages
>    * Created a helper function for nvme/host to avoid casting
>    * Added a fourth patch to avoid ublk_drv's casts by using a proper helper
> V3 -> V4:
>    * Create a function that returns a null pointer (io_uring_sqe_cmd()),
>      and uses it to get the cmd private data from the sqe.
> 
> Breno Leitao (3):
>    io_uring: Create a helper to return the SQE size
>    io_uring: Pass whole sqe to commands
>    io_uring: Remove unnecessary BUILD_BUG_ON
> 
>   drivers/block/ublk_drv.c  | 26 +++++++++++++-------------
>   drivers/nvme/host/ioctl.c |  2 +-
>   include/linux/io_uring.h  |  7 ++++++-
>   io_uring/io_uring.h       | 10 ++++++++++
>   io_uring/opdef.c          |  2 +-
>   io_uring/uring_cmd.c      | 12 +++---------
>   io_uring/uring_cmd.h      |  8 --------
>   7 files changed, 34 insertions(+), 33 deletions(-)
> 

-- 
Pavel Begunkov

