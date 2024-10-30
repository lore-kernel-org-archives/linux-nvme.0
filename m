Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1CBD7495E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 07:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5A+WoaD6hNf9aS+eLZsHQ70N8/STdtSx7gdhbn1wW/s=; b=CFmyx0mBTP9iNqV/AQEWgzhcAL
	R0ppyt7gkXePUg7b0DL04fS2/4MMQHT+8o2UFvX+eOpV3gjhyPu9J16vJK2FdLZWGPB9B9FAOhdua
	9ySHt+Gv6E7jzDK1fVKGD4hKFWUoMPe5EYm4CwGWzH8bNnnLlR3Gjws1FoPLB0faxkYcM4rt6Cyo3
	kqbChZGxeOH6QCXO67kkyYvrbMTE7GjQ6unwFauWnEIEO7D33PdBEmIbKIWqrYk9lhesPpNYWkPZm
	z/qj4JjmIiZEyi1PdI1FIZRM69bqm9p6gtdTNBU9J01dPN3Sl5rrC8Vbf/bUDWzNQ9QtyN9oEZrCB
	gmTBSxdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t63C6-0000000H9QB-3M1t;
	Wed, 30 Oct 2024 07:32:42 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t632b-0000000H7nQ-1Cc0
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 07:22:57 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C64611FB86;
	Wed, 30 Oct 2024 07:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730272971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5A+WoaD6hNf9aS+eLZsHQ70N8/STdtSx7gdhbn1wW/s=;
	b=XsdF+3v2pyhpsOrsUWZrGa1h3N6iS1KZ0hJjNb1POtyIaFjANe96xsY3xuHR+HJg0a+sJN
	Q9WdkF+KxCEsnADhj1FTshZ5yuEiP7xbtcRFIwAXpjSzOmign+tlCiYuDVD9PLIgBnvJc/
	mDlW/Ll04RlFwAjE+uQ8ft00N2by5BI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730272971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5A+WoaD6hNf9aS+eLZsHQ70N8/STdtSx7gdhbn1wW/s=;
	b=m3TJy1FwJYOW4f1Iq6QghG6zrZD3uzfE1XKKUsH4+XinOlzRCZqgV7h0ldNs8bq0LLrwIs
	9bxkK0x2WUEAWLCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730272971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5A+WoaD6hNf9aS+eLZsHQ70N8/STdtSx7gdhbn1wW/s=;
	b=XsdF+3v2pyhpsOrsUWZrGa1h3N6iS1KZ0hJjNb1POtyIaFjANe96xsY3xuHR+HJg0a+sJN
	Q9WdkF+KxCEsnADhj1FTshZ5yuEiP7xbtcRFIwAXpjSzOmign+tlCiYuDVD9PLIgBnvJc/
	mDlW/Ll04RlFwAjE+uQ8ft00N2by5BI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730272971;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5A+WoaD6hNf9aS+eLZsHQ70N8/STdtSx7gdhbn1wW/s=;
	b=m3TJy1FwJYOW4f1Iq6QghG6zrZD3uzfE1XKKUsH4+XinOlzRCZqgV7h0ldNs8bq0LLrwIs
	9bxkK0x2WUEAWLCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3B5D13AD9;
	Wed, 30 Oct 2024 07:22:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gvrOJcveIWe0fgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 30 Oct 2024 07:22:51 +0000
Message-ID: <fd1cdb1e-16c4-47d3-8547-6445dfdbff5a@suse.de>
Date: Wed, 30 Oct 2024 08:22:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2 05/13] nvme/{rc,002,016,017,030}: pass port ID
 to genctr helper functions
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
 <20241030065149.2297405-6-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20241030065149.2297405-6-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_002253_505822_F3F2767D 
X-CRM114-Status: GOOD (  18.63  )
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

