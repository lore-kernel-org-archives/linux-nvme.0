Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D25D0C61B
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z5PpS6ja80/wdAfTbv8heGf4UjE1pOTA5r+ID5JGgV8=; b=ilulgNGnDoj/vGP5rQ4EZxJrLT
	KgMefVXMgRl5fHklrE2UoiNbYBj1kuxfmtLHbeUxExVCZwIfrS0hsOG1kQfxu64glN6GmbLEOjmlg
	LBY2E4z3Jxc45rXFx42EwN9YHkaKmypdjt/heN2hrMS5mkXtDpQNYEdyCPhGysJyIpDJEUAHmAe0S
	guspBra/E+SEUi9vMQZueyRkYLmjAKlEIAw71pVRMWRaMW4iXEuZ5jv6uVm67Lp1a6IMGy+9GFi30
	V9ebnuHBMeCLtBkO0yJXa7aqLphz47LCZC6EA4DWsyN0iZ7fIvrBTgz+qduAVkpcCzZb6DE0gmUE+
	gUXXi5lw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4LaD-000000044cf-1uQ5;
	Fri, 25 Oct 2024 14:46:33 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4LUS-000000043Cx-0G5Q
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 14:40:41 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3B6EA1F7F5;
	Fri, 25 Oct 2024 14:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729867234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5PpS6ja80/wdAfTbv8heGf4UjE1pOTA5r+ID5JGgV8=;
	b=Id5iXNylHuPebxgo4jBJZGbLlbHjSsVwwg8t91nvMW60z3Grr/nTm3rA+2lcUonO3iUlmU
	k4psAsWrXnn8+XbMzKriib8AhigcuTk7lxPVYYCWu+QCe8Py/zK+AyA84Vjc7Gp21Io3/0
	sCi6B56ZHXZ1z0UskIc+e7ARuzpKIQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729867234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5PpS6ja80/wdAfTbv8heGf4UjE1pOTA5r+ID5JGgV8=;
	b=vjuorMhkeo4c374mvOd4gnaW2mDq+Cmsgd42oSAqVVJQYb4ftlAwtUDtrBR6+c9Q6XcczU
	2bzzuXveL5rTv6DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Id5iXNyl;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vjuorMhk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729867234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5PpS6ja80/wdAfTbv8heGf4UjE1pOTA5r+ID5JGgV8=;
	b=Id5iXNylHuPebxgo4jBJZGbLlbHjSsVwwg8t91nvMW60z3Grr/nTm3rA+2lcUonO3iUlmU
	k4psAsWrXnn8+XbMzKriib8AhigcuTk7lxPVYYCWu+QCe8Py/zK+AyA84Vjc7Gp21Io3/0
	sCi6B56ZHXZ1z0UskIc+e7ARuzpKIQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729867234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5PpS6ja80/wdAfTbv8heGf4UjE1pOTA5r+ID5JGgV8=;
	b=vjuorMhkeo4c374mvOd4gnaW2mDq+Cmsgd42oSAqVVJQYb4ftlAwtUDtrBR6+c9Q6XcczU
	2bzzuXveL5rTv6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22089136F5;
	Fri, 25 Oct 2024 14:40:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hQHyBeKtG2fwXwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Oct 2024 14:40:34 +0000
Date: Fri, 25 Oct 2024 16:40:33 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 09/15] nvme: check for controller device in
 _nvme_connect_subsys()
Message-ID: <82cad6a8-c249-445e-9836-f9c234add172@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-10-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024010025.2216242-10-shinichiro.kawasaki@wdc.com>
X-Rspamd-Queue-Id: 3B6EA1F7F5
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_074036_283715_4F54C47E 
X-CRM114-Status: GOOD (  19.30  )
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

On Thu, Oct 24, 2024 at 10:00:19AM GMT, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> When calling 'nvme connect' we cannot assume that a namespace is
> always present (eg if connecting to a discovery service), so better
> check for the controller device to ensure that 'nvme connect' has
> succeeded.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> [Shin'ichiro: fixed _nvme_connect_subsys() return for no_wait case]
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  common/nvme | 37 ++++++++++++++++++-------------------
>  1 file changed, 18 insertions(+), 19 deletions(-)
> 
> diff --git a/common/nvme b/common/nvme
> index 758df33..fa64ad4 100644
> --- a/common/nvme
> +++ b/common/nvme
> @@ -373,17 +373,20 @@ _nvme_connect_subsys() {
>  	if [[ -n "${ctrl_loss_tmo}" ]]; then
>  		ARGS+=(--ctrl-loss-tmo="${ctrl_loss_tmo}")
>  	fi
> +	ARGS+=(-o json)
> +	connect=$(nvme connect "${ARGS[@]}" 2> /dev/null)
>  
> -	nvme connect "${ARGS[@]}" 2> /dev/null | grep -v "connecting to device:"
> -
> -	# Wait until device file and uuid/wwid sysfs attributes get ready for
> -	# all namespaces.
> +	# Wait until device file and sysfs attributes get ready
>  	if [[ ${no_wait} = false ]]; then
> +		local ctrldev
> +
> +		ctrldev=$(echo "${connect}"  | sed -n 's/.*device.:.\(nvme[0-9]*\)./\1/p')
>  		udevadm settle
>  		for ((i = 0; i < 10; i++)); do
> -			_nvme_ns_ready "${subsysnqn}" && return
> +			_nvme_ctrl_ready "${ctrldev}" "${subsysnqn}" && return 0
>  			sleep .1
>  		done
> +		return 1
>  	fi
>  }
>  
> @@ -408,21 +411,17 @@ _nvme_disconnect_subsys() {
>  }
>  
>  
> -_nvme_ns_ready() {
> -	local subsysnqn="${1}"
> -	local ns_path ns_id dev
> -	local cfs_path="${NVMET_CFS}/subsystems/$subsysnqn"
> +_nvme_ctrl_ready() {
> +	local ctrldev="${1}"
> +	local subsysnqn="${2:-$def_subsysnqn}"
> +	local ctrlpath="/sys/class/nvme/${ctrldev}"
>  
> -	dev=$(_find_nvme_dev "$subsysnqn")
> -	for ns_path in "${cfs_path}/namespaces/"*; do
> -		ns_id=${ns_path##*/}
> -		if [[ ! -b /dev/${dev}n${ns_id} ||
> -			   ! -e /sys/block/${dev}n${ns_id}/uuid ||
> -			   ! -e /sys/block/${dev}n${ns_id}/wwid ]]; then
> -			return 1

IIRC, the uuid/wwid test were originally from nvme/004 and copied to the
other test. When we refactored we moved the uuid/wwid here. I suggest we
add this part back to nvme/004 so that we don't loose this test case.

