Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47772D0C61D
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Oct 2024 14:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/D2GsFgz0TkqsDU7uFpbMB/wnPEzuLLkfZ55LUWxXF0=; b=obHE7bP+pb3P+n0PvqGzbaJpZ0
	UJSxGi5GfJL6OkHeN9A2qtCukoDNLW5b3QH3/1gKlbAaR5mkPadLfmcgcwm+k+pkoCzR6lcvy9JVY
	bpNmoF8hSj+4XRe3Pw6od4nUvJydq/ex28GHmg68LrMKlfXjbApX+NckLHNNjDcHg47nfQHjSfd8K
	Iaa8cViBDzhJaIMp612bX1ER+ASnu7bbdskyyHF7EviWbw0B26coObYMONJQFcftr1rSsd7YnNt5t
	WD0eYYdR3SM5sbRlLnm1jg1Pfr+hhJRnbgTnPPQEaEya33rDWxet/53Ct/4hEEWCNmNzT1CFOl9kn
	C/aPXmFA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4Lah-000000044kB-3HlH;
	Fri, 25 Oct 2024 14:47:03 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4LXm-000000043qh-2fAj
	for linux-nvme@lists.infradead.org;
	Fri, 25 Oct 2024 14:44:06 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 281EA21D23;
	Fri, 25 Oct 2024 14:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729867441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/D2GsFgz0TkqsDU7uFpbMB/wnPEzuLLkfZ55LUWxXF0=;
	b=IQch38OmIhOcDazmv5nAENlZAlitFoj5xcq0INtFWZR9Fgux8lW/QbBWl3ac+q91InvP1Q
	jljHCTF4js302IFu4UXCrTBo6XF0lACV9rX6iR4q3AqTJgLWsAJhE+wdSL9XRSYlYacO6q
	huGZ6v4V0oo1OnAjl0ZlT2CAei9Xu7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729867441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/D2GsFgz0TkqsDU7uFpbMB/wnPEzuLLkfZ55LUWxXF0=;
	b=WW9Z6bcMgIFxg3glZ+9wOa07jsnSxd4It5LIlwn9D4C1ksbaxqyKiZG1LtosFhHlTMAC36
	nw+caomm99AbitBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1729867441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/D2GsFgz0TkqsDU7uFpbMB/wnPEzuLLkfZ55LUWxXF0=;
	b=IQch38OmIhOcDazmv5nAENlZAlitFoj5xcq0INtFWZR9Fgux8lW/QbBWl3ac+q91InvP1Q
	jljHCTF4js302IFu4UXCrTBo6XF0lACV9rX6iR4q3AqTJgLWsAJhE+wdSL9XRSYlYacO6q
	huGZ6v4V0oo1OnAjl0ZlT2CAei9Xu7M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1729867441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/D2GsFgz0TkqsDU7uFpbMB/wnPEzuLLkfZ55LUWxXF0=;
	b=WW9Z6bcMgIFxg3glZ+9wOa07jsnSxd4It5LIlwn9D4C1ksbaxqyKiZG1LtosFhHlTMAC36
	nw+caomm99AbitBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04E53136F5;
	Fri, 25 Oct 2024 14:44:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SYBkOrCuG2frYAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 25 Oct 2024 14:44:00 +0000
Date: Fri, 25 Oct 2024 16:44:00 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests 04/15] nvme: introduce wwnn/wwpn helper functions
Message-ID: <51d4d585-3276-4621-9df1-e5b4342bc874@flourine.local>
References: <20241024010025.2216242-1-shinichiro.kawasaki@wdc.com>
 <20241024010025.2216242-5-shinichiro.kawasaki@wdc.com>
 <f151f9dc-730d-4e69-ae3f-8884a1bf4de5@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f151f9dc-730d-4e69-ae3f-8884a1bf4de5@flourine.local>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[flourine.local:mid,imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_074402_844469_6273E099 
X-CRM114-Status: UNSURE (   9.07  )
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

On Fri, Oct 25, 2024 at 04:22:14PM GMT, Daniel Wagner wrote
> > +			echo only one port is supported at this moment...
> 
> Maybe prefix the error message with 'FAIL', so that it pops up in the
> logs a bit more.

Ah I see later this gets address later in the series. So forget my comment.

