Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3036EC43458
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2026 13:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=42HisIemLDAaB9PYi5wHE+U+F0xLaap+aR1Ygx2vBD4=; b=RsFMkfeT2BLgBUmZxzMelaAXcr
	L310CzQO53o3Fb13lfceg3AEr3GE9DHm13hTnuLzAE4ZFmMTrRLSKQlcwV8x6B3p5CnlcooKj/6X+
	QPOBFeYwsKPzpgNMKyGRmeYL8LGOwtNok0gruCjyPO6ghZoGD2YzpMK6tqtsVuaOYj3hUj304Zp9G
	SLQn8rH6zujt/P3vXOLuxDpdHB0nOWo1EJB15c5BTnhMrD3Pm3PXt2Ser8b0Edg4JqbuFQzYkzWtl
	ZkWscz37pJ+4xlenT2nHqfJ7LAduhhDVYTEfrU9EF9kxEzPOA7wRM2pjzdK3iMJ0skUBRGblz0N11
	sCeN02AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weuZG-000000026dp-1cyK;
	Wed, 01 Jul 2026 13:01:30 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weuZD-000000026dK-1z3a
	for linux-nvme@lists.infradead.org;
	Wed, 01 Jul 2026 13:01:29 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BEF0973AA2;
	Wed,  1 Jul 2026 13:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782910884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42HisIemLDAaB9PYi5wHE+U+F0xLaap+aR1Ygx2vBD4=;
	b=MabHrzxI4UOGG2wN0xU86BWcMSKLo0i1PKFpIyOkF8WJYWejQezwq6xo+hY3imEGnlYvXP
	EqsTpDu6sgxbyiJ0acQlMBj2/tvXKiBeexfsH3c1YQ67N2MhMKtiCXIZowfdpg+ynZS0F/
	NOEkaO5NB4inAsMig0cjd1usoy8+cLc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782910884;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42HisIemLDAaB9PYi5wHE+U+F0xLaap+aR1Ygx2vBD4=;
	b=olEAGgakdEVsDqEHhDj6r0zFByuDDQgnZWoXlCxlkWOPM/2B1VVG6oNAURF+iK9FHC2kNP
	MOgkl78cyGlyGZBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yRrVbgZJ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DmgRg1Jo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782910879; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42HisIemLDAaB9PYi5wHE+U+F0xLaap+aR1Ygx2vBD4=;
	b=yRrVbgZJxjR+lLUlRxpj5nXWlsgSXy+ZEYA3XM9x/C3FruuGppCrluCi3AIzayTiyicI+z
	XhbSGgiiihkqLYb+XIACRMUH2Hgjt/JknyTL06jTqKaKPBH0jwGnQD6VwJ1OVcZNTArrzO
	rpeEODzmeOQHzBiCxeQiCfQiyeswu4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782910879;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=42HisIemLDAaB9PYi5wHE+U+F0xLaap+aR1Ygx2vBD4=;
	b=DmgRg1JogUNf8XOzpOBxyrsUgfTDZEuKN9M7IQaWh0Ymzz93UFrga7maI93fiqYsVt9Jf6
	0XPbdqjNctO+wsBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E099779AA;
	Wed,  1 Jul 2026 13:01:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pgDpJJ8PRWreawAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 01 Jul 2026 13:01:19 +0000
Date: Wed, 1 Jul 2026 15:01:10 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Tomas Hrnciar <thrnciar@redhat.com>
Cc: linux-nvme@lists.infradead.org, hch@infradead.org, 
	Ales Novak <alnovak@suse.com>
Subject: Re: [PATCH] Drop python2 support and the dependency on python-six
Message-ID: <8eabaa9f-9698-4e51-8147-c73c2b25a53d@flourine.local>
References: <CALkDUM9r6NjVuPM15==o04eAGjhw8AeXeQEtQifksU6gd95V3A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALkDUM9r6NjVuPM15==o04eAGjhw8AeXeQEtQifksU6gd95V3A@mail.gmail.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BEF0973AA2
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_060127_827491_04350561 
X-CRM114-Status: GOOD (  14.52  )
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

Hi Tomáš,

On Tue, Jun 23, 2026 at 02:24:28PM +0200, Tomas Hrnciar wrote:
> I'd like to propose a patch which removes support for Python 2 and
> drops the dependency on python-six. Python 2 has been EOL since
> January 2020 and we are trying to remove python-six from distribution.
> This patch drops the remaining six usage.

Christoph has ask me to maintain the nvmetcli project. With Ales help I
started to collect patches posted in the last few years. I've setup an
integration tree at github so we can use fancy tools:

  https://github.com/linux-nvme/nvmetcli

Still in the early setup phase but the initial CI worklows start to
work and with Ales help going through the issues found by the fancy
tools:

  https://github.com/linux-nvme/nvmetcli/pull/2

There is also a python-six removal path queued up. When the PR is good
shape I'll post it here once again before applying it to the upstream
repo.

Thanks,
Daniel

