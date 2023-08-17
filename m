Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17239C27C7A
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Aug 2023 08:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3x3CNCzNbxZSHDixFhOmVHdfhj5Iy+BRTqOQe78zlpw=; b=WbD3LwrtR8L648yPQ0XpBIk0nx
	7ay2tfmlcIsGRzkDn6canrGlXV2nzHCAWNtXAvRqEpaQvD0ToBak1jXqKQDgSJtjjU5hHedi8Zo4M
	GxhWOrwxJVYtz5ZSnzwplWS78b9Hi/bGgey7oXrlITxKivxz8xSEnpFncc8BlZusdIBKDQaGEAt60
	4mtRCxeA4EjbXfmn3wpCYF3fkZgu8mNAUVvNlkxNO6HXupkjyscK79DXRlNM+IJMG+3Xqy1dRW6zd
	hQ8kYRF5NH6ovlBf827aGcUdiLAGgakF7zMfPWJ1aHsAVFKD6NLK77y0EteamaCCZ6ONracsllwVD
	To1LK1nA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWYNy-005pCg-34;
	Thu, 17 Aug 2023 08:29:42 +0000
Received: from mail-wm1-f49.google.com ([209.85.128.49])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWYNw-005pA5-2p
	for linux-nvme@lists.infradead.org;
	Thu, 17 Aug 2023 08:29:42 +0000
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3fe247796ccso17523265e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 17 Aug 2023 01:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692260977; x=1692865777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3x3CNCzNbxZSHDixFhOmVHdfhj5Iy+BRTqOQe78zlpw=;
        b=k57I5tNyrAcF/Dl+e/VUtx0p7y4saivCJiKnQec3Izbv9BrtAciOeG3lHpTB+EJD4L
         mTe75Gn21VRP87S/V1AtOhjY7aQtLjw5gU076nPfT9qWUluZpRh7s88CCGYYgBX4U1J7
         tVliAbuwoTz6gHo5wXIH3IdPKLdx3TMu0ZoLlsX8iOXA4Z3iK/KD7TbcZQHS0/OloLu+
         YDwq69mQ3XSC3rTtAhAkjtg079YkwIoFMS3a3lTfbolhCnXS9EON78tLFkknMj1SIAPr
         bPuJnyBInXDTRIdMmJ9UuRaLcQEPFF94YYCh52y3VFCYckGR0bF0Q3ATrd4IfYIRG75Y
         aS/A==
X-Gm-Message-State: AOJu0YwbyuFAT9jCIlBr8Nw4fWuf4CeK/Btv6pLgWBRrLA2gGHaR68TR
	BHVnOtbcNDNsrEqKkoVlZn21ieLBxtQ=
X-Google-Smtp-Source: AGHT+IGWXhy4lbi7okPqXciO9hZc0y73nSU63Nuqr+nAoHQh83TSV/4sjOZaERQ5EX0fQ2cEmgnGUA==
X-Received: by 2002:a05:600c:474e:b0:3fa:9767:bb0 with SMTP id w14-20020a05600c474e00b003fa97670bb0mr3348206wmo.0.1692260977416;
        Thu, 17 Aug 2023 01:29:37 -0700 (PDT)
Received: from [192.168.64.157] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id k22-20020a7bc416000000b003fe11148055sm2072515wmi.27.2023.08.17.01.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 01:29:36 -0700 (PDT)
Message-ID: <85f074cd-d916-2baf-36bc-05a19384dcce@grimberg.me>
Date: Thu, 17 Aug 2023 11:29:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH blktests v2 1/2] nvme/rc: fix nvme device readiness check
 after _nvme_connect_subsys
Content-Language: en-US
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: Yi Zhang <yi.zhang@redhat.com>, Daniel Wagner <dwagner@suse.de>,
 Bart Van Assche <bvanassche@acm.org>
References: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230817073021.3674602-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230817_012940_912134_B3DAEA85 
X-CRM114-Status: GOOD (  31.25  )
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



On 8/17/23 10:30, Shin'ichiro Kawasaki wrote:
> The helper function _nvme_connect_subsys() creates a nvme device. It may
> take some time after the function call until the device gets ready for
> I/O. So it is expected that the test cases call _find_nvme_dev() after
> _nvme_connect_subsys() before I/O. _find_nvme_dev() returns the path of
> the created device, and it also waits for uuid and wwid sysfs attributes
> of the created device get ready. This wait works as the wait for the
> device I/O readiness.
> 
> However, this wait by _find_nvme_dev() has two problems. The first
> problem is missing call of _find_nvme_dev(). The test case nvme/047
> calls _nvme_connect_subsys() twice, but _find_nvme_dev() is called only
> for the first _nvme_connect_subsys() call. This causes too early I/O to
> the device with tcp transport [1]. Fix this by moving the wait for the
> device readiness from _find_nvme_dev() to _nvme_connect_subsys(). Also
> add --wait-for option to _nvme_connect_subsys(). It allows to skip the
> wait in _nvmet_passthru_target_connect() which has its own wait for
> device readiness.
> 
> The second problem is wrong paths for the sysfs attributes. The paths
> do not include namespace index, so the check for the attributes always
> fail. Still _find_nvme_dev() does 1 second wait and allows the device
> get ready for I/O in most cases, but this is not intended behavior.
> Fix the paths by adding the namespace index.
> 
> On top of the checks for sysfs attributes, add 'udevadm settle' and a
> check for the created device file. These ensures that the create device
> is ready for I/O.
> 
> [1] https://lore.kernel.org/linux-block/CAHj4cs9GNohGUjohNw93jrr8JGNcRYC-ienAZz+sa7az1RK77w@mail.gmail.com/
> 
> Fixes: c766fccf3aff ("Make the NVMe tests more reliable")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> Changes from v1:
> * Added --wait-for option to _nvme_connect_subsys()
> * Added 'udevadm settle' before readiness check
> 
>   tests/nvme/rc | 31 +++++++++++++++++++++++--------
>   1 file changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 0b964e9..797483e 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -428,6 +428,8 @@ _nvme_connect_subsys() {
>   	local keep_alive_tmo=""
>   	local reconnect_delay=""
>   	local ctrl_loss_tmo=""
> +	local wait_for="ns"
> +	local dev i
>   
>   	while [[ $# -gt 0 ]]; do
>   		case $1 in
> @@ -483,6 +485,10 @@ _nvme_connect_subsys() {
>   				ctrl_loss_tmo="$2"
>   				shift 2
>   				;;
> +			--wait-for)
> +				wait_for="$2"
> +				shift 2
> +				;;

I think that it would make better since to reverse the polarity
here.

connect always wait, and tests that actually want to
do some fast stress will choose --nowait.

>   			*)
>   				positional_args+=("$1")
>   				shift
> @@ -532,6 +538,21 @@ _nvme_connect_subsys() {
>   	fi
>   
>   	nvme connect "${ARGS[@]}" 2> /dev/null
> +
> +	# Wait until device file and uuid/wwid sysfs attributes get ready for
> +	# namespace 1.
> +	if [[ ${wait_for} == ns ]]; then
> +		udevadm settle
> +		dev=$(_find_nvme_dev "$subsysnqn")
> +		for ((i = 0; i < 10; i++)); do
> +			if [[ -b /dev/${dev}n1 &&
> +				      -e /sys/block/${dev}n1/uuid &&
> +				      -e /sys/block/${dev}n1/wwid ]]; then
> +				return

What happens if the subsystem does not have any namespaces?
Or what about other namesapces?

Won't it make more sense to inspect the subsys for
expected ns and wait for all?

