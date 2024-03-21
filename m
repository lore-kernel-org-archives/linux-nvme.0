Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B5AC54E58
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Mar 2024 09:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tx5MSBSCndiNheSglKAt+FKNItRhWRlBds9sQkreFqs=; b=uKqNKncGaY8NHJgLwPEzagtYy/
	6Qxu521hglr6chQi9rHISRntu7OX+2Rx3AeUQTkrbc+Remg6+BomWR5+HUU/Zyd5MVwWLZivoz/Mb
	o44oJ4OZ3GT+QuK2/1Ro/odDDg5OI3//nyV0aO6UtLPEAlxPoDoYx1ONpUepEsBtUR4sQk9+tuV/T
	E39EWEf3hNQEPRsTaEQIePwiMMnv7Ys4wRhM8U6MuSGQ0RRLJfOcK8vJ8ifnnE6mduZkczdBs4E70
	6/+zFgRfnlQvfS9vJ8Z1iBGPv4X4wOKjcNW1F0FycpOsu6iD43rB/85u5WTwIdikN8LptBXGHU0bf
	oKVZ2W1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnFBS-00000002ZBD-2YJl;
	Thu, 21 Mar 2024 09:58:02 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnFBP-00000002Z9x-1OlV
	for linux-nvme@lists.infradead.org;
	Thu, 21 Mar 2024 09:58:02 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4CE415CBE2;
	Thu, 21 Mar 2024 09:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711015077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tx5MSBSCndiNheSglKAt+FKNItRhWRlBds9sQkreFqs=;
	b=Au7yFlj6X2n+OfsH4QiXbS14DXvR0z2//Co4GF77oPuzqATELDaFNhvh2i/dqBP7UUzxJm
	Qb/LSkEdvtTvwBnP7866pTMkIlNRDu1mI7nqZvv27gfBRVo69lR7wdKOvIlmHwGcEE3vk9
	7z0rgAybrW/xOSFhyfKOJhFXo2jYl7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711015077;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tx5MSBSCndiNheSglKAt+FKNItRhWRlBds9sQkreFqs=;
	b=En4CiItGik1PzdoFvepvKRS/cIS1areDieP4orovD7qkso9B1ge/TlJ2Svj1F8+judi3mc
	zfNtvTwSM2j9mkAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711015075; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tx5MSBSCndiNheSglKAt+FKNItRhWRlBds9sQkreFqs=;
	b=WEIOh6kbCulTh4Hrwqu3v+50c2dPz9dAUkXT5ms2/h/87FyFz1T8aZ49Y396wR09NIZ7qK
	mx8M2zM1uisYyHDSUr3wDEbaNHSfueCTFTrjB4PEykFMoh1X03VX+iz4e7HETkwCl8s9nm
	X2ZHt/VK5SUV5igwtU7ai2G5t551xTs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711015075;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tx5MSBSCndiNheSglKAt+FKNItRhWRlBds9sQkreFqs=;
	b=b9xdAsynyOPBRFdffHExQ11SHpTy+9Eyz3nnef8ktbhHZmteUPCCAFzKwXXUniZIHY4+hq
	iIlV86Sv+GdvHWBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3867413976;
	Thu, 21 Mar 2024 09:57:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XLJVDKME/GWDEwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 21 Mar 2024 09:57:55 +0000
Date: Thu, 21 Mar 2024 10:57:54 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	Chaitanya Kulkarni <chaitanyak@nvidia.com>, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 02/18] nvme/rc: silence fcloop cleanup
 failures
Message-ID: <ltt4ymu4sioby5tzlhg25lbspevul3p4vp6jj37tjawjuc5bw6@pmxzeozgzn2e>
References: <20240321094727.6503-1-dwagner@suse.de>
 <20240321094727.6503-3-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321094727.6503-3-dwagner@suse.de>
X-Spamd-Result: default: False [-0.81 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[5];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.01)[48.37%]
Authentication-Results: smtp-out2.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240321_025759_552495_DCF7CD5A 
X-CRM114-Status: GOOD (  16.19  )
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

On Thu, Mar 21, 2024 at 10:47:11AM +0100, Daniel Wagner wrote:
> When the ctl file is missing we are logging
> 
>   tests/nvme/rc: line 265: /sys/class/fcloop/ctl/del_target_port: No such file or directory
>   tests/nvme/rc: line 257: /sys/class/fcloop/ctl/del_local_port: No such file or directory
>   tests/nvme/rc: line 249: /sys/class/fcloop/ctl/del_remote_port: No such file or directory
> 
> because the first redirect operator fails. Thus first check if the ctl
> file exists.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>  tests/nvme/rc | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 78d84af72e73..53fa54e64cb2 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -234,7 +234,10 @@ _nvme_fcloop_del_rport() {
>  	local remote_wwpn="$4"
>  	local loopctl=/sys/class/fcloop/ctl
>  
> -	echo "wwnn=${remote_wwnn},wwpn=${remote_wwpn}" > ${loopctl}/del_remote_port 2> /dev/null
> +	if [[ ! -f "${loopctrl}" ]]; then

This should be ${loopctl}, obviously. Same for the other changes.

