Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDD12C3600C
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 17:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zis9DGFcEqTcLL7uZhGpsAx8pYGVa2kgd0kFcUXCiug=; b=ZZRQIQHiY6iGdLzOHviV/v2U99
	hG8RGMkzX1865KCEVrXxkujarLAqx0IW1zAGQ9ZQwGupuD5vUQ335u2YBPRfzvpSM11AQfKsMa42z
	w7lwyLJwjl1lS6EWzcnW5FjZFJpODtOFvbyGV7Gfl2aGKnMcskGrH9HtjhND2iA+vUkZI+tCeJqnt
	yoX/0XdRNhTNYi9OjWTWwxQNM7BnS2zGUrFYoVN89KmdSnNjM2aAfQusE+M/u6n9O+AJNpB6AkBnX
	1RlusA8s7RZxkougsyUqi4XOKKZkq3gYemtJJruz475rp5xYWSe1yVJLk1Ar6hNJu/5wStLpIpXbU
	GH0FnFxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0OX1-00000009Tkk-3ao4;
	Thu, 03 Apr 2025 17:39:11 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0OWi-00000009Tio-0nm0
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 17:38:53 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9DEC6211C6;
	Thu,  3 Apr 2025 17:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743701930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zis9DGFcEqTcLL7uZhGpsAx8pYGVa2kgd0kFcUXCiug=;
	b=IPlVhX1v8/q24wXGAIC8rBn6usFhN8dGROHasIjudpUFoFjvqeUNvliydRyCXewTUXExxt
	eAXhKgtcWsB596Isvt4iCxTBOn9KnTmk280t3vxrxsJB+eLHePyfk54KzSEYyR1ZNorDtj
	ZM/R57/Mg44EZV2bBEGbF1RXToNJDZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743701930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zis9DGFcEqTcLL7uZhGpsAx8pYGVa2kgd0kFcUXCiug=;
	b=zz0vapogjnd+9OvvsvzZInNf5lZ+ALfx0qKDrn6FLVwXD3/gOxaZcz2OXVcLvGbhdwnMaz
	hXYLVpqQe08jtTDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=IPlVhX1v;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zz0vapog
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743701930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zis9DGFcEqTcLL7uZhGpsAx8pYGVa2kgd0kFcUXCiug=;
	b=IPlVhX1v8/q24wXGAIC8rBn6usFhN8dGROHasIjudpUFoFjvqeUNvliydRyCXewTUXExxt
	eAXhKgtcWsB596Isvt4iCxTBOn9KnTmk280t3vxrxsJB+eLHePyfk54KzSEYyR1ZNorDtj
	ZM/R57/Mg44EZV2bBEGbF1RXToNJDZw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743701930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zis9DGFcEqTcLL7uZhGpsAx8pYGVa2kgd0kFcUXCiug=;
	b=zz0vapogjnd+9OvvsvzZInNf5lZ+ALfx0qKDrn6FLVwXD3/gOxaZcz2OXVcLvGbhdwnMaz
	hXYLVpqQe08jtTDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7482313A2C;
	Thu,  3 Apr 2025 17:38:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TBGgGqrH7mf8EQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 03 Apr 2025 17:38:50 +0000
Date: Thu, 3 Apr 2025 19:38:49 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, wagi@kernel.org, 
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH] libnvme: do not byte swap command dwords
Message-ID: <01debb8e-dd4a-4355-8f8a-7926e5876280@flourine.local>
References: <20250403144315.2576523-1-kbusch@meta.com>
 <315bb015-66e3-49cd-be3d-a93b97846617@flourine.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <315bb015-66e3-49cd-be3d-a93b97846617@flourine.local>
X-Rspamd-Queue-Id: 9DEC6211C6
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-2.99)[99.97%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_103852_385678_2A317A52 
X-CRM114-Status: UNSURE (   7.78  )
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

On Thu, Apr 03, 2025 at 07:25:13PM +0200, Daniel Wagner wrote:
> in this case shouldn't we use cpu_to_le32?

Nevermind, just saw your explanation on github. the driver takes care of it...

