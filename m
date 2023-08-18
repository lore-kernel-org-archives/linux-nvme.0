Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6EBC678DC
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Aug 2023 12:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bZUqLx6aDKEOVtIoUrNHKk3Ucu59bgR9yuEuVpBRaHM=; b=FBxm4cVzsFxPh08bK4LVeHxwd6
	BCgYlvuP5doguqKMoTjUKn3gEMc/k6ZMbMfQjn7mZbE/vts4RMWf65n92s+wHdkrf3HIOdQ1wo94H
	a8Vdz8IdCBiDP6r6G0Ak2IzszPim2oaaa/va0fwQPyBhZ0ic9L5/RjcOZJhgBGUzin2fijewWRDMV
	0Uwa8jgw7Voa6+pmmS9OpIvoNgGygM8sSPTLVvP5jOS4wkUvgCY+clNLvXUFJ8FvtVp/5H1Kl1rj0
	tcnCq6Z8CPLTY+0jBoKIExUOHkJUo+bfNZiV2+gv6DfEuEve+8Gl9xgdlIqMZIP5xpX3JjBiUqteP
	mTEDDsyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qWyIf-0094Rw-0i;
	Fri, 18 Aug 2023 12:09:57 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qWyIc-0094Oj-2m
	for linux-nvme@lists.infradead.org;
	Fri, 18 Aug 2023 12:09:56 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1D4F21F74B;
	Fri, 18 Aug 2023 12:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692360591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bZUqLx6aDKEOVtIoUrNHKk3Ucu59bgR9yuEuVpBRaHM=;
	b=FRQ34vhe/T3rBnmLl5YkJXm5zo1E/juH9fGlDnr+vAMyw3pVkX7jazylobbCzLFWNa4BBD
	O5b34nS54MkVkEYGhVK3tgM6eusS55Dqffvov4d6F84gyqDYsmr51jcS9S+O5KfmPWBIYd
	sSsNAgNWnbv2p0pGPBj0zuTKTUAvZAc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692360591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bZUqLx6aDKEOVtIoUrNHKk3Ucu59bgR9yuEuVpBRaHM=;
	b=+90ZxIb/gl/Xzp4wXd+OtPrussY4k1hefjrplLseKn9s/uf1kp6F2hrCnuFba/udCwlgfQ
	WMFT9q7W1fbdkbBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F5AF13441;
	Fri, 18 Aug 2023 12:09:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id dzO1A49f32SbegAAMHmgww
	(envelope-from <dwagner@suse.de>); Fri, 18 Aug 2023 12:09:51 +0000
Date: Fri, 18 Aug 2023 14:10:02 +0200
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
	Chaitanya Kulkarni <kch@nvidia.com>, Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH blktests v1 1/1] nvme: Introduce
 nvmet_target_{setup/cleanup} common code
Message-ID: <2jv5fxbuyd6zqwmgkqydrmgpiozxgebsbq3qzd46uf7xtyo3iv@wmp2ejair6l4>
References: <20230818095744.24619-1-dwagner@suse.de>
 <20230818095744.24619-2-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818095744.24619-2-dwagner@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230818_050955_061754_68CECFEA 
X-CRM114-Status: UNSURE (   9.48  )
X-CRM114-Notice: Please train this message.
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

> +_nvmet_target_cleanup() {
> +	local ports
> +	local port
> +	local blkdev
> +
> +	_get_nvmet_ports "${def_subsysnqn}" ports
> +
> +	for port in "${ports[@]}"; do
> +		_remove_nvmet_subsystem_from_port "${port}" "${def_subsysnqn}"
> +	done
> +	_remove_nvmet_subsystem "${def_subsysnqn}"
> +	_remove_nvmet_port "${port}"

_remove_nvmet_port should be also be part of the loop.

> +	_remove_nvmet_host "${def_hostnqn}"
> +
> +	blkdev="$(losetup -l | awk '$6 == "'"${def_file_path}"'" { print $1 }')"
> +	if [[ -n "${blkdev}" ]] ; then
> +		losetup -d "${blkdev}"
> +	fi
> +	rm "${def_file_path}"
> +}
> +

