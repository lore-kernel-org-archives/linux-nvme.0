Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A99DC27C4F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Jun 2024 07:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZHTUtwv87WM/dpIZOlIsd3oxDkljBINYJ+vL2DOSS5U=; b=Z5OTs9no1btqjA4urQoHpIBrxC
	iXFDXXWPkOHEsJyUdzOY+jBbrFkfkELGHF1bqK/CckbbxA5eQj/Wd5ss+oL0QNUsMctLWz4/tLlNn
	kpEqgm623FLQOgsJp6fnrCI53NOP2RcUiSMRrspEzGqxeKvRivowDDY5Oe9O2PX4P+T7luwhm6DnI
	PzizgBzanN0up/WTOH+X6YHl9yvQZbI6dcGhXZADlEOQCOjMkfSipchSqYtrOXFC6O3rUkzBH28vW
	uofW3cuMtK4ylJSMRY9ALKFAVplfWOPyXRbV4+9j/27Tuj4LWo/8eRLFt5CfennINaWTyZADRz9NS
	GdcGW+tQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMMq6-00000005gxi-1rWt;
	Wed, 26 Jun 2024 07:13:10 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMMpz-00000005gu1-0iBk
	for linux-nvme@lists.infradead.org;
	Wed, 26 Jun 2024 07:13:08 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F1E7B1FB3F;
	Wed, 26 Jun 2024 07:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719385981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHTUtwv87WM/dpIZOlIsd3oxDkljBINYJ+vL2DOSS5U=;
	b=Bq6AJcW5xaHZzoUzkWysdAUHENt6SrfkK5+oNacCYXAP+gf30Ep44DVFmiWkv+h/ANat5B
	nPlKArf6VP1f+/RVjQapLbcgtNQha5iAaJYInvi+SkmDQPeEe7MlRuWp5LexIs59oCbFoo
	VTslFMbPrVpLbSkT5qUCk6PnT60MQ2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719385981;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHTUtwv87WM/dpIZOlIsd3oxDkljBINYJ+vL2DOSS5U=;
	b=81orOkJQ4eP/8LF0j55YJbTzH1meDrv4a6w8DUjELEDsSKnn1QTGRoBkHxFkq9dN7ooAu8
	vBJheZMezbJQj6AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719385980; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHTUtwv87WM/dpIZOlIsd3oxDkljBINYJ+vL2DOSS5U=;
	b=1gobKQntsEG5yHhi4nV7NPmKkRqNWOT+liMnidRTklfWoAh5EvrE5ijIwWvaNFQu7MeGap
	cv6wnQR0lc86Lm4RhrC7OcJeZVagEtUHs9PSTG/ZynjxMP/0gQCXisuYfhWReZlhKJgHLE
	YYQ9AFu8FRiNi3OkjRmqWIbu+FFJyjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719385980;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZHTUtwv87WM/dpIZOlIsd3oxDkljBINYJ+vL2DOSS5U=;
	b=H7TE8OfsI2JobDI3QtB/UF8AtTveuTjPYK1JPVenwAItVBy4BLOTsOCqo2OafXpCINOnmZ
	VZ851wVObQ5N6dDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DFA1C13AAD;
	Wed, 26 Jun 2024 07:13:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mYpENny/e2ZHRAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 26 Jun 2024 07:13:00 +0000
Date: Wed, 26 Jun 2024 09:13:00 +0200
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v1 0/2]: nvme-fc: fix race with connectivity loss with
 nvme_fc_create_association
Message-ID: <oewocks6plwwkd2un2szha5l4hszbvua6xq5mpmrjvqkb6mstq@kkn4upvvw2fy>
References: <20240611190647.11856-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611190647.11856-1-dwagner@suse.de>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_001303_442928_06D7BFC9 
X-CRM114-Status: GOOD (  12.02  )
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

On Tue, Jun 11, 2024 at 09:06:45PM GMT, Daniel Wagner wrote:
> We got a bug report that a controller was stuck in the connected state after an
> association dropped. It turns out that nvme_fc_create_association can succeed
> even though some operation do fail. This is on purpose to handle other corner
> cases, thus we can't really make nvme_fc_create_assocication bullet proof.
> 
> Given this, I think the second best option is to ensure that we always schedule
> a reset whenever a connectivity loss is observed in CONNECTING state. This is
> not perfect (possible back to back reset) but at least it is correct, which wins
> in my books.

Any feedback?

