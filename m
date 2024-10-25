Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A939BD0C61D
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 14:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OwUpY9Adn6wtDjEzhHlxK8iABgrO41iCr/kP9FxbDUM=; b=hPwaiC8Ane0Ta7y6262v8y2xDU
	ZnlrZveQE3IeZJ3Xp9dsfuFr37uGfhIOU5U8OtNeRhGWuJc/nHcIieflbvbpDVe+EncYpBe94nkZ6
	h4T2/L0L1rGb2XZHsxHuI8d64OYvapR7ZkV9N1U0AVID+Ft4jLjE2Gvwzck9JeHkRTG4VCzVHxEd5
	pKtdlP6YsWq52VAcfC8HgDqwh4CMA9cw+n7ll6BOR/emhR+qwDsitC1Vt3KGOmxmoOMQ1XfL1rRh7
	sRjt2+BnedU0iypIVWxJFFrxqsfN/6Mb3hJVZOTSVSpU56RVUIhWheJyJMmRPhpKAeUfm9jrPHfB0
	GIVzG7+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4LVg-000000043Mu-0GBD;
	Fri, 25 Oct 2024 14:41:52 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4LCh-00000003zrQ-1wst
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 14:22:18 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EECF521D2D;
	Fri, 25 Oct 2024 14:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729866134; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwUpY9Adn6wtDjEzhHlxK8iABgrO41iCr/kP9FxbDUM=;
	b=zwgf9+4Br2Ml+eIWBZCwC0WXV+h38ua557qbkediPxXbcLIL5DyS3mAkGyg5bjQZx2ETx6
	3ad3mOPvl3MaAOomEHdAUL4RIhrGZp9wlMgjG4fyaKbmD/mSOB8RqKGAjs7pubhpZp63Eh
	E3n7GSmM1Z8MsswuaA2xo6DDLTvlyDQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729866134;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwUpY9Adn6wtDjEzhHlxK8iABgrO41iCr/kP9FxbDUM=;
	b=AJV6OtusmaMyC9r6obEiQ/xqUYK4HdNjKr1HiqxksfvGAFWSy76zo+W2DPp+pt8dJxzwPz
	gDgeWwJVhT+F13BA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729866133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwUpY9Adn6wtDjEzhHlxK8iABgrO41iCr/kP9FxbDUM=;
	b=Q/ZDMRKRNwOpmta9madvMBeGG0hqGgOo2skxzX5E5VmJLAH2zqGBQBxdFSWAVJsxA/GkBi
	nhMCllV9PBEzGNjC+BUNVdpulr8qd/0qK6KxWQ6CmZ+Nu0QiU4HFc3/xgEQFzX0+Owu58I
	QVzaikctHrloNmHfLmXuKjuw6jhrAn0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729866133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OwUpY9Adn6wtDjEzhHlxK8iABgrO41iCr/kP9FxbDUM=;
	b=iaLERdlnaDLdPR9caFybobU/5N2Bna/MKQH0mV5foABjhHoHNSvNDpTgtl5L4djJQAv0o5
	MbPdPkQqLg6oucAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CAC00132D3;
	Fri, 25 Oct 2024 14:22:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4qIPL5WpG2ewWQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Oct 2024 14:22:13 +0000
Date: Fri, 25 Oct 2024 16:22:13 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 04/15] nvme: introduce wwnn/wwpn helper functions
Message-ID: <f151f9dc-730d-4e69-ae3f-8884a1bf4de5@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-5-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241024010025.2216242-5-shinichiro.kawasaki@wdc.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_072215_675450_541CE937 
X-CRM114-Status: GOOD (  16.41  )
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

On Thu, Oct 24, 2024 at 10:00:14AM GMT, Shin'ichiro Kawasaki wrote:
> Commit "nvme: sanitize transport parameter in _create_nvmet_port()"
> modified the wwnn and wwpn names for fc transport to calculate from the
> port ID. It also moved the timing to set the global variable
> def_host_traddr based on the wwnn and wwpn from _setup_nvmet() to
> _create_nvmet_port(). This move made _nvme_connect_subsys() fail
> to refer to the def_host_traddr variable, and caused nvme/003 test case
> failure.
> 
> To avoid the failure, do the wwnn and wwpn calculations both in
> _create_nvmet_port() and _nvme_connect_subsys(). Introduce helper
> functions to calculate wwnn and wwpn.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  common/nvme | 63 +++++++++++++++++++++++++++++++++++++----------------
>  1 file changed, 44 insertions(+), 19 deletions(-)
> 
> diff --git a/common/nvme b/common/nvme
> index 46dfb51..3e388c2 100644
> --- a/common/nvme
> +++ b/common/nvme
> @@ -331,7 +331,15 @@ _nvme_connect_subsys() {
>  
>  	ARGS=(--transport "${nvme_trtype}" --nqn "${subsysnqn}")
>  	if [[ "${nvme_trtype}" == "fc" ]] ; then
> -		ARGS+=(--traddr "${def_traddr}" --host-traddr "${def_host_traddr}")
> +		local ports
> +		_get_nvmet_ports "${subsysnqn}" ports
> +		if ((${#ports[@]} != 1)); then
> +			echo only one port is supported at this moment...

Maybe prefix the error message with 'FAIL', so that it pops up in the
logs a bit more.

Rest looks good.

Reviewed-by: Daniel Wagner <dwagner@suse.de>

