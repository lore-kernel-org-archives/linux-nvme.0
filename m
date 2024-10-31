Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3605D767D8
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 16:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+3Q2JTQUtgrqqItIBYE8p0yRehABWfOEK0UY8FM4fNA=; b=gdRYqn102jTfecPaET6GtHRd1B
	rCT1Nla6+pvegzM0LAKTYlATZiE0gMUrQZyRG/FcmZkRdDrXBFuaQ0CuyW5PGXixYLHDCcmoEf+Vw
	EgD9MNiACLnUng1KIy22cBxDNmd/sEOkp2QLhreZRVWsnOtQ+Wqjg+DytcKbxRzfJVFuDTIW4Aa1c
	t9pbZq1aFUhjED+EVGyCqw5fsj5dKq6iY6ouCn9i8AH0S6Tde87F1b2QQAfLcvwmcWnXpqvd9Dqg6
	iGP5dCZbLvSgnYyghOhZNJ99dUudW/Yx/c16978mC5CN0MR83M+rJJuWyDdqKKf/RNtXl0gN8wyMG
	ElOiJ+hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6XnR-000000049Gw-2zHm;
	Thu, 31 Oct 2024 16:13:17 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6XjP-000000048bw-2auS
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 16:09:10 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AD6BD21CF2;
	Thu, 31 Oct 2024 16:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730390942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+3Q2JTQUtgrqqItIBYE8p0yRehABWfOEK0UY8FM4fNA=;
	b=xYR5NBf8Ut7Pgo6pCd6Nw5jJ3Nxhtbl8tKtjlmTDQAhccjwC3QibID54EQu/v6SVSMEQT/
	jiNW/A32hvBmuOIJR4w0Ak1T0BQON9C6N/jCfs6TraxzrFLUnAT4tp/G/RndEP752YhR1m
	OQJfwIsSUBJpyLrNEktJaOOaw1MCxH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730390942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+3Q2JTQUtgrqqItIBYE8p0yRehABWfOEK0UY8FM4fNA=;
	b=QL2Xn5U9VZ6VXvVjSdVTj2pEhZ/YDylcLYttyh1BlE7BVhbutL8t9iXVxKaTVkT5b8yNP5
	2jHL/3NfGDZ/ieDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1730390942; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+3Q2JTQUtgrqqItIBYE8p0yRehABWfOEK0UY8FM4fNA=;
	b=xYR5NBf8Ut7Pgo6pCd6Nw5jJ3Nxhtbl8tKtjlmTDQAhccjwC3QibID54EQu/v6SVSMEQT/
	jiNW/A32hvBmuOIJR4w0Ak1T0BQON9C6N/jCfs6TraxzrFLUnAT4tp/G/RndEP752YhR1m
	OQJfwIsSUBJpyLrNEktJaOOaw1MCxH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1730390942;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+3Q2JTQUtgrqqItIBYE8p0yRehABWfOEK0UY8FM4fNA=;
	b=QL2Xn5U9VZ6VXvVjSdVTj2pEhZ/YDylcLYttyh1BlE7BVhbutL8t9iXVxKaTVkT5b8yNP5
	2jHL/3NfGDZ/ieDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 944F113A53;
	Thu, 31 Oct 2024 16:09:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id S3HzIZ6rI2cnLwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 31 Oct 2024 16:09:02 +0000
Date: Thu, 31 Oct 2024 17:09:01 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v2 11/13] common/nvme, nvme/003: specify "--port
 none" to _nvme_connect_subsys()
Message-ID: <b23b8793-e15e-4e0c-81f5-c00ce1c1ede5@flourine.local>
References: <20241030065149.2297405-1-shinichiro.kawasaki@wdc.com>
 <20241030065149.2297405-12-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030065149.2297405-12-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_090907_838286_B786B94A 
X-CRM114-Status: GOOD (  19.68  )
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

On Wed, Oct 30, 2024 at 03:51:47PM GMT, Shin'ichiro Kawasaki wrote:
> Commit "nvme: pass in port parameter to _nvme_connect_subsys()"
> introduced the --port argument to _nvme_connect_subsys(). If the option
> is not specified, _nvme_connect_subsys() automatically finds the port
> for the specified subsysnqn. However, this does not work for the test
> case nvme/003, since the test case connects to the subsys for discovery,
> then, the port of the created subsysnqn is not to be used. This causes
> the failure of the test case.
> 
> To avoid the failure, modify _nvme_connect_subsys() to take the special
> value "none" for the --port option. When "--port none" is specified,
> _nvme_connect_subsys() skips the steps to obtain port dependent
> parameters and just use default parameters.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  common/nvme    | 41 ++++++++++++++++++++++++++++++-----------
>  tests/nvme/003 |  3 ++-
>  2 files changed, 32 insertions(+), 12 deletions(-)
> 
> diff --git a/common/nvme b/common/nvme
> index 6513205..3a2bb35 100644
> --- a/common/nvme
> +++ b/common/nvme
> @@ -690,22 +690,41 @@ _get_nvmet_port_params() {
>  	local port="$1"
>  	local -n args="$2"
>  	local cfs_path="${NVMET_CFS}/ports/${port}"
> -	local trtype
> -	local traddr
> -	local trsvcid
> +	local trtype="${nvme_trtype}"
> +	local traddr="${def_traddr}"
> +	local trsvcid="${def_trsvcid}"
>  
> -	[[ -d "${cfs_path}" ]] || exit 1
> -	trtype=$(cat "${cfs_path}/addr_trtype")
> +	# When port is specified, get port dependent parameter values
> +	if [[ $port != none ]]; then
> +		[[ -d "${cfs_path}" ]] || exit 1
> +		trtype=$(cat "${cfs_path}/addr_trtype")
> +		traddr=$(cat "${cfs_path}/addr_traddr")
> +		args+=(--traddr "${traddr}")
> +		if [[ "${trtype}" == "tcp" ]] || [[ "${trtype}" == "rdma" ]]; then
> +			trsvcid=$(cat "${cfs_path}/addr_trsvcid")
> +		fi
> +	fi
> +
> +	# Prepare parameter options
>  	args+=(--transport "${trtype}")
> -	traddr=$(cat "${cfs_path}/addr_traddr")
> -	args+=(--traddr "${traddr}")
> -	if [[ "${trtype}" == "tcp" ]] || [[ "${trtype}" == "rdma" ]]; then
> -		trsvcid=$(cat "${cfs_path}/addr_trsvcid")
> +	case ${trtype} in
> +	loop)
> +		;;
> +	rdma | tcp)
> +		if [[ $port == none ]]; then
> +			args+=(--traddr "${traddr}")

Maybe make this one explicit: args+=(--traddr "${def_traddr}")

Rest looks good!

Reviewed-by: Daniel Wagner <dwagner@suse.de>

