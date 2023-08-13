Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F938C001B0
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Aug 2023 14:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ad0NVWbLc0DW2zExtiVlyR4ajbzJ+cjn6E663HH2QCg=; b=WSSCVBwzepg0XSF46x5wgw0DVn
	tbqtQ9smm0crChhU3m2Vqmq6NwOoU/UuwT96N1m9RIOjmxnbRXBiLoxNYo7Ci7pWGnxhNWr12TgGV
	YoZbVM/CnUI+Ezg75qSzPiNaoz1wY+kHc9GE+SJ2OVR2qPfhltYMZnCTIGP1E7v7lFyyUxJf+K4BR
	jC6oBZJuRFl2WQkAi8aykFZrIGfObkTOikOwfuVv3DyQ94B3k+eWm1qLzGWvbijhOKNdrqpm+Uiij
	aE1HMT81pp7z6Wf+2nJ7OYdVwsHPQ1m8w848o197UYJenrzZmcNpcObdDHoX3ezHir281aa+F3sJX
	dw5ySkHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qVCVY-00FHWv-1n;
	Sun, 13 Aug 2023 14:55:56 +0000
Received: from mail-ed1-f43.google.com ([209.85.208.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qVCVV-00FHWI-2a
	for linux-nvme@lists.infradead.org;
	Sun, 13 Aug 2023 14:55:55 +0000
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-522a9e0e6e9so839704a12.1
        for <linux-nvme@lists.infradead.org>; Sun, 13 Aug 2023 07:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691938551; x=1692543351;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ad0NVWbLc0DW2zExtiVlyR4ajbzJ+cjn6E663HH2QCg=;
        b=ME0vYl+b8PTZEuWW127yvgK4IjzhWBNAvVKuK8Zy75tYmvqn8IV3iXlzGYn/7aYu6K
         G3gJUMQybATSPxwKuY02QkslGNqln8jrP0MPW8HCztb6xs8GrPqd/twFDdIv7Qo8UuIK
         MMn9DrfD/CpgQwBVSbglYlJ/WwC/dkxpWtnfS9D5hMnyfSv8xR3YZg8qflovXdBilpjv
         i/4WCQyfCDlvwKvBQ3ZCe+buT4fj7a8bkgahDKYYPV4RqE9JpkwV99Bk5WU2Mckvm4Rl
         +hnXHwPq6iLRJffc+jzxujNi6ebm3WU23zEYUWF81zwtED9EDJSeM3jXPqjLNaVzSA67
         612g==
X-Gm-Message-State: AOJu0YwyFgNk2zQrbMAhkmaIbSpfeDCTDnrBbVHNu5fymWxIPuOEybvP
	uP3NuTpKBOXuigbYbm6hdxA=
X-Google-Smtp-Source: AGHT+IH3JQ0kaSRLJCXCDqYhq/hqML2mvDZq457dPLaKXnmiQQaxMW8oTzpTC0DWWg3H/Y51a7PXIg==
X-Received: by 2002:a05:6402:4314:b0:522:580f:8304 with SMTP id m20-20020a056402431400b00522580f8304mr6185856edc.1.1691938551110;
        Sun, 13 Aug 2023 07:55:51 -0700 (PDT)
Received: from [10.100.102.14] (46-116-229-137.bb.netvision.net.il. [46.116.229.137])
        by smtp.gmail.com with ESMTPSA id r15-20020a056402034f00b005255991c576sm1032584edw.66.2023.08.13.07.55.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Aug 2023 07:55:50 -0700 (PDT)
Message-ID: <58d299c4-84e1-603d-6c99-15d0484f9609@grimberg.me>
Date: Sun, 13 Aug 2023 17:55:48 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests v3 13/13] nvme: Introduce
 nvmet_target_{setup/cleanup} common code
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Max Gurtovoy <mgurtovoy@nvidia.com>, Hannes Reinecke <hare@suse.de>,
 James Smart <jsmart2021@gmail.com>, Bart Van Assche <bvanassche@acm.org>
References: <20230811093614.28005-1-dwagner@suse.de>
 <20230811093614.28005-14-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230811093614.28005-14-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230813_075553_845228_24661F00 
X-CRM114-Status: GOOD (  16.76  )
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



On 8/11/23 12:36, Daniel Wagner wrote:
> Almost all fabric tests have the identically code for
> setting up and cleaning up the target side. Introduce
> two new helpers.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/003 | 13 +++-------
>   tests/nvme/004 | 20 +++------------
>   tests/nvme/005 | 19 ++-------------
>   tests/nvme/006 | 18 ++------------
>   tests/nvme/007 | 13 ++--------
>   tests/nvme/008 | 20 ++-------------
>   tests/nvme/009 | 15 ++----------
>   tests/nvme/010 | 20 ++-------------
>   tests/nvme/011 | 15 ++----------
>   tests/nvme/012 | 20 ++-------------
>   tests/nvme/013 | 15 ++----------
>   tests/nvme/014 | 20 ++-------------
>   tests/nvme/015 | 15 ++----------
>   tests/nvme/018 | 15 ++----------
>   tests/nvme/019 | 20 ++-------------
>   tests/nvme/020 | 15 ++----------
>   tests/nvme/021 | 15 ++----------
>   tests/nvme/022 | 15 ++----------
>   tests/nvme/023 | 20 ++-------------
>   tests/nvme/024 | 15 ++----------
>   tests/nvme/025 | 15 ++----------
>   tests/nvme/026 | 15 ++----------
>   tests/nvme/027 | 16 +++---------
>   tests/nvme/028 | 16 +++---------
>   tests/nvme/029 | 20 ++-------------
>   tests/nvme/040 | 18 ++------------
>   tests/nvme/041 | 17 ++-----------
>   tests/nvme/042 | 16 ++----------
>   tests/nvme/043 | 16 ++----------
>   tests/nvme/044 | 18 +++-----------
>   tests/nvme/045 | 17 +++----------
>   tests/nvme/047 | 20 ++-------------
>   tests/nvme/048 | 16 ++----------
>   tests/nvme/rc  | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++
>   34 files changed, 138 insertions(+), 486 deletions(-)
> 
> diff --git a/tests/nvme/003 b/tests/nvme/003
> index 71b82ce758a3..54e5fe651c9a 100755
> --- a/tests/nvme/003
> +++ b/tests/nvme/003
> @@ -22,15 +22,9 @@ test() {
>   
>   	_setup_nvmet
>   
> -	local loop_dev
>   	local port
>   
> -	port="$(_create_nvmet_port "${nvme_trtype}")"
> -
> -	loop_dev="$(losetup -f)"
> -
> -	_create_nvmet_subsystem "${def_subsysnqn}" "${loop_dev}"
> -	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
> +	port="$(_nvmet_target_setup --blkdev=device)"
>   
>   	_nvme_connect_subsys "${nvme_trtype}" nqn.2014-08.org.nvmexpress.discovery
>   
> @@ -46,9 +40,8 @@ test() {
>   	fi
>   
>   	_nvme_disconnect_subsys nqn.2014-08.org.nvmexpress.discovery
> -	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> -	_remove_nvmet_subsystem "${def_subsysnqn}"
> -	_remove_nvmet_port "${port}"
> +
> +	_nvmet_target_cleanup "${port}"

It is very very strange that _setup returns a port
which is passed to _cleanup...

I think that _cleanup should simply remove all
ports, and that setup should not return a port
to begin with.

If someone needs the actual port number, then it
should either not use this _setup helper or
query it somehow.