On 10/30/24 07:51, Shin'ichiro Kawasaki wrote:
> Commit "nvme: sanitize transport parameter in _create_nvmet_port()"
> introduced wwnn and wwpn calculation based on port ID for fc transport.
> This means that --traddr and --host-traddr options for "nvme discover"
> command should reflect the port ID. This change was missing for the
> genctr, or Generation Counter, related helper functions and it made
> the test case nvme/030 fail.
> 
> To avoid the failure, pass the port ID to the genctr related helper
> functions and reflect the port ID for fc transport.
> 
> Reviewed-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>   tests/nvme/002 |  3 ++-
>   tests/nvme/016 |  3 ++-
>   tests/nvme/017 |  3 ++-
>   tests/nvme/030 | 13 ++++++++-----
>   tests/nvme/rc  | 18 +++++++++++-------
>   5 files changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/tests/nvme/002 b/tests/nvme/002
> index e5b751d..b87570a 100755
> --- a/tests/nvme/002
> +++ b/tests/nvme/002
> @@ -39,7 +39,8 @@ test() {
>   		_add_nvmet_subsys_to_port "${port}" "blktests-subsystem-$i"
>   	done
>   
> -	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
> +	genctr=$(_check_genctr "${genctr}" "$port" \
> +			       "adding a subsystem to a port")
>   
>   	for ((i = iterations - 1; i >= 0; i--)); do
>   		_remove_nvmet_subsystem_from_port "${port}" "blktests-subsystem-$i"
> diff --git a/tests/nvme/016 b/tests/nvme/016
> index 8ab9d22..13d2c46 100755
> --- a/tests/nvme/016
> +++ b/tests/nvme/016
> @@ -41,7 +41,8 @@ test() {
>   	port="$(_create_nvmet_port)"
>   	_add_nvmet_subsys_to_port "$port" "${def_subsysnqn}"
>   
> -	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
> +	genctr=$(_check_genctr "${genctr}" "$port" \
> +			       "adding a subsystem to a port")
>   
>   	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
>   	_remove_nvmet_port "${port}"
> diff --git a/tests/nvme/017 b/tests/nvme/017
> index dd302fc..10ee38c 100755
> --- a/tests/nvme/017
> +++ b/tests/nvme/017
> @@ -42,7 +42,8 @@ test() {
>   	port="$(_create_nvmet_port)"
>   	_add_nvmet_subsys_to_port "${port}" "${def_subsysnqn}"
>   
> -	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
> +	genctr=$(_check_genctr "${genctr}" "$port" \
> +			       "adding a subsystem to a port")
>   
>   	_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
>   	_remove_nvmet_port "${port}"
> diff --git a/tests/nvme/030 b/tests/nvme/030
> index 1ba1274..596e411 100755
> --- a/tests/nvme/030
> +++ b/tests/nvme/030
> @@ -35,26 +35,29 @@ test() {
>   	_add_nvmet_subsys_to_port "${port}" "${subsys}1"
>   	_create_nvmet_host "${subsys}1" "${def_hostnqn}"
>   
> -	genctr=$(_discovery_genctr)
> +	genctr=$(_discovery_genctr "$port")
>   
>   	_create_nvmet_subsystem --subsysnqn "${subsys}2" \
>   				--blkdev "$(losetup -f)"
>   	_add_nvmet_subsys_to_port "${port}" "${subsys}2"
>   
> -	genctr=$(_check_genctr "${genctr}" "adding a subsystem to a port")
> +	genctr=$(_check_genctr "${genctr}" "$port" \
> +			       "adding a subsystem to a port")
>   
>   	_add_nvmet_allow_hosts "${subsys}2" "${def_hostnqn}"
>   
> -	genctr=$(_check_genctr "${genctr}" "adding host to allow_hosts")
> +	genctr=$(_check_genctr "${genctr}" "$port" "adding host to allow_hosts")
>   
>   	_remove_nvmet_allow_hosts "${subsys}2" "${def_hostnqn}"
>   
> -	genctr=$(_check_genctr "${genctr}" "removing host from allow_hosts")
> +	genctr=$(_check_genctr "${genctr}" "$port" \
> +			       "removing host from allow_hosts")
>   
>   	_remove_nvmet_subsystem_from_port "${port}" "${subsys}2"
>   	_remove_nvmet_subsystem "${subsys}2"
>   
> -	genctr=$(_check_genctr "${genctr}" "removing a subsystem from a port")
> +	genctr=$(_check_genctr "${genctr}" "$port" \
> +			       "removing a subsystem from a port")
>   
>   	_remove_nvmet_subsystem_from_port "${port}" "${subsys}1"
>   	_remove_nvmet_subsystem "${subsys}1"
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 5b4629d..64a31e0 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -222,15 +222,16 @@ _nvme_calc_rand_io_size() {
>   
>   _nvme_discover() {
>   	local trtype="$1"
> -	local traddr="${2:-$def_traddr}"
> -	local host_traddr="${3:-$def_host_traddr}"
> -	local trsvcid="${3:-$def_trsvcid}"
> +	local port="$2"
> +	local traddr="$def_traddr"
> +	local trsvcid="$def_trsvcid"
>   
>   	ARGS=(--transport "${trtype}")
>   	ARGS+=(--hostnqn="${def_hostnqn}")
>   	ARGS+=(--hostid="${def_hostid}")
>   	if [[ "${trtype}" = "fc" ]]; then
> -		ARGS+=(--traddr "${traddr}" --host-traddr "${host_traddr}")
> +		ARGS+=(--traddr "$(_fc_traddr "$port")")
> +		ARGS+=(--host-traddr "$(_fc_host_traddr "$port")")
>   	elif [[ "${trtype}" != "loop" ]]; then
>   		ARGS+=(--traddr "${traddr}" --trsvcid "${trsvcid}")
>   	fi
> @@ -463,16 +464,19 @@ _nvmet_passthru_target_cleanup() {
>   }
>   
>   _discovery_genctr() {
> -	_nvme_discover "${nvme_trtype}" |
> +	local port=${1}
> +
> +	_nvme_discover "${nvme_trtype}" "${port}" |
>   		sed -n -e 's/^.*Generation counter \([0-9]\+\).*$/\1/p'
>   }
>   
>   _check_genctr() {
>   	local last=$1
> -	local msg=$2
> +	local port=$2
> +	local msg=$3
>   	local genctr
>   
> -	genctr=$(_discovery_genctr)
> +	genctr=$(_discovery_genctr "$port")
>   	if (( "${genctr}" <= "${last}" )); then
>   		echo "Generation counter not incremented when ${msg} (${genctr} <= ${last})"
>   	fi
See my comments for the previous patch regarding local wwpn/wwnn setup.
Otherwise looks fine.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

