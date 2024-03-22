Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A92BC47DD9
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Mar 2024 12:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GjIVixRgcRcR3jkf6RRZnkfRE8Aou8UrqZcioUg/eN0=; b=uxt49Bx8JypaPz99FMiGukiJGL
	59CQ+JkSvXEZWwaVJQ9VHKDW6FJsB9ABX9X7lGfpKbRffYFnTCuXy+ifrF1hk+VZXFVESA4gLCse3
	TOzKI3qbM35uyjuX36K6zERohatVV/d+WHKUKkxIG+SP7qHeHIRf40Kew0RJfO7rQQ6rvQFJMbR+t
	uU0G0BesBWtTH7OPkVikcIj8+Y25RJnLt/rI2zkftGftIRszAAv8na1i6AQedgRCJC9IyOqkRf+Mx
	RRJXOWBKqFZqXwpSk75FRKo+zJ1kDErrrdleJBI2ummshlW2r9d2qTcjG9YNlqzxkHKubUZIW7Ddg
	g5p8Lwpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rne7q-000000079Ht-3buL;
	Fri, 22 Mar 2024 12:35:58 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rne7m-000000079Fg-1tvM
	for linux-nvme@lists.infradead.org;
	Fri, 22 Mar 2024 12:35:58 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0231D34E63;
	Fri, 22 Mar 2024 12:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711110953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjIVixRgcRcR3jkf6RRZnkfRE8Aou8UrqZcioUg/eN0=;
	b=rQRAmZJzY3fwxGjvDrquxX3GkrKzxE28pBuiuZGdVlAHyAZNPR8VNUUTgdZ1EgVQXDgfkT
	PjF33yR2ELNmJfUWWA8E6cSpQLOpj0LBaGiu4uU7hVzk6tsLgzfhrmsGrj3oEe+8LSN2ok
	2Q0hwEEpMywF5X374r31DUgGfcKgBtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711110953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjIVixRgcRcR3jkf6RRZnkfRE8Aou8UrqZcioUg/eN0=;
	b=o2T7Xp3rPVodkaOMTnOdIUlPIar6ENp/+0RenuEqykRkMKwjPo6uKsuIhg31JZoTiDVDqc
	QnSb+TK/sB5a8qDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711110953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjIVixRgcRcR3jkf6RRZnkfRE8Aou8UrqZcioUg/eN0=;
	b=rQRAmZJzY3fwxGjvDrquxX3GkrKzxE28pBuiuZGdVlAHyAZNPR8VNUUTgdZ1EgVQXDgfkT
	PjF33yR2ELNmJfUWWA8E6cSpQLOpj0LBaGiu4uU7hVzk6tsLgzfhrmsGrj3oEe+8LSN2ok
	2Q0hwEEpMywF5X374r31DUgGfcKgBtg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711110953;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GjIVixRgcRcR3jkf6RRZnkfRE8Aou8UrqZcioUg/eN0=;
	b=o2T7Xp3rPVodkaOMTnOdIUlPIar6ENp/+0RenuEqykRkMKwjPo6uKsuIhg31JZoTiDVDqc
	QnSb+TK/sB5a8qDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3D6013688;
	Fri, 22 Mar 2024 12:35:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UWI0Nih7/WVFAgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Fri, 22 Mar 2024 12:35:52 +0000
Date: Fri, 22 Mar 2024 13:35:52 +0100
From: Daniel Wagner <dwagner@suse.de>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests v1 00/18] refactoring and various cleanups/fixes
Message-ID: <xjfhvzsare7kki2rjjjrhzny6efmyqsvkxjhkscvgad4w6ozni@4646fc5b2bg7>
References: <20240321094727.6503-1-dwagner@suse.de>
 <25uxq4piju5fd5ya56wmlcsmihd6ddqbohv37xpkluqsvosorm@fvrrs53crtwj>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25uxq4piju5fd5ya56wmlcsmihd6ddqbohv37xpkluqsvosorm@fvrrs53crtwj>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.86 / 50.00];
	 ARC_NA(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
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
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.06)[61.50%]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240322_053554_672231_05D18F56 
X-CRM114-Status: GOOD (  13.93  )
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

On Fri, Mar 22, 2024 at 09:38:16AM +0000, Shinichiro Kawasaki wrote:
> On Mar 21, 2024 / 10:47, Daniel Wagner wrote:
> > While working on two new features I collected a bunch of patches which I think
> > make sense to review and merge them indepenedly. And I got a few more ideas for
> > refactoring and cleanups. But one step after the other.
> 
> Overall, the patches in this series look reasonable for me. Most of them are
> part of the RFC series for the real target support, so it's good to have this
> series for separate review.
> 
> I made some nit review comments on the patches. I will do trial runs after v2
> comes out. Thanks!

Thanks for reviewing. I'm updating the series according your feedback.
I avoid sending 'ok' to every point you made, because you are right
every single time :)

