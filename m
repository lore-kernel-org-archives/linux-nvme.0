Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D58AD2F7EB
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Dec 2025 12:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qAGys8tOc/BASIq5655RvmSW8s+ShyLz+bpPeZslseg=; b=PH5sF0NfpQtG5ucA/oTufwYl4z
	aCkz25IOfR8jG9lhxvGzejtHn1k/Z3DNNnQV5OjPmP8+ZQ8IXSHeb0angfBl6ARNQJchvLf5sfyks
	N3+fNZlGX4GhIaw9pEWlGm3EI7d6wID9Cc0PeiRlBf9EoR01BujLsUEnQQq15StMSX9t2/GWA9HGc
	yennkatKTnpytnLxJWYRd5mYlWVIZVQ0FkBAIbhuXmGwkYmtjUP2vKQx6UGb5jD1EZk1bWie9RH5K
	5turWsbzIqpRcNlqU5LuBgmwAsdU0Ws6gvdgDmaALArBtEN0WmM/WSaRZ33QHOwWF4ZUkQn2H5KGh
	Z54AWF0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRUxu-00000009TK4-3oKk;
	Fri, 05 Dec 2025 12:31:14 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vRUxs-00000009TJb-3GQr
	for linux-nvme@lists.infradead.org;
	Fri, 05 Dec 2025 12:31:14 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 61FCB5BD3E;
	Fri,  5 Dec 2025 12:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764937869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAGys8tOc/BASIq5655RvmSW8s+ShyLz+bpPeZslseg=;
	b=thydEEWUigkrJKB1PUD0GuneCz7zy/IrwrtzykR8474zcmMPjp4irP4I5Y1eeqT1y2c0Rp
	1NX/09p2YfMiNuvELY9OF5Rg1i8r2sm373ryTaIA2eokgZaTzayZhEJA3syMVvytdm65Rx
	DwE7Neh+10hiu4g/95dQJQo75oqZJjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764937869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAGys8tOc/BASIq5655RvmSW8s+ShyLz+bpPeZslseg=;
	b=9ymVOlZy3gyd3G/AJTZlTHiIrxN91qrv95DC3SVeV4Q2BIcRLYcnw39a3Zqk9ALkIJ/Iex
	Nt+/ODDqMse2+xCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=thydEEWU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=9ymVOlZy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1764937869; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAGys8tOc/BASIq5655RvmSW8s+ShyLz+bpPeZslseg=;
	b=thydEEWUigkrJKB1PUD0GuneCz7zy/IrwrtzykR8474zcmMPjp4irP4I5Y1eeqT1y2c0Rp
	1NX/09p2YfMiNuvELY9OF5Rg1i8r2sm373ryTaIA2eokgZaTzayZhEJA3syMVvytdm65Rx
	DwE7Neh+10hiu4g/95dQJQo75oqZJjw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1764937869;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qAGys8tOc/BASIq5655RvmSW8s+ShyLz+bpPeZslseg=;
	b=9ymVOlZy3gyd3G/AJTZlTHiIrxN91qrv95DC3SVeV4Q2BIcRLYcnw39a3Zqk9ALkIJ/Iex
	Nt+/ODDqMse2+xCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52FAB3EA63;
	Fri,  5 Dec 2025 12:31:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VPRGE43QMmmeGQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 05 Dec 2025 12:31:09 +0000
Date: Fri, 5 Dec 2025 13:31:08 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Justin Tee <justintee8345@gmail.com>
Cc: linux-nvme@lists.infradead.org, Aristeu Rozanski <aris@redhat.com>, 
	Daniel Wagner <wagi@kernel.org>, "Ewan D . Milne" <emilne@redhat.com>
Subject: Re: [PATCH 1/1] nvmet-fcloop: Check remoteport port_state before
 calling done callback
Message-ID: <126c67dd-8892-48fc-a2e2-f6d449f7654b@flourine.local>
References: <20251204202613.14908-1-justintee8345@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204202613.14908-1-justintee8345@gmail.com>
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,flourine.local:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 61FCB5BD3E
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251205_043112_987283_CBF99388 
X-CRM114-Status: GOOD (  12.01  )
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

On Thu, Dec 04, 2025 at 12:26:13PM -0800, Justin Tee wrote:
> -		 * Return success because this is what LLDDs do; silently
> -		 * drop the response.
> +		 * Return success when remoteport is still online because this
> +		 * is what LLDDs do and silently drop the response.  Otherwise,
> +		 * return with error to signal upper layer to perform the lsrsp
> +		 * resource cleanup.
>  		 */
> -		lsrsp->done(lsrsp);
> +		if (remoteport->port_state == FC_OBJSTATE_ONLINE)
> +			lsrsp->done(lsrsp);
> +		else
> +			ret = -ENODEV;

Is this what the hardware/driver would do as well? Originally, when
adding this code it return always an error and James told me that this
is not how the hardware/driver work. Though this was without checking
the port_state.

That said, I am fine doing this though, as it clearly fixes a problem.
Just wondering how far we can deviate from the 'real' thing.

In other words:

Reviewed-by: Daniel Wagner <dwagner@suse.de>


