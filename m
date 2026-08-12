Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12419C5AD5A
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Aug 2026 19:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jF5vEdjS6Gt9lpkiWy9qRTwoSpjzvZgLsdsLNZ6YZOk=; b=Be8RQLzgzcW642XKA065Z7LcdK
	++aBQEpVB8B5UFDAq/MLh3SvXiq35XNUJp+Pe9wr+HUetI7aFMlqiIKsuMm37NEWUPXaXgPi+GgKc
	f2N4JklCfBB4WdMlAHN/+2joPpscnet1nL4TWug63+qdlwu924OMIB5i6oB3dAlu39YEn7EIvJCLp
	8c0jo+7P6ZirO68api+iRq4/ROhwHAHCo3nVYBwv5O9NWV66hPF9unRQcWBqxrPCJjxuZZpyFWOkC
	wAQuURWdcGxEKaLDPH9Aj85oBZYlOX+K2Kc4Ilo6gntt4jAtqLg4xQrlVHn49dBwCBx9dCzyPqnes
	EcMro9RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuEFo-0000000Gqnt-1Bb4;
	Wed, 12 Aug 2026 19:04:44 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuEFk-0000000GqnS-3qKz
	for linux-nvme@lists.infradead.org;
	Wed, 12 Aug 2026 19:04:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786561476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jF5vEdjS6Gt9lpkiWy9qRTwoSpjzvZgLsdsLNZ6YZOk=;
	b=MyVUdGwmBSu/3nESIHKIARMw0eKVeuiXEWvkjFRZI6NzW/ml4EMAmFYpSsQUkPx1LV4fHc
	LNLCOq4Fm8YXwnBUulrM3VkPgL8HoB5nTXVNu8O5gMo4u1LVZYtNR0rm+Zt50ffhXdeT/i
	g1oUJXIdCQ699fQ2s4+qLjt1uOAKGfA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-RtfgM6IpO3SRgaedx1ldpg-1; Wed,
 12 Aug 2026 15:03:03 -0400
X-MC-Unique: RtfgM6IpO3SRgaedx1ldpg-1
X-Mimecast-MFC-AGG-ID: RtfgM6IpO3SRgaedx1ldpg_1786561382
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F4E2180074B;
	Wed, 12 Aug 2026 19:03:02 +0000 (UTC)
Received: from [10.17.17.225] (unknown [10.17.17.225])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6C885195DF98;
	Wed, 12 Aug 2026 19:03:01 +0000 (UTC)
Message-ID: <29b5a54c-09ae-44c8-824a-4bf41bfb8a74@redhat.com>
Date: Wed, 12 Aug 2026 15:03:00 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests 1/2] nvme: Add _setup_nvmet_port_marginal
To: Jesse Taube <jtaubepe@redhat.com>, linux-block@vger.kernel.org
Cc: linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com,
 Daniel Wagner <dwagner@suse.de>
References: <20260812174503.3705830-1-jtaubepe@redhat.com>
 <20260812174503.3705830-2-jtaubepe@redhat.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20260812174503.3705830-2-jtaubepe@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-MFC-PROC-ID: ivYydHSsZrjsrT6AosHAq9UOz1ehDgzDMWmWdoEP5pI_1786561382
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_120441_039372_BC17E3F2 
X-CRM114-Status: GOOD (  15.22  )
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

Good job Jesse. These tests work!

Reviewed-by: John Meneghini <jmeneghi@redhat.com>
Tested-by: John Meneghini <jmeneghi@redhat.com>

On 8/12/26 13:45, Jesse Taube wrote:
> Adds functionality to set up a NVME port in marginal state.
> This is useful for testing the behavior of the NVME driver when a port
> is in a marginal state.
> 
> Signed-off-by: Jesse Taube <jtaubepe@redhat.com>
> ---
>   common/nvme | 30 ++++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 
> diff --git a/common/nvme b/common/nvme
> index f399937..d389e18 100644
> --- a/common/nvme
> +++ b/common/nvme
> @@ -153,6 +153,15 @@ _nvme_fcloop_add_tport() {
>   	echo "wwnn=${wwnn},wwpn=${wwpn}" > ${loopctl}/add_target_port
>   }
>   
> +_nvme_fcloop_set_rport_marginal() {
> +	local wwnn="$1"
> +	local wwpn="$2"
> +	local marginal="$3"
> +	local loopctl=/sys/class/fcloop/ctl
> +
> +	echo "wwnn=${wwnn},wwpn=${wwpn},marginal=${marginal}" > ${loopctl}/set_marginal_rport
> +}
> +
>   _nvme_fcloop_del_rport() {
>   	local local_wwnn="$1"
>   	local local_wwpn="$2"
> @@ -763,6 +772,27 @@ _create_nvmet_port() {
>   	echo "${port}"
>   }
>   
> +_setup_nvmet_port_marginal() {
> +	local -i port="$1"
> +	local state="${2}"
> +
> +	if [[ ! "${nvme_trtype}" == "fc" ]]; then
> +		echo "FAIL _setup_nvmet_port_marginal() only supports fc transport"
> +		exit 1
> +	fi
> +
> +	if [[ "${state}" == "live" ]]; then
> +		_nvme_fcloop_set_rport_marginal "$(_remote_wwnn $port)" \
> +					"$(_remote_wwpn $port)" 0
> +	elif [[ "${state}" == "marginal" ]]; then
> +		_nvme_fcloop_set_rport_marginal "$(_remote_wwnn $port)" \
> +					"$(_remote_wwpn $port)" 1
> +	else
> +		echo "FAIL _setup_nvmet_port_marginal() invalid state: ${state}"
> +		exit 1
> +	fi
> +}
> +
>   _setup_nvmet_port_ana() {
>   	local port="$1"
>   	local anagrpid="${2:-$def_anagrpid}"


