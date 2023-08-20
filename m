Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73870EE49A4
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Aug 2023 14:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pbNFg4FMsOEtDpmNGiLWQaiUGQH+kOdMIT+2KSP2jaU=; b=2B0zU4SYZUviV+A6ay7HwPCi4S
	XZGVSiOybwstv62NfSkwVgGhRwmjWo9a+w8zUM0KM5pzfO/xdGbA/+ea9Tqa0dztgQ6TWPljVlrMR
	ksn/AK+FxhT0PixWmG/68t+1lbxC5IpsDK9Dv6hH2gA4e6Tnvmn6UFN+1gq89fROM7tqFteYZImQv
	B4MOo+cohIdvOpqupERIK6NLtKcJTPoZ5E9cYogPyDjeP1AxXN6aKrdKCCORXteg9jCxmR1inhcsG
	c83hdsWXxiQjWj01peHqupYGeI+Kmu4/5hSZE/ZTgXwAzczvW58GYOjD1kqw7ixth14NPTP/IrGdB
	xFWoUuNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qXjt3-00C4Mr-1x;
	Sun, 20 Aug 2023 14:58:41 +0000
Received: from mail-ej1-f46.google.com ([209.85.218.46])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qXjt1-00C4M7-0l
	for linux-nvme@lists.infradead.org;
	Sun, 20 Aug 2023 14:58:40 +0000
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-99dff8b95b9so64580966b.0
        for <linux-nvme@lists.infradead.org>; Sun, 20 Aug 2023 07:58:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692543517; x=1693148317;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbNFg4FMsOEtDpmNGiLWQaiUGQH+kOdMIT+2KSP2jaU=;
        b=XKWy9DV4o8Vue3/VPufam2isr97fCOP5dJpRhkaGHddImo6d23Uq6T4OA+F9UNE8Ms
         787rrzPDkGw8OTtE0/7gp5F5MSqSMCb8pcgzyoaXN+iwPpiOxlNv0xiAOOMZqDpYnC0A
         pIWlFiJbEKE2reuaRk1yMN45rlIxVRcHLucBUeorqMSWit33d9kpOFghkFtv1/TTCujV
         Hklh+tPVMzvR9e8i+G5AsBajN5AbNytaNgovReK7h7AS+fYejml42Cb/aCVAm/wj0vbr
         wAyEZnh5nRbeBm1+wjGmdFax+TG4KXQv/da3OHFiC2V3P3hek6WlGdrFvEmKEcSTY961
         sXEg==
X-Gm-Message-State: AOJu0YyjPC+YjjJAv8++6iU8abtIWVLFDGZsxopoggLmI5k6iXafM4+F
	mB4/7PyzjITBe6OifmQc1NI=
X-Google-Smtp-Source: AGHT+IEs2VbbrzpBE+6vpoyVdVfQITvx7jOeRoIxPgTHfLCA6rCxKbzutCXT8qsW0HasIjlnL8cdZw==
X-Received: by 2002:a17:906:535d:b0:99c:d995:22e6 with SMTP id j29-20020a170906535d00b0099cd99522e6mr3378271ejo.3.1692543517034;
        Sun, 20 Aug 2023 07:58:37 -0700 (PDT)
Received: from [10.100.102.14] (46-116-234-112.bb.netvision.net.il. [46.116.234.112])
        by smtp.gmail.com with ESMTPSA id e3-20020a170906504300b0099bccb03eadsm4744880ejk.205.2023.08.20.07.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Aug 2023 07:58:36 -0700 (PDT)
Message-ID: <3713297b-a5fb-b027-c34b-d56526155c4c@grimberg.me>
Date: Sun, 20 Aug 2023 17:58:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests v2 3/3] nvme: introduce
 nvmet_target_{setup/cleanup} common code
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Hannes Reinecke <hare@suse.de>, Jason Gunthorpe <jgg@ziepe.ca>
References: <20230818141537.22332-1-dwagner@suse.de>
 <20230818141537.22332-4-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230818141537.22332-4-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230820_075839_343490_28DDFDC4 
X-CRM114-Status: GOOD (  13.96  )
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



On 8/18/23 17:15, Daniel Wagner wrote:
> Almost all fabric tests have the identically code for
> setting up and cleaning up the target side. Introduce
> two new helpers.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/003 | 14 +++-------
>   tests/nvme/004 | 21 +++------------
>   tests/nvme/005 | 20 ++-------------
>   tests/nvme/006 | 19 ++------------
>   tests/nvme/007 | 14 ++--------
>   tests/nvme/008 | 21 ++-------------
>   tests/nvme/009 | 16 ++----------
>   tests/nvme/010 | 21 ++-------------
>   tests/nvme/011 | 16 ++----------
>   tests/nvme/012 | 21 ++-------------
>   tests/nvme/013 | 16 ++----------
>   tests/nvme/014 | 21 ++-------------
>   tests/nvme/015 | 16 ++----------
>   tests/nvme/018 | 16 ++----------
>   tests/nvme/019 | 21 ++-------------
>   tests/nvme/020 | 16 ++----------
>   tests/nvme/021 | 16 ++----------
>   tests/nvme/022 | 16 ++----------
>   tests/nvme/023 | 21 ++-------------
>   tests/nvme/024 | 16 ++----------
>   tests/nvme/025 | 16 ++----------
>   tests/nvme/026 | 16 ++----------
>   tests/nvme/027 | 17 +++----------
>   tests/nvme/028 | 17 +++----------
>   tests/nvme/029 | 21 ++-------------
>   tests/nvme/040 | 19 ++------------
>   tests/nvme/041 | 18 ++-----------
>   tests/nvme/042 | 17 ++-----------
>   tests/nvme/043 | 17 ++-----------
>   tests/nvme/044 | 19 +++-----------
>   tests/nvme/045 | 18 +++----------
>   tests/nvme/047 | 21 ++-------------
>   tests/nvme/048 | 17 ++-----------
>   tests/nvme/rc  | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   34 files changed, 141 insertions(+), 519 deletions(-)
> 
> diff --git a/tests/nvme/003 b/tests/nvme/003
> index 71b82ce758a3..eed1f549866a 100755
> --- a/tests/nvme/003
> +++ b/tests/nvme/003
> @@ -22,15 +22,8 @@ test() {
>   
>   	_setup_nvmet
>   
> -	local loop_dev
> -	local port
>   
> -	port="$(_create_nvmet_port "${nvme_trtype}")"
> -
> -	loop_dev="$(losetup -f)"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> +	_nvmet_target_setup --blkdev=device

--blkdev=device by default no?

