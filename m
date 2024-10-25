Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42348D0C614
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 14:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dztrD2BuMBwGiXHKocxJWe1XfpV/O8ubhvzYFxdGIbI=; b=pUe53hR3U+txXEkXPYkPpQHvpe
	8+lE+VV/Aeo4nltLd30SUGjdWGgtRciAmkvXEOb2YDX4mptss7dOWje5gr1QdyGcGFyd2+T1nMU1i
	rQvv+zQh/1z+rN4TV9TiAa9zzGOmyNOKNcHH2VX4u5LSUDk2sSroDCG+w0YbQ/3yClQjgT5qgsQJR
	62J8kgKD2TxX73Ry9i1XKoHThvffsxb8eOZqzR35B8L8KO1tLUOwkfuj3f/kGsJNCttb1NDnO6fnR
	TJMVXF3Ho/fWkA5/XjbG5kwshHomhaHCO8o3yVkmYBg5SxLt9tv3WDQ390BCb5nbjTYJzGn8qUgSD
	sDHtwNHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4L2P-00000003wxv-0eUR;
	Fri, 25 Oct 2024 14:11:37 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Ktb-00000003v9d-3ADI
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 14:02:35 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 712BB21E23;
	Fri, 25 Oct 2024 14:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729864948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dztrD2BuMBwGiXHKocxJWe1XfpV/O8ubhvzYFxdGIbI=;
	b=ho1u1ThvJ5WHX2dW//JzNOxn25EiDdMD3iqAFYd86Q41RmANWzsxrQc9fNjSxdOoYKU1ub
	3AiRrKKkVQlnvBT90fB2YRW5uOPSMGReQ7tCOOnnAaYy7l0/NI43dbCzSIJk+EW8OQKZh0
	u1Vuj3TSRyhahqHcwowWp2syLVZydto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729864948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dztrD2BuMBwGiXHKocxJWe1XfpV/O8ubhvzYFxdGIbI=;
	b=8Rt0puBX2H0KozyFGrPInJaYO2C7I3hXVcVP0vASvD3W3NRkdUHDhTzemldCAlG+PsO4m3
	MukXRGbJIvZs7IDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ho1u1Thv;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8Rt0puBX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729864948; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dztrD2BuMBwGiXHKocxJWe1XfpV/O8ubhvzYFxdGIbI=;
	b=ho1u1ThvJ5WHX2dW//JzNOxn25EiDdMD3iqAFYd86Q41RmANWzsxrQc9fNjSxdOoYKU1ub
	3AiRrKKkVQlnvBT90fB2YRW5uOPSMGReQ7tCOOnnAaYy7l0/NI43dbCzSIJk+EW8OQKZh0
	u1Vuj3TSRyhahqHcwowWp2syLVZydto=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729864948;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dztrD2BuMBwGiXHKocxJWe1XfpV/O8ubhvzYFxdGIbI=;
	b=8Rt0puBX2H0KozyFGrPInJaYO2C7I3hXVcVP0vASvD3W3NRkdUHDhTzemldCAlG+PsO4m3
	MukXRGbJIvZs7IDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57A3D132D3;
	Fri, 25 Oct 2024 14:02:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id amT9EvSkG2cqUwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Oct 2024 14:02:28 +0000
Date: Fri, 25 Oct 2024 16:02:27 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 00/15] nvme: prepare for ANA support
Message-ID: <2e4efaf9-d6cc-46b2-8783-d400f6e49829@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
X-Rspamd-Queue-Id: 712BB21E23
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_070231_966520_5FD9C1BE 
X-CRM114-Status: GOOD (  16.47  )
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

On Thu, Oct 24, 2024 at 10:00:10AM GMT, Shin'ichiro Kawasaki wrote:
> The 3rd patch caused the failure of the test case nvme/037 with fc transport.
> I'm not sure if it unveils a kernel bug, or if it should be fixed in blktests.
> I found the following change for the test case avoids the failure, which
> adds short waits after nvme disconnect and target cleanup. Comments on this
> change by nvme-fc experts will be appreciated.
> 
> diff --git a/tests/nvme/037 b/tests/nvme/037
> index 33a6857..e00f632 100755
> --- a/tests/nvme/037
> +++ b/tests/nvme/037
> @@ -36,7 +36,13 @@ test_device() {
> 
>                 _nvme_disconnect_subsys \
>                         --subsysnqn "${subsys}${i}" >>"${FULL}" 2>&1
> +               if [[ ${nvme_trtype} == fc ]]; then
> +                       sleep .1
> +               fi
>                 _nvmet_passthru_target_cleanup --subsysnqn "${subsys}${i}"
> +               if [[ ${nvme_trtype} == fc ]]; then
> +                       sleep .1
> +               fi

I think this is a workaround for a kernel bug which not really
surprising. I'll have a look.

