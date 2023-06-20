Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981D6EB64D7
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jun 2023 14:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HHDvUdN+oRU2iMEgn1t7pRaNmxE6JGuZWiNo/5GWyY4=; b=kdOFGjFscBjY7N+9OSTXmd1Lm8
	wGnMrqmrHphEJCetD/m3BymYAev4OppsmLLXR8mBY5uY/j7+jxgbsNKMfga2vRwfRsdmgVzHMyLHy
	+nTCjEQWH17TNJOy+BaWoOnEXu+ScO4HovysFvzj5OOhB6+FLxf6F/A0bOo7glaLSSPbMoTpItDQS
	9IijCzABBupzYNVyA1oa7a9O5ozJinQYvNJHVqmZzFnsvl/7sbLC6xdiki6xMNu0+WXszaLHuQkLB
	JUE9k2X1Xvknc2tYpvWcHnoRZuPCa7+Z1Qy/3ID8FP9lBe7tdjNPg88fJLUWzvopTNdiqgETtH7cC
	nOOTkYiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qBc1T-00BUkP-1I;
	Tue, 20 Jun 2023 14:07:55 +0000
Received: from mail-wm1-f44.google.com ([209.85.128.44])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qBc1P-00BUjT-2j
	for linux-nvme@lists.infradead.org;
	Tue, 20 Jun 2023 14:07:53 +0000
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-3f99aa36d18so6278355e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 20 Jun 2023 07:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270066; x=1689862066;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HHDvUdN+oRU2iMEgn1t7pRaNmxE6JGuZWiNo/5GWyY4=;
        b=GYP0tQnNnOQcBDuX2qkSnR5egYR77ucL59PJQiZP7y8asMrJBX5cuRXZGH/3wYoGOr
         dobWPRRwwKIzlm9h89YYkdMFZ/kUA8F5/JVOyqScxDlx3C6zryC78Knfsm1czeZTNWv/
         YfGwbkZCaq1S4UoP4Mxtmay9NBoDdpdK5rXbVKa894MQ9hWH/JCm2vyhfXkR2ZcW55/b
         OGGjorGAmaaLnVB9CzFcpJIZTPf3Uj3mtKytQJl04CpImXg7vsLEaScpbu6iVL3hKB5E
         Alx9J+NMyB/Dje9fyMGzFVX8+4PiC89ds3ue51YYYu2o0My1c3KD3jbiR4gaDwLmACTg
         J5zw==
X-Gm-Message-State: AC+VfDw1IwcHQnXCnU3xsa7WPBUiL/nBievyYgLm5sWvucFCJSC1wzVL
	2jZaq26wYWUIDjbixgFJBL0=
X-Google-Smtp-Source: ACHHUZ6piCilQNu/uvBXQjuiMjhYHBZ+tN2L+h9TcYR7FRPajQG6f85LOzKioBcz99YGAe6CKWcu1A==
X-Received: by 2002:a05:600c:6349:b0:3f9:b3f9:fac4 with SMTP id du9-20020a05600c634900b003f9b3f9fac4mr3677814wmb.1.1687270066361;
        Tue, 20 Jun 2023 07:07:46 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003f7e4d143cfsm2453909wmi.15.2023.06.20.07.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 07:07:45 -0700 (PDT)
Message-ID: <af640019-b867-d488-0443-797a75ba4195@grimberg.me>
Date: Tue, 20 Jun 2023 17:07:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH blktests v1 2/3] nvme/rc: Avoid triggering host nvme-cli
 autoconnect
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chaitanya Kulkarni <kch@nvidia.com>,
 Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
 Hannes Reinecke <hare@suse.de>, James Smart <jsmart2021@gmail.com>,
 Martin Belanger <Martin.Belanger@dell.com>
References: <20230620132703.20648-1-dwagner@suse.de>
 <20230620132703.20648-3-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230620132703.20648-3-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230620_070751_889953_EA7EFF17 
X-CRM114-Status: GOOD (  20.73  )
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


> When the host has enabled the udev/systemd autoconnect services for the
> fc transport it interacts with blktests and make tests break.
> 
> nvme-cli learned to ignore connects attemps when using the
> --context command line option paired with a volatile configuration. Thus
> we can mark all the resources created by blktests and avoid any
> interaction with the systemd autoconnect scripts.

Hmm... is this hapenning with non-fc as well?

> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   tests/nvme/rc | 73 ++++++++++++++++++++++++++++++++++++++++++++-------
>   1 file changed, 63 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 191f3e2e0c43..00117d314a38 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -14,8 +14,8 @@ def_remote_wwnn="0x10001100aa000001"
>   def_remote_wwpn="0x20001100aa000001"
>   def_local_wwnn="0x10001100aa000002"
>   def_local_wwpn="0x20001100aa000002"
> -def_hostnqn="$(cat /etc/nvme/hostnqn 2> /dev/null)"
> -def_hostid="$(cat /etc/nvme/hostid 2> /dev/null)"
> +def_hostnqn="nqn.2014-08.org.nvmexpress:uuid:242d4a24-2484-4a80-8234-d0169409c5e8"
> +def_hostid="242d4a24-2484-4a80-8234-d0169409c5e8"
>   nvme_trtype=${nvme_trtype:-"loop"}
>   nvme_img_size=${nvme_img_size:-"1G"}
>   nvme_num_iter=${nvme_num_iter:-"1000"}
> @@ -161,6 +161,50 @@ _nvme_calc_rand_io_size() {
>   	echo "${io_size_kb}k"
>   }
>   
> +_nvme_cli_supports_context() {
> +	if ! nvme connect --help 2>&1 | grep -q context > /dev/null; then
> +		    return 1
> +	fi
> +	return 0
> +}

Not a great way to check support.

> +
> +_setup_nvme_cli() {
> +	if ! _nvme_cli_supports_context; then
> +		return
> +	fi
> +
> +	mkdir -p /run/nvme
> +	cat >> /run/nvme/blktests.json <<-EOF
> +	[
> +	  {
> +	    "hostnqn": "${def_hostnqn}",
> +	    "hostid": "${def_hostid}",
> +	    "subsystems": [
> +	      {
> +	        "application": "blktests",
> +	        "nqn": "blktests-subsystem-1",
> +	        "ports": [
> +	          {
> +	            "transport": "fc",
> +	            "traddr": "nn-${def_remote_wwnn}:pn-${def_remote_wwpn}",
> +	            "host_traddr": "nn-${def_local_wwnn}:pn-${def_local_wwpn}"
> +	          }
> +	        ]
> +	      }
> +	    ]
> +	  }
> +	]
> +	EOF
> +}
> +
> +_cleanup_nvme_cli() {
> +	if ! _nvme_cli_supports_context; then
> +		return
> +	fi
> +
> +	rm -f /run/nvme/blktests.json
> +}
> +
>   _nvme_fcloop_add_rport() {
>   	local local_wwnn="$1"
>   	local local_wwpn="$2"
> @@ -235,6 +279,8 @@ _cleanup_fcloop() {
>   	_nvme_fcloop_del_lport "${local_wwnn}" "${local_wwpn}"
>   	_nvme_fcloop_del_rport "${local_wwnn}" "${local_wwpn}" \
>   			       "${remote_wwnn}" "${remote_wwpn}"
> +
> +	_cleanup_nvme_cli
>   }
>   
>   _cleanup_nvmet() {
> @@ -337,6 +383,8 @@ _setup_nvmet() {
>   		def_host_traddr=$(printf "nn-%s:pn-%s" \
>   					 "${def_local_wwnn}" \
>   					 "${def_local_wwpn}")
> +
> +		_setup_nvme_cli
>   	fi
>   }
>   
> @@ -436,18 +484,18 @@ _nvme_connect_subsys() {
>   	trtype="$1"
>   	subsysnqn="$2"
>   
> -	ARGS=(-t "${trtype}" -n "${subsysnqn}")
> +	ARGS=(-t "${trtype}"
> +	      -n "${subsysnqn}"
> +	      --hostnqn="${hostnqn}"
> +	      --hostid="${hostid}")
> +	if _nvme_cli_supports_context; then
> +		ARGS+=(--context="blktests")
> +	fi
>   	if [[ "${trtype}" == "fc" ]] ; then
>   		ARGS+=(-a "${traddr}" -w "${host_traddr}")
>   	elif [[ "${trtype}" != "loop" ]]; then
>   		ARGS+=(-a "${traddr}" -s "${trsvcid}")
>   	fi
> -	if [[ "${hostnqn}" != "$def_hostnqn" ]]; then
> -		ARGS+=(--hostnqn="${hostnqn}")
> -	fi
> -	if [[ "${hostid}" != "$def_hostid" ]]; then
> -		ARGS+=(--hostid="${hostid}")
> -	fi
>   	if [[ -n "${hostkey}" ]]; then
>   		ARGS+=(--dhchap-secret="${hostkey}")
>   	fi
> @@ -482,7 +530,12 @@ _nvme_discover() {
>   	local host_traddr="${3:-$def_host_traddr}"
>   	local trsvcid="${3:-$def_trsvcid}"
>   
> -	ARGS=(-t "${trtype}")
> +	ARGS=(-t "${trtype}"
> +	      --hostnqn="${def_hostnqn}"
> +	      --hostid="${def_hostid}")
> +	if _nvme_cli_supports_context; then
> +		ARGS+=(--context="blktests")
> +	fi
>   	if [[ "${trtype}" = "fc" ]]; then
>   		ARGS+=(-a "${traddr}" -w "${host_traddr}")
>   	elif [[ "${trtype}" != "loop" ]]; then

