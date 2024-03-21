Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49354C54E68
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 10:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qW8AkJgm+O3tvv+XHrSr8JvgavgYkGN+RTtxQeioiOU=; b=YM4fzNuVxF+tqdKGa6bt8tvF4v
	o1K2cTI4KYjqG5uS1yFM7kG47rpEHFlpdQQtUHwU2w/7BnT9ukICaRXApdTpcSVLP5g+L0p45dxch
	H8ynXaLj0/4tjupSxtUF1nAU6r7I38HWGG0j/1gQZoKCvfvrOEcUTQSpMfr7gNIO24w7cW9jKi+ZG
	8sgbitdxmwCUug5VtA8RujBs8kioU5jl1RtVil71onjGyaL6dNV4P1igpjlsm09fVMCp0zcgtcUoq
	fq1eSREephjKFD+XBnuItzYYE/6SptofUVQSN/nKIvsMXA+il6Ni+KYCzGep1US7LdxlITDOCh2X2
	tvHlq/4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnFWW-00000002cEB-0SGW;
	Thu, 21 Mar 2024 10:19:48 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnFWQ-00000002cCd-0ijT
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 10:19:45 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 671EA5CC22;
	Thu, 21 Mar 2024 10:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711016380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qW8AkJgm+O3tvv+XHrSr8JvgavgYkGN+RTtxQeioiOU=;
	b=Qi6J63rB9haKT3mKYMoH+JHAtiGcCBlY/UO4114OtKRnNS8yMgs71umqMadwbGgGguAEQs
	WfqAgc61ZWVCGWlZ86axW33wbaPR8fBgqjS4BFSGoKJTJ2sRSUMtdSrPFMu3tdyD6CEUtP
	zRTUzqzgUa/El1fKoDp6Sf1q5KoC42U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711016380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qW8AkJgm+O3tvv+XHrSr8JvgavgYkGN+RTtxQeioiOU=;
	b=ewOOqEAaN2IOqovqz8oyjjCN1Vo+UbI1Na8dLqRN3FlqSLGrzuxI2IsIdeFAtCPJY7jbMY
	ZphYcR40EkpSdABA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711016380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qW8AkJgm+O3tvv+XHrSr8JvgavgYkGN+RTtxQeioiOU=;
	b=Qi6J63rB9haKT3mKYMoH+JHAtiGcCBlY/UO4114OtKRnNS8yMgs71umqMadwbGgGguAEQs
	WfqAgc61ZWVCGWlZ86axW33wbaPR8fBgqjS4BFSGoKJTJ2sRSUMtdSrPFMu3tdyD6CEUtP
	zRTUzqzgUa/El1fKoDp6Sf1q5KoC42U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711016380;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qW8AkJgm+O3tvv+XHrSr8JvgavgYkGN+RTtxQeioiOU=;
	b=ewOOqEAaN2IOqovqz8oyjjCN1Vo+UbI1Na8dLqRN3FlqSLGrzuxI2IsIdeFAtCPJY7jbMY
	ZphYcR40EkpSdABA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5587213976;
	Thu, 21 Mar 2024 10:19:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id I1psE7wJ/GVrGwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 10:19:40 +0000
Date: Thu, 21 Mar 2024 11:19:39 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 17/18] nvme: don't assume namespace id
Message-ID: <vscyepzp6kgg4en2ynq4zewlybca6zohtbgp23bfzuno3gcof7@4ono2tozgq5p>
References: <20240321094727.6503-1-dwagner@suse.de>
 <20240321094727.6503-18-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321094727.6503-18-dwagner@suse.de>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.01 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 RCPT_COUNT_FIVE(0.00)[5];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Qi6J63rB;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ewOOqEAa
X-Rspamd-Queue-Id: 671EA5CC22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_031942_407246_AAA4B137 
X-CRM114-Status: GOOD (  12.91  )
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

On Thu, Mar 21, 2024 at 10:47:26AM +0100, Daniel Wagner wrote:
 --- a/tests/nvme/029
> +++ b/tests/nvme/029
> @@ -53,16 +53,12 @@ test() {
>  
>  	_setup_nvmet
>  
> -	local nvmedev
>  	local reset_nr_hugepages=false
>  
>  	_nvmet_target_setup
>  
>  	_nvme_connect_subsys
>  
> -	nvmedev=$(_find_nvme_dev "${def_subsysnqn}")
> -	_check_uuid "${nvmedev}"
> -
>  	# nvme-cli may fail to allocate linear memory for rather large IO buffers.
>  	# Increase nr_hugepages to allow nvme-cli to try the linear memory allocation
>  	# from HugeTLB pool.
> @@ -72,7 +68,7 @@ test() {
>  		reset_nr_hugepages=true
>  	fi
>  
> -	local dev="/dev/${nvmedev}n1"
> +	local dev="/dev/$(_find_nvme_ns "${def_subsys_uuid}")"

make check complains here, the declaration and assignment should be a
separate step. I've fixed this up

> +_find_nvme_ns() {
> +	local subsys_uuid=$1
> +	local uuid
> +	local ns
> +
> +	for ns in "/sys/block/nvme"* ; do
> +		# ignore nvme channel block devices
> +		if ! [[ "${ns}" =~ nvme[0-9]+n[0-9]+ ]]; then
> +			continue
> +		fi
> +		[ -e "${ns}/uuid" ] || continue
> +		uuid=$(cat "${ns}/uuid")
> +		if [[ "${subsys_uuid}" == "${uuid}" ]]; then
> +			echo "$(basename ${ns})"

The echo is not necessary, I've dropped it.

