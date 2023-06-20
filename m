Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEAACEB64D8
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 13:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hlxEnYUT/GBNJ3ibxmMMF9Ie5mQ6Tr4qzFp00sesHFs=; b=vTseMNl3Z5PXs//2zQLL9d9f/U
	MTd2X30RjBpBGwlN464YSqsP9QFerbrinFKTFMZR4vq8ersIzeu90sugVYulSrMcW1UivKx4/39JI
	F9E6bH3myHUYfTNnGHR30UlTE5O7+mTM/pKMmJy2Ag23LUg0Osz9T4T7jbTOyNuHbuxMll29L98DP
	J0bWPzcRwEhXNbOwdmY83tkavQOcw8DnGRKaXpAaDhi+vQ7MutQR8USuITBEGPqPsVY7VXDZQrpGB
	KO24z6g3djWv6oQ5GDuhUT2hJfAthhC8O3Hj+Vk91FUnjJGOaWQBBY6O24Lo7oLHEE86PxkOb7SQP
	yJ3XgifQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbk1-00BSOv-01;
	Tue, 20 Jun 2023 13:49:53 +0000
Received: from mail-wr1-f43.google.com ([209.85.221.43])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBbjz-00BSO8-0A
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 13:49:52 +0000
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3110e74bf3cso1034158f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 20 Jun 2023 06:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687268989; x=1689860989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hlxEnYUT/GBNJ3ibxmMMF9Ie5mQ6Tr4qzFp00sesHFs=;
        b=aGauMy7TYefAjhvfZ1uReMDqaqsVVLA5Wodbl1u4nBexGQa7I89cgFi9r03S9nYzDC
         UJBZv5YeLsmYF738lLz3zAwfc8p0od13qUnKKsQd7w8j0FLb7G0+8AcgoiuFLr8P6mO3
         7mMx6Rw1HRUzPK3+pPdRx2t9RxIo5YroROFM/S5iS5cf0QBjIuSzsq/ufXziZff66b/m
         7Nq1u/PPMPBZ8AJJziyQem8XwO+2/CXKtiqKL1QPAf/E0yYuwcSck08+Ujr/UnRWWbjn
         XdJXjBqndnNRhpfLbLkfuasxEUG7YUYhc9InpNLBAKqmv0VLPJ0QpetvmofYszInMzU/
         lT1g==
X-Gm-Message-State: AC+VfDwGxi1gkNu2M0700PiWZlThOPihUmhxGHMIRUngzR13q659YRTF
	gC5DY/Lt2LyhRe1cR3fU+NQ=
X-Google-Smtp-Source: ACHHUZ7dfSygVmSYoeR8bcP0LWtDsP3kSnE1m9tFQ7YhYMY1daxOcmdm5XHD3k6L8NIykPxUMXsgdg==
X-Received: by 2002:a5d:66d0:0:b0:311:166b:b3b0 with SMTP id k16-20020a5d66d0000000b00311166bb3b0mr8870155wrw.7.1687268988999;
        Tue, 20 Jun 2023 06:49:48 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id m13-20020adff38d000000b003113ed02080sm2044736wro.95.2023.06.20.06.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 06:49:48 -0700 (PDT)
Message-ID: <380cde65-8794-cfbc-237f-30a8d7e9330c@grimberg.me>
Date: Tue, 20 Jun 2023 16:49:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests v1 1/3] nvme/048: Check for queue count check
 directly
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
 Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>,
 Martin Belanger <Martin.Belanger@dell.com>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-2-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230620132703.20648-2-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_064951_085416_DC9C94A4 
X-CRM114-Status: GOOD (  20.21  )
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


> The test monitored the state changes live -> resetting -> connecting ->
> live, to figure out the queue count change was successful.
> 
> The fc transport is reconnecting very fast and the state transitions
> are not observed by the current approach.
> 
> So instead trying to monitor the state changes, let's just wait for the
> live state and the correct queue number.
> 
> As queue count is depending on the number of online CPUs we explicitly
> use 1 and 2 for the max_queue count. This means the queue_count value
> needs to reach either 2 or 3 (admin queue included).
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/048 | 35 ++++++++++++++++++++++++-----------
>   1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/tests/nvme/048 b/tests/nvme/048
> index 81084f0440c2..3dc5169132de 100755
> --- a/tests/nvme/048
> +++ b/tests/nvme/048
> @@ -42,6 +42,26 @@ nvmf_wait_for_state() {
>   	return 0
>   }
>   
> +nvmf_wait_for_queue_count() {
> +	local subsys_name="$1"
> +	local queue_count="$2"
> +	local nvmedev
> +
> +	nvmedev=$(_find_nvme_dev "${subsys_name}")
> +
> +	queue_count_file="/sys/class/nvme-fabrics/ctl/${nvmedev}/queue_count"
> +
> +	nvmf_wait_for_state "${subsys_name}" "live" || return 1
> +
> +	queue_count=$((queue_count + 1))
> +	if grep -q "${queue_count}" "${queue_count_file}"; then
> +		return 0
> +	fi
> +
> +	echo "expected queue count ${queue_count} not set"
> +	return 1
> +}
> +
>   set_nvmet_attr_qid_max() {
>   	local nvmet_subsystem="$1"
>   	local qid_max="$2"
> @@ -56,10 +76,7 @@ set_qid_max() {
>   	local qid_max="$3"
>   
>   	set_nvmet_attr_qid_max "${subsys_name}" "${qid_max}"
> -
> -	# Setting qid_max forces a disconnect and the reconntect attempt starts
> -	nvmf_wait_for_state "${subsys_name}" "connecting" || return 1
> -	nvmf_wait_for_state "${subsys_name}" "live" || return 1
> +	nvmf_wait_for_queue_count "${subsys_name}" "${qid_max}" || return 1

Why not simply wait for live? The connecting is obviously racy...

>   
>   	return 0
>   }
> @@ -77,12 +94,8 @@ test() {
>   
>   	_setup_nvmet
>   
> -	hostid="$(uuidgen)"
> -	if [ -z "$hostid" ] ; then
> -		echo "uuidgen failed"
> -		return 1
> -	fi
> -	hostnqn="nqn.2014-08.org.nvmexpress:uuid:${hostid}"
> +	hostid="${def_hostid}"
> +	hostnqn="${def_hostnqn}"
>   
>   	truncate -s "${nvme_img_size}" "${file_path}"
>   
> @@ -103,7 +116,7 @@ test() {
>   			echo FAIL
>   		else
>   			set_qid_max "${port}" "${subsys_name}" 1 || echo FAIL
> -			set_qid_max "${port}" "${subsys_name}" 128 || echo FAIL
> +			set_qid_max "${port}" "${subsys_name}" 2 || echo FAIL
>   		fi
>   
>   		_nvme_disconnect_subsys "${subsys_name}"

